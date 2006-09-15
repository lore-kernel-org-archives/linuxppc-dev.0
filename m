Return-Path: <vbordug@ru.mvista.com>
Received: from localhost.localdomain (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 11EB767C7C
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Sep 2006 03:39:28 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 6/7] POWERPC: overhaul with cpm2_map mechanism
Date: Fri, 15 Sep 2006 21:39:19 +0400
Message-Id: <20060915173919.7984.20910.stgit@localhost.localdomain>
In-Reply-To: <20060915213751.128e85f3@localhost.localdomain>
References: <20060915213751.128e85f3@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Incorporating the new way of cpm2 immr access, introduced in the previous
patch, into CPM2 peripheral devices (fs_enet and cpm_uart). Both ppc and
powerpc approved working( real actions taken in powerpc only, ppc just
has a wrapper to keep init stuff consistent).

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/powerpc/platforms/85xx/mpc85xx_ads.c |  109 ++++++++++++++++-------------
 arch/powerpc/sysdev/cpm2_common.c         |   90 ++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.c             |    7 ++
 arch/ppc/platforms/mpc8272ads_setup.c     |    8 +-
 arch/ppc/platforms/mpc866ads_setup.c      |    8 +-
 arch/ppc/platforms/mpc885ads_setup.c      |   10 +--
 drivers/net/fs_enet/fs_enet-main.c        |    2 -
 drivers/serial/cpm_uart/cpm_uart_core.c   |    4 +
 include/asm-ppc/cpm2.h                    |   53 ++++++++++++++
 include/linux/fs_enet_pd.h                |   10 ++-
 include/linux/fs_uart_pd.h                |    4 +
 11 files changed, 235 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 7ebfe74..28070e7 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -33,6 +33,7 @@ #include <sysdev/fsl_soc.h>
 #include "mpc85xx.h"
 
 #ifdef CONFIG_CPM2
+#include <linux/fs_enet_pd.h>
 #include <asm/cpm2.h>
 #include <sysdev/cpm2_pic.h>
 #include <asm/fs_pd.h>
@@ -146,70 +147,81 @@ #endif
  * Setup the architecture
  */
 #ifdef CONFIG_CPM2
-static void init_fcc_ioports(void)
+void init_fcc_ioports(struct fs_platform_info *fpi)
 {
-	struct immap *immap;
-	struct io_port *io;
+	struct io_port *io = cpm2_map(im_ioport);
+	int fcc_no = fs_get_fcc_index(fpi->fs_no);
+	int target;
 	u32 tempval;
 
-	immap = cpm2_immr;
-
-	io = &immap->im_ioport;
-	/* FCC2/3 are on the ports B/C. */
-	tempval = in_be32(&io->iop_pdirb);
-	tempval &= ~PB2_DIRB0;
-	tempval |= PB2_DIRB1;
-	out_be32(&io->iop_pdirb, tempval);
-
-	tempval = in_be32(&io->iop_psorb);
-	tempval &= ~PB2_PSORB0;
-	tempval |= PB2_PSORB1;
-	out_be32(&io->iop_psorb, tempval);
-
-	tempval = in_be32(&io->iop_pparb);
-	tempval |= (PB2_DIRB0 | PB2_DIRB1);
-	out_be32(&io->iop_pparb, tempval);
-
-	tempval = in_be32(&io->iop_pdirb);
-	tempval &= ~PB3_DIRB0;
-	tempval |= PB3_DIRB1;
-	out_be32(&io->iop_pdirb, tempval);
-
-	tempval = in_be32(&io->iop_psorb);
-	tempval &= ~PB3_PSORB0;
-	tempval |= PB3_PSORB1;
-	out_be32(&io->iop_psorb, tempval);
-
-	tempval = in_be32(&io->iop_pparb);
-	tempval |= (PB3_DIRB0 | PB3_DIRB1);
-	out_be32(&io->iop_pparb, tempval);
-
-	tempval = in_be32(&io->iop_pdirc);
-	tempval |= PC3_DIRC1;
-	out_be32(&io->iop_pdirc, tempval);
-
-	tempval = in_be32(&io->iop_pparc);
-	tempval |= PC3_DIRC1;
-	out_be32(&io->iop_pparc, tempval);
+	switch(fcc_no) {
+	case 1:
+		tempval = in_be32(&io->iop_pdirb);
+		tempval &= ~PB2_DIRB0;
+		tempval |= PB2_DIRB1;
+		out_be32(&io->iop_pdirb, tempval);
+
+		tempval = in_be32(&io->iop_psorb);
+		tempval &= ~PB2_PSORB0;
+		tempval |= PB2_PSORB1;
+		out_be32(&io->iop_psorb, tempval);
+
+		tempval = in_be32(&io->iop_pparb);
+		tempval |= (PB2_DIRB0 | PB2_DIRB1);
+		out_be32(&io->iop_pparb, tempval);
+
+		target = CPM_CLK_FCC2;
+		break;
+	case 2:
+		tempval = in_be32(&io->iop_pdirb);
+		tempval &= ~PB3_DIRB0;
+		tempval |= PB3_DIRB1;
+		out_be32(&io->iop_pdirb, tempval);
+
+		tempval = in_be32(&io->iop_psorb);
+		tempval &= ~PB3_PSORB0;
+		tempval |= PB3_PSORB1;
+		out_be32(&io->iop_psorb, tempval);
+
+		tempval = in_be32(&io->iop_pparb);
+		tempval |= (PB3_DIRB0 | PB3_DIRB1);
+		out_be32(&io->iop_pparb, tempval);
+
+		tempval = in_be32(&io->iop_pdirc);
+		tempval |= PC3_DIRC1;
+		out_be32(&io->iop_pdirc, tempval);
+
+		tempval = in_be32(&io->iop_pparc);
+		tempval |= PC3_DIRC1;
+		out_be32(&io->iop_pparc, tempval);
+
+		target = CPM_CLK_FCC3;
+		break;
+	default:
+		printk(KERN_ERR "init_fcc_ioports: invalid FCC number\n");
+		return;
+	}
 
 	/* Port C has clocks......  */
 	tempval = in_be32(&io->iop_psorc);
-	tempval &= ~(CLK_TRX);
+	tempval &= ~(PC_CLK(fpi->clk_rx - 8) | PC_CLK(fpi->clk_tx - 8));
 	out_be32(&io->iop_psorc, tempval);
 
 	tempval = in_be32(&io->iop_pdirc);
-	tempval &= ~(CLK_TRX);
+	tempval &= ~(PC_CLK(fpi->clk_rx - 8) | PC_CLK(fpi->clk_tx - 8));
 	out_be32(&io->iop_pdirc, tempval);
 	tempval = in_be32(&io->iop_pparc);
-	tempval |= (CLK_TRX);
+	tempval |= (PC_CLK(fpi->clk_rx - 8) | PC_CLK(fpi->clk_tx - 8));
 	out_be32(&io->iop_pparc, tempval);
 
+	cpm2_unmap(io);
+
 	/* Configure Serial Interface clock routing.
-	 * First,  clear all FCC bits to zero,
+	 * First,  clear FCC bits to zero,
 	 * then set the ones we want.
 	 */
-	immap->im_cpmux.cmx_fcr &= ~(CPMUX_CLK_MASK);
-	immap->im_cpmux.cmx_fcr |= CPMUX_CLK_ROUTE;
+	cpm2_clk_setup(target, fpi->clk_rx, CPM_CLK_RX);
+	cpm2_clk_setup(target, fpi->clk_tx, CPM_CLK_TX);
 }
 #endif
 
@@ -237,7 +249,6 @@ #endif
 
 #ifdef CONFIG_CPM2
 	cpm2_reset();
-	init_fcc_ioports();
 #endif
 
 #ifdef CONFIG_PCI
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index 4adc174..37f8ebf 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -124,6 +124,96 @@ cpm2_fastbrg(uint brg, uint rate, int di
 	cpm2_unmap(bp);
 }
 
+int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode)
+{
+	int ret = 0;
+	int shift;
+	int i, bits = 0;
+	cpmux_t *im_cpmux;
+	u32 *reg;
+	u32 mask = 7;
+	u8 clk_map [24][3] = {
+		{CPM_CLK_FCC1, CPM_BRG5, 0},
+		{CPM_CLK_FCC1, CPM_BRG6, 1},
+		{CPM_CLK_FCC1, CPM_BRG7, 2},
+		{CPM_CLK_FCC1, CPM_BRG8, 3},
+		{CPM_CLK_FCC1, CPM_CLK9, 4},
+		{CPM_CLK_FCC1, CPM_CLK10, 5},
+		{CPM_CLK_FCC1, CPM_CLK11, 6},
+		{CPM_CLK_FCC1, CPM_CLK12, 7},
+		{CPM_CLK_FCC2, CPM_BRG5, 0},
+		{CPM_CLK_FCC2, CPM_BRG6, 1},
+		{CPM_CLK_FCC2, CPM_BRG7, 2},
+		{CPM_CLK_FCC2, CPM_BRG8, 3},
+		{CPM_CLK_FCC2, CPM_CLK13, 4},
+		{CPM_CLK_FCC2, CPM_CLK14, 5},
+		{CPM_CLK_FCC2, CPM_CLK15, 6},
+		{CPM_CLK_FCC2, CPM_CLK16, 7},
+		{CPM_CLK_FCC3, CPM_BRG5, 0},
+		{CPM_CLK_FCC3, CPM_BRG6, 1},
+		{CPM_CLK_FCC3, CPM_BRG7, 2},
+		{CPM_CLK_FCC3, CPM_BRG8, 3},
+		{CPM_CLK_FCC3, CPM_CLK13, 4},
+		{CPM_CLK_FCC3, CPM_CLK14, 5},
+		{CPM_CLK_FCC3, CPM_CLK15, 6},
+		{CPM_CLK_FCC3, CPM_CLK16, 7}
+		};
+
+	im_cpmux = cpm2_map(im_cpmux);
+
+	switch (target) {
+	case CPM_CLK_SCC1:
+		reg = &im_cpmux->cmx_scr;
+		shift = 24;
+	case CPM_CLK_SCC2:
+		reg = &im_cpmux->cmx_scr;
+		shift = 16;
+		break;
+	case CPM_CLK_SCC3:
+		reg = &im_cpmux->cmx_scr;
+		shift = 8;
+		break;
+	case CPM_CLK_SCC4:
+		reg = &im_cpmux->cmx_scr;
+		shift = 0;
+		break;
+	case CPM_CLK_FCC1:
+		reg = &im_cpmux->cmx_fcr;
+		shift = 24;
+		break;
+	case CPM_CLK_FCC2:
+		reg = &im_cpmux->cmx_fcr;
+		shift = 16;
+		break;
+	case CPM_CLK_FCC3:
+		reg = &im_cpmux->cmx_fcr;
+		shift = 8;
+		break;
+	default:
+		printk(KERN_ERR "cpm2_clock_setup: invalid clock target\n");
+		return -EINVAL;
+	}
+
+	if (mode == CPM_CLK_RX)
+		shift +=3;
+
+	for (i=0; i<24; i++) {
+		if (clk_map[i][0] == target && clk_map[i][1] == clock) {
+			bits = clk_map[i][2];
+			break;
+		}
+	}
+	if (i == sizeof(clk_map)/3)
+	    ret = -EINVAL;
+
+	bits <<= shift;
+	mask <<= shift;
+	out_be32(reg, (in_be32(reg) & ~mask) | bits);
+
+	cpm2_unmap(im_cpmux);
+	return ret;
+}
+
 /*
  * dpalloc / dpfree bits.
  */
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 32eca28..26153a2 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -38,6 +38,7 @@ #ifdef CONFIG_CPM2
 #include <asm/cpm2.h>
 #endif
 
+extern void init_fcc_ioports(struct fs_platform_info*);
 static phys_addr_t immrbase = -1;
 
 phys_addr_t get_immrbase(void)
@@ -630,6 +631,9 @@ static int __init fs_enet_of_init(void)
                         goto unreg;
                 }
 
+		fs_enet_data.clk_rx = *((u32 *) get_property(np, "rx-clock", NULL));
+		fs_enet_data.clk_tx = *((u32 *) get_property(np, "tx-clock", NULL));
+
 		if (strstr(model, "FCC")) {
 			int fcc_index = fs_get_fcc_index(*id);
 
@@ -646,6 +650,7 @@ static int __init fs_enet_of_init(void)
 			snprintf((char*)&bus_id[(*id)], BUS_ID_SIZE, "%x:%02x",
 							(u32)res.start, fs_enet_data.phy_addr);
 			fs_enet_data.bus_id = (char*)&bus_id[(*id)];
+			fs_enet_data.init_ioports = init_fcc_ioports;
 		}
 
 		of_node_put(phy);
@@ -717,6 +722,8 @@ static int __init cpm_uart_of_init(void)
 		cpm_uart_data.tx_buf_size = 32;
 		cpm_uart_data.rx_num_fifo = 4;
 		cpm_uart_data.rx_buf_size = 32;
+		cpm_uart_data.clk_rx = *((u32 *) get_property(np, "rx-clock", NULL));
+		cpm_uart_data.clk_tx = *((u32 *) get_property(np, "tx-clock", NULL));
 
 		ret =
 		    platform_device_add_data(cpm_uart_dev, &cpm_uart_data,
diff --git a/arch/ppc/platforms/mpc8272ads_setup.c b/arch/ppc/platforms/mpc8272ads_setup.c
index 2a35fe2..d5d36c3 100644
--- a/arch/ppc/platforms/mpc8272ads_setup.c
+++ b/arch/ppc/platforms/mpc8272ads_setup.c
@@ -103,7 +103,7 @@ static struct fs_platform_info mpc82xx_e
 	},
 };
 
-static void init_fcc1_ioports(void)
+static void init_fcc1_ioports(struct fs_platform_info*)
 {
 	struct io_port *io;
 	u32 tempval;
@@ -144,7 +144,7 @@ static void init_fcc1_ioports(void)
 	iounmap(immap);
 }
 
-static void init_fcc2_ioports(void)
+static void init_fcc2_ioports(struct fs_platform_info*)
 {
 	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
 	u32 *bcsr = ioremap(BCSR_ADDR+12, sizeof(u32));
@@ -229,7 +229,7 @@ static void mpc8272ads_fixup_uart_pdata(
 	}
 }
 
-static void init_scc1_uart_ioports(void)
+static void init_scc1_uart_ioports(struct fs_uart_platform_info*)
 {
 	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
 
@@ -246,7 +246,7 @@ static void init_scc1_uart_ioports(void)
 	iounmap(immap);
 }
 
-static void init_scc4_uart_ioports(void)
+static void init_scc4_uart_ioports(struct fs_uart_platform_info*)
 {
 	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
 
diff --git a/arch/ppc/platforms/mpc866ads_setup.c b/arch/ppc/platforms/mpc866ads_setup.c
index e12cece..5f130dc 100644
--- a/arch/ppc/platforms/mpc866ads_setup.c
+++ b/arch/ppc/platforms/mpc866ads_setup.c
@@ -137,7 +137,7 @@ #endif
 	iounmap(bcsr_io);
 }
 
-static void setup_fec1_ioports(void)
+static void setup_fec1_ioports(struct fs_platform_info*)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 
@@ -145,7 +145,7 @@ static void setup_fec1_ioports(void)
 	setbits16(&immap->im_ioport.iop_pddir, 0x1fff);
 }
 
-static void setup_scc1_ioports(void)
+static void setup_scc1_ioports(struct fs_platform_info*)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 	unsigned *bcsr_io;
@@ -194,7 +194,7 @@ static void setup_scc1_ioports(void)
 
 }
 
-static void setup_smc1_ioports(void)
+static void setup_smc1_ioports(struct fs_uart_platform_info*)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 	unsigned *bcsr_io;
@@ -216,7 +216,7 @@ static void setup_smc1_ioports(void)
 
 }
 
-static void setup_smc2_ioports(void)
+static void setup_smc2_ioports(struct fs_uart_platform_info*)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 	unsigned *bcsr_io;
diff --git a/arch/ppc/platforms/mpc885ads_setup.c b/arch/ppc/platforms/mpc885ads_setup.c
index 5dfa4e6..bf388ed 100644
--- a/arch/ppc/platforms/mpc885ads_setup.c
+++ b/arch/ppc/platforms/mpc885ads_setup.c
@@ -161,7 +161,7 @@ #endif
 #endif
 }
 
-static void setup_fec1_ioports(void)
+static void setup_fec1_ioports(struct fs_platform_info*)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 
@@ -181,7 +181,7 @@ static void setup_fec1_ioports(void)
 	clrbits32(&immap->im_cpm.cp_cptr, 0x00000100);
 }
 
-static void setup_fec2_ioports(void)
+static void setup_fec2_ioports(struct fs_platform_info*)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 
@@ -193,7 +193,7 @@ static void setup_fec2_ioports(void)
 	clrbits32(&immap->im_cpm.cp_cptr, 0x00000080);
 }
 
-static void setup_scc3_ioports(void)
+static void setup_scc3_ioports(struct fs_platform_info*)
 {
 	immap_t *immap = (immap_t *) IMAP_ADDR;
 	unsigned *bcsr_io;
@@ -315,7 +315,7 @@ static void __init mpc885ads_fixup_scc_e
 	mpc885ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
 }
 
-static void setup_smc1_ioports(void)
+static void setup_smc1_ioports(struct fs_uart_platform_info*)
 {
         immap_t *immap = (immap_t *) IMAP_ADDR;
         unsigned *bcsr_io;
@@ -335,7 +335,7 @@ static void setup_smc1_ioports(void)
         clrbits16(&immap->im_cpm.cp_pbodr, iobits);
 }
 
-static void setup_smc2_ioports(void)
+static void setup_smc2_ioports(struct fs_uart_platform_info*)
 {
         immap_t *immap = (immap_t *) IMAP_ADDR;
         unsigned *bcsr_io;
diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index df62506..f358ee6 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -971,7 +971,7 @@ static struct net_device *fs_init_instan
 	dev_set_drvdata(dev, ndev);
 	fep->fpi = fpi;
 	if (fpi->init_ioports)
-		fpi->init_ioports();
+		fpi->init_ioports((struct fs_platform_info *)fpi);
 
 #ifdef CONFIG_FS_ENET_HAS_FEC
 	if (fs_get_fec_index(fpi->fs_no) >= 0)
diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index dfa06b6..24613a6 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -1180,7 +1180,7 @@ static int __init cpm_uart_console_setup
 		pdata = pdev->dev.platform_data;
 		if (pdata)
 			if (pdata->init_ioports)
-    	                	pdata->init_ioports();
+    	                	pdata->init_ioports(pdata);
 
 		cpm_uart_drv_get_platform_data(pdev, 1);
 	}
@@ -1269,7 +1269,7 @@ static int cpm_uart_drv_probe(struct dev
 		return ret;
 
 	if (pdata->init_ioports)
-                pdata->init_ioports();
+                pdata->init_ioports(pdata);
 
 	ret = uart_add_one_port(&cpm_reg, &cpm_uart_ports[pdata->fs_no].port);
 
diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index bd6623a..220cc2d 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -1196,5 +1196,58 @@ #define FCC1_MEM_OFFSET FCC_MEM_OFFSET(0
 #define FCC2_MEM_OFFSET FCC_MEM_OFFSET(1)
 #define FCC3_MEM_OFFSET FCC_MEM_OFFSET(2)
 
+/* Clocks and GRG's */
+
+enum cpm_clk_dir {
+	CPM_CLK_RX,
+	CPM_CLK_TX,
+	CPM_CLK_RTX
+};
+
+enum cpm_clk_target {
+	CPM_CLK_SCC1,
+	CPM_CLK_SCC2,
+	CPM_CLK_SCC3,
+	CPM_CLK_SCC4,
+	CPM_CLK_FCC1,
+	CPM_CLK_FCC2,
+	CPM_CLK_FCC3
+};
+
+enum cpm_clk {
+	CPM_CLK_NONE = 0,
+	CPM_BRG1,	/* Baud Rate Generator  1 */
+	CPM_BRG2,	/* Baud Rate Generator  2 */
+	CPM_BRG3,	/* Baud Rate Generator  3 */
+	CPM_BRG4,	/* Baud Rate Generator  4 */
+	CPM_BRG5,	/* Baud Rate Generator  5 */
+	CPM_BRG6,	/* Baud Rate Generator  6 */
+	CPM_BRG7,	/* Baud Rate Generator  7 */
+	CPM_BRG8,	/* Baud Rate Generator  8 */
+	CPM_CLK1,	/* Clock  1 */
+	CPM_CLK2,	/* Clock  2 */
+	CPM_CLK3,	/* Clock  3 */
+	CPM_CLK4,	/* Clock  4 */
+	CPM_CLK5,	/* Clock  5 */
+	CPM_CLK6,	/* Clock  6 */
+	CPM_CLK7,	/* Clock  7 */
+	CPM_CLK8,	/* Clock  8 */
+	CPM_CLK9,	/* Clock  9 */
+	CPM_CLK10,	/* Clock 10 */
+	CPM_CLK11,	/* Clock 11 */
+	CPM_CLK12,	/* Clock 12 */
+	CPM_CLK13,	/* Clock 13 */
+	CPM_CLK14,	/* Clock 14 */
+	CPM_CLK15,	/* Clock 15 */
+	CPM_CLK16,	/* Clock 16 */
+	CPM_CLK17,	/* Clock 17 */
+	CPM_CLK18,	/* Clock 18 */
+	CPM_CLK19,	/* Clock 19 */
+	CPM_CLK20,	/* Clock 20 */
+	CPM_CLK_DUMMY
+};
+
+extern int cpm2_clk_setup(enum cpm_clk_target target, int clock, int mode);
+
 #endif /* __CPM2__ */
 #endif /* __KERNEL__ */
diff --git a/include/linux/fs_enet_pd.h b/include/linux/fs_enet_pd.h
index 74ed35a..9322235 100644
--- a/include/linux/fs_enet_pd.h
+++ b/include/linux/fs_enet_pd.h
@@ -87,18 +87,20 @@ struct fs_mii_bb_platform_info {
 };
 
 struct fs_platform_info {
-	
-	void(*init_ioports)(void);
+
+	void(*init_ioports)(struct fs_platform_info *);
 	/* device specific information */
 	int fs_no;		/* controller index            */
 
 	u32 cp_page;		/* CPM page */
 	u32 cp_block;		/* CPM sblock */
-	
+
 	u32 clk_trx;		/* some stuff for pins & mux configuration*/
+	u32 clk_rx;
+	u32 clk_tx;
 	u32 clk_route;
 	u32 clk_mask;
-	
+
 	u32 mem_offset;
 	u32 dpram_offset;
 	u32 fcc_regs_c;
diff --git a/include/linux/fs_uart_pd.h b/include/linux/fs_uart_pd.h
index f597512..a99a020 100644
--- a/include/linux/fs_uart_pd.h
+++ b/include/linux/fs_uart_pd.h
@@ -46,7 +46,7 @@ static inline int fs_uart_id_fsid2smc(in
 }
 
 struct fs_uart_platform_info {
-        void(*init_ioports)(void);
+        void(*init_ioports)(struct fs_uart_platform_info *);
 	/* device specific information */
 	int fs_no;		/* controller index */
 	u32 uart_clk;
@@ -55,6 +55,8 @@ struct fs_uart_platform_info {
 	u8 rx_num_fifo;
 	u8 rx_buf_size;
 	u8 brg;
+	u8 clk_rx;
+	u8 clk_tx;
 };
 
 #endif
