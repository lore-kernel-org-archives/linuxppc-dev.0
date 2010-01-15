Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DB4361008CB
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jan 2010 04:11:22 +1100 (EST)
From: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/5] powerpc/head fsl: move the temp 4KiB mapping to TLB0
Date: Fri, 15 Jan 2010 17:41:34 +0100
Message-Id: <1263573697-17839-3-git-send-email-linuxppc-dev@ml.breakpoint.cc>
In-Reply-To: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
References: <1263573697-17839-1-git-send-email-linuxppc-dev@ml.breakpoint.cc>
Cc: linuxppc-dev@ozlabs.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Right now the setup code takes ESEL of the current mapping and puts the
temporary into ESEL (old_ESEL & 1 ) + 1 which is either one or two.
This is actually not required since all slots in TLB0 are invalid by now
and can be used.
This patch moved the temp mapping to TLB0, ESEL[0]. The invalidation of
TLB0 does not care about IPPROT so that part can go as well.
The benefit is that now the setup code may set every slot of TLB1 while
before that it was not allowed to touch ESEL one or two depending on the
old_ESEL.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/head_fsl_booke.S |   20 +++++---------------
 1 files changed, 5 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 799ddbe..cc76952 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -165,8 +165,6 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	TLBSYNC
 
 /* 3. Setup a temp mapping and jump to it */
-	andi.	r5, r3, 0x1	/* Find an entry not used and is non-zero */
-	addi	r5, r5, 0x1
 	lis	r7,0x1000	/* Set MAS0(TLBSEL) = 1 */
 	rlwimi	r7,r3,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r3) */
 	mtspr	SPRN_MAS0,r7
@@ -194,12 +192,11 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	ori	r8,r25,(MAS3_SX|MAS3_SW|MAS3_SR)
 
 	/* Just modify the entry ID and EPN for the temp mapping */
-	lis	r7,0x1000	/* Set MAS0(TLBSEL) = 1 */
-	rlwimi	r7,r5,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r5) */
+	li	r7, 0		/* Set MAS0(TLBSEL) = 0 | ESEL(0) */
 	mtspr	SPRN_MAS0,r7
 	xori	r6,r4,1		/* Setup TMP mapping in the other Address space */
 	slwi	r6,r6,12
-	oris	r6,r6,(MAS1_VALID|MAS1_IPROT)@h
+	oris	r6,r6,(MAS1_VALID)@h
 	ori	r6,r6,(MAS1_TSIZE(BOOK3E_PAGESZ_4K))@l
 	mtspr	SPRN_MAS1,r6
 	mfspr	r6,SPRN_MAS2
@@ -281,16 +278,9 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	rfi				/* start execution out of TLB1[0] entry */
 
 /* 8. Clear out the temp mapping */
-2:	lis	r7,0x1000	/* Set MAS0(TLBSEL) = 1 */
-	rlwimi	r7,r5,16,4,15	/* Setup MAS0 = TLBSEL | ESEL(r5) */
-	mtspr	SPRN_MAS0,r7
-	tlbre
-	mfspr	r8,SPRN_MAS1
-	rlwinm	r8,r8,0,2,0	/* clear IPROT */
-	mtspr	SPRN_MAS1,r8
-	tlbwe
-	/* Invalidate TLB1 */
-	li	r9,0x0c
+2:
+	/* Invalidate TLB0 */
+	li	r9,0x04
 	tlbivax 0,r9
 	TLBSYNC
 
-- 
1.6.2.5
