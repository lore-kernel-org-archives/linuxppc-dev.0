Date: Wed, 16 Jun 2004 22:42:52 +0200
Message-Id: <HZF5JG$8DFE4973242834322717FEB2CD3FE797@scarlet.be>
Subject: [PATCH] PPC601 MQ handling
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "Stef Simoens" <stef.simoens@pi.be>
To: "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Cc: "benh" <benh@kernel.crashing.org>, "paulus" <paulus@samba.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a patch to handle the MQ-register found on 601 CPU's. It's a diff against linux-2.6.7. Could this patch be included in further Linux kernels?

The patch can also be downloaded from http://users.tijd.com/~tdn46485/linux-2.6.7-mq.patch
I also wrote a small testcase (http://users.tijd.com/~tdn46485/mqtest.s)
The test makes a division, enters a for loop, and prints the contents of the MQ register.

Changes:
* Add a CONFIG_PPC601_MQ option
* Set CPU_FTR_MQ for 601 (arch/ppc/cputable.c, include/asm-ppc/cputable.h)
* Save and restore the MQ register (arch/ppc/entry.S, include/asm-ppc/reg.h)
* Delete the 'not used' message, mq debug (arch/ppc/kernel/ppc-stub.c, include/asm-ppc/ptrace.h)

Signed-off-by: Stef Simoens <stef.simoens@pi.be>

diff -upr linux-2.6.7/arch/ppc/Kconfig linux-2.6.7-mq/arch/ppc/Kconfig
--- linux-2.6.7/arch/ppc/Kconfig	2004-06-16 07:20:22.000000000 +0200
+++ linux-2.6.7-mq/arch/ppc/Kconfig	2004-06-16 13:00:08.000000000 +0200
@@ -197,6 +197,19 @@ config PPC601_SYNC_FIX

 	  If in doubt, say Y here.

+config PPC601_MQ
+	bool "Enable MQ register on PPC601 CPU"
+	depends on 6xx && (PPC_PREP || PPC_PMAC)
+	help
+	  The PPC601 (the first PowerPC chip) has a special MQ register.
+	  This option enables kernel support for saving and restoring the MQ
+	  register. This will allow to use gcc's -mcpu=601 option without
+	  breaking executables.
+
+	  This option is only useful if you have a 601 processor and does
+	  not have any affect on other processors (it does, however, add
+	  code to the kernel). Say Y here if you have a 601 chip.
+
 source arch/ppc/platforms/4xx/Kconfig

 config PPC64BRIDGE
diff -upr linux-2.6.7/arch/ppc/kernel/cputable.c linux-2.6.7-mq/arch/ppc/kernel/cputable.c
--- linux-2.6.7/arch/ppc/kernel/cputable.c	2004-06-16 07:19:26.000000000 +0200
+++ linux-2.6.7-mq/arch/ppc/kernel/cputable.c	2004-06-16 13:00:08.000000000 +0200
@@ -66,7 +66,7 @@ struct cpu_spec	cpu_specs[] = {
     { 	/* 601 */
 	0xffff0000, 0x00010000, "601",
 	CPU_FTR_COMMON |
-	CPU_FTR_601 | CPU_FTR_HPTE_TABLE,
+	CPU_FTR_601 | CPU_FTR_HPTE_TABLE | CPU_FTR_MQ,
 	COMMON_PPC | PPC_FEATURE_601_INSTR | PPC_FEATURE_UNIFIED_CACHE,
 	32, 32,
 	__setup_cpu_601
diff -upr linux-2.6.7/arch/ppc/kernel/entry.S linux-2.6.7-mq/arch/ppc/kernel/entry.S
--- linux-2.6.7/arch/ppc/kernel/entry.S	2004-06-16 07:19:52.000000000 +0200
+++ linux-2.6.7-mq/arch/ppc/kernel/entry.S	2004-06-16 13:00:08.000000000 +0200
@@ -104,6 +104,12 @@ transfer_to_handler:
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
@@ -641,6 +647,12 @@ restore:
 	lwz	r11,_CTR(r1)
 	mtspr	XER,r10
 	mtctr	r11
+#ifdef CONFIG_PPC601_MQ
+BEGIN_FTR_SECTION
+	lwz	r10,_MQ(r1)
+	mtspr	SPRN_MQ,r10
+END_FTR_SECTION_IFSET(CPU_FTR_MQ)
+#endif /* CONFIG_PPC601_MQ */

 	PPC405_ERR77(0,r1)
 	stwcx.	r0,0,r1			/* to clear the reservation */
@@ -738,6 +750,12 @@ ret_from_crit_exc:
 	lwz	r11,_CTR(r1)
 	mtspr	XER,r10
 	mtctr	r11
+#ifdef CONFIG_PPC601_MQ
+BEGIN_FTR_SECTION
+	lwz	r10,_MQ(r1)
+	mtspr	SPRN_MQ,r10
+END_FTR_SECTION_IFSET(CPU_FTR_MQ)
+#endif /* CONFIG_PPC601_MQ */

 	PPC405_ERR77(0,r1)
 	stwcx.	r0,0,r1			/* to clear the reservation */
diff -upr linux-2.6.7/arch/ppc/kernel/ppc-stub.c linux-2.6.7-mq/arch/ppc/kernel/ppc-stub.c
--- linux-2.6.7/arch/ppc/kernel/ppc-stub.c	2004-06-16 07:20:03.000000000 +0200
+++ linux-2.6.7-mq/arch/ppc/kernel/ppc-stub.c	2004-06-16 13:00:08.000000000 +0200
@@ -690,6 +690,7 @@ handle_exception (struct pt_regs *regs)
 			ptr = mem2hex((char *)&regs->link, ptr, 4);
 			ptr = mem2hex((char *)&regs->ctr, ptr, 4);
 			ptr = mem2hex((char *)&regs->xer, ptr, 4);
+			ptr = mem2hex((char *)&regs->mq, ptr, 4);
 		}
 			break;

@@ -709,13 +710,14 @@ handle_exception (struct pt_regs *regs)
 			/*ptr = hex2mem(ptr, ??, 32 * 8);*/
 			ptr += 32*8*2;

-			/* pc, msr, cr, lr, ctr, xer, (mq is unused) */
+			/* pc, msr, cr, lr, ctr, xer, mq */
 			ptr = hex2mem(ptr, (char *)&regs->nip, 4);
 			ptr = hex2mem(ptr, (char *)&regs->msr, 4);
 			ptr = hex2mem(ptr, (char *)&regs->ccr, 4);
 			ptr = hex2mem(ptr, (char *)&regs->link, 4);
 			ptr = hex2mem(ptr, (char *)&regs->ctr, 4);
 			ptr = hex2mem(ptr, (char *)&regs->xer, 4);
+			ptr = hex2mem(ptr, (char *)&regs->mq, 4);

 			strcpy(remcomOutBuffer,"OK");
 		}
diff -upr linux-2.6.7/include/asm-ppc/cputable.h linux-2.6.7-mq/include/asm-ppc/cputable.h
--- linux-2.6.7/include/asm-ppc/cputable.h	2004-06-16 07:19:22.000000000 +0200
+++ linux-2.6.7-mq/include/asm-ppc/cputable.h	2004-06-16 13:00:09.000000000 +0200
@@ -76,6 +76,7 @@ extern struct cpu_spec		*cur_cpu_spec[];
 #define CPU_FTR_NO_DPM			0x00008000
 #define CPU_FTR_HAS_HIGH_BATS		0x00010000
 #define CPU_FTR_NEED_COHERENT           0x00020000
+#define CPU_FTR_MQ			0x00040000

 #ifdef __ASSEMBLY__

diff -upr linux-2.6.7/include/asm-ppc/ptrace.h linux-2.6.7-mq/include/asm-ppc/ptrace.h
--- linux-2.6.7/include/asm-ppc/ptrace.h	2004-06-16 07:19:23.000000000 +0200
+++ linux-2.6.7-mq/include/asm-ppc/ptrace.h	2004-06-16 13:00:09.000000000 +0200
@@ -27,7 +27,7 @@ struct pt_regs {
 	unsigned long link;
 	unsigned long xer;
 	unsigned long ccr;
-	unsigned long mq;		/* 601 only (not used at present) */
+	unsigned long mq;		/* 601 only */
 					/* Used on APUS to hold IPL value. */
 	unsigned long trap;		/* Reason for being here */
 	/* N.B. for critical exceptions on 4xx, the dar and dsisr
diff -upr linux-2.6.7/include/asm-ppc/reg.h linux-2.6.7-mq/include/asm-ppc/reg.h
--- linux-2.6.7/include/asm-ppc/reg.h	2004-06-16 07:19:52.000000000 +0200
+++ linux-2.6.7-mq/include/asm-ppc/reg.h	2004-06-16 13:00:09.000000000 +0200
@@ -316,6 +316,7 @@
 #define SPRN_USIA	0x3AB	/* User Sampled Instruction Address Register */
 #define SPRN_VRSAVE	0x100	/* Vector Register Save Register */
 #define SPRN_XER	0x001	/* Fixed Point Exception Register */
+#define SPRN_MQ		0x000	/* MQ Register */

 /* Bit definitions for MMCR0 and PMC1 / PMC2. */
 #define MMCR0_PMC1_CYCLES	(1 << 7)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
