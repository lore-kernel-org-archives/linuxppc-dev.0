Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id B427467A65
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Feb 2005 11:15:35 +1100 (EST)
Message-ID: <42153399.6020303@mvista.com>
Date: Thu, 17 Feb 2005 17:15:21 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------070201050808040706020001"
Cc: dfarnsworth <dfarnsworth@mvista.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][PPC32] Artesyn Katana enet update
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------070201050808040706020001
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This applies on top of Mark Greer's Artesyn Katana patch of 15 Feb 2005, http://ozlabs.org/pipermail/linuxppc-embedded/2005-February/001339.html

- Adapt Katana to the new names used by the ethernet driver.
- Remove SRAM allocation code for mv643xx_enet until it's had more review.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--


--------------070201050808040706020001
Content-Type: text/plain;
 name="k.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="k.patch"

Index: linux-2.5-katana/arch/ppc/platforms/katana.c
===================================================================
--- linux-2.5-katana.orig/arch/ppc/platforms/katana.c
+++ linux-2.5-katana/arch/ppc/platforms/katana.c
@@ -558,32 +558,18 @@
 static void __init
 katana_fixup_eth_pdata(struct platform_device *pdev)
 {
-	struct mv64xxx_eth_platform_data *eth_pd;
+	struct mv643xx_eth_platform_data *eth_pd;
 	static u16 phy_addr[] = {
 		KATANA_ETH0_PHY_ADDR,
 		KATANA_ETH1_PHY_ADDR,
 		KATANA_ETH2_PHY_ADDR,
 	};
-	int	rx_size = KATANA_ETH_RX_QUEUE_SIZE * MV64340_ETH_DESC_SIZE;
-	int	tx_size = KATANA_ETH_TX_QUEUE_SIZE * MV64340_ETH_DESC_SIZE;
 
 	eth_pd = pdev->dev.platform_data;
 	eth_pd->force_phy_addr = 1;
 	eth_pd->phy_addr = phy_addr[pdev->id];
 	eth_pd->tx_queue_size = KATANA_ETH_TX_QUEUE_SIZE;
 	eth_pd->rx_queue_size = KATANA_ETH_RX_QUEUE_SIZE;
-	eth_pd->tx_sram_addr = mv643xx_sram_alloc(tx_size);
-
-	if (eth_pd->tx_sram_addr)
-		eth_pd->tx_sram_size = tx_size;
-	else
-		printk(KERN_ERR "mv643xx_sram_alloc failed\n");
-
-	eth_pd->rx_sram_addr = mv643xx_sram_alloc(rx_size);
-	if (eth_pd->rx_sram_addr)
-		eth_pd->rx_sram_size = rx_size;
-	else
-		printk(KERN_ERR "mv643xx_sram_alloc failed\n");
 }
 #endif
 
@@ -599,9 +585,9 @@
 		{ MPSC_CTLR_NAME "1", katana_fixup_mpsc_pdata },
 #endif
 #if defined(CONFIG_MV643XX_ETH)
-		{ MV64XXX_ETH_NAME "0", katana_fixup_eth_pdata },
-		{ MV64XXX_ETH_NAME "1", katana_fixup_eth_pdata },
-		{ MV64XXX_ETH_NAME "2", katana_fixup_eth_pdata },
+		{ MV643XX_ETH_NAME "0", katana_fixup_eth_pdata },
+		{ MV643XX_ETH_NAME "1", katana_fixup_eth_pdata },
+		{ MV643XX_ETH_NAME "2", katana_fixup_eth_pdata },
 #endif
 	};
 	struct platform_device	*pdev;
Index: linux-2.5-katana/arch/ppc/syslib/mv64x60.c
===================================================================
--- linux-2.5-katana.orig/arch/ppc/syslib/mv64x60.c
+++ linux-2.5-katana/arch/ppc/syslib/mv64x60.c
@@ -314,15 +314,15 @@
 static struct resource mv64x60_eth_shared_resources[] = {
 	[0] = {
 		.name	= "ethernet shared base",
-		.start	= MV64340_ETH_SHARED_REGS,
-		.end	= MV64340_ETH_SHARED_REGS +
-					MV64340_ETH_SHARED_REGS_SIZE - 1,
+		.start	= MV643XX_ETH_SHARED_REGS,
+		.end	= MV643XX_ETH_SHARED_REGS +
+					MV643XX_ETH_SHARED_REGS_SIZE - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 };
 
 static struct platform_device mv64x60_eth_shared_device = {
-	.name		= MV64XXX_ETH_SHARED_NAME,
+	.name		= MV643XX_ETH_SHARED_NAME,
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(mv64x60_eth_shared_resources),
 	.resource	= mv64x60_eth_shared_resources,
@@ -338,10 +338,10 @@
 	},
 };
 
-static struct mv64xxx_eth_platform_data eth0_pd;
+static struct mv643xx_eth_platform_data eth0_pd;
 
 static struct platform_device eth0_device = {
-	.name		= MV64XXX_ETH_NAME,
+	.name		= MV643XX_ETH_NAME,
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(mv64x60_eth0_resources),
 	.resource	= mv64x60_eth0_resources,
@@ -361,10 +361,10 @@
 	},
 };
 
-static struct mv64xxx_eth_platform_data eth1_pd;
+static struct mv643xx_eth_platform_data eth1_pd;
 
 static struct platform_device eth1_device = {
-	.name		= MV64XXX_ETH_NAME,
+	.name		= MV643XX_ETH_NAME,
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(mv64x60_eth1_resources),
 	.resource	= mv64x60_eth1_resources,
@@ -384,10 +384,10 @@
 	},
 };
 
-static struct mv64xxx_eth_platform_data eth2_pd;
+static struct mv643xx_eth_platform_data eth2_pd;
 
 static struct platform_device eth2_device = {
-	.name		= MV64XXX_ETH_NAME,
+	.name		= MV643XX_ETH_NAME,
 	.id		= 2,
 	.num_resources	= ARRAY_SIZE(mv64x60_eth2_resources),
 	.resource	= mv64x60_eth2_resources,

--------------070201050808040706020001--
