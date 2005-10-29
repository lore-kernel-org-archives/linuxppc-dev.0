Return-Path: <akpm@osdl.org>
Message-Id: <200510290046.j9T0ktdF030029@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:25 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, det.nicolas@free.fr,
	linuxppc64-dev@ozlabs.org
Subject: [patch 14/43] chrp_pegasos_eth: Added Marvell Discovery II SRAM
	support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Nicolas DET <nd@bplan-gmbh.de>

Add proper entry to support the Marvell MV64361 (Marvell Discovery II)
SRAM.

This feature may be used by the mv643xx_eth driver.

Signed-off-by: Nicolas DET <det.nicolas@free.fr>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc/platforms/chrp_pegasos_eth.c |  124 ++++++++++++++++++++++++++++++++--
 1 files changed, 118 insertions(+), 6 deletions(-)

diff -puN arch/ppc/platforms/chrp_pegasos_eth.c~chrp_pegasos_eth-added-marvell-discovery arch/ppc/platforms/chrp_pegasos_eth.c
--- devel/arch/ppc/platforms/chrp_pegasos_eth.c~chrp_pegasos_eth-added-marvell-discovery	2005-10-28 17:44:03.000000000 -0700
+++ devel-akpm/arch/ppc/platforms/chrp_pegasos_eth.c	2005-10-28 17:44:03.000000000 -0700
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
@@ -44,7 +57,16 @@ static struct resource mv643xx_eth0_reso
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
@@ -65,7 +87,15 @@ static struct resource mv643xx_eth1_reso
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
@@ -83,9 +113,62 @@ static struct platform_device *mv643xx_e
 	&eth1_device,
 };
 
+/***********/
+/***********/
+#define MV_READ(offset,val) 	{ val = readl(mv643xx_reg_base + offset); }
+#define MV_WRITE(offset,data) writel(data, mv643xx_reg_base + offset)
+
+static void __iomem *mv643xx_reg_base;
+
+static int Enable_SRAM(void)
+{
+	u32 ALong;
+
+	if (mv643xx_reg_base == NULL)
+		mv643xx_reg_base = ioremap(PEGASOS2_MARVELL_REGBASE,
+					PEGASOS2_MARVELL_REGSIZE);
+
+	if (mv643xx_reg_base == NULL)
+		return -ENOMEM;
+
+#ifdef BE_VERBOSE
+	printk("Pegasos II/Marvell MV64361: register remapped from %p to %p\n",
+		(void *)PEGASOS2_MARVELL_REGBASE, (void *)mv643xx_reg_base);
+#endif
+
+	MV_WRITE(MV64340_SRAM_CONFIG, 0);
 
-int
-mv643xx_eth_add_pds(void)
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
@@ -93,9 +176,38 @@ mv643xx_eth_add_pds(void)
 		{ }
 	};
 
+#ifdef BE_VERBOSE
+	printk("Pegasos II/Marvell MV64361: init\n");
+#endif
+
 	if (pci_dev_present(pci_marvell_mv64360)) {
-		ret = platform_add_devices(mv643xx_eth_pd_devs, ARRAY_SIZE(mv643xx_eth_pd_devs));
+		ret = platform_add_devices(mv643xx_eth_pd_devs,
+				ARRAY_SIZE(mv643xx_eth_pd_devs));
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
+			printk("Pegasos II/Marvell MV64361: Can't enable the "
+				"SRAM\n");
+#endif
+		}
 	}
+
+#ifdef BE_VERBOSE
+	printk("Pegasos II/Marvell MV64361: init is over\n");
+#endif
+
 	return ret;
 }
+
 device_initcall(mv643xx_eth_add_pds);
_
