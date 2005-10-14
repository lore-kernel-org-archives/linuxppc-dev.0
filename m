Return-Path: <nd@bplan-gmbh.de>
Received: from natnoddy.rzone.de (natnoddy.rzone.de [81.169.145.166])
	by ozlabs.org (Postfix) with ESMTP id 74BE86856C
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Oct 2005 03:33:22 +1000 (EST)
From: Nicolas DET <nd@bplan-gmbh.de>
To: Sven Luther <sl@bplan-gmbh.de>, Andrew Morton <akpm@osdl.org>,
	linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="=-chHDbs5NXNaUTTJSTWrn"
Date: Fri, 14 Oct 2005 19:38:22 +0200
Message-Id: <1129311502.28103.0.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [PATCH 2.6.14-rc3 1/1] chrp_pegasos_eth: Added Marvell Discovery
	II SRAM support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-chHDbs5NXNaUTTJSTWrn
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Added proper entry to support the Marvell MV64361 (Marvell Discovery II)
SRAM.

This feature may be used by the mv643xx_eth driver.

Signed-off-by: Nicolas DET <det.nicolas@free.fr)


--=-chHDbs5NXNaUTTJSTWrn
Content-Disposition: attachment; filename=chrp_pegasos_eth.2.6.14-rc4.patch
Content-Type: text/x-patch; name=chrp_pegasos_eth.2.6.14-rc4.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

diff -ur a/arch/ppc/platforms/chrp_pegasos_eth.c b/arch/ppc/platforms/chrp_pegasos_eth.c
--- a/arch/ppc/platforms/chrp_pegasos_eth.c	2005-10-14 19:35:45.339667250 +0200
+++ b/arch/ppc/platforms/chrp_pegasos_eth.c	2005-10-14 19:36:29.682438500 +0200
@@ -17,8 +17,27 @@
 #include <linux/mv643xx.h>
 #include <linux/pci.h>
 
+/*
+ * Pegasos II location and size for the SRAM stuff
+ * Only used for the ethernet driver ATM
+*/
+
+#define PEGASOS2_MARVELL_REGBASE 		(0xf1000000)
+#define PEGASOS2_MARVELL_REGSIZE 		(0x00004000)
+#define PEGASOS2_SRAM_BASE 			(0xf2000000)
+#define PEGASOS2_SRAM_SIZE			(0x00040000)
+
+#define PEGASOS2_SRAM_BASE_ETH0			(PEGASOS2_SRAM_BASE)
+#define PEGASOS2_SRAM_BASE_ETH1			(PEGASOS2_SRAM_BASE_ETH0 + (PEGASOS2_SRAM_SIZE / 2) )
+
+#define PEGASOS2_SRAM_RXRING_SIZE		(PEGASOS2_SRAM_SIZE/4)
+#define PEGASOS2_SRAM_TXRING_SIZE		(PEGASOS2_SRAM_SIZE/4)
+
+#undef BE_VERBOSE
+
 /* Pegasos 2 specific Marvell MV 64361 gigabit ethernet port setup */
-static struct resource mv643xx_eth_shared_resources[] = {
+static struct resource mv643xx_eth_shared_resources[] = 
+{
 	[0] = {
 		.name	= "ethernet shared base",
 		.start	= 0xf1000000 + MV643XX_ETH_SHARED_REGS,
@@ -28,14 +47,16 @@
 	},
 };
 
-static struct platform_device mv643xx_eth_shared_device = {
+static struct platform_device mv643xx_eth_shared_device = 
+{
 	.name		= MV643XX_ETH_SHARED_NAME,
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(mv643xx_eth_shared_resources),
 	.resource	= mv643xx_eth_shared_resources,
 };
 
-static struct resource mv643xx_eth0_resources[] = {
+static struct resource mv643xx_eth0_resources[] = 
+{
 	[0] = {
 		.name	= "eth0 irq",
 		.start	= 9,
@@ -44,9 +65,19 @@
 	},
 };
 
-static struct mv643xx_eth_platform_data eth0_pd;
+static struct mv643xx_eth_platform_data eth0_pd =
+{
+	.tx_sram_addr = PEGASOS2_SRAM_BASE_ETH0,
+	.tx_sram_size = PEGASOS2_SRAM_TXRING_SIZE,
+	.tx_queue_size = PEGASOS2_SRAM_TXRING_SIZE/16,
+
+	.rx_sram_addr = PEGASOS2_SRAM_BASE + PEGASOS2_SRAM_TXRING_SIZE,
+	.rx_sram_size = PEGASOS2_SRAM_RXRING_SIZE,
+	.rx_queue_size = PEGASOS2_SRAM_RXRING_SIZE/16,
+};
 
-static struct platform_device eth0_device = {
+static struct platform_device eth0_device =
+{
 	.name		= MV643XX_ETH_NAME,
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(mv643xx_eth0_resources),
@@ -56,7 +87,8 @@
 	},
 };
 
-static struct resource mv643xx_eth1_resources[] = {
+static struct resource mv643xx_eth1_resources[] =
+{
 	[0] = {
 		.name	= "eth1 irq",
 		.start	= 9,
@@ -65,9 +97,19 @@
 	},
 };
 
-static struct mv643xx_eth_platform_data eth1_pd;
+static struct mv643xx_eth_platform_data eth1_pd =
+{
+	.tx_sram_addr = PEGASOS2_SRAM_BASE_ETH1,
+	.tx_sram_size = PEGASOS2_SRAM_TXRING_SIZE,
+	.tx_queue_size = PEGASOS2_SRAM_TXRING_SIZE/16,
+	
+	.rx_sram_addr = PEGASOS2_SRAM_BASE_ETH1 + PEGASOS2_SRAM_TXRING_SIZE,
+	.rx_sram_size = PEGASOS2_SRAM_RXRING_SIZE,
+	.rx_queue_size = PEGASOS2_SRAM_RXRING_SIZE/16,
+};
 
-static struct platform_device eth1_device = {
+static struct platform_device eth1_device =
+{
 	.name		= MV643XX_ETH_NAME,
 	.id		= 1,
 	.num_resources	= ARRAY_SIZE(mv643xx_eth1_resources),
@@ -77,25 +119,120 @@
 	},
 };
 
-static struct platform_device *mv643xx_eth_pd_devs[] __initdata = {
+static struct platform_device *mv643xx_eth_pd_devs[] __initdata =
+{
 	&mv643xx_eth_shared_device,
 	&eth0_device,
 	&eth1_device,
 };
 
+/***********/
+/***********/
+#define MV_READ(offset,val) 	{ val = readl(mv643xx_reg_base + offset); }
+#define MV_WRITE(offset,data) writel(data, mv643xx_reg_base + offset)
+
+static void __iomem *mv643xx_reg_base = NULL;
+
 
-int
-mv643xx_eth_add_pds(void)
+static int Enable_SRAM(void)
+{
+	u32 ALong;
+	
+	/* Let's io remap the mv register to touch the SRAM config */
+	if (mv643xx_reg_base == NULL)
+		mv643xx_reg_base = ioremap(PEGASOS2_MARVELL_REGBASE, PEGASOS2_MARVELL_REGSIZE);
+
+	if (mv643xx_reg_base == NULL)
+	return -ENOMEM;
+
+#ifdef BE_VERBOSE
+	printk("Pegasos II/Marvell MV64361: register remapped from %p to %p\n", (void *)PEGASOS2_MARVELL_REGBASE, (void *)mv643xx_reg_base);
+#endif
+
+	/*
+	 * First the SRAM config register
+	 * We set it to 0 ATM -> No cache coherency, no parity check
+	*/
+	MV_WRITE(MV64340_SRAM_CONFIG, 0);
+
+	/* set the SRAM address on the CPU side */
+	MV_WRITE(MV64340_INTEGRATED_SRAM_BASE_ADDR, PEGASOS2_SRAM_BASE >> 16);
+
+	/* Now enable it (CPU side) */
+	MV_READ(MV64340_BASE_ADDR_ENABLE, ALong);
+	ALong &= ~(1 << 19);
+	MV_WRITE(MV64340_BASE_ADDR_ENABLE, ALong);
+
+	/* And now to the GB side on WB 4 (0->3) can be use for DRAM stuff */
+	ALong = 0x02; // Integrated SRAM value
+	ALong |= PEGASOS2_SRAM_BASE & 0xffff0000; 
+	MV_WRITE(MV643XX_ETH_BAR_4, ALong);
+
+	/* and the size ... */
+	MV_WRITE(MV643XX_ETH_SIZE_REG_4, PEGASOS2_SRAM_SIZE & 0xffff0000);
+
+	/* Finaly enable the window */
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
-	static struct pci_device_id pci_marvell_mv64360[] = {
+	static struct pci_device_id pci_marvell_mv64360[] =
+	{
 		{ PCI_DEVICE(PCI_VENDOR_ID_MARVELL, PCI_DEVICE_ID_MARVELL_MV64360) },
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
+			// Humm, disable SRAM stuff
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

--=-chHDbs5NXNaUTTJSTWrn--
