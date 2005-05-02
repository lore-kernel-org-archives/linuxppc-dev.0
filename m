Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0ACC767A70
	for <linuxppc-dev@ozlabs.org>; Mon,  2 May 2005 11:09:07 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 02 May 2005 11:07:08 +1000
Message-Id: <1114996028.7112.358.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: Workaround a cache flush issue on sleep
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

We are experiencing a problem when flushing the CPU caches before sleep
on some laptop models using the 750FX CPU rev 1.X. While I haven't been
able to figure out a proper explanation for what's going on, I do have a
workaround that seem to work reliably and allows those machine to sleep
and wakeup properly again. This should be applied for 2.6.12. I'll
re-update that code if/when I ever find exactly what is happening with
those CPU revisions.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/platforms/pmac_cache.S
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_cache.S	2005-04-24 11:37:38.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_cache.S	2005-04-24 12:00:46.000000000 +1000
@@ -64,27 +64,39 @@
 	mtspr	SPRN_HID0,r4		/* Disable DPM */
 	sync
 
-	/* disp-flush L1 */
-	li	r4,0x4000
-	mtctr	r4
+	/* Disp-flush L1. We have a weird problem here that I never
+	 * totally figured out. On 750FX, using the ROM for the flush
+	 * results in a non-working flush. We use that workaround for
+	 * now until I finally understand what's going on. --BenH
+	 */
+
+	/* ROM base by default */
 	lis	r4,0xfff0
-1:	lwzx	r0,r0,r4
+	mfpvr	r3
+	srwi	r3,r3,16
+	cmplwi	cr0,r3,0x7000
+	bne+	1f
+	/* RAM base on 750FX */
+	li	r4,0
+1:	li	r4,0x4000
+	mtctr	r4
+1:	lwz	r0,0(r4)
 	addi	r4,r4,32
 	bdnz	1b
 	sync
 	isync
 
-	/* disable / invalidate / enable L1 data */
+	/* Disable / invalidate / enable L1 data */
 	mfspr	r3,SPRN_HID0
-	rlwinm	r0,r0,0,~HID0_DCE
+	rlwinm	r3,r3,0,~(HID0_DCE | HID0_ICE)
 	mtspr	SPRN_HID0,r3
 	sync
 	isync
-	ori	r3,r3,HID0_DCE|HID0_DCI
+	ori	r3,r3,(HID0_DCE|HID0_DCI|HID0_ICE|HID0_ICFI)
 	sync
 	isync
 	mtspr	SPRN_HID0,r3
-	xori	r3,r3,HID0_DCI
+	xori	r3,r3,(HID0_DCI|HID0_ICFI)
 	mtspr	SPRN_HID0,r3
 	sync
 
@@ -110,11 +122,20 @@
 	lis	r4,2
 	mtctr	r4
 	lis	r4,0xfff0
-1:	lwzx	r0,r0,r4
+1:	lwz	r0,0(r4)
+	addi	r4,r4,32
+	bdnz	1b
+	sync
+	isync
+	lis	r4,2
+	mtctr	r4
+	lis	r4,0xfff0
+1:	dcbf	0,r4
 	addi	r4,r4,32
 	bdnz	1b
 	sync
 	isync
+
 	/* now disable L2 */
 	rlwinm	r5,r5,0,~L2CR_L2E
 	b	2f
@@ -135,6 +156,13 @@
 	mtspr	SPRN_L2CR,r4
 	sync
 	isync
+
+	/* Wait for the invalidation to complete */
+1:	mfspr	r3,SPRN_L2CR
+	rlwinm.	r0,r3,0,31,31
+	bne	1b
+
+	/* Clear L2I */
 	xoris	r4,r4,L2CR_L2I@h
 	sync
 	mtspr	SPRN_L2CR,r4
@@ -142,16 +170,18 @@
 
 	/* now disable the L1 data cache */
 	mfspr	r0,SPRN_HID0
-	rlwinm	r0,r0,0,~HID0_DCE
+	rlwinm	r0,r0,0,~(HID0_DCE|HID0_ICE)
 	mtspr	SPRN_HID0,r0
 	sync
 	isync
 
 	/* Restore HID0[DPM] to whatever it was before */
 	sync
-	mtspr	SPRN_HID0,r8
+	mfspr	r0,SPRN_HID0
+	rlwimi	r0,r8,0,11,11		/* Turn back HID0[DPM] */
+	mtspr	SPRN_HID0,r0
 	sync
-
+
 	/* restore DR and EE */
 	sync
 	mtmsr	r11
@@ -201,7 +231,7 @@
         mtctr   r4
  	li      r4,0
 1:
-        lwzx    r0,r0,r4
+        lwz     r0,0(r4)
         addi    r4,r4,32                /* Go to start of next cache line */
         bdnz    1b
         isync
