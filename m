Message-ID: <40F57E20.4050004@pi.be>
Date: Wed, 14 Jul 2004 20:40:32 +0200
From: Stef Simoens <stef.simoens@pi.be>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] 601 MQ handling
Content-Type: multipart/mixed;
 boundary="------------060301020506080806060506"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------060301020506080806060506
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This is an (updated) patch for saving and restoring the MQ register on
old 601 CPU's for the 2.6.8-rc1 kernel.

The patch adds a configuration option to compile the neccesairy
instructions in the kernel or not. Compiled in, the instructions will
only be executed on a 601.

Stef

--------------060301020506080806060506
Content-Type: text/plain;
 name="linux-2.6.8-rc1-mq.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.8-rc1-mq.patch"

diff -ur linux-2.6.8-rc1/arch/ppc/Kconfig linux-2.6.8-rc1-mq/arch/ppc/Kconfig
--- linux-2.6.8-rc1/arch/ppc/Kconfig	2004-07-12 17:46:41.801627097 +0200
+++ linux-2.6.8-rc1-mq/arch/ppc/Kconfig	2004-07-12 20:34:03.845393066 +0200
@@ -225,6 +225,18 @@

 	  If in doubt, say Y here.

+config PPC601_MQ
+	bool "Enable MQ register on PPC601 CPU"
+	depends on 6xx && (PPC_PREP || PPC_PMAC)
+	help
+	  The PPC601 (the first PowerPC chip) has a special MQ register.
+	  This option enables kernel support for saving and restoring the MQ
+	  register.
+
+	  This option is only useful if you have a 601 processor and does
+	  not have any affect on other processors (it does, however, add
+	  code to the kernel). Say Y here if you have a 601 chip.
+
 source arch/ppc/platforms/4xx/Kconfig
 source arch/ppc/platforms/85xx/Kconfig

diff -ur linux-2.6.8-rc1/arch/ppc/kernel/cputable.c linux-2.6.8-rc1-mq/arch/ppc/kernel/cputable.c
--- linux-2.6.8-rc1/arch/ppc/kernel/cputable.c	2004-07-12 17:46:42.632411087 +0200
+++ linux-2.6.8-rc1-mq/arch/ppc/kernel/cputable.c	2004-07-12 20:22:37.631447272 +0200
@@ -67,7 +67,7 @@
     { 	/* 601 */
 	0xffff0000, 0x00010000, "601",
 	CPU_FTR_COMMON |
-	CPU_FTR_601 | CPU_FTR_HPTE_TABLE,
+	CPU_FTR_601 | CPU_FTR_HPTE_TABLE | CPU_FTR_MQ,
 	COMMON_PPC | PPC_FEATURE_601_INSTR | PPC_FEATURE_UNIFIED_CACHE,
 	32, 32,
 	__setup_cpu_601
diff -ur linux-2.6.8-rc1/arch/ppc/kernel/entry.S linux-2.6.8-rc1-mq/arch/ppc/kernel/entry.S
--- linux-2.6.8-rc1/arch/ppc/kernel/entry.S	2004-07-12 17:46:42.728155700 +0200
+++ linux-2.6.8-rc1-mq/arch/ppc/kernel/entry.S	2004-07-12 20:22:37.898734896 +0200
@@ -104,6 +104,12 @@
 	mfspr	r2,XER
 	stw	r12,_CTR(r11)
 	stw	r2,_XER(r11)
+#ifdef CONFIG_PPC601_MQ
+BEGIN_FTR_SECTION
+	mfspr	r2,SPRN_MQ
+	stw	r2,_MQ(r11)
+END_FTR_SECTION_IFSET(CPU_FTR_MQ)
+#endif /* CONFIG_PPC601_MQ */
 	mfspr	r12,SPRG3
 	addi	r2,r12,-THREAD
 	tovirt(r2,r2)			/* set r2 to current */
@@ -252,6 +258,12 @@
 	lwz	r5,_CCR(r1)
 	mtlr	r4
 	mtcr	r5
+#ifdef CONFIG_PPC601_MQ
+BEGIN_FTR_SECTION
+	lwz	r7,_MQ(r1)
+	mtspr	SPRN_MQ,r7
+END_FTR_SECTION_IFSET(CPU_FTR_MQ)
+#endif /* CONFIG_PPC601_MQ */
 	lwz	r7,_NIP(r1)
 	lwz	r8,_MSR(r1)
 	FIX_SRR1(r8, r0)
@@ -523,6 +535,12 @@
 1:	stw	r11,_MSR(r1)
 	mfcr	r10
 	stw	r10,_CCR(r1)
+#ifdef CONFIG_PPC601_MQ
+BEGIN_FTR_SECTION
+	mfspr	r10,SPRN_MQ
+	stw	r10,_MQ(r1)
+END_FTR_SECTION_IFSET(CPU_FTR_MQ)
+#endif /* CONFIG_PPC601_MQ */
 	stw	r1,KSP(r3)	/* Set old stack pointer */

 #ifdef CONFIG_SMP
@@ -555,6 +573,12 @@

 	lwz	r0,_CCR(r1)
 	mtcrf	0xFF,r0
+#ifdef CONFIG_PPC601_MQ
+BEGIN_FTR_SECTION
+	lwz	r0,_MQ(r1)
+	mtspr	SPRN_MQ,r0
+END_FTR_SECTION_IFSET(CPU_FTR_MQ)
+#endif /* CONFIG_PPC601_MQ */
 	/* r3-r12 are destroyed -- Cort */
 	REST_NVGPRS(r1)

@@ -663,6 +687,12 @@
 	lwz	r11,_LINK(r1)
 	mtcrf	0xFF,r10
 	mtlr	r11
+#ifdef CONFIG_PPC601_MQ
+BEGIN_FTR_SECTION
+	lwz	r10,_MQ(r1)
+	mtspr	SPRN_MQ,r10
+END_FTR_SECTION_IFSET(CPU_FTR_MQ)
+#endif /* CONFIG_PPC601_MQ */

 	/*
 	 * Once we put values in SRR0 and SRR1, we are in a state
diff -ur linux-2.6.8-rc1/arch/ppc/kernel/ppc-stub.c linux-2.6.8-rc1-mq/arch/ppc/kernel/ppc-stub.c
--- linux-2.6.8-rc1/arch/ppc/kernel/ppc-stub.c	2004-07-12 17:46:43.310602098 +0200
+++ linux-2.6.8-rc1-mq/arch/ppc/kernel/ppc-stub.c	2004-07-12 20:22:38.165025177 +0200
@@ -685,13 +685,14 @@
 				ptr[i] = '0';
 			}
 			ptr += 32*8*2;
-			/* pc, msr, cr, lr, ctr, xer, (mq is unused) */
+			/* pc, msr, cr, lr, ctr, xer, mq (only on 601) */
 			ptr = mem2hex((char *)&regs->nip, ptr, 4);
 			ptr = mem2hex((char *)&regs->msr, ptr, 4);
 			ptr = mem2hex((char *)&regs->ccr, ptr, 4);
 			ptr = mem2hex((char *)&regs->link, ptr, 4);
 			ptr = mem2hex((char *)&regs->ctr, ptr, 4);
 			ptr = mem2hex((char *)&regs->xer, ptr, 4);
+			ptr = mem2hex((char *)&regs->mq, ptr, 4);
 		}
 			break;

@@ -711,13 +712,14 @@
 			/*ptr = hex2mem(ptr, ??, 32 * 8);*/
 			ptr += 32*8*2;

-			/* pc, msr, cr, lr, ctr, xer, (mq is unused) */
+			/* pc, msr, cr, lr, ctr, xer, mq (only on 601) */
 			ptr = hex2mem(ptr, (char *)&regs->nip, 4);
 			ptr = hex2mem(ptr, (char *)&regs->msr, 4);
 			ptr = hex2mem(ptr, (char *)&regs->ccr, 4);
 			ptr = hex2mem(ptr, (char *)&regs->link, 4);
 			ptr = hex2mem(ptr, (char *)&regs->ctr, 4);
 			ptr = hex2mem(ptr, (char *)&regs->xer, 4);
+			ptr = hex2mem(ptr, (char *)&regs->mq, 4);

 			strcpy(remcomOutBuffer,"OK");
 		}
diff -ur linux-2.6.8-rc1/include/asm-ppc/cputable.h linux-2.6.8-rc1-mq/include/asm-ppc/cputable.h
--- linux-2.6.8-rc1/include/asm-ppc/cputable.h	2004-06-16 07:19:22.000000000 +0200
+++ linux-2.6.8-rc1-mq/include/asm-ppc/cputable.h	2004-07-12 20:22:38.241820502 +0200
@@ -76,6 +76,7 @@
 #define CPU_FTR_NO_DPM			0x00008000
 #define CPU_FTR_HAS_HIGH_BATS		0x00010000
 #define CPU_FTR_NEED_COHERENT           0x00020000
+#define CPU_FTR_MQ			0x00040000

 #ifdef __ASSEMBLY__

diff -ur linux-2.6.8-rc1/include/asm-ppc/ptrace.h linux-2.6.8-rc1-mq/include/asm-ppc/ptrace.h
--- linux-2.6.8-rc1/include/asm-ppc/ptrace.h	2004-07-12 17:49:59.282833840 +0200
+++ linux-2.6.8-rc1-mq/include/asm-ppc/ptrace.h	2004-07-12 20:22:38.346541399 +0200
@@ -27,7 +27,7 @@
 	unsigned long link;
 	unsigned long xer;
 	unsigned long ccr;
-	unsigned long mq;		/* 601 only (not used at present) */
+	unsigned long mq;		/* 601 only */
 					/* Used on APUS to hold IPL value. */
 	unsigned long trap;		/* Reason for being here */
 	/* N.B. for critical exceptions on 4xx, the dar and dsisr
diff -ur linux-2.6.8-rc1/include/asm-ppc/reg.h linux-2.6.8-rc1-mq/include/asm-ppc/reg.h
--- linux-2.6.8-rc1/include/asm-ppc/reg.h	2004-07-12 17:49:59.325719433 +0200
+++ linux-2.6.8-rc1-mq/include/asm-ppc/reg.h	2004-07-12 20:22:38.528057621 +0200
@@ -320,6 +320,7 @@
 #define SPRN_USIA	0x3AB	/* User Sampled Instruction Address Register */
 #define SPRN_VRSAVE	0x100	/* Vector Register Save Register */
 #define SPRN_XER	0x001	/* Fixed Point Exception Register */
+#define SPRN_MQ		0x000	/* MQ Register */

 /* Bit definitions for MMCR0 and PMC1 / PMC2. */
 #define MMCR0_PMC1_CYCLES	(1 << 7)

--------------060301020506080806060506--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
