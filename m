Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E00E7DDF26
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 08:21:23 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n2GLLJEV003189
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 16:21:20 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: 
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 2/4] powerpc/mm: Remove unused register usage in SW TLB
	miss handling
Date: Mon, 16 Mar 2009 16:21:16 -0500
Message-Id: <1237238478-30493-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1237238478-30493-1-git-send-email-galak@kernel.crashing.org>
References: <1237238478-30493-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Long ago we had some code that actually used the CTR in the SW TLB
miss handlers (603/e300).  Since we don't use it no reason to waste
cycles saving it off and restoring it (we actually didn't restore it
in the fast path case).

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/head_32.S |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index d0bad4b..f37df0c 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -475,12 +475,11 @@ SystemCall:
 	. = 0x1000
 InstructionTLBMiss:
 /*
- * r0:	stored ctr
+ * r0:	scratch
  * r1:	linux style pte ( later becomes ppc hardware pte )
  * r2:	ptr to linux-style pte
  * r3:	scratch
  */
-	mfctr	r0
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_IMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
@@ -531,7 +530,6 @@ InstructionAddressInvalid:
 
 	addis	r1,r1,0x2000
 	mtspr	SPRN_DSISR,r1	/* (shouldn't be needed) */
-	mtctr	r0		/* Restore CTR */
 	andi.	r2,r3,0xFFFF	/* Clear upper bits of SRR1 */
 	or	r2,r2,r1
 	mtspr	SPRN_SRR1,r2
@@ -552,12 +550,11 @@ InstructionAddressInvalid:
 	. = 0x1100
 DataLoadTLBMiss:
 /*
- * r0:	stored ctr
+ * r0:	scratch
  * r1:	linux style pte ( later becomes ppc hardware pte )
  * r2:	ptr to linux-style pte
  * r3:	scratch
  */
-	mfctr	r0
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_DMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
@@ -607,7 +604,6 @@ DataAddressInvalid:
 	rlwinm	r1,r3,9,6,6	/* Get load/store bit */
 	addis	r1,r1,0x2000
 	mtspr	SPRN_DSISR,r1
-	mtctr	r0		/* Restore CTR */
 	andi.	r2,r3,0xFFFF	/* Clear upper bits of SRR1 */
 	mtspr	SPRN_SRR1,r2
 	mfspr	r1,SPRN_DMISS	/* Get failing address */
@@ -627,12 +623,11 @@ DataAddressInvalid:
 	. = 0x1200
 DataStoreTLBMiss:
 /*
- * r0:	stored ctr
+ * r0:	scratch
  * r1:	linux style pte ( later becomes ppc hardware pte )
  * r2:	ptr to linux-style pte
  * r3:	scratch
  */
-	mfctr	r0
 	/* Get PTE (linux-style) and check access */
 	mfspr	r3,SPRN_DMISS
 	lis	r1,PAGE_OFFSET@h		/* check if kernel address */
-- 
1.5.6.6
