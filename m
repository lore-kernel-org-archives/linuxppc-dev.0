Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A667DE288
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 23:57:01 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m7TDuu0s012317
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 08:56:56 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 3/4] powerpc/fsl-booke: Fixup 64-bit PTE reading for SMP
	support
Date: Fri, 29 Aug 2008 08:56:52 -0500
Message-Id: <1220018213-12959-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1220018213-12959-2-git-send-email-galak@kernel.crashing.org>
References: <1220018213-12959-1-git-send-email-galak@kernel.crashing.org>
	<1220018213-12959-2-git-send-email-galak@kernel.crashing.org>
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
 arch/powerpc/kernel/head_fsl_booke.S |   24 ++++++++++++++++++++----
 1 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 3cb52fa..fa39cce 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -579,13 +579,19 @@ interrupt_base:
 
 	FIND_PTE
 	andc.	r13,r13,r11		/* Check permission */
-	bne	2f			/* Bail if permission mismach */
 
 #ifdef CONFIG_PTE_64BIT
-	lwz	r13, 0(r12)
+#ifdef CONFIG_SMP
+	subf	r10, r11, r12		/* create false data dep */
+	lwzx	r13, r11, r10		/* Get upper pte bits */
+#else
+	lwz	r13, 0(r12)		/* Get upper pte bits */
 #endif
+#endif
+
+	bne	2f			/* Bail if permission/valid mismach */
 
-	 /* Jump to common tlb load */
+	/* Jump to common tlb load */
 	b	finish_tlb_load
 2:
 	/* The bailout.  Restore registers to pre-exception conditions
@@ -640,6 +646,16 @@ interrupt_base:
 
 	FIND_PTE
 	andc.	r13,r13,r11		/* Check permission */
+
+#ifdef CONFIG_PTE_64BIT
+#ifdef CONFIG_SMP
+	subf	r10, r11, r12		/* create false data dep */
+	lwzx	r13, r11, r10		/* Get upper pte bits */
+#else
+	lwz	r13, 0(r12)		/* Get upper pte bits */
+#endif
+#endif
+
 	bne	2f			/* Bail if permission mismach */
 
 #ifdef CONFIG_PTE_64BIT
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
