Return-Path: <paulus@ozlabs.org>
Date: Sat, 18 Jun 2011 18:35:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 09/15] KVM: PPC: Add support for Book3S processors in
	hypervisor mode
Message-ID: <20110618083558.GJ28413@bloggs.ozlabs.ibm.com>
References: <20110618082705.GA28413@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110618082705.GA28413@bloggs.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds support for KVM running on 64-bit Book 3S processors,
specifically POWER7, in hypervisor mode.  Using hypervisor mode means
that the guest can use the processor's supervisor mode.  That means
that the guest can execute privileged instructions and access privileged
registers itself without trapping to the host.  This gives excellent
performance, but does mean that KVM cannot emulate a processor
architecture other than the one that the hardware implements.

This code assumes that the guest is running paravirtualized using the
PAPR (Power Architecture Platform Requirements) interface, which is the
interface that IBM's PowerVM hypervisor uses.  That means that existing
Linux distributions that run on IBM pSeries machines will also run
under KVM without modification.  In order to communicate the PAPR
hypercalls to qemu, this adds a new KVM_EXIT_PAPR_HCALL exit code
to include/linux/kvm.h.

Currently the choice between book3s_hv support and book3s_pr support
(i.e. the existing code, which runs the guest in user mode) has to be
made at kernel configuration time, so a given kernel binary can only
do one or the other.

This new book3s_hv code doesn't support MMIO emulation at present.
Since we are running paravirtualized guests, this isn't a serious
restriction.

With the guest running in supervisor mode, most exceptions go straight
to the guest.  We will never get data or instruction storage or segment
interrupts, alignment interrupts, decrementer interrupts, program
interrupts, single-step interrupts, etc., coming to the hypervisor from
the guest.  Therefore this introduces a new KVMTEST_NONHV macro for the
exception entry path so that we don't have to do the KVM test on entry
to those exception handlers.

We do however get hypervisor decrementer, hypervisor data storage,
hypervisor instruction storage, and hypervisor emulation assist
interrupts, so we have to handle those.

In hypervisor mode, real-mode accesses can access all of RAM, not just
a limited amount.  Therefore we put all the guest state in the vcpu.arch
and use the shadow_vcpu in the PACA only for temporary scratch space.
We allocate the vcpu with kzalloc rather than vzalloc, and we don't use
anything in the kvmppc_vcpu_book3s struct, so we don't allocate it.
We don't have a shared page with the guest, but we still need a
kvm_vcpu_arch_shared struct to store the values of various registers,
so we include one in the vcpu_arch struct.

The POWER7 processor has a restriction that all threads in a core have
to be in the same partition.  MMU-on kernel code counts as a partition
(partition 0), so we have to do a partition switch on every entry to and
exit from the guest.  At present we require the host and guest to run
in single-thread mode because of this hardware restriction.

This code allocates a hashed page table for the guest and initializes
it with HPTEs for the guest's Virtual Real Memory Area (VRMA).  We
require that the guest memory is allocated using 16MB huge pages, in
order to simplify the low-level memory management.  This also means that
we can get away without tracking paging activity in the host for now,
since huge pages can't be paged or swapped.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 Documentation/virtual/kvm/api.txt         |   17 +
 arch/powerpc/include/asm/exception-64s.h  |   19 +-
 arch/powerpc/include/asm/kvm_asm.h        |    4 +
 arch/powerpc/include/asm/kvm_book3s.h     |  136 +++++-
 arch/powerpc/include/asm/kvm_book3s_64.h  |    2 +
 arch/powerpc/include/asm/kvm_book3s_asm.h |   11 +
 arch/powerpc/include/asm/kvm_booke.h      |    4 +
 arch/powerpc/include/asm/kvm_host.h       |   53 ++-
 arch/powerpc/include/asm/kvm_ppc.h        |    6 +
 arch/powerpc/include/asm/mmu-hash64.h     |   10 +-
 arch/powerpc/include/asm/paca.h           |    2 +
 arch/powerpc/include/asm/reg.h            |    4 +
 arch/powerpc/kernel/asm-offsets.c         |   78 ++++
 arch/powerpc/kernel/exceptions-64s.S      |   60 ++--
 arch/powerpc/kvm/Kconfig                  |   41 ++-
 arch/powerpc/kvm/Makefile                 |   16 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c       |  258 +++++++++++
 arch/powerpc/kvm/book3s_hv.c              |  452 +++++++++++++++++++
 arch/powerpc/kvm/book3s_hv_interrupts.S   |  325 ++++++++++++++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  667 +++++++++++++++++++++++++++++
 arch/powerpc/kvm/book3s_segment.S         |   34 +-
 arch/powerpc/kvm/powerpc.c                |   22 +-
 arch/powerpc/kvm/trace.h                  |    2 +-
 include/linux/kvm.h                       |    6 +
 24 files changed, 2147 insertions(+), 82 deletions(-)
 create mode 100644 arch/powerpc/kvm/book3s_64_mmu_hv.c
 create mode 100644 arch/powerpc/kvm/book3s_hv.c
 create mode 100644 arch/powerpc/kvm/book3s_hv_interrupts.S
 create mode 100644 arch/powerpc/kvm/book3s_hv_rmhandlers.S

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 0ebe922..cc5064c 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -1530,6 +1530,23 @@ Userspace can now handle the hypercall and when it's done modify the gprs as
 necessary. Upon guest entry all guest GPRs will then be replaced by the values
 in this struct.
 
+		/* KVM_EXIT_PAPR_HCALL */
+		struct {
+			__u64 nr;
+			__u64 ret;
+			__u64 args[9];
+		} papr_hcall;
+
+This is used on 64-bit PowerPC when emulating a pSeries partition,
+e.g. with the 'pseries' machine type in qemu.  It occurs when the
+guest does a hypercall using the 'sc 1' instruction.  The 'nr' field
+contains the hypercall number (from the guest R3), and 'args' contains
+the arguments (from the guest R4 - R12).  Userspace should put the
+return code in 'ret' and any extra returned values in args[].
+The possible hypercalls are defined in the Power Architecture Platform
+Requirements (PAPR) document available from www.power.org (free
+developer registration required to access it).
+
 		/* Fix the size of the union. */
 		char padding[256];
 	};
diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 296c9b6..69435da 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -134,6 +134,17 @@ do_kvm_##n:								\
 #define KVM_HANDLER_SKIP(area, h, n)
 #endif
 
+#ifdef CONFIG_KVM_BOOK3S_PR
+#define KVMTEST_PR(n)			__KVMTEST(n)
+#define KVM_HANDLER_PR(area, h, n)	__KVM_HANDLER(area, h, n)
+#define KVM_HANDLER_PR_SKIP(area, h, n)	__KVM_HANDLER_SKIP(area, h, n)
+
+#else
+#define KVMTEST_PR(n)
+#define KVM_HANDLER_PR(area, h, n)
+#define KVM_HANDLER_PR_SKIP(area, h, n)
+#endif
+
 #define NOTEST(n)
 
 /*
@@ -210,7 +221,7 @@ label##_pSeries:					\
 	HMT_MEDIUM;					\
 	SET_SCRATCH0(r13);		/* save r13 */		\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
-				 EXC_STD, KVMTEST, vec)
+				 EXC_STD, KVMTEST_PR, vec)
 
 #define STD_EXCEPTION_HV(loc, vec, label)		\
 	. = loc;					\
@@ -227,8 +238,8 @@ label##_hv:						\
 	beq	masked_##h##interrupt
 #define _SOFTEN_TEST(h)	__SOFTEN_TEST(h)
 
-#define SOFTEN_TEST(vec)						\
-	KVMTEST(vec);							\
+#define SOFTEN_TEST_PR(vec)						\
+	KVMTEST_PR(vec);						\
 	_SOFTEN_TEST(EXC_STD)
 
 #define SOFTEN_TEST_HV(vec)						\
@@ -248,7 +259,7 @@ label##_hv:						\
 	.globl label##_pSeries;						\
 label##_pSeries:							\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
-				    EXC_STD, SOFTEN_TEST)
+				    EXC_STD, SOFTEN_TEST_PR)
 
 #define MASKABLE_EXCEPTION_HV(loc, vec, label)				\
 	. = loc;							\
diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
index 0951b17..7b1f0e0 100644
--- a/arch/powerpc/include/asm/kvm_asm.h
+++ b/arch/powerpc/include/asm/kvm_asm.h
@@ -64,8 +64,12 @@
 #define BOOK3S_INTERRUPT_PROGRAM	0x700
 #define BOOK3S_INTERRUPT_FP_UNAVAIL	0x800
 #define BOOK3S_INTERRUPT_DECREMENTER	0x900
+#define BOOK3S_INTERRUPT_HV_DECREMENTER	0x980
 #define BOOK3S_INTERRUPT_SYSCALL	0xc00
 #define BOOK3S_INTERRUPT_TRACE		0xd00
+#define BOOK3S_INTERRUPT_H_DATA_STORAGE	0xe00
+#define BOOK3S_INTERRUPT_H_INST_STORAGE	0xe20
+#define BOOK3S_INTERRUPT_H_EMUL_ASSIST	0xe40
 #define BOOK3S_INTERRUPT_PERFMON	0xf00
 #define BOOK3S_INTERRUPT_ALTIVEC	0xf20
 #define BOOK3S_INTERRUPT_VSX		0xf40
diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/include/asm/kvm_book3s.h
index 480fff6..6135a98 100644
--- a/arch/powerpc/include/asm/kvm_book3s.h
+++ b/arch/powerpc/include/asm/kvm_book3s.h
@@ -116,6 +116,7 @@ extern void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 new_msr);
 extern void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr);
 extern void kvmppc_mmu_book3s_64_init(struct kvm_vcpu *vcpu);
 extern void kvmppc_mmu_book3s_32_init(struct kvm_vcpu *vcpu);
+extern void kvmppc_mmu_book3s_hv_init(struct kvm_vcpu *vcpu);
 extern int kvmppc_mmu_map_page(struct kvm_vcpu *vcpu, struct kvmppc_pte *pte);
 extern int kvmppc_mmu_map_segment(struct kvm_vcpu *vcpu, ulong eaddr);
 extern void kvmppc_mmu_flush_segments(struct kvm_vcpu *vcpu);
@@ -127,10 +128,12 @@ extern int kvmppc_mmu_hpte_init(struct kvm_vcpu *vcpu);
 extern void kvmppc_mmu_invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte);
 extern int kvmppc_mmu_hpte_sysinit(void);
 extern void kvmppc_mmu_hpte_sysexit(void);
+extern int kvmppc_mmu_hv_init(void);
 
 extern int kvmppc_ld(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr, bool data);
 extern int kvmppc_st(struct kvm_vcpu *vcpu, ulong *eaddr, int size, void *ptr, bool data);
 extern void kvmppc_book3s_queue_irqprio(struct kvm_vcpu *vcpu, unsigned int vec);
+extern void kvmppc_inject_interrupt(struct kvm_vcpu *vcpu, int vec, u64 flags);
 extern void kvmppc_set_bat(struct kvm_vcpu *vcpu, struct kvmppc_bat *bat,
 			   bool upper, u32 val);
 extern void kvmppc_giveup_ext(struct kvm_vcpu *vcpu, ulong msr);
@@ -151,6 +154,19 @@ static inline struct kvmppc_vcpu_book3s *to_book3s(struct kvm_vcpu *vcpu)
 	return container_of(vcpu, struct kvmppc_vcpu_book3s, vcpu);
 }
 
+extern void kvm_return_point(void);
+
+/* Also add subarch specific defines */
+
+#ifdef CONFIG_KVM_BOOK3S_32_HANDLER
+#include <asm/kvm_book3s_32.h>
+#endif
+#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+#include <asm/kvm_book3s_64.h>
+#endif
+
+#ifdef CONFIG_KVM_BOOK3S_PR
+
 static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
 {
 	return to_book3s(vcpu)->hior;
@@ -165,16 +181,6 @@ static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
 		vcpu->arch.shared->int_pending = 0;
 }
 
-static inline ulong dsisr(void)
-{
-	ulong r;
-	asm ( "mfdsisr %0 " : "=r" (r) );
-	return r;
-}
-
-extern void kvm_return_point(void);
-static inline struct kvmppc_book3s_shadow_vcpu *to_svcpu(struct kvm_vcpu *vcpu);
-
 static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, ulong val)
 {
 	if ( num < 14 ) {
@@ -281,6 +287,108 @@ static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
 
 	return crit;
 }
+#else /* CONFIG_KVM_BOOK3S_PR */
+
+static inline unsigned long kvmppc_interrupt_offset(struct kvm_vcpu *vcpu)
+{
+	return 0;
+}
+
+static inline void kvmppc_update_int_pending(struct kvm_vcpu *vcpu,
+			unsigned long pending_now, unsigned long old_pending)
+{
+	/* Recalculate LPCR:MER based on the presence of
+	 * a pending external interrupt
+	 */
+	if (test_bit(BOOK3S_IRQPRIO_EXTERNAL, &pending_now) ||
+	    test_bit(BOOK3S_IRQPRIO_EXTERNAL_LEVEL, &pending_now))
+		vcpu->arch.lpcr |= LPCR_MER;
+	else
+		vcpu->arch.lpcr &= ~((u64)LPCR_MER);
+}
+
+static inline void kvmppc_set_gpr(struct kvm_vcpu *vcpu, int num, ulong val)
+{
+	vcpu->arch.gpr[num] = val;
+}
+
+static inline ulong kvmppc_get_gpr(struct kvm_vcpu *vcpu, int num)
+{
+	return vcpu->arch.gpr[num];
+}
+
+static inline void kvmppc_set_cr(struct kvm_vcpu *vcpu, u32 val)
+{
+	vcpu->arch.cr = val;
+}
+
+static inline u32 kvmppc_get_cr(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.cr;
+}
+
+static inline void kvmppc_set_xer(struct kvm_vcpu *vcpu, u32 val)
+{
+	vcpu->arch.xer = val;
+}
+
+static inline u32 kvmppc_get_xer(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.xer;
+}
+
+static inline void kvmppc_set_ctr(struct kvm_vcpu *vcpu, ulong val)
+{
+	vcpu->arch.ctr = val;
+}
+
+static inline ulong kvmppc_get_ctr(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.ctr;
+}
+
+static inline void kvmppc_set_lr(struct kvm_vcpu *vcpu, ulong val)
+{
+	vcpu->arch.lr = val;
+}
+
+static inline ulong kvmppc_get_lr(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.lr;
+}
+
+static inline void kvmppc_set_pc(struct kvm_vcpu *vcpu, ulong val)
+{
+	vcpu->arch.pc = val;
+}
+
+static inline ulong kvmppc_get_pc(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.pc;
+}
+
+static inline u32 kvmppc_get_last_inst(struct kvm_vcpu *vcpu)
+{
+	ulong pc = kvmppc_get_pc(vcpu);
+
+	/* Load the instruction manually if it failed to do so in the
+	 * exit path */
+	if (vcpu->arch.last_inst == KVM_INST_FETCH_FAILED)
+		kvmppc_ld(vcpu, &pc, sizeof(u32), &vcpu->arch.last_inst, false);
+
+	return vcpu->arch.last_inst;
+}
+
+static inline ulong kvmppc_get_fault_dar(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.fault_dar;
+}
+
+static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+#endif
 
 /* Magic register values loaded into r3 and r4 before the 'sc' assembly
  * instruction for the OSI hypercalls */
@@ -289,12 +397,4 @@ static inline bool kvmppc_critical_section(struct kvm_vcpu *vcpu)
 
 #define INS_DCBZ			0x7c0007ec
 
-/* Also add subarch specific defines */
-
-#ifdef CONFIG_PPC_BOOK3S_32
-#include <asm/kvm_book3s_32.h>
-#else
-#include <asm/kvm_book3s_64.h>
-#endif
-
 #endif /* __ASM_KVM_BOOK3S_H__ */
diff --git a/arch/powerpc/include/asm/kvm_book3s_64.h b/arch/powerpc/include/asm/kvm_book3s_64.h
index 4cadd61..5f73388 100644
--- a/arch/powerpc/include/asm/kvm_book3s_64.h
+++ b/arch/powerpc/include/asm/kvm_book3s_64.h
@@ -20,9 +20,11 @@
 #ifndef __ASM_KVM_BOOK3S_64_H__
 #define __ASM_KVM_BOOK3S_64_H__
 
+#ifdef CONFIG_KVM_BOOK3S_PR
 static inline struct kvmppc_book3s_shadow_vcpu *to_svcpu(struct kvm_vcpu *vcpu)
 {
 	return &get_paca()->shadow_vcpu;
 }
+#endif
 
 #endif /* __ASM_KVM_BOOK3S_64_H__ */
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index 3126175..550cf07 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -74,6 +74,17 @@ struct kvmppc_host_state {
 	ulong scratch0;
 	ulong scratch1;
 	u8 in_guest;
+
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	struct kvm_vcpu *kvm_vcpu;
+	u64 dabr;
+	u64 host_mmcr[3];
+	u32 host_pmc[6];
+	u64 host_purr;
+	u64 host_spurr;
+	u64 host_dscr;
+	u64 dec_expires;
+#endif
 };
 
 struct kvmppc_book3s_shadow_vcpu {
diff --git a/arch/powerpc/include/asm/kvm_booke.h b/arch/powerpc/include/asm/kvm_booke.h
index 9c9ba3d..a90e091 100644
--- a/arch/powerpc/include/asm/kvm_booke.h
+++ b/arch/powerpc/include/asm/kvm_booke.h
@@ -93,4 +93,8 @@ static inline ulong kvmppc_get_fault_dar(struct kvm_vcpu *vcpu)
 	return vcpu->arch.fault_dear;
 }
 
+static inline ulong kvmppc_get_msr(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.shared->msr;
+}
 #endif /* __ASM_KVM_BOOKE_H__ */
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index 069eb9f..4a3f790 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -33,7 +33,9 @@
 /* memory slots that does not exposed to userspace */
 #define KVM_PRIVATE_MEM_SLOTS 4
 
+#ifdef CONFIG_KVM_MMIO
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
+#endif
 
 /* We don't currently support large pages. */
 #define KVM_HPAGE_GFN_SHIFT(x)	0
@@ -133,7 +135,26 @@ struct kvmppc_exit_timing {
 	};
 };
 
+struct kvmppc_pginfo {
+	unsigned long pfn;
+	atomic_t refcnt;
+};
+
 struct kvm_arch {
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	unsigned long hpt_virt;
+	unsigned long ram_npages;
+	unsigned long ram_psize;
+	unsigned long ram_porder;
+	struct kvmppc_pginfo *ram_pginfo;
+	unsigned int lpid;
+	unsigned int host_lpid;
+	unsigned long host_lpcr;
+	unsigned long sdr1;
+	unsigned long host_sdr1;
+	int tlbie_lock;
+	unsigned short last_vcpu[NR_CPUS];
+#endif /* CONFIG_KVM_BOOK3S_64_HV */
 };
 
 struct kvmppc_pte {
@@ -190,7 +211,7 @@ struct kvm_vcpu_arch {
 	ulong rmcall;
 	ulong host_paca_phys;
 	struct kvmppc_slb slb[64];
-	int slb_max;		/* # valid entries in slb[] */
+	int slb_max;		/* 1 + index of last valid entry in slb[] */
 	int slb_nr;		/* total number of entries in SLB */
 	struct kvmppc_mmu mmu;
 #endif
@@ -212,7 +233,7 @@ struct kvm_vcpu_arch {
 #endif
 
 #ifdef CONFIG_VSX
-	u64 vsr[32];
+	u64 vsr[64];
 #endif
 
 #ifdef CONFIG_PPC_BOOK3S
@@ -220,18 +241,24 @@ struct kvm_vcpu_arch {
 	u32 qpr[32];
 #endif
 
-#ifdef CONFIG_BOOKE
 	ulong pc;
 	ulong ctr;
 	ulong lr;
 
 	ulong xer;
 	u32 cr;
-#endif
 
 #ifdef CONFIG_PPC_BOOK3S
 	ulong hflags;
 	ulong guest_owned_ext;
+	ulong purr;
+	ulong spurr;
+	ulong lpcr;
+	ulong dscr;
+	ulong amr;
+	ulong uamor;
+	u32 ctrl;
+	ulong dabr;
 #endif
 	u32 vrsave; /* also USPRG0 */
 	u32 mmucr;
@@ -270,6 +297,9 @@ struct kvm_vcpu_arch {
 	u32 dbcr1;
 	u32 dbsr;
 
+	u64 mmcr[3];
+	u32 pmc[6];
+
 #ifdef CONFIG_KVM_EXIT_TIMING
 	struct mutex exit_timing_lock;
 	struct kvmppc_exit_timing timing_exit;
@@ -284,8 +314,12 @@ struct kvm_vcpu_arch {
 	struct dentry *debugfs_exit_timing;
 #endif
 
+#ifdef CONFIG_PPC_BOOK3S
+	ulong fault_dar;
+	u32 fault_dsisr;
+#endif
+
 #ifdef CONFIG_BOOKE
-	u32 last_inst;
 	ulong fault_dear;
 	ulong fault_esr;
 	ulong queued_dear;
@@ -300,16 +334,25 @@ struct kvm_vcpu_arch {
 	u8 dcr_is_write;
 	u8 osi_needed;
 	u8 osi_enabled;
+	u8 hcall_needed;
 
 	u32 cpr0_cfgaddr; /* holds the last set cpr0_cfgaddr */
 
 	struct hrtimer dec_timer;
 	struct tasklet_struct tasklet;
 	u64 dec_jiffies;
+	u64 dec_expires;
 	unsigned long pending_exceptions;
+	u16 last_cpu;
+	u32 last_inst;
+	int trap;
 	struct kvm_vcpu_arch_shared *shared;
 	unsigned long magic_page_pa; /* phys addr to map the magic page to */
 	unsigned long magic_page_ea; /* effect. addr to map the magic page to */
+
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	struct kvm_vcpu_arch_shared shregs;
+#endif
 };
 
 #endif /* __POWERPC_KVM_HOST_H__ */
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 48b7ab7..0dafd53 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -112,6 +112,12 @@ extern void kvmppc_core_destroy_mmu(struct kvm_vcpu *vcpu);
 extern int kvmppc_kvm_pv(struct kvm_vcpu *vcpu);
 extern void kvmppc_map_magic(struct kvm_vcpu *vcpu);
 
+extern long kvmppc_alloc_hpt(struct kvm *kvm);
+extern void kvmppc_free_hpt(struct kvm *kvm);
+extern long kvmppc_prepare_vrma(struct kvm *kvm,
+				struct kvm_userspace_memory_region *mem);
+extern void kvmppc_map_vrma(struct kvm *kvm,
+			    struct kvm_userspace_memory_region *mem);
 extern int kvmppc_core_init_vm(struct kvm *kvm);
 extern void kvmppc_core_destroy_vm(struct kvm *kvm);
 extern int kvmppc_core_prepare_memory_region(struct kvm *kvm,
diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/include/asm/mmu-hash64.h
index d865bd9..b445e0a 100644
--- a/arch/powerpc/include/asm/mmu-hash64.h
+++ b/arch/powerpc/include/asm/mmu-hash64.h
@@ -90,13 +90,19 @@ extern char initial_stab[];
 
 #define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
 #define HPTE_R_TS		ASM_CONST(0x4000000000000000)
+#define HPTE_R_KEY_HI		ASM_CONST(0x3000000000000000)
 #define HPTE_R_RPN_SHIFT	12
-#define HPTE_R_RPN		ASM_CONST(0x3ffffffffffff000)
-#define HPTE_R_FLAGS		ASM_CONST(0x00000000000003ff)
+#define HPTE_R_RPN		ASM_CONST(0x0ffffffffffff000)
 #define HPTE_R_PP		ASM_CONST(0x0000000000000003)
 #define HPTE_R_N		ASM_CONST(0x0000000000000004)
+#define HPTE_R_G		ASM_CONST(0x0000000000000008)
+#define HPTE_R_M		ASM_CONST(0x0000000000000010)
+#define HPTE_R_I		ASM_CONST(0x0000000000000020)
+#define HPTE_R_W		ASM_CONST(0x0000000000000040)
+#define HPTE_R_WIMG		ASM_CONST(0x0000000000000078)
 #define HPTE_R_C		ASM_CONST(0x0000000000000080)
 #define HPTE_R_R		ASM_CONST(0x0000000000000100)
+#define HPTE_R_KEY_LO		ASM_CONST(0x0000000000000e00)
 
 #define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
 #define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff000000)
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 58f4a18..a6da128 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -147,8 +147,10 @@ struct paca_struct {
 	struct dtl_entry *dtl_curr;	/* pointer corresponding to dtl_ridx */
 
 #ifdef CONFIG_KVM_BOOK3S_HANDLER
+#ifdef CONFIG_KVM_BOOK3S_PR
 	/* We use this to store guest state in */
 	struct kvmppc_book3s_shadow_vcpu shadow_vcpu;
+#endif
 	struct kvmppc_host_state kvm_hstate;
 #endif
 };
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index d879a6b..36a611b 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -189,6 +189,9 @@
 #define SPRN_CTR	0x009	/* Count Register */
 #define SPRN_DSCR	0x11
 #define SPRN_CFAR	0x1c	/* Come From Address Register */
+#define SPRN_AMR	0x1d	/* Authority Mask Register */
+#define SPRN_UAMOR	0x9d	/* User Authority Mask Override Register */
+#define SPRN_AMOR	0x15d	/* Authority Mask Override Register */
 #define SPRN_ACOP	0x1F	/* Available Coprocessor Register */
 #define SPRN_CTRLF	0x088
 #define SPRN_CTRLT	0x098
@@ -252,6 +255,7 @@
 #define   LPCR_RMI     0x00000002      /* real mode is cache inhibit */
 #define   LPCR_HDICE   0x00000001      /* Hyp Decr enable (HV,PR,EE) */
 #define SPRN_LPID	0x13F	/* Logical Partition Identifier */
+#define   LPID_RSVD	0x3ff		/* Reserved LPID for partn switching */
 #define	SPRN_HMER	0x150	/* Hardware m? error recovery */
 #define	SPRN_HMEER	0x151	/* Hardware m? enable error recovery */
 #define	SPRN_HEIR	0x153	/* Hypervisor Emulated Instruction Register */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index dabfb73..4f73572 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -187,6 +187,7 @@ int main(void)
 	DEFINE(LPPACASRR1, offsetof(struct lppaca, saved_srr1));
 	DEFINE(LPPACAANYINT, offsetof(struct lppaca, int_dword.any_int));
 	DEFINE(LPPACADECRINT, offsetof(struct lppaca, int_dword.fields.decr_int));
+	DEFINE(LPPACA_PMCINUSE, offsetof(struct lppaca, pmcregs_in_use));
 	DEFINE(LPPACA_DTLIDX, offsetof(struct lppaca, dtl_idx));
 	DEFINE(PACA_DTL_RIDX, offsetof(struct paca_struct, dtl_ridx));
 #endif /* CONFIG_PPC_STD_MMU_64 */
@@ -392,6 +393,29 @@ int main(void)
 	DEFINE(VCPU_HOST_PID, offsetof(struct kvm_vcpu, arch.host_pid));
 	DEFINE(VCPU_GPRS, offsetof(struct kvm_vcpu, arch.gpr));
 	DEFINE(VCPU_VRSAVE, offsetof(struct kvm_vcpu, arch.vrsave));
+	DEFINE(VCPU_FPRS, offsetof(struct kvm_vcpu, arch.fpr));
+	DEFINE(VCPU_FPSCR, offsetof(struct kvm_vcpu, arch.fpscr));
+#ifdef CONFIG_ALTIVEC
+	DEFINE(VCPU_VRS, offsetof(struct kvm_vcpu, arch.vr));
+	DEFINE(VCPU_VSCR, offsetof(struct kvm_vcpu, arch.vscr));
+#endif
+#ifdef CONFIG_VSX
+	DEFINE(VCPU_VSRS, offsetof(struct kvm_vcpu, arch.vsr));
+#endif
+	DEFINE(VCPU_XER, offsetof(struct kvm_vcpu, arch.xer));
+	DEFINE(VCPU_CTR, offsetof(struct kvm_vcpu, arch.ctr));
+	DEFINE(VCPU_LR, offsetof(struct kvm_vcpu, arch.lr));
+	DEFINE(VCPU_CR, offsetof(struct kvm_vcpu, arch.cr));
+	DEFINE(VCPU_PC, offsetof(struct kvm_vcpu, arch.pc));
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	DEFINE(VCPU_MSR, offsetof(struct kvm_vcpu, arch.shregs.msr));
+	DEFINE(VCPU_SRR0, offsetof(struct kvm_vcpu, arch.shregs.srr0));
+	DEFINE(VCPU_SRR1, offsetof(struct kvm_vcpu, arch.shregs.srr1));
+	DEFINE(VCPU_SPRG0, offsetof(struct kvm_vcpu, arch.shregs.sprg0));
+	DEFINE(VCPU_SPRG1, offsetof(struct kvm_vcpu, arch.shregs.sprg1));
+	DEFINE(VCPU_SPRG2, offsetof(struct kvm_vcpu, arch.shregs.sprg2));
+	DEFINE(VCPU_SPRG3, offsetof(struct kvm_vcpu, arch.shregs.sprg3));
+#endif
 	DEFINE(VCPU_SPRG4, offsetof(struct kvm_vcpu, arch.sprg4));
 	DEFINE(VCPU_SPRG5, offsetof(struct kvm_vcpu, arch.sprg5));
 	DEFINE(VCPU_SPRG6, offsetof(struct kvm_vcpu, arch.sprg6));
@@ -403,17 +427,60 @@ int main(void)
 	DEFINE(VCPU_SHADOW_MSR, offsetof(struct kvm_vcpu, arch.shadow_msr));
 
 	/* book3s */
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	DEFINE(KVM_LPID, offsetof(struct kvm, arch.lpid));
+	DEFINE(KVM_SDR1, offsetof(struct kvm, arch.sdr1));
+	DEFINE(KVM_HOST_LPID, offsetof(struct kvm, arch.host_lpid));
+	DEFINE(KVM_HOST_LPCR, offsetof(struct kvm, arch.host_lpcr));
+	DEFINE(KVM_HOST_SDR1, offsetof(struct kvm, arch.host_sdr1));
+	DEFINE(KVM_TLBIE_LOCK, offsetof(struct kvm, arch.tlbie_lock));
+	DEFINE(KVM_ONLINE_CPUS, offsetof(struct kvm, online_vcpus.counter));
+	DEFINE(KVM_LAST_VCPU, offsetof(struct kvm, arch.last_vcpu));
+	DEFINE(VCPU_DSISR, offsetof(struct kvm_vcpu, arch.shregs.dsisr));
+	DEFINE(VCPU_DAR, offsetof(struct kvm_vcpu, arch.shregs.dar));
+#endif
 #ifdef CONFIG_PPC_BOOK3S
+	DEFINE(VCPU_KVM, offsetof(struct kvm_vcpu, kvm));
+	DEFINE(VCPU_VCPUID, offsetof(struct kvm_vcpu, vcpu_id));
 	DEFINE(VCPU_HOST_RETIP, offsetof(struct kvm_vcpu, arch.host_retip));
 	DEFINE(VCPU_HOST_MSR, offsetof(struct kvm_vcpu, arch.host_msr));
+	DEFINE(VCPU_PURR, offsetof(struct kvm_vcpu, arch.purr));
+	DEFINE(VCPU_SPURR, offsetof(struct kvm_vcpu, arch.spurr));
+	DEFINE(VCPU_DSCR, offsetof(struct kvm_vcpu, arch.dscr));
+	DEFINE(VCPU_AMR, offsetof(struct kvm_vcpu, arch.amr));
+	DEFINE(VCPU_UAMOR, offsetof(struct kvm_vcpu, arch.uamor));
+	DEFINE(VCPU_CTRL, offsetof(struct kvm_vcpu, arch.ctrl));
+	DEFINE(VCPU_DABR, offsetof(struct kvm_vcpu, arch.dabr));
 	DEFINE(VCPU_TRAMPOLINE_LOWMEM, offsetof(struct kvm_vcpu, arch.trampoline_lowmem));
 	DEFINE(VCPU_TRAMPOLINE_ENTER, offsetof(struct kvm_vcpu, arch.trampoline_enter));
 	DEFINE(VCPU_HIGHMEM_HANDLER, offsetof(struct kvm_vcpu, arch.highmem_handler));
 	DEFINE(VCPU_RMCALL, offsetof(struct kvm_vcpu, arch.rmcall));
 	DEFINE(VCPU_HFLAGS, offsetof(struct kvm_vcpu, arch.hflags));
+	DEFINE(VCPU_DEC, offsetof(struct kvm_vcpu, arch.dec));
+	DEFINE(VCPU_DEC_EXPIRES, offsetof(struct kvm_vcpu, arch.dec_expires));
+	DEFINE(VCPU_LPCR, offsetof(struct kvm_vcpu, arch.lpcr));
+	DEFINE(VCPU_MMCR, offsetof(struct kvm_vcpu, arch.mmcr));
+	DEFINE(VCPU_PMC, offsetof(struct kvm_vcpu, arch.pmc));
+	DEFINE(VCPU_SLB, offsetof(struct kvm_vcpu, arch.slb));
+	DEFINE(VCPU_SLB_MAX, offsetof(struct kvm_vcpu, arch.slb_max));
+	DEFINE(VCPU_SLB_NR, offsetof(struct kvm_vcpu, arch.slb_nr));
+	DEFINE(VCPU_LAST_CPU, offsetof(struct kvm_vcpu, arch.last_cpu));
+	DEFINE(VCPU_FAULT_DSISR, offsetof(struct kvm_vcpu, arch.fault_dsisr));
+	DEFINE(VCPU_FAULT_DAR, offsetof(struct kvm_vcpu, arch.fault_dar));
+	DEFINE(VCPU_LAST_INST, offsetof(struct kvm_vcpu, arch.last_inst));
+	DEFINE(VCPU_TRAP, offsetof(struct kvm_vcpu, arch.trap));
+	DEFINE(VCPU_SVCPU, offsetof(struct kvmppc_vcpu_book3s, shadow_vcpu) -
+			   offsetof(struct kvmppc_vcpu_book3s, vcpu));
+	DEFINE(VCPU_SLB_E, offsetof(struct kvmppc_slb, orige));
+	DEFINE(VCPU_SLB_V, offsetof(struct kvmppc_slb, origv));
+	DEFINE(VCPU_SLB_SIZE, sizeof(struct kvmppc_slb));
 
 #ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_KVM_BOOK3S_PR
 # define SVCPU_FIELD(x, f)	DEFINE(x, offsetof(struct paca_struct, shadow_vcpu.f))
+#else
+# define SVCPU_FIELD(x, f)
+#endif
 # define HSTATE_FIELD(x, f)	DEFINE(x, offsetof(struct paca_struct, kvm_hstate.f))
 #else	/* 32-bit */
 # define SVCPU_FIELD(x, f)	DEFINE(x, offsetof(struct kvmppc_book3s_shadow_vcpu, f))
@@ -458,6 +525,17 @@ int main(void)
 	HSTATE_FIELD(HSTATE_SCRATCH1, scratch1);
 	HSTATE_FIELD(HSTATE_IN_GUEST, in_guest);
 
+#ifdef CONFIG_KVM_BOOK3S_64_HV
+	HSTATE_FIELD(HSTATE_KVM_VCPU, kvm_vcpu);
+	HSTATE_FIELD(HSTATE_MMCR, host_mmcr);
+	HSTATE_FIELD(HSTATE_PMC, host_pmc);
+	HSTATE_FIELD(HSTATE_PURR, host_purr);
+	HSTATE_FIELD(HSTATE_SPURR, host_spurr);
+	HSTATE_FIELD(HSTATE_DSCR, host_dscr);
+	HSTATE_FIELD(HSTATE_DABR, dabr);
+	HSTATE_FIELD(HSTATE_DECEXP, dec_expires);
+#endif /* CONFIG_KVM_BOOK3S_64_HV */
+
 #else /* CONFIG_PPC_BOOK3S */
 	DEFINE(VCPU_CR, offsetof(struct kvm_vcpu, arch.cr));
 	DEFINE(VCPU_XER, offsetof(struct kvm_vcpu, arch.xer));
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index e76472c..a4a89fc 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -87,14 +87,14 @@ data_access_not_stab:
 END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 #endif
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, data_access_common, EXC_STD,
-				 KVMTEST, 0x300)
+				 KVMTEST_PR, 0x300)
 
 	. = 0x380
 	.globl data_access_slb_pSeries
 data_access_slb_pSeries:
 	HMT_MEDIUM
 	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x380)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x380)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
 #ifdef __DISABLED__
@@ -125,7 +125,7 @@ data_access_slb_pSeries:
 instruction_access_slb_pSeries:
 	HMT_MEDIUM
 	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x480)
+	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
 #ifdef __DISABLED__
@@ -153,32 +153,32 @@ instruction_access_slb_pSeries:
 hardware_interrupt_pSeries:
 hardware_interrupt_hv:
 	BEGIN_FTR_SECTION
-		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt,
-					    EXC_STD, SOFTEN_TEST)
-		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
-	FTR_SECTION_ELSE
 		_MASKABLE_EXCEPTION_PSERIES(0x502, hardware_interrupt,
 					    EXC_HV, SOFTEN_TEST_HV)
 		KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x502)
-	ALT_FTR_SECTION_END_IFCLR(CPU_FTR_HVMODE_206)
+	FTR_SECTION_ELSE
+		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt,
+					    EXC_STD, SOFTEN_TEST_PR)
+		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
+	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE_206)
 
 	STD_EXCEPTION_PSERIES(0x600, 0x600, alignment)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x600)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x600)
 
 	STD_EXCEPTION_PSERIES(0x700, 0x700, program_check)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x700)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x700)
 
 	STD_EXCEPTION_PSERIES(0x800, 0x800, fp_unavailable)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x800)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x800)
 
 	MASKABLE_EXCEPTION_PSERIES(0x900, 0x900, decrementer)
 	MASKABLE_EXCEPTION_HV(0x980, 0x982, decrementer)
 
 	STD_EXCEPTION_PSERIES(0xa00, 0xa00, trap_0a)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xa00)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xa00)
 
 	STD_EXCEPTION_PSERIES(0xb00, 0xb00, trap_0b)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xb00)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xb00)
 
 	. = 0xc00
 	.globl	system_call_pSeries
@@ -219,7 +219,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_REAL_LE)
 	b	.
 
 	STD_EXCEPTION_PSERIES(0xd00, 0xd00, single_step)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xd00)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xd00)
 
 	/* At 0xe??? we have a bunch of hypervisor exceptions, we branch
 	 * out of line to handle them
@@ -254,23 +254,23 @@ vsx_unavailable_pSeries_1:
 
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1200, 0x1202, cbe_system_error)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1202)
+	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_HV, 0x1202)
 #endif /* CONFIG_CBE_RAS */
 
 	STD_EXCEPTION_PSERIES(0x1300, 0x1300, instruction_breakpoint)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x1300)
+	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_STD, 0x1300)
 
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1600, 0x1602, cbe_maintenance)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1602)
+	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_HV, 0x1602)
 #endif /* CONFIG_CBE_RAS */
 
 	STD_EXCEPTION_PSERIES(0x1700, 0x1700, altivec_assist)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x1700)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x1700)
 
 #ifdef CONFIG_CBE_RAS
 	STD_EXCEPTION_HV(0x1800, 0x1802, cbe_thermal)
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0x1802)
+	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_HV, 0x1802)
 #endif /* CONFIG_CBE_RAS */
 
 	. = 0x3000
@@ -297,7 +297,7 @@ data_access_check_stab:
 	mfspr	r9,SPRN_DSISR
 	srdi	r10,r10,60
 	rlwimi	r10,r9,16,0x20
-#ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+#ifdef CONFIG_KVM_BOOK3S_PR
 	lbz	r9,PACA_KVM_SVCPU+SVCPU_IN_GUEST(r13)
 	rlwimi	r10,r9,8,0x300
 #endif
@@ -316,11 +316,11 @@ do_stab_bolted_pSeries:
 	EXCEPTION_PROLOG_PSERIES_1(.do_stab_bolted, EXC_STD)
 #endif /* CONFIG_POWER4_ONLY */
 
-	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_STD, 0x300)
-	KVM_HANDLER_SKIP(PACA_EXSLB, EXC_STD, 0x380)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x400)
-	KVM_HANDLER(PACA_EXSLB, EXC_STD, 0x480)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x900)
+	KVM_HANDLER_PR_SKIP(PACA_EXGEN, EXC_STD, 0x300)
+	KVM_HANDLER_PR_SKIP(PACA_EXSLB, EXC_STD, 0x380)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x400)
+	KVM_HANDLER_PR(PACA_EXSLB, EXC_STD, 0x480)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x900)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x982)
 
 	.align	7
@@ -336,11 +336,11 @@ do_stab_bolted_pSeries:
 
 	/* moved from 0xf00 */
 	STD_EXCEPTION_PSERIES(., 0xf00, performance_monitor)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf00)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf00)
 	STD_EXCEPTION_PSERIES(., 0xf20, altivec_unavailable)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf20)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf20)
 	STD_EXCEPTION_PSERIES(., 0xf40, vsx_unavailable)
-	KVM_HANDLER(PACA_EXGEN, EXC_STD, 0xf40)
+	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf40)
 
 /*
  * An interrupt came in while soft-disabled; clear EE in SRR1,
@@ -417,7 +417,11 @@ slb_miss_user_pseries:
 /* KVM's trampoline code needs to be close to the interrupt handlers */
 
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
+#ifdef CONFIG_KVM_BOOK3S_PR
 #include "../kvm/book3s_rmhandlers.S"
+#else
+#include "../kvm/book3s_hv_rmhandlers.S"
+#endif
 #endif
 
 	.align	7
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index b7baff7..3662ecc 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -20,7 +20,6 @@ config KVM
 	bool
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
-	select KVM_MMIO
 
 config KVM_BOOK3S_HANDLER
 	bool
@@ -28,16 +27,22 @@ config KVM_BOOK3S_HANDLER
 config KVM_BOOK3S_32_HANDLER
 	bool
 	select KVM_BOOK3S_HANDLER
+	select KVM_MMIO
 
 config KVM_BOOK3S_64_HANDLER
 	bool
 	select KVM_BOOK3S_HANDLER
 
+config KVM_BOOK3S_PR
+	bool
+	select KVM_MMIO
+
 config KVM_BOOK3S_32
 	tristate "KVM support for PowerPC book3s_32 processors"
 	depends on EXPERIMENTAL && PPC_BOOK3S_32 && !SMP && !PTE_64BIT
 	select KVM
 	select KVM_BOOK3S_32_HANDLER
+	select KVM_BOOK3S_PR
 	---help---
 	  Support running unmodified book3s_32 guest kernels
 	  in virtual machines on book3s_32 host processors.
@@ -48,10 +53,38 @@ config KVM_BOOK3S_32
 	  If unsure, say N.
 
 config KVM_BOOK3S_64
-	tristate "KVM support for PowerPC book3s_64 processors"
+	bool
+	select KVM_BOOK3S_64_HANDLER
+
+config KVM_BOOK3S_64_HV
+	bool "KVM support for POWER7 using hypervisor mode in host"
 	depends on EXPERIMENTAL && PPC_BOOK3S_64
 	select KVM
-	select KVM_BOOK3S_64_HANDLER
+	select KVM_BOOK3S_64
+	---help---
+	  Support running unmodified book3s_64 guest kernels in
+	  virtual machines on POWER7 processors that have hypervisor
+	  mode available to the host.
+
+	  If you say Y here, KVM will use the hardware virtualization
+	  facilities of POWER7 (and later) processors, meaning that
+	  guest operating systems will run at full hardware speed
+	  using supervisor and user modes.  However, this also means
+	  that KVM is not usable under PowerVM (pHyp), is only usable
+	  on POWER7 (or later) processors, and can only emulate
+	  POWER5+, POWER6 and POWER7 processors.
+
+	  This module provides access to the hardware capabilities through
+	  a character device node named /dev/kvm.
+
+	  If unsure, say N.
+
+config KVM_BOOK3S_64_PR
+	tristate "KVM support for PowerPC book3s_64 processors"
+	depends on EXPERIMENTAL && PPC_BOOK3S_64 && !KVM_BOOK3S_64_HV
+	select KVM
+	select KVM_BOOK3S_64
+	select KVM_BOOK3S_PR
 	---help---
 	  Support running unmodified book3s_64 and book3s_32 guest kernels
 	  in virtual machines on book3s_64 host processors.
@@ -65,6 +98,7 @@ config KVM_440
 	bool "KVM support for PowerPC 440 processors"
 	depends on EXPERIMENTAL && 44x
 	select KVM
+	select KVM_MMIO
 	---help---
 	  Support running unmodified 440 guest kernels in virtual machines on
 	  440 host processors.
@@ -89,6 +123,7 @@ config KVM_E500
 	bool "KVM support for PowerPC E500 processors"
 	depends on EXPERIMENTAL && E500
 	select KVM
+	select KVM_MMIO
 	---help---
 	  Support running unmodified E500 guest kernels in virtual machines on
 	  E500 host processors.
diff --git a/arch/powerpc/kvm/Makefile b/arch/powerpc/kvm/Makefile
index bf9854f..ca7ed27 100644
--- a/arch/powerpc/kvm/Makefile
+++ b/arch/powerpc/kvm/Makefile
@@ -14,7 +14,7 @@ CFLAGS_emulate.o  := -I.
 
 common-objs-y += powerpc.o emulate.o
 obj-$(CONFIG_KVM_EXIT_TIMING) += timing.o
-obj-$(CONFIG_KVM_BOOK3S_HANDLER) += book3s_exports.o
+obj-$(CONFIG_KVM_BOOK3S_PR) += book3s_exports.o
 
 AFLAGS_booke_interrupts.o := -I$(obj)
 
@@ -38,7 +38,7 @@ kvm-e500-objs := \
 	e500_emulate.o
 kvm-objs-$(CONFIG_KVM_E500) := $(kvm-e500-objs)
 
-kvm-book3s_64-objs := \
+kvm-book3s_64_pr-objs := \
 	$(common-objs-y) \
 	fpu.o \
 	book3s_paired_singles.o \
@@ -50,7 +50,17 @@ kvm-book3s_64-objs := \
 	book3s_64_mmu_host.o \
 	book3s_64_mmu.o \
 	book3s_32_mmu.o
-kvm-objs-$(CONFIG_KVM_BOOK3S_64) := $(kvm-book3s_64-objs)
+kvm-objs-$(CONFIG_KVM_BOOK3S_64_PR) := $(kvm-book3s_64_pr-objs)
+
+kvm-book3s_64_hv-objs := \
+	../../../virt/kvm/kvm_main.o \
+	powerpc.o \
+	emulate.o \
+	book3s.o \
+	book3s_hv.o \
+	book3s_hv_interrupts.o \
+	book3s_64_mmu_hv.o
+kvm-objs-$(CONFIG_KVM_BOOK3S_64_HV) := $(kvm-book3s_64_hv-objs)
 
 kvm-book3s_32-objs := \
 	$(common-objs-y) \
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
new file mode 100644
index 0000000..4a4fbec
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -0,0 +1,258 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ */
+
+#include <linux/types.h>
+#include <linux/string.h>
+#include <linux/kvm.h>
+#include <linux/kvm_host.h>
+#include <linux/highmem.h>
+#include <linux/gfp.h>
+#include <linux/slab.h>
+#include <linux/hugetlb.h>
+
+#include <asm/tlbflush.h>
+#include <asm/kvm_ppc.h>
+#include <asm/kvm_book3s.h>
+#include <asm/mmu-hash64.h>
+#include <asm/hvcall.h>
+#include <asm/synch.h>
+#include <asm/ppc-opcode.h>
+#include <asm/cputable.h>
+
+/* For now use fixed-size 16MB page table */
+#define HPT_ORDER	24
+#define HPT_NPTEG	(1ul << (HPT_ORDER - 7))	/* 128B per pteg */
+#define HPT_HASH_MASK	(HPT_NPTEG - 1)
+
+/* Pages in the VRMA are 16MB pages */
+#define VRMA_PAGE_ORDER	24
+#define VRMA_VSID	0x1ffffffUL	/* 1TB VSID reserved for VRMA */
+
+#define NR_LPIDS	(LPID_RSVD + 1)
+unsigned long lpid_inuse[BITS_TO_LONGS(NR_LPIDS)];
+
+long kvmppc_alloc_hpt(struct kvm *kvm)
+{
+	unsigned long hpt;
+	unsigned long lpid;
+
+	hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|__GFP_NOWARN,
+			       HPT_ORDER - PAGE_SHIFT);
+	if (!hpt) {
+		pr_err("kvm_alloc_hpt: Couldn't alloc HPT\n");
+		return -ENOMEM;
+	}
+	kvm->arch.hpt_virt = hpt;
+
+	do {
+		lpid = find_first_zero_bit(lpid_inuse, NR_LPIDS);
+		if (lpid >= NR_LPIDS) {
+			pr_err("kvm_alloc_hpt: No LPIDs free\n");
+			free_pages(hpt, HPT_ORDER - PAGE_SHIFT);
+			return -ENOMEM;
+		}
+	} while (test_and_set_bit(lpid, lpid_inuse));
+
+	kvm->arch.sdr1 = __pa(hpt) | (HPT_ORDER - 18);
+	kvm->arch.lpid = lpid;
+	kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
+	kvm->arch.host_lpid = mfspr(SPRN_LPID);
+	kvm->arch.host_lpcr = mfspr(SPRN_LPCR);
+
+	pr_info("KVM guest htab at %lx, LPID %lx\n", hpt, lpid);
+	return 0;
+}
+
+void kvmppc_free_hpt(struct kvm *kvm)
+{
+	unsigned long i;
+	struct kvmppc_pginfo *pginfo;
+
+	clear_bit(kvm->arch.lpid, lpid_inuse);
+	free_pages(kvm->arch.hpt_virt, HPT_ORDER - PAGE_SHIFT);
+
+	if (kvm->arch.ram_pginfo) {
+		pginfo = kvm->arch.ram_pginfo;
+		kvm->arch.ram_pginfo = NULL;
+		for (i = 0; i < kvm->arch.ram_npages; ++i)
+			put_page(pfn_to_page(pginfo[i].pfn));
+		kfree(pginfo);
+	}
+}
+
+static unsigned long user_page_size(unsigned long addr)
+{
+	struct vm_area_struct *vma;
+	unsigned long size = PAGE_SIZE;
+
+	down_read(&current->mm->mmap_sem);
+	vma = find_vma(current->mm, addr);
+	if (vma)
+		size = vma_kernel_pagesize(vma);
+	up_read(&current->mm->mmap_sem);
+	return size;
+}
+
+static pfn_t hva_to_pfn(unsigned long addr)
+{
+	struct page *page[1];
+	int npages;
+
+	might_sleep();
+
+	npages = get_user_pages_fast(addr, 1, 1, page);
+
+	if (unlikely(npages != 1))
+		return 0;
+
+	return page_to_pfn(page[0]);
+}
+
+long kvmppc_prepare_vrma(struct kvm *kvm,
+			 struct kvm_userspace_memory_region *mem)
+{
+	unsigned long psize, porder;
+	unsigned long i, npages;
+	struct kvmppc_pginfo *pginfo;
+	pfn_t pfn;
+	unsigned long hva;
+
+	/* First see what page size we have */
+	psize = user_page_size(mem->userspace_addr);
+	/* For now, only allow 16MB pages */
+	if (psize != 1ul << VRMA_PAGE_ORDER || (mem->memory_size & (psize - 1))) {
+		pr_err("bad psize=%lx memory_size=%llx @ %llx\n",
+		       psize, mem->memory_size, mem->userspace_addr);
+		return -EINVAL;
+	}
+	porder = __ilog2(psize);
+
+	npages = mem->memory_size >> porder;
+	pginfo = kzalloc(npages * sizeof(struct kvmppc_pginfo), GFP_KERNEL);
+	if (!pginfo) {
+		pr_err("kvmppc_prepare_vrma: couldn't alloc %lu bytes\n",
+		       npages * sizeof(struct kvmppc_pginfo));
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < npages; ++i) {
+		hva = mem->userspace_addr + (i << porder);
+		if (user_page_size(hva) != psize)
+			goto err;
+		pfn = hva_to_pfn(hva);
+		if (pfn == 0) {
+			pr_err("oops, no pfn for hva %lx\n", hva);
+			goto err;
+		}
+		if (pfn & ((1ul << (porder - PAGE_SHIFT)) - 1)) {
+			pr_err("oops, unaligned pfn %llx\n", pfn);
+			put_page(pfn_to_page(pfn));
+			goto err;
+		}
+		pginfo[i].pfn = pfn;
+	}
+
+	kvm->arch.ram_npages = npages;
+	kvm->arch.ram_psize = psize;
+	kvm->arch.ram_porder = porder;
+	kvm->arch.ram_pginfo = pginfo;
+
+	return 0;
+
+ err:
+	kfree(pginfo);
+	return -EINVAL;
+}
+
+void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
+{
+	unsigned long i;
+	unsigned long npages = kvm->arch.ram_npages;
+	unsigned long pfn;
+	unsigned long *hpte;
+	unsigned long hash;
+	struct kvmppc_pginfo *pginfo = kvm->arch.ram_pginfo;
+
+	if (!pginfo)
+		return;
+
+	/* VRMA can't be > 1TB */
+	if (npages > 1ul << (40 - kvm->arch.ram_porder))
+		npages = 1ul << (40 - kvm->arch.ram_porder);
+	/* Can't use more than 1 HPTE per HPTEG */
+	if (npages > HPT_NPTEG)
+		npages = HPT_NPTEG;
+
+	for (i = 0; i < npages; ++i) {
+		pfn = pginfo[i].pfn;
+		/* can't use hpt_hash since va > 64 bits */
+		hash = (i ^ (VRMA_VSID ^ (VRMA_VSID << 25))) & HPT_HASH_MASK;
+		/*
+		 * We assume that the hash table is empty and no
+		 * vcpus are using it at this stage.  Since we create
+		 * at most one HPTE per HPTEG, we just assume entry 7
+		 * is available and use it.
+		 */
+		hpte = (unsigned long *) (kvm->arch.hpt_virt + (hash << 7));
+		hpte += 7 * 2;
+		/* HPTE low word - RPN, protection, etc. */
+		hpte[1] = (pfn << PAGE_SHIFT) | HPTE_R_R | HPTE_R_C |
+			HPTE_R_M | PP_RWXX;
+		wmb();
+		hpte[0] = HPTE_V_1TB_SEG | (VRMA_VSID << (40 - 16)) |
+			(i << (VRMA_PAGE_ORDER - 16)) | HPTE_V_BOLTED |
+			HPTE_V_LARGE | HPTE_V_VALID;
+	}
+}
+
+int kvmppc_mmu_hv_init(void)
+{
+	if (!cpu_has_feature(CPU_FTR_HVMODE_206))
+		return -EINVAL;
+	memset(lpid_inuse, 0, sizeof(lpid_inuse));
+	set_bit(mfspr(SPRN_LPID), lpid_inuse);
+	set_bit(LPID_RSVD, lpid_inuse);
+
+	return 0;
+}
+
+void kvmppc_mmu_destroy(struct kvm_vcpu *vcpu)
+{
+}
+
+static void kvmppc_mmu_book3s_64_hv_reset_msr(struct kvm_vcpu *vcpu)
+{
+	kvmppc_set_msr(vcpu, MSR_SF | MSR_ME);
+}
+
+static int kvmppc_mmu_book3s_64_hv_xlate(struct kvm_vcpu *vcpu, gva_t eaddr,
+				struct kvmppc_pte *gpte, bool data)
+{
+	return -ENOENT;
+}
+
+void kvmppc_mmu_book3s_hv_init(struct kvm_vcpu *vcpu)
+{
+	struct kvmppc_mmu *mmu = &vcpu->arch.mmu;
+
+	vcpu->arch.slb_nr = 32;		/* Assume POWER7 for now */
+
+	mmu->xlate = kvmppc_mmu_book3s_64_hv_xlate;
+	mmu->reset_msr = kvmppc_mmu_book3s_64_hv_reset_msr;
+
+	vcpu->arch.hflags |= BOOK3S_HFLAG_SLB;
+}
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
new file mode 100644
index 0000000..321bf38
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -0,0 +1,452 @@
+/*
+ * Copyright 2011 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ * Copyright (C) 2009. SUSE Linux Products GmbH. All rights reserved.
+ *
+ * Authors:
+ *    Paul Mackerras <paulus@au1.ibm.com>
+ *    Alexander Graf <agraf@suse.de>
+ *    Kevin Wolf <mail@kevin-wolf.de>
+ *
+ * Description: KVM functions specific to running on Book 3S
+ * processors in hypervisor mode (specifically POWER7 and later).
+ *
+ * This file is derived from arch/powerpc/kvm/book3s.c,
+ * by Alexander Graf <agraf@suse.de>.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kvm_host.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/preempt.h>
+#include <linux/sched.h>
+#include <linux/delay.h>
+#include <linux/fs.h>
+#include <linux/anon_inodes.h>
+#include <linux/cpumask.h>
+
+#include <asm/reg.h>
+#include <asm/cputable.h>
+#include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/kvm_ppc.h>
+#include <asm/kvm_book3s.h>
+#include <asm/mmu_context.h>
+#include <asm/lppaca.h>
+#include <asm/processor.h>
+#include <linux/gfp.h>
+#include <linux/sched.h>
+#include <linux/vmalloc.h>
+#include <linux/highmem.h>
+
+/* #define EXIT_DEBUG */
+/* #define EXIT_DEBUG_SIMPLE */
+/* #define EXIT_DEBUG_INT */
+
+void kvmppc_core_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
+{
+	local_paca->kvm_hstate.kvm_vcpu = vcpu;
+}
+
+void kvmppc_core_vcpu_put(struct kvm_vcpu *vcpu)
+{
+}
+
+void kvmppc_vcpu_block(struct kvm_vcpu *vcpu)
+{
+	u64 now;
+	unsigned long dec_nsec;
+
+	now = get_tb();
+	if (now >= vcpu->arch.dec_expires && !kvmppc_core_pending_dec(vcpu))
+		kvmppc_core_queue_dec(vcpu);
+	if (vcpu->arch.pending_exceptions)
+		return;
+	if (vcpu->arch.dec_expires != ~(u64)0) {
+		dec_nsec = (vcpu->arch.dec_expires - now) * NSEC_PER_SEC /
+			tb_ticks_per_sec;
+		hrtimer_start(&vcpu->arch.dec_timer, ktime_set(0, dec_nsec),
+			      HRTIMER_MODE_REL);
+	}
+
+	kvm_vcpu_block(vcpu);
+	vcpu->stat.halt_wakeup++;
+
+	if (vcpu->arch.dec_expires != ~(u64)0)
+		hrtimer_try_to_cancel(&vcpu->arch.dec_timer);
+}
+
+void kvmppc_set_msr(struct kvm_vcpu *vcpu, u64 msr)
+{
+	vcpu->arch.shregs.msr = msr;
+}
+
+void kvmppc_set_pvr(struct kvm_vcpu *vcpu, u32 pvr)
+{
+	vcpu->arch.pvr = pvr;
+}
+
+void kvmppc_dump_regs(struct kvm_vcpu *vcpu)
+{
+	int r;
+
+	pr_err("vcpu %p (%d):\n", vcpu, vcpu->vcpu_id);
+	pr_err("pc  = %.16lx  msr = %.16llx  trap = %x\n",
+	       vcpu->arch.pc, vcpu->arch.shregs.msr, vcpu->arch.trap);
+	for (r = 0; r < 16; ++r)
+		pr_err("r%2d = %.16lx  r%d = %.16lx\n",
+		       r, kvmppc_get_gpr(vcpu, r),
+		       r+16, kvmppc_get_gpr(vcpu, r+16));
+	pr_err("ctr = %.16lx  lr  = %.16lx\n",
+	       vcpu->arch.ctr, vcpu->arch.lr);
+	pr_err("srr0 = %.16llx srr1 = %.16llx\n",
+	       vcpu->arch.shregs.srr0, vcpu->arch.shregs.srr1);
+	pr_err("sprg0 = %.16llx sprg1 = %.16llx\n",
+	       vcpu->arch.shregs.sprg0, vcpu->arch.shregs.sprg1);
+	pr_err("sprg2 = %.16llx sprg3 = %.16llx\n",
+	       vcpu->arch.shregs.sprg2, vcpu->arch.shregs.sprg3);
+	pr_err("cr = %.8x  xer = %.16lx  dsisr = %.8x\n",
+	       vcpu->arch.cr, vcpu->arch.xer, vcpu->arch.shregs.dsisr);
+	pr_err("dar = %.16llx\n", vcpu->arch.shregs.dar);
+	pr_err("fault dar = %.16lx dsisr = %.8x\n",
+	       vcpu->arch.fault_dar, vcpu->arch.fault_dsisr);
+	pr_err("SLB (%d entries):\n", vcpu->arch.slb_max);
+	for (r = 0; r < vcpu->arch.slb_max; ++r)
+		pr_err("  ESID = %.16llx VSID = %.16llx\n",
+		       vcpu->arch.slb[r].orige, vcpu->arch.slb[r].origv);
+	pr_err("lpcr = %.16lx sdr1 = %.16lx last_inst = %.8x\n",
+	       vcpu->arch.lpcr, vcpu->kvm->arch.sdr1,
+	       vcpu->arch.last_inst);
+}
+
+static int kvmppc_handle_exit(struct kvm_run *run, struct kvm_vcpu *vcpu,
+			      struct task_struct *tsk)
+{
+	int r = RESUME_HOST;
+
+	vcpu->stat.sum_exits++;
+
+	run->exit_reason = KVM_EXIT_UNKNOWN;
+	run->ready_for_interrupt_injection = 1;
+	switch (vcpu->arch.trap) {
+	/* We're good on these - the host merely wanted to get our attention */
+	case BOOK3S_INTERRUPT_HV_DECREMENTER:
+		vcpu->stat.dec_exits++;
+		r = RESUME_GUEST;
+		break;
+	case BOOK3S_INTERRUPT_EXTERNAL:
+		vcpu->stat.ext_intr_exits++;
+		r = RESUME_GUEST;
+		break;
+	case BOOK3S_INTERRUPT_PERFMON:
+		r = RESUME_GUEST;
+		break;
+	case BOOK3S_INTERRUPT_PROGRAM:
+	{
+		ulong flags;
+		/*
+		 * Normally program interrupts are delivered directly
+		 * to the guest by the hardware, but we can get here
+		 * as a result of a hypervisor emulation interrupt
+		 * (e40) getting turned into a 700 by BML RTAS.
+		 */
+		flags = vcpu->arch.shregs.msr & 0x1f0000ull;
+		kvmppc_core_queue_program(vcpu, flags);
+		r = RESUME_GUEST;
+		break;
+	}
+	case BOOK3S_INTERRUPT_SYSCALL:
+	{
+		/* hcall - punt to userspace */
+		int i;
+
+		if (vcpu->arch.shregs.msr & MSR_PR) {
+			/* sc 1 from userspace - reflect to guest syscall */
+			kvmppc_book3s_queue_irqprio(vcpu, BOOK3S_INTERRUPT_SYSCALL);
+			r = RESUME_GUEST;
+			break;
+		}
+		run->papr_hcall.nr = kvmppc_get_gpr(vcpu, 3);
+		for (i = 0; i < 9; ++i)
+			run->papr_hcall.args[i] = kvmppc_get_gpr(vcpu, 4 + i);
+		run->exit_reason = KVM_EXIT_PAPR_HCALL;
+		vcpu->arch.hcall_needed = 1;
+		r = RESUME_HOST;
+		break;
+	}
+	/*
+	 * We get these next two if the guest does a bad real-mode access,
+	 * as we have enabled VRMA (virtualized real mode area) mode in the
+	 * LPCR.  We just generate an appropriate DSI/ISI to the guest.
+	 */
+	case BOOK3S_INTERRUPT_H_DATA_STORAGE:
+		vcpu->arch.shregs.dsisr = vcpu->arch.fault_dsisr;
+		vcpu->arch.shregs.dar = vcpu->arch.fault_dar;
+		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_DATA_STORAGE, 0);
+		r = RESUME_GUEST;
+		break;
+	case BOOK3S_INTERRUPT_H_INST_STORAGE:
+		kvmppc_inject_interrupt(vcpu, BOOK3S_INTERRUPT_INST_STORAGE,
+					0x08000000);
+		r = RESUME_GUEST;
+		break;
+	/*
+	 * This occurs if the guest executes an illegal instruction.
+	 * We just generate a program interrupt to the guest, since
+	 * we don't emulate any guest instructions at this stage.
+	 */
+	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
+		kvmppc_core_queue_program(vcpu, 0x80000);
+		r = RESUME_GUEST;
+		break;
+	default:
+		kvmppc_dump_regs(vcpu);
+		printk(KERN_EMERG "trap=0x%x | pc=0x%lx | msr=0x%llx\n",
+			vcpu->arch.trap, kvmppc_get_pc(vcpu),
+			vcpu->arch.shregs.msr);
+		r = RESUME_HOST;
+		BUG();
+		break;
+	}
+
+
+	if (!(r & RESUME_HOST)) {
+		/* To avoid clobbering exit_reason, only check for signals if
+		 * we aren't already exiting to userspace for some other
+		 * reason. */
+		if (signal_pending(tsk)) {
+			vcpu->stat.signal_exits++;
+			run->exit_reason = KVM_EXIT_INTR;
+			r = -EINTR;
+		} else {
+			kvmppc_core_deliver_interrupts(vcpu);
+		}
+	}
+
+	return r;
+}
+
+int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
+                                  struct kvm_sregs *sregs)
+{
+	int i;
+
+	sregs->pvr = vcpu->arch.pvr;
+
+	memset(sregs, 0, sizeof(struct kvm_sregs));
+	for (i = 0; i < vcpu->arch.slb_max; i++) {
+		sregs->u.s.ppc64.slb[i].slbe = vcpu->arch.slb[i].orige;
+		sregs->u.s.ppc64.slb[i].slbv = vcpu->arch.slb[i].origv;
+	}
+
+	return 0;
+}
+
+int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
+                                  struct kvm_sregs *sregs)
+{
+	int i, j;
+
+	kvmppc_set_pvr(vcpu, sregs->pvr);
+
+	j = 0;
+	for (i = 0; i < vcpu->arch.slb_nr; i++) {
+		if (sregs->u.s.ppc64.slb[i].slbe & SLB_ESID_V) {
+			vcpu->arch.slb[j].orige = sregs->u.s.ppc64.slb[i].slbe;
+			vcpu->arch.slb[j].origv = sregs->u.s.ppc64.slb[i].slbv;
+			++j;
+		}
+	}
+	vcpu->arch.slb_max = j;
+
+	return 0;
+}
+
+int kvmppc_core_check_processor_compat(void)
+{
+	if (cpu_has_feature(CPU_FTR_HVMODE_206))
+		return 0;
+	return -EIO;
+}
+
+struct kvm_vcpu *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
+{
+	struct kvm_vcpu *vcpu;
+	int err = -ENOMEM;
+	unsigned long lpcr;
+
+	vcpu = kzalloc(sizeof(struct kvm_vcpu), GFP_KERNEL);
+	if (!vcpu)
+		goto out;
+
+	err = kvm_vcpu_init(vcpu, kvm, id);
+	if (err)
+		goto free_vcpu;
+
+	vcpu->arch.shared = &vcpu->arch.shregs;
+	vcpu->arch.last_cpu = -1;
+	vcpu->arch.host_msr = mfmsr();
+	vcpu->arch.mmcr[0] = MMCR0_FC;
+	vcpu->arch.ctrl = CTRL_RUNLATCH;
+	/* default to host PVR, since we can't spoof it */
+	vcpu->arch.pvr = mfspr(SPRN_PVR);
+	kvmppc_set_pvr(vcpu, vcpu->arch.pvr);
+
+	/* remember where some real-mode handlers are */
+	vcpu->arch.trampoline_lowmem = (ulong)kvmppc_handler_lowmem_trampoline;
+	vcpu->arch.trampoline_enter = (ulong)kvmppc_handler_trampoline_enter;
+	vcpu->arch.highmem_handler = (ulong)kvmppc_handler_highmem;
+	vcpu->arch.rmcall = *(ulong*)kvmppc_rmcall;
+
+	lpcr = kvm->arch.host_lpcr & (LPCR_PECE | LPCR_LPES);
+	lpcr |= LPCR_VPM0 | LPCR_VRMA_L | (4UL << LPCR_DPFD_SH) | LPCR_HDICE;
+	vcpu->arch.lpcr = lpcr;
+
+	kvmppc_mmu_book3s_hv_init(vcpu);
+
+	return vcpu;
+
+free_vcpu:
+	kfree(vcpu);
+out:
+	return ERR_PTR(err);
+}
+
+void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
+{
+	kvm_vcpu_uninit(vcpu);
+	kfree(vcpu);
+}
+
+extern int __kvmppc_vcore_entry(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu);
+
+int kvmppc_vcpu_run(struct kvm_run *run, struct kvm_vcpu *vcpu)
+{
+	u64 now;
+
+	if (signal_pending(current)) {
+		run->exit_reason = KVM_EXIT_INTR;
+		return -EINTR;
+	}
+
+	flush_fp_to_thread(current);
+	flush_altivec_to_thread(current);
+	flush_vsx_to_thread(current);
+	preempt_disable();
+
+	/*
+	 * Make sure we are running on thread 0, and that
+	 * secondary threads are offline.
+	 * XXX we should also block attempts to bring any
+	 * secondary threads online.
+	 */
+	if (threads_per_core > 1) {
+		int cpu = smp_processor_id();
+		int thr = cpu_thread_in_core(cpu);
+
+		if (thr)
+			goto out;
+		while (++thr < threads_per_core)
+			if (cpu_online(cpu + thr))
+				goto out;
+	}
+
+	kvm_guest_enter();
+
+	__kvmppc_vcore_entry(NULL, vcpu);
+
+	kvm_guest_exit();
+
+	preempt_enable();
+	kvm_resched(vcpu);
+
+	now = get_tb();
+	/* cancel pending dec exception if dec is positive */
+	if (now < vcpu->arch.dec_expires && kvmppc_core_pending_dec(vcpu))
+		kvmppc_core_dequeue_dec(vcpu);
+
+	return kvmppc_handle_exit(run, vcpu, current);
+
+ out:
+	preempt_enable();
+	return -EBUSY;
+}
+
+int kvmppc_core_prepare_memory_region(struct kvm *kvm,
+				struct kvm_userspace_memory_region *mem)
+{
+	if (mem->guest_phys_addr == 0 && mem->memory_size != 0)
+		return kvmppc_prepare_vrma(kvm, mem);
+	return 0;
+}
+
+void kvmppc_core_commit_memory_region(struct kvm *kvm,
+				struct kvm_userspace_memory_region *mem)
+{
+	if (mem->guest_phys_addr == 0 && mem->memory_size != 0)
+		kvmppc_map_vrma(kvm, mem);
+}
+
+int kvmppc_core_init_vm(struct kvm *kvm)
+{
+	long r;
+
+	/* Allocate hashed page table */
+	r = kvmppc_alloc_hpt(kvm);
+
+	return r;
+}
+
+void kvmppc_core_destroy_vm(struct kvm *kvm)
+{
+	kvmppc_free_hpt(kvm);
+}
+
+/* These are stubs for now */
+void kvmppc_mmu_pte_pflush(struct kvm_vcpu *vcpu, ulong pa_start, ulong pa_end)
+{
+}
+
+/* We don't need to emulate any privileged instructions or dcbz */
+int kvmppc_core_emulate_op(struct kvm_run *run, struct kvm_vcpu *vcpu,
+                           unsigned int inst, int *advance)
+{
+	return EMULATE_FAIL;
+}
+
+int kvmppc_core_emulate_mtspr(struct kvm_vcpu *vcpu, int sprn, int rs)
+{
+	return EMULATE_FAIL;
+}
+
+int kvmppc_core_emulate_mfspr(struct kvm_vcpu *vcpu, int sprn, int rt)
+{
+	return EMULATE_FAIL;
+}
+
+static int kvmppc_book3s_hv_init(void)
+{
+	int r;
+
+	r = kvm_init(NULL, sizeof(struct kvm_vcpu), 0, THIS_MODULE);
+
+	if (r)
+		return r;
+
+	r = kvmppc_mmu_hv_init();
+
+	return r;
+}
+
+static void kvmppc_book3s_hv_exit(void)
+{
+	kvm_exit();
+}
+
+module_init(kvmppc_book3s_hv_init);
+module_exit(kvmppc_book3s_hv_exit);
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
new file mode 100644
index 0000000..5c6a387
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -0,0 +1,325 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ *
+ * Copyright 2011 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *
+ * Derived from book3s_interrupts.S, which is:
+ * Copyright SUSE Linux Products GmbH 2009
+ *
+ * Authors: Alexander Graf <agraf@suse.de>
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/kvm_asm.h>
+#include <asm/reg.h>
+#include <asm/page.h>
+#include <asm/asm-offsets.h>
+#include <asm/exception-64s.h>
+#include <asm/ppc-opcode.h>
+
+#define DISABLE_INTERRUPTS	\
+	mfmsr   r0;		\
+	rldicl  r0,r0,48,1;	\
+	rotldi  r0,r0,16;	\
+	mtmsrd  r0,1;		\
+
+/*****************************************************************************
+ *                                                                           *
+ *     Guest entry / exit code that is in kernel module memory (vmalloc)     *
+ *                                                                           *
+ ****************************************************************************/
+
+/* Registers:
+ *  r4: vcpu pointer
+ */
+_GLOBAL(__kvmppc_vcore_entry)
+
+	/* Write correct stack frame */
+	mflr	r0
+	std	r0,PPC_LR_STKOFF(r1)
+
+	/* Save host state to the stack */
+	stdu	r1, -SWITCH_FRAME_SIZE(r1)
+
+	/* Save non-volatile registers (r14 - r31) */
+	SAVE_NVGPRS(r1)
+
+	/* Save host PMU registers and load guest PMU registers */
+	/* R4 is live here (vcpu pointer) but not r3 or r5 */
+	li	r3, 1
+	sldi	r3, r3, 31		/* MMCR0_FC (freeze counters) bit */
+	mfspr	r7, SPRN_MMCR0		/* save MMCR0 */
+	mtspr	SPRN_MMCR0, r3		/* freeze all counters, disable interrupts */
+	isync
+	ld	r3, PACALPPACAPTR(r13)	/* is the host using the PMU? */
+	lbz	r5, LPPACA_PMCINUSE(r3)
+	cmpwi	r5, 0
+	beq	31f			/* skip if not */
+	mfspr	r5, SPRN_MMCR1
+	mfspr	r6, SPRN_MMCRA
+	std	r7, HSTATE_MMCR(r13)
+	std	r5, HSTATE_MMCR + 8(r13)
+	std	r6, HSTATE_MMCR + 16(r13)
+	mfspr	r3, SPRN_PMC1
+	mfspr	r5, SPRN_PMC2
+	mfspr	r6, SPRN_PMC3
+	mfspr	r7, SPRN_PMC4
+	mfspr	r8, SPRN_PMC5
+	mfspr	r9, SPRN_PMC6
+	stw	r3, HSTATE_PMC(r13)
+	stw	r5, HSTATE_PMC + 4(r13)
+	stw	r6, HSTATE_PMC + 8(r13)
+	stw	r7, HSTATE_PMC + 12(r13)
+	stw	r8, HSTATE_PMC + 16(r13)
+	stw	r9, HSTATE_PMC + 20(r13)
+31:
+
+	/* Save host DSCR */
+	mfspr	r3, SPRN_DSCR
+	std	r3, HSTATE_DSCR(r13)
+
+	/* Save host DABR */
+	mfspr	r3, SPRN_DABR
+	std	r3, HSTATE_DABR(r13)
+
+	DISABLE_INTERRUPTS
+
+	/*
+	 * Put whatever is in the decrementer into the
+	 * hypervisor decrementer.
+	 */
+	mfspr	r8,SPRN_DEC
+	mftb	r7
+	mtspr	SPRN_HDEC,r8
+	extsw	r8,r8
+	add	r8,r8,r7
+	std	r8,HSTATE_DECEXP(r13)
+
+	ld	r5, VCPU_TRAMPOLINE_ENTER(r4)
+	LOAD_REG_IMMEDIATE(r6, MSR_KERNEL & ~(MSR_IR | MSR_DR))
+
+	/* Jump to segment patching handler and into our guest */
+	b	kvmppc_rmcall
+
+/*
+ * This is the handler in module memory. It gets jumped at from the
+ * lowmem trampoline code, so it's basically the guest exit code.
+ *
+ */
+
+.global kvmppc_handler_highmem
+kvmppc_handler_highmem:
+
+	/*
+	 * Register usage at this point:
+	 *
+	 * R1       = host R1
+	 * R2       = host R2
+	 * R12      = exit handler id
+	 * R13      = PACA
+	 *
+	 */
+
+	/* R7 = vcpu */
+	ld	r7, HSTATE_KVM_VCPU(r13)
+
+	/*
+	 * Reload DEC.  HDEC interrupts were disabled when
+	 * we reloaded the host's LPCR value.
+	 */
+	ld	r3, HSTATE_DECEXP(r13)
+	mftb	r4
+	subf	r4, r4, r3
+	mtspr	SPRN_DEC, r4
+
+	ld	r3, PACALPPACAPTR(r13)	/* is the host using the PMU? */
+	lbz	r4, LPPACA_PMCINUSE(r3)
+	cmpwi	r4, 0
+	beq	23f			/* skip if not */
+	lwz	r3, HSTATE_PMC(r13)
+	lwz	r4, HSTATE_PMC + 4(r13)
+	lwz	r5, HSTATE_PMC + 8(r13)
+	lwz	r6, HSTATE_PMC + 12(r13)
+	lwz	r8, HSTATE_PMC + 16(r13)
+	lwz	r9, HSTATE_PMC + 20(r13)
+	mtspr	SPRN_PMC1, r3
+	mtspr	SPRN_PMC2, r4
+	mtspr	SPRN_PMC3, r5
+	mtspr	SPRN_PMC4, r6
+	mtspr	SPRN_PMC5, r8
+	mtspr	SPRN_PMC6, r9
+	ld	r3, HSTATE_MMCR(r13)
+	ld	r4, HSTATE_MMCR + 8(r13)
+	ld	r5, HSTATE_MMCR + 16(r13)
+	mtspr	SPRN_MMCR1, r4
+	mtspr	SPRN_MMCRA, r5
+	mtspr	SPRN_MMCR0, r3
+	isync
+23:
+
+	/* Restore host msr -> SRR1 */
+	ld	r4, VCPU_HOST_MSR(r7)
+
+	/*
+	 * For some interrupts, we need to call the real Linux
+	 * handler, so it can do work for us. This has to happen
+	 * as if the interrupt arrived from the kernel though,
+	 * so let's fake it here where most state is restored.
+	 *
+	 * Call Linux for hardware interrupts/decrementer
+	 * r3 = address of interrupt handler (exit reason)
+	 */
+	/* Note: preemption is disabled at this point */
+
+	cmpwi	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
+	beq	1f
+	cmpwi	r12, BOOK3S_INTERRUPT_EXTERNAL
+	beq	1f
+
+	/* Back to EE=1 */
+	mtmsr	r4
+	sync
+	b	kvm_return_point
+
+1:	bl	call_linux_handler
+
+.global kvm_return_point
+kvm_return_point:
+	/* Restore non-volatile host registers (r14 - r31) */
+	REST_NVGPRS(r1)
+
+	addi    r1, r1, SWITCH_FRAME_SIZE
+	ld	r0, PPC_LR_STKOFF(r1)
+	mtlr	r0
+	blr
+
+call_linux_handler:
+	/* Restore host IP -> SRR0 */
+	mflr	r3
+	mtlr	r12
+
+	ld	r5, VCPU_TRAMPOLINE_LOWMEM(r7)
+	LOAD_REG_IMMEDIATE(r6, MSR_KERNEL & ~(MSR_IR | MSR_DR))
+	b	kvmppc_rmcall
+
+/*
+ * Save away FP, VMX and VSX registers.
+ * r3 = vcpu pointer
+*/
+_GLOBAL(kvmppc_save_fp)
+	mfmsr	r9
+	ori	r8,r9,MSR_FP
+#ifdef CONFIG_ALTIVEC
+#ifdef CONFIG_VSX
+	oris	r8,r8,(MSR_VEC|MSR_VSX)@h
+#else
+	oris	r8,r8,MSR_VEC@h
+#endif
+#endif
+	mtmsrd	r8
+	isync
+#ifdef CONFIG_VSX
+BEGIN_FTR_SECTION
+	reg = 0
+	.rept	32
+	li	r6,reg*16+VCPU_VSRS
+	stxvd2x	reg,r6,r3
+	reg = reg + 1
+	.endr
+FTR_SECTION_ELSE
+#endif
+	reg = 0
+	.rept	32
+	stfd	reg,reg*8+VCPU_FPRS(r3)
+	reg = reg + 1
+	.endr
+#ifdef CONFIG_VSX
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_VSX)
+#endif
+	mffs	fr0
+	stfd	fr0,VCPU_FPSCR(r3)
+
+#ifdef CONFIG_ALTIVEC
+BEGIN_FTR_SECTION
+	reg = 0
+	.rept	32
+	li	r6,reg*16+VCPU_VRS
+	stvx	reg,r6,r3
+	reg = reg + 1
+	.endr
+	mfvscr	vr0
+	li	r6,VCPU_VSCR
+	stvx	vr0,r6,r3
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+#endif
+	mfspr	r6,SPRN_VRSAVE
+	stw	r6,VCPU_VRSAVE(r3)
+	mtmsrd	r9
+	isync
+	blr
+
+/*
+ * Load up FP, VMX and VSX registers
+ * r4 = vcpu pointer
+ */
+	.globl	kvmppc_load_fp
+kvmppc_load_fp:
+	mfmsr	r9
+	ori	r8,r9,MSR_FP
+#ifdef CONFIG_ALTIVEC
+#ifdef CONFIG_VSX
+	oris	r8,r8,(MSR_VEC|MSR_VSX)@h
+#else
+	oris	r8,r8,MSR_VEC@h
+#endif
+#endif
+	mtmsrd	r8
+	isync
+	lfd	fr0,VCPU_FPSCR(r4)
+	MTFSF_L(fr0)
+#ifdef CONFIG_VSX
+BEGIN_FTR_SECTION
+	reg = 0
+	.rept	32
+	li	r7,reg*16+VCPU_VSRS
+	lxvd2x	reg,r7,r4
+	reg = reg + 1
+	.endr
+FTR_SECTION_ELSE
+#endif
+	reg = 0
+	.rept	32
+	lfd	reg,reg*8+VCPU_FPRS(r4)
+	reg = reg + 1
+	.endr
+#ifdef CONFIG_VSX
+ALT_FTR_SECTION_END_IFSET(CPU_FTR_VSX)
+#endif
+
+#ifdef CONFIG_ALTIVEC
+	li	r7,VCPU_VSCR
+	lvx	vr0,r7,r4
+	mtvscr	vr0
+BEGIN_FTR_SECTION
+	reg = 0
+	.rept	32
+	li	r7,reg*16+VCPU_VRS
+	lvx	reg,r7,r4
+	reg = reg + 1
+	.endr
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+#endif
+	lwz	r7,VCPU_VRSAVE(r4)
+	mtspr	SPRN_VRSAVE,r7
+	blr
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
new file mode 100644
index 0000000..f0dc0ff
--- /dev/null
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -0,0 +1,667 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright 2011 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
+ *
+ * Derived from book3s_rmhandlers.S and other files, which are:
+ *
+ * Copyright SUSE Linux Products GmbH 2009
+ *
+ * Authors: Alexander Graf <agraf@suse.de>
+ */
+
+#include <asm/ppc_asm.h>
+#include <asm/kvm_asm.h>
+#include <asm/reg.h>
+#include <asm/page.h>
+#include <asm/asm-offsets.h>
+#include <asm/exception-64s.h>
+
+/*****************************************************************************
+ *                                                                           *
+ *        Real Mode handlers that need to be in the linear mapping           *
+ *                                                                           *
+ ****************************************************************************/
+
+#define SHADOW_VCPU_OFF		PACA_KVM_SVCPU
+
+	.globl	kvmppc_skip_interrupt
+kvmppc_skip_interrupt:
+	mfspr	r13,SPRN_SRR0
+	addi	r13,r13,4
+	mtspr	SPRN_SRR0,r13
+	GET_SCRATCH0(r13)
+	rfid
+	b	.
+
+	.globl	kvmppc_skip_Hinterrupt
+kvmppc_skip_Hinterrupt:
+	mfspr	r13,SPRN_HSRR0
+	addi	r13,r13,4
+	mtspr	SPRN_HSRR0,r13
+	GET_SCRATCH0(r13)
+	hrfid
+	b	.
+
+/*
+ * This trampoline brings us back to a real mode handler
+ *
+ * Input Registers:
+ *
+ * R5 = SRR0
+ * R6 = SRR1
+ * R12 = real-mode IP
+ * LR = real-mode IP
+ *
+ * We have external interrupts set to come to the hypervisor using
+ * HSRR0/1, so if we're handling an external interrupt, we have to
+ * set HSRR0/1 rather than SRR0/1.
+ */
+.global kvmppc_handler_lowmem_trampoline
+kvmppc_handler_lowmem_trampoline:
+	cmpwi	r12,BOOK3S_INTERRUPT_EXTERNAL
+	beq	1f
+	mtsrr0	r3
+	mtsrr1	r4
+	blr
+1:	mtspr	SPRN_HSRR0,r3
+	mtspr	SPRN_HSRR1,r4
+	blr
+
+/*
+ * Call a function in real mode.
+ * Must be called with interrupts hard-disabled.
+ *
+ * Input Registers:
+ *
+ * R5 = function
+ * R6 = MSR
+ * R7 = scratch register
+ *
+ */
+_GLOBAL(kvmppc_rmcall)
+	mfmsr	r7
+	li	r0,MSR_RI		/* clear RI in MSR */
+	andc	r7,r7,r0
+	mtmsrd	r7,1
+	mtsrr0	r5
+	mtsrr1	r6
+	RFI
+
+.global kvmppc_trampoline_lowmem
+kvmppc_trampoline_lowmem:
+	PPC_LONG kvmppc_handler_lowmem_trampoline - _stext
+
+.global kvmppc_trampoline_enter
+kvmppc_trampoline_enter:
+	PPC_LONG kvmppc_handler_trampoline_enter - _stext
+
+#define ULONG_SIZE 		8
+#define VCPU_GPR(n)		(VCPU_GPRS + (n * ULONG_SIZE))
+
+/******************************************************************************
+ *                                                                            *
+ *                               Entry code                                   *
+ *                                                                            *
+ *****************************************************************************/
+
+.global kvmppc_handler_trampoline_enter
+kvmppc_handler_trampoline_enter:
+
+	/* Required state:
+	 *
+	 * R4 = vcpu pointer
+	 * MSR = ~IR|DR
+	 * R13 = PACA
+	 * R1 = host R1
+	 * all other volatile GPRS = free
+	 */
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
+	/* Load guest PMU registers */
+	/* R4 is live here (vcpu pointer) */
+	li	r3, 1
+	sldi	r3, r3, 31		/* MMCR0_FC (freeze counters) bit */
+	mtspr	SPRN_MMCR0, r3		/* freeze all counters, disable ints */
+	isync
+	lwz	r3, VCPU_PMC(r4)	/* always load up guest PMU registers */
+	lwz	r5, VCPU_PMC + 4(r4)	/* to prevent information leak */
+	lwz	r6, VCPU_PMC + 8(r4)
+	lwz	r7, VCPU_PMC + 12(r4)
+	lwz	r8, VCPU_PMC + 16(r4)
+	lwz	r9, VCPU_PMC + 20(r4)
+	mtspr	SPRN_PMC1, r3
+	mtspr	SPRN_PMC2, r5
+	mtspr	SPRN_PMC3, r6
+	mtspr	SPRN_PMC4, r7
+	mtspr	SPRN_PMC5, r8
+	mtspr	SPRN_PMC6, r9
+	ld	r3, VCPU_MMCR(r4)
+	ld	r5, VCPU_MMCR + 8(r4)
+	ld	r6, VCPU_MMCR + 16(r4)
+	mtspr	SPRN_MMCR1, r5
+	mtspr	SPRN_MMCRA, r6
+	mtspr	SPRN_MMCR0, r3
+	isync
+
+	/* Load up FP, VMX and VSX registers */
+	bl	kvmppc_load_fp
+
+	/* Switch DSCR to guest value */
+	ld	r5, VCPU_DSCR(r4)
+	mtspr	SPRN_DSCR, r5
+
+	/*
+	 * Set the decrementer to the guest decrementer.
+	 */
+	ld	r8,VCPU_DEC_EXPIRES(r4)
+	mftb	r7
+	subf	r3,r7,r8
+	mtspr	SPRN_DEC,r3
+	stw	r3,VCPU_DEC(r4)
+
+	ld	r5, VCPU_SPRG0(r4)
+	ld	r6, VCPU_SPRG1(r4)
+	ld	r7, VCPU_SPRG2(r4)
+	ld	r8, VCPU_SPRG3(r4)
+	mtspr	SPRN_SPRG0, r5
+	mtspr	SPRN_SPRG1, r6
+	mtspr	SPRN_SPRG2, r7
+	mtspr	SPRN_SPRG3, r8
+
+	/* Save R1 in the PACA */
+	std	r1, HSTATE_HOST_R1(r13)
+
+	/* Load up DAR and DSISR */
+	ld	r5, VCPU_DAR(r4)
+	lwz	r6, VCPU_DSISR(r4)
+	mtspr	SPRN_DAR, r5
+	mtspr	SPRN_DSISR, r6
+
+	/* Set partition DABR */
+	li	r5,3
+	ld	r6,VCPU_DABR(r4)
+	mtspr	SPRN_DABRX,r5
+	mtspr	SPRN_DABR,r6
+
+	/* Restore AMR and UAMOR, set AMOR to all 1s */
+	ld	r5,VCPU_AMR(r4)
+	ld	r6,VCPU_UAMOR(r4)
+	li	r7,-1
+	mtspr	SPRN_AMR,r5
+	mtspr	SPRN_UAMOR,r6
+	mtspr	SPRN_AMOR,r7
+
+	/* Clear out SLB */
+	li	r6,0
+	slbmte	r6,r6
+	slbia
+	ptesync
+
+	/* Switch to guest partition. */
+	ld	r9,VCPU_KVM(r4)		/* pointer to struct kvm */
+	ld	r6,KVM_SDR1(r9)
+	lwz	r7,KVM_LPID(r9)
+	li	r0,LPID_RSVD		/* switch to reserved LPID */
+	mtspr	SPRN_LPID,r0
+	ptesync
+	mtspr	SPRN_SDR1,r6		/* switch to partition page table */
+	mtspr	SPRN_LPID,r7
+	isync
+	ld	r8,VCPU_LPCR(r4)
+	mtspr	SPRN_LPCR,r8
+	isync
+
+	/* Check if HDEC expires soon */
+	mfspr	r3,SPRN_HDEC
+	cmpwi	r3,10
+	li	r12,BOOK3S_INTERRUPT_HV_DECREMENTER
+	mr	r9,r4
+	blt	hdec_soon
+
+	/*
+	 * Invalidate the TLB if we could possibly have stale TLB
+	 * entries for this partition on this core due to the use
+	 * of tlbiel.
+	 */
+	ld	r9,VCPU_KVM(r4)		/* pointer to struct kvm */
+	lwz	r5,VCPU_VCPUID(r4)
+	lhz	r6,PACAPACAINDEX(r13)
+	lhz	r8,VCPU_LAST_CPU(r4)
+	sldi	r7,r6,1			/* see if this is the same vcpu */
+	add	r7,r7,r9		/* as last ran on this pcpu */
+	lhz	r0,KVM_LAST_VCPU(r7)
+	cmpw	r6,r8			/* on the same cpu core as last time? */
+	bne	3f
+	cmpw	r0,r5			/* same vcpu as this core last ran? */
+	beq	1f
+3:	sth	r6,VCPU_LAST_CPU(r4)	/* if not, invalidate partition TLB */
+	sth	r5,KVM_LAST_VCPU(r7)
+	li	r6,128
+	mtctr	r6
+	li	r7,0x800		/* IS field = 0b10 */
+	ptesync
+2:	tlbiel	r7
+	addi	r7,r7,0x1000
+	bdnz	2b
+	ptesync
+1:
+
+	/* Save purr/spurr */
+	mfspr	r5,SPRN_PURR
+	mfspr	r6,SPRN_SPURR
+	std	r5,HSTATE_PURR(r13)
+	std	r6,HSTATE_SPURR(r13)
+	ld	r7,VCPU_PURR(r4)
+	ld	r8,VCPU_SPURR(r4)
+	mtspr	SPRN_PURR,r7
+	mtspr	SPRN_SPURR,r8
+
+	/* Load up guest SLB entries */
+	lwz	r5,VCPU_SLB_MAX(r4)
+	cmpwi	r5,0
+	beq	9f
+	mtctr	r5
+	addi	r6,r4,VCPU_SLB
+1:	ld	r8,VCPU_SLB_E(r6)
+	ld	r9,VCPU_SLB_V(r6)
+	slbmte	r9,r8
+	addi	r6,r6,VCPU_SLB_SIZE
+	bdnz	1b
+9:
+
+	/* Restore state of CTRL run bit; assume 1 on entry */
+	lwz	r5,VCPU_CTRL(r4)
+	andi.	r5,r5,1
+	bne	4f
+	mfspr	r6,SPRN_CTRLF
+	clrrdi	r6,r6,1
+	mtspr	SPRN_CTRLT,r6
+4:
+	ld	r6, VCPU_CTR(r4)
+	lwz	r7, VCPU_XER(r4)
+
+	mtctr	r6
+	mtxer	r7
+
+	/* Move SRR0 and SRR1 into the respective regs */
+	ld	r6, VCPU_SRR0(r4)
+	ld	r7, VCPU_SRR1(r4)
+	mtspr	SPRN_SRR0, r6
+	mtspr	SPRN_SRR1, r7
+
+	ld	r10, VCPU_PC(r4)
+
+	ld	r11, VCPU_MSR(r4)	/* r10 = vcpu->arch.msr & ~MSR_HV */
+	rldicl	r11, r11, 63 - MSR_HV_LG, 1
+	rotldi	r11, r11, 1 + MSR_HV_LG
+	ori	r11, r11, MSR_ME
+
+fast_guest_return:
+	mtspr	SPRN_HSRR0,r10
+	mtspr	SPRN_HSRR1,r11
+
+	/* Activate guest mode, so faults get handled by KVM */
+	li	r9, KVM_GUEST_MODE_GUEST
+	stb	r9, HSTATE_IN_GUEST(r13)
+
+	/* Enter guest */
+
+	ld	r5, VCPU_LR(r4)
+	lwz	r6, VCPU_CR(r4)
+	mtlr	r5
+	mtcr	r6
+
+	ld	r0, VCPU_GPR(r0)(r4)
+	ld	r1, VCPU_GPR(r1)(r4)
+	ld	r2, VCPU_GPR(r2)(r4)
+	ld	r3, VCPU_GPR(r3)(r4)
+	ld	r5, VCPU_GPR(r5)(r4)
+	ld	r6, VCPU_GPR(r6)(r4)
+	ld	r7, VCPU_GPR(r7)(r4)
+	ld	r8, VCPU_GPR(r8)(r4)
+	ld	r9, VCPU_GPR(r9)(r4)
+	ld	r10, VCPU_GPR(r10)(r4)
+	ld	r11, VCPU_GPR(r11)(r4)
+	ld	r12, VCPU_GPR(r12)(r4)
+	ld	r13, VCPU_GPR(r13)(r4)
+
+	ld	r4, VCPU_GPR(r4)(r4)
+
+	hrfid
+	b	.
+kvmppc_handler_trampoline_enter_end:
+
+
+/******************************************************************************
+ *                                                                            *
+ *                               Exit code                                    *
+ *                                                                            *
+ *****************************************************************************/
+
+/*
+ * We come here from the first-level interrupt handlers.
+ */
+	.globl	kvmppc_interrupt
+kvmppc_interrupt:
+	/*
+	 * Register contents:
+	 * R12		= interrupt vector
+	 * R13		= PACA
+	 * guest CR, R12 saved in shadow VCPU SCRATCH1/0
+	 * guest R13 saved in SPRN_SCRATCH0
+	 */
+	/* abuse host_r2 as third scratch area; we get r2 from PACATOC(r13) */
+	std	r9, HSTATE_HOST_R2(r13)
+	ld	r9, HSTATE_KVM_VCPU(r13)
+
+	/* Save registers */
+
+	std	r0, VCPU_GPR(r0)(r9)
+	std	r1, VCPU_GPR(r1)(r9)
+	std	r2, VCPU_GPR(r2)(r9)
+	std	r3, VCPU_GPR(r3)(r9)
+	std	r4, VCPU_GPR(r4)(r9)
+	std	r5, VCPU_GPR(r5)(r9)
+	std	r6, VCPU_GPR(r6)(r9)
+	std	r7, VCPU_GPR(r7)(r9)
+	std	r8, VCPU_GPR(r8)(r9)
+	ld	r0, HSTATE_HOST_R2(r13)
+	std	r0, VCPU_GPR(r9)(r9)
+	std	r10, VCPU_GPR(r10)(r9)
+	std	r11, VCPU_GPR(r11)(r9)
+	ld	r3, HSTATE_SCRATCH0(r13)
+	lwz	r4, HSTATE_SCRATCH1(r13)
+	std	r3, VCPU_GPR(r12)(r9)
+	stw	r4, VCPU_CR(r9)
+
+	/* Restore R1/R2 so we can handle faults */
+	ld	r1, HSTATE_HOST_R1(r13)
+	ld	r2, PACATOC(r13)
+
+	mfspr	r10, SPRN_SRR0
+	mfspr	r11, SPRN_SRR1
+	std	r10, VCPU_SRR0(r9)
+	std	r11, VCPU_SRR1(r9)
+	andi.	r0, r12, 2		/* need to read HSRR0/1? */
+	beq	1f
+	mfspr	r10, SPRN_HSRR0
+	mfspr	r11, SPRN_HSRR1
+	clrrdi	r12, r12, 2
+1:	std	r10, VCPU_PC(r9)
+	std	r11, VCPU_MSR(r9)
+
+	GET_SCRATCH0(r3)
+	mflr	r4
+	std	r3, VCPU_GPR(r13)(r9)
+	std	r4, VCPU_LR(r9)
+
+	/* Unset guest mode */
+	li	r0, KVM_GUEST_MODE_NONE
+	stb	r0, HSTATE_IN_GUEST(r13)
+
+	stw	r12,VCPU_TRAP(r9)
+
+	/* See if this is a leftover HDEC interrupt */
+	cmpwi	r12,BOOK3S_INTERRUPT_HV_DECREMENTER
+	bne	2f
+	mfspr	r3,SPRN_HDEC
+	cmpwi	r3,0
+	bge	ignore_hdec
+2:
+
+	/* Check for mediated interrupts (could be done earlier really ...) */
+	cmpwi	r12,BOOK3S_INTERRUPT_EXTERNAL
+	bne+	1f
+	ld	r5,VCPU_LPCR(r9)
+	andi.	r0,r11,MSR_EE
+	beq	1f
+	andi.	r0,r5,LPCR_MER
+	bne	bounce_ext_interrupt
+1:
+
+	/* Save DEC */
+	mfspr	r5,SPRN_DEC
+	mftb	r6
+	extsw	r5,r5
+	add	r5,r5,r6
+	std	r5,VCPU_DEC_EXPIRES(r9)
+
+	/* Save HEIR (HV emulation assist reg) in last_inst
+	   if this is an HEI (HV emulation interrupt, e40) */
+	li	r3,-1
+	cmpwi	r12,BOOK3S_INTERRUPT_H_EMUL_ASSIST
+	bne	11f
+	mfspr	r3,SPRN_HEIR
+11:	stw	r3,VCPU_LAST_INST(r9)
+
+	/* Save more register state  */
+	mfxer	r5
+	mfdar	r6
+	mfdsisr	r7
+	mfctr	r8
+
+	stw	r5, VCPU_XER(r9)
+	std	r6, VCPU_DAR(r9)
+	stw	r7, VCPU_DSISR(r9)
+	std	r8, VCPU_CTR(r9)
+	/* grab HDAR & HDSISR if HV data storage interrupt (HDSI) */
+	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
+	beq	6f
+7:	std	r6, VCPU_FAULT_DAR(r9)
+	stw	r7, VCPU_FAULT_DSISR(r9)
+
+	/* Save guest CTRL register, set runlatch to 1 */
+	mfspr	r6,SPRN_CTRLF
+	stw	r6,VCPU_CTRL(r9)
+	andi.	r0,r6,1
+	bne	4f
+	ori	r6,r6,1
+	mtspr	SPRN_CTRLT,r6
+4:
+	/* Read the guest SLB and save it away */
+	lwz	r0,VCPU_SLB_NR(r9)	/* number of entries in SLB */
+	mtctr	r0
+	li	r6,0
+	addi	r7,r9,VCPU_SLB
+	li	r5,0
+1:	slbmfee	r8,r6
+	andis.	r0,r8,SLB_ESID_V@h
+	beq	2f
+	add	r8,r8,r6		/* put index in */
+	slbmfev	r3,r6
+	std	r8,VCPU_SLB_E(r7)
+	std	r3,VCPU_SLB_V(r7)
+	addi	r7,r7,VCPU_SLB_SIZE
+	addi	r5,r5,1
+2:	addi	r6,r6,1
+	bdnz	1b
+	stw	r5,VCPU_SLB_MAX(r9)
+
+	/*
+	 * Save the guest PURR/SPURR
+	 */
+	mfspr	r5,SPRN_PURR
+	mfspr	r6,SPRN_SPURR
+	ld	r7,VCPU_PURR(r9)
+	ld	r8,VCPU_SPURR(r9)
+	std	r5,VCPU_PURR(r9)
+	std	r6,VCPU_SPURR(r9)
+	subf	r5,r7,r5
+	subf	r6,r8,r6
+
+	/*
+	 * Restore host PURR/SPURR and add guest times
+	 * so that the time in the guest gets accounted.
+	 */
+	ld	r3,HSTATE_PURR(r13)
+	ld	r4,HSTATE_SPURR(r13)
+	add	r3,r3,r5
+	add	r4,r4,r6
+	mtspr	SPRN_PURR,r3
+	mtspr	SPRN_SPURR,r4
+
+	/* Clear out SLB */
+	li	r5,0
+	slbmte	r5,r5
+	slbia
+	ptesync
+
+hdec_soon:
+	/* Switch back to host partition */
+	ld	r4,VCPU_KVM(r9)		/* pointer to struct kvm */
+	ld	r6,KVM_HOST_SDR1(r4)
+	lwz	r7,KVM_HOST_LPID(r4)
+	li	r8,LPID_RSVD		/* switch to reserved LPID */
+	mtspr	SPRN_LPID,r8
+	ptesync
+	mtspr	SPRN_SDR1,r6		/* switch to partition page table */
+	mtspr	SPRN_LPID,r7
+	isync
+	lis	r8,0x7fff		/* MAX_INT@h */
+	mtspr	SPRN_HDEC,r8
+
+	ld	r8,KVM_HOST_LPCR(r4)
+	mtspr	SPRN_LPCR,r8
+	isync
+
+	/* load host SLB entries */
+	ld	r8,PACA_SLBSHADOWPTR(r13)
+
+	.rept	SLB_NUM_BOLTED
+	ld	r5,SLBSHADOW_SAVEAREA(r8)
+	ld	r6,SLBSHADOW_SAVEAREA+8(r8)
+	andis.	r7,r5,SLB_ESID_V@h
+	beq	1f
+	slbmte	r6,r5
+1:	addi	r8,r8,16
+	.endr
+
+	/* Save and reset AMR and UAMOR before turning on the MMU */
+	mfspr	r5,SPRN_AMR
+	mfspr	r6,SPRN_UAMOR
+	std	r5,VCPU_AMR(r9)
+	std	r6,VCPU_UAMOR(r9)
+	li	r6,0
+	mtspr	SPRN_AMR,r6
+
+	/* Restore host DABR and DABRX */
+	ld	r5,HSTATE_DABR(r13)
+	li	r6,7
+	mtspr	SPRN_DABR,r5
+	mtspr	SPRN_DABRX,r6
+
+	/* Switch DSCR back to host value */
+	mfspr	r8, SPRN_DSCR
+	ld	r7, HSTATE_DSCR(r13)
+	std	r8, VCPU_DSCR(r7)
+	mtspr	SPRN_DSCR, r7
+
+	/* Save non-volatile GPRs */
+	std	r14, VCPU_GPR(r14)(r9)
+	std	r15, VCPU_GPR(r15)(r9)
+	std	r16, VCPU_GPR(r16)(r9)
+	std	r17, VCPU_GPR(r17)(r9)
+	std	r18, VCPU_GPR(r18)(r9)
+	std	r19, VCPU_GPR(r19)(r9)
+	std	r20, VCPU_GPR(r20)(r9)
+	std	r21, VCPU_GPR(r21)(r9)
+	std	r22, VCPU_GPR(r22)(r9)
+	std	r23, VCPU_GPR(r23)(r9)
+	std	r24, VCPU_GPR(r24)(r9)
+	std	r25, VCPU_GPR(r25)(r9)
+	std	r26, VCPU_GPR(r26)(r9)
+	std	r27, VCPU_GPR(r27)(r9)
+	std	r28, VCPU_GPR(r28)(r9)
+	std	r29, VCPU_GPR(r29)(r9)
+	std	r30, VCPU_GPR(r30)(r9)
+	std	r31, VCPU_GPR(r31)(r9)
+
+	/* Save SPRGs */
+	mfspr	r3, SPRN_SPRG0
+	mfspr	r4, SPRN_SPRG1
+	mfspr	r5, SPRN_SPRG2
+	mfspr	r6, SPRN_SPRG3
+	std	r3, VCPU_SPRG0(r9)
+	std	r4, VCPU_SPRG1(r9)
+	std	r5, VCPU_SPRG2(r9)
+	std	r6, VCPU_SPRG3(r9)
+
+	/* Save PMU registers */
+	li	r3, 1
+	sldi	r3, r3, 31		/* MMCR0_FC (freeze counters) bit */
+	mfspr	r4, SPRN_MMCR0		/* save MMCR0 */
+	mtspr	SPRN_MMCR0, r3		/* freeze all counters, disable ints */
+	isync
+	mfspr	r5, SPRN_MMCR1
+	mfspr	r6, SPRN_MMCRA
+	std	r4, VCPU_MMCR(r9)
+	std	r5, VCPU_MMCR + 8(r9)
+	std	r6, VCPU_MMCR + 16(r9)
+	mfspr	r3, SPRN_PMC1
+	mfspr	r4, SPRN_PMC2
+	mfspr	r5, SPRN_PMC3
+	mfspr	r6, SPRN_PMC4
+	mfspr	r7, SPRN_PMC5
+	mfspr	r8, SPRN_PMC6
+	stw	r3, VCPU_PMC(r9)
+	stw	r4, VCPU_PMC + 4(r9)
+	stw	r5, VCPU_PMC + 8(r9)
+	stw	r6, VCPU_PMC + 12(r9)
+	stw	r7, VCPU_PMC + 16(r9)
+	stw	r8, VCPU_PMC + 20(r9)
+22:
+	/* save FP state */
+	mr	r3, r9
+	bl	.kvmppc_save_fp
+
+	/* RFI into the highmem handler */
+	mfmsr	r7
+	ori	r7, r7, MSR_IR|MSR_DR|MSR_RI|MSR_ME	/* Enable paging */
+	mtsrr1	r7
+	/* Load highmem handler address */
+	ld	r8, VCPU_HIGHMEM_HANDLER(r3)
+	mtsrr0	r8
+
+	RFI
+kvmppc_handler_trampoline_exit_end:
+
+6:	mfspr	r6,SPRN_HDAR
+	mfspr	r7,SPRN_HDSISR
+	b	7b
+
+ignore_hdec:
+	mr	r4,r9
+	b	fast_guest_return
+
+bounce_ext_interrupt:
+	mr	r4,r9
+	mtspr	SPRN_SRR0,r10
+	mtspr	SPRN_SRR1,r11
+	li	r10,BOOK3S_INTERRUPT_EXTERNAL
+	LOAD_REG_IMMEDIATE(r11,MSR_SF | MSR_ME);
+	b	fast_guest_return
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index b0ae527..174d59c 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -85,29 +85,29 @@ kvmppc_handler_trampoline_enter:
 
 	/* Enter guest */
 
-	PPC_LL	r4, (SVCPU_CTR)(r3)
-	PPC_LL	r5, (SVCPU_LR)(r3)
-	lwz	r6, (SVCPU_CR)(r3)
-	lwz	r7, (SVCPU_XER)(r3)
+	PPC_LL	r4, SVCPU_CTR(r3)
+	PPC_LL	r5, SVCPU_LR(r3)
+	lwz	r6, SVCPU_CR(r3)
+	lwz	r7, SVCPU_XER(r3)
 
 	mtctr	r4
 	mtlr	r5
 	mtcr	r6
 	mtxer	r7
 
-	PPC_LL	r0, (SVCPU_R0)(r3)
-	PPC_LL	r1, (SVCPU_R1)(r3)
-	PPC_LL	r2, (SVCPU_R2)(r3)
-	PPC_LL	r4, (SVCPU_R4)(r3)
-	PPC_LL	r5, (SVCPU_R5)(r3)
-	PPC_LL	r6, (SVCPU_R6)(r3)
-	PPC_LL	r7, (SVCPU_R7)(r3)
-	PPC_LL	r8, (SVCPU_R8)(r3)
-	PPC_LL	r9, (SVCPU_R9)(r3)
-	PPC_LL	r10, (SVCPU_R10)(r3)
-	PPC_LL	r11, (SVCPU_R11)(r3)
-	PPC_LL	r12, (SVCPU_R12)(r3)
-	PPC_LL	r13, (SVCPU_R13)(r3)
+	PPC_LL	r0, SVCPU_R0(r3)
+	PPC_LL	r1, SVCPU_R1(r3)
+	PPC_LL	r2, SVCPU_R2(r3)
+	PPC_LL	r4, SVCPU_R4(r3)
+	PPC_LL	r5, SVCPU_R5(r3)
+	PPC_LL	r6, SVCPU_R6(r3)
+	PPC_LL	r7, SVCPU_R7(r3)
+	PPC_LL	r8, SVCPU_R8(r3)
+	PPC_LL	r9, SVCPU_R9(r3)
+	PPC_LL	r10, SVCPU_R10(r3)
+	PPC_LL	r11, SVCPU_R11(r3)
+	PPC_LL	r12, SVCPU_R12(r3)
+	PPC_LL	r13, SVCPU_R13(r3)
 
 	PPC_LL	r3, (SVCPU_R3)(r3)
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 026036e..3a4f379 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -38,8 +38,12 @@
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
+#ifndef CONFIG_KVM_BOOK3S_64_HV
 	return !(v->arch.shared->msr & MSR_WE) ||
 	       !!(v->arch.pending_exceptions);
+#else
+	return 1;
+#endif
 }
 
 int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
@@ -184,10 +188,13 @@ int kvm_dev_ioctl_check_extension(long ext)
 #else
 	case KVM_CAP_PPC_SEGSTATE:
 #endif
-	case KVM_CAP_PPC_PAIRED_SINGLES:
 	case KVM_CAP_PPC_UNSET_IRQ:
 	case KVM_CAP_PPC_IRQ_LEVEL:
 	case KVM_CAP_ENABLE_CAP:
+		r = 1;
+		break;
+#ifndef CONFIG_KVM_BOOK3S_64_HV
+	case KVM_CAP_PPC_PAIRED_SINGLES:
 	case KVM_CAP_PPC_OSI:
 	case KVM_CAP_PPC_GET_PVINFO:
 		r = 1;
@@ -195,6 +202,7 @@ int kvm_dev_ioctl_check_extension(long ext)
 	case KVM_CAP_COALESCED_MMIO:
 		r = KVM_COALESCED_MMIO_PAGE_OFFSET;
 		break;
+#endif
 	default:
 		r = 0;
 		break;
@@ -291,6 +299,7 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	hrtimer_init(&vcpu->arch.dec_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
 	tasklet_init(&vcpu->arch.tasklet, kvmppc_decrementer_func, (ulong)vcpu);
 	vcpu->arch.dec_timer.function = kvmppc_decrementer_wakeup;
+	vcpu->arch.dec_expires = ~(u64)0;
 
 #ifdef CONFIG_KVM_EXIT_TIMING
 	mutex_init(&vcpu->arch.exit_timing_lock);
@@ -317,6 +326,7 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	mtspr(SPRN_VRSAVE, vcpu->arch.vrsave);
 #endif
 	kvmppc_core_vcpu_load(vcpu, cpu);
+	vcpu->cpu = smp_processor_id();
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -325,6 +335,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 #ifdef CONFIG_BOOKE
 	vcpu->arch.vrsave = mfspr(SPRN_VRSAVE);
 #endif
+	vcpu->cpu = -1;
 }
 
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
@@ -496,6 +507,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		for (i = 0; i < 32; i++)
 			kvmppc_set_gpr(vcpu, i, gprs[i]);
 		vcpu->arch.osi_needed = 0;
+	} else if (vcpu->arch.hcall_needed) {
+		int i;
+
+		kvmppc_set_gpr(vcpu, 3, run->papr_hcall.ret);
+		for (i = 0; i < 9; ++i)
+			kvmppc_set_gpr(vcpu, 4 + i, run->papr_hcall.args[i]);
+		vcpu->arch.hcall_needed = 0;
 	}
 
 	kvmppc_core_deliver_interrupts(vcpu);
@@ -518,6 +536,8 @@ int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
 	if (waitqueue_active(&vcpu->wq)) {
 		wake_up_interruptible(&vcpu->wq);
 		vcpu->stat.halt_wakeup++;
+	} else if (vcpu->cpu != -1) {
+		smp_send_reschedule(vcpu->cpu);
 	}
 
 	return 0;
diff --git a/arch/powerpc/kvm/trace.h b/arch/powerpc/kvm/trace.h
index d62a14b..b135d3d 100644
--- a/arch/powerpc/kvm/trace.h
+++ b/arch/powerpc/kvm/trace.h
@@ -103,7 +103,7 @@ TRACE_EVENT(kvm_gtlb_write,
  *                         Book3S trace points                           *
  *************************************************************************/
 
-#ifdef CONFIG_PPC_BOOK3S
+#ifdef CONFIG_KVM_BOOK3S_PR
 
 TRACE_EVENT(kvm_book3s_exit,
 	TP_PROTO(unsigned int exit_nr, struct kvm_vcpu *vcpu),
diff --git a/include/linux/kvm.h b/include/linux/kvm.h
index 9c9ca7c..a156294 100644
--- a/include/linux/kvm.h
+++ b/include/linux/kvm.h
@@ -161,6 +161,7 @@ struct kvm_pit_config {
 #define KVM_EXIT_NMI              16
 #define KVM_EXIT_INTERNAL_ERROR   17
 #define KVM_EXIT_OSI              18
+#define KVM_EXIT_PAPR_HCALL	  19
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 #define KVM_INTERNAL_ERROR_EMULATION 1
@@ -264,6 +265,11 @@ struct kvm_run {
 		struct {
 			__u64 gprs[32];
 		} osi;
+		struct {
+			__u64 nr;
+			__u64 ret;
+			__u64 args[9];
+		} papr_hcall;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
-- 
1.7.5.4
