Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC09CDE1E7
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 00:55:15 +1000 (EST)
Date: Fri, 27 Jun 2008 08:10:08 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/booke: don't reinitialize time base
Message-ID: <Pine.LNX.4.64.0806270809440.16057@blarg.am.freescale.net>
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

For some reason long ago I decided that we should zero out the time base
when we calibrate the decrementer.  The problem is that this can be
harmful in SMP systems where the firmware has already synchronized the
time bases on the various cores.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/time.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index c73fc33..eb93880 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -742,10 +742,6 @@ void __init generic_calibrate_decr(void)
 	}

 #if defined(CONFIG_BOOKE) || defined(CONFIG_40x)
-	/* Set the time base to zero */
-	mtspr(SPRN_TBWL, 0);
-	mtspr(SPRN_TBWU, 0);
-
 	/* Clear any pending timer interrupts */
 	mtspr(SPRN_TSR, TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS);

-- 
1.5.5.1
