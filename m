Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09C27DE80C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jan 2009 11:15:22 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n090FHEV002392
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jan 2009 18:15:18 -0600
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/e500mc: Doorbells need to be taken w/exceptions
	disabled
Date: Thu,  8 Jan 2009 18:15:16 -0600
Message-Id: <1231460116-26383-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1231460116-26383-1-git-send-email-galak@kernel.crashing.org>
References: <1231460116-26383-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We use Doorbell interrupts for IPIs and thus we need to make sure we aren't
interrupted in the process of processing the IPI.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/kernel/head_fsl_booke.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/head_fsl_booke.S b/arch/powerpc/kernel/head_fsl_booke.S
index 6062669..475c937 100644
--- a/arch/powerpc/kernel/head_fsl_booke.S
+++ b/arch/powerpc/kernel/head_fsl_booke.S
@@ -698,7 +698,7 @@ interrupt_base:
 	/* Performance Monitor */
 	EXCEPTION(0x2060, PerformanceMonitor, performance_monitor_exception, EXC_XFER_STD)
 	
-	EXCEPTION(0x2070, Doorbell, unknown_exception, EXC_XFER_EE)
+	EXCEPTION(0x2070, Doorbell, unknown_exception, EXC_XFER_STD)
 
 	/* Debug Interrupt */
 	DEBUG_DEBUG_EXCEPTION
-- 
1.5.6.5
