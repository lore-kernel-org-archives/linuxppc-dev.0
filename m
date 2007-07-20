Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id EE22EDDED4
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jul 2007 08:31:31 +1000 (EST)
Message-ID: <46A137C1.3080105@mvista.com>
Date: Fri, 20 Jul 2007 15:31:29 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 5/6 v2] 85xxCDS: Misc 8548 PCI Corrections.
References: <46A10578.6030609@mvista.com>	<DF1A9889-840C-4D19-9824-177DFEFE298F@kernel.crashing.org>
	<46A133CF.6010407@mvista.com>
In-Reply-To: <46A133CF.6010407@mvista.com>
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>From 57501bb79c2d5212c02766a32685d415cc74a4ab Mon Sep 17 00:00:00 2001
From: Randy Vinson <rvinson@mvista.com>
Date: Thu, 19 Jul 2007 10:40:53 -0700
Subject: [PATCH] 85xxCDS: Misc 8548 PCI Corrections.

Setting the host bridge @8000 as primary. Also fixing a bug in
setting the USB interrupt numbers.

Signed-off-by: Randy Vinson <rvinson@mvista.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 963c6f8..862f394 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -114,7 +114,7 @@ static void __init mpc85xx_cds_pci_irq_fixup(struct pci_dev *dev)
 		/* There are two USB controllers.
 		 * Identify them by functon number
 		 */
-			if (PCI_FUNC(dev->devfn))
+			if (PCI_FUNC(dev->devfn) == 3)
 				dev->irq = 11;
 			else
 				dev->irq = 10;
@@ -272,10 +272,10 @@ static void __init mpc85xx_cds_setup_arch(void)
 	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;) {
 		struct resource rsrc;
 		of_address_to_resource(np, 0, &rsrc);
-		if ((rsrc.start & 0xfffff) == 0x9000)
-			fsl_add_bridge(np, 0);
-		else
+		if ((rsrc.start & 0xfffff) == 0x8000)
 			fsl_add_bridge(np, 1);
+		else
+			fsl_add_bridge(np, 0);
 	}
 	ppc_md.pci_irq_fixup = mpc85xx_cds_pci_irq_fixup;
 #endif
-- 
1.5.2.2.549.gaeb59
