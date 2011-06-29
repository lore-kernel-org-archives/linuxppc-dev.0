Return-Path: <paulus@ozlabs.org>
Date: Wed, 29 Jun 2011 20:23:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
Subject: [PATCH 13/17] KVM: PPC: Allow book3s_hv guests to use SMT processor
	modes
Message-ID: <20110629102307.GN25406@bloggs.ozlabs.ibm.com>
References: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110629101552.GA25406@bloggs.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This lifts the restriction that book3s_hv guests can only run one
hardware thread per core, and allows them to use up to 4 threads
per core on POWER7.  The host still has to run single-threaded.

This capability is advertised to qemu through a new KVM_CAP_PPC_SMT
capability.  The return value of the ioctl querying this capability
is the number of vcpus per virtual CPU core (vcore), currently 4.

To use this, the host kernel should be booted with all threads
active, and then all the secondary threads should be offlined.
This will put the secondary threads into nap mode.  KVM will then
wake them from nap mode and use them for running guest code (while
they are still offline).  To wake the secondary threads, we send
them an IPI using a new xics_wake_cpu() function, implemented in
arch/powerpc/sysdev/xics/icp-native.c.  In other words, at this stage
we assume that the platform has a XICS interrupt controller and
we are using icp-native.c to drive it.  Since the woken thread will
need to acknowledge and clear the IPI, we also export the base
physical address of the XICS registers using kvmppc_set_xics_phys()
for use in the low-level KVM book3s code.

When a vcpu is created, it is assigned to a virtual CPU core.
The vcore number is obtained by dividing the vcpu number by the
number of threads per core in the host.  This number is exported
to userspace via the KVM_CAP_PPC_SMT capability.  If qemu wishes
to run the guest in single-threaded mode, it should make all vcpu
numbers be multiples of the number of threads per core.

We distinguish three states of a vcpu: runnable (i.e., ready to execute
the guest), blocked (that is, idle), and busy in host.  We currently
implement a policy that the vcore can run only when all its threads
are runnable or blocked.  This way, if a vcpu needs to execute elsewhere
in the kernel or in qemu, it can do so without being starved of CPU
by the other vcpus.

When a vcore starts to run, it executes in the context of one of the
vcpu threads.  The other vcpu threads all go to sleep and stay asleep
until something happens requiring the vcpu thread to return to qemu,
or to wake up to run the vcore (this can happen when another vcpu
thread goes from busy in host state to blocked).

It can happen that a vcpu goes from blocked to runnable state (e.g.
because of an interrupt), and the vcore it belongs to is already
running.  In that case it can start to run immediately as long as
the none of the vcpus in the vcore have started to exit the guest.
We send the next free thread in the vcore an IPI to get it to start
to execute the guest.  It synchronizes with the other threads via
the vcore->entry_exit_count field to make sure that it doesn't go
into the guest if the other vcpus are exiting by the time that it
is ready to actually enter the guest.

Note that there is no fixed relationship between the hardware thread
number and the vcpu number.  Hardware threads are assigned to vcpus
as they become runnable, so we will always use the lower-numbered
hardware threads in preference to higher-numbered threads if not all
the vcpus in the vcore are runnable, regardless of which vcpus are
runnable.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 Documentation/virtual/kvm/api.txt         |   13 ++
 arch/powerpc/include/asm/kvm.h            |    1 +
 arch/powerpc/include/asm/kvm_book3s_asm.h |    2 +
 arch/powerpc/include/asm/kvm_host.h       |   46 ++++-
 arch/powerpc/include/asm/kvm_ppc.h        |   13 ++
 arch/powerpc/kernel/asm-offsets.c         |    6 +
 arch/powerpc/kernel/exceptions-64s.S      |   31 ++-
 arch/powerpc/kernel/idle_power7.S         |    2 -
 arch/powerpc/kvm/book3s_hv.c              |  316 ++++++++++++++++++++++++++---
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  168 +++++++++++++++-
 arch/powerpc/kvm/powerpc.c                |    4 +
 arch/powerpc/sysdev/xics/icp-native.c     |    9 +
 include/linux/kvm.h                       |    1 +
 13 files changed, 567 insertions(+), 45 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index a1d344d..6818713 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -180,6 +180,19 @@ KVM_CHECK_EXTENSION ioctl() to determine the value for max_vcpus at run-time.
 If the KVM_CAP_NR_VCPUS does not exist, you should assume that max_vcpus is 4
 cpus max.
 
+On powerpc using book3s_hv mode, the vcpus are mapped onto virtual
+threads in one or more virtual CPU cores.  (This is because the
+hardware requires all the hardware threads in a CPU core to be in the
+same partition.)  The KVM_CAP_PPC_SMT capability indicates the number
+of vcpus per virtual core (vcore).  The vcore id is obtained by
+dividing the vcpu id by the number of vcpus per vcore.  The vcpus in a
+given vcore will always be in the same physical core as each other
+(though that might be a different physical core from time to time).
+Userspace can control the threading (SMT) mode of the guest by its
+allocation of vcpu ids.  For example, if userspace wants
+single-threaded guest vcpus, it should make all vcpu ids be a multiple
+of the number of vcpus per vcore.
+
 4.8 KVM_GET_DIRTY_LOG (vm ioctl)
 
 Capability: basic
diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/asm/kvm.h
index c3ec990..471bb3d 100644
--- a/arch/powerpc/include/asm/kvm.h
+++ b/arch/powerpc/include/asm/kvm.h
@@ -24,6 +24,7 @@
 
 /* Select powerpc specific features in <linux/kvm.h> */
 #define __KVM_HAVE_SPAPR_TCE
+#define __KVM_HAVE_PPC_SMT
 
 struct kvm_regs {
 	__u64 pc;
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index b7b0395..9cfd543 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -78,6 +78,8 @@ struct kvmppc_host_state {
 
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	struct kvm_vcpu *kvm_vcpu;
+	struct kvmppc_vcore *kvm_vcore;
+	unsigned long xics_phys;
 	u64 dabr;
 	u64 host_mmcr[3];
 	u32 host_pmc[6];
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 5616e39..0d6d569 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -25,10 +25,14 @@
 #include <linux/interrupt.h>
 #include <linux/types.h>
 #include <linux/kvm_types.h>
+#include <linux/threads.h>
+#include <linux/spinlock.h>
 #include <linux/kvm_para.h>
 #include <asm/kvm_asm.h>
+#include <asm/processor.h>
 
-#define KVM_MAX_VCPUS 1
+#define KVM_MAX_VCPUS		NR_CPUS
+#define KVM_MAX_VCORES		NR_CPUS
 #define KVM_MEMORY_SLOTS 32
 /* memory slots that does not exposed to userspace */
 #define KVM_PRIVATE_MEM_SLOTS 4
@@ -167,9 +171,34 @@ struct kvm_arch {
 	int tlbie_lock;
 	struct list_head spapr_tce_tables;
 	unsigned short last_vcpu[NR_CPUS];
+	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
 #endif /* CONFIG_KVM_BOOK3S_64_HV */
 };
 
+/*
+ * Struct for a virtual core.
+ * Note: entry_exit_count combines an entry count in the bottom 8 bits
+ * and an exit count in the next 8 bits.  This is so that we can
+ * atomically increment the entry count iff the exit count is 0
+ * without taking the lock.
+ */
+struct kvmppc_vcore {
+	int n_runnable;
+	int n_blocked;
+	int num_threads;
+	int entry_exit_count;
+	int n_woken;
+	int nap_count;
+	u16 pcpu;
+	u8 vcore_running;
+	u8 in_guest;
+	struct list_head runnable_threads;
+	spinlock_t lock;
+};
+
+#define VCORE_ENTRY_COUNT(vc)	((vc)->entry_exit_count & 0xff)
+#define VCORE_EXIT_COUNT(vc)	((vc)->entry_exit_count >> 8)
+
 struct kvmppc_pte {
 	ulong eaddr;
 	u64 vpage;
@@ -365,14 +394,29 @@ struct kvm_vcpu_arch {
 	struct slb_shadow *slb_shadow;
 	struct dtl *dtl;
 	struct dtl *dtl_end;
+
+	struct kvmppc_vcore *vcore;
+	int ret;
 	int trap;
+	int state;
+	int ptid;
+	wait_queue_head_t cpu_run;
+
 	struct kvm_vcpu_arch_shared *shared;
 	unsigned long magic_page_pa; /* phys addr to map the magic page to */
 	unsigned long magic_page_ea; /* effect. addr to map the magic page to */
 
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	struct kvm_vcpu_arch_shared shregs;
+
+	struct list_head run_list;
+	struct task_struct *run_task;
+	struct kvm_run *kvm_run;
 #endif
 };
 
+#define KVMPPC_VCPU_BUSY_IN_HOST	0
+#define KVMPPC_VCPU_BLOCKED		1
+#define KVMPPC_VCPU_RUNNABLE		2
+
 #endif /* __POWERPC_KVM_HOST_H__ */
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 99f6fcf..6ef7344 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -33,6 +33,9 @@
 #else
 #include <asm/kvm_booke.h>
 #endif
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+#include <asm/paca.h>
+#endif
 
 enum emulation_result {
 	EMULATE_DONE,         /* no further processing */
@@ -169,4 +172,14 @@ int kvmppc_set_sregs_ivor(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs);
 
 void kvmppc_set_pid(struct kvm_vcpu *vcpu, u32 pid);
 
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
+{
+	paca[cpu].kvm_hstate.xics_phys = addr;
+}
+#else
+static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
+{}
+#endif
+
 #endif /* __POWERPC_KVM_PPC_H__ */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index c70d106..d0f2387f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -471,6 +471,10 @@ int main(void)
 	DEFINE(VCPU_FAULT_DAR, offsetof(struct kvm_vcpu, arch.fault_dar));
 	DEFINE(VCPU_LAST_INST, offsetof(struct kvm_vcpu, arch.last_inst));
 	DEFINE(VCPU_TRAP, offsetof(struct kvm_vcpu, arch.trap));
+	DEFINE(VCPU_PTID, offsetof(struct kvm_vcpu, arch.ptid));
+	DEFINE(VCORE_ENTRY_EXIT, offsetof(struct kvmppc_vcore, entry_exit_count));
+	DEFINE(VCORE_NAP_COUNT, offsetof(struct kvmppc_vcore, nap_count));
+	DEFINE(VCORE_IN_GUEST, offsetof(struct kvmppc_vcore, in_guest));
 	DEFINE(VCPU_SVCPU, offsetof(struct kvmppc_vcpu_book3s, shadow_vcpu) -
 			   offsetof(struct kvmppc_vcpu_book3s, vcpu));
 	DEFINE(VCPU_SLB_E, offsetof(struct kvmppc_slb, orige));
@@ -530,6 +534,8 @@ int main(void)
 
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	HSTATE_FIELD(HSTATE_KVM_VCPU, kvm_vcpu);
+	HSTATE_FIELD(HSTATE_KVM_VCORE, kvm_vcore);
+	HSTATE_FIELD(HSTATE_XICS_PHYS, xics_phys);
 	HSTATE_FIELD(HSTATE_MMCR, host_mmcr);
 	HSTATE_FIELD(HSTATE_PMC, host_pmc);
 	HSTATE_FIELD(HSTATE_PURR, host_purr);
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 163c041..5bc06fd 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -49,19 +49,32 @@ BEGIN_FTR_SECTION
 	 * state loss at this time.
 	 */
 	mfspr	r13,SPRN_SRR1
-	rlwinm	r13,r13,47-31,30,31
-	cmpwi	cr0,r13,1
-	bne	1f
-	b	.power7_wakeup_noloss
-1:	cmpwi	cr0,r13,2
-	bne	1f
-	b	.power7_wakeup_loss
+	rlwinm.	r13,r13,47-31,30,31
+	beq	9f
+
+	/* waking up from powersave (nap) state */
+	cmpwi	cr1,r13,2
 	/* Total loss of HV state is fatal, we could try to use the
 	 * PIR to locate a PACA, then use an emergency stack etc...
 	 * but for now, let's just stay stuck here
 	 */
-1:	cmpwi	cr0,r13,3
-	beq	.
+	bgt	cr1,.
+	GET_PACA(r13)
+
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	lbz	r0,PACAPROCSTART(r13)
+	cmpwi	r0,0x80
+	bne	1f
+	li	r0,0
+	stb	r0,PACAPROCSTART(r13)
+	b	kvm_start_guest
+1:
+#endif
+
+	beq	cr1,2f
+	b	.power7_wakeup_noloss
+2:	b	.power7_wakeup_loss
+9:
 END_FTR_SECTION_IFSET(CPU_FTR_HVMODE_206)
 #endif /* CONFIG_PPC_P7_NAP */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
index f8f0bc7..3a70845 100644
--- a/arch/powerpc/kernel/idle_power7.S
+++ b/arch/powerpc/kernel/idle_power7.S
@@ -73,7 +73,6 @@ _GLOBAL(power7_idle)
 	b	.
 
 _GLOBAL(power7_wakeup_loss)
-	GET_PACA(r13)
 	ld	r1,PACAR1(r13)
 	REST_NVGPRS(r1)
 	REST_GPR(2, r1)
@@ -87,7 +86,6 @@ _GLOBAL(power7_wakeup_loss)
 	rfid
 
 _GLOBAL(power7_wakeup_noloss)
-	GET_PACA(r13)
 	ld	r1,PACAR1(r13)
 	ld	r4,_MSR(r1)
 	ld	r5,_NIP(r1)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 6fe469e..36b6d98 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -39,6 +39,7 @@
 #include <asm/mmu_context.h>
 #include <asm/lppaca.h>
 #include <asm/processor.h>
+#include <asm/cputhreads.h>
 #include <linux/gfp.h>
 #include <linux/sched.h>
 #include <linux/vmalloc.h>
@@ -51,12 +52,16 @@
 void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	local_paca->kvm_hstate.kvm_vcpu = vcpu;
+	local_paca->kvm_hstate.kvm_vcore = vcpu->arch.vcore;
 }
 
 void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 {
 }
 
+static void kvmppc_vcpu_blocked(struct kvm_vcpu *vcpu);
+static void kvmppc_vcpu_unblocked(struct kvm_vcpu *vcpu);
+
 void kvmppc_vcpu_block(struct kvm_vcpu *vcpu)
 {
 	u64 now;
@@ -74,11 +79,15 @@ void kvmppc_vcpu_block(struct kvm_vcpu *vcpu)
 			      HRTIMER_MODE_REL);
 	}
 
+	kvmppc_vcpu_blocked(vcpu);
+
 	kvm_vcpu_block(vcpu);
 	vcpu->stat.halt_wakeup++;
 
 	if (vcpu->arch.dec_expires != ~(u64)0)
 		hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
+
+	kvmppc_vcpu_unblocked(vcpu);
 }
 
 void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
@@ -429,9 +438,16 @@ int kvmppc_core_check_processor_compat(void)
 struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	struct kvm_vcpu *vcpu;
-	int err = -ENOMEM;
+	int err = -EINVAL;
+	int core;
+	struct kvmppc_vcore *vcore;
 	unsigned long lpcr;
 
+	core = id / threads_per_core;
+	if (core >= KVM_MAX_VCORES)
+		goto out;
+
+	err = -ENOMEM;
 	vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
 	if (!vcpu)
 		goto out;
@@ -454,6 +470,38 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 
 	kvmppc_mmu_book3s_hv_init(vcpu);
 
+	/*
+	 * Some vcpus may start out in stopped state.  If we initialize
+	 * them to busy-in-host state they will stop other vcpus in the
+	 * vcore from running.  Instead we initialize them to blocked
+	 * state, effectively considering them to be stopped until we
+	 * see the first run ioctl for them.
+	 */
+	vcpu->arch.state = KVMPPC_VCPU_BLOCKED;
+
+	init_waitqueue_head(&vcpu->arch.cpu_run);
+
+	mutex_lock(&kvm->lock);
+	vcore = kvm->arch.vcores[core];
+	if (!vcore) {
+		vcore = kzalloc(sizeof(struct kvmppc_vcore), GFP_KERNEL);
+		if (vcore) {
+			INIT_LIST_HEAD(&vcore->runnable_threads);
+			spin_lock_init(&vcore->lock);
+		}
+		kvm->arch.vcores[core] = vcore;
+	}
+	mutex_unlock(&kvm->lock);
+
+	if (!vcore)
+		goto free_vcpu;
+
+	spin_lock(&vcore->lock);
+	++vcore->num_threads;
+	++vcore->n_blocked;
+	spin_unlock(&vcore->lock);
+	vcpu->arch.vcore = vcore;
+
 	return vcpu;
 
 free_vcpu:
@@ -468,21 +516,121 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
 	kfree(vcpu);
 }
 
+static void kvmppc_vcpu_blocked(struct kvm_vcpu *vcpu)
+{
+	struct kvmppc_vcore *vc = vcpu->arch.vcore;
+
+	spin_lock(&vc->lock);
+	vcpu->arch.state = KVMPPC_VCPU_BLOCKED;
+	++vc->n_blocked;
+	if (vc->n_runnable > 0 &&
+	    vc->n_runnable + vc->n_blocked == vc->num_threads) {
+		vcpu = list_first_entry(&vc->runnable_threads, struct kvm_vcpu,
+					arch.run_list);
+		wake_up(&vcpu->arch.cpu_run);
+	}
+	spin_unlock(&vc->lock);
+}
+
+static void kvmppc_vcpu_unblocked(struct kvm_vcpu *vcpu)
+{
+	struct kvmppc_vcore *vc = vcpu->arch.vcore;
+
+	spin_lock(&vc->lock);
+	vcpu->arch.state = KVMPPC_VCPU_BUSY_IN_HOST;
+	--vc->n_blocked;
+	spin_unlock(&vc->lock);
+}
+
 extern int __kvmppc_vcore_entry(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
+extern void xics_wake_cpu(int cpu);
 
-static int kvmppc_run_vcpu(struct kvm_run *run, struct kvm_vcpu *vcpu)
+static void kvmppc_remove_runnable(struct kvmppc_vcore *vc,
+				   struct kvm_vcpu *vcpu)
 {
-	u64 now;
+	struct kvm_vcpu *v;
 
-	if (signal_pending(current)) {
-		run->exit_reason = KVM_EXIT_INTR;
-		return -EINTR;
+	if (vcpu->arch.state != KVMPPC_VCPU_RUNNABLE)
+		return;
+	vcpu->arch.state = KVMPPC_VCPU_BUSY_IN_HOST;
+	--vc->n_runnable;
+	/* decrement the physical thread id of each following vcpu */
+	v = vcpu;
+	list_for_each_entry_continue(v, &vc->runnable_threads, arch.run_list)
+		--v->arch.ptid;
+	list_del(&vcpu->arch.run_list);
+}
+
+static void kvmppc_start_thread(struct kvm_vcpu *vcpu)
+{
+	int cpu;
+	struct paca_struct *tpaca;
+	struct kvmppc_vcore *vc = vcpu->arch.vcore;
+
+	cpu = vc->pcpu + vcpu->arch.ptid;
+	tpaca = &paca[cpu];
+	tpaca->kvm_hstate.kvm_vcpu = vcpu;
+	tpaca->kvm_hstate.kvm_vcore = vc;
+	smp_wmb();
+#ifdef CONFIG_PPC_ICP_NATIVE
+	if (vcpu->arch.ptid) {
+		tpaca->cpu_start = 0x80;
+		tpaca->kvm_hstate.in_guest = KVM_GUEST_MODE_GUEST;
+		wmb();
+		xics_wake_cpu(cpu);
+		++vc->n_woken;
 	}
+#endif
+}
 
-	flush_fp_to_thread(current);
-	flush_altivec_to_thread(current);
-	flush_vsx_to_thread(current);
-	preempt_disable();
+static void kvmppc_wait_for_nap(struct kvmppc_vcore *vc)
+{
+	int i;
+
+	HMT_low();
+	i = 0;
+	while (vc->nap_count < vc->n_woken) {
+		if (++i >= 1000000) {
+			pr_err("kvmppc_wait_for_nap timeout %d %d\n",
+			       vc->nap_count, vc->n_woken);
+			break;
+		}
+		cpu_relax();
+	}
+	HMT_medium();
+}
+
+/*
+ * Check that we are on thread 0 and that any other threads in
+ * this core are off-line.
+ */
+static int on_primary_thread(void)
+{
+	int cpu = smp_processor_id();
+	int thr = cpu_thread_in_core(cpu);
+
+	if (thr)
+		return 0;
+	while (++thr < threads_per_core)
+		if (cpu_online(cpu + thr))
+			return 0;
+	return 1;
+}
+
+/*
+ * Run a set of guest threads on a physical core.
+ * Called with vc->lock held.
+ */
+static int kvmppc_run_core(struct kvmppc_vcore *vc)
+{
+	struct kvm_vcpu *vcpu, *vnext;
+	long ret;
+	u64 now;
+
+	/* don't start if any threads have a signal pending */
+	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list)
+		if (signal_pending(vcpu->arch.run_task))
+			return 0;
 
 	/*
 	 * Make sure we are running on thread 0, and that
@@ -490,36 +638,150 @@ static int kvmppc_run_vcpu(struct kvm_run *run, struct kvm_vcpu *vcpu)
 	 * XXX we should also block attempts to bring any
 	 * secondary threads online.
 	 */
-	if (threads_per_core > 1) {
-		int cpu = smp_processor_id();
-		int thr = cpu_thread_in_core(cpu);
-
-		if (thr)
-			goto out;
-		while (++thr < threads_per_core)
-			if (cpu_online(cpu + thr))
-				goto out;
+	if (threads_per_core > 1 && !on_primary_thread()) {
+		list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list)
+			vcpu->arch.ret = -EBUSY;
+		goto out;
 	}
 
-	kvm_guest_enter();
+	vc->n_woken = 0;
+	vc->nap_count = 0;
+	vc->entry_exit_count = 0;
+	vc->vcore_running = 1;
+	vc->in_guest = 0;
+	vc->pcpu = smp_processor_id();
+	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list)
+		kvmppc_start_thread(vcpu);
+	vcpu = list_first_entry(&vc->runnable_threads, struct kvm_vcpu,
+				arch.run_list);
+
+	spin_unlock(&vc->lock);
 
+	preempt_disable();
+	kvm_guest_enter();
 	__kvmppc_vcore_entry(NULL, vcpu);
 
+	/* wait for secondary threads to finish writing their state to memory */
+	spin_lock(&vc->lock);
+	if (vc->nap_count < vc->n_woken)
+		kvmppc_wait_for_nap(vc);
+	/* prevent other vcpu threads from doing kvmppc_start_thread() now */
+	vc->vcore_running = 2;
+	spin_unlock(&vc->lock);
+
+	/* make sure updates to secondary vcpu structs are visible now */
+	smp_mb();
 	kvm_guest_exit();
 
 	preempt_enable();
 	kvm_resched(vcpu);
 
 	now = get_tb();
-	/* cancel pending dec exception if dec is positive */
-	if (now < vcpu->arch.dec_expires && kvmppc_core_pending_dec(vcpu))
-		kvmppc_core_dequeue_dec(vcpu);
-
-	return kvmppc_handle_exit(run, vcpu, current);
+	list_for_each_entry(vcpu, &vc->runnable_threads, arch.run_list) {
+		/* cancel pending dec exception if dec is positive */
+		if (now < vcpu->arch.dec_expires &&
+		    kvmppc_core_pending_dec(vcpu))
+			kvmppc_core_dequeue_dec(vcpu);
+		if (!vcpu->arch.trap) {
+			if (signal_pending(vcpu->arch.run_task)) {
+				vcpu->arch.kvm_run->exit_reason = KVM_EXIT_INTR;
+				vcpu->arch.ret = -EINTR;
+			}
+			continue;		/* didn't get to run */
+		}
+		ret = kvmppc_handle_exit(vcpu->arch.kvm_run, vcpu,
+					 vcpu->arch.run_task);
+		vcpu->arch.ret = ret;
+		vcpu->arch.trap = 0;
+	}
 
+	spin_lock(&vc->lock);
  out:
-	preempt_enable();
-	return -EBUSY;
+	vc->vcore_running = 0;
+	list_for_each_entry_safe(vcpu, vnext, &vc->runnable_threads,
+				 arch.run_list) {
+		if (vcpu->arch.ret != RESUME_GUEST) {
+			kvmppc_remove_runnable(vc, vcpu);
+			wake_up(&vcpu->arch.cpu_run);
+		}
+	}
+
+	return 1;
+}
+
+static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
+{
+	int ptid;
+	int wait_state;
+	struct kvmppc_vcore *vc;
+	DEFINE_WAIT(wait);
+
+	/* No need to go into the guest when all we do is going out */
+	if (signal_pending(current)) {
+		kvm_run->exit_reason = KVM_EXIT_INTR;
+		return -EINTR;
+	}
+
+	kvm_run->exit_reason = 0;
+	vcpu->arch.ret = RESUME_GUEST;
+	vcpu->arch.trap = 0;
+
+	flush_fp_to_thread(current);
+	flush_altivec_to_thread(current);
+	flush_vsx_to_thread(current);
+
+	/*
+	 * Synchronize with other threads in this virtual core
+	 */
+	vc = vcpu->arch.vcore;
+	spin_lock(&vc->lock);
+	/* This happens the first time this is called for a vcpu */
+	if (vcpu->arch.state == KVMPPC_VCPU_BLOCKED)
+		--vc->n_blocked;
+	vcpu->arch.state = KVMPPC_VCPU_RUNNABLE;
+	ptid = vc->n_runnable;
+	vcpu->arch.run_task = current;
+	vcpu->arch.kvm_run = kvm_run;
+	vcpu->arch.ptid = ptid;
+	list_add_tail(&vcpu->arch.run_list, &vc->runnable_threads);
+	++vc->n_runnable;
+
+	wait_state = TASK_INTERRUPTIBLE;
+	while (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE) {
+		if (signal_pending(current)) {
+			if (!vc->vcore_running) {
+				kvm_run->exit_reason = KVM_EXIT_INTR;
+				vcpu->arch.ret = -EINTR;
+				break;
+			}
+			/* have to wait for vcore to stop executing guest */
+			wait_state = TASK_UNINTERRUPTIBLE;
+			smp_send_reschedule(vc->pcpu);
+		}
+
+		if (!vc->vcore_running &&
+		    vc->n_runnable + vc->n_blocked == vc->num_threads) {
+			/* we can run now */
+			if (kvmppc_run_core(vc))
+				continue;
+		}
+
+		if (vc->vcore_running == 1 && VCORE_EXIT_COUNT(vc) == 0)
+			kvmppc_start_thread(vcpu);
+
+		/* wait for other threads to come in, or wait for vcore */
+		prepare_to_wait(&vcpu->arch.cpu_run, &wait, wait_state);
+		spin_unlock(&vc->lock);
+		schedule();
+		finish_wait(&vcpu->arch.cpu_run, &wait);
+		spin_lock(&vc->lock);
+	}
+
+	if (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE)
+		kvmppc_remove_runnable(vc, vcpu);
+	spin_unlock(&vc->lock);
+
+	return vcpu->arch.ret;
 }
 
 int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index e6adaad..c9bf177 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -30,8 +30,6 @@
  *                                                                           *
  ****************************************************************************/
 
-#define SHADOW_VCPU_OFF		PACA_KVM_SVCPU
-
 	.globl	kvmppc_skip_interrupt
 kvmppc_skip_interrupt:
 	mfspr	r13,SPRN_SRR0
@@ -79,6 +77,32 @@ _GLOBAL(kvmppc_hv_entry_trampoline)
  *                                                                            *
  *****************************************************************************/
 
+#define XICS_XIRR		4
+#define XICS_QIRR		0xc
+
+/*
+ * We come in here when wakened from nap mode on a secondary hw thread.
+ * Relocation is off and most register values are lost.
+ * r13 points to the PACA.
+ */
+	.globl	kvm_start_guest
+kvm_start_guest:
+	ld	r1,PACAEMERGSP(r13)
+	subi	r1,r1,STACK_FRAME_OVERHEAD
+
+	/* get vcpu pointer */
+	ld	r4, HSTATE_KVM_VCPU(r13)
+
+	/* We got here with an IPI; clear it */
+	ld	r5, HSTATE_XICS_PHYS(r13)
+	li	r0, 0xff
+	li	r6, XICS_QIRR
+	li	r7, XICS_XIRR
+	lwzcix	r8, r5, r7		/* ack the interrupt */
+	sync
+	stbcix	r0, r5, r6		/* clear it */
+	stwcix	r8, r5, r7		/* EOI it */
+
 .global kvmppc_hv_entry
 kvmppc_hv_entry:
 
@@ -200,7 +224,20 @@ kvmppc_hv_entry:
 	slbia
 	ptesync
 
-	/* Switch to guest partition. */
+	/* Increment entry count iff exit count is zero. */
+	ld	r5,HSTATE_KVM_VCORE(r13)
+	addi	r9,r5,VCORE_ENTRY_EXIT
+21:	lwarx	r3,0,r9
+	cmpwi	r3,0x100		/* any threads starting to exit? */
+	bge	secondary_too_late	/* if so we're too late to the party */
+	addi	r3,r3,1
+	stwcx.	r3,0,r9
+	bne	21b
+
+	/* Primary thread switches to guest partition. */
+	lwz	r6,VCPU_PTID(r4)
+	cmpwi	r6,0
+	bne	20f
 	ld	r9,VCPU_KVM(r4)		/* pointer to struct kvm */
 	ld	r6,KVM_SDR1(r9)
 	lwz	r7,KVM_LPID(r9)
@@ -210,7 +247,15 @@ kvmppc_hv_entry:
 	mtspr	SPRN_SDR1,r6		/* switch to partition page table */
 	mtspr	SPRN_LPID,r7
 	isync
-	ld	r8,VCPU_LPCR(r4)
+	li	r0,1
+	stb	r0,VCORE_IN_GUEST(r5)	/* signal secondaries to continue */
+	b	10f
+
+	/* Secondary threads wait for primary to have done partition switch */
+20:	lbz	r0,VCORE_IN_GUEST(r5)
+	cmpwi	r0,0
+	beq	20b
+10:	ld	r8,VCPU_LPCR(r4)
 	mtspr	SPRN_LPCR,r8
 	isync
 
@@ -225,10 +270,12 @@ kvmppc_hv_entry:
 	 * Invalidate the TLB if we could possibly have stale TLB
 	 * entries for this partition on this core due to the use
 	 * of tlbiel.
+	 * XXX maybe only need this on primary thread?
 	 */
 	ld	r9,VCPU_KVM(r4)		/* pointer to struct kvm */
 	lwz	r5,VCPU_VCPUID(r4)
 	lhz	r6,PACAPACAINDEX(r13)
+	rldimi	r6,r5,0,62		/* XXX map as if threads 1:1 p:v */
 	lhz	r8,VCPU_LAST_CPU(r4)
 	sldi	r7,r6,1			/* see if this is the same vcpu */
 	add	r7,r7,r9		/* as last ran on this pcpu */
@@ -512,8 +559,60 @@ hcall_real_cont:
 	ptesync
 
 hdec_soon:
-	/* Switch back to host partition */
+	/* Increment the threads-exiting-guest count in the 0xff00
+	   bits of vcore->entry_exit_count */
+	lwsync
+	ld	r5,HSTATE_KVM_VCORE(r13)
+	addi	r6,r5,VCORE_ENTRY_EXIT
+41:	lwarx	r3,0,r6
+	addi	r0,r3,0x100
+	stwcx.	r0,0,r6
+	bne	41b
+
+	/*
+	 * At this point we have an interrupt that we have to pass
+	 * up to the kernel or qemu; we can't handle it in real mode.
+	 * Thus we have to do a partition switch, so we have to
+	 * collect the other threads, if we are the first thread
+	 * to take an interrupt.  To do this, we set the HDEC to 0,
+	 * which causes an HDEC interrupt in all threads within 2ns
+	 * because the HDEC register is shared between all 4 threads.
+	 * However, we don't need to bother if this is an HDEC
+	 * interrupt, since the other threads will already be on their
+	 * way here in that case.
+	 */
+	cmpwi	r12,BOOK3S_INTERRUPT_HV_DECREMENTER
+	beq	40f
+	cmpwi	r3,0x100	/* Are we the first here? */
+	bge	40f
+	cmpwi	r3,1
+	ble	40f
+	li	r0,0
+	mtspr	SPRN_HDEC,r0
+40:
+
+	/* Secondary threads wait for primary to do partition switch */
 	ld	r4,VCPU_KVM(r9)		/* pointer to struct kvm */
+	ld	r5,HSTATE_KVM_VCORE(r13)
+	lwz	r3,VCPU_PTID(r9)
+	cmpwi	r3,0
+	beq	15f
+	HMT_LOW
+13:	lbz	r3,VCORE_IN_GUEST(r5)
+	cmpwi	r3,0
+	bne	13b
+	HMT_MEDIUM
+	b	16f
+
+	/* Primary thread waits for all the secondaries to exit guest */
+15:	lwz	r3,VCORE_ENTRY_EXIT(r5)
+	srwi	r0,r3,8
+	clrldi	r3,r3,56
+	cmpw	r3,r0
+	bne	15b
+	isync
+
+	/* Primary thread switches back to host partition */
 	ld	r6,KVM_HOST_SDR1(r4)
 	lwz	r7,KVM_HOST_LPID(r4)
 	li	r8,LPID_RSVD		/* switch to reserved LPID */
@@ -522,10 +621,12 @@ hdec_soon:
 	mtspr	SPRN_SDR1,r6		/* switch to partition page table */
 	mtspr	SPRN_LPID,r7
 	isync
+	li	r0,0
+	stb	r0,VCORE_IN_GUEST(r5)
 	lis	r8,0x7fff		/* MAX_INT@h */
 	mtspr	SPRN_HDEC,r8
 
-	ld	r8,KVM_HOST_LPCR(r4)
+16:	ld	r8,KVM_HOST_LPCR(r4)
 	mtspr	SPRN_LPCR,r8
 	isync
 
@@ -634,6 +735,11 @@ hdec_soon:
 	mr	r3, r9
 	bl	.kvmppc_save_fp
 
+	/* Secondary threads go off to take a nap */
+	lwz	r0,VCPU_PTID(r3)
+	cmpwi	r0,0
+	bne	secondary_nap
+
 	/*
 	 * Reload DEC.  HDEC interrupts were disabled when
 	 * we reloaded the host's LPCR value.
@@ -840,6 +946,56 @@ _GLOBAL(kvmppc_h_set_dabr)
 	li	r3,0
 	blr
 
+secondary_too_late:
+	ld	r5,HSTATE_KVM_VCORE(r13)
+	HMT_LOW
+13:	lbz	r3,VCORE_IN_GUEST(r5)
+	cmpwi	r3,0
+	bne	13b
+	HMT_MEDIUM
+	ld	r11,PACA_SLBSHADOWPTR(r13)
+
+	.rept	SLB_NUM_BOLTED
+	ld	r5,SLBSHADOW_SAVEAREA(r11)
+	ld	r6,SLBSHADOW_SAVEAREA+8(r11)
+	andis.	r7,r5,SLB_ESID_V@h
+	beq	1f
+	slbmte	r6,r5
+1:	addi	r11,r11,16
+	.endr
+	b	50f
+
+secondary_nap:
+	/* Clear any pending IPI */
+50:	ld	r5, HSTATE_XICS_PHYS(r13)
+	li	r0, 0xff
+	li	r6, XICS_QIRR
+	stbcix	r0, r5, r6
+
+	/* increment the nap count and then go to nap mode */
+	ld	r4, HSTATE_KVM_VCORE(r13)
+	addi	r4, r4, VCORE_NAP_COUNT
+	lwsync				/* make previous updates visible */
+51:	lwarx	r3, 0, r4
+	addi	r3, r3, 1
+	stwcx.	r3, 0, r4
+	bne	51b
+	isync
+
+	mfspr	r4, SPRN_LPCR
+	li	r0, LPCR_PECE
+	andc	r4, r4, r0
+	ori	r4, r4, LPCR_PECE0	/* exit nap on interrupt */
+	mtspr	SPRN_LPCR, r4
+	li	r0, 0
+	std	r0, HSTATE_SCRATCH0(r13)
+	ptesync
+	ld	r0, HSTATE_SCRATCH0(r13)
+1:	cmpd	r0, r0
+	bne	1b
+	nap
+	b	.
+
 /*
  * Save away FP, VMX and VSX registers.
  * r3 = vcpu pointer
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index c78ceb9..4c54966 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -30,6 +30,7 @@
 #include <asm/uaccess.h>
 #include <asm/kvm_ppc.h>
 #include <asm/tlbflush.h>
+#include <asm/cputhreads.h>
 #include "timing.h"
 #include "../mm/mmu_decl.h"
 
@@ -207,6 +208,9 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_SPAPR_TCE:
 		r = 1;
 		break;
+	case KVM_CAP_PPC_SMT:
+		r = threads_per_core;
+		break;
 #endif
 	default:
 		r = 0;
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index 1f15ad4..ba382b5 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -17,6 +17,7 @@
 #include <linux/cpu.h>
 #include <linux/of.h>
 #include <linux/spinlock.h>
+#include <linux/module.h>
 
 #include <asm/prom.h>
 #include <asm/io.h>
@@ -24,6 +25,7 @@
 #include <asm/irq.h>
 #include <asm/errno.h>
 #include <asm/xics.h>
+#include <asm/kvm_ppc.h>
 
 struct icp_ipl {
 	union {
@@ -139,6 +141,12 @@ static void icp_native_cause_ipi(int cpu, unsigned long data)
 	icp_native_set_qirr(cpu, IPI_PRIORITY);
 }
 
+void xics_wake_cpu(int cpu)
+{
+	icp_native_set_qirr(cpu, IPI_PRIORITY);
+}
+EXPORT_SYMBOL_GPL(xics_wake_cpu);
+
 static irqreturn_t icp_native_ipi_action(int irq, void *dev_id)
 {
 	int cpu = smp_processor_id();
@@ -185,6 +193,7 @@ static int __init icp_native_map_one_cpu(int hw_id, unsigned long addr,
 	}
 
 	icp_native_regs[cpu] = ioremap(addr, size);
+	kvmppc_set_xics_phys(cpu, addr);
 	if (!icp_native_regs[cpu]) {
 		pr_warning("icp_native: Failed ioremap for CPU %d, "
 			   "interrupt server #0x%x, addr %#lx\n",
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 61f5650..e2a378d 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -551,6 +551,7 @@ struct kvm_ppc_pvinfo {
 #define KVM_CAP_GET_TSC_KHZ 61
 #define KVM_CAP_PPC_BOOKE_SREGS 62
 #define KVM_CAP_SPAPR_TCE 63
+#define KVM_CAP_PPC_SMT 64
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.7.5.4
