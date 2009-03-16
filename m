Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 92591DDFAE
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 02:52:11 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [RFC][PATCH v5] MPC5121 TLB errata workaround
Date: Mon, 16 Mar 2009 16:52:09 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200903161652.09747.david.jander@protonic.nl>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Wolfgang Denk <wd@denx.de>, gunnar@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Complete workaround for DTLB errata in e300c2/c3/c4 processors.

Due to the bug, the hardware-implemented LRU algorythm always goes to way
1 of the TLB. This fix implements the proposed software workaround in
form of a LRW table for chosing the TLB-way.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: David Jander <david@protonic.nl>

---
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index 0f4fac5..3971ee4 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -578,9 +578,21 @@ DataLoadTLBMiss:
 	andc	r1,r3,r1		/* PP = user? (rw&dirty? 2: 3): 0 */
 	mtspr	SPRN_RPA,r1
 	mfspr	r3,SPRN_DMISS
+	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
+	mtcrf	0x80,r2
+#ifdef CONFIG_PPC_MPC512x
+	li	r0,1
+	mfspr	r1,SPRN_SPRG6
+	rlwinm	r2,r3,17,27,31		/* Get Address bits 19:15 */
+	slw	r0,r0,r2
+	xor	r1,r0,r1
+	srw	r0,r1,r2
+	mtspr   SPRN_SPRG6,r1
+	mfspr	r2,SPRN_SRR1
+	rlwimi	r2,r0,31-14,14,14
+	mtspr   SPRN_SRR1,r2
+#endif
 	tlbld	r3
-	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
-	mtcrf	0x80,r3
 	rfi
 DataAddressInvalid:
 	mfspr	r3,SPRN_SRR1
@@ -646,9 +658,21 @@ DataStoreTLBMiss:
 	andc	r1,r3,r1		/* PP = user? 2: 0 */
 	mtspr	SPRN_RPA,r1
 	mfspr	r3,SPRN_DMISS
+	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
+	mtcrf	0x80,r2
+#ifdef CONFIG_PPC_MPC512x
+	li	r0,1
+	mfspr	r1,SPRN_SPRG6
+	rlwinm	r2,r3,17,27,31		/* Get Address bits 19:15 */
+	slw	r0,r0,r2
+	xor	r1,r0,r1
+	srw	r0,r1,r2
+	mtspr   SPRN_SPRG6,r1
+	mfspr	r2,SPRN_SRR1
+	rlwimi	r2,r0,31-14,14,14
+	mtspr   SPRN_SRR1,r2
+#endif
 	tlbld	r3
-	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
-	mtcrf	0x80,r3
 	rfi
 
 #ifndef CONFIG_ALTIVEC
