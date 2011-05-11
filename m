Return-Path: <paulus@ozlabs.org>
Date: Wed, 11 May 2011 20:46:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org
Subject: [PATCH 13/13] kvm/powerpc: Allow book3s_hv guests to use SMT
	processor modes
Message-ID: <20110511104656.GN2837@brick.ozlabs.ibm.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110511103443.GA2837@brick.ozlabs.ibm.com>
Cc: Alexander Graf <agraf@suse.de>
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
capability.

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

When a vcpu is created, it is assigned to a virtual core (vcore).
The vcore number is obtained by dividing the vcpu number by 4,
since we assume at most 4 threads per core.  Thus, if qemu wishes
to run the guest in single-threaded mode, it should make all vcpu
numbers be multiples of 4.

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
 arch/powerpc/include/asm/kvm.h          |    1 +
 arch/powerpc/include/asm/kvm_host.h     |   45 +++++-
 arch/powerpc/include/asm/kvm_ppc.h      |   13 ++
 arch/powerpc/include/asm/paca.h         |    2 +
 arch/powerpc/kernel/asm-offsets.c       |    6 +
 arch/powerpc/kernel/exceptions-64s.S    |   31 +++-
 arch/powerpc/kernel/idle_power7.S       |    2 -
 arch/powerpc/kvm/Kconfig                |    2 +-
 arch/powerpc/kvm/book3s_hv.c            |  266 +++++++++++++++++++++++++++++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S |  157 ++++++++++++++++++-
 arch/powerpc/sysdev/xics/icp-native.c   |    7 +
 include/linux/kvm.h                     |    3 +
 12 files changed, 506 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/include/asm/kvm.h b/arch/powerpc/include/asm/kvm.h
index a9e641b..624c872 100644
--- a/arch/powerpc/include/asm/kvm.h
+++ b/arch/powerpc/include/asm/kvm.h
@@ -24,6 +24,7 @@
 
 /* Select powerpc specific features in <linux/kvm.h> */
 #define __KVM_HAVE_SPAPR_TCE
+#define __KVM_HAVE_PPC_SMT
 
 struct kvm_regs {
 	__u64 pc;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index cda183e..a2085da 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -25,10 +25,15 @@
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
+#define KVM_THREADS_PER_CORE	4
+#define KVM_MAX_VCORES		(KVM_MAX_VCPUS / KVM_THREADS_PER_CORE)
 #define KVM_MEMORY_SLOTS 32
 /* memory slots that does not exposed to userspace */
 #define KVM_PRIVATE_MEM_SLOTS 4
@@ -165,9 +170,36 @@ struct kvm_arch {
 	unsigned long host_sdr1;
 	int tlbie_lock;
 	unsigned short last_vcpu[NR_CPUS];
+	struct kvmppc_vcore *vcores[KVM_MAX_VCORES];
 	struct list_head spapr_tce_tables;
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
+	struct kvm_vcpu *runnable_threads[KVM_THREADS_PER_CORE];
+	struct task_struct *run_task[KVM_THREADS_PER_CORE];
+	struct kvm_run *kvm_run[KVM_THREADS_PER_CORE];
+	spinlock_t lock;
+};
+
+#define VCORE_ENTRY_COUNT(vc)	((vc)->entry_exit_count & 0xff)
+#define VCORE_EXIT_COUNT(vc)	((vc)->entry_exit_count >> 8)
+
 struct kvmppc_pte {
 	ulong eaddr;
 	u64 vpage;
@@ -362,10 +394,21 @@ struct kvm_vcpu_arch {
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
 };
 
+#define KVMPPC_VCPU_BUSY_IN_HOST	0
+#define KVMPPC_VCPU_BLOCKED		1
+#define KVMPPC_VCPU_RUNNABLE		2
+
 #endif /* __POWERPC_KVM_HOST_H__ */
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index de683fa..ed75975 100644
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
@@ -159,4 +162,14 @@ static inline u32 kvmppc_set_field(u64 inst, int msb, int lsb, int value)
 	return r;
 }
 
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
+{
+	paca[cpu].xics_phys = addr;
+}
+#else
+static inline void kvmppc_set_xics_phys(int cpu, unsigned long addr)
+{}
+#endif
+
 #endif /* __POWERPC_KVM_PPC_H__ */
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 8dba5f6..8b6628c 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -151,6 +151,8 @@ struct paca_struct {
 	struct kvmppc_book3s_shadow_vcpu shadow_vcpu;
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	struct kvm_vcpu *kvm_vcpu;
+	struct kvmppc_vcore *kvm_vcore;
+	unsigned long xics_phys;
 	u64 dabr;
 	u64 host_mmcr[3];
 	u32 host_pmc[6];
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index fd56f14..1fee2cf 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -204,12 +204,14 @@ int main(void)
 	DEFINE(PACA_KVM_SVCPU, offsetof(struct paca_struct, shadow_vcpu));
 #ifdef CONFIG_KVM_BOOK3S_64_HV
 	DEFINE(PACA_KVM_VCPU, offsetof(struct paca_struct, kvm_vcpu));
+	DEFINE(PACA_KVM_VCORE, offsetof(struct paca_struct, kvm_vcore));
 	DEFINE(PACA_HOST_MMCR, offsetof(struct paca_struct, host_mmcr));
 	DEFINE(PACA_HOST_PMC, offsetof(struct paca_struct, host_pmc));
 	DEFINE(PACA_HOST_PURR, offsetof(struct paca_struct, host_purr));
 	DEFINE(PACA_HOST_SPURR, offsetof(struct paca_struct, host_spurr));
 	DEFINE(PACA_HOST_DSCR, offsetof(struct paca_struct, host_dscr));
 	DEFINE(PACA_DABR, offsetof(struct paca_struct, dabr));
+	DEFINE(PACA_XICS_PHYS, offsetof(struct paca_struct, xics_phys));
 	DEFINE(PACA_KVM_DECEXP, offsetof(struct paca_struct, dec_expires));
 #endif
 #endif /* CONFIG_KVM_BOOK3S_64_HANDLER */
@@ -478,6 +480,10 @@ int main(void)
 	DEFINE(VCPU_FAULT_DAR, offsetof(struct kvm_vcpu, arch.fault_dar));
 	DEFINE(VCPU_LAST_INST, offsetof(struct kvm_vcpu, arch.last_inst));
 	DEFINE(VCPU_TRAP, offsetof(struct kvm_vcpu, arch.trap));
+	DEFINE(VCPU_PTID, offsetof(struct kvm_vcpu, arch.ptid));
+	DEFINE(VCORE_ENTRY_EXIT, offsetof(struct kvmppc_vcore, entry_exit_count));
+	DEFINE(VCORE_NAP_COUNT, offsetof(struct kvmppc_vcore, nap_count));
+	DEFINE(VCORE_IN_GUEST, offsetof(struct kvmppc_vcore, in_guest));
 	DEFINE(VCPU_SVCPU, offsetof(struct kvmppc_vcpu_book3s, shadow_vcpu) -
 			   offsetof(struct kvmppc_vcpu_book3s, vcpu));
 	DEFINE(SVCPU_HOST_R1, offsetof(struct kvmppc_book3s_shadow_vcpu, host_r1));
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 80c6456..803dcff 100644
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
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 6ff191b..27d8e36 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -58,7 +58,7 @@ config KVM_BOOK3S_64
 
 config KVM_BOOK3S_64_HV
 	bool "KVM support for POWER7 using hypervisor mode in host"
-	depends on EXPERIMENTAL && PPC_BOOK3S_64
+	depends on EXPERIMENTAL && PPC_BOOK3S_64 && PPC_PSERIES
 	select KVM
 	select KVM_BOOK3S_64
 	---help---
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index eed2c10..ce006c0 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -50,6 +50,7 @@
 void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	local_paca->kvm_vcpu = vcpu;
+	local_paca->kvm_vcore = vcpu->arch.vcore;
 	vcpu->cpu = cpu;
 }
 
@@ -58,6 +59,9 @@ void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
 	vcpu->cpu = -1;
 }
 
+static void kvmppc_vcpu_blocked(struct kvm_vcpu *vcpu);
+static void kvmppc_vcpu_unblocked(struct kvm_vcpu *vcpu);
+
 void kvmppc_vcpu_block(struct kvm_vcpu *vcpu)
 {
 	u64 now;
@@ -75,11 +79,15 @@ void kvmppc_vcpu_block(struct kvm_vcpu *vcpu)
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
@@ -415,6 +423,8 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 {
 	struct kvm_vcpu *vcpu;
 	int err = -ENOMEM;
+	int core;
+	struct kvmppc_vcore *vcore;
 	unsigned long lpcr;
 
 	vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
@@ -443,6 +453,37 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
 	lpcr |= LPCR_VPM0 | LPCR_VRMA_L | (4UL << LPCR_DPFD_SH) | LPCR_HDICE;
 	vcpu->arch.lpcr = lpcr;
 
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
+	core = id / KVM_THREADS_PER_CORE;
+
+	mutex_lock(&kvm->lock);
+	vcore = kvm->arch.vcores[core];
+	if (!vcore) {
+		vcore = kzalloc(sizeof(struct kvmppc_vcore), GFP_KERNEL);
+		if (vcore)
+			spin_lock_init(&vcore->lock);
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
@@ -457,37 +498,238 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
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
+	    vc->n_runnable + vc->n_blocked == vc->num_threads)
+		wake_up(&vc->runnable_threads[0]->arch.cpu_run);
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
+
+static void kvmppc_remove_runnable(struct kvmppc_vcore *vc, int ptid)
+{
+	int i;
+	struct kvm_vcpu *vcpu;
+
+	vcpu = vc->runnable_threads[ptid];
+	if (vcpu->arch.state != KVMPPC_VCPU_RUNNABLE)
+		return;
+	vcpu->arch.state = KVMPPC_VCPU_BUSY_IN_HOST;
+	--vc->n_runnable;
+	for (i = ptid; i < vc->n_runnable; ++i) {
+		vcpu = vc->runnable_threads[i+1];
+		vc->runnable_threads[i] = vcpu;
+		vcpu->arch.ptid = i;
+		vc->run_task[i] = vc->run_task[i+1];
+		vc->kvm_run[i] = vc->kvm_run[i+1];
+	}
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
+	tpaca->kvm_vcpu = vcpu;
+	tpaca->kvm_vcore = vc;
+	smp_wmb();
+	if (vcpu->arch.ptid) {
+		tpaca->cpu_start = 0x80;
+		tpaca->shadow_vcpu.in_guest = KVM_GUEST_MODE_GUEST;
+		wmb();
+		xics_wake_cpu(cpu);
+		++vc->n_woken;
+	}
+}
+
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
 
-static int kvmppc_run_vcpu(struct kvm_run *run, struct kvm_vcpu *vcpu)
+static int kvmppc_run_core(struct kvmppc_vcore *vc)
 {
+	struct kvm_vcpu *vcpu;
+	long i, ret;
 	u64 now;
 
+	/* don't start if any threads have a signal pending */
+	for (i = 0; i < vc->n_runnable; ++i) {
+		if (signal_pending(vc->run_task[i]))
+			return 0;
+	}
+
+	vc->n_woken = 0;
+	vc->nap_count = 0;
+	vc->entry_exit_count = 0;
+	vc->vcore_running = 1;
+	vc->in_guest = 0;
+	vc->pcpu = smp_processor_id();
+	for (i = 0; i < vc->n_runnable; ++i)
+		kvmppc_start_thread(vc->runnable_threads[i]);
+	vcpu = vc->runnable_threads[0];
+
+	spin_unlock(&vc->lock);
+
+	kvm_guest_enter();
+	__kvmppc_vcore_entry(NULL, vcpu);
+
+	/* wait for secondary threads to get back to nap mode */
+	spin_lock(&vc->lock);
+	if (vc->nap_count < vc->n_woken)
+		kvmppc_wait_for_nap(vc);
+	vc->vcore_running = 2;
+	spin_unlock(&vc->lock);
+
+	/* make sure updates to secondary vcpu structs are visible now */
+	smp_mb();
+	kvm_guest_exit();
+
+	preempt_enable();
+	kvm_resched(vcpu);
+
+	now = get_tb();
+	for (i = 0; i < vc->n_runnable; ++i) {
+		vcpu = vc->runnable_threads[i];
+		/* cancel pending dec exception if dec is positive */
+		if (now < vcpu->arch.dec_expires &&
+		    kvmppc_core_pending_dec(vcpu))
+			kvmppc_core_dequeue_dec(vcpu);
+		if (!vcpu->arch.trap) {
+			if (signal_pending(vc->run_task[i])) {
+				vc->kvm_run[i]->exit_reason = KVM_EXIT_INTR;
+				vcpu->arch.ret = -EINTR;
+			}
+			continue;		/* didn't get to run */
+		}
+		ret = kvmppc_handle_exit(vc->kvm_run[i], vcpu, vc->run_task[i]);
+		vcpu->arch.ret = ret;
+		vcpu->arch.trap = 0;
+	}
+
+	preempt_disable();
+	spin_lock(&vc->lock);
+
+	vc->vcore_running = 0;
+	for (i = 0; i < vc->n_runnable; ) {
+		vcpu = vc->runnable_threads[i];
+		if (vcpu->arch.ret != RESUME_GUEST) {
+			kvmppc_remove_runnable(vc, i);
+			wake_up(&vcpu->arch.cpu_run);
+		} else
+			++i;
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
 	if (signal_pending(current)) {
-		run->exit_reason = KVM_EXIT_INTR;
+		kvm_run->exit_reason = KVM_EXIT_INTR;
 		return -EINTR;
 	}
 
+	kvm_run->exit_reason = 0;
+	vcpu->arch.ret = RESUME_GUEST;
+	vcpu->arch.trap = 0;
+
 	flush_fp_to_thread(current);
 	flush_altivec_to_thread(current);
 	flush_vsx_to_thread(current);
 	preempt_disable();
 
-	kvm_guest_enter();
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
+	vc->runnable_threads[ptid] = vcpu;
+	vc->run_task[ptid] = current;
+	vc->kvm_run[ptid] = kvm_run;
+	vcpu->arch.ptid = ptid;
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
 
-	__kvmppc_vcore_entry(NULL, vcpu);
+		if (!vc->vcore_running &&
+		    vc->n_runnable + vc->n_blocked == vc->num_threads) {
+			/* we can run now */
+			if (kvmppc_run_core(vc))
+				continue;
+		}
 
-	kvm_guest_exit();
+		if (vc->vcore_running == 1 && VCORE_EXIT_COUNT(vc) == 0)
+			kvmppc_start_thread(vcpu);
 
-	preempt_enable();
-	kvm_resched(vcpu);
+		/* wait for other threads to come in, or wait for vcore */
+		prepare_to_wait(&vcpu->arch.cpu_run, &wait, wait_state);
+		spin_unlock(&vc->lock);
+		schedule();
+		finish_wait(&vcpu->arch.cpu_run, &wait);
+		spin_lock(&vc->lock);
+	}
 
-	now = get_tb();
-	/* cancel pending dec exception if dec is positive */
-	if (now < vcpu->arch.dec_expires && kvmppc_core_pending_dec(vcpu))
-		kvmppc_core_dequeue_dec(vcpu);
+	if (vcpu->arch.state == KVMPPC_VCPU_RUNNABLE)
+		kvmppc_remove_runnable(vc, vcpu->arch.ptid);
+	spin_unlock(&vc->lock);
 
-	return kvmppc_handle_exit(run, vcpu, current);
+	return vcpu->arch.ret;
 }
 
 int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 95f6386..f1d3779 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -111,6 +111,32 @@ kvmppc_trampoline_enter:
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
+	ld	r4, PACA_KVM_VCPU(r13)
+
+	/* We got here with an IPI; clear it */
+	ld	r5, PACA_XICS_PHYS(r13)
+	li	r0, 0xff
+	li	r6, XICS_QIRR
+	li	r7, XICS_XIRR
+	lwzcix	r8, r5, r7		/* ack the interrupt */
+	sync
+	stbcix	r0, r5, r6		/* clear it */
+	stwcix	r8, r5, r7		/* EOI it */
+
 .global kvmppc_handler_trampoline_enter
 kvmppc_handler_trampoline_enter:
 
@@ -229,7 +255,20 @@ kvmppc_handler_trampoline_enter:
 	slbia
 	ptesync
 
-	/* Switch to guest partition. */
+	/* Increment entry count iff exit count is zero. */
+ 	ld	r5,PACA_KVM_VCORE(r13)
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
@@ -239,7 +278,15 @@ kvmppc_handler_trampoline_enter:
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
 
@@ -254,10 +301,12 @@ kvmppc_handler_trampoline_enter:
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
@@ -540,8 +589,51 @@ hcall_real_cont:
 	ptesync
 
 hdec_soon:
-	/* Switch back to host partition */
+	/* Increment the threads-exiting-guest count in the 0xff00
+	   bits of vcore->entry_exit_count */
+	lwsync
+	ld	r5,PACA_KVM_VCORE(r13)
+	addi	r6,r5,VCORE_ENTRY_EXIT
+41:	lwarx	r3,0,r6
+	addi	r0,r3,0x100
+	stwcx.	r0,0,r6
+	bne	41b
+
+	/* If this is not a HDEC interrupt and there are other threads,
+	   and we were the first thread to take an interrupt,
+	   set HDEC to 0 to pull the other threads out of the guest. */
+	cmpwi	r12,0x980
+	beq	40f
+	cmpwi	r3,0x100
+	bge	40f
+	cmpwi	r3,1
+	ble	40f
+	li	r0,0
+	mtspr	SPRN_HDEC,r0
+40:
+
+	/* Secondary threads wait for primary to do partition switch */
 	ld	r4,VCPU_KVM(r9)		/* pointer to struct kvm */
+	ld	r5,PACA_KVM_VCORE(r13)
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
 	li	r8,0x3ff		/* switch to reserved LPID */
@@ -550,10 +642,12 @@ hdec_soon:
 	mtspr	SPRN_SDR1,r6		/* switch to partition page table */
 	mtspr	SPRN_LPID,r7
 	isync
+	li	r0,0
+	stb	r0,VCORE_IN_GUEST(r5)
 	lis	r8,0x7fff
 	mtspr	SPRN_HDEC,r8
 
-	ld	r8,KVM_HOST_LPCR(r4)
+16:	ld	r8,KVM_HOST_LPCR(r4)
 	mtspr	SPRN_LPCR,r8
 	isync
 
@@ -662,6 +756,11 @@ hdec_soon:
 	mr	r3, r9
 	bl	.kvmppc_save_fp
 
+	/* Secondary threads go off to take a nap */
+	lwz	r0,VCPU_PTID(r3)
+	cmpwi	r0,0
+	bne	secondary_nap
+
 	/* RFI into the highmem handler */
 	mfmsr	r7
 	ori	r7, r7, MSR_IR|MSR_DR|MSR_RI|MSR_ME	/* Enable paging */
@@ -807,3 +906,53 @@ _GLOBAL(kvmppc_h_set_dabr)
 	mtspr	SPRN_DABR,r4
 	li	r3,0
 	blr
+
+secondary_too_late:
+	ld	r5,PACA_KVM_VCORE(r13)
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
+50:	ld	r5, PACA_XICS_PHYS(r13)
+	li	r0, 0xff
+	li	r6, XICS_QIRR
+	stbcix	r0, r5, r6
+
+	/* increment the nap count and then go to nap mode */
+	ld	r4, PACA_KVM_VCORE(r13)
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
+	std	r0, SHADOW_VCPU_OFF + SVCPU_SCRATCH0(r13)
+	ptesync
+	ld	r0, SHADOW_VCPU_OFF + SVCPU_SCRATCH0(r13)
+1:	cmpd	r0, r0
+	bne	1b
+	nap
+	b	.
diff --git a/arch/powerpc/sysdev/xics/icp-native.c b/arch/powerpc/sysdev/xics/icp-native.c
index be5e3d7..01149c0 100644
--- a/arch/powerpc/sysdev/xics/icp-native.c
+++ b/arch/powerpc/sysdev/xics/icp-native.c
@@ -23,6 +23,7 @@
 #include <asm/irq.h>
 #include <asm/errno.h>
 #include <asm/xics.h>
+#include <asm/kvm_ppc.h>
 
 struct icp_ipl {
 	union {
@@ -142,6 +143,11 @@ static inline void icp_native_do_message(int cpu, int msg)
 	icp_native_set_qirr(cpu, IPI_PRIORITY);
 }
 
+void xics_wake_cpu(int cpu)
+{
+	icp_native_set_qirr(cpu, IPI_PRIORITY);
+}
+
 static void icp_native_message_pass(int target, int msg)
 {
 	unsigned int i;
@@ -204,6 +210,7 @@ static int __init icp_native_map_one_cpu(int hw_id, unsigned long addr,
 	}
 
 	icp_native_regs[cpu] = ioremap(addr, size);
+	kvmppc_set_xics_phys(cpu, addr);
 	if (!icp_native_regs[cpu]) {
 		pr_warning("icp_native: Failed ioremap for CPU %d, "
 			   "interrupt server #0x%x, addr %#lx\n",
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 3d3cdf1..952d556 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -550,6 +550,9 @@ struct kvm_ppc_pvinfo {
 #ifdef __KVM_HAVE_SPAPR_TCE
 #define KVM_CAP_SPAPR_TCE 60
 #endif
+#ifdef __KVM_HAVE_PPC_SMT
+#define KVM_CAP_PPC_SMT 61
+#endif
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
1.7.4.4
