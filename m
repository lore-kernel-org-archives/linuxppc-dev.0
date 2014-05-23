Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3260E1A05D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 May 2014 18:15:46 +1000 (EST)
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH v2 5/6] KVM: PPC: Book3S HV: Use threads_per_subcore in KVM
Date: Fri, 23 May 2014 18:15:29 +1000
Message-Id: <1400832930-17050-6-git-send-email-mikey@neuling.org>
In-Reply-To: <1400832930-17050-1-git-send-email-mikey@neuling.org>
References: <1400832930-17050-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Michael Ellerman <mpe@ellerman.id.au>

To support split core on POWER8 we need to modify various parts of the
KVM code to use threads_per_subcore instead of threads_per_core. On
systems that do not support split core threads_per_subcore ==
threads_per_core and these changes are a nop.

We use threads_per_subcore as the value reported by KVM_CAP_PPC_SMT.
This communicates to userspace that guests can only be created with
a value of threads_per_core that is less than or equal to the current
threads_per_subcore. This ensures that guests can only be created with a
thread configuration that we are able to run given the current split
core mode.

Although threads_per_subcore can change during the life of the system,
the commit that enables that will ensure that threads_per_subcore does
not change during the life of a KVM VM.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Alexander Graf <agraf@suse.de>
Acked-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kvm/book3s_hv.c | 26 ++++++++++++++++----------
 arch/powerpc/kvm/powerpc.c   |  2 +-
 2 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index d7b74f8..5e86f28 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1266,7 +1266,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 	int core;
 	struct kvmppc_vcore *vcore;
 
-	core = id / threads_per_core;
+	core = id / threads_per_subcore;
 	if (core >= KVM_MAX_VCORES)
 		goto out;
 
@@ -1305,7 +1305,7 @@ static struct kvm_vcpu *kvmppc_core_vcpu_create_hv(struct kvm *kvm,
 			init_waitqueue_head(&vcore->wq);
 			vcore->preempt_tb = TB_NIL;
 			vcore->lpcr = kvm->arch.lpcr;
-			vcore->first_vcpuid = core * threads_per_core;
+			vcore->first_vcpuid = core * threads_per_subcore;
 			vcore->kvm = kvm;
 		}
 		kvm->arch.vcores[core] = vcore;
@@ -1495,16 +1495,19 @@ static void kvmppc_wait_for_nap(struct kvmppc_vcore *vc)
 static int on_primary_thread(void)
 {
 	int cpu = smp_processor_id();
-	int thr = cpu_thread_in_core(cpu);
+	int thr;
 
-	if (thr)
+	/* Are we on a primary subcore? */
+	if (cpu_thread_in_subcore(cpu))
 		return 0;
-	while (++thr < threads_per_core)
+
+	thr = 0;
+	while (++thr < threads_per_subcore)
 		if (cpu_online(cpu + thr))
 			return 0;
 
 	/* Grab all hw threads so they can't go into the kernel */
-	for (thr = 1; thr < threads_per_core; ++thr) {
+	for (thr = 1; thr < threads_per_subcore; ++thr) {
 		if (kvmppc_grab_hwthread(cpu + thr)) {
 			/* Couldn't grab one; let the others go */
 			do {
@@ -1563,15 +1566,18 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
 	}
 
 	/*
-	 * Make sure we are running on thread 0, and that
-	 * secondary threads are offline.
+	 * Make sure we are running on primary threads, and that secondary
+	 * threads are offline.  Also check if the number of threads in this
+	 * guest are greater than the current system threads per guest.
 	 */
-	if (threads_per_core > 1 && !on_primary_thread()) {
+	if ((threads_per_core > 1) &&
+	    ((vc->num_threads > threads_per_subcore) || !on_primary_thread())) {
 		list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list)
 			vcpu->arch.ret = -EBUSY;
 		goto out;
 	}
 
+
 	vc->pcpu = smp_processor_id();
 	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list) {
 		kvmppc_start_thread(vcpu);
@@ -1599,7 +1605,7 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
 	/* wait for secondary threads to finish writing their state to memory */
 	if (vc->nap_count < vc->n_woken)
 		kvmppc_wait_for_nap(vc);
-	for (i = 0; i < threads_per_core; ++i)
+	for (i = 0; i < threads_per_subcore; ++i)
 		kvmppc_release_hwthread(vc->pcpu + i);
 	/* prevent other vcpu threads from doing kvmppc_start_thread() now */
 	vc->vcore_state = VCORE_EXITING;
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 3cf541a..27919a8 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -384,7 +384,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 	case KVM_CAP_PPC_SMT:
 		if (hv_enabled)
-			r = threads_per_core;
+			r = threads_per_subcore;
 		else
 			r = 0;
 		break;
-- 
1.9.1
