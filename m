Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77B47DDDFD
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 01:08:21 +1100 (EST)
From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] powerpc: don't pass unused regs around in head_.*.S
Date: Sun, 12 Oct 2008 16:08:13 +0200
Message-Id: <1223820494-7822-2-git-send-email-sebastian@breakpoint.cc>
In-Reply-To: <1223820494-7822-1-git-send-email-sebastian@breakpoint.cc>
References: <1223820494-7822-1-git-send-email-sebastian@breakpoint.cc>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This looks like a relict from arch/ppc. machine_init() is accepting
only two parameters (dtb, phys) and is using only the first one.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/head_32.S        |    8 +-------
 arch/powerpc/kernel/head_40x.S       |   14 +-------------
 arch/powerpc/kernel/head_44x.S       |   14 +-------------
 arch/powerpc/kernel/head_8xx.S       |   14 +-------------
 arch/powerpc/kernel/head_fsl_booke.S |   14 +-------------
 5 files changed, 5 insertions(+), 59 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index a6de6db..2f5c4fc 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -89,11 +89,7 @@ _ENTRY(_start);
  * This is jumped to on prep systems right after the kernel is relocated
  * to its proper place in memory by the boot loader.  The expected layout
  * of the regs is:
- *   r3: ptr to residual data
- *   r4: initrd_start or if no initrd then 0
- *   r5: initrd_end - unused if r4 is 0
- *   r6: Start of command line string
- *   r7: End of command line string
+ *   r3 - Device tree pointer (DRAM, frequency, MAC address, etc.)
  *
  * This just gets a minimal mmu environment setup so we can call
  * start_here() to do the real work.
@@ -128,7 +124,6 @@ __start:
 #endif /* CONFIG_PPC_PMAC */
 
 1:	mr	r31,r3			/* save parameters */
-	mr	r30,r4
 	li	r24,0			/* cpu # */
 
 /*
@@ -1017,7 +1012,6 @@ start_here:
  * and set up the MMU.
  */
 	mr	r3,r31
-	mr	r4,r30
 	bl	machine_init
 	bl	__save_cpu_setup
 	bl	MMU_init
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 56d8e5d..1cdd4ce 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -44,11 +44,7 @@
  * execution begins here, the following registers contain valid, yet
  * optional, information:
  *
- *   r3 - Board info structure pointer (DRAM, frequency, MAC address, etc.)
- *   r4 - Starting address of the init RAM disk
- *   r5 - Ending address of the init RAM disk
- *   r6 - Start of kernel command line string (e.g. "mem=96m")
- *   r7 - End of kernel command line string
+ *   r3 - Device tree pointer (DRAM, frequency, MAC address, etc.)
  *
  * This is all going to change RSN when we add bi_recs.......  -- Dan
  */
@@ -59,10 +55,6 @@ _ENTRY(_start);
 	/* Save parameters we are passed.
 	*/
 	mr	r31,r3
-	mr	r30,r4
-	mr	r29,r5
-	mr	r28,r6
-	mr	r27,r7
 
 	/* We have to turn on the MMU right away so we get cache modes
 	 * set correctly.
@@ -848,10 +840,6 @@ start_here:
  * Decide what sort of machine this is and initialize the MMU.
  */
 	mr	r3,r31
-	mr	r4,r30
-	mr	r5,r29
-	mr	r6,r28
-	mr	r7,r27
 	bl	machine_init
 	bl	MMU_init
 
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index f3a1ea9..8098b59 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -43,11 +43,7 @@
  * execution begins here, the following registers contain valid, yet
  * optional, information:
  *
- *   r3 - Board info structure pointer (DRAM, frequency, MAC address, etc.)
- *   r4 - Starting address of the init RAM disk
- *   r5 - Ending address of the init RAM disk
- *   r6 - Start of kernel command line string (e.g. "mem=128")
- *   r7 - End of kernel command line string
+ *   r3 - Device tree pointer (DRAM, frequency, MAC address, etc.)
  *
  */
 	.section	.text.head, "ax"
@@ -62,10 +58,6 @@ _ENTRY(_start);
  * Save parameters we are passed
  */
 	mr	r31,r3
-	mr	r30,r4
-	mr	r29,r5
-	mr	r28,r6
-	mr	r27,r7
 	li	r24,0		/* CPU number */
 
 /*
@@ -241,10 +233,6 @@ skpinv:	addi	r4,r4,1				/* Increment */
  * Decide what sort of machine this is and initialize the MMU.
  */
 	mr	r3,r31
-	mr	r4,r30
-	mr	r5,r29
-	mr	r6,r28
-	mr	r7,r27
 	bl	machine_init
 	bl	MMU_init
 
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 3c9452d..a61d563 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -46,11 +46,7 @@ _ENTRY(_start);
  * This port was done on an MBX board with an 860.  Right now I only
  * support an ELF compressed (zImage) boot from EPPC-Bug because the
  * code there loads up some registers before calling us:
- *   r3: ptr to board info data
- *   r4: initrd_start or if no initrd then 0
- *   r5: initrd_end - unused if r4 is 0
- *   r6: Start of command line string
- *   r7: End of command line string
+ *   r3 - Device tree pointer (DRAM, frequency, MAC address, etc.)
  *
  * I decided to use conditional compilation instead of checking PVR and
  * adding more processor specific branches around code I don't need.
@@ -78,10 +74,6 @@ _ENTRY(_start);
 	.globl	__start
 __start:
 	mr	r31,r3			/* save parameters */
-	mr	r30,r4
-	mr	r29,r5
-	mr	r28,r6
-	mr	r27,r7
 
 	/* We have to turn on the MMU right away so we get cache modes
 	 * set correctly.
@@ -618,10 +610,6 @@ start_here:
  * Decide what sort of machine this is and initialize the MMU.
  */
 	mr	r3,r31
-	mr	r4,r30
-	mr	r5,r29
-	mr	r6,r28
-	mr	r7,r27
 	bl	machine_init
 	bl	MMU_init
 
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 18c0093..e42aa44 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -46,11 +46,7 @@
  * execution begins here, the following registers contain valid, yet
  * optional, information:
  *
- *   r3 - Board info structure pointer (DRAM, frequency, MAC address, etc.)
- *   r4 - Starting address of the init RAM disk
- *   r5 - Ending address of the init RAM disk
- *   r6 - Start of kernel command line string (e.g. "mem=128")
- *   r7 - End of kernel command line string
+ *   r3 - Device tree pointer (DRAM, frequency, MAC address, etc.)
  *
  */
 	.section	.text.head, "ax"
@@ -65,10 +61,6 @@ _ENTRY(_start);
  * Save parameters we are passed
  */
 	mr	r31,r3
-	mr	r30,r4
-	mr	r29,r5
-	mr	r28,r6
-	mr	r27,r7
 	li	r25,0		/* phys kernel start (low) */
 	li	r24,0		/* CPU number */
 	li	r23,0		/* phys kernel start (high) */
@@ -383,10 +375,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
  * Decide what sort of machine this is and initialize the MMU.
  */
 	mr	r3,r31
-	mr	r4,r30
-	mr	r5,r29
-	mr	r6,r28
-	mr	r7,r27
 	bl	machine_init
 	bl	MMU_init
 
-- 
1.5.6.5
