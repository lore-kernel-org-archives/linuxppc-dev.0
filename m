Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BF9A4DE508
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Sep 2008 04:37:50 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m8GIbkMk006364
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Sep 2008 13:37:46 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v6 3/4] powerpc/fsl-booke: Fixup 64-bit PTE reading for SMP
	support
Date: Tue, 16 Sep 2008 13:37:43 -0500
Message-Id: <1221590264-3368-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1221590264-3368-2-git-send-email-galak@kernel.crashing.org>
References: <1221590264-3368-1-git-send-email-galak@kernel.crashing.org>
	<1221590264-3368-2-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to create a false data dependency to ensure the loads of
the pte are done in the right order.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/head_fsl_booke.S |   26 +++++++++++++++++++++-----
 1 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 3cb52fa..377e0c1 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -579,13 +579,19 @@ interrupt_base:
 
 	FIND_PTE
 	andc.	r13,r13,r11		/* Check permission */
-	bne	2f			/* Bail if permission mismach */
 
 #ifdef CONFIG_PTE_64BIT
-	lwz	r13, 0(r12)
+#ifdef CONFIG_SMP
+	subf	r10,r11,r12		/* create false data dep */
+	lwzx	r13,r11,r10		/* Get upper pte bits */
+#else
+	lwz	r13,0(r12)		/* Get upper pte bits */
+#endif
 #endif
 
-	 /* Jump to common tlb load */
+	bne	2f			/* Bail if permission/valid mismach */
+
+	/* Jump to common tlb load */
 	b	finish_tlb_load
 2:
 	/* The bailout.  Restore registers to pre-exception conditions
@@ -640,10 +646,20 @@ interrupt_base:
 
 	FIND_PTE
 	andc.	r13,r13,r11		/* Check permission */
+
+#ifdef CONFIG_PTE_64BIT
+#ifdef CONFIG_SMP
+	subf	r10,r11,r12		/* create false data dep */
+	lwzx	r13,r11,r10		/* Get upper pte bits */
+#else
+	lwz	r13,0(r12)		/* Get upper pte bits */
+#endif
+#endif
+
 	bne	2f			/* Bail if permission mismach */
 
 #ifdef CONFIG_PTE_64BIT
-	lwz	r13, 0(r12)
+	lwz	r13,0(r12)
 #endif
 
 	/* Jump to common TLB load point */
@@ -702,7 +718,7 @@ interrupt_base:
 /*
  * Both the instruction and data TLB miss get to this
  * point to load the TLB.
- *	r10 - EA of fault
+ *	r10 - available to use
  *	r11 - TLB (info from Linux PTE)
  *	r12 - available to use
  *	r13 - upper bits of PTE (if PTE_64BIT) or available to use
-- 
1.5.5.1
