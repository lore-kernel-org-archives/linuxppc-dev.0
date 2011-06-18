Return-Path: <paulus@ozlabs.org>
Date: Sat, 18 Jun 2011 18:38:51 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: [PATCH 14/15] powerpc, KVM: Split HVMODE_206 cpu feature bit into
	separate HV and architecture bits
Message-ID: <20110618083851.GO28413@bloggs.ozlabs.ibm.com>
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

This replaces the single CPU_FTR_HVMODE_206 bit with two bits, one to
indicate that we have a usable hypervisor mode, and another to indicate
that the processor conforms to PowerISA version 2.06.  We also add
another bit to indicate that the processor conforms to ISA version 2.01
and set that for PPC970 and derivatives.

Some PPC970 chips (specifically those in Apple machines) have a
hypervisor mode in that MSR[HV] is always 1, but the hypervisor mode
is not useful in the sense that there is no way to run any code in
supervisor mode (HV=0 PR=0).  On these processors, the LPES0 and LPES1
bits in HID4 are always 0, and we use that as a way of detecting that
hypervisor mode is not useful.

Where we have a feature section in assembly code around code that
only applies on POWER7 in hypervisor mode, we use a construct like

END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)

The definition of END_FTR_SECTION_IFSET is such that the code will
be enabled (not overwritten with nops) only if all bits in the
provided mask are set.

Note that the CPU feature check in __tlbie() only needs to check the
ARCH_206 bit, not the HVMODE bit, because __tlbie() can only get called
if we are running bare-metal, i.e. in hypervisor mode.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/cputable.h    |   14 ++++++++------
 arch/powerpc/include/asm/reg.h         |   16 ++++++++++++----
 arch/powerpc/kernel/cpu_setup_power7.S |    4 ++--
 arch/powerpc/kernel/cpu_setup_ppc970.S |   26 ++++++++++++++++++++++----
 arch/powerpc/kernel/exceptions-64s.S   |    4 ++--
 arch/powerpc/kernel/paca.c             |    2 +-
 arch/powerpc/kvm/book3s_64_mmu_hv.c    |    3 ++-
 arch/powerpc/kvm/book3s_hv.c           |    7 ++++---
 arch/powerpc/kvm/book3s_segment.S      |    2 +-
 arch/powerpc/mm/hash_native_64.c       |    4 ++--
 10 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/include/asm/cputable.h b/arch/powerpc/include/asm/cputable.h
index c0d842c..e30442c 100644
--- a/arch/powerpc/include/asm/cputable.h
+++ b/arch/powerpc/include/asm/cputable.h
@@ -179,8 +179,9 @@ extern const char *powerpc_base_platform;
 #define LONG_ASM_CONST(x)		0
 #endif
 
-
-#define CPU_FTR_HVMODE_206		LONG_ASM_CONST(0x0000000800000000)
+#define CPU_FTR_HVMODE			LONG_ASM_CONST(0x0000000200000000)
+#define CPU_FTR_ARCH_201		LONG_ASM_CONST(0x0000000400000000)
+#define CPU_FTR_ARCH_206		LONG_ASM_CONST(0x0000000800000000)
 #define CPU_FTR_CFAR			LONG_ASM_CONST(0x0000001000000000)
 #define CPU_FTR_IABR			LONG_ASM_CONST(0x0000002000000000)
 #define CPU_FTR_MMCRA			LONG_ASM_CONST(0x0000004000000000)
@@ -401,9 +402,10 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_MMCRA | CPU_FTR_CP_USE_DCBTZ | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS)
 #define CPU_FTRS_PPC970	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_201 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA | \
-	    CPU_FTR_CP_USE_DCBTZ | CPU_FTR_STCX_CHECKS_ADDRESS)
+	    CPU_FTR_CP_USE_DCBTZ | CPU_FTR_STCX_CHECKS_ADDRESS | \
+	    CPU_FTR_HVMODE)
 #define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
@@ -417,13 +419,13 @@ extern const char *powerpc_base_platform;
 	    CPU_FTR_DSCR | CPU_FTR_UNALIGNED_LD_STD | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_CFAR)
 #define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
-	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_HVMODE_206 |\
+	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | CPU_FTR_ARCH_206 |\
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR | CPU_FTR_SAO  | CPU_FTR_ASYM_SMT | \
 	    CPU_FTR_STCX_CHECKS_ADDRESS | CPU_FTR_POPCNTB | CPU_FTR_POPCNTD | \
-	    CPU_FTR_ICSWX | CPU_FTR_CFAR)
+	    CPU_FTR_ICSWX | CPU_FTR_CFAR | CPU_FTR_HVMODE)
 #define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 20a053c..ddbe57a 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -307,6 +307,7 @@
 #define SPRN_HASH1	0x3D2		/* Primary Hash Address Register */
 #define SPRN_HASH2	0x3D3		/* Secondary Hash Address Resgister */
 #define SPRN_HID0	0x3F0		/* Hardware Implementation Register 0 */
+#define HID0_HDICE_SH	(63 - 23)	/* 970 HDEC interrupt enable */
 #define HID0_EMCP	(1<<31)		/* Enable Machine Check pin */
 #define HID0_EBA	(1<<29)		/* Enable Bus Address Parity */
 #define HID0_EBD	(1<<28)		/* Enable Bus Data Parity */
@@ -362,6 +363,13 @@
 #define SPRN_IABR2	0x3FA		/* 83xx */
 #define SPRN_IBCR	0x135		/* 83xx Insn Breakpoint Control Reg */
 #define SPRN_HID4	0x3F4		/* 970 HID4 */
+#define  HID4_LPES0	 (1ul << (63-0)) /* LPAR env. sel. bit 0 */
+#define	 HID4_RMLS2_SH	 (63 - 2)	/* Real mode limit bottom 2 bits */
+#define	 HID4_LPID5_SH	 (63 - 6)	/* partition ID bottom 4 bits */
+#define	 HID4_RMOR_SH	 (63 - 22)	/* real mode offset (16 bits) */
+#define  HID4_LPES1	 (1 << (63-57))	/* LPAR env. sel. bit 1 */
+#define  HID4_RMLS0_SH	 (63 - 58)	/* Real mode limit top bit */
+#define	 HID4_LPID1_SH	 0		/* partition ID top 2 bits */
 #define SPRN_HID4_GEKKO	0x3F3		/* Gekko HID4 */
 #define SPRN_HID5	0x3F6		/* 970 HID5 */
 #define SPRN_HID6	0x3F9	/* BE HID 6 */
@@ -811,28 +819,28 @@
 	mfspr	rX,SPRN_SPRG_PACA;			\
 	FTR_SECTION_ELSE_NESTED(66);			\
 	mfspr	rX,SPRN_SPRG_HPACA;			\
-	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE_206, 66)
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
 
 #define SET_PACA(rX)					\
 	BEGIN_FTR_SECTION_NESTED(66);			\
 	mtspr	SPRN_SPRG_PACA,rX;			\
 	FTR_SECTION_ELSE_NESTED(66);			\
 	mtspr	SPRN_SPRG_HPACA,rX;			\
-	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE_206, 66)
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
 
 #define GET_SCRATCH0(rX)				\
 	BEGIN_FTR_SECTION_NESTED(66);			\
 	mfspr	rX,SPRN_SPRG_SCRATCH0;			\
 	FTR_SECTION_ELSE_NESTED(66);			\
 	mfspr	rX,SPRN_SPRG_HSCRATCH0;			\
-	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE_206, 66)
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
 
 #define SET_SCRATCH0(rX)				\
 	BEGIN_FTR_SECTION_NESTED(66);			\
 	mtspr	SPRN_SPRG_SCRATCH0,rX;			\
 	FTR_SECTION_ELSE_NESTED(66);			\
 	mtspr	SPRN_SPRG_HSCRATCH0,rX;			\
-	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE_206, 66)
+	ALT_FTR_SECTION_END_NESTED_IFCLR(CPU_FTR_HVMODE, 66)
 
 #else /* CONFIG_PPC_BOOK3S_64 */
 #define GET_SCRATCH0(rX)	mfspr	rX,SPRN_SPRG_SCRATCH0
diff --git a/arch/powerpc/kernel/cpu_setup_power7.S b/arch/powerpc/kernel/cpu_setup_power7.S
index 2ef6749..76797c5 100644
--- a/arch/powerpc/kernel/cpu_setup_power7.S
+++ b/arch/powerpc/kernel/cpu_setup_power7.S
@@ -45,12 +45,12 @@ _GLOBAL(__restore_cpu_power7)
 	blr
 
 __init_hvmode_206:
-	/* Disable CPU_FTR_HVMODE_206 and exit if MSR:HV is not set */
+	/* Disable CPU_FTR_HVMODE and exit if MSR:HV is not set */
 	mfmsr	r3
 	rldicl.	r0,r3,4,63
 	bnelr
 	ld	r5,CPU_SPEC_FEATURES(r4)
-	LOAD_REG_IMMEDIATE(r6,CPU_FTR_HVMODE_206)
+	LOAD_REG_IMMEDIATE(r6,CPU_FTR_HVMODE)
 	xor	r5,r5,r6
 	std	r5,CPU_SPEC_FEATURES(r4)
 	blr
diff --git a/arch/powerpc/kernel/cpu_setup_ppc970.S b/arch/powerpc/kernel/cpu_setup_ppc970.S
index 27f2507..12fac8d 100644
--- a/arch/powerpc/kernel/cpu_setup_ppc970.S
+++ b/arch/powerpc/kernel/cpu_setup_ppc970.S
@@ -76,7 +76,7 @@ _GLOBAL(__setup_cpu_ppc970)
 	/* Do nothing if not running in HV mode */
 	mfmsr	r0
 	rldicl.	r0,r0,4,63
-	beqlr
+	beq	no_hv_mode
 
 	mfspr	r0,SPRN_HID0
 	li	r11,5			/* clear DOZE and SLEEP */
@@ -90,7 +90,7 @@ _GLOBAL(__setup_cpu_ppc970MP)
 	/* Do nothing if not running in HV mode */
 	mfmsr	r0
 	rldicl.	r0,r0,4,63
-	beqlr
+	beq	no_hv_mode
 
 	mfspr	r0,SPRN_HID0
 	li	r11,0x15		/* clear DOZE and SLEEP */
@@ -109,6 +109,14 @@ load_hids:
 	sync
 	isync
 
+	/* Try to set LPES = 01 in HID4 */
+	mfspr	r0,SPRN_HID4
+	clrldi	r0,r0,1			/* clear LPES0 */
+	ori	r0,r0,HID4_LPES1	/* set LPES1 */
+	sync
+	mtspr	SPRN_HID4,r0
+	isync
+
 	/* Save away cpu state */
 	LOAD_REG_ADDR(r5,cpu_state_storage)
 
@@ -117,11 +125,21 @@ load_hids:
 	std	r3,CS_HID0(r5)
 	mfspr	r3,SPRN_HID1
 	std	r3,CS_HID1(r5)
-	mfspr	r3,SPRN_HID4
-	std	r3,CS_HID4(r5)
+	mfspr	r4,SPRN_HID4
+	std	r4,CS_HID4(r5)
 	mfspr	r3,SPRN_HID5
 	std	r3,CS_HID5(r5)
 
+	/* See if we successfully set LPES1 to 1; if not we are in Apple mode */
+	andi.	r4,r4,HID4_LPES1
+	bnelr
+
+no_hv_mode:
+	/* Disable CPU_FTR_HVMODE and exit, since we don't have HV mode */
+	ld	r5,CPU_SPEC_FEATURES(r4)
+	LOAD_REG_IMMEDIATE(r6,CPU_FTR_HVMODE)
+	andc	r5,r5,r6
+	std	r5,CPU_SPEC_FEATURES(r4)
 	blr
 
 /* Called with no MMU context (typically MSR:IR/DR off) to
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 0771606..e654165 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -75,7 +75,7 @@ BEGIN_FTR_SECTION
 	b	.power7_wakeup_noloss
 2:	b	.power7_wakeup_loss
 9:
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE_206)
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 #endif /* CONFIG_PPC_P7_NAP */
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
@@ -173,7 +173,7 @@ hardware_interrupt_hv:
 		_MASKABLE_EXCEPTION_PSERIES(0x500, hardware_interrupt,
 					    EXC_STD, SOFTEN_TEST_PR)
 		KVM_HANDLER(PACA_EXGEN, EXC_STD, 0x500)
-	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE_206)
+	ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
 
 	STD_EXCEPTION_PSERIES(0x600, 0x600, alignment)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0x600)
diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index efeb881..0a5a899 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -167,7 +167,7 @@ void setup_paca(struct paca_struct *new_paca)
 	 * if we do a GET_PACA() before the feature fixups have been
 	 * applied
 	 */
-	if (cpu_has_feature(CPU_FTR_HVMODE_206))
+	if (cpu_has_feature(CPU_FTR_HVMODE))
 		mtspr(SPRN_SPRG_HPACA, local_paca);
 #endif
 	mtspr(SPRN_SPRG_PACA, local_paca);
diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index a57b40d..3f773b3 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -470,7 +470,8 @@ long kvmppc_h_read(struct kvm_vcpu *vcpu, unsigned long flags,
 
 int kvmppc_mmu_hv_init(void)
 {
-	if (!cpu_has_feature(CPU_FTR_HVMODE_206))
+	if (!cpu_has_feature(CPU_FTR_HVMODE) ||
+	    !cpu_has_feature(CPU_FTR_ARCH_206))
 		return -EINVAL;
 	memset(lpid_inuse, 0, sizeof(lpid_inuse));
 	set_bit(mfspr(SPRN_LPID), lpid_inuse);
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index ca40ef0..ebc097d 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -444,7 +444,8 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 
 int kvmppc_core_check_processor_compat(void)
 {
-	if (cpu_has_feature(CPU_FTR_HVMODE_206))
+	if (cpu_has_feature(CPU_FTR_HVMODE) &&
+	    cpu_has_feature(CPU_FTR_ARCH_206))
 		return 0;
 	return -EIO;
 }
@@ -999,8 +1000,8 @@ void kvm_rma_init(void)
 	void *rma;
 	struct page *pg;
 
-	/* Only do this on POWER7 in HV mode */
-	if (!cpu_has_feature(CPU_FTR_HVMODE_206))
+	/* Only do this in HV mode */
+	if (!cpu_has_feature(CPU_FTR_HVMODE))
 		return;
 
 	if (!kvm_rma_size || !kvm_rma_count)
diff --git a/arch/powerpc/kvm/book3s_segment.S b/arch/powerpc/kvm/book3s_segment.S
index 174d59c..2410f81 100644
--- a/arch/powerpc/kvm/book3s_segment.S
+++ b/arch/powerpc/kvm/book3s_segment.S
@@ -166,7 +166,7 @@ BEGIN_FTR_SECTION
 	mfspr	r4,SPRN_HSRR1
 	andi.	r12,r12,0x3ffd
 	b	2f
-END_FTR_SECTION_IFSET(CPU_FTR_HVMODE_206)
+END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 #endif
 1:	mfsrr0	r3
 	mfsrr1	r4
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index dfd7648..b44f5f8 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -51,7 +51,7 @@ static inline void __tlbie(unsigned long va, int psize, int ssize)
 		va &= ~0xffful;
 		va |= ssize << 8;
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
-			     : : "r" (va), "r"(0), "i" (CPU_FTR_HVMODE_206)
+			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
 			     : "memory");
 		break;
 	default:
@@ -61,7 +61,7 @@ static inline void __tlbie(unsigned long va, int psize, int ssize)
 		va |= ssize << 8;
 		va |= 1; /* L */
 		asm volatile(ASM_FTR_IFCLR("tlbie %0,1", PPC_TLBIE(%1,%0), %2)
-			     : : "r" (va), "r"(0), "i" (CPU_FTR_HVMODE_206)
+			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
 			     : "memory");
 		break;
 	}
-- 
1.7.5.4
