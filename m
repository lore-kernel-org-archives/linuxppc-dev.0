Return-Path: <paulus@ozlabs.org>
Date: Sat, 23 Jul 2011 17:42:46 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
Subject: [PATCH 3/3] KVM: PPC: Implement H_CEDE hcall for book3s_hv in
	real-mode code
Message-ID: <20110723074246.GC17927@bloggs.ozlabs.ibm.com>
References: <20110723074111.GA17927@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110723074111.GA17927@bloggs.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With a KVM guest operating in SMT4 mode (i.e. 4 hardware threads per
core), whenever a CPU goes idle, we have to pull all the other
hardware threads in the core out of the guest, because the H_CEDE
hcall is handled in the kernel.  This is inefficient.

This adds code to book3s_hv_rmhandlers.S to handle the H_CEDE hcall
in real mode.  When a guest vcpu does an H_CEDE hcall, we now only
exit to the kernel if all the other vcpus in the same core are also
idle.  Otherwise we mark this vcpu as napping, save state that could
be lost in nap mode (mainly GPRs and FPRs), and execute the nap
instruction.  When the thread wakes up, because of a decrementer or
external interrupt, we come back in at kvm_start_guest (from the
system reset interrupt vector), find the `napping' flag set in the
paca, and go to the resume path.

This has some other ramifications.  First, when starting a core, we
now start all the threads, both those that are immediately runnable and
those that are idle.  This is so that we don't have to pull all the
threads out of the guest when an idle thread gets a decrementer interrupt
and wants to start running.  In fact the idle threads will all start
with the H_CEDE hcall returning; being idle they will just do another
H_CEDE immediately and go to nap mode.

This required some changes to kvmppc_run_core() and kvmppc_run_vcpu().
These functions have been restructured to make them simpler and clearer.
We introduce a level of indirection in the wait queue that gets woken
when external and decrementer interrupts get generated for a vcpu, so
that we can have the 4 vcpus in a vcore using the same wait queue.
We need this because the 4 vcpus are being handled by one thread.

Secondly, when we need to exit from the guest to the kernel, we now
have to generate an IPI for any napping threads, because an HDEC
interrupt doesn't wake up a napping thread.

Thirdly, we now need to be able to handle virtual external interrupts
and decrementer interrupts becoming pending while a thread is napping,
and deliver those interrupts to the guest when the thread wakes.
This is done in kvmppc_cede_reentry, just before fast_guest_return.

Finally, since we are not using the generic kvm_vcpu_block for book3s_hv,
and hence not calling kvm_arch_vcpu_runnable, we can remove the #ifdef
from kvm_arch_vcpu_runnable.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/kvm_book3s_asm.h |    1 +
 arch/powerpc/include/asm/kvm_host.h       |   19 ++-
 arch/powerpc/kernel/asm-offsets.c         |    6 +
 arch/powerpc/kvm/book3s_hv.c              |  335 ++++++++++++++++-------------
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  297 ++++++++++++++++++++++---
 arch/powerpc/kvm/powerpc.c                |   21 +-
 6 files changed, 483 insertions(+), 196 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index af73469..1f2f5b6 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -76,6 +76,7 @@ struct kvmppc_host_state {
 	ulong scratch1;
 	u8 in_guest;
 	u8 restore_hid5;
+	u8 napping;
 
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	struct kvm_vcpu *kvm_vcpu;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index db15384..652b05f 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -198,21 +198,29 @@ struct kvm_arch {
  */
 struct kvmppc_vcore {
 	int n_runnable;
-	int n_blocked;
+	int n_busy;
 	int num_threads;
 	int entry_exit_count;
 	int n_woken;
 	int nap_count;
+	int napping_threads;
 	u16 pcpu;
-	u8 vcore_running;
+	u8 vcore_state;
 	u8 in_guest;
 	struct list_head runnable_threads;
 	spinlock_t lock;
+	wait_queue_head_t wq;
 };
 
 #define VCORE_ENTRY_COUNT(vc)	((vc)->entry_exit_count & 0xff)
 #define VCORE_EXIT_COUNT(vc)	((vc)->entry_exit_count >> 8)
 
+/* Values for vcore_state */
+#define VCORE_INACTIVE	0
+#define VCORE_RUNNING	1
+#define VCORE_EXITING	2
+#define VCORE_SLEEPING	3
+
 struct kvmppc_pte {
 	ulong eaddr;
 	u64 vpage;
@@ -400,11 +408,13 @@ struct kvm_vcpu_arch {
 	struct dtl *dtl;
 	struct dtl *dtl_end;
 
+	wait_queue_head_t *wqp;
 	struct kvmppc_vcore *vcore;
 	int ret;
 	int trap;
 	int state;
 	int ptid;
+	bool timer_running;
 	wait_queue_head_t cpu_run;
 
 	struct kvm_vcpu_arch_shared *shared;
@@ -420,8 +430,9 @@ struct kvm_vcpu_arch {
 #endif
 };
 
-#define KVMPPC_VCPU_BUSY_IN_HOST	0
-#define KVMPPC_VCPU_BLOCKED		1
+/* Values for vcpu->arch.state */
+#define KVMPPC_VCPU_STOPPED		0
+#define KVMPPC_VCPU_BUSY_IN_HOST	1
 #define KVMPPC_VCPU_RUNNABLE		2
 
 #endif /* __POWERPC_KVM_HOST_H__ */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index d34cd32..833021c 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -44,6 +44,7 @@
 #include <asm/compat.h>
 #include <asm/mmu.h>
 #include <asm/hvcall.h>
+#include <asm/xics.h>
 #endif
 #ifdef CONFIG_PPC_ISERIES
 #include <asm/iseries/alpaca.h>
@@ -457,6 +458,8 @@ int main(void)
 	DEFINE(VCPU_DEC, offsetof(struct kvm_vcpu, arch.dec));
 	DEFINE(VCPU_DEC_EXPIRES, offsetof(struct kvm_vcpu, arch.dec_expires));
 	DEFINE(VCPU_PENDING_EXC, offsetof(struct kvm_vcpu, arch.pending_exceptions));
+	DEFINE(VCPU_CEDED, offsetof(struct kvm_vcpu, arch.ceded));
+	DEFINE(VCPU_PRODDED, offsetof(struct kvm_vcpu, arch.prodded));
 	DEFINE(VCPU_VPA, offsetof(struct kvm_vcpu, arch.vpa));
 	DEFINE(VCPU_MMCR, offsetof(struct kvm_vcpu, arch.mmcr));
 	DEFINE(VCPU_PMC, offsetof(struct kvm_vcpu, arch.pmc));
@@ -472,6 +475,7 @@ int main(void)
 	DEFINE(VCORE_ENTRY_EXIT, offsetof(struct kvmppc_vcore, entry_exit_count));
 	DEFINE(VCORE_NAP_COUNT, offsetof(struct kvmppc_vcore, nap_count));
 	DEFINE(VCORE_IN_GUEST, offsetof(struct kvmppc_vcore, in_guest));
+	DEFINE(VCORE_NAPPING_THREADS, offsetof(struct kvmppc_vcore, napping_threads));
 	DEFINE(VCPU_SVCPU, offsetof(struct kvmppc_vcpu_book3s, shadow_vcpu) -
 			   offsetof(struct kvmppc_vcpu_book3s, vcpu));
 	DEFINE(VCPU_SLB_E, offsetof(struct kvmppc_slb, orige));
@@ -529,6 +533,7 @@ int main(void)
 	HSTATE_FIELD(HSTATE_SCRATCH1, scratch1);
 	HSTATE_FIELD(HSTATE_IN_GUEST, in_guest);
 	HSTATE_FIELD(HSTATE_RESTORE_HID5, restore_hid5);
+	HSTATE_FIELD(HSTATE_NAPPING, napping);
 
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	HSTATE_FIELD(HSTATE_KVM_VCPU, kvm_vcpu);
@@ -541,6 +546,7 @@ int main(void)
 	HSTATE_FIELD(HSTATE_DSCR, host_dscr);
 	HSTATE_FIELD(HSTATE_DABR, dabr);
 	HSTATE_FIELD(HSTATE_DECEXP, dec_expires);
+	DEFINE(IPI_PRIORITY, IPI_PRIORITY);
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
 
 #else /* CONFIG_PPC_BOOK3S */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index cc0d7f1..81c384d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -62,6 +62,8 @@
 /* #define EXIT_DEBUG_SIMPLE */
 /* #define EXIT_DEBUG_INT */
 
+static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
+
 void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	local_paca->kvm_hstate.kvm_vcpu = vcpu;
@@ -72,40 +74,10 @@ void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 {
 }
 
-static void kvmppc_vcpu_blocked(struct kvm_vcpu *vcpu);
-static void kvmppc_vcpu_unblocked(struct kvm_vcpu *vcpu);
-
-void kvmppc_vcpu_block(struct kvm_vcpu *vcpu)
-{
-	u64 now;
-	unsigned long dec_nsec;
-
-	now = get_tb();
-	if (now >= vcpu->arch.dec_expires && !kvmppc_core_pending_dec(vcpu))
-		kvmppc_core_queue_dec(vcpu);
-	if (vcpu->arch.pending_exceptions)
-		return;
-	if (vcpu->arch.dec_expires != ~(u64)0) {
-		dec_nsec = (vcpu->arch.dec_expires - now) * NSEC_PER_SEC /
-			tb_ticks_per_sec;
-		hrtimer_start(&vcpu->arch.dec_timer, ktime_set(0, dec_nsec),
-			      HRTIMER_MODE_REL);
-	}
-
-	kvmppc_vcpu_blocked(vcpu);
-
-	kvm_vcpu_block(vcpu);
-	vcpu->stat.halt_wakeup++;
-
-	if (vcpu->arch.dec_expires != ~(u64)0)
-		hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
-
-	kvmppc_vcpu_unblocked(vcpu);
-}
-
 void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
 {
 	vcpu->arch.shregs.msr = msr;
+	kvmppc_end_cede(vcpu);
 }
 
 void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr)
@@ -257,15 +229,6 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 
 	switch (req) {
 	case H_CEDE:
-		vcpu->arch.shregs.msr |= MSR_EE;
-		vcpu->arch.ceded = 1;
-		smp_mb();
-		if (!vcpu->arch.prodded)
-			kvmppc_vcpu_block(vcpu);
-		else
-			vcpu->arch.prodded = 0;
-		smp_mb();
-		vcpu->arch.ceded = 0;
 		break;
 	case H_PROD:
 		target = kvmppc_get_gpr(vcpu, 4);
@@ -388,20 +351,6 @@ static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
 		break;
 	}
 
-
-	if (!(r & RESUME_HOST)) {
-		/* To avoid clobbering exit_reason, only check for signals if
-		 * we aren't already exiting to userspace for some other
-		 * reason. */
-		if (signal_pending(tsk)) {
-			vcpu->stat.signal_exits++;
-			run->exit_reason = KVM_EXIT_INTR;
-			r = -EINTR;
-		} else {
-			kvmppc_core_deliver_interrupts(vcpu);
-		}
-	}
-
 	return r;
 }
 
@@ -479,13 +428,9 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	kvmppc_mmu_book3s_hv_init(vcpu);
 
 	/*
-	 * Some vcpus may start out in stopped state.  If we initialize
-	 * them to busy-in-host state they will stop other vcpus in the
-	 * vcore from running.  Instead we initialize them to blocked
-	 * state, effectively considering them to be stopped until we
-	 * see the first run ioctl for them.
+	 * We consider the vcpu stopped until we see the first run ioctl for it.
 	 */
-	vcpu->arch.state = KVMPPC_VCPU_BLOCKED;
+	vcpu->arch.state = KVMPPC_VCPU_STOPPED;
 
 	init_waitqueue_head(&vcpu->arch.cpu_run);
 
@@ -496,6 +441,7 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 		if (vcore) {
 			INIT_LIST_HEAD(&vcore->runnable_threads);
 			spin_lock_init(&vcore->lock);
+			init_waitqueue_head(&vcore->wq);
 		}
 		kvm->arch.vcores[core] = vcore;
 	}
@@ -506,7 +452,6 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 
 	spin_lock(&vcore->lock);
 	++vcore->num_threads;
-	++vcore->n_blocked;
 	spin_unlock(&vcore->lock);
 	vcpu->arch.vcore = vcore;
 
@@ -524,30 +469,31 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	kfree(vcpu);
 }
 
-static void kvmppc_vcpu_blocked(struct kvm_vcpu *vcpu)
+static void kvmppc_set_timer(struct kvm_vcpu *vcpu)
 {
-	struct kvmppc_vcore *vc = vcpu->arch.vcore;
+	unsigned long dec_nsec, now;
 
-	spin_lock(&vc->lock);
-	vcpu->arch.state = KVMPPC_VCPU_BLOCKED;
-	++vc->n_blocked;
-	if (vc->n_runnable > 0 &&
-	    vc->n_runnable + vc->n_blocked == vc->num_threads) {
-		vcpu = list_first_entry(&vc->runnable_threads, struct kvm_vcpu,
-					arch.run_list);
-		wake_up(&vcpu->arch.cpu_run);
+	now = get_tb();
+	if (now > vcpu->arch.dec_expires) {
+		/* decrementer has already gone negative */
+		kvmppc_core_queue_dec(vcpu);
+		kvmppc_core_deliver_interrupts(vcpu);
+		return;
 	}
-	spin_unlock(&vc->lock);
+	dec_nsec = (vcpu->arch.dec_expires - now) * NSEC_PER_SEC
+		   / tb_ticks_per_sec;
+	hrtimer_start(&vcpu->arch.dec_timer, ktime_set(0, dec_nsec),
+		      HRTIMER_MODE_REL);
+	vcpu->arch.timer_running = 1;
 }
 
-static void kvmppc_vcpu_unblocked(struct kvm_vcpu *vcpu)
+static void kvmppc_end_cede(struct kvm_vcpu *vcpu)
 {
-	struct kvmppc_vcore *vc = vcpu->arch.vcore;
-
-	spin_lock(&vc->lock);
-	vcpu->arch.state = KVMPPC_VCPU_BUSY_IN_HOST;
-	--vc->n_blocked;
-	spin_unlock(&vc->lock);
+	vcpu->arch.ceded = 0;
+	if (vcpu->arch.timer_running) {
+		hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
+		vcpu->arch.timer_running = 0;
+	}
 }
 
 extern int __kvmppc_vcore_entry(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
@@ -562,6 +508,7 @@ static void kvmppc_remove_runnable(struct kvmppc_vcore *vc,
 		return;
 	vcpu->arch.state = KVMPPC_VCPU_BUSY_IN_HOST;
 	--vc->n_runnable;
+	++vc->n_busy;
 	/* decrement the physical thread id of each following vcpu */
 	v = vcpu;
 	list_for_each_entry_continue(v, &vc->runnable_threads, arch.run_list)
@@ -575,15 +522,20 @@ static void kvmppc_start_thread(struct kvm_vcpu *vcpu)
 	struct paca_struct *tpaca;
 	struct kvmppc_vcore *vc = vcpu->arch.vcore;
 
+	if (vcpu->arch.timer_running) {
+		hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
+		vcpu->arch.timer_running = 0;
+	}
 	cpu = vc->pcpu + vcpu->arch.ptid;
 	tpaca = &paca[cpu];
 	tpaca->kvm_hstate.kvm_vcpu = vcpu;
 	tpaca->kvm_hstate.kvm_vcore = vc;
+	tpaca->kvm_hstate.napping = 0;
+	vcpu->cpu = vc->pcpu;
 	smp_wmb();
 #ifdef CONFIG_PPC_ICP_NATIVE
 	if (vcpu->arch.ptid) {
 		tpaca->cpu_start = 0x80;
-		tpaca->kvm_hstate.in_guest = KVM_GUEST_MODE_GUEST;
 		wmb();
 		xics_wake_cpu(cpu);
 		++vc->n_woken;
@@ -631,9 +583,10 @@ static int on_primary_thread(void)
  */
 static int kvmppc_run_core(struct kvmppc_vcore *vc)
 {
-	struct kvm_vcpu *vcpu, *vnext;
+	struct kvm_vcpu *vcpu, *vcpu0, *vnext;
 	long ret;
 	u64 now;
+	int ptid;
 
 	/* don't start if any threads have a signal pending */
 	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list)
@@ -652,29 +605,50 @@ static int kvmppc_run_core(struct kvmppc_vcore *vc)
 		goto out;
 	}
 
+	/*
+	 * Assign physical thread IDs, first to non-ceded vcpus
+	 * and then to ceded ones.
+	 */
+	ptid = 0;
+	vcpu0 = NULL;
+	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list) {
+		if (!vcpu->arch.ceded) {
+			if (!ptid)
+				vcpu0 = vcpu;
+			vcpu->arch.ptid = ptid++;
+		}
+	}
+	if (!vcpu0)
+		return 0;		/* nothing to run */
+	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list)
+		if (vcpu->arch.ceded)
+			vcpu->arch.ptid = ptid++;
+
 	vc->n_woken = 0;
 	vc->nap_count = 0;
 	vc->entry_exit_count = 0;
-	vc->vcore_running = 1;
+	vc->vcore_state = VCORE_RUNNING;
 	vc->in_guest = 0;
 	vc->pcpu = smp_processor_id();
+	vc->napping_threads = 0;
 	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list)
 		kvmppc_start_thread(vcpu);
-	vcpu = list_first_entry(&vc->runnable_threads, struct kvm_vcpu,
-				arch.run_list);
 
+	preempt_disable();
 	spin_unlock(&vc->lock);
 
-	preempt_disable();
 	kvm_guest_enter();
-	__kvmppc_vcore_entry(NULL, vcpu);
+	__kvmppc_vcore_entry(NULL, vcpu0);
 
-	/* wait for secondary threads to finish writing their state to memory */
 	spin_lock(&vc->lock);
+	/* disable sending of IPIs on virtual external irqs */
+	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list)
+		vcpu->cpu = -1;
+	/* wait for secondary threads to finish writing their state to memory */
 	if (vc->nap_count < vc->n_woken)
 		kvmppc_wait_for_nap(vc);
 	/* prevent other vcpu threads from doing kvmppc_start_thread() now */
-	vc->vcore_running = 2;
+	vc->vcore_state = VCORE_EXITING;
 	spin_unlock(&vc->lock);
 
 	/* make sure updates to secondary vcpu structs are visible now */
@@ -690,22 +664,26 @@ static int kvmppc_run_core(struct kvmppc_vcore *vc)
 		if (now < vcpu->arch.dec_expires &&
 		    kvmppc_core_pending_dec(vcpu))
 			kvmppc_core_dequeue_dec(vcpu);
-		if (!vcpu->arch.trap) {
-			if (signal_pending(vcpu->arch.run_task)) {
-				vcpu->arch.kvm_run->exit_reason = KVM_EXIT_INTR;
-				vcpu->arch.ret = -EINTR;
-			}
-			continue;		/* didn't get to run */
-		}
-		ret = kvmppc_handle_exit(vcpu->arch.kvm_run, vcpu,
-					 vcpu->arch.run_task);
+
+		ret = RESUME_GUEST;
+		if (vcpu->arch.trap)
+			ret = kvmppc_handle_exit(vcpu->arch.kvm_run, vcpu,
+						 vcpu->arch.run_task);
+
 		vcpu->arch.ret = ret;
 		vcpu->arch.trap = 0;
+
+		if (vcpu->arch.ceded) {
+			if (ret != RESUME_GUEST)
+				kvmppc_end_cede(vcpu);
+			else
+				kvmppc_set_timer(vcpu);
+		}
 	}
 
 	spin_lock(&vc->lock);
  out:
-	vc->vcore_running = 0;
+	vc->vcore_state = VCORE_INACTIVE;
 	list_for_each_entry_safe(vcpu, vnext, &vc->runnable_threads,
 				 arch.run_list) {
 		if (vcpu->arch.ret != RESUME_GUEST) {
@@ -717,82 +695,130 @@ static int kvmppc_run_core(struct kvmppc_vcore *vc)
 	return 1;
 }
 
-static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
+/*
+ * Wait for some other vcpu thread to execute us, and
+ * wake us up when we need to handle something in the host.
+ */
+static void kvmppc_wait_for_exec(struct kvm_vcpu *vcpu, int wait_state)
 {
-	int ptid;
-	int wait_state;
-	struct kvmppc_vcore *vc;
 	DEFINE_WAIT(wait);
 
-	/* No need to go into the guest when all we do is going out */
-	if (signal_pending(current)) {
-		kvm_run->exit_reason = KVM_EXIT_INTR;
-		return -EINTR;
+	prepare_to_wait(&vcpu->arch.cpu_run, &wait, wait_state);
+	if (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE)
+		schedule();
+	finish_wait(&vcpu->arch.cpu_run, &wait);
+}
+
+/*
+ * All the vcpus in this vcore are idle, so wait for a decrementer
+ * or external interrupt to one of the vcpus.  vc->lock is held.
+ */
+static void kvmppc_vcore_blocked(struct kvmppc_vcore *vc)
+{
+	DEFINE_WAIT(wait);
+	struct kvm_vcpu *v;
+	int all_idle = 1;
+
+	prepare_to_wait(&vc->wq, &wait, TASK_INTERRUPTIBLE);
+	vc->vcore_state = VCORE_SLEEPING;
+	spin_unlock(&vc->lock);
+	list_for_each_entry(v, &vc->runnable_threads, arch.run_list) {
+		if (!v->arch.ceded || v->arch.pending_exceptions) {
+			all_idle = 0;
+			break;
+		}
 	}
+	if (all_idle)
+		schedule();
+	finish_wait(&vc->wq, &wait);
+	spin_lock(&vc->lock);
+	vc->vcore_state = VCORE_INACTIVE;
+}
 
-	/* On PPC970, check that we have an RMA region */
-	if (!vcpu->kvm->arch.rma && cpu_has_feature(CPU_FTR_ARCH_201))
-		return -EPERM;
+static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
+{
+	int n_ceded;
+	int prev_state;
+	struct kvmppc_vcore *vc;
+	struct kvm_vcpu *v, *vn;
 
 	kvm_run->exit_reason = 0;
 	vcpu->arch.ret = RESUME_GUEST;
 	vcpu->arch.trap = 0;
 
-	flush_fp_to_thread(current);
-	flush_altivec_to_thread(current);
-	flush_vsx_to_thread(current);
-
 	/*
 	 * Synchronize with other threads in this virtual core
 	 */
 	vc = vcpu->arch.vcore;
 	spin_lock(&vc->lock);
-	/* This happens the first time this is called for a vcpu */
-	if (vcpu->arch.state == KVMPPC_VCPU_BLOCKED)
-		--vc->n_blocked;
-	vcpu->arch.state = KVMPPC_VCPU_RUNNABLE;
-	ptid = vc->n_runnable;
+	vcpu->arch.ceded = 0;
 	vcpu->arch.run_task = current;
 	vcpu->arch.kvm_run = kvm_run;
-	vcpu->arch.ptid = ptid;
+	prev_state = vcpu->arch.state;
+	vcpu->arch.state = KVMPPC_VCPU_RUNNABLE;
 	list_add_tail(&vcpu->arch.run_list, &vc->runnable_threads);
 	++vc->n_runnable;
 
-	wait_state = TASK_INTERRUPTIBLE;
-	while (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE) {
-		if (signal_pending(current)) {
-			if (!vc->vcore_running) {
-				kvm_run->exit_reason = KVM_EXIT_INTR;
-				vcpu->arch.ret = -EINTR;
-				break;
-			}
-			/* have to wait for vcore to stop executing guest */
-			wait_state = TASK_UNINTERRUPTIBLE;
-			smp_send_reschedule(vc->pcpu);
+	/*
+	 * This happens the first time this is called for a vcpu.
+	 * If the vcore is already running, we may be able to start
+	 * this thread straight away and have it join in.
+	 */
+	if (prev_state == KVMPPC_VCPU_STOPPED) {
+		if (vc->vcore_state == VCORE_RUNNING &&
+		    VCORE_EXIT_COUNT(vc) == 0) {
+			vcpu->arch.ptid = vc->n_runnable - 1;
+			kvmppc_start_thread(vcpu);
 		}
 
-		if (!vc->vcore_running &&
-		    vc->n_runnable + vc->n_blocked == vc->num_threads) {
-			/* we can run now */
-			if (kvmppc_run_core(vc))
-				continue;
-		}
+	} else if (prev_state == KVMPPC_VCPU_BUSY_IN_HOST)
+		--vc->n_busy;
 
-		if (vc->vcore_running == 1 && VCORE_EXIT_COUNT(vc) == 0)
-			kvmppc_start_thread(vcpu);
+	while (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE &&
+	       !signal_pending(current)) {
+		if (vc->n_busy || vc->vcore_state != VCORE_INACTIVE) {
+			spin_unlock(&vc->lock);
+			kvmppc_wait_for_exec(vcpu, TASK_INTERRUPTIBLE);
+			spin_lock(&vc->lock);
+			continue;
+		}
+		n_ceded = 0;
+		list_for_each_entry(v, &vc->runnable_threads, arch.run_list)
+			n_ceded += v->arch.ceded;
+		if (n_ceded == vc->n_runnable)
+			kvmppc_vcore_blocked(vc);
+		else
+			kvmppc_run_core(vc);
+
+		list_for_each_entry_safe(v, vn, &vc->runnable_threads,
+					 arch.run_list) {
+			kvmppc_core_deliver_interrupts(v);
+			if (signal_pending(v->arch.run_task)) {
+				kvmppc_remove_runnable(vc, v);
+				v->stat.signal_exits++;
+				v->arch.kvm_run->exit_reason = KVM_EXIT_INTR;
+				v->arch.ret = -EINTR;
+				wake_up(&v->arch.cpu_run);
+			}
+		}
+	}
 
-		/* wait for other threads to come in, or wait for vcore */
-		prepare_to_wait(&vcpu->arch.cpu_run, &wait, wait_state);
-		spin_unlock(&vc->lock);
-		schedule();
-		finish_wait(&vcpu->arch.cpu_run, &wait);
-		spin_lock(&vc->lock);
+	if (signal_pending(current)) {
+		if (vc->vcore_state == VCORE_RUNNING ||
+		    vc->vcore_state == VCORE_EXITING) {
+			spin_unlock(&vc->lock);
+			kvmppc_wait_for_exec(vcpu, TASK_UNINTERRUPTIBLE);
+			spin_lock(&vc->lock);
+		}
+		if (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE) {
+			kvmppc_remove_runnable(vc, vcpu);
+			vcpu->stat.signal_exits++;
+			kvm_run->exit_reason = KVM_EXIT_INTR;
+			vcpu->arch.ret = -EINTR;
+		}
 	}
 
-	if (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE)
-		kvmppc_remove_runnable(vc, vcpu);
 	spin_unlock(&vc->lock);
-
 	return vcpu->arch.ret;
 }
 
@@ -800,6 +826,21 @@ int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	int r;
 
+	/* No need to go into the guest when all we'll do is come back out */
+	if (signal_pending(current)) {
+		run->exit_reason = KVM_EXIT_INTR;
+		return -EINTR;
+	}
+
+	/* On PPC970, check that we have an RMA region */
+	if (!vcpu->kvm->arch.rma && cpu_has_feature(CPU_FTR_ARCH_201))
+		return -EPERM;
+
+	flush_fp_to_thread(current);
+	flush_altivec_to_thread(current);
+	flush_vsx_to_thread(current);
+	vcpu->arch.wqp = &vcpu->arch.vcore->wq;
+
 	do {
 		r = kvmppc_run_vcpu(run, vcpu);
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 543ee50..0e2ea04 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -52,7 +52,7 @@ kvmppc_skip_Hinterrupt:
 	b	.
 
 /*
- * Call kvmppc_handler_trampoline_enter in real mode.
+ * Call kvmppc_hv_entry in real mode.
  * Must be called with interrupts hard-disabled.
  *
  * Input Registers:
@@ -92,6 +92,12 @@ _GLOBAL(kvmppc_hv_entry_trampoline)
 kvm_start_guest:
 	ld	r1,PACAEMERGSP(r13)
 	subi	r1,r1,STACK_FRAME_OVERHEAD
+	ld	r2,PACATOC(r13)
+
+	/* were we napping due to cede? */
+	lbz	r0,HSTATE_NAPPING(r13)
+	cmpwi	r0,0
+	bne	kvm_end_cede
 
 	/* get vcpu pointer */
 	ld	r4, HSTATE_KVM_VCPU(r13)
@@ -279,15 +285,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	cmpwi	r0,0
 	beq	20b
 
-	/* Set LPCR.  Set the MER bit if there is a pending external irq. */
+	/* Set LPCR and RMOR. */
 10:	ld	r8,KVM_LPCR(r9)
-	ld	r0,VCPU_PENDING_EXC(r4)
-	li	r7,(1 << BOOK3S_IRQPRIO_EXTERNAL)
-	oris	r7,r7,(1 << BOOK3S_IRQPRIO_EXTERNAL_LEVEL)@h
-	and.	r0,r0,r7
-	beq	11f
-	ori	r8,r8,LPCR_MER
-11:	mtspr	SPRN_LPCR,r8
+	mtspr	SPRN_LPCR,r8
 	ld	r8,KVM_RMOR(r9)
 	mtspr	SPRN_RMOR,r8
 	isync
@@ -451,19 +451,50 @@ toc_tlbie_lock:
 	mtctr	r6
 	mtxer	r7
 
-	/* Move SRR0 and SRR1 into the respective regs */
+kvmppc_cede_reentry:		/* r4 = vcpu, r13 = paca */
 	ld	r6, VCPU_SRR0(r4)
 	ld	r7, VCPU_SRR1(r4)
-	mtspr	SPRN_SRR0, r6
-	mtspr	SPRN_SRR1, r7
-
 	ld	r10, VCPU_PC(r4)
+	ld	r11, VCPU_MSR(r4)	/* r11 = vcpu->arch.msr & ~MSR_HV */
 
-	ld	r11, VCPU_MSR(r4)	/* r10 = vcpu->arch.msr & ~MSR_HV */
 	rldicl	r11, r11, 63 - MSR_HV_LG, 1
 	rotldi	r11, r11, 1 + MSR_HV_LG
 	ori	r11, r11, MSR_ME
 
+	/* Check if we can deliver an external or decrementer interrupt now */
+	ld	r0,VCPU_PENDING_EXC(r4)
+	li	r8,(1 << BOOK3S_IRQPRIO_EXTERNAL)
+	oris	r8,r8,(1 << BOOK3S_IRQPRIO_EXTERNAL_LEVEL)@h
+	and	r0,r0,r8
+	cmpdi	cr1,r0,0
+	andi.	r0,r11,MSR_EE
+	beq	cr1,11f
+BEGIN_FTR_SECTION
+	mfspr	r8,SPRN_LPCR
+	ori	r8,r8,LPCR_MER
+	mtspr	SPRN_LPCR,r8
+	isync
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
+	beq	5f
+	li	r0,BOOK3S_INTERRUPT_EXTERNAL
+12:	mr	r6,r10
+	mr	r10,r0
+	mr	r7,r11
+	li	r11,(MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
+	rotldi	r11,r11,63
+	b	5f
+11:	beq	5f
+	mfspr	r0,SPRN_DEC
+	cmpwi	r0,0
+	li	r0,BOOK3S_INTERRUPT_DECREMENTER
+	blt	12b
+
+	/* Move SRR0 and SRR1 into the respective regs */
+5:	mtspr	SPRN_SRR0, r6
+	mtspr	SPRN_SRR1, r7
+	li	r0,0
+	stb	r0,VCPU_CEDED(r4)	/* cancel cede */
+
 fast_guest_return:
 	mtspr	SPRN_HSRR0,r10
 	mtspr	SPRN_HSRR1,r11
@@ -577,21 +608,20 @@ kvmppc_interrupt:
 	/* See if this is something we can handle in real mode */
 	cmpwi	r12,BOOK3S_INTERRUPT_SYSCALL
 	beq	hcall_try_real_mode
-hcall_real_cont:
 
 	/* Check for mediated interrupts (could be done earlier really ...) */
 BEGIN_FTR_SECTION
 	cmpwi	r12,BOOK3S_INTERRUPT_EXTERNAL
 	bne+	1f
-	ld	r5,VCPU_KVM(r9)
-	ld	r5,KVM_LPCR(r5)
 	andi.	r0,r11,MSR_EE
 	beq	1f
+	mfspr	r5,SPRN_LPCR
 	andi.	r0,r5,LPCR_MER
 	bne	bounce_ext_interrupt
 1:
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
+hcall_real_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
 	/* Save DEC */
 	mfspr	r5,SPRN_DEC
 	mftb	r6
@@ -685,7 +715,7 @@ END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_201)
 	slbia
 	ptesync
 
-hdec_soon:
+hdec_soon:			/* r9 = vcpu, r12 = trap, r13 = paca */
 BEGIN_FTR_SECTION
 	b	32f
 END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
@@ -703,6 +733,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	addi	r0,r3,0x100
 	stwcx.	r0,0,r6
 	bne	41b
+	lwsync
 
 	/*
 	 * At this point we have an interrupt that we have to pass
@@ -716,18 +747,39 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	 * interrupt, since the other threads will already be on their
 	 * way here in that case.
 	 */
+	cmpwi	r3,0x100	/* Are we the first here? */
+	bge	43f
+	cmpwi	r3,1		/* Are any other threads in the guest? */
+	ble	43f
 	cmpwi	r12,BOOK3S_INTERRUPT_HV_DECREMENTER
 	beq	40f
-	cmpwi	r3,0x100	/* Are we the first here? */
-	bge	40f
-	cmpwi	r3,1
-	ble	40f
 	li	r0,0
 	mtspr	SPRN_HDEC,r0
 40:
+	/*
+	 * Send an IPI to any napping threads, since an HDEC interrupt
+	 * doesn't wake CPUs up from nap.
+	 */
+	lwz	r3,VCORE_NAPPING_THREADS(r5)
+	lwz	r4,VCPU_PTID(r9)
+	li	r0,1
+	sldi	r0,r0,r4
+	andc.	r3,r3,r0		/* no sense IPI'ing ourselves */
+	beq	43f
+	mulli	r4,r4,PACA_SIZE		/* get paca for thread 0 */
+	subf	r6,r4,r13
+42:	andi.	r0,r3,1
+	beq	44f
+	ld	r8,HSTATE_XICS_PHYS(r6)	/* get thread's XICS reg addr */
+	li	r0,IPI_PRIORITY
+	li	r7,XICS_QIRR
+	stbcix	r0,r7,r8		/* trigger the IPI */
+44:	srdi.	r3,r3,1
+	addi	r6,r6,PACA_SIZE
+	bne	42b
 
 	/* Secondary threads wait for primary to do partition switch */
-	ld	r4,VCPU_KVM(r9)		/* pointer to struct kvm */
+43:	ld	r4,VCPU_KVM(r9)		/* pointer to struct kvm */
 	ld	r5,HSTATE_KVM_VCORE(r13)
 	lwz	r3,VCPU_PTID(r9)
 	cmpwi	r3,0
@@ -1080,7 +1132,6 @@ hcall_try_real_mode:
 hcall_real_fallback:
 	li	r12,BOOK3S_INTERRUPT_SYSCALL
 	ld	r9, HSTATE_KVM_VCPU(r13)
-	ld	r11, VCPU_MSR(r9)
 
 	b	hcall_real_cont
 
@@ -1142,7 +1193,7 @@ hcall_real_table:
 	.long	0		/* 0xd4 */
 	.long	0		/* 0xd8 */
 	.long	0		/* 0xdc */
-	.long	0		/* 0xe0 */
+	.long	.kvmppc_h_cede - hcall_real_table
 	.long	0		/* 0xe4 */
 	.long	0		/* 0xe8 */
 	.long	0		/* 0xec */
@@ -1171,7 +1222,8 @@ bounce_ext_interrupt:
 	mtspr	SPRN_SRR0,r10
 	mtspr	SPRN_SRR1,r11
 	li	r10,BOOK3S_INTERRUPT_EXTERNAL
-	LOAD_REG_IMMEDIATE(r11,MSR_SF | MSR_ME);
+	li	r11,(MSR_ME << 1) | 1	/* synthesize MSR_SF | MSR_ME */
+	rotldi	r11,r11,63
 	b	fast_guest_return
 
 _GLOBAL(kvmppc_h_set_dabr)
@@ -1180,6 +1232,178 @@ _GLOBAL(kvmppc_h_set_dabr)
 	li	r3,0
 	blr
 
+_GLOBAL(kvmppc_h_cede)
+	ori	r11,r11,MSR_EE
+	std	r11,VCPU_MSR(r3)
+	li	r0,1
+	stb	r0,VCPU_CEDED(r3)
+	sync			/* order setting ceded vs. testing prodded */
+	lbz	r5,VCPU_PRODDED(r3)
+	cmpwi	r5,0
+	bne	1f
+	li	r0,0		/* set trap to 0 to say hcall is handled */
+	stw	r0,VCPU_TRAP(r3)
+	li	r0,H_SUCCESS
+	std	r0,VCPU_GPR(r3)(r3)
+BEGIN_FTR_SECTION
+	b	2f		/* just send it up to host on 970 */
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_206)
+
+	/*
+	 * Set our bit in the bitmask of napping threads unless all the
+	 * other threads are already napping, in which case we send this
+	 * up to the host.
+	 */
+	ld	r5,HSTATE_KVM_VCORE(r13)
+	lwz	r6,VCPU_PTID(r3)
+	lwz	r8,VCORE_ENTRY_EXIT(r5)
+	clrldi	r8,r8,56
+	li	r0,1
+	sld	r0,r0,r6
+	addi	r6,r5,VCORE_NAPPING_THREADS
+31:	lwarx	r4,0,r6
+	or	r4,r4,r0
+	popcntw	r7,r4
+	cmpw	r7,r8
+	bge	2f
+	stwcx.	r4,0,r6
+	bne	31b
+	li	r0,1
+	stb	r0,HSTATE_NAPPING(r13)
+	/* order napping_threads update vs testing entry_exit_count */
+	lwsync
+	mr	r4,r3
+	lwz	r7,VCORE_ENTRY_EXIT(r5)
+	cmpwi	r7,0x100
+	bge	33f		/* another thread already exiting */
+
+/*
+ * Although not specifically required by the architecture, POWER7
+ * preserves the following registers in nap mode, even if an SMT mode
+ * switch occurs: SLB entries, PURR, SPURR, AMOR, UAMOR, AMR, SPRG0-3,
+ * DAR, DSISR, DABR, DABRX, DSCR, PMCx, MMCRx, SIAR, SDAR.
+ */
+	/* Save non-volatile GPRs */
+	std	r14, VCPU_GPR(r14)(r3)
+	std	r15, VCPU_GPR(r15)(r3)
+	std	r16, VCPU_GPR(r16)(r3)
+	std	r17, VCPU_GPR(r17)(r3)
+	std	r18, VCPU_GPR(r18)(r3)
+	std	r19, VCPU_GPR(r19)(r3)
+	std	r20, VCPU_GPR(r20)(r3)
+	std	r21, VCPU_GPR(r21)(r3)
+	std	r22, VCPU_GPR(r22)(r3)
+	std	r23, VCPU_GPR(r23)(r3)
+	std	r24, VCPU_GPR(r24)(r3)
+	std	r25, VCPU_GPR(r25)(r3)
+	std	r26, VCPU_GPR(r26)(r3)
+	std	r27, VCPU_GPR(r27)(r3)
+	std	r28, VCPU_GPR(r28)(r3)
+	std	r29, VCPU_GPR(r29)(r3)
+	std	r30, VCPU_GPR(r30)(r3)
+	std	r31, VCPU_GPR(r31)(r3)
+
+	/* save FP state */
+	bl	.kvmppc_save_fp
+
+	/*
+	 * Take a nap until a decrementer or external interrupt occurs,
+	 * with PECE1 (wake on decr) and PECE0 (wake on external) set in LPCR
+	 */
+	li	r0,0x80
+	stb	r0,PACAPROCSTART(r13)
+	mfspr	r5,SPRN_LPCR
+	ori	r5,r5,LPCR_PECE0 | LPCR_PECE1
+	mtspr	SPRN_LPCR,r5
+	isync
+	li	r0, 0
+	std	r0, HSTATE_SCRATCH0(r13)
+	ptesync
+	ld	r0, HSTATE_SCRATCH0(r13)
+1:	cmpd	r0, r0
+	bne	1b
+	nap
+	b	.
+
+kvm_end_cede:
+	/* Woken by external or decrementer interrupt */
+	ld	r1, HSTATE_HOST_R1(r13)
+	ld	r2, PACATOC(r13)
+
+	/* If we're a secondary thread and we got here by an IPI, ack it */
+	ld	r4,HSTATE_KVM_VCPU(r13)
+	lwz	r3,VCPU_PTID(r4)
+	cmpwi	r3,0
+	beq	27f
+	mfspr	r3,SPRN_SRR1
+	rlwinm	r3,r3,44-31,0x7		/* extract wake reason field */
+	cmpwi	r3,4			/* was it an external interrupt? */
+	bne	27f
+	ld	r5, HSTATE_XICS_PHYS(r13)
+	li	r0,0xff
+	li	r6,XICS_QIRR
+	li	r7,XICS_XIRR
+	lwzcix	r8,r5,r7		/* ack the interrupt */
+	sync
+	stbcix	r0,r5,r6		/* clear it */
+	stwcix	r8,r5,r7		/* EOI it */
+27:
+	/* load up FP state */
+	bl	kvmppc_load_fp
+
+	/* Load NV GPRS */
+	ld	r14, VCPU_GPR(r14)(r4)
+	ld	r15, VCPU_GPR(r15)(r4)
+	ld	r16, VCPU_GPR(r16)(r4)
+	ld	r17, VCPU_GPR(r17)(r4)
+	ld	r18, VCPU_GPR(r18)(r4)
+	ld	r19, VCPU_GPR(r19)(r4)
+	ld	r20, VCPU_GPR(r20)(r4)
+	ld	r21, VCPU_GPR(r21)(r4)
+	ld	r22, VCPU_GPR(r22)(r4)
+	ld	r23, VCPU_GPR(r23)(r4)
+	ld	r24, VCPU_GPR(r24)(r4)
+	ld	r25, VCPU_GPR(r25)(r4)
+	ld	r26, VCPU_GPR(r26)(r4)
+	ld	r27, VCPU_GPR(r27)(r4)
+	ld	r28, VCPU_GPR(r28)(r4)
+	ld	r29, VCPU_GPR(r29)(r4)
+	ld	r30, VCPU_GPR(r30)(r4)
+	ld	r31, VCPU_GPR(r31)(r4)
+
+	/* clear our bit in vcore->napping_threads */
+33:	ld	r5,HSTATE_KVM_VCORE(r13)
+	lwz	r3,VCPU_PTID(r4)
+	li	r0,1
+	sld	r0,r0,r3
+	addi	r6,r5,VCORE_NAPPING_THREADS
+32:	lwarx	r7,0,r6
+	andc	r7,r7,r0
+	stwcx.	r7,0,r6
+	bne	32b
+	li	r0,0
+	stb	r0,HSTATE_NAPPING(r13)
+
+	/* see if any other thread is already exiting */
+	lwz	r0,VCORE_ENTRY_EXIT(r5)
+	cmpwi	r0,0x100
+	blt	kvmppc_cede_reentry	/* if not go back to guest */
+
+	/* some threads are exiting, so go to the guest exit path */
+	b	hcall_real_fallback
+
+	/* cede when already previously prodded case */
+1:	li	r0,0
+	stb	r0,VCPU_PRODDED(r3)
+	sync			/* order testing prodded vs. clearing ceded */
+	stb	r0,VCPU_CEDED(r3)
+	li	r3,H_SUCCESS
+	blr
+
+	/* we've ceded but we want to give control to the host */
+2:	li	r3,H_TOO_HARD
+	blr
+
 secondary_too_late:
 	ld	r5,HSTATE_KVM_VCORE(r13)
 	HMT_LOW
@@ -1197,14 +1421,20 @@ secondary_too_late:
 	slbmte	r6,r5
 1:	addi	r11,r11,16
 	.endr
-	b	50f
 
 secondary_nap:
-	/* Clear any pending IPI */
-50:	ld	r5, HSTATE_XICS_PHYS(r13)
+	/* Clear any pending IPI - assume we're a secondary thread */
+	ld	r5, HSTATE_XICS_PHYS(r13)
+	li	r7, XICS_XIRR
+	lwzcix	r3, r5, r7		/* ack any pending interrupt */
+	rlwinm.	r0, r3, 0, 0xffffff	/* any pending? */
+	beq	37f
+	sync
 	li	r0, 0xff
 	li	r6, XICS_QIRR
-	stbcix	r0, r5, r6
+	stbcix	r0, r5, r6		/* clear the IPI */
+	stwcix	r3, r5, r7		/* EOI it */
+37:	sync
 
 	/* increment the nap count and then go to nap mode */
 	ld	r4, HSTATE_KVM_VCORE(r13)
@@ -1214,13 +1444,12 @@ secondary_nap:
 	addi	r3, r3, 1
 	stwcx.	r3, 0, r4
 	bne	51b
-	isync
 
+	li	r3, LPCR_PECE0
 	mfspr	r4, SPRN_LPCR
-	li	r0, LPCR_PECE
-	andc	r4, r4, r0
-	ori	r4, r4, LPCR_PECE0	/* exit nap on interrupt */
+	rlwimi	r4, r3, 0, LPCR_PECE0 | LPCR_PECE1
 	mtspr	SPRN_LPCR, r4
+	isync
 	li	r0, 0
 	std	r0, HSTATE_SCRATCH0(r13)
 	ptesync
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index a107c9b..cd0e3e5 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -39,12 +39,8 @@
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
-#ifndef CONFIG_KVM_BOOK3S_64_HV
 	return !(v->arch.shared->msr & MSR_WE) ||
 	       !!(v->arch.pending_exceptions);
-#else
-	return !(v->arch.ceded) || !!(v->arch.pending_exceptions);
-#endif
 }
 
 int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
@@ -258,6 +254,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	struct kvm_vcpu *vcpu;
 	vcpu = kvmppc_core_vcpu_create(kvm, id);
+	vcpu->arch.wqp = &vcpu->wq;
 	if (!IS_ERR(vcpu))
 		kvmppc_create_vcpu_debugfs(vcpu, id);
 	return vcpu;
@@ -289,8 +286,8 @@ static void kvmppc_decrementer_func(unsigned long data)
 
 	kvmppc_core_queue_dec(vcpu);
 
-	if (waitqueue_active(&vcpu->wq)) {
-		wake_up_interruptible(&vcpu->wq);
+	if (waitqueue_active(vcpu->arch.wqp)) {
+		wake_up_interruptible(vcpu->arch.wqp);
 		vcpu->stat.halt_wakeup++;
 	}
 }
@@ -543,13 +540,15 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
 {
-	if (irq->irq == KVM_INTERRUPT_UNSET)
+	if (irq->irq == KVM_INTERRUPT_UNSET) {
 		kvmppc_core_dequeue_external(vcpu, irq);
-	else
-		kvmppc_core_queue_external(vcpu, irq);
+		return 0;
+	}
+
+	kvmppc_core_queue_external(vcpu, irq);
 
-	if (waitqueue_active(&vcpu->wq)) {
-		wake_up_interruptible(&vcpu->wq);
+	if (waitqueue_active(vcpu->arch.wqp)) {
+		wake_up_interruptible(vcpu->arch.wqp);
 		vcpu->stat.halt_wakeup++;
 	} else if (vcpu->cpu != -1) {
 		smp_send_reschedule(vcpu->cpu);
-- 
1.7.5.4
