Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F0FEDB7B9C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 15:08:41 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3FAC7DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 15:08:41 +1000 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/5] powerpc/book3e-64: Wait til generic_calibrate_decr to
	enable decrementer
Date: Wed, 19 Aug 2009 00:08:31 -0500
Message-Id: <1250658513-13009-3-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1250658513-13009-2-git-send-email-galak@kernel.crashing.org>
References: <1250658513-13009-1-git-send-email-galak@kernel.crashing.org>
	<1250658513-13009-2-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Match what we do on 32-bit Book-E processors and enable the decrementer
in generic_calibrate_decr.  We need to make sure we disable the
decrementer early in boot since we currently use lazy (soft) interrupt
on 64-bit Book-E and possible get a decrementer exception before we
are ready for it.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/exceptions-64e.S |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 695d484..3611b0e 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -774,9 +774,11 @@ _STATIC(init_thread_book3e)
 	/* Make sure interrupts are off */
 	wrteei	0
 
-	/* disable watchdog and FIT and enable DEC interrupts */
-	lis	r3,TCR_DIE@h
+	/* disable all timers and clear out status */
+	li	r3,0
 	mtspr	SPRN_TCR,r3
+	mfspr	r3,SPRN_TSR
+	mtspr	SPRN_TSR,r3
 
 	blr
 
-- 
1.6.0.6
