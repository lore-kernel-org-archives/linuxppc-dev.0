Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1B0D0B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Jul 2011 07:29:44 +1000 (EST)
Date: Mon, 25 Jul 2011 16:29:33 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH] powerpc/32: pass device tree address as u64 to machine_init
Message-ID: <20110725212933.GA3835@schlenkerla.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

u64 is used rather than phys_addr_t to keep things simple, as
this is called from assembly code.

Update callers to pass a 64-bit address in r3/r4.  Other unused
register assignments that were once parameters to machine_init
are dropped.

For FSL BookE, look up the physical address of the device tree from the
effective address passed in r3 by the loader.  This is required for
situations where memory does not start at zero (due to AMP or IOMMU-less
virtualization), and thus the IMA doesn't start at zero, and thus the
device tree effective address does not equal the physical address.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
Tested on fsl booke and 83xx.

 arch/powerpc/kernel/head_32.S        |    7 ++---
 arch/powerpc/kernel/head_40x.S       |   15 ++---------
 arch/powerpc/kernel/head_44x.S       |   16 ++----------
 arch/powerpc/kernel/head_8xx.S       |   13 ++--------
 arch/powerpc/kernel/head_fsl_booke.S |   42 +++++++++++++++++++++-------------
 arch/powerpc/kernel/setup_32.c       |    2 +-
 6 files changed, 39 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index ba250d5..0654dba 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -139,8 +139,7 @@ __start:
 	trap
 #endif /* CONFIG_PPC_PMAC */
 
-1:	mr	r31,r3			/* save parameters */
-	mr	r30,r4
+1:	mr	r31,r3			/* save device tree ptr */
 	li	r24,0			/* cpu # */
 
 /*
@@ -964,8 +963,8 @@ start_here:
  * Do early platform-specific initialization,
  * and set up the MMU.
  */
-	mr	r3,r31
-	mr	r4,r30
+	li	r3,0
+	mr	r4,r31
 	bl	machine_init
 	bl	__save_cpu_setup
 	bl	MMU_init
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index a91626d..872a6af 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -58,13 +58,7 @@
 _ENTRY(_stext);
 _ENTRY(_start);
 
-	/* Save parameters we are passed.
-	*/
-	mr	r31,r3
-	mr	r30,r4
-	mr	r29,r5
-	mr	r28,r6
-	mr	r27,r7
+	mr	r31,r3			/* save device tree ptr */
 
 	/* We have to turn on the MMU right away so we get cache modes
 	 * set correctly.
@@ -849,11 +843,8 @@ start_here:
 /*
  * Decide what sort of machine this is and initialize the MMU.
  */
-	mr	r3,r31
-	mr	r4,r30
-	mr	r5,r29
-	mr	r6,r28
-	mr	r7,r27
+	li	r3,0
+	mr	r4,r31
 	bl	machine_init
 	bl	MMU_init
 
diff --git a/arch/powerpc/kernel/head_44x.S b/arch/powerpc/kernel/head_44x.S
index f8e971b..b725dab 100644
--- a/arch/powerpc/kernel/head_44x.S
+++ b/arch/powerpc/kernel/head_44x.S
@@ -61,14 +61,7 @@ _ENTRY(_start);
 	 * of abatron_pteptrs
 	 */
 	nop
-/*
- * Save parameters we are passed
- */
-	mr	r31,r3
-	mr	r30,r4
-	mr	r29,r5
-	mr	r28,r6
-	mr	r27,r7
+	mr	r31,r3		/* save device tree ptr */
 	li	r24,0		/* CPU number */
 
 	bl	init_cpu_state
@@ -120,11 +113,8 @@ _ENTRY(_start);
 /*
  * Decide what sort of machine this is and initialize the MMU.
  */
-	mr	r3,r31
-	mr	r4,r30
-	mr	r5,r29
-	mr	r6,r28
-	mr	r7,r27
+	li	r3,0
+	mr	r4,r31
 	bl	machine_init
 	bl	MMU_init
 
diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 1cbf64e..b68cb17 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -76,11 +76,7 @@ _ENTRY(_start);
  */
 	.globl	__start
 __start:
-	mr	r31,r3			/* save parameters */
-	mr	r30,r4
-	mr	r29,r5
-	mr	r28,r6
-	mr	r27,r7
+	mr	r31,r3			/* save device tree ptr */
 
 	/* We have to turn on the MMU right away so we get cache modes
 	 * set correctly.
@@ -723,11 +719,8 @@ start_here:
 /*
  * Decide what sort of machine this is and initialize the MMU.
  */
-	mr	r3,r31
-	mr	r4,r30
-	mr	r5,r29
-	mr	r6,r28
-	mr	r7,r27
+	li	r3,0
+	mr	r4,r31
 	bl	machine_init
 	bl	MMU_init
 
diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 985638d..c86f0eb 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -63,17 +63,30 @@ _ENTRY(_start);
 	 * of abatron_pteptrs
 	 */
 	nop
-/*
- * Save parameters we are passed
- */
-	mr	r31,r3
-	mr	r30,r4
-	mr	r29,r5
-	mr	r28,r6
-	mr	r27,r7
-	li	r25,0		/* phys kernel start (low) */
-	li	r24,0		/* CPU number */
-	li	r23,0		/* phys kernel start (high) */
+
+	/* Translate device tree address to physical, save in r30/r31 */
+	mfmsr	r16
+	mfspr	r17,SPRN_PID
+	rlwinm	r17,r17,16,0x3fff0000	/* turn PID into MAS6[SPID] */
+	rlwimi	r17,r16,28,0x00000001	/* turn MSR[DS] into MAS6[SAS] */
+	mtspr	SPRN_MAS6,r17
+
+	tlbsx	0,r3			/* must succeed */
+
+	mfspr	r16,SPRN_MAS1
+	mfspr	r20,SPRN_MAS3
+	rlwinm	r17,r16,25,0x1f		/* r17 = log2(page size) */
+	li	r18,1024
+	slw	r18,r18,r17		/* r18 = page size */
+	addi	r18,r18,-1
+	and	r19,r3,r18		/* r19 = page offset */
+	andc	r31,r20,r18		/* r3 = page base */
+	or	r31,r31,r19		/* r3 = devtree phys addr */
+	mfspr	r30,SPRN_MAS7
+
+	li	r25,0			/* phys kernel start (low) */
+	li	r24,0			/* CPU number */
+	li	r23,0			/* phys kernel start (high) */
 
 /* We try to not make any assumptions about how the boot loader
  * setup or used the TLBs.  We invalidate all mappings from the
@@ -198,11 +211,8 @@ _ENTRY(__early_start)
 /*
  * Decide what sort of machine this is and initialize the MMU.
  */
-	mr	r3,r31
-	mr	r4,r30
-	mr	r5,r29
-	mr	r6,r28
-	mr	r7,r27
+	mr	r3,r30
+	mr	r4,r31
 	bl	machine_init
 	bl	MMU_init
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 209135a..c1ce863 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -117,7 +117,7 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
  * This is called very early on the boot process, after a minimal
  * MMU environment has been set up but before MMU_init is called.
  */
-notrace void __init machine_init(unsigned long dt_ptr)
+notrace void __init machine_init(u64 dt_ptr)
 {
 	lockdep_init();
 
-- 
1.7.4.1
