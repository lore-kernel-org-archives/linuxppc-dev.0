Return-Path: <nd@bplan-gmbh.de>
Received: from natfrord.rzone.de (natfrord.rzone.de [81.169.145.161])
	by ozlabs.org (Postfix) with ESMTP id B0BA9685C0
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Oct 2005 23:09:58 +1000 (EST)
From: Nicolas DET <nd@bplan-gmbh.de>
To: Sven Luther <sl@bplan-gmbh.de>, Andrew Morton <akpm@osdl.org>,
	linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-2r7gtjZgozJqy+lj0LYp"
Date: Mon, 24 Oct 2005 15:09:38 +0200
Message-Id: <1130159379.4872.9.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [PATCH 2.6.14-rc5 1/1] chrp_pegasos_eth: Added Marvell Discovery
	II SRAM support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-2r7gtjZgozJqy+lj0LYp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Added proper entry to support the Marvell MV64361 (Marvell Discovery II)
SRAM.

This feature may be used by the mv643xx_eth driver.

Signed-off-by: Nicolas DET <det.nicolas@free.fr>
Signed-off-by: Sven Luther <sl@bplan-gmbh.de>


--=-2r7gtjZgozJqy+lj0LYp
Content-Disposition: attachment; filename=chrp_pegasos_eth.2.6.14-rc5.patch
Content-Type: text/x-patch; name=chrp_pegasos_eth.2.6.14-rc5.patch;
	charset=iso-8859-15
Content-Transfer-Encoding: 7bit

diff -Naur a/arch/ppc/platforms/chrp_pegasos_eth.c b/arch/ppc/platforms/chrp_pegasos_eth.c
--- a/arch/ppc/platforms/chrp_pegasos_eth.c	2005-10-24 14:48:16.087853000 +0200
+++ b/arch/ppc/platforms/chrp_pegasos_eth.c	2005-10-24 15:05:09.271853000 +0200
@@ -17,7 +17,20 @@
 #include <linux/mv643xx.h>
 #include <linux/pci.h>
 
-/* Pegasos 2 specific Marvell MV 64361 gigabit ethernet port setup */
+#define PEGASOS2_MARVELL_REGBASE 		(0xf1000000)
+#define PEGASOS2_MARVELL_REGSIZE 		(0x00004000)
+#define PEGASOS2_SRAM_BASE 			(0xf2000000)
+#define PEGASOS2_SRAM_SIZE			(256*1024)
+
+#define PEGASOS2_SRAM_BASE_ETH0			(PEGASOS2_SRAM_BASE)
+#define PEGASOS2_SRAM_BASE_ETH1			(PEGASOS2_SRAM_BASE_ETH0 + (PEGASOS2_SRAM_SIZE / 2) )
+
+
+#define PEGASOS2_SRAM_RXRING_SIZE		(PEGASOS2_SRAM_SIZE/4)
+#define PEGASOS2_SRAM_TXRING_SIZE		(PEGASOS2_SRAM_SIZE/4)
+
+#undef BE_VERBOSE
+
 static struct resource mv643xx_eth_shared_resources[] = {
 	[0] = {
 		.name	= "ethernet shared base",
@@ -44,7 +57,16 @@
 	},
 };
 
-static struct mv643xx_eth_platform_data eth0_pd;
+
+static struct mv643xx_eth_platform_data eth0_pd = {
+	.tx_sram_addr = PEGASOS2_SRAM_BASE_ETH0,
+	.tx_sram_size = PEGASOS2_SRAM_TXRING_SIZE,
+	.tx_queue_size = PEGASOS2_SRAM_TXRING_SIZE/16,
+
+	.rx_sram_addr = PEGASOS2_SRAM_BASE_ETH0 + PEGASOS2_SRAM_TXRING_SIZE,
+	.rx_sram_size = PEGASOS2_SRAM_RXRING_SIZE,
+	.rx_queue_size = PEGASOS2_SRAM_RXRING_SIZE/16,
+};
 
 static struct platform_device eth0_device = {
 	.name		= MV643XX_ETH_NAME,
@@ -65,7 +87,15 @@
 	},
 };
 
-static struct mv643xx_eth_platform_data eth1_pd;
+static struct mv643xx_eth_platform_data eth1_pd = {
+	.tx_sram_addr = PEGASOS2_SRAM_BASE_ETH1,
+	.tx_sram_size = PEGASOS2_SRAM_TXRING_SIZE,
+	.tx_queue_size = PEGASOS2_SRAM_TXRING_SIZE/16,
+	
+	.rx_sram_addr = PEGASOS2_SRAM_BASE_ETH1 + PEGASOS2_SRAM_TXRING_SIZE,
+	.rx_sram_size = PEGASOS2_SRAM_RXRING_SIZE,
+	.rx_queue_size = PEGASOS2_SRAM_RXRING_SIZE/16,
+};
 
 static struct platform_device eth1_device = {
 	.name		= MV643XX_ETH_NAME,
@@ -83,9 +113,61 @@
 	&eth1_device,
 };
 
+/***********/
+/***********/
+#define MV_READ(offset,val) 	{ val = readl(mv643xx_reg_base + offset); }
+#define MV_WRITE(offset,data) writel(data, mv643xx_reg_base + offset)
+
+static void __iomem *mv643xx_reg_base = NULL;
+
+
+static int Enable_SRAM(void)
+{
+	u32 ALong;
+	
+	if (mv643xx_reg_base == NULL)
+		mv643xx_reg_base = ioremap(PEGASOS2_MARVELL_REGBASE, PEGASOS2_MARVELL_REGSIZE);
+
+	if (mv643xx_reg_base == NULL)
+	return -ENOMEM;
+
+#ifdef BE_VERBOSE
+	printk("Pegasos II/Marvell MV64361: register remapped from %p to %p\n", (void *)PEGASOS2_MARVELL_REGBASE, (void *)mv643xx_reg_base);
+#endif
 
-int
-mv643xx_eth_add_pds(void)
+	MV_WRITE(MV64340_SRAM_CONFIG, 0);
+
+	MV_WRITE(MV64340_INTEGRATED_SRAM_BASE_ADDR, PEGASOS2_SRAM_BASE >> 16);
+
+	MV_READ(MV64340_BASE_ADDR_ENABLE, ALong);
+	ALong &= ~(1 << 19);
+	MV_WRITE(MV64340_BASE_ADDR_ENABLE, ALong);
+
+	ALong = 0x02;
+	ALong |= PEGASOS2_SRAM_BASE & 0xffff0000; 
+	MV_WRITE(MV643XX_ETH_BAR_4, ALong);
+
+	MV_WRITE(MV643XX_ETH_SIZE_REG_4, (PEGASOS2_SRAM_SIZE-1) & 0xffff0000);
+
+	MV_READ(MV643XX_ETH_BASE_ADDR_ENABLE_REG, ALong);
+	ALong &= ~(1 << 4);
+	MV_WRITE(MV643XX_ETH_BASE_ADDR_ENABLE_REG, ALong);
+
+#ifdef BE_VERBOSE
+	printk("Pegasos II/Marvell MV64361: register unmapped\n");
+	printk("Pegasos II/Marvell MV64361: SRAM at %p, size=%x\n", (void*) PEGASOS2_SRAM_BASE, PEGASOS2_SRAM_SIZE);
+#endif
+
+	iounmap(mv643xx_reg_base);
+	mv643xx_reg_base = NULL;
+
+	return 1;
+}
+
+
+/***********/
+/***********/
+int mv643xx_eth_add_pds(void)
 {
 	int ret = 0;
 	static struct pci_device_id pci_marvell_mv64360[] = {
@@ -93,9 +175,39 @@
 		{ }
 	};
 
-	if (pci_dev_present(pci_marvell_mv64360)) {
+#ifdef BE_VERBOSE
+	printk("Pegasos II/Marvell MV64361: init\n");
+#endif
+
+	if (pci_dev_present(pci_marvell_mv64360))
+	{
 		ret = platform_add_devices(mv643xx_eth_pd_devs, ARRAY_SIZE(mv643xx_eth_pd_devs));
+		
+		if ( Enable_SRAM() < 0)
+		{
+			eth0_pd.tx_sram_addr = 0;
+			eth0_pd.tx_sram_size = 0;
+			eth0_pd.rx_sram_addr = 0;
+			eth0_pd.rx_sram_size = 0;
+			
+			eth1_pd.tx_sram_addr = 0;
+			eth1_pd.tx_sram_size = 0;
+			eth1_pd.rx_sram_addr = 0;
+			eth1_pd.rx_sram_size = 0;
+			
+#ifdef BE_VERBOSE
+			printk("Pegasos II/Marvell MV64361: Can't enable the SRAM\n");
+#endif
+		}	
 	}
+	
+#ifdef BE_VERBOSE
+		
+	printk("Pegasos II/Marvell MV64361: init is over\n");
+#endif
+	
 	return ret;
 }
+
 device_initcall(mv643xx_eth_add_pds);
+

--=-2r7gtjZgozJqy+lj0LYp--
