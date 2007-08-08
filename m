Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 65AD8DDE39
	for <linuxppc-dev@ozlabs.org>; Thu,  9 Aug 2007 08:49:01 +1000 (EST)
Message-ID: <46BA4858.4040405@mvista.com>
Date: Wed, 08 Aug 2007 15:48:56 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [PATCH] 85xxCDS: Fix building without PCI.
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 32ad910d7d88e754102f3101b8869c4ca68efb53 Mon Sep 17 00:00:00 2001
From: Randy Vinson <rvinson@mvista.com>
Date: Wed, 8 Aug 2007 15:45:58 -0700
Subject: [PATCH] 85xxCDS: Fix building without PCI.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index d7ee380..f5f5d39 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -335,10 +335,10 @@ define_machine(mpc85xx_cds) {
 	.get_irq	= mpic_get_irq,
 #ifdef CONFIG_PCI
 	.restart	= mpc85xx_cds_restart,
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 #else
 	.restart	= mpc85xx_restart,
 #endif
 	.calibrate_decr = generic_calibrate_decr,
 	.progress	= udbg_progress,
-	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
 };
-- 
1.5.3.rc2.22.g69a9b
