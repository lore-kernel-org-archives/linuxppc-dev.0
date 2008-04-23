Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 9E45FDDF5E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 14:06:15 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>, <linuxppc-dev@ozlabs.org>
Message-Id: <c502b5a12340208adaf15ce4492db8d1bc864315.1208923391.git.tony@bakeyournoodle.com>
In-Reply-To: <d54206d25b690c9160401f65a583f586004dcd5d.1208923391.git.tony@bakeyournoodle.com>
References: <d54206d25b690c9160401f65a583f586004dcd5d.1208923391.git.tony@bakeyournoodle.com>
From: Tony Breeds <tony@bakeyournoodle.com>
Subject: [PATCH 2/3 v3] Make iSeries spin on __secondary_hold_spinloop,
	like pSeries.
Date: Wed, 23 Apr 2008 14:06:14 +1000 (EST)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently all iSeries secondary CPU's spin directly on the cpu_start in thier
paca.  Make them spin on the global __secondary_hold_spinloop, until after the
pacas have been initialised.

As sfr points out this works because __secondary_hold_spinloop is being set
already, but iSeries isn't looking at it :)

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
Changes since v1:
 - Updated commit message.
Changes since v2:
 - Fixed my brain damage, and split out the code that should be in 3/3

 arch/powerpc/platforms/iseries/exception.S |   27 ++++++++++++++++++++++++++-
 1 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/iseries/exception.S b/arch/powerpc/platforms/iseries/exception.S
index c775cd4..8ff330d 100644
--- a/arch/powerpc/platforms/iseries/exception.S
+++ b/arch/powerpc/platforms/iseries/exception.S
@@ -59,8 +59,33 @@ system_reset_iSeries:
 	andc	r4,r4,r5
 	mtspr	SPRN_CTRLT,r4
 
+/* Spin on __secondary_hold_spinloop until it is updated by the boot cpu. */
+/* In the UP case we'll yeild() later, and we will not access the paca anyway */
+#ifdef CONFIG_SMP
 1:
 	HMT_LOW
+	LOAD_REG_IMMEDIATE(r23, __secondary_hold_spinloop)
+	ld	r23,0(r23)
+	sync
+	LOAD_REG_IMMEDIATE(r3,current_set)
+	sldi	r28,r24,3		/* get current_set[cpu#] */
+	ldx	r3,r3,r28
+	addi	r1,r3,THREAD_SIZE
+	subi	r1,r1,STACK_FRAME_OVERHEAD
+
+	cmpwi	0,r23,0			/* Keep poking the Hypervisor until */
+	bne	2f			/* we're released */
+	/* Let the Hypervisor know we are alive */
+	/* 8002 is a call to HvCallCfg::getLps, a harmless Hypervisor function */
+	lis	r3,0x8002
+	rldicr	r3,r3,32,15		/* r0 = (r3 << 32) & 0xffff000000000000 */
+	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
+	sc				/* Invoke the hypervisor via a system call */
+	b	1b
+#endif
+
+2:
+	HMT_LOW
 #ifdef CONFIG_SMP
 	lbz	r23,PACAPROCSTART(r13)	/* Test if this processor
 					 * should start */
@@ -91,7 +116,7 @@ iSeries_secondary_smp_loop:
 	li	r0,-1			/* r0=-1 indicates a Hypervisor call */
 	sc				/* Invoke the hypervisor via a system call */
 	mfspr	r13,SPRN_SPRG3		/* Put r13 back ???? */
-	b	1b			/* If SMP not configured, secondaries
+	b	2b			/* If SMP not configured, secondaries
 					 * loop forever */
 
 /***  ISeries-LPAR interrupt handlers ***/
-- 
1.5.5.1
