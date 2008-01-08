Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from mail176-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 908D8DDF96
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 08:19:07 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca
Subject: [RFC] Xilinx: lltemac: use uboot bsp generated device tree style.
Date: Tue,  8 Jan 2008 13:18:51 -0800
Message-Id: <20080108211901.5017C1050057@mail176-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This driver is not in mainline, however since it is by far the most complex driver we have in terms of interacting with the device tree, I wouldn't mind some feedback.  The complexity comes from the fact that the driver is capable of being connected through two different control interfaces.  Previously, this information was all incoded in the device tree for the ll-temac, but now (to better reflect the actual hardware) it is split across two nodes with a link.

The xparameters for the lltemac not only includes information about
the lltemac parameters, but also the ip that the lltemac is connected
to, (usually either an ll_fifo or the dma port of the mpmc).  Since
we'd like the device tree to reflect the actual hardware, the code for
querying device trees has to traverse the device tree to discover this
information and pass it to the driver.

The expected device tree structure is something like:

		TriMode_MAC_MII: xps-ll-temac@81c00000 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "xlnx,compound";
			ethernet@81c00000 {
				compatible = "xlnx,xps-ll-temac-1.00.b";
				device_type = "network";
				interrupt-parent = <&xps_intc_0>;
				interrupts = < 1 2 >;
				llink-connected = <&TriMode_MAC_MII_fifo>;
				local-mac-address = [ 02 00 00 00 00 01 ];
				reg = < 81c00000 40 >;
				xlnx,bus2core-clk-ratio = <1>;
				xlnx,phy-type = <0>;
				xlnx,phyaddr = <1>;
				xlnx,rxcsum = <0>;
				xlnx,rxfifo = <1000>;
				xlnx,temac-type = <1>;
				xlnx,txcsum = <0>;
				xlnx,txfifo = <1000>;
			} ;
		} ;
		TriMode_MAC_MII_fifo: xps-ll-fifo@81a00000 {
			compatible = "xlnx,xps-ll-fifo-1.00.a";
			interrupt-parent = <&xps_intc_0>;
			interrupts = < 0 2 >;
			reg = < 81a00000 10000 >;
		} ;

or

		TriMode_MAC_MII: xps-ll-temac@81c00000 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "xlnx,compound";
			ethernet@81c00000 {
				compatible = "xlnx,xps-ll-temac-1.00.b";
				device_type = "network";
				interrupt-parent = <&xps_intc_0>;
				interrupts = < 2 2 >;
				llink-connected = <&PIM2>;
				local-mac-address = [ 00 00 00 00 00 00 ];
				reg = < 81c00000 40 >;
				xlnx,bus2core-clk-ratio = <1>;
				xlnx,phy-type = <0>;
				xlnx,phyaddr = <1>;
				xlnx,rxcsum = <0>;
				xlnx,rxfifo = <1000>;
				xlnx,temac-type = <1>;
				xlnx,txcsum = <0>;
				xlnx,txfifo = <1000>;
			} ;
		} ;
		mpmc@0 {
			#address-cells = <1>;
			#size-cells = <1>;
			compatible = "xlnx,mpmc-3.00.b";
			PIM2: sdma@84600100 {
				compatible = "xlnx,ll-dma-1.00.a";
				interrupt-parent = <&xps_intc_0>;
				interrupts = < 1 2 0 2 >;
				reg = < 84600100 80 >;
			} ;
		} ;
---
 drivers/net/xilinx_lltemac/xlltemac_main.c |   88 ++++++++++++++++++++++++++--
 1 files changed, 83 insertions(+), 5 deletions(-)

diff --git a/drivers/net/xilinx_lltemac/xlltemac_main.c b/drivers/net/xilinx_lltemac/xlltemac_main.c
index 420bd7e..758b1a1 100644
--- a/drivers/net/xilinx_lltemac/xlltemac_main.c
+++ b/drivers/net/xilinx_lltemac/xlltemac_main.c
@@ -3251,10 +3251,22 @@ static u32 get_u32(struct of_device *ofdev, const char *s) {
 	}
 }
 
+static struct of_device_id xtenet_fifo_of_match[] = {
+	{ .compatible = "xlnx,xps-ll-fifo-1.00.a", },
+	{ /* end of list */ },
+};
+
+static struct of_device_id xtenet_sdma_of_match[] = {
+	{ .compatible = "xlnx,ll-dma-1.00.a", },
+	{ /* end of list */ },
+};
+
 static int __devinit xtenet_of_probe(struct of_device *ofdev, const struct of_device_id *match)
 {
 	struct resource r_irq_struct;
 	struct resource r_mem_struct;
+	struct resource r_connected_mem_struct;
+	struct resource r_connected_irq_struct;
 	struct xlltemac_platform_data pdata_struct;
 
 	struct resource *r_irq = &r_irq_struct;	/* Interrupt resources */
@@ -3262,6 +3274,8 @@ static int __devinit xtenet_of_probe(struct of_device *ofdev, const struct of_de
 	struct xlltemac_platform_data *pdata = &pdata_struct;
         void *mac_address;
 	int rc = 0;
+	const phandle *llink_connected_handle;
+	struct device_node *llink_connected_node;
 
 	printk(KERN_INFO "Device Tree Probing \'%s\'\n",
                         ofdev->node->name);
@@ -3283,11 +3297,74 @@ static int __devinit xtenet_of_probe(struct of_device *ofdev, const struct of_de
 	pdata_struct.tx_csum		= get_u32(ofdev, "xlnx,txcsum");
 	pdata_struct.rx_csum		= get_u32(ofdev, "xlnx,rxcsum");
 	pdata_struct.phy_type           = get_u32(ofdev, "xlnx,phy-type");
-	pdata_struct.ll_dev_type	= get_u32(ofdev, "xlnx,llink-connected-type");
-	pdata_struct.ll_dev_baseaddress	= get_u32(ofdev, "xlnx,llink-connected-baseaddr");
-	pdata_struct.ll_dev_dma_rx_irq	= get_u32(ofdev, "xlnx,llink-connected-dmarx-intr");
-	pdata_struct.ll_dev_dma_tx_irq	= get_u32(ofdev, "xlnx,llink-connected-dmatx-intr");
-	pdata_struct.ll_dev_fifo_irq	= get_u32(ofdev, "xlnx,llink-connected-fifo-intr");
+        llink_connected_handle =
+		of_get_property(ofdev->node, "llink-connected", NULL);
+        if(!llink_connected_handle) {
+            dev_warn(&ofdev->dev, "no Locallink connection found.\n");
+            return rc;
+        }
+
+	llink_connected_node =
+		of_find_node_by_phandle(*llink_connected_handle);
+
+	rc = of_address_to_resource(
+			llink_connected_node,
+			0,
+			&r_connected_mem_struct);
+	if(rc) {
+		dev_warn(&ofdev->dev, "invalid address\n");
+		return rc;
+	}
+
+        pdata_struct.ll_dev_baseaddress	= r_connected_mem_struct.start;
+        /** Get the right information from whatever the locallink is
+	    connected to. */
+	if(of_match_node(xtenet_fifo_of_match, llink_connected_node)) {
+		/** Connected to a fifo. */
+		pdata_struct.ll_dev_type = XPAR_LL_FIFO;
+		pdata_struct.ll_dev_dma_rx_irq	= NO_IRQ;
+		pdata_struct.ll_dev_dma_tx_irq	= NO_IRQ;
+
+		rc = of_irq_to_resource(
+				llink_connected_node,
+				0,
+				&r_connected_irq_struct);
+		if(rc == NO_IRQ) {
+			dev_warn(&ofdev->dev, "no IRQ found.\n");
+			return rc;
+		}
+		pdata_struct.ll_dev_fifo_irq	= r_connected_irq_struct.start;
+        } else if(of_match_node(xtenet_sdma_of_match, llink_connected_node)) {
+		/** Connected to a dma port. */
+		pdata_struct.ll_dev_type = XPAR_LL_DMA;
+
+		rc = of_irq_to_resource(
+				llink_connected_node,
+				0,
+				&r_connected_irq_struct);
+		if(rc == NO_IRQ) {
+			dev_warn(&ofdev->dev, "First IRQ not found.\n");
+			return rc;
+		}
+		pdata_struct.ll_dev_dma_rx_irq	= r_connected_irq_struct.start;
+
+		rc = of_irq_to_resource(
+				llink_connected_node,
+				1,
+				&r_connected_irq_struct);
+		if(rc == NO_IRQ) {
+			dev_warn(&ofdev->dev, "Second IRQ not found.\n");
+			return rc;
+		}
+		pdata_struct.ll_dev_dma_tx_irq	= r_connected_irq_struct.start;
+
+		pdata_struct.ll_dev_fifo_irq	= NO_IRQ;
+        } else {
+		dev_warn(&ofdev->dev, "Locallink connection not matched.\n");
+		return rc;
+        }
+
+	of_node_put(llink_connected_node);
         mac_address = of_get_mac_address(ofdev->node);
         if(mac_address) {
             memcpy(pdata_struct.mac_addr, mac_address, 6);
@@ -3305,6 +3382,7 @@ static int __devexit xtenet_of_remove(struct of_device *dev)
 
 static struct of_device_id xtenet_of_match[] = {
 	{ .compatible = "xlnx,xps-ll-temac-1.00.a", },
+	{ .compatible = "xlnx,xps-ll-temac-1.00.b", },
 	{ /* end of list */ },
 };
 
-- 
1.5.3.4-dirty
