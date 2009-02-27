Return-Path: <John.Linn@xilinx.com>
Received: from WA4EHSOBE002.bigfish.com (wa4ehsobe002.messaging.microsoft.com
	[216.32.181.12]) by ozlabs.org (Postfix) with ESMTP id 764E6DDD01
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Feb 2009 11:10:06 +1100 (EST)
From: John Linn <john.linn@xilinx.com>
To: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org,
	jwboyer@linux.vnet.ibm.com, akonovalov@ru.mvista.com,
	dbrownell@users.sourceforge.net
Subject: [PATCH] Xilinx: SPI: driver not releasing memory
Date: Fri, 27 Feb 2009 16:54:45 -0700
Message-ID: <20090227235456.4DED2448057@mail135-wa4.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: John Linn <john.linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The driver was not releasing memory when it was removed or
when there was a failure during probe. This fixes it.

Signed-off-by: John Linn <john.linn@xilinx.com>

---
This is an incremental patch to the patch (updated driver
for device tree) that is in the next branch.
---
 drivers/spi/xilinx_spi.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index fe7e5f3..494d3f7 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -354,7 +354,7 @@ static int __init xilinx_spi_of_probe(struct of_device *ofdev,
 	if (xspi->regs == NULL) {
 		rc = -ENOMEM;
 		dev_warn(&ofdev->dev, "ioremap failure\n");
-		goto put_master;
+		goto release_mem;
 	}
 	xspi->irq = r_irq->start;
 
@@ -365,7 +365,7 @@ static int __init xilinx_spi_of_probe(struct of_device *ofdev,
 	prop = of_get_property(ofdev->node, "xlnx,num-ss-bits", &len);
 	if (!prop || len < sizeof(*prop)) {
 		dev_warn(&ofdev->dev, "no 'xlnx,num-ss-bits' property\n");
-		goto put_master;
+		goto unmap_io;
 	}
 	master->num_chipselect = *prop;
 
@@ -397,6 +397,8 @@ free_irq:
 	free_irq(xspi->irq, xspi);
 unmap_io:
 	iounmap(xspi->regs);
+release_mem:
+	release_mem_region(r_mem->start, resource_size(r_mem));
 put_master:
 	spi_master_put(master);
 	return rc;
@@ -406,6 +408,7 @@ static int __devexit xilinx_spi_remove(struct of_device *ofdev)
 {
 	struct xilinx_spi *xspi;
 	struct spi_master *master;
+	struct resource r_mem;
 
 	master = platform_get_drvdata(ofdev);
 	xspi = spi_master_get_devdata(master);
@@ -413,6 +416,8 @@ static int __devexit xilinx_spi_remove(struct of_device *ofdev)
 	spi_bitbang_stop(&xspi->bitbang);
 	free_irq(xspi->irq, xspi);
 	iounmap(xspi->regs);
+	if (!of_address_to_resource(ofdev->node, 0, &r_mem))
+		release_mem_region(r_mem.start, resource_size(&r_mem));
 	dev_set_drvdata(&ofdev->dev, 0);
 	spi_master_put(xspi->bitbang.master);
 
-- 
1.5.3.4



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
