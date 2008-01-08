Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 4581ADE1C5
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 06:35:23 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	simekm2@fel.cvut.cz, jwilliams@itee.uq.edu.au
Subject: [PATCH 7/7] [POWERPC] Xilinx: Uartlite: Section type fixups
Date: Tue,  8 Jan 2008 11:35:09 -0800
In-Reply-To: <1199820909-32341-7-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1199820909-32341-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-3-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-4-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-5-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-6-git-send-email-stephen.neuendorffer@xilinx.com>
	<1199820909-32341-7-git-send-email-stephen.neuendorffer@xilinx.com>
Message-Id: <20080108193519.5282318F8069@mail8-blu.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All the __devexit functions are now appropriately tagged.  This fixes
some ppc link warnings.

Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
---
 drivers/serial/uartlite.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/uartlite.c b/drivers/serial/uartlite.c
index 02c2d89..ecd5540 100644
--- a/drivers/serial/uartlite.c
+++ b/drivers/serial/uartlite.c
@@ -594,7 +594,7 @@ static int __devinit ulite_assign(struct device *dev, int id, u32 base, int irq)
  *
  * @dev: pointer to device structure
  */
-static int __devinit ulite_release(struct device *dev)
+static int __devexit ulite_release(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 	int rc = 0;
@@ -627,7 +627,7 @@ static int __devinit ulite_probe(struct platform_device *pdev)
 	return ulite_assign(&pdev->dev, pdev->id, res->start, res2->start);
 }
 
-static int ulite_remove(struct platform_device *pdev)
+static int __devexit ulite_remove(struct platform_device *pdev)
 {
 	return ulite_release(&pdev->dev);
 }
-- 
1.5.3.4-dirty
