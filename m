Return-Path: <vbordug@ru.mvista.com>
Received: from vitb.dev.rtsoft.ru (unknown [85.21.88.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8EDFE679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 02:26:49 +1000 (EST)
To: Paul Mackerras <paulus@samba.org>
From: Vitaly Bordug <vbordug@ru.mvista.com>
Subject: [PATCH 3/4] PPC32: Update board-specific code of the CPM UART users
Date: Tue, 25 Apr 2006 20:26:43 +0400
Message-Id: <20060425162643.23551.81283.stgit@vitb.ru.mvista.com>
In-Reply-To: <20060425162633.23551.85273.stgit@vitb.ru.mvista.com>
References: <20060425162633.23551.85273.stgit@vitb.ru.mvista.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This has the relevant updates/additions to the BSP code so that proper
platform_info struct well be passed to the CPM UART drivers. The changes
covered mpc866ads, mpc885ads and mpc8272ads.

Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
---

 arch/ppc/platforms/mpc8272ads_setup.c |  114 +++++++++++++++++++++++++++
 arch/ppc/platforms/mpc866ads_setup.c  |  140 +++++++++++++++++++++++++++++++++
 arch/ppc/platforms/mpc885ads_setup.c  |  131 +++++++++++++++++++++++++++++++
 arch/ppc/platforms/pq2ads.c           |   31 +++++++
 4 files changed, 415 insertions(+), 1 deletions(-)

diff --git a/arch/ppc/platforms/mpc8272ads_setup.c b/arch/ppc/platforms/mpc8272ads_setup.c
index bc9b94f..d5c8a3a 100644
--- a/arch/ppc/platforms/mpc8272ads_setup.c
+++ b/arch/ppc/platforms/mpc8272ads_setup.c
@@ -26,11 +26,35 @@
 #include <asm/irq.h>
 #include <asm/ppc_sys.h>
 #include <asm/ppcboot.h>
+#include <linux/fs_uart_pd.h>
 
 #include "pq2ads_pd.h"
 
 static void init_fcc1_ioports(void);
 static void init_fcc2_ioports(void);
+static void init_scc1_uart_ioports(void);
+static void init_scc4_uart_ioports(void);
+
+static struct fs_uart_platform_info mpc8272_uart_pdata[] = {
+	[fsid_scc1_uart] = {
+		.init_ioports 	= init_scc1_uart_ioports,
+		.fs_no		= fsid_scc1_uart,
+		.brg		= 1,
+		.tx_num_fifo	= 4,
+		.tx_buf_size	= 32,
+		.rx_num_fifo	= 4,
+		.rx_buf_size	= 32,
+	},
+	[fsid_scc4_uart] = {
+		.init_ioports 	= init_scc4_uart_ioports,
+		.fs_no		= fsid_scc4_uart,
+		.brg		= 4,
+		.tx_num_fifo	= 4,
+		.tx_buf_size	= 32,
+		.rx_num_fifo	= 4,
+		.rx_buf_size	= 32,
+	},
+};
 
 static struct fs_mii_bus_info mii_bus_info = {
 	.method                 = fsmii_bitbang,
@@ -201,6 +225,55 @@ static void __init mpc8272ads_fixup_enet
 	}
 }
 
+static void mpc8272ads_fixup_uart_pdata(struct platform_device *pdev,
+					      int idx)
+{
+	bd_t *bd = (bd_t *) __res;
+	struct fs_uart_platform_info *pinfo;
+	int num = ARRAY_SIZE(mpc8272_uart_pdata);
+	int id = fs_uart_id_scc2fsid(idx);
+	
+	/* no need to alter anything if console */
+	if ((id <= num) && (!pdev->dev.platform_data)) {
+		pinfo = &mpc8272_uart_pdata[id];
+		pinfo->uart_clk = bd->bi_intfreq;
+		pdev->dev.platform_data = pinfo; 
+	}
+}
+
+static void init_scc1_uart_ioports(void)
+{
+	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+
+        /* SCC1 is only on port D */
+	setbits32(&immap->im_ioport.iop_ppard,0x00000003);
+	clrbits32(&immap->im_ioport.iop_psord,0x00000001);
+	setbits32(&immap->im_ioport.iop_psord,0x00000002);
+	clrbits32(&immap->im_ioport.iop_pdird,0x00000001);
+	setbits32(&immap->im_ioport.iop_pdird,0x00000002);
+
+        /* Wire BRG1 to SCC1 */
+	clrbits32(&immap->im_cpmux.cmx_scr,0x00ffffff);
+
+	iounmap(immap);
+}
+
+static void init_scc4_uart_ioports(void)
+{
+	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+
+	setbits32(&immap->im_ioport.iop_ppard,0x00000600);
+	clrbits32(&immap->im_ioport.iop_psord,0x00000600);
+	clrbits32(&immap->im_ioport.iop_pdird,0x00000200);
+	setbits32(&immap->im_ioport.iop_pdird,0x00000400);
+
+        /* Wire BRG4 to SCC4 */
+	clrbits32(&immap->im_cpmux.cmx_scr,0x000000ff);
+	setbits32(&immap->im_cpmux.cmx_scr,0x0000001b);
+
+	iounmap(immap);
+}
+
 static int mpc8272ads_platform_notify(struct device *dev)
 {
 	static const struct platform_notify_dev_map dev_map[] = {
@@ -209,6 +282,10 @@ static int mpc8272ads_platform_notify(st
 			.rtn = mpc8272ads_fixup_enet_pdata
 		},
 		{
+			.bus_id = "fsl-cpm-scc:uart",
+			.rtn = mpc
+		},
+		{
 			.bus_id = NULL
 		}
 	};
@@ -230,7 +307,44 @@ int __init mpc8272ads_init(void)
 	ppc_sys_device_enable(MPC82xx_CPM_FCC1);
 	ppc_sys_device_enable(MPC82xx_CPM_FCC2);
 
+	/* to be ready for console, let's attach pdata here */
+#ifdef CONFIG_SERIAL_CPM_SCC1
+	ppc_sys_device_setfunc(MPC82xx_CPM_SCC1, PPC_SYS_FUNC_UART);
+	ppc_sys_device_enable(MPC82xx_CPM_SCC1);
+
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SCC4
+	ppc_sys_device_setfunc(MPC82xx_CPM_SCC4, PPC_SYS_FUNC_UART);
+	ppc_sys_device_enable(MPC82xx_CPM_SCC4);
+#endif
+
+
 	return 0;
 }
 
+/* 
+   To prevent confusion, console selection is gross:
+   by 0 assumed SCC1 and by 1 assumed SCC4
+ */
+struct platform_device* early_uart_get_pdev(int index)
+{
+	bd_t *bd = (bd_t *) __res;
+	struct fs_uart_platform_info *pinfo;
+
+	struct platform_device* pdev = NULL;
+	if(index) { /*assume SCC4 here*/
+		pdev = &ppc_sys_platform_devices[MPC82xx_CPM_SCC4];
+		pinfo = &mpc8272<F12>_uart_pdata[1];
+	} else { /*over SCC1*/
+		pdev = &ppc_sys_platform_devices[MPC82xx_CPM_SCC1];
+		pinfo = &mpc8272_uart_pdata[0];
+	}
+	
+	pinfo->uart_clk = bd->bi_intfreq;
+	pdev->dev.platform_data = pinfo;
+	ppc_sys_fixup_mem_resource(pdev, IMAP_ADDR);
+	return NULL;
+}
+
 arch_initcall(mpc8272ads_init);
diff --git a/arch/ppc/platforms/mpc866ads_setup.c b/arch/ppc/platforms/mpc866ads_setup.c
index ac8fcc6..7edefa5 100644
--- a/arch/ppc/platforms/mpc866ads_setup.c
+++ b/arch/ppc/platforms/mpc866ads_setup.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 
 #include <linux/fs_enet_pd.h>
+#include <linux/fs_uart_pd.h>
 #include <linux/mii.h>
 
 #include <asm/delay.h>
@@ -37,6 +38,11 @@
 
 extern unsigned char __res[];
 
+static void setup_fec1_ioports(void);
+static void setup_scc1_ioports(void);
+static void setup_smc1_ioports(void);
+static void setup_smc2_ioports(void);
+
 static struct fs_mii_bus_info fec_mii_bus_info = {
 	.method = fsmii_fec,
 	.id = 0,
@@ -79,6 +85,28 @@ static struct fs_platform_info mpc8xx_sc
 	.phy_irq = -1,
 
 	.bus_info = &scc_mii_bus_info,
+
+};
+
+static struct fs_uart_platform_info mpc866_uart_pdata[] = {
+	[fsid_smc1_uart] = {
+		.brg		= 1,
+ 		.fs_no 		= fsid_smc1_uart,
+ 		.init_ioports	= setup_smc1_ioports,
+		.tx_num_fifo	= 4,
+		.tx_buf_size	= 32,
+		.rx_num_fifo	= 4,
+		.rx_buf_size	= 32,
+ 	},
+ 	[fsid_smc2_uart] = {
+ 		.brg		= 2,
+ 		.fs_no 		= fsid_smc2_uart,
+ 		.init_ioports	= setup_smc2_ioports,
+		.tx_num_fifo	= 4,
+		.tx_buf_size	= 32,
+		.rx_num_fifo	= 4,
+		.rx_buf_size	= 32,
+ 	},
 };
 
 void __init board_init(void)
@@ -92,9 +120,12 @@ void __init board_init(void)
 		printk(KERN_CRIT "Could not remap BCSR1\n");
 		return;
 	}
+
 #ifdef CONFIG_SERIAL_CPM_SMC1
 	cp->cp_simode &= ~(0xe0000000 >> 17);	/* brg1 */
 	clrbits32(bcsr_io,(0x80000000 >> 7));
+	cp->cp_smc[0].smc_smcm |= (SMCM_RX | SMCM_TX);
+	cp->cp_smc[0].smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
 #else
 	setbits32(bcsr_io,(0x80000000 >> 7));
 
@@ -108,6 +139,8 @@ void __init board_init(void)
 	cp->cp_simode &= ~(0xe0000000 >> 1);
 	cp->cp_simode |= (0x20000000 >> 1);	/* brg2 */
 	clrbits32(bcsr_io,(0x80000000 >> 13));
+	cp->cp_smc[1].smc_smcm |= (SMCM_RX | SMCM_TX);
+	cp->cp_smc[1].smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
 #else
 	clrbits32(bcsr_io,(0x80000000 >> 13));
 	cp->cp_pbpar &= ~(0x00000c00);
@@ -232,6 +265,74 @@ static void mpc866ads_fixup_scc_enet_pda
 	mpc866ads_fixup_enet_pdata(pdev, fsid_scc1 + pdev->id - 1);
 }
 
+static void setup_smc1_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+	unsigned *bcsr_io;
+	unsigned int iobits = 0x000000c0;
+
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR1\n");
+		return;
+	}
+
+	clrbits32(bcsr_io,BCSR1_RS232EN_1);
+	iounmap(bcsr_io);
+
+	setbits32(&immap->im_cpm.cp_pbpar, iobits);
+	clrbits32(&immap->im_cpm.cp_pbdir, iobits);
+	clrbits16(&immap->im_cpm.cp_pbodr, iobits);
+
+}
+
+static void setup_smc2_ioports(void)
+{
+	immap_t *immap = (immap_t *) IMAP_ADDR;
+	unsigned *bcsr_io;
+	unsigned int iobits = 0x00000c00;
+
+	bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+	if (bcsr_io == NULL) {
+		printk(KERN_CRIT "Could not remap BCSR1\n");
+		return;
+	} 
+
+	clrbits32(bcsr_io,BCSR1_RS232EN_2);
+
+	iounmap(bcsr_io);
+	
+#ifndef CONFIG_SERIAL_CPM_ALT_SMC2
+	setbits32(&immap->im_cpm.cp_pbpar, iobits);
+	clrbits32(&immap->im_cpm.cp_pbdir, iobits);
+	clrbits16(&immap->im_cpm.cp_pbodr, iobits);
+#else
+	setbits16(&immap->im_ioport.iop_papar, iobits);
+	clrbits16(&immap->im_ioport.iop_padir, iobits);
+	clrbits16(&immap->im_ioport.iop_paodr, iobits);
+#endif
+
+}
+
+static void __init mpc866ads_fixup_uart_pdata(struct platform_device *pdev,
+                                              int idx)
+{
+	bd_t *bd = (bd_t *) __res;
+	struct fs_uart_platform_info *pinfo;
+	int num = ARRAY_SIZE(mpc866_uart_pdata);
+
+	int id = fs_uart_id_smc2fsid(idx);
+	
+	/* no need to alter anything if console */
+	if ((id <= num) && (!pdev->dev.platform_data)) {
+		pinfo = &mpc866_uart_pdata[id];
+		pinfo->uart_clk = bd->bi_intfreq;
+		pdev->dev.platform_data = pinfo; 
+	}
+}
+
 static int mpc866ads_platform_notify(struct device *dev)
 {
 	static const struct platform_notify_dev_map dev_map[] = {
@@ -244,6 +345,10 @@ static int mpc866ads_platform_notify(str
 			.rtn = mpc866ads_fixup_scc_enet_pdata,
 		},
 		{
+			.bus_id = "fsl-cpm-smc:uart",
+			.rtn = mpc866ads_fixup_uart_pdata
+		},
+		{
 			.bus_id = NULL
 		}
 	};
@@ -267,7 +372,42 @@ int __init mpc866ads_init(void)
 #endif
 	ppc_sys_device_enable(MPC8xx_CPM_FEC1);
 
+/* Since either of the uarts could be used as console, they need to ready */
+#ifdef CONFIG_SERIAL_CPM_SMC1
+	ppc_sys_device_enable(MPC8xx_CPM_SMC1);
+	ppc_sys_device_setfunc(MPC8xx_CPM_SMC1, PPC_SYS_FUNC_UART);
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SMCer
+	ppc_sys_device_enable(MPC8xx_CPM_SMC2);
+	ppc_sys_device_setfunc(MPC8xx_CPM_SMC2, PPC_SYS_FUNC_UART);
+#endif
+
 	return 0;
 }
 
+/* 
+   To prevent confusion, console selection is gross:
+   by 0 assumed SMC1 and by 1 assumed SMC2
+ */
+struct platform_device* early_uart_get_pdev(int index)
+{
+	bd_t *bd = (bd_t *) __res;
+	struct fs_uart_platform_info *pinfo;
+
+	struct platform_device* pdev = NULL;
+	if(index) { /*assume SMC2 here*/
+		pdev = &ppc_sys_platform_devices[MPC8xx_CPM_SMC2];
+		pinfo = &mpc866_uart_pdata[1];
+	} else { /*over SMC1*/
+		pdev = &ppc_sys_platform_devices[MPC8xx_CPM_SMC1];
+		pinfo = &mpc866_uart_pdata[0];
+	}
+	
+	pinfo->uart_clk = bd->bi_intfreq;
+	pdev->dev.platform_data = pinfo;
+	ppc_sys_fixup_mem_resource(pdev, IMAP_ADDR);
+	return NULL;
+}
+
 arch_initcall(mpc866ads_init);
diff --git a/arch/ppc/platforms/mpc885ads_setup.c b/arch/ppc/platforms/mpc885ads_setup.c
index 50a99e5..fc37aea 100644
--- a/arch/ppc/platforms/mpc885ads_setup.c
+++ b/arch/ppc/platforms/mpc885ads_setup.c
@@ -20,6 +20,7 @@
 #include <linux/device.h>
 
 #include <linux/fs_enet_pd.h>
+#include <linux/fs_uart_pd.h>
 #include <linux/mii.h>
 
 #include <asm/delay.h>
@@ -35,9 +36,32 @@
 #include <asm/ppc_sys.h>
 
 extern unsigned char __res[];
+static void setup_smc1_ioports(void);
+static void setup_smc2_ioports(void);
 
 static void __init mpc885ads_scc_phy_init(char);
 
+static struct fs_uart_platform_info mpc885_uart_pdata[] = {
+	[fsid_smc1_uart] = {
+		.brg		= 1,
+ 		.fs_no 		= fsid_smc1_uart,
+ 		.init_ioports	= setup_smc1_ioports,
+		.tx_num_fifo	= 4,
+		.tx_buf_size	= 32,
+		.rx_num_fifo	= 4,
+		.rx_buf_size	= 32,
+ 	},
+ 	[fsid_smc2_uart] = {
+ 		.brg		= 2,
+ 		.fs_no 		= fsid_smc2_uart,
+ 		.init_ioports	= setup_smc2_ioports,
+		.tx_num_fifo	= 4,
+		.tx_buf_size	= 32,
+		.rx_num_fifo	= 4,
+		.rx_buf_size	= 32,
+ 	},
+};
+
 static struct fs_mii_bus_info fec_mii_bus_info = {
 	.method = fsmii_fec,
 	.id = 0,
@@ -116,6 +140,8 @@ void __init board_init(void)
 #ifdef CONFIG_SERIAL_CPM_SMC1
 	cp->cp_simode &= ~(0xe0000000 >> 17);	/* brg1 */
 	clrbits32(bcsr_io, BCSR1_RS232EN_1);
+        cp->cp_smc[0].smc_smcm |= (SMCM_RX | SMCM_TX);
+        cp->cp_smc[0].smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
 #else
 	setbits32(bcsr_io,BCSR1_RS232EN_1);
 	cp->cp_smc[0].smc_smcmr = 0;
@@ -126,6 +152,8 @@ void __init board_init(void)
 	cp->cp_simode &= ~(0xe0000000 >> 1);
 	cp->cp_simode |= (0x20000000 >> 1);	/* brg2 */
 	clrbits32(bcsr_io,BCSR1_RS232EN_2);
+        cp->cp_smc[1].smc_smcm |= (SMCM_RX | SMCM_TX);
+        cp->cp_smc[1].smc_smcmr &= ~(SMCMR_REN | SMCMR_TEN);
 #else
 	setbits32(bcsr_io,BCSR1_RS232EN_2);
 	cp->cp_smc[1].smc_smcmr = 0;
@@ -343,6 +371,70 @@ static void mpc885ads_scc_phy_init(char 
 	out_be32(&fecp->fec_mii_speed, 0);
 }
 
+static void setup_smc1_ioports(void)
+{
+        immap_t *immap = (immap_t *) IMAP_ADDR;
+        unsigned *bcsr_io;
+        unsigned int iobits = 0x000000c0;
+
+        bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+        if (bcsr_io == NULL) {
+                printk(KERN_CRIT "Could not remap BCSR1\n");
+                return;
+        }
+        clrbits32(bcsr_io,BCSR1_RS232EN_1);
+        iounmap(bcsr_io);
+
+        setbits32(&immap->im_cpm.cp_pbpar, iobits);
+        clrbits32(&immap->im_cpm.cp_pbdir, iobits);
+        clrbits16(&immap->im_cpm.cp_pbodr, iobits);
+}
+
+static void setup_smc2_ioports(void)
+{
+        immap_t *immap = (immap_t *) IMAP_ADDR;
+        unsigned *bcsr_io;
+        unsigned int iobits = 0x00000c00;
+
+        bcsr_io = ioremap(BCSR1, sizeof(unsigned long));
+
+        if (bcsr_io == NULL) {
+                printk(KERN_CRIT "Could not remap BCSR1\n");
+                return;
+        }
+        clrbits32(bcsr_io,BCSR1_RS232EN_2);
+        iounmap(bcsr_io);
+
+#ifndef CONFIG_SERIAL_CPM_ALT_SMC2
+        setbits32(&immap->im_cpm.cp_pbpar, iobits);
+        clrbits32(&immap->im_cpm.cp_pbdir, iobits);
+        clrbits16(&immap->im_cpm.cp_pbodr, iobits);
+#else
+        setbits16(&immap->im_ioport.iop_papar, iobits);
+        clrbits16(&immap->im_ioport.iop_padir, iobits);
+        clrbits16(&immap->im_ioport.iop_paodr, iobits);
+#endif
+}
+
+static void __init mpc885ads_fixup_uart_pdata(struct platform_device *pdev,
+                                              int idx)
+{
+	bd_t *bd = (bd_t *) __res;
+	struct fs_uart_platform_info *pinfo;
+	int num = ARRAY_SIZE(mpc885_uart_pdata);
+
+	int id = fs_uart_id_smc2fsid(idx);
+	
+	/* no need to alter anything if console */
+	if ((id <= num) && (!pdev->dev.platform_data)) {
+		pinfo = &mpc885_uart_pdata[id];
+		pinfo->uart_clk = bd->bi_intfreq;
+		pdev->dev.platform_data = pinfo; 
+	}
+}
+
+
 static int mpc885ads_platform_notify(struct device *dev)
 {
 
@@ -356,12 +448,17 @@ static int mpc885ads_platform_notify(str
 			.rtn = mpc885ads_fixup_scc_enet_pdata,
 		},
 		{
+			.bus_id = "fsl-cpm-smc:uart",
+			.rtn = mpc885ads_fixup_uart_pdata
+		},
+		{
 			.bus_id = NULL
 		}
 	};
 
 	platform_notify_map(dev_map,dev);
 
+	return 0;	
 }
 
 int __init mpc885ads_init(void)
@@ -383,7 +480,41 @@ int __init mpc885ads_init(void)
 	ppc_sys_device_enable(MPC8xx_CPM_FEC2);
 #endif
 
+#ifdef CONFIG_SERIAL_CPM_SMC1
+	ppc_sys_device_enable(MPC8xx_CPM_SMC1);
+	ppc_sys_device_setfunc(MPC8xx_CPM_SMC1, PPC_SYS_FUNC_UART);
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SMC2
+	ppc_sys_device_enable(MPC8xx_CPM_SMC2);
+	ppc_sys_device_setfunc(MPC8xx_CPM_SMC2, PPC_SYS_FUNC_UART);
+#endif
 	return 0;
 }
 
 arch_initcall(mpc885ads_init);
+
+/* 
+   To prevent confusion, console selection is gross:
+   by 0 assumed SMC1 and by 1 assumed SMC2
+ */
+struct platform_device* early_uart_get_pdev(int index)
+{
+	bd_t *bd = (bd_t *) __res;
+	struct fs_uart_platform_info *pinfo;
+
+	struct platform_device* pdev = NULL;
+	if(index) { /*assume SMC2 here*/
+		pdev = &ppc_sys_platform_devices[MPC8xx_CPM_SMC2];
+		pinfo = &mpc885_uart_pdata[1];
+	} else { /*over SMC1*/
+		pdev = &ppc_sys_platform_devices[MPC8xx_CPM_SMC1];
+		pinfo = &mpc885_uart_pdata[0];
+	}
+	
+	pinfo->uart_clk = bd->bi_intfreq;
+	pdev->dev.platform_data = pinfo;
+	ppc_sys_fixup_mem_resource(pdev, IMAP_ADDR);
+	return NULL;
+}
+
diff --git a/arch/ppc/platforms/pq2ads.c b/arch/ppc/platforms/pq2ads.c
index 3365fd7..7fc2e02 100644
--- a/arch/ppc/platforms/pq2ads.c
+++ b/arch/ppc/platforms/pq2ads.c
@@ -14,11 +14,40 @@
 
 #include <linux/init.h>
 
+#include <asm/io.h>
 #include <asm/mpc8260.h>
+#include <asm/cpm2.h>
+#include <asm/immap_cpm2.h>
 
 void __init
 m82xx_board_setup(void)
 {
+	cpm2_map_t* immap = ioremap(CPM_MAP_ADDR, sizeof(cpm2_map_t));
+	u32 *bcsr = ioremap(BCSR_ADDR+4, sizeof(u32));
+
 	/* Enable the 2nd UART port */
-	*(volatile uint *)(BCSR_ADDR + 4) &= ~BCSR1_RS232_EN2;
+	clrbits32(bcsr, BCSR1_RS232_EN2);
+
+#ifdef CONFIG_SERIAL_CPM_SCC1
+	clrbits32((u32*)&immap->im_scc[0].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
+	clrbits32((u32*)&immap->im_scc[0].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SCC2
+	clrbits32((u32*)&immap->im_scc[1].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
+	clrbits32((u32*)&immap->im_scc[1].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SCC3
+	clrbits32((u32*)&immap->im_scc[2].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
+	clrbits32((u32*)&immap->im_scc[2].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+#endif
+
+#ifdef CONFIG_SERIAL_CPM_SCC4
+	clrbits32((u32*)&immap->im_scc[3].scc_sccm, UART_SCCM_TX | UART_SCCM_RX);
+	clrbits32((u32*)&immap->im_scc[3].scc_gsmrl, SCC_GSMRL_ENR | SCC_GSMRL_ENT);
+#endif
+
+	iounmap(bcsr);
+	iounmap(immap);
 }
