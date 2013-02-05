Return-Path: <paulus@ozlabs.org>
Date: Tue, 5 Feb 2013 15:10:15 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Alexander Graf <agraf@suse.de>
Subject: [PATCH 2/4] powerpc: Save CFAR before branching in interrupt entry
 paths
Message-ID: <20130205041015.GC20303@drongo>
References: <20130205040902.GA20303@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130205040902.GA20303@drongo>
Cc: kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some of the interrupt vectors on 64-bit POWER server processors are
only 32 bytes long, which is not enough for the full first-level
interrupt handler.  For these we currently just have a branch to an
out-of-line handler.  However, this means that we corrupt the CFAR
(come-from address register) on POWER7 and later processors.

To fix this, we split the EXCEPTION_PROLOG_1 macro into two pieces:
EXCEPTION_PROLOG_0 contains the part up to the point where the CFAR
is saved in the PACA, and EXCEPTION_PROLOG_1 contains the rest.  We
then put EXCEPTION_PROLOG_0 in the short interrupt vectors before
we branch to the out-of-line handler, which contains the rest of the
first-level interrupt handler.  To facilitate this, we define new
_OOL (out of line) variants of STD_EXCEPTION_PSERIES, etc.

In order to get EXCEPTION_PROLOG_0 to be short enough, i.e., no more
than 6 instructions, it was necessary to move the stores that move
the PPR and CFAR values into the PACA into __EXCEPTION_PROLOG_1 and
to get rid of one of the two HMT_MEDIUM instructions.  Previously
there was a HMT_MEDIUM_PPR_DISCARD before the prolog, which was
nop'd out on processors with the PPR (POWER7 and later), and then
another HMT_MEDIUM inside the HMT_MEDIUM_PPR_SAVE macro call inside
__EXCEPTION_PROLOG_1, which was nop'd out on processors without PPR.
Now the HMT_MEDIUM inside EXCEPTION_PROLOG_0 is there unconditionally
and the HMT_MEDIUM_PPR_DISCARD is not strictly necessary, although
this leaves it in for the interrupt vectors where there is room for
it.

Previously we had a handler for hypervisor maintenance interrupts at
0xe50, which doesn't leave enough room for the vector for hypervisor
emulation assist interrupts at 0xe40, since we need 8 instructions.
The 0xe50 vector was only used on POWER6, as the HMI vector was moved
to 0xe60 on POWER7.  Since we don't support running in hypervisor mode
on POWER6, we just remove the handler at 0xe50.

This also changes denorm_exception_hv to use EXCEPTION_PROLOG_0
instead of open-coding it, and removes the HMT_MEDIUM_PPR_DISCARD
from the relocation-on vectors (since any CPU that supports
relocation-on interrupts also has the PPR).

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/exception-64s.h |   84 +++++++++++++++++++++-----
 arch/powerpc/kernel/exceptions-64s.S     |   95 ++++++++++++++++++++----------
 2 files changed, 133 insertions(+), 46 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 370298a..4dfc515 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -50,7 +50,7 @@
 #define EX_PPR		88	/* SMT thread status register (priority) */
 
 #ifdef CONFIG_RELOCATABLE
-#define EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
+#define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
 	LOAD_HANDLER(r12,label);					\
@@ -61,13 +61,15 @@
 	blr;
 #else
 /* If not relocatable, we can jump directly -- and save messing with LR */
-#define EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
+#define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
 	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	li	r10,MSR_RI;						\
 	mtmsrd 	r10,1;			/* Set RI (EE=0) */		\
 	b	label;
 #endif
+#define EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
+	__EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
 
 /*
  * As EXCEPTION_PROLOG_PSERIES(), except we've already got relocation on
@@ -75,6 +77,7 @@
  * case EXCEPTION_RELON_PROLOG_PSERIES_1 will be using lr.
  */
 #define EXCEPTION_RELON_PROLOG_PSERIES(area, label, h, extra, vec)	\
+	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)
 
@@ -135,25 +138,32 @@ BEGIN_FTR_SECTION_NESTED(942)						\
 END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,0,942)  /*non P7*/		
 
 /*
- * Save PPR in paca whenever some register is available to use.
- * Then increase the priority.
+ * Get an SPR into a register if the CPU has the given feature
  */
-#define HMT_MEDIUM_PPR_SAVE(area, ra)					\
+#define OPT_GET_SPR(ra, spr, ftr)					\
 BEGIN_FTR_SECTION_NESTED(943)						\
-	mfspr	ra,SPRN_PPR;						\
-	std	ra,area+EX_PPR(r13);					\
-	HMT_MEDIUM;							\
-END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943) 
+	mfspr	ra,spr;							\
+END_FTR_SECTION_NESTED(ftr,ftr,943)
 
-#define __EXCEPTION_PROLOG_1(area, extra, vec)				\
+/*
+ * Save a register to the PACA if the CPU has the given feature
+ */
+#define OPT_SAVE_REG_TO_PACA(offset, ra, ftr)				\
+BEGIN_FTR_SECTION_NESTED(943)						\
+	std	ra,offset(r13);						\
+END_FTR_SECTION_NESTED(ftr,ftr,943)
+
+#define EXCEPTION_PROLOG_0(area)					\
 	GET_PACA(r13);							\
 	std	r9,area+EX_R9(r13);	/* save r9 */			\
-	HMT_MEDIUM_PPR_SAVE(area, r9);					\
+	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR);			\
+	HMT_MEDIUM;							\
 	std	r10,area+EX_R10(r13);	/* save r10 - r12 */		\
-	BEGIN_FTR_SECTION_NESTED(66);					\
-	mfspr	r10,SPRN_CFAR;						\
-	std	r10,area+EX_CFAR(r13);					\
-	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		\
+	OPT_GET_SPR(r10, SPRN_CFAR, CPU_FTR_CFAR)
+
+#define __EXCEPTION_PROLOG_1(area, extra, vec)				\
+	OPT_SAVE_REG_TO_PACA(area+EX_PPR, r9, CPU_FTR_HAS_PPR);		\
+	OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);		\
 	SAVE_LR(r10, area);						\
 	mfcr	r9;							\
 	extra(vec);							\
@@ -178,6 +188,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,943)
 	__EXCEPTION_PROLOG_PSERIES_1(label, h)
 
 #define EXCEPTION_PROLOG_PSERIES(area, label, h, extra, vec)		\
+	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
@@ -312,6 +323,13 @@ label##_pSeries:					\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_STD, KVMTEST_PR, vec)
 
+/* Version of above for when we have to branch out-of-line */
+#define STD_EXCEPTION_PSERIES_OOL(vec, label)			\
+	.globl label##_pSeries;					\
+label##_pSeries:						\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_STD)
+
 #define STD_EXCEPTION_HV(loc, vec, label)		\
 	. = loc;					\
 	.globl label##_hv;				\
@@ -321,6 +339,13 @@ label##_hv:						\
 	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, label##_common,	\
 				 EXC_HV, KVMTEST, vec)
 
+/* Version of above for when we have to branch out-of-line */
+#define STD_EXCEPTION_HV_OOL(vec, label)		\
+	.globl label##_hv;				\
+label##_hv:						\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST, vec);	\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_HV)
+
 #define STD_RELON_EXCEPTION_PSERIES(loc, vec, label)	\
 	. = loc;					\
 	.globl label##_relon_pSeries;			\
@@ -331,6 +356,12 @@ label##_relon_pSeries:					\
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label##_common, \
 				       EXC_STD, KVMTEST_PR, vec)
 
+#define STD_RELON_EXCEPTION_PSERIES_OOL(vec, label)		\
+	.globl label##_relon_pSeries;				\
+label##_relon_pSeries:						\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_PR, vec);	\
+	EXCEPTION_RELON_PROLOG_PSERIES_1(label##_common, EXC_STD)
+
 #define STD_RELON_EXCEPTION_HV(loc, vec, label)		\
 	. = loc;					\
 	.globl label##_relon_hv;			\
@@ -341,6 +372,12 @@ label##_relon_hv:					\
 	EXCEPTION_RELON_PROLOG_PSERIES(PACA_EXGEN, label##_common, \
 				       EXC_HV, KVMTEST, vec)
 
+#define STD_RELON_EXCEPTION_HV_OOL(vec, label)			\
+	.globl label##_relon_hv;				\
+label##_relon_hv:						\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST, vec);		\
+	EXCEPTION_RELON_PROLOG_PSERIES_1(label##_common, EXC_HV)
+
 /* This associate vector numbers with bits in paca->irq_happened */
 #define SOFTEN_VALUE_0x500	PACA_IRQ_EE
 #define SOFTEN_VALUE_0x502	PACA_IRQ_EE
@@ -375,8 +412,10 @@ label##_relon_hv:					\
 #define __MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
 	HMT_MEDIUM_PPR_DISCARD;						\
 	SET_SCRATCH0(r13);    /* save r13 */				\
-	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
+	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
+	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);			\
 	EXCEPTION_PROLOG_PSERIES_1(label##_common, h);
+
 #define _MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)		\
 	__MASKABLE_EXCEPTION_PSERIES(vec, label, h, extra)
 
@@ -394,9 +433,16 @@ label##_hv:								\
 	_MASKABLE_EXCEPTION_PSERIES(vec, label,				\
 				    EXC_HV, SOFTEN_TEST_HV)
 
+#define MASKABLE_EXCEPTION_HV_OOL(vec, label)				\
+	.globl label##_hv;						\
+label##_hv:								\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_TEST_HV, vec);		\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_HV);
+
 #define __MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
 	HMT_MEDIUM_PPR_DISCARD;						\
 	SET_SCRATCH0(r13);    /* save r13 */				\
+	EXCEPTION_PROLOG_0(PACA_EXGEN);					\
 	__EXCEPTION_PROLOG_1(PACA_EXGEN, extra, vec);		\
 	EXCEPTION_RELON_PROLOG_PSERIES_1(label##_common, h);
 #define _MASKABLE_RELON_EXCEPTION_PSERIES(vec, label, h, extra)	\
@@ -416,6 +462,12 @@ label##_relon_hv:							\
 	_MASKABLE_RELON_EXCEPTION_PSERIES(vec, label,			\
 					  EXC_HV, SOFTEN_NOTEST_HV)
 
+#define MASKABLE_RELON_EXCEPTION_HV_OOL(vec, label)			\
+	.globl label##_relon_hv;					\
+label##_relon_hv:							\
+	EXCEPTION_PROLOG_1(PACA_EXGEN, SOFTEN_NOTEST_HV, vec);		\
+	EXCEPTION_PROLOG_PSERIES_1(label##_common, EXC_HV);
+
 /*
  * Our exception common code can be passed various "additions"
  * to specify the behaviour of interrupts, whether to kick the
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index dc64165..b9bcf21 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -153,7 +153,10 @@ machine_check_pSeries_1:
 	 * some code path might still want to branch into the original
 	 * vector
 	 */
-	b	machine_check_pSeries
+	HMT_MEDIUM_PPR_DISCARD
+	SET_SCRATCH0(r13)		/* save r13 */
+	EXCEPTION_PROLOG_0(PACA_EXMC)
+	b	machine_check_pSeries_0
 
 	. = 0x300
 	.globl data_access_pSeries
@@ -172,6 +175,7 @@ END_MMU_FTR_SECTION_IFCLR(MMU_FTR_SLB)
 data_access_slb_pSeries:
 	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST, 0x380)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
@@ -203,6 +207,7 @@ data_access_slb_pSeries:
 instruction_access_slb_pSeries:
 	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, KVMTEST_PR, 0x480)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
@@ -284,16 +289,28 @@ system_call_pSeries:
 	 */
 	. = 0xe00
 hv_exception_trampoline:
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_data_storage_hv
+
 	. = 0xe20
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_instr_storage_hv
+
 	. = 0xe40
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	emulation_assist_hv
-	. = 0xe50
-	b	hmi_exception_hv
+
 	. = 0xe60
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	hmi_exception_hv
+
 	. = 0xe80
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_doorbell_hv
 
 	/* We need to deal with the Altivec unavailable exception
@@ -303,14 +320,20 @@ hv_exception_trampoline:
 	 */
 performance_monitor_pSeries_1:
 	. = 0xf00
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	performance_monitor_pSeries
 
 altivec_unavailable_pSeries_1:
 	. = 0xf20
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	altivec_unavailable_pSeries
 
 vsx_unavailable_pSeries_1:
 	. = 0xf40
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	vsx_unavailable_pSeries
 
 #ifdef CONFIG_CBE_RAS
@@ -326,10 +349,7 @@ vsx_unavailable_pSeries_1:
 denorm_exception_hv:
 	HMT_MEDIUM_PPR_DISCARD
 	mtspr	SPRN_SPRG_HSCRATCH0,r13
-	mfspr	r13,SPRN_SPRG_HPACA
-	std	r9,PACA_EXGEN+EX_R9(r13)
-	HMT_MEDIUM_PPR_SAVE(PACA_EXGEN, r9)
-	std	r10,PACA_EXGEN+EX_R10(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	std	r11,PACA_EXGEN+EX_R11(r13)
 	std	r12,PACA_EXGEN+EX_R12(r13)
 	mfspr	r9,SPRN_SPRG_HSCRATCH0
@@ -372,8 +392,10 @@ machine_check_pSeries:
 machine_check_fwnmi:
 	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXMC, machine_check_common,
-				 EXC_STD, KVMTEST, 0x200)
+	EXCEPTION_PROLOG_0(PACA_EXMC)
+machine_check_pSeries_0:
+	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST, 0x200)
+	EXCEPTION_PROLOG_PSERIES_1(machine_check_common, EXC_STD)
 	KVM_HANDLER_SKIP(PACA_EXMC, EXC_STD, 0x200)
 
 	/* moved from 0x300 */
@@ -510,23 +532,23 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_ARCH_206)
 
 	.align	7
 	/* moved from 0xe00 */
-	STD_EXCEPTION_HV(., 0xe02, h_data_storage)
+	STD_EXCEPTION_HV_OOL(0xe02, h_data_storage)
 	KVM_HANDLER_SKIP(PACA_EXGEN, EXC_HV, 0xe02)
-	STD_EXCEPTION_HV(., 0xe22, h_instr_storage)
+	STD_EXCEPTION_HV_OOL(0xe22, h_instr_storage)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe22)
-	STD_EXCEPTION_HV(., 0xe42, emulation_assist)
+	STD_EXCEPTION_HV_OOL(0xe42, emulation_assist)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe42)
-	STD_EXCEPTION_HV(., 0xe62, hmi_exception) /* need to flush cache ? */
+	STD_EXCEPTION_HV_OOL(0xe62, hmi_exception) /* need to flush cache ? */
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe62)
-	MASKABLE_EXCEPTION_HV(., 0xe82, h_doorbell)
+	MASKABLE_EXCEPTION_HV_OOL(0xe82, h_doorbell)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe82)
 
 	/* moved from 0xf00 */
-	STD_EXCEPTION_PSERIES(., 0xf00, performance_monitor)
+	STD_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf00)
-	STD_EXCEPTION_PSERIES(., 0xf20, altivec_unavailable)
+	STD_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf20)
-	STD_EXCEPTION_PSERIES(., 0xf40, vsx_unavailable)
+	STD_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
 	KVM_HANDLER_PR(PACA_EXGEN, EXC_STD, 0xf40)
 
 /*
@@ -718,8 +740,8 @@ machine_check_common:
 	. = 0x4380
 	.globl data_access_slb_relon_pSeries
 data_access_slb_relon_pSeries:
-	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x380)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_DAR
@@ -743,8 +765,8 @@ data_access_slb_relon_pSeries:
 	. = 0x4480
 	.globl instruction_access_slb_relon_pSeries
 instruction_access_slb_relon_pSeries:
-	HMT_MEDIUM_PPR_DISCARD
 	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXSLB)
 	EXCEPTION_PROLOG_1(PACA_EXSLB, NOTEST, 0x480)
 	std	r3,PACA_EXSLB+EX_R3(r13)
 	mfspr	r3,SPRN_SRR0		/* SRR0 is faulting address */
@@ -788,33 +810,46 @@ system_call_relon_pSeries:
 	STD_RELON_EXCEPTION_PSERIES(0x4d00, 0xd00, single_step)
 
 	. = 0x4e00
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_data_storage_relon_hv
 
 	. = 0x4e20
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_instr_storage_relon_hv
 
 	. = 0x4e40
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	emulation_assist_relon_hv
 
-	. = 0x4e50
-	b	hmi_exception_relon_hv
-
 	. = 0x4e60
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	hmi_exception_relon_hv
 
 	. = 0x4e80
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	h_doorbell_relon_hv
 
 performance_monitor_relon_pSeries_1:
 	. = 0x4f00
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	performance_monitor_relon_pSeries
 
 altivec_unavailable_relon_pSeries_1:
 	. = 0x4f20
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	altivec_unavailable_relon_pSeries
 
 vsx_unavailable_relon_pSeries_1:
 	. = 0x4f40
+	SET_SCRATCH0(r13)
+	EXCEPTION_PROLOG_0(PACA_EXGEN)
 	b	vsx_unavailable_relon_pSeries
 
 	STD_RELON_EXCEPTION_PSERIES(0x5300, 0x1300, instruction_breakpoint)
@@ -1171,20 +1206,20 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 __end_handlers:
 
 	/* Equivalents to the above handlers for relocation-on interrupt vectors */
-	STD_RELON_EXCEPTION_HV(., 0xe00, h_data_storage)
+	STD_RELON_EXCEPTION_HV_OOL(0xe00, h_data_storage)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe00)
-	STD_RELON_EXCEPTION_HV(., 0xe20, h_instr_storage)
+	STD_RELON_EXCEPTION_HV_OOL(0xe20, h_instr_storage)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe20)
-	STD_RELON_EXCEPTION_HV(., 0xe40, emulation_assist)
+	STD_RELON_EXCEPTION_HV_OOL(0xe40, emulation_assist)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe40)
-	STD_RELON_EXCEPTION_HV(., 0xe60, hmi_exception)
+	STD_RELON_EXCEPTION_HV_OOL(0xe60, hmi_exception)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe60)
-	MASKABLE_RELON_EXCEPTION_HV(., 0xe80, h_doorbell)
+	MASKABLE_RELON_EXCEPTION_HV_OOL(0xe80, h_doorbell)
 	KVM_HANDLER(PACA_EXGEN, EXC_HV, 0xe80)
 
-	STD_RELON_EXCEPTION_PSERIES(., 0xf00, performance_monitor)
-	STD_RELON_EXCEPTION_PSERIES(., 0xf20, altivec_unavailable)
-	STD_RELON_EXCEPTION_PSERIES(., 0xf40, vsx_unavailable)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf00, performance_monitor)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf20, altivec_unavailable)
+	STD_RELON_EXCEPTION_PSERIES_OOL(0xf40, vsx_unavailable)
 
 #if defined(CONFIG_PPC_PSERIES) || defined(CONFIG_PPC_POWERNV)
 /*
-- 
1.7.10.4
