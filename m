Return-Path: <bigeasy@Chamillionaire.breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A7C3FB7D69
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jan 2010 04:11:10 +1100 (EST)
From: Sebastian Andrzej Siewior <linuxppc-dev@ml.breakpoint.cc>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 3/5] powerpc/head fsl: replace a hardcoded constant
Date: Fri, 15 Jan 2010 17:41:35 +0100
Message-Id: <1263573697-17839-4-git-send-email-linuxppc-dev@ml.breakpoint.cc>
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

24 is offset between the opcode past bl and past rfi. This makes it more
obvious.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/powerpc/kernel/head_fsl_booke.S |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index cc76952..445eddd 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -211,11 +211,11 @@ skpinv:	addi	r6,r6,1				/* Increment */
 	bl	1f		/* Find our address */
 1:	mflr	r9
 	rlwimi	r7,r9,0,20,31
-	addi	r7,r7,24
+	addi	r7,r7,(2f - 1b)
 	mtspr	SPRN_SRR0,r7
 	mtspr	SPRN_SRR1,r6
 	rfi
-
+2:
 /* 4. Clear out PIDs & Search info */
 	li	r6,0
 	mtspr   SPRN_MAS6,r6
-- 
1.6.2.5
