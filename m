Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DE6B0DDF56
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 23:11:14 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m6EDBAqK012968
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Jul 2008 08:11:11 -0500
Date: Mon, 14 Jul 2008 08:11:10 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] powerpc/fsl: Minor TLBSYNC cleanup for FSL Book-E
In-Reply-To: <Pine.LNX.4.64.0807140809260.9284@blarg.am.freescale.net>
Message-ID: <Pine.LNX.4.64.0807140810430.9284@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0807140808090.9284@blarg.am.freescale.net>
	<Pine.LNX.4.64.0807140809260.9284@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Use the TLBSYNC macro defined in ppc_asm.h rather than our own ifdefs.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
this will go via my powerpc-next tree.

- k

 arch/powerpc/kernel/head_fsl_booke.S |   19 ++++---------------
 1 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 7d55496..3cb52fa 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -151,16 +151,11 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	/* Invalidate TLB0 */
 	li	r6,0x04
 	tlbivax 0,r6
-#ifdef CONFIG_SMP
-	tlbsync
-#endif
+	TLBSYNC
 	/* Invalidate TLB1 */
 	li	r6,0x0c
 	tlbivax 0,r6
-#ifdef CONFIG_SMP
-	tlbsync
-#endif
-	msync
+	TLBSYNC

 /* 3. Setup a temp mapping and jump to it */
 	andi.	r5, r3, 0x1	/* Find an entry not used and is non-zero */
@@ -238,10 +233,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	/* Invalidate TLB1 */
 	li	r9,0x0c
 	tlbivax 0,r9
-#ifdef CONFIG_SMP
-	tlbsync
-#endif
-	msync
+	TLBSYNC

 /* 6. Setup KERNELBASE mapping in TLB1[0] */
 	lis	r6,0x1000		/* Set MAS0(TLBSEL) = TLB1(1), ESEL = 0 */
@@ -283,10 +275,7 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	/* Invalidate TLB1 */
 	li	r9,0x0c
 	tlbivax 0,r9
-#ifdef CONFIG_SMP
-	tlbsync
-#endif
-	msync
+	TLBSYNC

 	/* Establish the interrupt vector offsets */
 	SET_IVOR(0,  CriticalInput);
-- 
1.5.5.1
