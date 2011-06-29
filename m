Return-Path: <paulus@ozlabs.org>
Date: Wed, 29 Jun 2011 20:40:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
	Alexander Graf <agraf@suse.de>
Subject: [PATCH 16/17] KVM: PPC: book3s_hv: Add support for PPC970-family
	processors
Message-ID: <20110629104008.GQ25406@bloggs.ozlabs.ibm.com>
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

This adds support for running KVM guests in supervisor mode on those
PPC970 processors that have a usable hypervisor mode.  Unfortunately,
Apple G5 machines have supervisor mode disabled (MSR[HV] is forced to
1), but the YDL PowerStation does have a usable hypervisor mode.

There are several differences between the PPC970 and POWER7 in how
guests are managed.  These differences are accommodated using the
CPU_FTR_ARCH_201 (PPC970) and CPU_FTR_ARCH_206 (POWER7) CPU feature
bits.  Notably, on PPC970:

* The LPCR, LPID or RMOR registers don't exist, and the functions of
  those registers are provided by bits in HID4 and one bit in HID0.

* External interrupts can be directed to the hypervisor, but unlike
  POWER7 they are masked by MSR[EE] in non-hypervisor modes and use
  SRR0/1 not HSRR0/1.

* There is no virtual RMA (VRMA) mode; the guest must use an RMO
  (real mode offset) area.

* The TLB entries are not tagged with the LPID, so it is necessary to
  flush the whole TLB on partition switch.  Furthermore, when switching
  partitions we have to ensure that no other CPU is executing the tlbie
  or tlbsync instructions in either the old or the new partition,
  otherwise undefined behaviour can occur.

* The PMU has 8 counters (PMC registers) rather than 6.

* The DSCR, PURR, SPURR, AMR, AMOR, UAMOR registers don't exist.

* The SLB has 64 entries rather than 32.

* There is no mediated external interrupt facility, so if we switch to
  a guest that has a virtual external interrupt pending but the guest
  has MSR[EE] = 0, we have to arrange to have an interrupt pending for
  it so that we can get control back once it re-enables interrupts.  We
  do that by sending ourselves an IPI with smp_send_reschedule after
  hard-disabling interrupts.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/exception-64s.h  |    4 +
 arch/powerpc/include/asm/kvm_book3s_asm.h |    2 +-
 arch/powerpc/include/asm/kvm_host.h       |    2 +-
 arch/powerpc/kernel/asm-offsets.c         |    1 +
 arch/powerpc/kernel/exceptions-64s.S      |    2 +-
 arch/powerpc/kvm/Kconfig                  |   13 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c       |   30 +++-
 arch/powerpc/kvm/book3s_hv.c              |   60 ++++++--
 arch/powerpc/kvm/book3s_hv_builtin.c      |   11 +-
 arch/powerpc/kvm/book3s_hv_interrupts.S   |   30 ++++
 arch/powerpc/kvm/book3s_hv_rm_mmu.c       |    6 +-
 arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  230 ++++++++++++++++++++++++++++-
 arch/powerpc/kvm/powerpc.c                |    3 +
 arch/powerpc/mm/hash_native_64.c          |    2 +-
 14 files changed, 354 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 69435da..8057f4f 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -246,6 +246,10 @@ label##_hv:						\
 	KVMTEST(vec);							\
 	_SOFTEN_TEST(EXC_HV)
 
+#define SOFTEN_TEST_HV_201(vec)						\
+	KVMTEST(vec);							\
+	_SOFTEN_TEST(EXC_STD)
+
 #define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
 	HMT_MEDIUM;							\
 	SET_SCRATCH0(r13);    /* save r13 */				\
diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
index 9cfd543..ef7b368 100644
--- a/arch/powerpc/include/asm/kvm_book3s_asm.h
+++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
@@ -82,7 +82,7 @@ struct kvmppc_host_state {
 	unsigned long xics_phys;
 	u64 dabr;
 	u64 host_mmcr[3];
-	u32 host_pmc[6];
+	u32 host_pmc[8];
 	u64 host_purr;
 	u64 host_spurr;
 	u64 host_dscr;
diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index f572d9c..cc22b28 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -353,7 +353,7 @@ struct kvm_vcpu_arch {
 	u32 dbsr;
 
 	u64 mmcr[3];
-	u32 pmc[6];
+	u32 pmc[8];
 
 #ifdef CONFIG_KVM_EXIT_TIMING
 	struct mutex exit_timing_lock;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index f4aba93..54b935f 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -128,6 +128,7 @@ int main(void)
 	DEFINE(ICACHEL1LINESPERPAGE, offsetof(struct ppc64_caches, ilines_per_page));
 	/* paca */
 	DEFINE(PACA_SIZE, sizeof(struct paca_struct));
+	DEFINE(PACA_LOCK_TOKEN, offsetof(struct paca_struct, lock_token));
 	DEFINE(PACAPACAINDEX, offsetof(struct paca_struct, paca_index));
 	DEFINE(PACAPROCSTART, offsetof(struct paca_struct, cpu_start));
 	DEFINE(PACAKSAVE, offsetof(struct paca_struct, kstack));
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a534538..41b02c7 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -171,7 +171,7 @@ hardware_interrupt_hv:
 		KVM_HANDLER(PACA_EXGEN, EXC_HV, 0x502)
 	FTR_SECTION_ELSE
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt,
-					    EXC_STD, SOFTEN_TEST_PR)
+					    EXC_STD, SOFTEN_TEST_HV_201)
 		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
 	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 
diff --git a/arch/powerpc/kvm/Kconfig b/arch/powerpc/kvm/Kconfig
index 5d9b78e..eeb42e0 100644
--- a/arch/powerpc/kvm/Kconfig
+++ b/arch/powerpc/kvm/Kconfig
@@ -67,23 +67,20 @@ config KVM_BOOK3S_64
 	  If unsure, say N.
 
 config KVM_BOOK3S_64_HV
-	bool "KVM support for POWER7 using hypervisor mode in host"
+	bool "KVM support for POWER7 and PPC970 using hypervisor mode in host"
 	depends on KVM_BOOK3S_64
 	---help---
 	  Support running unmodified book3s_64 guest kernels in
-	  virtual machines on POWER7 processors that have hypervisor
-	  mode available to the host.
+	  virtual machines on POWER7 and PPC970 processors that have
+	  hypervisor mode available to the host.
 
 	  If you say Y here, KVM will use the hardware virtualization
 	  facilities of POWER7 (and later) processors, meaning that
 	  guest operating systems will run at full hardware speed
 	  using supervisor and user modes.  However, this also means
 	  that KVM is not usable under PowerVM (pHyp), is only usable
-	  on POWER7 (or later) processors, and can only emulate
-	  POWER5+, POWER6 and POWER7 processors.
-
-	  This module provides access to the hardware capabilities through
-	  a character device node named /dev/kvm.
+	  on POWER7 (or later) processors and PPC970-family processors,
+	  and cannot emulate a different processor from the host processor.
 
 	  If unsure, say N.
 
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 212dcd8..bc3a2ea 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -42,6 +42,8 @@
 #define VRMA_PAGE_ORDER	24
 #define VRMA_VSID	0x1ffffffUL	/* 1TB VSID reserved for VRMA */
 
+/* POWER7 has 10-bit LPIDs, PPC970 has 6-bit LPIDs */
+#define MAX_LPID_970	63
 #define NR_LPIDS	(LPID_RSVD + 1)
 unsigned long lpid_inuse[BITS_TO_LONGS(NR_LPIDS)];
 
@@ -69,9 +71,6 @@ long kvmppc_alloc_hpt(struct kvm *kvm)
 
 	kvm->arch.sdr1 = __pa(hpt) | (HPT_ORDER - 18);
 	kvm->arch.lpid = lpid;
-	kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
-	kvm->arch.host_lpid = mfspr(SPRN_LPID);
-	kvm->arch.host_lpcr = mfspr(SPRN_LPCR);
 
 	pr_info("KVM guest htab at %lx, LPID %lx\n", hpt, lpid);
 	return 0;
@@ -128,12 +127,24 @@ void kvmppc_map_vrma(struct kvm *kvm, struct kvm_userspace_memory_region *mem)
 
 int kvmppc_mmu_hv_init(void)
 {
-	if (!cpu_has_feature(CPU_FTR_HVMODE) ||
-	    !cpu_has_feature(CPU_FTR_ARCH_206))
+	unsigned long host_lpid, rsvd_lpid;
+
+	if (!cpu_has_feature(CPU_FTR_HVMODE))
 		return -EINVAL;
+
 	memset(lpid_inuse, 0, sizeof(lpid_inuse));
-	set_bit(mfspr(SPRN_LPID), lpid_inuse);
-	set_bit(LPID_RSVD, lpid_inuse);
+
+	if (cpu_has_feature(CPU_FTR_ARCH_206)) {
+		host_lpid = mfspr(SPRN_LPID);	/* POWER7 */
+		rsvd_lpid = LPID_RSVD;
+	} else {
+		host_lpid = 0;			/* PPC970 */
+		rsvd_lpid = MAX_LPID_970;
+	}
+
+	set_bit(host_lpid, lpid_inuse);
+	/* rsvd_lpid is reserved for use in partition switching */
+	set_bit(rsvd_lpid, lpid_inuse);
 
 	return 0;
 }
@@ -157,7 +168,10 @@ void kvmppc_mmu_book3s_hv_init(struct kvm_vcpu *vcpu)
 {
 	struct kvmppc_mmu *mmu = &vcpu->arch.mmu;
 
-	vcpu->arch.slb_nr = 32;		/* Assume POWER7 for now */
+	if (cpu_has_feature(CPU_FTR_ARCH_206))
+		vcpu->arch.slb_nr = 32;		/* POWER7 */
+	else
+		vcpu->arch.slb_nr = 64;
 
 	mmu->xlate = kvmppc_mmu_book3s_64_hv_xlate;
 	mmu->reset_msr = kvmppc_mmu_book3s_64_hv_reset_msr;
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index dc70e77..cc0d7f1 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -443,8 +443,7 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 
 int kvmppc_core_check_processor_compat(void)
 {
-	if (cpu_has_feature(CPU_FTR_HVMODE) &&
-	    cpu_has_feature(CPU_FTR_ARCH_206))
+	if (cpu_has_feature(CPU_FTR_HVMODE))
 		return 0;
 	return -EIO;
 }
@@ -731,6 +730,10 @@ static int kvmppc_run_vcpu(struct kvm_run *kvm_run, struct kvm_vcpu *vcpu)
 		return -EINTR;
 	}
 
+	/* On PPC970, check that we have an RMA region */
+	if (!vcpu->kvm->arch.rma && cpu_has_feature(CPU_FTR_ARCH_201))
+		return -EPERM;
+
 	kvm_run->exit_reason = 0;
 	vcpu->arch.ret = RESUME_GUEST;
 	vcpu->arch.trap = 0;
@@ -920,12 +923,14 @@ fail:
 }
 
 /* Work out RMLS (real mode limit selector) field value for a given RMA size.
-   Assumes POWER7. */
+   Assumes POWER7 or PPC970. */
 static inline int lpcr_rmls(unsigned long rma_size)
 {
 	switch (rma_size) {
 	case 32ul << 20:	/* 32 MB */
-		return 8;
+		if (cpu_has_feature(CPU_FTR_ARCH_206))
+			return 8;	/* only supported on POWER7 */
+		return -1;
 	case 64ul << 20:	/* 64 MB */
 		return 3;
 	case 128ul << 20:	/* 128 MB */
@@ -1059,6 +1064,10 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		    mem->userspace_addr == vma->vm_start)
 			ri = vma->vm_file->private_data;
 		up_read(&current->mm->mmap_sem);
+		if (!ri && cpu_has_feature(CPU_FTR_ARCH_201)) {
+			pr_err("CPU requires an RMO\n");
+			return -EINVAL;
+		}
 	}
 
 	if (ri) {
@@ -1077,10 +1086,25 @@ int kvmppc_core_prepare_memory_region(struct kvm *kvm,
 		atomic_inc(&ri->use_count);
 		kvm->arch.rma = ri;
 		kvm->arch.n_rma_pages = rma_size >> porder;
-		lpcr = kvm->arch.lpcr & ~(LPCR_VPM0 | LPCR_VRMA_L);
-		lpcr |= rmls << LPCR_RMLS_SH;
+
+		/* Update LPCR and RMOR */
+		lpcr = kvm->arch.lpcr;
+		if (cpu_has_feature(CPU_FTR_ARCH_201)) {
+			/* PPC970; insert RMLS value (split field) in HID4 */
+			lpcr &= ~((1ul << HID4_RMLS0_SH) |
+				  (3ul << HID4_RMLS2_SH));
+			lpcr |= ((rmls >> 2) << HID4_RMLS0_SH) |
+				((rmls & 3) << HID4_RMLS2_SH);
+			/* RMOR is also in HID4 */
+			lpcr |= ((ri->base_pfn >> (26 - PAGE_SHIFT)) & 0xffff)
+				<< HID4_RMOR_SH;
+		} else {
+			/* POWER7 */
+			lpcr &= ~(LPCR_VPM0 | LPCR_VRMA_L);
+			lpcr |= rmls << LPCR_RMLS_SH;
+			kvm->arch.rmor = kvm->arch.rma->base_pfn << PAGE_SHIFT;
+		}
 		kvm->arch.lpcr = lpcr;
-		kvm->arch.rmor = kvm->arch.rma->base_pfn << PAGE_SHIFT;
 		pr_info("Using RMO at %lx size %lx (LPCR = %lx)\n",
 			ri->base_pfn << PAGE_SHIFT, rma_size, lpcr);
 	}
@@ -1151,11 +1175,25 @@ int kvmppc_core_init_vm(struct kvm *kvm)
 	kvm->arch.rma = NULL;
 	kvm->arch.n_rma_pages = 0;
 
-	lpcr = kvm->arch.host_lpcr & (LPCR_PECE | LPCR_LPES);
-	lpcr |= (4UL << LPCR_DPFD_SH) | LPCR_HDICE |
-		LPCR_VPM0 | LPCR_VRMA_L;
-	kvm->arch.lpcr = lpcr;
+	kvm->arch.host_sdr1 = mfspr(SPRN_SDR1);
 
+	if (cpu_has_feature(CPU_FTR_ARCH_201)) {
+		/* PPC970; HID4 is effectively the LPCR */
+		unsigned long lpid = kvm->arch.lpid;
+		kvm->arch.host_lpid = 0;
+		kvm->arch.host_lpcr = lpcr = mfspr(SPRN_HID4);
+		lpcr &= ~((3 << HID4_LPID1_SH) | (0xful << HID4_LPID5_SH));
+		lpcr |= ((lpid >> 4) << HID4_LPID1_SH) |
+			((lpid & 0xf) << HID4_LPID5_SH);
+	} else {
+		/* POWER7; init LPCR for virtual RMA mode */
+		kvm->arch.host_lpid = mfspr(SPRN_LPID);
+		kvm->arch.host_lpcr = lpcr = mfspr(SPRN_LPCR);
+		lpcr &= LPCR_PECE | LPCR_LPES;
+		lpcr |= (4UL << LPCR_DPFD_SH) | LPCR_HDICE |
+			LPCR_VPM0 | LPCR_VRMA_L;
+	}
+	kvm->arch.lpcr = lpcr;
 
 	return 0;
 
diff --git a/arch/powerpc/kvm/book3s_hv_builtin.c b/arch/powerpc/kvm/book3s_hv_builtin.c
index c67d7a1..e16a400 100644
--- a/arch/powerpc/kvm/book3s_hv_builtin.c
+++ b/arch/powerpc/kvm/book3s_hv_builtin.c
@@ -55,12 +55,14 @@ static LIST_HEAD(free_rmas);
 static DEFINE_SPINLOCK(rma_lock);
 
 /* Work out RMLS (real mode limit selector) field value for a given RMA size.
-   Assumes POWER7. */
+   Assumes POWER7 or PPC970. */
 static inline int lpcr_rmls(unsigned long rma_size)
 {
 	switch (rma_size) {
 	case 32ul << 20:	/* 32 MB */
-		return 8;
+		if (cpu_has_feature(CPU_FTR_ARCH_206))
+			return 8;	/* only supported on POWER7 */
+		return -1;
 	case 64ul << 20:	/* 64 MB */
 		return 3;
 	case 128ul << 20:	/* 128 MB */
@@ -90,8 +92,9 @@ void kvm_rma_init(void)
 	void *rma;
 	struct page *pg;
 
-	/* Only do this in HV mode */
-	if (!cpu_has_feature(CPU_FTR_HVMODE))
+	/* Only do this on PPC970 in HV mode */
+	if (!cpu_has_feature(CPU_FTR_HVMODE) ||
+	    !cpu_has_feature(CPU_FTR_ARCH_201))
 		return;
 
 	if (!kvm_rma_size || !kvm_rma_count)
diff --git a/arch/powerpc/kvm/book3s_hv_interrupts.S b/arch/powerpc/kvm/book3s_hv_interrupts.S
index 532afaf..3f7b674 100644
--- a/arch/powerpc/kvm/book3s_hv_interrupts.S
+++ b/arch/powerpc/kvm/book3s_hv_interrupts.S
@@ -50,8 +50,10 @@ _GLOBAL(__kvmppc_vcore_entry)
 	SAVE_NVGPRS(r1)
 
 	/* Save host DSCR */
+BEGIN_FTR_SECTION
 	mfspr	r3, SPRN_DSCR
 	std	r3, HSTATE_DSCR(r13)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
 	/* Save host DABR */
 	mfspr	r3, SPRN_DABR
@@ -86,12 +88,20 @@ _GLOBAL(__kvmppc_vcore_entry)
 	mfspr	r7, SPRN_PMC4
 	mfspr	r8, SPRN_PMC5
 	mfspr	r9, SPRN_PMC6
+BEGIN_FTR_SECTION
+	mfspr	r10, SPRN_PMC7
+	mfspr	r11, SPRN_PMC8
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	stw	r3, HSTATE_PMC(r13)
 	stw	r5, HSTATE_PMC + 4(r13)
 	stw	r6, HSTATE_PMC + 8(r13)
 	stw	r7, HSTATE_PMC + 12(r13)
 	stw	r8, HSTATE_PMC + 16(r13)
 	stw	r9, HSTATE_PMC + 20(r13)
+BEGIN_FTR_SECTION
+	stw	r10, HSTATE_PMC + 24(r13)
+	stw	r11, HSTATE_PMC + 28(r13)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 31:
 
 	/*
@@ -105,6 +115,26 @@ _GLOBAL(__kvmppc_vcore_entry)
 	add	r8,r8,r7
 	std	r8,HSTATE_DECEXP(r13)
 
+	/*
+	 * On PPC970, if the guest vcpu has an external interrupt pending,
+	 * send ourselves an IPI so as to interrupt the guest once it
+	 * enables interrupts.  (It must have interrupts disabled,
+	 * otherwise we would already have delivered the interrupt.)
+	 */
+BEGIN_FTR_SECTION
+	ld	r0, VCPU_PENDING_EXC(r4)
+	li	r7, (1 << BOOK3S_IRQPRIO_EXTERNAL)
+	oris	r7, r7, (1 << BOOK3S_IRQPRIO_EXTERNAL_LEVEL)@h
+	and.	r0, r0, r7
+	beq	32f
+	mr	r31, r4
+	lhz	r3, PACAPACAINDEX(r13)
+	bl	smp_send_reschedule
+	nop
+	mr	r4, r31
+32:
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
+
 	/* Jump to partition switch code */
 	bl	.kvmppc_hv_entry_trampoline
 	nop
diff --git a/arch/powerpc/kvm/book3s_hv_rm_mmu.c b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
index edb0aae..fcfe6b0 100644
--- a/arch/powerpc/kvm/book3s_hv_rm_mmu.c
+++ b/arch/powerpc/kvm/book3s_hv_rm_mmu.c
@@ -56,7 +56,8 @@ long kvmppc_h_enter(struct kvm_vcpu *vcpu, unsigned long flags,
 	/* only handle 4k, 64k and 16M pages for now */
 	porder = 12;
 	if (pteh & HPTE_V_LARGE) {
-		if ((ptel & 0xf000) == 0x1000) {
+		if (cpu_has_feature(CPU_FTR_ARCH_206) &&
+		    (ptel & 0xf000) == 0x1000) {
 			/* 64k page */
 			porder = 16;
 		} else if ((ptel & 0xff000) == 0) {
@@ -126,7 +127,8 @@ static unsigned long compute_tlbie_rb(unsigned long v, unsigned long r,
 	va_low &= 0x7ff;
 	if (v & HPTE_V_LARGE) {
 		rb |= 1;			/* L field */
-		if (r & 0xff000) {
+		if (cpu_has_feature(CPU_FTR_ARCH_206) &&
+		    (r & 0xff000)) {
 			/* non-16MB large page, must be 64k */
 			/* (masks depend on page size) */
 			rb |= 0x1000;		/* page encoding in LP field */
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 9ee223c..6dd3358 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -148,12 +148,20 @@ kvmppc_hv_entry:
 	lwz	r7, VCPU_PMC + 12(r4)
 	lwz	r8, VCPU_PMC + 16(r4)
 	lwz	r9, VCPU_PMC + 20(r4)
+BEGIN_FTR_SECTION
+	lwz	r10, VCPU_PMC + 24(r4)
+	lwz	r11, VCPU_PMC + 28(r4)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	mtspr	SPRN_PMC1, r3
 	mtspr	SPRN_PMC2, r5
 	mtspr	SPRN_PMC3, r6
 	mtspr	SPRN_PMC4, r7
 	mtspr	SPRN_PMC5, r8
 	mtspr	SPRN_PMC6, r9
+BEGIN_FTR_SECTION
+	mtspr	SPRN_PMC7, r10
+	mtspr	SPRN_PMC8, r11
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	ld	r3, VCPU_MMCR(r4)
 	ld	r5, VCPU_MMCR + 8(r4)
 	ld	r6, VCPU_MMCR + 16(r4)
@@ -165,9 +173,11 @@ kvmppc_hv_entry:
 	/* Load up FP, VMX and VSX registers */
 	bl	kvmppc_load_fp
 
+BEGIN_FTR_SECTION
 	/* Switch DSCR to guest value */
 	ld	r5, VCPU_DSCR(r4)
 	mtspr	SPRN_DSCR, r5
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
 	/*
 	 * Set the decrementer to the guest decrementer.
@@ -210,6 +220,7 @@ kvmppc_hv_entry:
 	mtspr	SPRN_DABRX,r5
 	mtspr	SPRN_DABR,r6
 
+BEGIN_FTR_SECTION
 	/* Restore AMR and UAMOR, set AMOR to all 1s */
 	ld	r5,VCPU_AMR(r4)
 	ld	r6,VCPU_UAMOR(r4)
@@ -217,6 +228,7 @@ kvmppc_hv_entry:
 	mtspr	SPRN_AMR,r5
 	mtspr	SPRN_UAMOR,r6
 	mtspr	SPRN_AMOR,r7
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
 	/* Clear out SLB */
 	li	r6,0
@@ -224,6 +236,14 @@ kvmppc_hv_entry:
 	slbia
 	ptesync
 
+BEGIN_FTR_SECTION
+	b	30f
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
+	/*
+	 * POWER7 host -> guest partition switch code.
+	 * We don't have to lock against concurrent tlbies,
+	 * but we do have to coordinate across hardware threads.
+	 */
 	/* Increment entry count iff exit count is zero. */
 	ld	r5,HSTATE_KVM_VCORE(r13)
 	addi	r9,r5,VCORE_ENTRY_EXIT
@@ -315,9 +335,94 @@ kvmppc_hv_entry:
 	ld	r8,VCPU_SPURR(r4)
 	mtspr	SPRN_PURR,r7
 	mtspr	SPRN_SPURR,r8
+	b	31f
+
+	/*
+	 * PPC970 host -> guest partition switch code.
+	 * We have to lock against concurrent tlbies,
+	 * using native_tlbie_lock to lock against host tlbies
+	 * and kvm->arch.tlbie_lock to lock against guest tlbies.
+	 * We also have to invalidate the TLB since its
+	 * entries aren't tagged with the LPID.
+	 */
+30:	ld	r9,VCPU_KVM(r4)		/* pointer to struct kvm */
+
+	/* first take native_tlbie_lock */
+	.section ".toc","aw"
+toc_tlbie_lock:
+	.tc	native_tlbie_lock[TC],native_tlbie_lock
+	.previous
+	ld	r3,toc_tlbie_lock@toc(2)
+	lwz	r8,PACA_LOCK_TOKEN(r13)
+24:	lwarx	r0,0,r3
+	cmpwi	r0,0
+	bne	24b
+	stwcx.	r8,0,r3
+	bne	24b
+	isync
+
+	ld	r7,KVM_LPCR(r9)		/* use kvm->arch.lpcr to store HID4 */
+	li	r0,0x18f
+	rotldi	r0,r0,HID4_LPID5_SH	/* all lpid bits in HID4 = 1 */
+	or	r0,r7,r0
+	ptesync
+	sync
+	mtspr	SPRN_HID4,r0		/* switch to reserved LPID */
+	isync
+	li	r0,0
+	stw	r0,0(r3)		/* drop native_tlbie_lock */
+
+	/* invalidate the whole TLB */
+	li	r0,256
+	mtctr	r0
+	li	r6,0
+25:	tlbiel	r6
+	addi	r6,r6,0x1000
+	bdnz	25b
+	ptesync
+
+	/* Take the guest's tlbie_lock */
+	addi	r3,r9,KVM_TLBIE_LOCK
+24:	lwarx	r0,0,r3
+	cmpwi	r0,0
+	bne	24b
+	stwcx.	r8,0,r3
+	bne	24b
+	isync
+	ld	r6,KVM_SDR1(r9)
+	mtspr	SPRN_SDR1,r6		/* switch to partition page table */
+
+	/* Set up HID4 with the guest's LPID etc. */
+	sync
+	mtspr	SPRN_HID4,r7
+	isync
+
+	/* drop the guest's tlbie_lock */
+	li	r0,0
+	stw	r0,0(r3)
+
+	/* Check if HDEC expires soon */
+	mfspr	r3,SPRN_HDEC
+	cmpwi	r3,10
+	li	r12,BOOK3S_INTERRUPT_HV_DECREMENTER
+	mr	r9,r4
+	blt	hdec_soon
+
+	/* Enable HDEC interrupts */
+	mfspr	r0,SPRN_HID0
+	li	r3,1
+	rldimi	r0,r3, HID0_HDICE_SH, 64-HID0_HDICE_SH-1
+	sync
+	mtspr	SPRN_HID0,r0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
 
 	/* Load up guest SLB entries */
-	lwz	r5,VCPU_SLB_MAX(r4)
+31:	lwz	r5,VCPU_SLB_MAX(r4)
 	cmpwi	r5,0
 	beq	9f
 	mtctr	r5
@@ -472,6 +577,7 @@ kvmppc_interrupt:
 hcall_real_cont:
 
 	/* Check for mediated interrupts (could be done earlier really ...) */
+BEGIN_FTR_SECTION
 	cmpwi	r12,BOOK3S_INTERRUPT_EXTERNAL
 	bne+	1f
 	ld	r5,VCPU_KVM(r9)
@@ -481,6 +587,7 @@ hcall_real_cont:
 	andi.	r0,r5,LPCR_MER
 	bne	bounce_ext_interrupt
 1:
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
 	/* Save DEC */
 	mfspr	r5,SPRN_DEC
@@ -492,9 +599,11 @@ hcall_real_cont:
 	/* Save HEIR (HV emulation assist reg) in last_inst
 	   if this is an HEI (HV emulation interrupt, e40) */
 	li	r3,-1
+BEGIN_FTR_SECTION
 	cmpwi	r12,BOOK3S_INTERRUPT_H_EMUL_ASSIST
 	bne	11f
 	mfspr	r3,SPRN_HEIR
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 11:	stw	r3,VCPU_LAST_INST(r9)
 
 	/* Save more register state  */
@@ -508,8 +617,10 @@ hcall_real_cont:
 	stw	r7, VCPU_DSISR(r9)
 	std	r8, VCPU_CTR(r9)
 	/* grab HDAR & HDSISR if HV data storage interrupt (HDSI) */
+BEGIN_FTR_SECTION
 	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
 	beq	6f
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 7:	std	r6, VCPU_FAULT_DAR(r9)
 	stw	r7, VCPU_FAULT_DSISR(r9)
 
@@ -543,6 +654,7 @@ hcall_real_cont:
 	/*
 	 * Save the guest PURR/SPURR
 	 */
+BEGIN_FTR_SECTION
 	mfspr	r5,SPRN_PURR
 	mfspr	r6,SPRN_SPURR
 	ld	r7,VCPU_PURR(r9)
@@ -562,6 +674,7 @@ hcall_real_cont:
 	add	r4,r4,r6
 	mtspr	SPRN_PURR,r3
 	mtspr	SPRN_SPURR,r4
+END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_201)
 
 	/* Clear out SLB */
 	li	r5,0
@@ -570,6 +683,14 @@ hcall_real_cont:
 	ptesync
 
 hdec_soon:
+BEGIN_FTR_SECTION
+	b	32f
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
+	/*
+	 * POWER7 guest -> host partition switch code.
+	 * We don't have to lock against tlbies but we do
+	 * have to coordinate the hardware threads.
+	 */
 	/* Increment the threads-exiting-guest count in the 0xff00
 	   bits of vcore->entry_exit_count */
 	lwsync
@@ -640,9 +761,82 @@ hdec_soon:
 16:	ld	r8,KVM_HOST_LPCR(r4)
 	mtspr	SPRN_LPCR,r8
 	isync
+	b	33f
+
+	/*
+	 * PPC970 guest -> host partition switch code.
+	 * We have to lock against concurrent tlbies, and
+	 * we have to flush the whole TLB.
+	 */
+32:	ld	r4,VCPU_KVM(r9)		/* pointer to struct kvm */
+
+	/* Take the guest's tlbie_lock */
+	lwz	r8,PACA_LOCK_TOKEN(r13)
+	addi	r3,r4,KVM_TLBIE_LOCK
+24:	lwarx	r0,0,r3
+	cmpwi	r0,0
+	bne	24b
+	stwcx.	r8,0,r3
+	bne	24b
+	isync
+
+	ld	r7,KVM_HOST_LPCR(r4)	/* use kvm->arch.host_lpcr for HID4 */
+	li	r0,0x18f
+	rotldi	r0,r0,HID4_LPID5_SH	/* all lpid bits in HID4 = 1 */
+	or	r0,r7,r0
+	ptesync
+	sync
+	mtspr	SPRN_HID4,r0		/* switch to reserved LPID */
+	isync
+	li	r0,0
+	stw	r0,0(r3)		/* drop guest tlbie_lock */
+
+	/* invalidate the whole TLB */
+	li	r0,256
+	mtctr	r0
+	li	r6,0
+25:	tlbiel	r6
+	addi	r6,r6,0x1000
+	bdnz	25b
+	ptesync
+
+	/* take native_tlbie_lock */
+	ld	r3,toc_tlbie_lock@toc(2)
+24:	lwarx	r0,0,r3
+	cmpwi	r0,0
+	bne	24b
+	stwcx.	r8,0,r3
+	bne	24b
+	isync
+
+	ld	r6,KVM_HOST_SDR1(r4)
+	mtspr	SPRN_SDR1,r6		/* switch to host page table */
+
+	/* Set up host HID4 value */
+	sync
+	mtspr	SPRN_HID4,r7
+	isync
+	li	r0,0
+	stw	r0,0(r3)		/* drop native_tlbie_lock */
+
+	lis	r8,0x7fff		/* MAX_INT@h */
+	mtspr	SPRN_HDEC,r8
+
+	/* Disable HDEC interrupts */
+	mfspr	r0,SPRN_HID0
+	li	r3,0
+	rldimi	r0,r3, HID0_HDICE_SH, 64-HID0_HDICE_SH-1
+	sync
+	mtspr	SPRN_HID0,r0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
+	mfspr	r0,SPRN_HID0
 
 	/* load host SLB entries */
-	ld	r8,PACA_SLBSHADOWPTR(r13)
+33:	ld	r8,PACA_SLBSHADOWPTR(r13)
 
 	.rept	SLB_NUM_BOLTED
 	ld	r5,SLBSHADOW_SAVEAREA(r8)
@@ -654,12 +848,14 @@ hdec_soon:
 	.endr
 
 	/* Save and reset AMR and UAMOR before turning on the MMU */
+BEGIN_FTR_SECTION
 	mfspr	r5,SPRN_AMR
 	mfspr	r6,SPRN_UAMOR
 	std	r5,VCPU_AMR(r9)
 	std	r6,VCPU_UAMOR(r9)
 	li	r6,0
 	mtspr	SPRN_AMR,r6
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
 	/* Restore host DABR and DABRX */
 	ld	r5,HSTATE_DABR(r13)
@@ -668,10 +864,12 @@ hdec_soon:
 	mtspr	SPRN_DABRX,r6
 
 	/* Switch DSCR back to host value */
+BEGIN_FTR_SECTION
 	mfspr	r8, SPRN_DSCR
 	ld	r7, HSTATE_DSCR(r13)
 	std	r8, VCPU_DSCR(r7)
 	mtspr	SPRN_DSCR, r7
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
 	/* Save non-volatile GPRs */
 	std	r14, VCPU_GPR(r14)(r9)
@@ -735,21 +933,31 @@ hdec_soon:
 	mfspr	r6, SPRN_PMC4
 	mfspr	r7, SPRN_PMC5
 	mfspr	r8, SPRN_PMC6
+BEGIN_FTR_SECTION
+	mfspr	r10, SPRN_PMC7
+	mfspr	r11, SPRN_PMC8
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	stw	r3, VCPU_PMC(r9)
 	stw	r4, VCPU_PMC + 4(r9)
 	stw	r5, VCPU_PMC + 8(r9)
 	stw	r6, VCPU_PMC + 12(r9)
 	stw	r7, VCPU_PMC + 16(r9)
 	stw	r8, VCPU_PMC + 20(r9)
+BEGIN_FTR_SECTION
+	stw	r10, VCPU_PMC + 24(r9)
+	stw	r11, VCPU_PMC + 28(r9)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 22:
 	/* save FP state */
 	mr	r3, r9
 	bl	.kvmppc_save_fp
 
-	/* Secondary threads go off to take a nap */
+	/* Secondary threads go off to take a nap on POWER7 */
+BEGIN_FTR_SECTION
 	lwz	r0,VCPU_PTID(r3)
 	cmpwi	r0,0
 	bne	secondary_nap
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_206)
 
 	/*
 	 * Reload DEC.  HDEC interrupts were disabled when
@@ -771,12 +979,20 @@ hdec_soon:
 	lwz	r6, HSTATE_PMC + 12(r13)
 	lwz	r8, HSTATE_PMC + 16(r13)
 	lwz	r9, HSTATE_PMC + 20(r13)
+BEGIN_FTR_SECTION
+	lwz	r10, HSTATE_PMC + 24(r13)
+	lwz	r11, HSTATE_PMC + 28(r13)
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	mtspr	SPRN_PMC1, r3
 	mtspr	SPRN_PMC2, r4
 	mtspr	SPRN_PMC3, r5
 	mtspr	SPRN_PMC4, r6
 	mtspr	SPRN_PMC5, r8
 	mtspr	SPRN_PMC6, r9
+BEGIN_FTR_SECTION
+	mtspr	SPRN_PMC7, r10
+	mtspr	SPRN_PMC8, r11
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
 	ld	r3, HSTATE_MMCR(r13)
 	ld	r4, HSTATE_MMCR + 8(r13)
 	ld	r5, HSTATE_MMCR + 16(r13)
@@ -802,7 +1018,7 @@ hdec_soon:
 	cmpwi	r12, BOOK3S_INTERRUPT_MACHINE_CHECK
 
 	/* RFI into the highmem handler, or branch to interrupt handler */
-	mfmsr	r6
+12:	mfmsr	r6
 	mtctr	r12
 	li	r0, MSR_RI
 	andc	r6, r6, r0
@@ -812,7 +1028,11 @@ hdec_soon:
 	beqctr
 	RFI
 
-11:	mtspr	SPRN_HSRR0, r8
+11:
+BEGIN_FTR_SECTION
+	b	12b
+END_FTR_SECTION_IFSET(CPU_FTR_ARCH_201)
+	mtspr	SPRN_HSRR0, r8
 	mtspr	SPRN_HSRR1, r7
 	ba	0x500
 
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 72c5065..a107c9b 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -213,6 +213,9 @@ int kvm_dev_ioctl_check_extension(long ext)
 		break;
 	case KVM_CAP_PPC_RMA:
 		r = 1;
+		/* PPC970 requires an RMA */
+		if (cpu_has_feature(CPU_FTR_ARCH_201))
+			r = 2;
 		break;
 #endif
 	default:
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index b44f5f8..90039bc 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -37,7 +37,7 @@
 
 #define HPTE_LOCK_BIT 3
 
-static DEFINE_RAW_SPINLOCK(native_tlbie_lock);
+DEFINE_RAW_SPINLOCK(native_tlbie_lock);
 
 static inline void __tlbie(unsigned long va, int psize, int ssize)
 {
-- 
1.7.5.4
