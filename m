Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0E3EC67A46
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 16:06:10 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 16:05:54 +1000
Message-Id: <1112681154.9517.7.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] Update ppc32-fix-errata-for-some-g3-cpus.patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrew !

The previous version of ppc32-fix-errata-for-some-g3-cpus.patch had an
issue that would crash some G4 CPUs on boot. This is fixed in this new
version, please replace the old one and send to linus asap (it's now
been tested on enough CPUs).

---

Some G3 CPUs can crash in funny way if a store from an FPU register
instruction is executed on a register that has never been initialized
since power on. This patch fixes it by making sure all FP registers have
been properly initialized at kernel boot and when waking from sleep. It
also makes the code that decides wether HID0_BTIC and HID0_DPM are
allowed on a given CPU smarter (it can actually _clear_ them now if they
are not allowed instead of just setting them when they are allowed in
case the firmware got them wrong)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Index: linux-work/arch/ppc/kernel/cpu_setup_6xx.S
===================================================================
--- linux-work.orig/arch/ppc/kernel/cpu_setup_6xx.S	2005-03-15 11:56:39.000000000 +1100
+++ linux-work/arch/ppc/kernel/cpu_setup_6xx.S	2005-04-05 15:57:49.000000000 +1000
@@ -30,12 +30,14 @@
 	blr
 _GLOBAL(__setup_cpu_750)
 	mflr	r4
+	bl	__init_fpu_registers
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
 	mtlr	r4
 	blr
 _GLOBAL(__setup_cpu_750cx)
 	mflr	r4
+	bl	__init_fpu_registers
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
 	bl	setup_750cx
@@ -43,6 +45,7 @@
 	blr
 _GLOBAL(__setup_cpu_750fx)
 	mflr	r4
+	bl	__init_fpu_registers
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
 	bl	setup_750fx
@@ -50,6 +53,7 @@
 	blr
 _GLOBAL(__setup_cpu_7400)
 	mflr	r4
+	bl	__init_fpu_registers
 	bl	setup_7400_workarounds
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
@@ -57,6 +61,7 @@
 	blr
 _GLOBAL(__setup_cpu_7410)
 	mflr	r4
+	bl	__init_fpu_registers
 	bl	setup_7410_workarounds
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
@@ -80,7 +85,7 @@
 	bne	1f			/* don't invalidate the D-cache */
 	ori	r8,r8,HID0_DCI		/* unless it wasn't enabled */
 1:	sync
-	mtspr	SPRN_HID0,r8			/* enable and invalidate caches */
+	mtspr	SPRN_HID0,r8		/* enable and invalidate caches */
 	sync
 	mtspr	SPRN_HID0,r11		/* enable caches */
 	sync
@@ -151,10 +156,14 @@
  */
 setup_750_7400_hid0:
 	mfspr	r11,SPRN_HID0
-	ori	r11,r11,HID0_SGE | HID0_ABE | HID0_BHTE | HID0_BTIC
+	ori	r11,r11,HID0_SGE | HID0_ABE | HID0_BHTE | HID0_BTIC	
+	oris	r11,r11,HID0_DPM@h
 BEGIN_FTR_SECTION
-	oris	r11,r11,HID0_DPM@h	/* enable dynamic power mgmt */
-END_FTR_SECTION_IFCLR(CPU_FTR_NO_DPM)
+	xori	r11,r11,HID0_BTIC
+END_FTR_SECTION_IFSET(CPU_FTR_NO_BTIC)
+BEGIN_FTR_SECTION
+	xoris	r11,r11,HID0_DPM@h	/* disable dynamic power mgmt */
+END_FTR_SECTION_IFSET(CPU_FTR_NO_DPM)
 	li	r3,HID0_SPD
 	andc	r11,r11,r3		/* clear SPD: enable speculative */
  	li	r3,0
@@ -218,13 +227,15 @@
 
 	/* All of the bits we have to set.....
 	 */
-	ori	r11,r11,HID0_SGE | HID0_FOLD | HID0_BHTE | HID0_LRSTK | HID0_BTIC
+	ori	r11,r11,HID0_SGE | HID0_FOLD | HID0_BHTE
+	ori	r11,r11,HID0_LRSTK | HID0_BTIC
+	oris	r11,r11,HID0_DPM@h
 BEGIN_FTR_SECTION
 	xori	r11,r11,HID0_BTIC
 END_FTR_SECTION_IFSET(CPU_FTR_NO_BTIC)
 BEGIN_FTR_SECTION
-	oris	r11,r11,HID0_DPM@h	/* enable dynamic power mgmt */
-END_FTR_SECTION_IFCLR(CPU_FTR_NO_DPM)
+	xoris	r11,r11,HID0_DPM@h	/* disable dynamic power mgmt */
+END_FTR_SECTION_IFSET(CPU_FTR_NO_DPM)
 
 	/* All of the bits we have to clear....
 	 */
@@ -248,6 +259,25 @@
 	isync
 	blr
 
+/*
+ * Initialize the FPU registers. This is needed to work around an errata
+ * in some 750 cpus where using a not yet initialized FPU register after
+ * power on reset may hang the CPU
+ */
+_GLOBAL(__init_fpu_registers)
+	mfmsr	r10
+	ori	r11,r10,MSR_FP
+	mtmsr	r11
+	isync	
+	addis	r9,r3,empty_zero_page@ha
+	addi	r9,r9,empty_zero_page@l
+	REST_32FPRS(0,r9)
+	sync
+	mtmsr	r10
+	isync
+	blr
+		
+	
 /* Definitions for the table use to save CPU states */
 #define CS_HID0		0
 #define CS_HID1		4
Index: linux-work/arch/ppc/platforms/pmac_sleep.S
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_sleep.S	2005-03-15 11:56:42.000000000 +1100
+++ linux-work/arch/ppc/platforms/pmac_sleep.S	2005-04-05 14:29:25.000000000 +1000
@@ -267,6 +267,10 @@
 	/* Restore various CPU config stuffs */
 	bl	__restore_cpu_setup
 
+	/* Make sure all FPRs have been initialized */
+	bl	reloc_offset
+	bl	__init_fpu_registers
+	
 	/* Invalidate & enable L1 cache, we don't care about
 	 * whatever the ROM may have tried to write to memory
 	 */
