Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 82F2DDE07A
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 04:29:56 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l47IToh4003472
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 11:29:51 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l47ITojt019063
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:29:50 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l47I83pa022243
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 13:08:03 -0500 (CDT)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 5E906AEFC9
	for <linuxppc-dev@ozlabs.org>; Mon,  7 May 2007 13:29:49 -0500 (CDT)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l47ITnDK026946
	for linuxppc-dev@ozlabs.org; Mon, 7 May 2007 13:29:49 -0500
Date: Mon, 7 May 2007 13:29:49 -0500
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 06/13] Make swsusp_32.S usable for suspend-to-RAM.
Message-ID: <20070507182949.GE26920@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070507182907.GA26897@ld0162-tx32.am.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This allows platform suspend code to re-use the generic state saving
code, passing a pointer to the low-level suspend code.

The resume path is modified so that non-hibernate callers skip
hibernate-specific bits, and so that callers can specify that the MMU is
off (and thus BATs should be restored).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/Kconfig            |   10 +++++++
 arch/powerpc/kernel/Makefile    |    2 +-
 arch/powerpc/kernel/swsusp_32.S |   57 ++++++++++++++++++++++----------------
 3 files changed, 44 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 49b1ea2..e51781e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -131,6 +131,16 @@ config PPC64_SWSUSP
 	depends on PPC64 && (BROKEN || (PPC_PMAC64 && EXPERIMENTAL))
 	default y
 
+config PPC_SUSPEND
+	bool
+	default n
+
+config PPC_SOFTWARE_SUSPEND
+	bool
+	depends on SOFTWARE_SUSPEND
+	select PPC_SUSPEND
+	default y
+
 menu "Processor support"
 choice
 	prompt "Processor Type"
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 4dc73b8..13cc430 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -37,8 +37,8 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 obj-$(CONFIG_6xx)		+= idle_6xx.o l2cr_6xx.o cpu_setup_6xx.o
 obj-$(CONFIG_TAU)		+= tau_6xx.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
-obj32-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_32.o
 obj64-$(CONFIG_SOFTWARE_SUSPEND) += swsusp_64.o swsusp_asm64.o
+obj32-$(CONFIG_PPC_SUSPEND)	+= swsusp_32.o
 obj32-$(CONFIG_MODULES)		+= module_32.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
diff --git a/arch/powerpc/kernel/swsusp_32.S b/arch/powerpc/kernel/swsusp_32.S
index 69e8f86..bc6dbc8 100644
--- a/arch/powerpc/kernel/swsusp_32.S
+++ b/arch/powerpc/kernel/swsusp_32.S
@@ -40,8 +40,13 @@ _GLOBAL(swsusp_save_area)
 	.section .text
 	.align	5
 
+#ifdef CONFIG_SOFTWARE_SUSPEND
 _GLOBAL(swsusp_arch_suspend)
+	lis	r3, swsusp_save@h
+	ori	r3, r3, swsusp_save@l
+#endif
 
+_GLOBAL(do_suspend)
 	lis	r11,swsusp_save_area@h
 	ori	r11,r11,swsusp_save_area@l
 
@@ -64,8 +69,8 @@ _GLOBAL(swsusp_arch_suspend)
 	stw	r4,SL_TB(r11)
 	mftb	r5
 	stw	r5,SL_TB+4(r11)
-	mftbu	r3
-	cmpw	r3,r4
+	mftbu	r6
+	cmpw	r6,r4
 	bne	1b
 
 	/* Save SPRGs */
@@ -119,7 +124,8 @@ _GLOBAL(swsusp_arch_suspend)
 	/* Call the low level suspend stuff (we should probably have made
 	 * a stackframe...
 	 */
-	bl	swsusp_save
+	mtctr	r3
+	bctrl
 
 	/* Restore LR from the save area */
 	lis	r11,swsusp_save_area@h
@@ -129,7 +135,7 @@ _GLOBAL(swsusp_arch_suspend)
 
 	blr
 
-
+#ifdef CONFIG_SOFTWARE_SUSPEND
 /* Resume code */
 _GLOBAL(swsusp_arch_resume)
 
@@ -212,6 +218,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	bdnz	1b
 	sync
 
+	li	r3, 0
+#endif
+
+	/* r3 = nonzero if the MMU is completely disabled and
+	 * BATs may be restored, zero otherwise.
+	 */
+_GLOBAL(do_resume)
 	/* Ok, we are now running with the kernel data of the old
 	 * kernel fully restored. We can get to the save area
 	 * easily now. As for the rest of the code, it assumes the
@@ -226,10 +239,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	bl	__restore_cpu_setup
 #endif
 	/* Restore the BATs, and SDR1.  Then we can turn on the MMU.
-	 * This is a bit hairy as we are running out of those BATs,
-	 * but first, our code is probably in the icache, and we are
-	 * writing the same value to the BAT, so that should be fine,
-	 * though a better solution will have to be found long-term
+	 * This can only be done when r3 != 0 (and thus the MMU is
+	 * off).
 	 */
 	lwz	r4,SL_SDR1(r11)
 	mtsdr1	r4
@@ -242,7 +253,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	lwz	r4,SL_SPRG0+12(r11)
 	mtsprg	3,r4
 
-#if 0
+	cmpw	r3, 0
+	beq	1f
+
 	lwz	r4,SL_DBAT0(r11)
 	mtdbatu	0,r4
 	lwz	r4,SL_DBAT0+4(r11)
@@ -275,8 +288,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	mtibatu	3,r4
 	lwz	r4,SL_IBAT3+4(r11)
 	mtibatl	3,r4
-#endif
 
+1:
 BEGIN_FTR_SECTION
 	li	r4,0
 	mtspr	SPRN_DBAT4U,r4
@@ -306,8 +319,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
 
 	/* restore the MSR and turn on the MMU */
 	lwz	r3,SL_MSR(r11)
-	bl	turn_on_mmu
-	tovirt(r11,r11)
+	lis	r4, 1f@h
+	ori	r4, r4, 1f@l
+
+	mtsrr0	r4
+	mtsrr1	r3
+	sync
+	isync
+	rfi
+
+1:	tovirt(r11, r11)
 
 	/* Restore TB */
 	li	r3,0
@@ -334,15 +355,3 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
 
 	li	r3,0
 	blr
-
-/* FIXME:This construct is actually not useful since we don't shut
- * down the instruction MMU, we could just flip back MSR-DR on.
- */
-turn_on_mmu:
-	mflr	r4
-	mtsrr0	r4
-	mtsrr1	r3
-	sync
-	isync
-	rfi
-
-- 
1.5.0.3
