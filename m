Return-Path: <sjitindarsingh@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rV1Gt6YsSzDqZw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 19:21:26 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id t190so1385812pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jun 2016 02:21:26 -0700 (PDT)
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, mpe@ellerman.id.au, paulus@samba.org,
 benh@kernel.crashing.org, kvm@vger.kernel.org, pbonzini@redhat.com,
 agraf@suse.com, rkrcmar@redhat.com,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Subject: [PATCH 1/4] kvm/ppc/book3s_hv: Change vcore element runnable_threads
 from linked-list to array
Date: Wed, 15 Jun 2016 19:21:05 +1000
Message-Id: <1465982468-18833-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The struct kvmppc_vcore is a structure used to store various information
about a virtual core for a kvm guest. The runnable_threads element of the
struct provides a list of all of the currently runnable vcpus on the core
(those in the KVMPPC_VCPU_RUNNABLE state). The previous implementation of
this list was a linked_list. The next patch requires that the list be able
to be iterated over without holding the vcore lock.

Reimplement the runnable_threads list in the kvmppc_vcore struct as an
array. Implement function to iterate over valid entries in the array and
update access sites accordingly.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 arch/powerpc/include/asm/kvm_host.h |  3 +-
 arch/powerpc/kvm/book3s_hv.c        | 68 +++++++++++++++++++++++--------------
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index ec35af3..4915443 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -293,7 +293,7 @@ struct kvmppc_vcore {
 	u8 vcore_state;
 	u8 in_guest;
 	struct kvmppc_vcore *master_vcore;
-	struct list_head runnable_threads;
+	struct kvm_vcpu *runnable_threads[MAX_SMT_THREADS];
 	struct list_head preempt_list;
 	spinlock_t lock;
 	struct swait_queue_head wq;
@@ -668,7 +668,6 @@ struct kvm_vcpu_arch {
 	long pgfault_index;
 	unsigned long pgfault_hpte[2];
 
-	struct list_head run_list;
 	struct task_struct *run_task;
 	struct kvm_run *kvm_run;
 
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index e20beae..3bcf9e6 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -57,6 +57,7 @@
 #include <linux/highmem.h>
 #include <linux/hugetlb.h>
 #include <linux/module.h>
+#include <linux/compiler.h>
 
 #include "book3s.h"
 
@@ -96,6 +97,26 @@ MODULE_PARM_DESC(h_ipi_redirect, "Redirect H_IPI wakeup to a free host core");
 static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
 static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu);
 
+static inline struct kvm_vcpu *next_runnable_thread(struct kvmppc_vcore *vc,
+		int *ip)
+{
+	int i = *ip;
+	struct kvm_vcpu *vcpu;
+
+	while (++i < MAX_SMT_THREADS) {
+		vcpu = READ_ONCE(vc->runnable_threads[i]);
+		if (vcpu) {
+			*ip = i;
+			return vcpu;
+		}
+	}
+	return NULL;
+}
+
+/* Used to traverse the list of runnable threads for a given vcore */
+#define for_each_runnable_thread(i, vcpu, vc) \
+	for (i = -1; (vcpu = next_runnable_thread(vc, &i)); )
+
 static bool kvmppc_ipi_thread(int cpu)
 {
 	/* On POWER8 for IPIs to threads in the same core, use msgsnd */
@@ -1492,7 +1513,6 @@ static struct kvmppc_vcore *kvmppc_vcore_create(struct kvm *kvm, int core)
 	if (vcore == NULL)
 		return NULL;
 
-	INIT_LIST_HEAD(&vcore->runnable_threads);
 	spin_lock_init(&vcore->lock);
 	spin_lock_init(&vcore->stoltb_lock);
 	init_swait_queue_head(&vcore->wq);
@@ -1801,7 +1821,7 @@ static void kvmppc_remove_runnable(struct kvmppc_vcore *vc,
 	vcpu->arch.state = KVMPPC_VCPU_BUSY_IN_HOST;
 	spin_unlock_irq(&vcpu->arch.tbacct_lock);
 	--vc->n_runnable;
-	list_del(&vcpu->arch.run_list);
+	WRITE_ONCE(vc->runnable_threads[vcpu->arch.ptid], NULL);
 }
 
 static int kvmppc_grab_hwthread(int cpu)
@@ -2208,10 +2228,10 @@ static bool can_piggyback(struct kvmppc_vcore *pvc, struct core_info *cip,
 
 static void prepare_threads(struct kvmppc_vcore *vc)
 {
-	struct kvm_vcpu *vcpu, *vnext;
+	int i;
+	struct kvm_vcpu *vcpu;
 
-	list_for_each_entry_safe(vcpu, vnext, &vc->runnable_threads,
-				 arch.run_list) {
+	for_each_runnable_thread(i, vcpu, vc) {
 		if (signal_pending(vcpu->arch.run_task))
 			vcpu->arch.ret = -EINTR;
 		else if (vcpu->arch.vpa.update_pending ||
@@ -2258,15 +2278,14 @@ static void collect_piggybacks(struct core_info *cip, int target_threads)
 
 static void post_guest_process(struct kvmppc_vcore *vc, bool is_master)
 {
-	int still_running = 0;
+	int still_running = 0, i;
 	u64 now;
 	long ret;
-	struct kvm_vcpu *vcpu, *vnext;
+	struct kvm_vcpu *vcpu;
 
 	spin_lock(&vc->lock);
 	now = get_tb();
-	list_for_each_entry_safe(vcpu, vnext, &vc->runnable_threads,
-				 arch.run_list) {
+	for_each_runnable_thread(i, vcpu, vc) {
 		/* cancel pending dec exception if dec is positive */
 		if (now < vcpu->arch.dec_expires &&
 		    kvmppc_core_pending_dec(vcpu))
@@ -2306,8 +2325,8 @@ static void post_guest_process(struct kvmppc_vcore *vc, bool is_master)
 		}
 		if (vc->n_runnable > 0 && vc->runner == NULL) {
 			/* make sure there's a candidate runner awake */
-			vcpu = list_first_entry(&vc->runnable_threads,
-						struct kvm_vcpu, arch.run_list);
+			i = -1;
+			vcpu = next_runnable_thread(vc, &i);
 			wake_up(&vcpu->arch.cpu_run);
 		}
 	}
@@ -2360,7 +2379,7 @@ static inline void kvmppc_set_host_core(int cpu)
  */
 static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 {
-	struct kvm_vcpu *vcpu, *vnext;
+	struct kvm_vcpu *vcpu;
 	int i;
 	int srcu_idx;
 	struct core_info core_info;
@@ -2396,8 +2415,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 	 */
 	if ((threads_per_core > 1) &&
 	    ((vc->num_threads > threads_per_subcore) || !on_primary_thread())) {
-		list_for_each_entry_safe(vcpu, vnext, &vc->runnable_threads,
-					 arch.run_list) {
+		for_each_runnable_thread(i, vcpu, vc) {
 			vcpu->arch.ret = -EBUSY;
 			kvmppc_remove_runnable(vc, vcpu);
 			wake_up(&vcpu->arch.cpu_run);
@@ -2476,8 +2494,7 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
 		active |= 1 << thr;
 		list_for_each_entry(pvc, &core_info.vcs[sub], preempt_list) {
 			pvc->pcpu = pcpu + thr;
-			list_for_each_entry(vcpu, &pvc->runnable_threads,
-					    arch.run_list) {
+			for_each_runnable_thread(i, vcpu, pvc) {
 				kvmppc_start_thread(vcpu, pvc);
 				kvmppc_create_dtl_entry(vcpu, pvc);
 				trace_kvm_guest_enter(vcpu);
@@ -2610,7 +2627,7 @@ static void kvmppc_wait_for_exec(struct kvmppc_vcore *vc,
 static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 {
 	struct kvm_vcpu *vcpu;
-	int do_sleep = 1;
+	int do_sleep = 1, i;
 	DECLARE_SWAITQUEUE(wait);
 
 	prepare_to_swait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
@@ -2619,7 +2636,7 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 	 * Check one last time for pending exceptions and ceded state after
 	 * we put ourselves on the wait queue
 	 */
-	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list) {
+	for_each_runnable_thread(i, vcpu, vc) {
 		if (vcpu->arch.pending_exceptions || !vcpu->arch.ceded) {
 			do_sleep = 0;
 			break;
@@ -2643,9 +2660,9 @@ static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
 
 static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 {
-	int n_ceded;
+	int n_ceded, i;
 	struct kvmppc_vcore *vc;
-	struct kvm_vcpu *v, *vn;
+	struct kvm_vcpu *v;
 
 	trace_kvmppc_run_vcpu_enter(vcpu);
 
@@ -2665,7 +2682,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 	vcpu->arch.stolen_logged = vcore_stolen_time(vc, mftb());
 	vcpu->arch.state = KVMPPC_VCPU_RUNNABLE;
 	vcpu->arch.busy_preempt = TB_NIL;
-	list_add_tail(&vcpu->arch.run_list, &vc->runnable_threads);
+	WRITE_ONCE(vc->runnable_threads[vcpu->arch.ptid], vcpu);
 	++vc->n_runnable;
 
 	/*
@@ -2705,8 +2722,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 			kvmppc_wait_for_exec(vc, vcpu, TASK_INTERRUPTIBLE);
 			continue;
 		}
-		list_for_each_entry_safe(v, vn, &vc->runnable_threads,
-					 arch.run_list) {
+		for_each_runnable_thread(i, v, vc) {
 			kvmppc_core_prepare_to_enter(v);
 			if (signal_pending(v->arch.run_task)) {
 				kvmppc_remove_runnable(vc, v);
@@ -2719,7 +2735,7 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 		if (!vc->n_runnable || vcpu->arch.state != KVMPPC_VCPU_RUNNABLE)
 			break;
 		n_ceded = 0;
-		list_for_each_entry(v, &vc->runnable_threads, arch.run_list) {
+		for_each_runnable_thread(i, v, vc) {
 			if (!v->arch.pending_exceptions)
 				n_ceded += v->arch.ceded;
 			else
@@ -2758,8 +2774,8 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 
 	if (vc->n_runnable && vc->vcore_state == VCORE_INACTIVE) {
 		/* Wake up some vcpu to run the core */
-		v = list_first_entry(&vc->runnable_threads,
-				     struct kvm_vcpu, arch.run_list);
+		i = -1;
+		v = next_runnable_thread(vc, &i);
 		wake_up(&v->arch.cpu_run);
 	}
 
-- 
2.5.5
