Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKqP403H0zDvt5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 18:28:56 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: kvm@vger.kernel.org,
	kvm-ppc@vger.kernel.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH 13/13] KVM: PPC: Book3S HV: Treat POWER9 CPU threads as
 independent subcores
Date: Fri, 18 Nov 2016 18:28:42 +1100
Message-Id: <1479454122-26994-14-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
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
 arch/powerpc/kvm/book3s_hv.c | 36 +++++++++++++++++++++++++++++-------
 arch/powerpc/kvm/powerpc.c   | 11 +++++++----
 2 files changed, 36 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index a1d2b5f..591ac84 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1569,6 +1569,20 @@ static int kvmppc_set_one_reg_hv(struct kvm_vcpu *vcpu, u64 id,
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
@@ -1583,7 +1597,7 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 	init_swait_queue_head(&vcore->wq);
 	vcore->preempt_tb = TB_NIL;
 	vcore->lpcr = kvm->arch.lpcr;
-	vcore->first_vcpuid = core * threads_per_subcore;
+	vcore->first_vcpuid = core * threads_per_vcore();
 	vcore->kvm = kvm;
 	INIT_LIST_HEAD(&vcore->preempt_list);
 
@@ -1746,7 +1760,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	int core;
 	struct kvmppc_vcore *vcore;
 
-	core = id / threads_per_subcore;
+	core = id / threads_per_vcore();
 	if (core >= KVM_MAX_VCORES)
 		goto out;
 
@@ -2336,6 +2350,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	unsigned long cmd_bit, stat_bit;
 	int pcpu, thr;
 	int target_threads;
+	int controlled_threads;
 
 	/*
 	 * Remove from the list any threads that have a signal pending
@@ -2354,11 +2369,18 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
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
@@ -2374,7 +2396,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	 */
 	init_core_info(&core_info, vc);
 	pcpu = smp_processor_id();
-	target_threads = threads_per_subcore;
+	target_threads = controlled_threads;
 	if (target_smt_mode && target_smt_mode < target_threads)
 		target_threads = target_smt_mode;
 	if (vc->num_threads < target_threads)
@@ -2410,7 +2432,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 		smp_wmb();
 	}
 	pcpu = smp_processor_id();
-	for (thr = 0; thr < threads_per_subcore; ++thr)
+	for (thr = 0; thr < controlled_threads; ++thr)
 		paca[pcpu + thr].kvm_hstate.kvm_split_mode = sip;
 
 	/* Initiate micro-threading (split-core) if required */
@@ -3380,9 +3402,9 @@ static int kvmppc_core_check_processor_compat_hv(void)
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
