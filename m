Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNjvy1BRjzDw1q
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 11:32:14 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm-ppc@vger.kernel.org,
	kvm@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v2 10/11] KVM: PPC: Book3S HV: Treat POWER9 CPU threads as
 independent subcores
Date: Wed, 23 Nov 2016 11:32:04 +1100
Message-Id: <1479861125-21394-11-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
References: <1479861125-21394-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With POWER9, each CPU thread has its own MMU context and can be
in the host or a guest independently of the other threads; there is
still however a restriction that all threads must use the same type
of address translation, either radix tree or hashed page table (HPT).

Since we only support HPT guests on a HPT host at this point, we
can treat the threads as being independent, and avoid all of the
work of coordinating the CPU threads.  To make this simpler, we
introduce a new threads_per_vcore() function that returns 1 on
POWER9 and threads_per_subcore on POWER7/8, and use that instead
of threads_per_subcore or threads_per_core in various places.

This also changes the value of the KVM_CAP_PPC_SMT capability on
POWER9 systems from 4 to 1, so that userspace will not try to
create VMs with multiple vcpus per vcore.  (If userspace did create
a VM that thought it was in an SMT mode, the VM might try to use
the msgsndp instruction, which will not work as expected.  In
future it may be possible to trap and emulate msgsndp in order to
allow VMs to think they are in an SMT mode, if only for the purpose
of allowing migration from POWER8 systems.)

With all this, we can now run guests on POWER9 as long as the host
is running with HPT translation.  Since userspace currently has no
way to request radix tree translation for the guest, the guest has
no choice but to use HPT translation.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/kvm/book3s_hv.c | 49 +++++++++++++++++++++++++++++++++-----------
 arch/powerpc/kvm/powerpc.c   | 11 ++++++----
 2 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index b6bc867..94294c3 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1576,6 +1576,20 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
 	return r;
 }
 
+/*
+ * On POWER9, threads are independent and can be in different partitions.
+ * Therefore we consider each thread to be a subcore.
+ * There is a restriction that all threads have to be in the same
+ * MMU mode (radix or HPT), unfortunately, but since we only support
+ * HPT guests on a HPT host so far, that isn't an impediment yet.
+ */
+static int threads_per_vcore(void)
+{
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		return 1;
+	return threads_per_subcore;
+}
+
 static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 {
 	struct kvmppc_vcore *vcore;
@@ -1590,7 +1604,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 	init_swait_queue_head(&vcore->wq);
 	vcore->preempt_tb = TB_NIL;
 	vcore->lpcr = kvm->arch.lpcr;
-	vcore->first_vcpuid = core * threads_per_subcore;
+	vcore->first_vcpuid = core * threads_per_vcore();
 	vcore->kvm = kvm;
 	INIT_LIST_HEAD(&vcore->preempt_list);
 
@@ -1753,7 +1767,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	int core;
 	struct kvmppc_vcore *vcore;
 
-	core = id / threads_per_subcore;
+	core = id / threads_per_vcore();
 	if (core >= KVM_MAX_VCORES)
 		goto out;
 
@@ -1971,7 +1985,10 @@ static void kvmppc_wait_for_nap(void)
 {
 	int cpu = smp_processor_id();
 	int i, loops;
+	int n_threads = threads_per_vcore();
 
+	if (n_threads <= 1)
+		return;
 	for (loops = 0; loops < 1000000; ++loops) {
 		/*
 		 * Check if all threads are finished.
@@ -1979,17 +1996,17 @@ static void kvmppc_wait_for_nap(void)
 		 * and the thread clears it when finished, so we look
 		 * for any threads that still have a non-NULL vcore ptr.
 		 */
-		for (i = 1; i < threads_per_subcore; ++i)
+		for (i = 1; i < n_threads; ++i)
 			if (paca[cpu + i].kvm_hstate.kvm_vcore)
 				break;
-		if (i == threads_per_subcore) {
+		if (i == n_threads) {
 			HMT_medium();
 			return;
 		}
 		HMT_low();
 	}
 	HMT_medium();
-	for (i = 1; i < threads_per_subcore; ++i)
+	for (i = 1; i < n_threads; ++i)
 		if (paca[cpu + i].kvm_hstate.kvm_vcore)
 			pr_err("KVM: CPU %d seems to be stuck\n", cpu + i);
 }
@@ -2055,7 +2072,7 @@ static void kvmppc_vcore_preempt(struct kvmppc_vcore *vc)
 
 	vc->vcore_state = VCORE_PREEMPT;
 	vc->pcpu = smp_processor_id();
-	if (vc->num_threads < threads_per_subcore) {
+	if (vc->num_threads < threads_per_vcore()) {
 		spin_lock(&lp->lock);
 		list_add_tail(&vc->preempt_list, &lp->list);
 		spin_unlock(&lp->lock);
@@ -2342,6 +2359,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	unsigned long cmd_bit, stat_bit;
 	int pcpu, thr;
 	int target_threads;
+	int controlled_threads;
 
 	/*
 	 * Remove from the list any threads that have a signal pending
@@ -2360,11 +2378,18 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	vc->preempt_tb = TB_NIL;
 
 	/*
+	 * Number of threads that we will be controlling: the same as
+	 * the number of threads per subcore, except on POWER9,
+	 * where it's 1 because the threads are (mostly) independent.
+	 */
+	controlled_threads = threads_per_vcore();
+
+	/*
 	 * Make sure we are running on primary threads, and that secondary
 	 * threads are offline.  Also check if the number of threads in this
 	 * guest are greater than the current system threads per guest.
 	 */
-	if ((threads_per_core > 1) &&
+	if ((controlled_threads > 1) &&
 	    ((vc->num_threads > threads_per_subcore) || !on_primary_thread())) {
 		for_each_runnable_thread(i, vcpu, vc) {
 			vcpu->arch.ret = -EBUSY;
@@ -2380,7 +2405,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	 */
 	init_core_info(&core_info, vc);
 	pcpu = smp_processor_id();
-	target_threads = threads_per_subcore;
+	target_threads = controlled_threads;
 	if (target_smt_mode && target_smt_mode < target_threads)
 		target_threads = target_smt_mode;
 	if (vc->num_threads < target_threads)
@@ -2416,7 +2441,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 		smp_wmb();
 	}
 	pcpu = smp_processor_id();
-	for (thr = 0; thr < threads_per_subcore; ++thr)
+	for (thr = 0; thr < controlled_threads; ++thr)
 		paca[pcpu + thr].kvm_hstate.kvm_split_mode = sip;
 
 	/* Initiate micro-threading (split-core) if required */
@@ -2526,7 +2551,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	}
 
 	/* Let secondaries go back to the offline loop */
-	for (i = 0; i < threads_per_subcore; ++i) {
+	for (i = 0; i < controlled_threads; ++i) {
 		kvmppc_release_hwthread(pcpu + i);
 		if (sip && sip->napped[i])
 			kvmppc_ipi_thread(pcpu + i);
@@ -3392,9 +3417,9 @@ static int kvmppc_core_check_processor_compat_hv(void)
 	    !cpu_has_feature(CPU_FTR_ARCH_206))
 		return -EIO;
 	/*
-	 * Disable KVM for Power9, untill the required bits merged.
+	 * Disable KVM for Power9 in radix mode.
 	 */
-	if (cpu_has_feature(CPU_FTR_ARCH_300))
+	if (cpu_has_feature(CPU_FTR_ARCH_300) && radix_enabled())
 		return -EIO;
 
 	return 0;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 70963c8..b5e4705 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -548,10 +548,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 #endif /* CONFIG_PPC_BOOK3S_64 */
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	case KVM_CAP_PPC_SMT:
-		if (hv_enabled)
-			r = threads_per_subcore;
-		else
-			r = 0;
+		r = 0;
+		if (hv_enabled) {
+			if (cpu_has_feature(CPU_FTR_ARCH_300))
+				r = 1;
+			else
+				r = threads_per_subcore;
+		}
 		break;
 	case KVM_CAP_PPC_RMA:
 		r = 0;
-- 
2.7.4
