Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0139D67A64
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 10:53:19 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 05 Apr 2005 10:49:56 +1000
Message-Id: <1112662196.19004.122.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] ppc32: Fix errata for some G3 CPUs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

Some G3 CPUs can crash in funny way if a store from an FPU register
instruction is executed on a register that has never been initialized
since power on. This patch fixes it by making sure all FP registers have
been properly initialized at kernel boot and when waking from sleep.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/kernel/cpu_setup_6xx.S
===================================================================
--- linux-work.orig/arch/ppc/kernel/cpu_setup_6xx.S	2005-03-15 11:56:39.000000000 +1100
+++ linux-work/arch/ppc/kernel/cpu_setup_6xx.S	2005-04-04 16:33:52.000000000 +1000
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
@@ -51,6 +54,7 @@
 _GLOBAL(__setup_cpu_7400)
 	mflr	r4
 	bl	setup_7400_workarounds
+	bl	__init_fpu_registers
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
 	mtlr	r4
@@ -58,6 +62,7 @@
 _GLOBAL(__setup_cpu_7410)
 	mflr	r4
 	bl	setup_7410_workarounds
+	bl	__init_fpu_registers
 	bl	setup_common_caches
 	bl	setup_750_7400_hid0
 	li	r3,0
@@ -248,6 +253,25 @@
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
+++ linux-work/arch/ppc/platforms/pmac_sleep.S	2005-04-05 10:35:06.000000000 +1000
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
