Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x234.google.com (mail-pf0-x234.google.com
 [IPv6:2607:f8b0:400e:c00::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3svhGJ0lKNzDsyK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Oct 2016 17:51:20 +1100 (AEDT)
Received: by mail-pf0-x234.google.com with SMTP id r16so7219422pfg.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Oct 2016 23:51:20 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	Anton Blanchard <anton@samba.org>
Subject: [PATCH][RFC] powerpc/64s: Use emergency stack for 0x100 system reset
 interrupt
Date: Thu, 13 Oct 2016 17:51:06 +1100
Message-Id: <20161013065106.5389-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also use EX_NMI save space. This should give cleaner debug data in
case kernel stacks have become corrupted.

MSR_RI is kept clear for the 0x100 handler, because we can't mask it,
and can't tolerate a reentrant NMI. Technically the 0x100 is not really
recoverable yet, because it could trample on another emergency stack
user. This will require a bit more work to safely implement, but for
now we don't need to recover after a 0x100.

A little bit of the emergency stack / MSR_RI handling differences seem
like they can be consolidated with some other handlers. I'll split those
into a couple more patches before submitting.

I moved the MC save area in the paca out from between the general and
slb save areas, and put it with the nmi area because it shouldn't be used
much.

Thanks,
Nick

---
 arch/powerpc/include/asm/exception-64s.h | 61 ++++++++++++++++++++++++++++----
 arch/powerpc/include/asm/paca.h          |  6 +++-
 arch/powerpc/kernel/asm-offsets.c        |  3 +-
 arch/powerpc/kernel/exceptions-64s.S     | 43 ++++++++--------------
 4 files changed, 77 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 84d49b1..335b8f1 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -191,11 +191,32 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define EXCEPTION_PROLOG_PSERIES_1(label, h)				\
 	__EXCEPTION_PROLOG_PSERIES_1(label, h)
 
+/* _NORI variant keeps MSR_RI clear */
+#define __EXCEPTION_PROLOG_PSERIES_1_NORI(label, h)			\
+	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
+	ld	r10,PACAKMSR(r13);	/* get MSR value for kernel */	\
+	xori	r10,r10,MSR_RI;		/* Clear MSR_RI */		\
+	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
+	LOAD_HANDLER(r12,label)						\
+	mtspr	SPRN_##h##SRR0,r12;					\
+	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
+	mtspr	SPRN_##h##SRR1,r10;					\
+	h##rfid;							\
+	b	.	/* prevent speculative execution */
+
+#define EXCEPTION_PROLOG_PSERIES_1_NORI(label, h)			\
+	__EXCEPTION_PROLOG_PSERIES_1_NORI(label, h)
+
 #define EXCEPTION_PROLOG_PSERIES(area, label, h, extra, vec)		\
 	EXCEPTION_PROLOG_0(area);					\
 	EXCEPTION_PROLOG_1(area, extra, vec);				\
 	EXCEPTION_PROLOG_PSERIES_1(label, h);
 
+#define EXCEPTION_PROLOG_PSERIES_NORI(area, label, h, extra, vec)	\
+	EXCEPTION_PROLOG_0(area);					\
+	EXCEPTION_PROLOG_1(area, extra, vec);				\
+	EXCEPTION_PROLOG_PSERIES_1_NORI(label, h);
+
 #define __KVMTEST(h, n)							\
 	lbz	r10,HSTATE_IN_GUEST(r13);				\
 	cmpwi	r10,0;							\
@@ -273,6 +294,19 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 
 #define NOTEST(n)
 
+#define EXCEPTION_PROLOG_COMMON_EMSTACK(n, area)			   \
+	mr	r10,r1;			/* Save r1			*/ \
+	ld	r1,PACAEMERGSP(r13);	/* Use emergency kernel stack	*/ \
+	subi	r1,r1,INT_FRAME_SIZE;	/* alloc stack frame		*/ \
+	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
+	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
+	std	r12,_MSR(r1);		/* save SRR1 in stackframe	*/ \
+	std	r10,0(r1);		/* make stack chain pointer	*/ \
+	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
+	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
+	EXCEPTION_PROLOG_COMMON_2(area)					   \
+	EXCEPTION_PROLOG_COMMON_3(n)
+
 /*
  * The common exception prolog is used for all except a few exceptions
  * such as a segment miss on a kernel address.  We have to be prepared
@@ -495,8 +529,16 @@ BEGIN_FTR_SECTION				\
 	beql	ppc64_runlatch_on_trampoline;	\
 END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 
-#define EXCEPTION_COMMON(trap, label, hdlr, ret, additions)	\
-	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);		\
+#define EXCEPTION_COMMON(area, trap, label, hdlr, ret, additions) \
+	EXCEPTION_PROLOG_COMMON(trap, area);			\
+	/* Volatile regs are potentially clobbered here */	\
+	additions;						\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	bl	hdlr;						\
+	b	ret
+
+#define EXCEPTION_COMMON_EMSTACK(area, trap, label, hdlr, ret, additions) \
+	EXCEPTION_PROLOG_COMMON_EMSTACK(trap, area);		\
 	/* Volatile regs are potentially clobbered here */	\
 	additions;						\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
@@ -504,7 +546,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
 	b	ret
 
 #define STD_EXCEPTION_COMMON(trap, label, hdlr)			\
-	EXCEPTION_COMMON(trap, label, hdlr, ret_from_except,	\
+	EXCEPTION_COMMON(PACA_EXGEN, trap, label, hdlr, ret_from_except, \
 			 ADD_NVGPRS;ADD_RECONCILE)
 
 /*
@@ -512,9 +554,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
  * in the idle task and therefore need the special idle handling
  * (finish nap and runlatch)
  */
-#define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)		  \
-	EXCEPTION_COMMON(trap, label, hdlr, ret_from_except_lite, \
-			 FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON)
+#define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)			\
+	EXCEPTION_COMMON(PACA_EXGEN, trap, label, hdlr,			\
+		ret_from_except_lite, FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON)
+
+/*
+ * Like STD_EXCEPTION_COMMON, but for "NMI" exceptions.
+ */
+#define NMI_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)			\
+	EXCEPTION_COMMON_EMSTACK(PACA_EXNMI, trap, label, hdlr,		\
+		ret_from_except_lite, FINISH_NAP;ADD_RECONCILE;RUNLATCH_ON)
 
 /*
  * When the idle code in power4_idle puts the CPU into NAP mode,
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 6a6792b..06e9664 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -99,7 +99,6 @@ struct paca_struct {
 	 */
 	/* used for most interrupts/exceptions */
 	u64 exgen[13] __attribute__((aligned(0x80)));
-	u64 exmc[13];		/* used for machine checks */
 	u64 exslb[13];		/* used for SLB/segment table misses
  				 * on the linear mapping */
 	/* SLB related definitions */
@@ -174,6 +173,11 @@ struct paca_struct {
 	u8 subcore_sibling_mask;
 #endif
 
+#ifdef CONFIG_PPC_STD_MMU_64
+	/* Non-maskable exceptions that are not performance critical */
+	u64 exnmi[13];		/* used for system reset (nmi) */
+	u64 exmc[13];		/* used for machine checks */
+#endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	/* Exclusive emergency stack pointer for machine check exception. */
 	void *mc_emergency_sp;
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index caec7bf..0e8fde5c 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -222,8 +222,9 @@ int main(void)
 	DEFINE(PACACONTEXTSLLP, offsetof(struct paca_struct, mm_ctx_sllp));
 #endif /* CONFIG_PPC_MM_SLICES */
 	DEFINE(PACA_EXGEN, offsetof(struct paca_struct, exgen));
-	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
 	DEFINE(PACA_EXSLB, offsetof(struct paca_struct, exslb));
+	DEFINE(PACA_EXNMI, offsetof(struct paca_struct, exnmi));
+	DEFINE(PACA_EXMC, offsetof(struct paca_struct, exmc));
 	DEFINE(PACALPPACAPTR, offsetof(struct paca_struct, lppaca_ptr));
 	DEFINE(PACA_SLBSHADOWPTR, offsetof(struct paca_struct, slb_shadow_ptr));
 	DEFINE(SLBSHADOW_STACKVSID,
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 4af87e4..6f429d9 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -116,7 +116,11 @@ EXC_VIRT_NONE(0x4000, 0x4100)
 
 EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
 	SET_SCRATCH0(r13)
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
+	/*
+	 * MSR_RI is not enabled, because PACA_EXNMI and emergency stack is
+	 * being used, so a nested NMI exception would corrupt it.
+	 */
+	EXCEPTION_PROLOG_PSERIES_NORI(PACA_EXNMI, system_reset_common, EXC_STD,
 				 IDLETEST, 0x100)
 
 EXC_REAL_END(system_reset, 0x100, 0x200)
@@ -148,7 +152,8 @@ EXC_COMMON_BEGIN(system_reset_idle_common)
 2:	b	pnv_wakeup_noloss
 #endif
 
-EXC_COMMON(system_reset_common, 0x100, system_reset_exception)
+EXC_COMMON_BEGIN(system_reset_common)
+	NMI_EXCEPTION_COMMON_ASYNC(0x100, system_reset, system_reset_exception)
 
 #ifdef CONFIG_PPC_PSERIES
 /*
@@ -156,7 +161,8 @@ EXC_COMMON(system_reset_common, 0x100, system_reset_exception)
  */
 TRAMP_REAL_BEGIN(system_reset_fwnmi)
 	SET_SCRATCH0(r13)		/* save r13 */
-	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
+	/* See comment at system_reset exception */
+	EXCEPTION_PROLOG_PSERIES_NORI(PACA_EXNMI, system_reset_common, EXC_STD,
 				 NOTEST, 0x100)
 #endif /* CONFIG_PPC_PSERIES */
 
@@ -263,20 +269,11 @@ machine_check_fwnmi:
 machine_check_pSeries_0:
 	EXCEPTION_PROLOG_1(PACA_EXMC, KVMTEST_PR, 0x200)
 	/*
-	 * The following is essentially EXCEPTION_PROLOG_PSERIES_1 with the
-	 * difference that MSR_RI is not enabled, because PACA_EXMC is being
-	 * used, so nested machine check corrupts it. machine_check_common
-	 * enables MSR_RI.
+	 * MSR_RI is not enabled, because PACA_EXMC is being used, so a
+	 * nested machine check corrupts it. machine_check_common enables
+	 * MSR_RI.
 	 */
-	ld	r10,PACAKMSR(r13)
-	xori	r10,r10,MSR_RI
-	mfspr	r11,SPRN_SRR0
-	LOAD_HANDLER(r12, machine_check_common)
-	mtspr	SPRN_SRR0,r12
-	mfspr	r12,SPRN_SRR1
-	mtspr	SPRN_SRR1,r10
-	rfid
-	b	.	/* prevent speculative execution */
+	EXCEPTION_PROLOG_PSERIES_1_NORI(machine_check_common, EXC_STD)
 
 TRAMP_KVM_SKIP(PACA_EXMC, 0x200)
 
@@ -960,19 +957,9 @@ EXC_VIRT_NONE(0x4e60, 0x4e80)
 TRAMP_KVM_HV(PACA_EXGEN, 0xe60)
 TRAMP_REAL_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_1(PACA_EXGEN, KVMTEST_HV, 0xe60)
-	mr	r10,r1			/* Save r1			*/
-	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack		*/
-	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
-	std	r9,_CCR(r1)		/* save CR in stackframe	*/
 	mfspr	r11,SPRN_HSRR0		/* Save HSRR0 */
-	std	r11,_NIP(r1)		/* save HSRR0 in stackframe	*/
-	mfspr	r12,SPRN_HSRR1		/* Save SRR1 */
-	std	r12,_MSR(r1)		/* save SRR1 in stackframe	*/
-	std	r10,0(r1)		/* make stack chain pointer	*/
-	std	r0,GPR0(r1)		/* save r0 in stackframe	*/
-	std	r10,GPR1(r1)		/* save r1 in stackframe	*/
-	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
-	EXCEPTION_PROLOG_COMMON_3(0xe60)
+	mfspr	r12,SPRN_HSRR1		/* Save HSRR1 */
+	EXCEPTION_PROLOG_COMMON_EMSTACK(0xe60, PACA_EXGEN)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	hmi_exception_realmode
 	/* Windup the stack. */
-- 
2.9.3
