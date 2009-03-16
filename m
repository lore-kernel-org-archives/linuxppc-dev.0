Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id C0D6BDDF31
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 01:21:07 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC][PATCH v4] MPC5121 TLB errata workaround
Date: Mon, 16 Mar 2009 15:21:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200903161521.04979.david.jander@protonic.nl>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Wolfgang Denk <wd@denx.de>, Gunnar Von Boehn <gunnar@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Complete workaround for DTLB errata in MPC5121e processors of die M36P and 
older (all currently existing versions).

Due to the bug, the hardware-implemented LRU algorythm always goes to way 1 of 
the TLB. This fix implements the proposed software workaround in form of a LRW 
table encoded in 32 bits of SPRG6 for chosing the TLB-way.

Signed-off-by: David Jander <david@protonic.nl>

---
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 0f4fac5..6cc0cd3 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -540,9 +540,13 @@ DataLoadTLBMiss:
  * r2:	ptr to linux-style pte
  * r3:	scratch
  */
+	mfspr	r3,SPRN_DMISS
+#ifdef CONFIG_PPC_MPC512x
+	b      e300_read_tlb_fix    /* Code for TLB-errata workaround doesn't fit 
here */
+e300_read_tlb_fix_ret:
+#endif
 	mfctr	r0
 	/* Get PTE (linux-style) and check access */
-	mfspr	r3,SPRN_DMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2,SPRN_SPRG3
@@ -612,9 +616,32 @@ DataStoreTLBMiss:
  * r2:	ptr to linux-style pte
  * r3:	scratch
  */
+	mfspr	r3,SPRN_DMISS
+#ifdef CONFIG_PPC_MPC512x
+/* MPC512x: workaround for errata in die M36P and earlier:
+ * Implement LRW for TLB way.
+ */
+ 	rlwinm  r0,r3,17,27,31 /* Get Address bits 19:15 */
+	li      r1,1
+	slw     r0,r1,r0       /* Make bitmask */
+	mfspr   r2,SPRN_SPRG6  /* Get lrw table */
+	and.    r1,r2,r0       /* Check entry in lrw */
+	beq-    0,113f         /* 0? Then goto 113: */
+	
+	mfspr	r1,SPRN_SRR1
+	rlwinm  r1,r1,0,15,13  /* Mask out SRR1[WAY] */
+	mtspr   SPRN_SRR1,r1
+	
+	andc    r2,r2,r0
+	mtspr   SPRN_SPRG6,r2
+	b       114f
+113:
+	or      r2,r2,r0
+	mtspr   SPRN_SPRG6,r2
+114:
+#endif
 	mfctr	r0
 	/* Get PTE (linux-style) and check access */
-	mfspr	r3,SPRN_DMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
 	cmplw	0,r1,r3
 	mfspr	r2,SPRN_SPRG3
@@ -688,6 +715,29 @@ DataStoreTLBMiss:
 	.globl mol_trampoline
 	.set mol_trampoline, i0x2f00
 
+#ifdef CONFIG_PPC_MPC512x
+e300_read_tlb_fix:
+ 	rlwinm  r0,r3,17,27,31 /* Get Address bits 19:15 */
+	li      r1,1
+	slw     r0,r1,r0       /* Make bitmask */
+	mfspr   r2,SPRN_SPRG6  /* Get lrw table */
+	and.    r1,r2,r0       /* Check entry in lrw */
+	beq-    0,113f         /* 0? Then goto 113: */
+	
+	mfspr	r1,SPRN_SRR1
+	rlwinm  r1,r1,0,15,13  /* Mask out SRR1[WAY] */
+	mtspr   SPRN_SRR1,r1
+	
+	andc    r2,r2,r0
+	mtspr   SPRN_SPRG6,r2
+	b       114f
+113:
+	or      r2,r2,r0
+	mtspr   SPRN_SPRG6,r2
+114:
+	b       e300_read_tlb_fix_ret
+#endif
+
 	. = 0x3000
 
 AltiVecUnavailable:
