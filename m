Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A96E92BF16
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Jan 2005 23:06:24 +1100 (EST)
Date: Sun, 9 Jan 2005 12:57:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Sven Luther <sven.luther@wanadoo.fr>, benh@kernel.crashing.org
Message-ID: <20050109115720.GA19213@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
Subject: status of the G4 l2 cache flush and MSR errate patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sven & Ben,

what's the status of the patch below (forward-port to 2.6.10 by me)?



#! /bin/sh -e 
##
## All lines beginning with `## DP:' are a description of the patch.
## DP: Description: Fixes g4 l2 cache flush and MSR erratas.
## DP: Patch author: Sven Luther <luther@debian.org>
## DP: Upstream status: under review by benh.

. $(dirname $0)/DPATCH

@DPATCH@
--- 1.31/arch/ppc/kernel/cputable.c	2004-11-11 09:25:53 +01:00
+++ edited/arch/ppc/kernel/cputable.c	2005-01-02 12:53:10 +01:00
@@ -380,7 +380,7 @@ struct cpu_spec	cpu_specs[] = {
 			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 			CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
-			CPU_FTR_NEED_COHERENT,
+			CPU_FTR_NEED_COHERENT | CPU_FTR_HWFLUSH_L2_CACHE,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -397,7 +397,7 @@ struct cpu_spec	cpu_specs[] = {
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP |
-			CPU_FTR_NEED_COHERENT,
+			CPU_FTR_NEED_COHERENT | CPU_FTR_HWFLUSH_L2_CACHE,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -413,7 +413,8 @@ struct cpu_spec	cpu_specs[] = {
 			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
-			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_NEED_COHERENT,
+			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_NEED_COHERENT |
+			CPU_FTR_HWFLUSH_L2_CACHE,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -428,7 +429,8 @@ struct cpu_spec	cpu_specs[] = {
 			CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB |
 			CPU_FTR_L2CR | CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
-			CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
+			CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT |
+			CPU_FTR_HWFLUSH_L2_CACHE,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -445,7 +447,8 @@ struct cpu_spec	cpu_specs[] = {
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_L3_DISABLE_NAP |
-			CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS,
+			CPU_FTR_NEED_COHERENT | CPU_FTR_HAS_HIGH_BATS |
+			CPU_FTR_HWFLUSH_L2_CACHE,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -462,7 +465,7 @@ struct cpu_spec	cpu_specs[] = {
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
-			CPU_FTR_NEED_COHERENT,
+			CPU_FTR_NEED_COHERENT | CPU_FTR_HWFLUSH_L2_CACHE,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -479,7 +482,8 @@ struct cpu_spec	cpu_specs[] = {
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
-			CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
+			CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC |
+			CPU_FTR_HWFLUSH_L2_CACHE,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -496,7 +500,8 @@ struct cpu_spec	cpu_specs[] = {
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
-			CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC,
+			CPU_FTR_NEED_COHERENT | CPU_FTR_NO_BTIC |
+			CPU_FTR_HWFLUSH_L2_CACHE,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -513,7 +518,7 @@ struct cpu_spec	cpu_specs[] = {
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_L3CR |
 			CPU_FTR_HPTE_TABLE | CPU_FTR_SPEC7450 |
 			CPU_FTR_NAP_DISABLE_L2_PR | CPU_FTR_HAS_HIGH_BATS |
-			CPU_FTR_NEED_COHERENT,
+			CPU_FTR_NEED_COHERENT | CPU_FTR_HWFLUSH_L2_CACHE,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
@@ -529,7 +534,8 @@ struct cpu_spec	cpu_specs[] = {
 			CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_L2CR |
 			CPU_FTR_ALTIVEC_COMP | CPU_FTR_HPTE_TABLE |
 			CPU_FTR_SPEC7450 | CPU_FTR_NAP_DISABLE_L2_PR |
-			CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT,
+			CPU_FTR_HAS_HIGH_BATS | CPU_FTR_NEED_COHERENT |
+			CPU_FTR_HWFLUSH_L2_CACHE,
 		.cpu_user_features	= COMMON_PPC | PPC_FEATURE_ALTIVEC_COMP,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
--- 1.11/arch/ppc/kernel/l2cr.S	2004-02-21 02:30:29 +01:00
+++ edited/arch/ppc/kernel/l2cr.S	2005-01-02 12:55:28 +01:00
@@ -19,7 +19,7 @@
 /*
 	Thur, Dec. 12, 1998.
 	- First public release, contributed by PowerLogix.
-	***********
+
 	Sat, Aug. 7, 1999.
 	- Terry: Made sure code disabled interrupts before running. (Previously
 			it was assumed interrupts were already disabled).
@@ -27,16 +27,19 @@
 			instead of 2MB.  (Prob. only 3 is necessary).
 	- Terry: Updated for workaround to HID0[DPM] processor bug
 			during global invalidates.
-	***********
+
 	Thu, July 13, 2000.
 	- Terry: Added isync to correct for an errata.
 
-	22 August 2001.
+	We, August 22, 2001.
 	- DanM: Finally added the 7450 patch I've had for the past
 		several months.  The L2CR is similar, but I'm going
 		to assume the user of this functions knows what they
 		are doing.
 
+	Thu, June 17, 2004.
+	- JPAN: Fixed 745X L3 cache enablement routine, also use HW flush assist.
+	
 	Author:	Terry Greeniaus (tgree@phys.ualberta.ca)
 	Please e-mail updates to this file to me, thanks!
 */
@@ -154,9 +157,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	       Don't do this unless you accomodate all processor variations.
 	       The bit moved on the 7450.....
 	  ****/
-
-	/* TODO: use HW flush assist when available */
-
+BEGIN_FTR_SECTION
 	lis	r4,0x0002
 	mtctr	r4
 	li	r4,0
@@ -175,7 +176,23 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	dcbf	0,r4
 	addi	r4,r4,32		/* Go to start of next cache line */
 	bdnz	1b
+END_FTR_SECTION_IFCLR(CPU_FTR_HWFLUSH_L2_CACHE)
 
+BEGIN_FTR_SECTION
+	/* Use HW flush assist, MPC7447A errata #3 */
+	oris	r4,r4,0x0010	/* Set L2CR[IONLY/11] = 1 */
+	oris	r4,r4,0x0001	/* Set L2CR[DONLY/15] = 1 */
+	mtspr   L2CR,r4		/* Lock the L2	*/
+	sync
+	ori	r4,r4,0x0800	/* Set L2CR[L2HWF/20] = 1 */
+	mtspr   L2CR,r4		/* Flush the L2 */
+1:	
+	mfspr	r4,L2CR
+	andi.	r4,r4,0x0800	/* L2HWF still set? */
+	bne	1b
+	sync	/* sync to clear the store queues before L3 flush (UM step 5)*/
+END_FTR_SECTION_IFSET(CPU_FTR_HWFLUSH_L2_CACHE)
+	
 2:
 	/* Set up the L2CR configuration bits (and switch L2 off) */
 	/* CPU errata: Make sure the mtspr below is already in the
@@ -292,17 +309,18 @@ END_FTR_SECTION_IFCLR(CPU_FTR_L3CR)
 
 	/* Flush the cache.
 	 */
-
-	/* TODO: use HW flush assist */
-
-	lis	r4,0x0008
-	mtctr	r4
-	li	r4,0
-1:
-	lwzx	r0,r0,r4
-	dcbf	0,r4
-	addi	r4,r4,32		/* Go to start of next cache line */
-	bdnz	1b
+	/* use HW flush assist. (UM 3.6.3.1.5) */
+	mfspr	r4, SPRN_L3CR
+	oris	r4,r4,0x0040	/* Set L3CR[L3IO/9] = 1. */
+	ori	r4,r4,0x0040	/* Set L3CR[L3DO/29] = 1.*/
+	mtspr	1018,r4		/* Lock the L3 by making IONLY and DONLY */
+	ori	r4,r4,0x0800	/* Set L3CR[L3HWF/20] for hardware flush */
+	mtspr	SPRN_L3CR,r4
+flush_745x_L3_poll:
+	mfspr	r4,SPRN_L3CR
+	rlwinm.	r4,r4,0,20,20
+	bne	flush_745x_L3_poll
+	sync	/* Clear the store queues per procedure (UM step 8) */
 
 2:
 	/* Set up the L3CR configuration bits (and switch L3 off) */
@@ -348,8 +366,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_L3CR)
 	cmplwi	r5,0
 	beq	4f
 
-	/* Enable the cache */
-	oris	r3,r3,(L3CR_L3E | L3CR_L3CLKEN)@h
+	/* enable L3 clock */
+	oris	r3,r3,(L3CR_L3CLKEN)@h
 	mtspr	SPRN_L3CR,r3
 	sync
 
@@ -357,6 +375,15 @@ END_FTR_SECTION_IFCLR(CPU_FTR_L3CR)
 	li	r0,256
 	mtctr	r0
 1:	bdnz	1b
+	
+	/* Clear MSSSR0 which may cause parity error */
+	xor	r5,r5,r5
+	mtspr	1015, r5
+	
+	/* Enable L3 cache */
+	oris	r3,r3,(L3CR_L3E)@h
+	mtspr	SPRN_L3CR,r3
+	sync
 
 	/* Restore MSR (restores EE and DR bits to original state) */
 4:	SYNC
--- 1.36/arch/ppc/kernel/traps.c	2004-11-02 15:40:33 +01:00
+++ edited/arch/ppc/kernel/traps.c	2005-01-02 12:53:46 +01:00
@@ -298,7 +298,9 @@ void MachineCheckException(struct pt_reg
 	case 0x80000:
 		printk("Machine check signal\n");
 		break;
-	case 0:		/* for 601 */
+	case 0:		/* for 601 and 744x */
+		printk("Transfer error ack signal if 601, or MCP if 744x \n");
+		break;
 	case 0x40000:
 	case 0x140000:	/* 7450 MSS error and TEA */
 		printk("Transfer error ack signal\n");
--- 1.10/include/asm-ppc/cputable.h	2004-11-11 09:25:52 +01:00
+++ edited/include/asm-ppc/cputable.h	2005-01-02 12:53:46 +01:00
@@ -83,6 +83,7 @@ extern struct cpu_spec		*cur_cpu_spec[];
 #define CPU_FTR_HAS_HIGH_BATS		0x00010000
 #define CPU_FTR_NEED_COHERENT           0x00020000
 #define CPU_FTR_NO_BTIC			0x00040000
+#define CPU_FTR_HWFLUSH_L2_CACHE	0x00080000
 
 #ifdef __ASSEMBLY__
 
