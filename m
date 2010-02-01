Return-Path: <jtyner@cs.ucr.edu>
Received: from fed1rmmtao104.cox.net (fed1rmmtao104.cox.net [68.230.241.42])
	by ozlabs.org (Postfix) with ESMTP id 110DEB7D4F
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Feb 2010 10:31:14 +1100 (EST)
Message-ID: <4B6762CE.1050001@cs.ucr.edu>
Date: Mon, 01 Feb 2010 15:25:02 -0800
From: John Tyner <jtyner@cs.ucr.edu>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: PATCH: Add non-Virtex 5 support for LL TEMAC driver
Content-Type: multipart/mixed; boundary="------------040108000603080003060800"
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040108000603080003060800
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch adds support for using the LL TEMAC Ethernet driver on 
non-Virtex 5 platforms by adding support for accessing the Soft DMA 
registers as if they were memory mapped instead of solely through the 
DCR's (available on the Virtex 5).

Signed-off-by: John Tyner <jtyner@cs.ucr.edu>

--------------040108000603080003060800
Content-Type: text/x-diff;
 name="temac.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="temac.patch"

--- /tmp/tmp.5198.41	2010-02-01 15:04:45.000000000 -0800
+++ ./linux-2.6.32.3/drivers/net/ll_temac.h	2010-01-28 15:06:17.000000000 -0800
@@ -338,6 +338,7 @@
 	/* IO registers and IRQs */
 	void __iomem *regs;
 	dcr_host_t sdma_dcrs;
+	u32 __iomem *sdma_regs;
 	int tx_irq;
 	int rx_irq;
 	int emac_num;
--- /tmp/tmp.5198.53	2010-02-01 15:04:45.000000000 -0800
+++ ./linux-2.6.32.3/drivers/net/ll_temac_main.c	2010-02-01 15:04:01.000000000 -0800
@@ -20,9 +20,6 @@
  *   or rx, so this should be okay.
  *
  * TODO:
- * - Fix driver to work on more than just Virtex5.  Right now the driver
- *   assumes that the locallink DMA registers are accessed via DCR
- *   instructions.
  * - Factor out locallink DMA code into separate driver
  * - Fix multicast assignment.
  * - Fix support for hardware checksumming.
@@ -117,12 +114,20 @@
 
 static u32 temac_dma_in32(struct temac_local *lp, int reg)
 {
-	return dcr_read(lp->sdma_dcrs, reg);
+	if (lp->sdma_regs) {
+		return __raw_readl(lp->sdma_regs + reg);
+	} else {
+		return dcr_read(lp->sdma_dcrs, reg);
+	}
 }
 
 static void temac_dma_out32(struct temac_local *lp, int reg, u32 value)
 {
-	dcr_write(lp->sdma_dcrs, reg, value);
+	if (lp->sdma_regs) {
+		__raw_writel(value, lp->sdma_regs + reg);
+	} else {
+		dcr_write(lp->sdma_dcrs, reg, value);
+	}
 }
 
 /**
@@ -862,13 +867,17 @@
 		goto nodev;
 	}
 
-	dcrs = dcr_resource_start(np, 0);
-	if (dcrs == 0) {
-		dev_err(&op->dev, "could not get DMA register address\n");
+	lp->sdma_regs = NULL;
+
+	if ((dcrs = dcr_resource_start(np, 0)) != 0) {
+		lp->sdma_dcrs = dcr_map(np, dcrs, dcr_resource_len(np, 0));
+		dev_dbg(&op->dev, "DCR base: %x\n", dcrs);
+	} else if ((lp->sdma_regs = of_iomap(np, 0))) {
+		dev_dbg(&op->dev, "MEM base: %p\n", lp->sdma_regs);
+	} else {
+		dev_err(&op->dev, "unable to map DMA registers\n");
 		goto nodev;
 	}
-	lp->sdma_dcrs = dcr_map(np, dcrs, dcr_resource_len(np, 0));
-	dev_dbg(&op->dev, "DCR base: %x\n", dcrs);
 
 	lp->rx_irq = irq_of_parse_and_map(np, 0);
 	lp->tx_irq = irq_of_parse_and_map(np, 1);
@@ -895,7 +904,7 @@
 
 	lp->phy_node = of_parse_phandle(op->node, "phy-handle", 0);
 	if (lp->phy_node)
-		dev_dbg(lp->dev, "using PHY node %s (%p)\n", np->full_name, np);
+		dev_dbg(lp->dev, "using PHY node %s (%p)\n", lp->phy_node->full_name, lp->phy_node);
 
 	/* Add the device attributes */
 	rc = sysfs_create_group(&lp->dev->kobj, &temac_attr_group);

--------------040108000603080003060800--
