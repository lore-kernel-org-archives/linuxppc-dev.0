Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 8DF8D68736
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Nov 2005 23:04:36 +1100 (EST)
Message-ID: <437B2051.5030408@ru.mvista.com>
Date: Wed, 16 Nov 2005 15:04:33 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] ppc32: 8xx board-specific platform stuff for fs_enet
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This adds board-specific files needed to utilize fs_enet Ethernet driver
for MPC885ADS and MPC866ADS.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>


---

  arch/ppc/Kconfig                     |   47 ++++
  arch/ppc/platforms/Makefile          |    2
  arch/ppc/platforms/fads.h            |    2
  arch/ppc/platforms/mpc866ads_setup.c |  290 ++++++++++++++++++++++++
  arch/ppc/platforms/mpc885ads_setup.c |  408 ++++++++++++++++++++++++++++++++++
  5 files changed, 748 insertions(+), 1 deletions(-)
  create mode 100644 arch/ppc/platforms/mpc866ads_setup.c
  create mode 100644 arch/ppc/platforms/mpc885ads_setup.c

applies-to: f358a802ba9f62bb4777d5f626f2972d1b0fa43b
4c4f454bd8e79fd67bc86aa9a22604f66d682d3b
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 8fa51b0..8e6fcb2 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -506,6 +506,53 @@ config WINCEPT

  endchoice

+menu "Freescale Ethernet driver platform-specific options"
+	depends on FS_ENET
+
+	config MPC8xx_SECOND_ETH
+	bool "Second Ethernet channel"
+	depends on (MPC885ADS || MPC86XADS)
+	default y
+	help
+	  This enables support for second Ethernet on MPC885ADS and MPC86xADS boards.
+	  The latter will use SCC1, for 885ADS you can select it below.
+
+	choice
+		prompt "Second Ethernet channel"
+		depends on MPC8xx_SECOND_ETH
+		default MPC8xx_SECOND_ETH_FEC2
+
+		config MPC8xx_SECOND_ETH_FEC2
+		bool "FEC2"
+		depends on MPC885ADS
+		help
+		  Enable FEC2 to serve as 2-nd Ethernet channel. Note that SMC2
+		  (often 2-nd UART) will not work if this is enabled.
+
+		config MPC8xx_SECOND_ETH_SCC1
+		bool "SCC1"
+		depends on MPC86XADS
+		select MPC8xx_SCC_ENET_FIXED
+		help
+		  Enable SCC1 to serve as 2-nd Ethernet channel. Note that SMC1
+		  (often 1-nd UART) will not work if this is enabled.
+
+		config MPC8xx_SECOND_ETH_SCC3
+		bool "SCC3"
+		depends on MPC885ADS
+		help
+		  Enable SCC3 to serve as 2-nd Ethernet channel. Note that SMC1
+		  (often 1-nd UART) will not work if this is enabled.
+
+	endchoice
+
+	config MPC8xx_SCC_ENET_FIXED
+	depends on MPC8xx_SECOND_ETH_SCC
+	default n
+	bool "Use fixed MII-less mode for SCC Ethernet"
+
+endmenu
+
  choice
  	prompt "Machine Type"
  	depends on 6xx || POWER3 || POWER4
diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
index 7c5cdab..cce6487 100644
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -45,6 +45,8 @@ obj-$(CONFIG_SBC82xx)		+= sbc82xx.o
  obj-$(CONFIG_SPRUCE)		+= spruce.o
  obj-$(CONFIG_LITE5200)		+= lite5200.o
  obj-$(CONFIG_EV64360)		+= ev64360.o
+obj-$(CONFIG_MPC86XADS)		+= mpc866ads_setup.o
+obj-$(CONFIG_MPC885ADS)		+= mpc885ads_setup.o

  ifeq ($(CONFIG_SMP),y)
  obj-$(CONFIG_PPC_PMAC)		+= pmac_smp.o
diff --git a/arch/ppc/platforms/fads.h b/arch/ppc/platforms/fads.h
index a48fb8d..e1c0b1b 100644
--- a/arch/ppc/platforms/fads.h
+++ b/arch/ppc/platforms/fads.h
@@ -112,7 +112,7 @@

  /* CPM Ethernet through SCC1 or SCC2 */

-#ifdef CONFIG_SCC1_ENET		/* Probably 860 variant */
+#if defined(CONFIG_SCC1_ENET) || defined(CONFIG_MPC8xx_SECOND_ETH_SCC1)		/* Probably 860
variant */
  /* Bits in parallel I/O port registers that have to be set/cleared
   * to configure the pins for SCC1 use.
   * TCLK - CLK1, RCLK - CLK2.
diff --git a/arch/ppc/platforms/mpc866ads_setup.c b/arch/ppc/platforms/mpc866ads_setup.c
new file mode 100644
index 0000000..6ffdb0e
--- /dev/null
+++ b/arch/ppc/platforms/mpc866ads_setup.c
@@ -0,0 +1,290 @@
+/*arch/ppc/platforms/mpc885ads-setup.c
+ *
+ * Platform setup for the Freescale mpc885ads board
+ *
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * Copyright 2005 MontaVista Software Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+
+#include <linux/fs_enet_pd.h>
+#include <linux/mii.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/ppcboot.h>
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+#include <asm/ppc_sys.h>
+#include <asm/mpc8xx.h>
+
+extern unsigned char __res[];
+
+/* access ports */
+#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) |  (_v))
+#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) & ~(_v))
+
+#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) |  (_v))
+#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) & ~(_v))
+
+static struct fs_mii_bus_info fec_mii_bus_info = {
+	.method = fsmii_fec,
+	.id = 0,
+};
+
+static struct fs_mii_bus_info scc_mii_bus_info = {
+	.method = fsmii_fixed,
+	.id = 0,
+	.i.fixed.speed = 10,
+	.i.fixed.duplex = 0,
+};
+
+static struct fs_platform_info mpc8xx_fec_pdata[] = {
+	{
+	 .rx_ring = 128,
+	 .tx_ring = 16,
+	 .rx_copybreak = 240,
+
+	 .use_napi = 1,
+	 .napi_weight = 17,
+
+	 .phy_addr = 15,
+	 .phy_irq = -1,
+
+	 .use_rmii = 0,
+
+	 .bus_info = &fec_mii_bus_info,
+	 }
+};
+
+static struct fs_platform_info mpc8xx_scc_pdata = {
+	.rx_ring = 64,
+	.tx_ring = 8,
+	.rx_copybreak = 240,
+
+	.use_napi = 1,
+	.napi_weight = 17,
+
+	.phy_addr = -1,
+	.phy_irq = -1,
+
+	.bus_info = &scc_mii_bus_info,
+};
+
+static void mpc866_nonplatform_device_init(void)
+{
+	volatile cpm8xx_t *cp = cpmp;
+	unsigned *bcsr_io;
+
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR1\n");
+		return;
+	}
+#ifdef CONFIG_SERIAL_CPM_SMC1
+	cp->cp_simode &= ~(0xe0000000 >> 17);	/* brg1 */
+	out_be32(bcsr_io, in_be32(bcsr_io) & ~(0x80000000 >> 7));
+#else
+	out_be32(bcsr_io, in_be32(bcsr_io) | (0x80000000 >> 7));
+	cp->cp_pbpar &= ~(0x000000c0);
+	cp->cp_pbdir |= 0x000000c0;
+	cp->cp_smc[0].smc_smcmr = 0;
+	cp->cp_smc[0].smc_smce = 0;
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SMC2
+	cp->cp_simode &= ~(0xe0000000 >> 1);
+	cp->cp_simode |= (0x20000000 >> 1);	/* brg2 */
+	out_be32(bcsr_io, in_be32(bcsr_io) & ~(0x80000000 >> 13));
+#else
+	out_be32(bcsr_io, in_be32(bcsr_io) | (0x80000000 >> 13));
+	cp->cp_pbpar &= ~(0x00000c00);
+	cp->cp_pbdir |= 0x00000c00;
+	cp->cp_smc[1].smc_smcmr = 0;
+	cp->cp_smc[1].smc_smce = 0;
+#endif
+	iounmap(bcsr_io);
+}
+
+static void setup_fec1_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+
+	setbits16(immap->im_ioport.iop_pdpar, 0x1fff);
+	setbits16(immap->im_ioport.iop_pddir, 0x1fff);
+}
+
+static void setup_scc1_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+	unsigned *bcsr_io;
+
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR1\n");
+		return;
+	}
+
+	/* Enable the PHY.
+	 */
+	out_be32(bcsr_io, in_be32(bcsr_io) & ~BCSR1_ETHEN);
+
+	/* Configure port A pins for Txd and Rxd.
+	 */
+	/* Disable receive and transmit in case EPPC-Bug started it.
+	 */
+	setbits16(immap->im_ioport.iop_papar, PA_ENET_RXD | PA_ENET_TXD);
+	clrbits16(immap->im_ioport.iop_padir, PA_ENET_RXD | PA_ENET_TXD);
+	clrbits16(immap->im_ioport.iop_paodr, PA_ENET_TXD);
+
+	/* Configure port C pins to enable CLSN and RENA.
+	 */
+	clrbits16(immap->im_ioport.iop_pcpar, PC_ENET_CLSN | PC_ENET_RENA);
+	clrbits16(immap->im_ioport.iop_pcdir, PC_ENET_CLSN | PC_ENET_RENA);
+	setbits16(immap->im_ioport.iop_pcso, PC_ENET_CLSN | PC_ENET_RENA);
+	/* Configure port A for TCLK and RCLK.
+	 */
+	setbits16(immap->im_ioport.iop_papar, PA_ENET_TCLK | PA_ENET_RCLK);
+	clrbits16(immap->im_ioport.iop_padir, PA_ENET_TCLK | PA_ENET_RCLK);
+	clrbits32(immap->im_cpm.cp_pbpar, PB_ENET_TENA);
+	clrbits32(immap->im_cpm.cp_pbdir, PB_ENET_TENA);
+
+	/* Configure Serial Interface clock routing.
+	 * First, clear all SCC bits to zero, then set the ones we want.
+	 */
+	clrbits32(immap->im_cpm.cp_sicr, SICR_ENET_MASK);
+	setbits32(immap->im_cpm.cp_sicr, SICR_ENET_CLKRT);
+
+	/* In the original SCC enet driver the following code is placed at the end of the
initialization */
+	setbits32(immap->im_cpm.cp_pbpar, PB_ENET_TENA);
+	setbits32(immap->im_cpm.cp_pbdir, PB_ENET_TENA);
+
+}
+
+static void mpc866ads_fixup_enet_pdata(struct platform_device *pdev,
+					      int fs_no)
+{
+	struct fs_platform_info *fpi = pdev->dev.platform_data;
+
+	volatile cpm8xx_t *cp;
+	bd_t *bd = (bd_t *) __res;
+	char *e;
+	int i;
+
+	/* Get pointer to Communication Processor */
+	cp = cpmp;
+	switch (fs_no) {
+	case fsid_fec1:
+		fpi = &mpc8xx_fec_pdata[0];
+		fpi->init_ioports = &setup_fec1_ioports;
+
+		break;
+	case fsid_scc1:
+		fpi = &mpc8xx_scc_pdata;
+		fpi->init_ioports = &setup_scc1_ioports;
+
+		break;
+	default:
+		break;
+	}
+
+	pdev->dev.platform_data = fpi;
+	fpi->fs_no = fs_no;
+
+	e = (unsigned char *)&bd->bi_enetaddr;
+	for (i = 0; i < 6; i++)
+		fpi->macaddr[i] = *e++;
+
+	fpi->macaddr[5 - pdev->id]++;
+
+}
+
+static void mpc866ads_fixup_fec_enet_pdata(struct platform_device *pdev,
+						  int idx)
+{
+	/* This is for FEC devices only */
+	if (strcmp(pdev->name, "fsl-cpm-fec"))
+		return;
+	mpc866ads_fixup_enet_pdata(pdev, fsid_fec1 + pdev->id - 1);
+}
+
+static void mpc866ads_fixup_scc_enet_pdata(struct platform_device *pdev,
+						  int idx)
+{
+	/* This is for SCC devices only */
+	if (strcmp(pdev->name, "fsl-cpm-scc"))
+		return;
+
+	mpc866ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
+}
+
+static int mpc866ads_platform_notify(struct device *dev)
+{
+	static struct {
+		const char *bus_id;
+		void (*rtn) (struct platform_device * pdev, int idx);
+	} dev_map[] = {
+		{
+		"fsl-cpm-fec", mpc866ads_fixup_fec_enet_pdata}, {
+	"fsl-cpm-scc", mpc866ads_fixup_scc_enet_pdata},};
+	struct platform_device *pdev;
+	int i, j, idx;
+	const char *s;
+	if (dev && dev->bus_id)
+		for (i = 0; i < ARRAY_SIZE(dev_map); i++) {
+			idx = -1;
+
+			if ((s = strrchr(dev->bus_id, '.')) != NULL)
+				idx = (int)simple_strtol(s + 1, NULL, 10);
+			else
+				s = dev->bus_id;
+			j = s - dev->bus_id;
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id, j)) {
+				pdev =
+				    container_of(dev, struct platform_device,
+						 dev);
+				dev_map[i].rtn(pdev, idx);
+			}
+		}
+	return 0;
+}
+
+int __init mpc866ads_init(void)
+{
+	printk(KERN_NOTICE "mpc866ads: Init\n");
+
+	mpc866_nonplatform_device_init();
+	platform_notify = mpc866ads_platform_notify;
+
+	identify_ppc_sys_by_name(BOARD_CHIP_NAME);
+
+	ppc_sys_device_remove(MPC8xx_CPM_FEC2);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC3);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC2);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC4);
+	ppc_sys_device_remove(MPC8xx_CPM_SMC1);
+	ppc_sys_device_remove(MPC8xx_CPM_SMC2);
+
+	return 0;
+}
+
+arch_initcall(mpc866ads_init);
diff --git a/arch/ppc/platforms/mpc885ads_setup.c b/arch/ppc/platforms/mpc885ads_setup.c
new file mode 100644
index 0000000..37c5c7b
--- /dev/null
+++ b/arch/ppc/platforms/mpc885ads_setup.c
@@ -0,0 +1,408 @@
+/*arch/ppc/platforms/mpc885ads-setup.c
+ *
+ * Platform setup for the Freescale mpc885ads board
+ *
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ *
+ * Copyright 2005 MontaVista Software Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/ioport.h>
+#include <linux/device.h>
+
+#include <linux/fs_enet_pd.h>
+#include <linux/mii.h>
+
+#include <asm/delay.h>
+#include <asm/io.h>
+#include <asm/machdep.h>
+#include <asm/page.h>
+#include <asm/processor.h>
+#include <asm/system.h>
+#include <asm/time.h>
+#include <asm/ppcboot.h>
+#include <asm/8xx_immap.h>
+#include <asm/commproc.h>
+#include <asm/ppc_sys.h>
+
+extern unsigned char __res[];
+
+/* access ports */
+#define setbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) |  (_v))
+#define clrbits32(_addr, _v) out_be32(&(_addr), in_be32(&(_addr)) & ~(_v))
+
+#define setbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) |  (_v))
+#define clrbits16(_addr, _v) out_be16(&(_addr), in_be16(&(_addr)) & ~(_v))
+
+void __init mpc885ads_scc_phy_init(char);
+
+static struct fs_mii_bus_info fec_mii_bus_info = {
+	.method = fsmii_fec,
+	.id = 0,
+};
+
+static struct fs_mii_bus_info scc_mii_bus_info = {
+#ifdef CONFIG_SCC_ENET_8xx_FIXED
+	.method = fsmii_fixed,
+#else
+	.method = fsmii_fec,
+#endif
+
+	.id = 0,
+};
+
+static struct fs_platform_info mpc8xx_fec_pdata[] = {
+	{
+	 .rx_ring = 128,
+	 .tx_ring = 16,
+	 .rx_copybreak = 240,
+
+	 .use_napi = 1,
+	 .napi_weight = 17,
+
+	 .phy_addr = 0,
+	 .phy_irq = SIU_IRQ7,
+
+	 .bus_info = &fec_mii_bus_info,
+	 }, {
+	     .rx_ring = 128,
+	     .tx_ring = 16,
+	     .rx_copybreak = 240,
+
+	     .use_napi = 1,
+	     .napi_weight = 17,
+
+	     .phy_addr = 1,
+	     .phy_irq = SIU_IRQ7,
+
+	     .bus_info = &fec_mii_bus_info,
+	     }
+};
+
+static struct fs_platform_info mpc8xx_scc_pdata = {
+	.rx_ring = 64,
+	.tx_ring = 8,
+	.rx_copybreak = 240,
+
+	.use_napi = 1,
+	.napi_weight = 17,
+
+	.phy_addr = 2,
+#ifdef CONFIG_MPC8xx_SCC_ENET_FIXED
+	.phy_irq = -1,
+#else
+	.phy_irq = SIU_IRQ7,
+#endif
+
+	.bus_info = &scc_mii_bus_info,
+};
+
+static void mpc885_nonplatform_device_init(void)
+{
+	volatile cpm8xx_t *cp = cpmp;
+	unsigned *bcsr_io;
+
+#ifdef CONFIG_FS_ENET
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+#endif
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR\n");
+		return;
+	}
+#ifdef CONFIG_SERIAL_CPM_SMC1
+	cp->cp_simode &= ~(0xe0000000 >> 17);	/* brg1 */
+	out_be32(bcsr_io, in_be32(bcsr_io) & ~BCSR1_RS232EN_1);
+#else
+	out_be32(bcsr_io, in_be32(bcsr_io) | BCSR1_RS232EN_1);
+	cp->cp_smc[0].smc_smcmr = 0;
+	cp->cp_smc[0].smc_smce = 0;
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SMC2
+	cp->cp_simode &= ~(0xe0000000 >> 1);
+	cp->cp_simode |= (0x20000000 >> 1);	/* brg2 */
+	out_be32(bcsr_io, in_be32(bcsr_io) & ~BCSR1_RS232EN_2);
+#else
+	out_be32(bcsr_io, in_be32(bcsr_io) | BCSR1_RS232EN_2);
+	cp->cp_smc[1].smc_smcmr = 0;
+	cp->cp_smc[1].smc_smce = 0;
+#endif
+	iounmap(bcsr_io);
+
+#ifdef CONFIG_FS_ENET
+	/* use MDC for MII (common) */
+	setbits16(immap->im_ioport.iop_pdpar, 0x0080);
+	clrbits16(immap->im_ioport.iop_pddir, 0x0080);
+#endif
+}
+
+static void setup_fec1_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+
+	/* configure FEC1 pins  */
+	setbits16(immap->im_ioport.iop_papar, 0xf830);
+	setbits16(immap->im_ioport.iop_padir, 0x0830);
+	clrbits16(immap->im_ioport.iop_padir, 0xf000);
+	setbits32(immap->im_cpm.cp_pbpar, 0x00001001);
+
+	clrbits32(immap->im_cpm.cp_pbdir, 0x00001001);
+	setbits16(immap->im_ioport.iop_pcpar, 0x000c);
+	clrbits16(immap->im_ioport.iop_pcdir, 0x000c);
+	setbits32(immap->im_cpm.cp_pepar, 0x00000003);
+
+	setbits32(immap->im_cpm.cp_pedir, 0x00000003);
+	clrbits32(immap->im_cpm.cp_peso, 0x00000003);
+	clrbits32(immap->im_cpm.cp_cptr, 0x00000100);
+}
+
+static void setup_fec2_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+
+	/* configure FEC2 pins */
+	setbits32(immap->im_cpm.cp_pepar, 0x0003fffc);
+	setbits32(immap->im_cpm.cp_pedir, 0x0003fffc);
+	setbits32(immap->im_cpm.cp_peso, 0x00037800);
+	clrbits32(immap->im_cpm.cp_peso, 0x000087fc);
+	clrbits32(immap->im_cpm.cp_cptr, 0x00000080);
+}
+
+static void setup_scc3_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+	unsigned *bcsr_io;
+
+	bcsr_io = ioremap(BCSR_ADDR, BCSR_SIZE);
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR\n");
+		return;
+	}
+
+	/* Enable the PHY.
+	 */
+	out_be32(bcsr_io + 4, in_be32(bcsr_io + 4) | BCSR4_ETH10_RST);
+
+	/* Configure port A pins for Txd and Rxd.
+	 */
+	setbits16(immap->im_ioport.iop_papar, PA_ENET_RXD | PA_ENET_TXD);
+	clrbits16(immap->im_ioport.iop_padir, PA_ENET_RXD | PA_ENET_TXD);
+
+	/* Configure port C pins to enable CLSN and RENA.
+	 */
+	clrbits16(immap->im_ioport.iop_pcpar, PC_ENET_CLSN | PC_ENET_RENA);
+	clrbits16(immap->im_ioport.iop_pcdir, PC_ENET_CLSN | PC_ENET_RENA);
+	setbits16(immap->im_ioport.iop_pcso, PC_ENET_CLSN | PC_ENET_RENA);
+
+	/* Configure port E for TCLK and RCLK.
+	 */
+	setbits32(immap->im_cpm.cp_pepar, PE_ENET_TCLK | PE_ENET_RCLK);
+	clrbits32(immap->im_cpm.cp_pepar, PE_ENET_TENA);
+	clrbits32(immap->im_cpm.cp_pedir,
+		  PE_ENET_TCLK | PE_ENET_RCLK | PE_ENET_TENA);
+	clrbits32(immap->im_cpm.cp_peso, PE_ENET_TCLK | PE_ENET_RCLK);
+	setbits32(immap->im_cpm.cp_peso, PE_ENET_TENA);
+
+	/* Configure Serial Interface clock routing.
+	 * First, clear all SCC bits to zero, then set the ones we want.
+	 */
+	clrbits32(immap->im_cpm.cp_sicr, SICR_ENET_MASK);
+	setbits32(immap->im_cpm.cp_sicr, SICR_ENET_CLKRT);
+
+	/* Disable Rx and Tx. SMC1 sshould be stopped if SCC3 eternet are used.
+	 */
+	immap->im_cpm.cp_smc[0].smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
+	/* On the MPC885ADS SCC ethernet PHY is initialized in the full duplex mode
+	 * by H/W setting after reset. SCC ethernet controller support only half duplex.
+	 * This discrepancy of modes causes a lot of carrier lost errors.
+	 */
+
+	/* In the original SCC enet driver the following code is placed at the end of the
initialization */
+	setbits32(immap->im_cpm.cp_pepar, PE_ENET_TENA);
+	clrbits32(immap->im_cpm.cp_pedir, PE_ENET_TENA);
+	setbits32(immap->im_cpm.cp_peso, PE_ENET_TENA);
+
+	out_be32(bcsr_io + 1, in_be32(bcsr_io + 1) | BCSR1_ETHEN);
+	iounmap(bcsr_io);
+}
+
+static void mpc885ads_fixup_enet_pdata(struct platform_device *pdev,
+					      int fs_no)
+{
+	struct fs_platform_info *fpi = pdev->dev.platform_data;
+
+	volatile cpm8xx_t *cp;
+	bd_t *bd = (bd_t *) __res;
+	char *e;
+	int i;
+
+	/* Get pointer to Communication Processor */
+	cp = cpmp;
+	switch (fs_no) {
+	case fsid_fec1:
+		fpi = &mpc8xx_fec_pdata[0];
+		fpi->init_ioports = &setup_fec1_ioports;
+		break;
+	case fsid_fec2:
+		fpi = &mpc8xx_fec_pdata[1];
+		fpi->init_ioports = &setup_fec2_ioports;
+		break;
+	case fsid_scc3:
+		fpi = &mpc8xx_scc_pdata;
+		fpi->init_ioports = &setup_scc3_ioports;
+		mpc885ads_scc_phy_init(fpi->phy_addr);
+		break;
+	default:
+		break;
+	}
+
+	pdev->dev.platform_data = fpi;
+	fpi->fs_no = fs_no;
+
+	e = (unsigned char *)&bd->bi_enetaddr;
+	for (i = 0; i < 6; i++)
+		fpi->macaddr[i] = *e++;
+
+	fpi->macaddr[5 - pdev->id]++;
+
+}
+
+static void mpc885ads_fixup_fec_enet_pdata(struct platform_device *pdev,
+						  int idx)
+{
+	/* This is for FEC devices only */
+	if (!strstr(pdev->name, "fsl-cpm-fec"))
+		return;
+	mpc885ads_fixup_enet_pdata(pdev, fsid_fec1 + pdev->id - 1);
+}
+
+static void __init mpc885ads_fixup_scc_enet_pdata(struct platform_device *pdev,
+						  int idx)
+{
+	/* This is for SCC devices only */
+	if (!strstr(pdev->name, "fsl-cpm-scc"))
+		return;
+
+	mpc885ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
+}
+
+/* SCC ethernet controller does not have MII management channel. FEC1 MII
+ * channel is used to communicate with the 10Mbit PHY.
+ */
+
+#define MII_ECNTRL_PINMUX        0x4
+#define FEC_ECNTRL_PINMUX        0x00000004
+#define FEC_RCNTRL_MII_MODE        0x00000004
+
+/* Make MII read/write commands.
+ */
+#define mk_mii_write(REG, VAL, PHY_ADDR)    (0x50020000 | (((REG) & 0x1f) << 18) | \
+                ((VAL) & 0xffff) | ((PHY_ADDR) << 23))
+
+static void mpc885ads_scc_phy_init(char phy_addr)
+{
+	volatile immap_t *immap;
+	volatile fec_t *fecp;
+	bd_t *bd;
+
+	bd = (bd_t *) __res;
+	immap = (immap_t *) IMAP_ADDR;	/* pointer to internal registers */
+	fecp = &(immap->im_cpm.cp_fec);
+
+	/* Enable MII pins of the FEC1
+	 */
+	setbits16(immap->im_ioport.iop_pdpar,0x0080);
+	clrbits16(immap->im_ioport.iop_pddir,0x0080);
+	/* Set MII speed to 2.5 MHz
+	 */
+	out_be32(&fecp->fec_mii_speed,
+		 ((((bd->bi_intfreq + 4999999) / 2500000) / 2) & 0x3F) << 1);
+
+	/* Enable FEC pin MUX
+	 */
+	setbits32(fecp->fec_ecntrl, MII_ECNTRL_PINMUX);
+	setbits32(fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
+
+	out_be32(&fecp->fec_mii_data, mk_mii_write(MII_BMCR, BMCR_ISOLATE, phy_addr));
+	udelay(100);
+	out_be32(&fecp->fec_mii_data,
+		 mk_mii_write(MII_ADVERTISE,
+			      ADVERTISE_10HALF | ADVERTISE_CSMA,phy_addr));
+	udelay(100);
+
+	/* Disable FEC MII settings
+	 */
+	clrbits32(fecp->fec_ecntrl, MII_ECNTRL_PINMUX);
+	clrbits32(fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
+	out_be32(&fecp->fec_mii_speed, 0);
+}
+
+static int mpc885ads_platform_notify(struct device *dev)
+{
+	static struct {
+		const char *bus_id;
+		void (*rtn) (struct platform_device * pdev, int idx);
+	} dev_map[] = {
+		{
+		"fsl-cpm-fec", mpc885ads_fixup_fec_enet_pdata}, {
+	"fsl-cpm-scc", mpc885ads_fixup_scc_enet_pdata},};
+	struct platform_device *pdev;
+	int i, j, idx;
+	const char *s;
+	if (dev && dev->bus_id)
+		for (i = 0; i < ARRAY_SIZE(dev_map); i++) {
+			idx = -1;
+
+			if ((s = strrchr(dev->bus_id, '.')) != NULL)
+				idx = (int)simple_strtol(s + 1, NULL, 10);
+			else
+				s = dev->bus_id;
+			j = s - dev->bus_id;
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id, j)) {
+				pdev =
+				    container_of(dev, struct platform_device,
+						 dev);
+				dev_map[i].rtn(pdev, idx);
+			}
+		}
+	return 0;
+}
+
+int __init mpc885ads_init(void)
+{
+	printk(KERN_NOTICE "mpc885ads: Init\n");
+
+	mpc885_nonplatform_device_init();
+	platform_notify = mpc885ads_platform_notify;
+
+	identify_ppc_sys_by_name(BOARD_CHIP_NAME);
+
+#ifdef CONFIG_MPC8xx_SECOND_ETH_SCC3
+	ppc_sys_device_remove(MPC8xx_CPM_FEC2);
+#endif
+#ifdef CONFIG_MPC8xx_SECOND_ETH_FEC2
+	ppc_sys_device_remove(MPC8xx_CPM_SCC3);
+#endif
+
+	ppc_sys_device_remove(MPC8xx_CPM_SCC1);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC2);
+	ppc_sys_device_remove(MPC8xx_CPM_SCC4);
+	ppc_sys_device_remove(MPC8xx_CPM_SMC1);
+	ppc_sys_device_remove(MPC8xx_CPM_SMC2);
+
+	return 0;
+}
+
+arch_initcall(mpc885ads_init);
---
Sincerely,
Vitaly
