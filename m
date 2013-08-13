Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
Date: Tue, 13 Aug 2013 15:40:11 +1000
Message-ID: <22993.1376372411@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 anton@samba.org, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fcc: +outbox
Subject: [PATCH v2] powerpc: Avoid link stack corruption for MMU on exceptions
In-reply-to: <20130813150617.dba639d38dad2ea41668c4d4@canb.auug.org.au>
References: <18522.1376360422@ale.ozlabs.ibm.com> <20130813150617.dba639d38dad2ea41668c4d4@canb.auug.org.au>
Comments: In-reply-to Stephen Rothwell <sfr@canb.auug.org.au>
   message dated "Tue, 13 Aug 2013 15:06:17 +1000."
X-Mailer: MH-E 8.2; nmh 1.5; GNU Emacs 23.4.1
--------
When we have MMU on exceptions (POWER8) and a relocatable kernel, we
need to branch from the initial exception vectors at 0x0 to up high
where the kernel might be located.  Currently we do this using the link
register.

Unfortunately this corrupts the link stack and instead we should use the
count register.  We did this for the syscall entry path in:
  6a40480 powerpc: Avoid link stack corruption in MMU on syscall entry path
but I stupidly forgot to do the same for other exceptions.

This patches changes the initial exception vectors to use the count
register instead of the link register when we need to branch up to the
relocated kernel.

I have a dodgy userspace test which loops calling a function that reads
the PVR (mfpvr in userspace will be emulated by the kernel via the
program check exception).  On POWER8 and with CONFIG_RELOCATABLE=y, I
get a ~10% performance improvement with my userspace test with this
patch.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
v2: fix comments as noticed by sfr

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 07ca627..fe5e523 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -48,17 +48,18 @@
 #define EX_LR		72
 #define EX_CFAR		80
 #define EX_PPR		88	/* SMT thread status register (priority) */
+#define EX_CTR		96
 
 #ifdef CONFIG_RELOCATABLE
 #define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
 	ld	r12,PACAKBASE(r13);	/* get high part of &label */	\
 	mfspr	r11,SPRN_##h##SRR0;	/* save SRR0 */			\
 	LOAD_HANDLER(r12,label);					\
-	mtlr	r12;							\
+	mtctr	r12;							\
 	mfspr	r12,SPRN_##h##SRR1;	/* and SRR1 */			\
 	li	r10,MSR_RI;						\
 	mtmsrd 	r10,1;			/* Set RI (EE=0) */		\
-	blr;
+	bctr;
 #else
 /* If not relocatable, we can jump directly -- and save messing with LR */
 #define __EXCEPTION_RELON_PROLOG_PSERIES_1(label, h)			\
@@ -97,18 +98,18 @@
 
 #if defined(CONFIG_RELOCATABLE)
 /*
- * If we support interrupts with relocation on AND we're a relocatable
- * kernel, we need to use LR to get to the 2nd level handler.  So, save/restore
- * it when required.
+ * If we support interrupts with relocation on AND we're a relocatable kernel,
+ * we need to use CTR to get to the 2nd level handler.  So, save/restore it
+ * when required.
  */
-#define SAVE_LR(reg, area)	mflr	reg ; 	std	reg,area+EX_LR(r13)
-#define GET_LR(reg, area) 			ld	reg,area+EX_LR(r13)
-#define RESTORE_LR(reg, area)	ld	reg,area+EX_LR(r13) ; mtlr reg
+#define SAVE_CTR(reg, area)	mfctr	reg ; 	std	reg,area+EX_CTR(r13)
+#define GET_CTR(reg, area) 			ld	reg,area+EX_CTR(r13)
+#define RESTORE_CTR(reg, area)	ld	reg,area+EX_CTR(r13) ; mtctr reg
 #else
-/* ...else LR is unused and in register. */
-#define SAVE_LR(reg, area)
-#define GET_LR(reg, area) 	mflr	reg
-#define RESTORE_LR(reg, area)
+/* ...else CTR is unused and in register. */
+#define SAVE_CTR(reg, area)
+#define GET_CTR(reg, area) 	mfctr	reg
+#define RESTORE_CTR(reg, area)
 #endif
 
 /*
@@ -164,7 +165,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define __EXCEPTION_PROLOG_1(area, extra, vec)				\
 	OPT_SAVE_REG_TO_PACA(area+EX_PPR, r9, CPU_FTR_HAS_PPR);		\
 	OPT_SAVE_REG_TO_PACA(area+EX_CFAR, r10, CPU_FTR_CFAR);		\
-	SAVE_LR(r10, area);						\
+	SAVE_CTR(r10, area);						\
 	mfcr	r9;							\
 	extra(vec);							\
 	std	r11,area+EX_R11(r13);					\
@@ -270,7 +271,7 @@ do_kvm_##n:								\
 	sth	r1,PACA_TRAP_SAVE(r13);					   \
 	std	r3,area+EX_R3(r13);					   \
 	addi	r3,r13,area;		/* r3 -> where regs are saved*/	   \
-	RESTORE_LR(r1, area);						   \
+	RESTORE_CTR(r1, area);						   \
 	b	bad_stack;						   \
 3:	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
 	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
@@ -298,10 +299,10 @@ do_kvm_##n:								\
 	ld	r10,area+EX_CFAR(r13);					   \
 	std	r10,ORIG_GPR3(r1);					   \
 	END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);		   \
-	GET_LR(r9,area);		/* Get LR, later save to stack	*/ \
+	mflr	r9;			/* Get LR, later save to stack	*/ \
 	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
 	std	r9,_LINK(r1);						   \
-	mfctr	r10;			/* save CTR in stackframe	*/ \
+	GET_CTR(r10, area);						   \
 	std	r10,_CTR(r1);						   \
 	lbz	r10,PACASOFTIRQEN(r13);				   \
 	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 77c91e7..17d40a2 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -93,9 +93,9 @@ struct paca_struct {
 	 * Now, starting in cacheline 2, the exception save areas
 	 */
 	/* used for most interrupts/exceptions */
-	u64 exgen[12] __attribute__((aligned(0x80)));
-	u64 exmc[12];		/* used for machine checks */
-	u64 exslb[12];		/* used for SLB/segment table misses
+	u64 exgen[13] __attribute__((aligned(0x80)));
+	u64 exmc[13];		/* used for machine checks */
+	u64 exslb[13];		/* used for SLB/segment table misses
  				 * on the linear mapping */
 	/* SLB related definitions */
 	u16 vmalloc_sllp;
