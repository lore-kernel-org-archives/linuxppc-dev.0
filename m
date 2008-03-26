Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6D53CDDF52
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 03:11:43 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m2QGBcUt022412
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 11:11:39 -0500
Date: Wed, 26 Mar 2008 11:07:53 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx: Cleanup TLB initialization
Message-ID: <Pine.LNX.4.64.0803261107300.29754@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Determine the RPN we are running the kernel at runtime rather
  than using compile time constant for initial TLB

* Cleanup adjust_total_lowmem() to respect memstart_addr and
  be a bit more clear on variables that are sizes vs addresses.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/head_fsl_booke.S |   34 ++++++++++++++++++++++++------
 arch/powerpc/mm/fsl_booke_mmu.c      |   37 ++++++++++++++-------------------
 2 files changed, 43 insertions(+), 28 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index d9cc2c2..3b69b54 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -68,7 +68,9 @@ _ENTRY(_start);
 	mr	r29,r5
 	mr	r28,r6
 	mr	r27,r7
+	li	r25,0		/* phys kernel start (low) */
 	li	r24,0		/* CPU number */
+	li	r23,0		/* phys kernel start (high) */

 /* We try to not make any assumptions about how the boot loader
  * setup or used the TLBs.  We invalidate all mappings from the
@@ -167,7 +169,28 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	mtspr	SPRN_MAS0,r7
 	tlbre

-	/* Just modify the entry ID, EPN and RPN for the temp mapping */
+	/* grab and fixup the RPN */
+	mfspr	r6,SPRN_MAS1	/* extract MAS1[SIZE] */
+	rlwinm	r6,r6,25,27,30
+	li	r8,-1
+	addi	r6,r6,10
+	slw	r6,r8,r6	/* convert to mask */
+
+	bl	1f		/* Find our address */
+1:	mflr	r7
+
+	mfspr	r8,SPRN_MAS3
+#ifdef CONFIG_PHYS_64BIT
+	mfspr	r23,SPRN_MAS7
+#endif
+	and	r8,r6,r8
+	subfic	r9,r6,-4096
+	and	r9,r9,r7
+
+	or	r25,r8,r9
+	ori	r8,r25,(MAS3_SX|MAS3_SW|MAS3_SR)
+
+	/* Just modify the entry ID and EPN for the temp mapping */
 	lis	r7,0x1000	/* Set MAS0(TLBSEL) = 1 */
 	rlwimi	r7,r5,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r5) */
 	mtspr	SPRN_MAS0,r7
@@ -177,12 +200,10 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	ori	r6,r6,(MAS1_TSIZE(BOOKE_PAGESZ_4K))@l
 	mtspr	SPRN_MAS1,r6
 	mfspr	r6,SPRN_MAS2
-	lis	r7,PHYSICAL_START@h
+	li	r7,0		/* temp EPN = 0 */
 	rlwimi	r7,r6,0,20,31
 	mtspr	SPRN_MAS2,r7
-	mfspr	r6,SPRN_MAS3
-	rlwimi	r7,r6,0,20,31
-	mtspr	SPRN_MAS3,r7
+	mtspr	SPRN_MAS3,r8
 	tlbwe

 	xori	r6,r4,1
@@ -232,8 +253,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	ori	r6,r6,PAGE_OFFSET@l
 	rlwimi	r6,r7,0,20,31
 	mtspr	SPRN_MAS2,r6
-	li	r7,(MAS3_SX|MAS3_SW|MAS3_SR)
-	mtspr	SPRN_MAS3,r7
+ 	mtspr	SPRN_MAS3,r8
 	tlbwe

 /* 7. Jump to KERNELBASE mapping */
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 3dd0c81..59f6649 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -49,7 +49,6 @@
 #include <asm/mmu.h>
 #include <asm/uaccess.h>
 #include <asm/smp.h>
-#include <asm/bootx.h>
 #include <asm/machdep.h>
 #include <asm/setup.h>

@@ -59,7 +58,6 @@ extern void loadcam_entry(unsigned int index);
 unsigned int tlbcam_index;
 unsigned int num_tlbcam_entries;
 static unsigned long __cam0, __cam1, __cam2;
-#define MAX_LOW_MEM	CONFIG_LOWMEM_SIZE

 #define NUM_TLBCAMS	(16)

@@ -195,35 +193,32 @@ unsigned long __init mmu_mapin_ram(void)
 void __init
 adjust_total_lowmem(void)
 {
-	unsigned long max_low_mem = MAX_LOW_MEM;
-	unsigned long cam_max = 0x10000000;
-	unsigned long ram;
+	phys_addr_t max_lowmem_size = __max_low_memory;
+	phys_addr_t cam_max_size = 0x10000000;
+	phys_addr_t ram;

-	/* adjust CAM size to max_low_mem */
-	if (max_low_mem < cam_max)
-		cam_max = max_low_mem;
+	/* adjust CAM size to max_lowmem_size */
+	if (max_lowmem_size < cam_max_size)
+		cam_max_size = max_lowmem_size;

-	/* adjust lowmem size to max_low_mem */
-	if (max_low_mem < total_lowmem)
-		ram = max_low_mem;
-	else
-		ram = total_lowmem;
+	/* adjust lowmem size to max_lowmem_size */
+	ram = min(max_lowmem_size, total_lowmem);

 	/* Calculate CAM values */
 	__cam0 = 1UL << 2 * (__ilog2(ram) / 2);
-	if (__cam0 > cam_max)
-		__cam0 = cam_max;
+	if (__cam0 > cam_max_size)
+		__cam0 = cam_max_size;
 	ram -= __cam0;
 	if (ram) {
 		__cam1 = 1UL << 2 * (__ilog2(ram) / 2);
-		if (__cam1 > cam_max)
-			__cam1 = cam_max;
+		if (__cam1 > cam_max_size)
+			__cam1 = cam_max_size;
 		ram -= __cam1;
 	}
 	if (ram) {
 		__cam2 = 1UL << 2 * (__ilog2(ram) / 2);
-		if (__cam2 > cam_max)
-			__cam2 = cam_max;
+		if (__cam2 > cam_max_size)
+			__cam2 = cam_max_size;
 		ram -= __cam2;
 	}

@@ -231,6 +226,6 @@ adjust_total_lowmem(void)
 			" CAM2=%ldMb residual: %ldMb\n",
 			__cam0 >> 20, __cam1 >> 20, __cam2 >> 20,
 			(total_lowmem - __cam0 - __cam1 - __cam2) >> 20);
-	__max_low_memory = max_low_mem = __cam0 + __cam1 + __cam2;
-	__initial_memory_limit = __max_low_memory;
+	__max_low_memory = __cam0 + __cam1 + __cam2;
+	__initial_memory_limit = memstart_addr + __max_low_memory;
 }
-- 
1.5.4.1
