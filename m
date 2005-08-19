Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 11A82680BE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Aug 2005 00:37:34 +1000 (EST)
Message-ID: <4305EEAC.4050407@ru.mvista.com>
Date: Fri, 19 Aug 2005 18:37:32 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Kumar Gala <galak@freescale.com>
Content-Type: multipart/mixed; boundary="------------070003040405010004060908"
Cc: Pantelis Antoniou <pantelis.antoniou@gmail.com>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [RFC][PATCH] board-specific platform setup for mpc8272
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
--------------070003040405010004060908
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit

This is platform setup for MPC8272ADS to use it with fs_enet driver. 
Assumes that [PATCH] ppc32: Add ppc_sys descriptions for PowerQUICC II 
devices is applied. This is not in the final state (since fs_enet will 
be modified a bit),but it could be useful if someone does want to test 
fs_enet on the likewise board.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>

-- 
Sincerely,
Vitaly

--------------070003040405010004060908
Content-Type: text/x-patch;
 name="mpc8272_platform_bsp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mpc8272_platform_bsp.patch"

diff --git a/arch/ppc/platforms/Makefile b/arch/ppc/platforms/Makefile
--- a/arch/ppc/platforms/Makefile
+++ b/arch/ppc/platforms/Makefile
@@ -19,6 +19,8 @@ ifeq ($(CONFIG_PPC_PMAC),y)
 obj-$(CONFIG_NVRAM)		+= pmac_nvram.o
 obj-$(CONFIG_CPU_FREQ_PMAC)	+= pmac_cpufreq.o
 endif
+
+obj-$(CONFIG_ADS8272)		+= mpc8272ads_setup.o
 obj-$(CONFIG_PMAC_BACKLIGHT)	+= pmac_backlight.o
 obj-$(CONFIG_PREP_RESIDUAL)	+= residual.o
 obj-$(CONFIG_ADIR)		+= adir_setup.o adir_pic.o adir_pci.o
diff --git a/arch/ppc/platforms/mpc8272ads_setup.c b/arch/ppc/platforms/mpc8272ads_setup.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/mpc8272ads_setup.c
@@ -0,0 +1,237 @@
+/*
+ * arch/ppc/platforms/82xx/pq2ads_pd.c
+ *
+ * MPC82xx Board-specific PlatformDevice descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/ioport.h>
+#include <linux/fs_enet_pd.h>
+
+#include <asm/io.h>
+#include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+#include <asm/immap_cpm2.h>
+#include <asm/irq.h>
+#include <asm/ppc_sys.h>
+#include <asm/ppcboot.h>
+
+#include "pq2ads_pd.h"
+
+static struct fs_mii_bus_info mii_bus_info = {
+	.method                 = fsmii_bitbang,
+	.id                     = 0,
+	.i.bitbang = {
+		.mdio_port	= fsiop_portc,
+		.mdio_bit	= 18,
+		.mdc_port	= fsiop_portc,
+		.mdc_bit	= 19,
+		.delay		= 1,
+	},
+};
+
+static struct fs_platform_info mpc82xx_fcc1_pdata = {
+	.fs_no		= fsid_fcc1,
+	.cp_page	= CPM_CR_FCC1_PAGE,
+	.cp_block 	= CPM_CR_FCC1_SBLOCK,
+	.clk_trx 	= (PC_F1RXCLK | PC_F1TXCLK),
+	.clk_route	= CMX1_CLK_ROUTE,
+	.clk_mask	= CMX1_CLK_MASK,
+
+		
+	.phy_addr	= 0,
+#ifdef PHY_INTERRUPT
+	.phy_irq	= PHY_INTERRUPT,
+#endif
+	.mem_offset	= FCC1_MEM_OFFSET,
+	.bus_info	= &mii_bus_info,
+	.rx_ring	= 32,
+	.tx_ring	= 32,
+	.rx_copybreak	= 240,
+	.use_napi	= 0,
+	.napi_weight	= 17,
+};
+
+static struct fs_platform_info mpc82xx_fcc2_pdata = {
+	.fs_no		= fsid_fcc2,
+	.cp_page	= CPM_CR_FCC2_PAGE,
+	.cp_block 	= CPM_CR_FCC2_SBLOCK,
+	.clk_trx 	= (PC_F2RXCLK | PC_F2TXCLK),
+	.clk_route	= CMX2_CLK_ROUTE,
+	.clk_mask	= CMX2_CLK_MASK,
+	
+	.phy_addr	= 3,
+#ifdef PHY_INTERRUPT
+	.phy_irq	= PHY_INTERRUPT,
+#endif
+
+	.mem_offset	= FCC2_MEM_OFFSET,
+	.bus_info	= &mii_bus_info,
+	.rx_ring	= 32,
+	.tx_ring	= 32,
+	.rx_copybreak	= 240,
+	.use_napi	= 0,
+	.napi_weight	= 17,
+};
+
+/* Initialize the I/O pins for the FCC Ethernet. */
+static void init_fcc_ioports(void)
+{
+	struct immap *immap;
+	struct io_port *io;
+	u32 tempval;
+
+	immap = cpm2_immr;
+
+	io = &immap->im_ioport;
+	/* FCC1 pins are on port A/C.  FCC2/3 are port B/C. */
+	/* Configure port A and C pins for FCC1 Ethernet. */
+	tempval = in_be32(&io->iop_pdira);
+	tempval &= ~PA1_DIRA0;
+	tempval |= PA1_DIRA1;
+	out_be32(&io->iop_pdira, tempval);
+
+	tempval = in_be32(&io->iop_psora);
+	tempval &= ~PA1_PSORA0;
+	tempval |= PA1_PSORA1;
+	out_be32(&io->iop_psora, tempval);
+
+	tempval = in_be32(&io->iop_ppara);
+	tempval |= (PA1_DIRA0 | PA1_DIRA1);
+	out_be32(&io->iop_ppara, tempval);
+
+	tempval = in_be32(&io->iop_pdirb);
+	tempval &= ~PB2_DIRB0;
+	tempval |= PB2_DIRB1;
+	out_be32(&io->iop_pdirb, tempval);
+
+	tempval = in_be32(&io->iop_psorb);
+	tempval &= ~PB2_PSORB0;
+	tempval |= PB2_PSORB1;
+	out_be32(&io->iop_psorb, tempval);
+
+	tempval = in_be32(&io->iop_pparb);
+	tempval |= (PB2_DIRB0 | PB2_DIRB1);
+	out_be32(&io->iop_pparb, tempval);
+
+	/* Port C has clocks...... */
+	tempval = in_be32(&io->iop_psorc);
+	tempval &= ~(CLK_TRX);
+	out_be32(&io->iop_psorc, tempval);
+
+	tempval = in_be32(&io->iop_pdirc);
+	tempval &= ~(CLK_TRX);
+	out_be32(&io->iop_pdirc, tempval);
+
+	tempval = in_be32(&io->iop_pparc);
+	tempval |= (CLK_TRX);
+	out_be32(&io->iop_pparc, tempval);
+
+	/* ....and the MII serial clock/data. */
+	io->iop_pdatc |= (PC_MDIO | PC_MDCK);
+	io->iop_podrc &= ~(PC_MDIO | PC_MDCK);
+	io->iop_pdirc |= (PC_MDIO | PC_MDCK);
+	io->iop_pparc &= ~(PC_MDIO | PC_MDCK);
+
+	/* Configure Serial Interface clock routing.
+	 * First, clear all FCC bits to zero,
+	 * then set the ones we want.
+	 */
+	immap->im_cpmux.cmx_fcr &= ~(CPMUX_CLK_MASK);
+	immap->im_cpmux.cmx_fcr |= CPMUX_CLK_ROUTE;
+}
+
+
+static void __init mpc8272ads_fixup_enet_pdata(struct platform_device *pdev,
+					      int idx)
+{
+	bd_t* bi = (void*)__res;
+	cpm2_map_t* immr = (cpm2_map_t *)CPM_MAP_ADDR;
+	int fs_no = fsid_fcc1+pdev->id-1;
+
+	/*all-in-one for now*/
+	init_fcc_ioports();
+	
+	mpc82xx_fcc1_pdata.dpram_offset = mpc82xx_fcc2_pdata.dpram_offset = (u32)immr->im_dprambase;
+	mpc82xx_fcc1_pdata.fcc_regs_c = mpc82xx_fcc2_pdata.fcc_regs_c = (u32)immr->im_fcc_c;
+	
+	/* At last wi fill the platform_data pointers with respective data */
+	switch(fs_no) {
+		case fsid_fcc1:
+			memcpy(&mpc82xx_fcc1_pdata.macaddr,bi->bi_enetaddr,6);
+			pdev->dev.platform_data = &mpc82xx_fcc1_pdata;
+		break;
+		case fsid_fcc2:
+			memcpy(&mpc82xx_fcc2_pdata.macaddr,bi->bi_enetaddr,6);
+			mpc82xx_fcc2_pdata.macaddr[5] ^= 1;
+			pdev->dev.platform_data = &mpc82xx_fcc2_pdata;
+		break;
+	}
+}
+
+static int __init mpc8272ads_platform_notify(struct device *dev)
+{
+	static struct {
+		const char *bus_id;
+		void (*rtn) (struct platform_device * pdev, int idx);
+	} dev_map[] = {
+		{"fsl-cpm-fcc", mpc8272ads_fixup_enet_pdata}, 
+	};
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
+int __init mpc8272ads_init(void)
+{
+	cpm2_map_t* immr = (cpm2_map_t *)CPM_MAP_ADDR;
+
+	printk(KERN_NOTICE "mpc8272ads: Init\n");
+
+	platform_notify = mpc8272ads_platform_notify;
+
+	identify_ppc_sys_by_name_and_id(BOARD_NAME,cpm2_immr->im_memctl.memc_immr); 
+
+	identify_ppc_sys_by_name(BOARD_NAME);
+	
+	/*Remove stuff does not utilized platform way*/
+	ppc_sys_device_remove(MPC82xx_CPM_SCC1);
+	ppc_sys_device_remove(MPC82xx_CPM_SCC2);
+	ppc_sys_device_remove(MPC82xx_CPM_SCC3);
+	ppc_sys_device_remove(MPC82xx_CPM_SCC4);
+	ppc_sys_device_remove(MPC82xx_CPM_SMC1);
+	ppc_sys_device_remove(MPC82xx_CPM_SMC2);
+
+	return 0;
+}
+
+arch_initcall(mpc8272ads_init);
diff --git a/arch/ppc/platforms/pq2ads.h b/arch/ppc/platforms/pq2ads.h
--- a/arch/ppc/platforms/pq2ads.h
+++ b/arch/ppc/platforms/pq2ads.h
@@ -13,6 +13,10 @@
 
 #include <asm/ppcboot.h>
 
+#if defined(CONFIG_ADS8272)
+#define BOARD_NAME "8272"
+#endif
+
 /* Memory map is configured by the PROM startup.
  * We just map a few things we need.  The CSR is actually 4 byte-wide
  * registers that can be accessed as 8-, 16-, or 32-bit values.
diff --git a/arch/ppc/platforms/pq2ads_pd.h b/arch/ppc/platforms/pq2ads_pd.h
new file mode 100644
--- /dev/null
+++ b/arch/ppc/platforms/pq2ads_pd.h
@@ -0,0 +1,135 @@
+#ifndef __PQ2ADS_PD_H
+#define __PQ2ADS_PD_H
+/*
+ * arch/ppc/platforms/82xx/pq2ads_pd.h
+ *
+ * Some defines for MPC82xx board-specific PlatformDevice descriptions
+ *
+ * Maintainer: Kumar Gala <kumar.gala@freescale.com>
+ *
+ * 2005 (c) MontaVista Software, Inc. 
+ * Vitaly Bordug <vbordug@ru.mvista.com>
+ * 
+ * This file is licensed under the terms of the GNU General Public License 
+ * version 2. This program is licensed "as is" without any warranty of any 
+ * kind, whether express or implied.
+ */
+
+/* FCC1 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK9-12 */
+
+#define F1_RXCLK	11
+#define F1_TXCLK	10
+
+/* FCC2 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK13-16 */
+#define F2_RXCLK	15
+#define F2_TXCLK	16
+
+/* FCC3 Clock Source Configuration.  These can be redefined in the board specific file.
+   Can only choose from CLK13-16 */
+#define F3_RXCLK	15
+#define F3_TXCLK	16
+
+/* MDIO and MDCK settings. These can be redefined in the board specific file.*/
+#define PC_MDIO		0x00002000U
+#define PC_MDCK		0x00001000U
+
+/* Automatically generates register configurations */
+#define PC_CLK(x)	((uint)(1<<(x-1)))	/* FCC CLK I/O ports */
+
+#define CMXFCR_RF1CS(x)	((uint)((x-5)<<27))	/* FCC1 Receive Clock Source */
+#define CMXFCR_TF1CS(x)	((uint)((x-5)<<24))	/* FCC1 Transmit Clock Source */
+#define CMXFCR_RF2CS(x)	((uint)((x-9)<<19))	/* FCC2 Receive Clock Source */
+#define CMXFCR_TF2CS(x) ((uint)((x-9)<<16))	/* FCC2 Transmit Clock Source */
+#define CMXFCR_RF3CS(x)	((uint)((x-9)<<11))	/* FCC3 Receive Clock Source */
+#define CMXFCR_TF3CS(x) ((uint)((x-9)<<8))	/* FCC3 Transmit Clock Source */
+
+#define PC_F1RXCLK	PC_CLK(F1_RXCLK)
+#define PC_F1TXCLK	PC_CLK(F1_TXCLK)
+#define CMX1_CLK_ROUTE	(CMXFCR_RF1CS(F1_RXCLK) | CMXFCR_TF1CS(F1_TXCLK))
+#define CMX1_CLK_MASK	((uint)0xff000000)
+
+#define PC_F2RXCLK	PC_CLK(F2_RXCLK)
+#define PC_F2TXCLK	PC_CLK(F2_TXCLK)
+#define CMX2_CLK_ROUTE	(CMXFCR_RF2CS(F2_RXCLK) | CMXFCR_TF2CS(F2_TXCLK))
+#define CMX2_CLK_MASK	((uint)0x00ff0000)
+
+#define PC_F3RXCLK	PC_CLK(F3_RXCLK)
+#define PC_F3TXCLK	PC_CLK(F3_TXCLK)
+#define CMX3_CLK_ROUTE	(CMXFCR_RF3CS(F3_RXCLK) | CMXFCR_TF3CS(F3_TXCLK))
+#define CMX3_CLK_MASK	((uint)0x0000ff00)
+
+/* Some board-specific defines here... Temporary I hope -vb*/
+#ifdef CONFIG_ADS8272
+#define CPMUX_CLK_MASK (CMX1_CLK_MASK | CMX2_CLK_MASK)
+#define CPMUX_CLK_ROUTE (CMX1_CLK_ROUTE | CMX2_CLK_ROUTE)
+#else
+#error You need to define cpmux setup for your board
+#endif
+
+#ifdef CONFIG_ADS8272
+#define CLK_TRX (F1_TXCLK | F1_TXCLK | F2_TXCLK | F2_RXCLK)
+#else
+#error You need to define clock source for your board
+#endif
+
+
+/* I/O Pin assignment for FCC1.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PA1_COL		0x00000001U
+#define PA1_CRS		0x00000002U
+#define PA1_TXER	0x00000004U
+#define PA1_TXEN	0x00000008U
+#define PA1_RXDV	0x00000010U
+#define PA1_RXER	0x00000020U
+#define PA1_TXDAT	0x00003c00U
+#define PA1_RXDAT	0x0003c000U
+#define PA1_PSORA0	(PA1_RXDAT | PA1_TXDAT)
+#define PA1_PSORA1	(PA1_COL | PA1_CRS | PA1_TXER | PA1_TXEN | \
+		PA1_RXDV | PA1_RXER)
+#define PA1_DIRA0	(PA1_RXDAT | PA1_CRS | PA1_COL | PA1_RXER | PA1_RXDV)
+#define PA1_DIRA1	(PA1_TXDAT | PA1_TXEN | PA1_TXER)
+
+
+/* I/O Pin assignment for FCC2.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PB2_TXER	0x00000001U
+#define PB2_RXDV	0x00000002U
+#define PB2_TXEN	0x00000004U
+#define PB2_RXER	0x00000008U
+#define PB2_COL		0x00000010U
+#define PB2_CRS		0x00000020U
+#define PB2_TXDAT	0x000003c0U
+#define PB2_RXDAT	0x00003c00U
+#define PB2_PSORB0	(PB2_RXDAT | PB2_TXDAT | PB2_CRS | PB2_COL | \
+		PB2_RXER | PB2_RXDV | PB2_TXER)
+#define PB2_PSORB1	(PB2_TXEN)
+#define PB2_DIRB0	(PB2_RXDAT | PB2_CRS | PB2_COL | PB2_RXER | PB2_RXDV)
+#define PB2_DIRB1	(PB2_TXDAT | PB2_TXEN | PB2_TXER)
+
+
+/* I/O Pin assignment for FCC3.  I don't yet know the best way to do this,
+ * but there is little variation among the choices.
+ */
+#define PB3_RXDV	0x00004000U
+#define PB3_RXER	0x00008000U
+#define PB3_TXER	0x00010000U
+#define PB3_TXEN	0x00020000U
+#define PB3_COL		0x00040000U
+#define PB3_CRS		0x00080000U
+#define PB3_TXDAT	0x0f000000U
+#define PB3_RXDAT	0x00f00000U
+#define PB3_PSORB0	(PB3_RXDAT | PB3_TXDAT | PB3_CRS | PB3_COL | \
+		PB3_RXER | PB3_RXDV | PB3_TXER | PB3_TXEN)
+#define PB3_PSORB1	0
+#define PB3_DIRB0	(PB3_RXDAT | PB3_CRS | PB3_COL | PB3_RXER | PB3_RXDV)
+#define PB3_DIRB1	(PB3_TXDAT | PB3_TXEN | PB3_TXER)
+
+#define FCC_MEM_OFFSET(x) (CPM_FCC_SPECIAL_BASE + (x*128))
+#define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0)
+#define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
+
+#endif

--------------070003040405010004060908--
