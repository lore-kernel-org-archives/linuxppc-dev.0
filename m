Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 33AEB67A65
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 23:47:37 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k5UDlZht002346
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 06:47:35 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id k5UDlVQX022626
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 08:47:32 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FF8@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Paul Mackerras'" <paulus@samba.org>
Subject: [PATCH 3/7 v2] powerpc: Add QE library qe_lib--common files
Date: Fri, 30 Jun 2006 21:47:24 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: Gridish Shlomi-RM96313 <gridish@freescale.com>, linuxppc-dev@ozlabs.org,
	Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

v2 change: 
Remove private mm, and change to use rheap.
Remove complex Kconfig to use device tree.
Minor changes.

Below is content:

The patch series adds QE generic API qe_lib.  QE is a new generation communication coprocessor in Freescale CPUs.

Signed-off-by: Shlomi Gridish <gridish@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/Kconfig                   |   12 +
 arch/powerpc/sysdev/Makefile           |    1 
 arch/powerpc/sysdev/ipic.c             |    2 
 arch/powerpc/sysdev/qe_lib/Kconfig     |   29 ++
 arch/powerpc/sysdev/qe_lib/Makefile    |    8 +
 arch/powerpc/sysdev/qe_lib/qe.c        |  181 ++++++++++++
 arch/powerpc/sysdev/qe_lib/qe_common.c |  361 ++++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/qe_ic.c     |  487 ++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/qe_ic.h     |   83 +++++
 arch/powerpc/sysdev/qe_lib/qe_io.c     |  275 ++++++++++++++++++
 10 files changed, 1439 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6729c98..6d4fc0b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -334,6 +334,16 @@ config APUS
 	  <http://linux-apus.sourceforge.net/>.
 endchoice
 
+config QUICC_ENGINE
+	bool
+	depends on MPC836x
+	default y
+	help
+	  The QE(QUICC Engine) is a new generation of coprocessor on 
+	  Freescale embedded CPUs(like CPM  in older chips).  Selecting
+	  this option means that you wish to build a kernel for a machine
+	  with QE coprocessor on it.
+
 config PPC_PSERIES
 	depends on PPC_MULTIPLATFORM && PPC64
 	bool "  IBM pSeries & new (POWER5-based) iSeries"
@@ -993,6 +1003,8 @@ # XXX source "arch/ppc/8xx_io/Kconfig"
 
 # XXX source "arch/ppc/8260_io/Kconfig"
 
+source "arch/powerpc/sysdev/qe_lib/Kconfig"
+
 source "arch/powerpc/platforms/iseries/Kconfig"
 
 source "lib/Kconfig"
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 4c2b356..cd1d5cc 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_PPC_83xx)		+= ipic.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
+obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index 8f01e0f..dbeccba 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -537,12 +537,14 @@ void ipic_set_highest_priority(unsigned 
 
 void ipic_set_default_priority(void)
 {
+#ifdef CONFIG_MPC834x
 	ipic_set_priority(MPC83xx_IRQ_TSEC1_TX, 0);
 	ipic_set_priority(MPC83xx_IRQ_TSEC1_RX, 1);
 	ipic_set_priority(MPC83xx_IRQ_TSEC1_ERROR, 2);
 	ipic_set_priority(MPC83xx_IRQ_TSEC2_TX, 3);
 	ipic_set_priority(MPC83xx_IRQ_TSEC2_RX, 4);
 	ipic_set_priority(MPC83xx_IRQ_TSEC2_ERROR, 5);
+#endif
 	ipic_set_priority(MPC83xx_IRQ_USB2_DR, 6);
 	ipic_set_priority(MPC83xx_IRQ_USB2_MPH, 7);
 
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
new file mode 100644
index 0000000..28487e4
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -0,0 +1,29 @@
+#
+# QE Communication options
+#
+
+menu "QE Options"
+	depends on QUICC_ENGINE
+
+config UCC_SLOW
+	bool "UCC Slow Protocols Support"
+	default n
+	select UCC
+	help
+	  This option provides qe_lib support to UCC slow
+	  protocols: UART, BISYNC, QMC
+
+config UCC_FAST
+	bool "UCC Fast Protocols Support"
+	default n
+	select UCC
+	help
+	  This option provides qe_lib support to UCC fast
+	  protocols: HDLC, Ethernet, ATM, transparent
+
+config UCC
+	bool
+	default y if UCC_FAST || UCC_SLOW
+
+endmenu
+
diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/sysdev/qe_lib/Makefile
new file mode 100644
index 0000000..9a54a81
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the linux ppc-specific parts of QE
+#
+obj-$(CONFIG_QUICC_ENGINE)+= qe_common.o qe.o qe_ic.o qe_io.o
+
+obj-$(CONFIG_UCC)	+= ucc.o
+obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
+obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o ucc_slow.o
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
new file mode 100644
index 0000000..0fbb54c
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -0,0 +1,181 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Li Yang <LeoLi@freescale.com>
+ *
+ * Description:
+ * FSL QE SOC setup.
+ *
+ * Changelog: 
+ * Jun 21, 2006	Initial version
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/major.h>
+#include <linux/delay.h>
+#include <linux/irq.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/fsl_devices.h>
+
+#include <asm/system.h>
+#include <asm/atomic.h>
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/prom.h>
+#include <sysdev/fsl_soc.h>
+#include <mm/mmu_decl.h>
+
+static phys_addr_t qebase = -1;
+
+phys_addr_t get_qe_base(void)
+{
+	struct device_node *qe;
+
+	if (qebase != -1)
+		return qebase;
+
+	qe = of_find_node_by_type(NULL, "qe");
+	if (qe) {
+		unsigned int size;
+		void *prop = get_property(qe, "reg", &size);
+		qebase = of_translate_address(qe, prop);
+		of_node_put(qe);
+	};
+
+	return qebase;
+}
+
+EXPORT_SYMBOL(get_qe_base);
+
+static int __init ucc_geth_of_init(void)
+{
+	struct device_node *np;
+	unsigned int i, ucc_num;
+	struct platform_device *ugeth_dev;
+	struct resource res;
+	int ret;
+
+	for (np = NULL, i = 0;
+	     (np = of_find_compatible_node(np, "network", "ucc_geth")) != NULL;
+	     i++) {
+		struct resource r[2];
+		struct device_node *phy, *mdio;
+		struct ucc_geth_platform_data ugeth_data;
+		unsigned int *id;
+		char *model;
+		void *mac_addr;
+		phandle *ph;
+
+		memset(r, 0, sizeof(r));
+		memset(&ugeth_data, 0, sizeof(ugeth_data));
+
+		ret = of_address_to_resource(np, 0, &r[0]);
+		if (ret)
+			goto err;
+
+		ugeth_data.phy_reg_addr = r[0].start;
+		r[1].start = np->intrs[0].line;
+		r[1].end = np->intrs[0].line;
+		r[1].flags = IORESOURCE_IRQ;
+
+		model = get_property(np, "model", NULL);
+		ucc_num = *((u32 *) get_property(np, "device-id", NULL));
+		if ((strstr(model, "UCC") == NULL) || 
+				(ucc_num < 1) || (ucc_num > 8)) {
+			ret = -ENODEV;
+			goto err;
+		}
+		
+		ugeth_dev =
+		    platform_device_register_simple("ucc_geth", ucc_num - 1,
+				    &r[0], np->n_intrs + 1);
+
+		if (IS_ERR(ugeth_dev)) {
+			ret = PTR_ERR(ugeth_dev);
+			goto err;
+		}
+
+		mac_addr = get_property(np, "mac-address", NULL);
+		
+		memcpy(ugeth_data.mac_addr, mac_addr, 6);
+
+		ugeth_data.rx_clock = *((u32 *) get_property(np, "rx-clock",
+					NULL));
+		ugeth_data.tx_clock = *((u32 *) get_property(np, "tx-clock",
+					NULL));
+
+		ph = (phandle *) get_property(np, "phy-handle", NULL);
+		phy = of_find_node_by_phandle(*ph);
+
+		if (phy == NULL) {
+			ret = -ENODEV;
+			goto unreg;
+		}
+
+		mdio = of_get_parent(phy);
+
+		id = (u32 *) get_property(phy, "reg", NULL);
+		ret = of_address_to_resource(mdio, 0, &res);
+		if (ret) {
+			of_node_put(phy);
+			of_node_put(mdio);
+			goto unreg;
+		}
+		
+		ugeth_data.phy_id = *id;
+		ugeth_data.phy_interrupt = phy->intrs[0].line; 
+		ugeth_data.phy_interface = *((u32 *) get_property(phy,
+					"interface", NULL));
+
+		/* FIXME: Work around for early chip rev.               */
+		/* There's a bug in initial chip rev(s) in the RGMII ac */
+		/* timing.						*/
+		/* The following compensates by writing to the reserved */
+		/* QE Port Output Hold Registers (CPOH1?).              */	
+		if ((ugeth_data.phy_interface == ENET_1000_RGMII) || 
+				(ugeth_data.phy_interface == ENET_100_RGMII) ||
+				(ugeth_data.phy_interface == ENET_10_RGMII)) {
+			u32 *tmp_reg = (u32 *) ioremap(get_immrbase() 
+					+ 0x14A8, 0x4);
+			u32 tmp_val = in_be32(tmp_reg);
+			if (ucc_num == 1)
+				out_be32(tmp_reg, tmp_val | 0x00003000);
+			else if (ucc_num == 2)
+				out_be32(tmp_reg, tmp_val | 0x0c000000);
+			iounmap(tmp_reg);
+		}
+		
+		if (phy->intrs[0].line != 0)
+			ugeth_data.board_flags |= FSL_UGETH_BRD_HAS_PHY_INTR;
+
+		of_node_put(phy);
+		of_node_put(mdio);
+
+		ret =
+		    platform_device_add_data(ugeth_dev, &ugeth_data,
+					     sizeof(struct
+						    ucc_geth_platform_data));
+		if (ret)
+			goto unreg;
+	}
+
+	return 0;
+
+unreg:
+	platform_device_unregister(ugeth_dev);
+err:
+	return ret;
+}
+
+arch_initcall(ucc_geth_of_init);
diff --git a/arch/powerpc/sysdev/qe_lib/qe_common.c b/arch/powerpc/sysdev/qe_lib/qe_common.c
new file mode 100644
index 0000000..84458a3
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_common.c
@@ -0,0 +1,361 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * General Purpose functions for the global management of the
+ * QUICC Engine (QE).
+ *
+ * Changelog:
+ * Jun 28, 2006	Li Yang <LeoLi@freescale.com>
+ * - Reorganized as qe_lib
+ * - Merged to powerpc arch; add device tree support
+ * - Style fixes
+ * Jun 30, 2006 Li Yang <LeoLi@freescale.com>
+ * - Change to use rheap instead of private mm lib
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/param.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/bootmem.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <asm/irq.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+#include <asm/prom.h>
+#include <asm/rheap.h>
+
+/* QE snum state
+*/
+typedef enum qe_snum_state {
+	QE_SNUM_STATE_USED,	/* used */
+	QE_SNUM_STATE_FREE	/* free */
+} qe_snum_state_e;
+
+/* QE snum
+*/
+typedef struct qe_snum {
+	u8 num;			/* snum  */
+	qe_snum_state_e state;	/* state */
+} qe_snum_t;
+
+/* We allocate this here because it is used almost exclusively for
+ * the communication processor devices.
+ */
+EXPORT_SYMBOL(qe_immr);
+qe_map_t *qe_immr = NULL;
+static qe_snum_t snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUMs  */
+
+static void qe_snums_init(void);
+static void qe_muram_init(void);
+static int qe_sdma_init(void);
+
+static DEFINE_SPINLOCK(qe_lock);
+
+void qe_reset(void)
+{
+	if (qe_immr == NULL)
+		qe_immr = (qe_map_t *) ioremap(get_qe_base(), QE_IMMAP_SIZE);
+
+	qe_snums_init();
+
+	qe_issue_cmd(QE_RESET, QE_CR_SUBBLOCK_INVALID,
+		     (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
+
+	/* Reclaim the MURAM memory for our use. */
+	qe_muram_init();
+
+	if (qe_sdma_init())
+		panic("sdma init failed!");
+}
+
+EXPORT_SYMBOL(qe_issue_cmd);
+int qe_issue_cmd(uint cmd, uint device, u8 mcn_protocol, u32 cmd_input)
+{
+	unsigned long flags;
+	u32 cecr;
+	u8 mcn_shift = 0, dev_shift = 0;
+
+	spin_lock_irqsave(&qe_lock, flags);
+	if (cmd == QE_RESET) {
+		out_be32(&qe_immr->cp.cecr, (u32) (cmd | QE_CR_FLG));
+	} else {
+		if (cmd == QE_ASSIGN_PAGE) {
+			/* Here device is the SNUM, not sub-block */
+			dev_shift = QE_CR_SNUM_SHIFT;
+		} else if (cmd == QE_ASSIGN_RISC) {
+			/* Here device is the SNUM, and mcnProtocol is
+			 * e_QeCmdRiscAssignment value */
+			dev_shift = QE_CR_SNUM_SHIFT;
+			mcn_shift = QE_CR_MCN_RISC_ASSIGN_SHIFT;
+		} else {
+			if (device == QE_CR_SUBBLOCK_USB)
+				mcn_shift = QE_CR_MCN_USB_SHIFT;
+			else
+				mcn_shift = QE_CR_MCN_NORMAL_SHIFT;
+		}
+
+		out_be32(&qe_immr->cp.cecdr,
+			 immrbar_virt_to_phys((void *)cmd_input));
+		out_be32(&qe_immr->cp.cecr,
+			 (cmd | QE_CR_FLG | ((u32) device << dev_shift) | (u32)
+			  mcn_protocol << mcn_shift));
+	}
+
+	/* wait for the QE_CR_FLG to clear */
+	do {
+		cecr = in_be32(&qe_immr->cp.cecr);
+	} while (cecr & QE_CR_FLG);
+	spin_unlock_irqrestore(&qe_lock, flags);
+
+	return 0;
+}
+
+/* Set a baud rate generator. This needs lots of work. There are
+ * 16 BRGs, which can be connected to the QE channels or output
+ * as clocks. The BRGs are in two different block of internal
+ * memory mapped space.
+ * The baud rate clock is the system clock divided by something.
+ * It was set up long ago during the initial boot phase and is
+ * is given to us.
+ * Baud rate clocks are zero-based in the driver code (as that maps
+ * to port numbers). Documentation uses 1-based numbering.
+ */
+static unsigned int brg_clk = 0;
+
+unsigned int get_brg_clk(void)
+{
+	struct device_node *qe;
+	if (brg_clk)
+		return brg_clk;
+
+	qe = of_find_node_by_type(NULL, "qe");
+	if (qe) {
+		unsigned int size;
+		u32 *prop = (u32 *) get_property(qe, "brg-frequency", &size);
+		brg_clk = *prop;
+		of_node_put(qe);
+	};
+	return brg_clk;
+}
+
+/* This function is used by UARTS, or anything else that uses a 16x
+ * oversampled clock.
+ */
+void qe_setbrg(uint brg, uint rate)
+{
+	volatile uint *bp;
+	u32 divisor;
+	int div16 = 0;
+
+	bp = (uint *) & qe_immr->brg.brgc1;
+	bp += brg;
+
+	divisor = (get_brg_clk() / rate);
+	if (divisor > QE_BRGC_DIVISOR_MAX + 1) {
+		div16 = 1;
+		divisor /= 16;
+	}
+
+	*bp = ((divisor - 1) << QE_BRGC_DIVISOR_SHIFT) | QE_BRGC_ENABLE;
+	if (div16)
+		*bp |= QE_BRGC_DIV16;
+}
+
+static void qe_snums_init(void)
+{
+	int i;
+
+	/* Initialize the SNUMs array. */
+	for (i = 0; i < QE_NUM_OF_SNUM; i++)
+		snums[i].state = QE_SNUM_STATE_FREE;
+
+	/* Initialize SNUMs (thread serial numbers) according to QE
+	 * spec chapter 4, SNUM table */
+	i = 0;
+	snums[i++].num = 0x04;
+	snums[i++].num = 0x05;
+	snums[i++].num = 0x0C;
+	snums[i++].num = 0x0D;
+	snums[i++].num = 0x14;
+	snums[i++].num = 0x15;
+	snums[i++].num = 0x1C;
+	snums[i++].num = 0x1D;
+	snums[i++].num = 0x24;
+	snums[i++].num = 0x25;
+	snums[i++].num = 0x2C;
+	snums[i++].num = 0x2D;
+	snums[i++].num = 0x34;
+	snums[i++].num = 0x35;
+	snums[i++].num = 0x88;
+	snums[i++].num = 0x89;
+	snums[i++].num = 0x98;
+	snums[i++].num = 0x99;
+	snums[i++].num = 0xA8;
+	snums[i++].num = 0xA9;
+	snums[i++].num = 0xB8;
+	snums[i++].num = 0xB9;
+	snums[i++].num = 0xC8;
+	snums[i++].num = 0xC9;
+	snums[i++].num = 0xD8;
+	snums[i++].num = 0xD9;
+	snums[i++].num = 0xE8;
+	snums[i++].num = 0xE9;
+}
+
+int qe_get_snum(void)
+{
+	unsigned long flags;
+	int snum = -EBUSY;
+	int i;
+
+	spin_lock_irqsave(&qe_lock, flags);
+	for (i = 0; i < QE_NUM_OF_SNUM; i++) {
+		if (snums[i].state == QE_SNUM_STATE_FREE) {
+			snums[i].state = QE_SNUM_STATE_USED;
+			snum = snums[i].num;
+			break;
+		}
+	}
+	spin_unlock_irqrestore(&qe_lock, flags);
+
+	return snum;
+}
+
+EXPORT_SYMBOL(qe_get_snum);
+
+void qe_put_snum(u8 snum)
+{
+	int i;
+
+	for (i = 0; i < QE_NUM_OF_SNUM; i++) {
+		if (snums[i].num == snum) {
+			snums[i].state = QE_SNUM_STATE_FREE;
+			break;
+		}
+	}
+}
+
+EXPORT_SYMBOL(qe_put_snum);
+
+static int qe_sdma_init(void)
+{
+	sdma_t *sdma = &qe_immr->sdma;
+	uint sdma_buf_offset;
+
+	if (!sdma)
+		return -ENODEV;
+
+	/* allocate 2 internal temporary buffers (512 bytes size each) for
+	 * the SDMA */
+	sdma_buf_offset = qe_muram_alloc(512 * 2, 64);
+	if (IS_MURAM_ERR(sdma_buf_offset))
+		return -ENOMEM;
+
+	out_be32(&sdma->sdebcr, sdma_buf_offset & QE_SDEBCR_BA_MASK);
+	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 >>
+					QE_SDMR_CEN_SHIFT)));
+
+	return 0;
+}
+
+/*
+ * muram_alloc / muram_free bits.
+ */
+static DEFINE_SPINLOCK(qe_muram_lock);
+
+/* 16 blocks should be enough to satisfy all requests
+ * until the memory subsystem goes up... */
+static rh_block_t qe_boot_muram_rh_block[16];
+static rh_info_t qe_muram_info;
+
+static void qe_muram_init(void)
+{
+	/* initialize the info header */
+	rh_init(&qe_muram_info, 1,
+		sizeof(qe_boot_muram_rh_block) /
+		sizeof(qe_boot_muram_rh_block[0]), qe_boot_muram_rh_block);
+	
+	/* Attach the usable muram area */
+	/* XXX: This is actually crap. QE_DATAONLY_BASE and
+	 * QE_DATAONLY_SIZE is only a subset of the available muram. It
+	 * varies with the processor and the microcode patches activated.
+	 * But the following should be at least safe.
+	 */
+	rh_attach_region(&qe_muram_info,
+			 (void *)QE_MURAM_DATAONLY_BASE,
+			 QE_MURAM_DATAONLY_SIZE);
+}
+
+/* This function returns an index into the MURAM area.
+ */
+uint qe_muram_alloc(uint size, uint align)
+{
+	void *start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	start = rh_alloc_align(&qe_muram_info, size, align, "QE");
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return (uint) start;
+}
+
+EXPORT_SYMBOL(qe_muram_alloc);
+
+int qe_muram_free(uint offset)
+{
+	int ret;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	ret = rh_free(&qe_muram_info, (void *)offset);
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return ret;
+}
+
+EXPORT_SYMBOL(qe_muram_free);
+
+/* not sure if this is ever needed */
+uint qe_muram_alloc_fixed(uint offset, uint size)
+{
+	void *start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	start =
+	    rh_alloc_fixed(&qe_muram_info, (void *)offset, size, "commproc");
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return (uint) start;
+}
+
+EXPORT_SYMBOL(qe_muram_alloc_fixed);
+
+void qe_muram_dump(void)
+{
+	rh_dump(&qe_muram_info);
+}
+
+EXPORT_SYMBOL(qe_muram_dump);
+
+void *qe_muram_addr(uint offset)
+{
+	return (void *)&qe_immr->muram[offset];
+}
+
+EXPORT_SYMBOL(qe_muram_addr);
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
new file mode 100644
index 0000000..465630e
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -0,0 +1,487 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * QE Interrupt Controller routines implementations.
+ *
+ * Changelog: 
+ * Jun 28, 2006 Li Yang <LeoLi@freescale.com>
+ * - Reorganized as qe_lib
+ * - Merged to powerpc arch; add device tree support
+ * - Style fixes
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/sysdev.h>
+#include <linux/interrupt.h>
+
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/qe_ic.h>
+
+#include "qe_ic.h"
+
+static struct qe_ic_private p_qe_ic;
+static struct qe_ic_private *primary_qe_ic;
+
+static struct qe_ic_info qe_ic_info[] = {
+	[1] = {
+	       .mask = 0x00008000,
+	       .qimr = 1,
+	       .pri_code = 0},
+	[2] = {
+	       .mask = 0x00004000,
+	       .qimr = 1,
+	       .pri_code = 1},
+	[3] = {
+	       .mask = 0x00002000,
+	       .qimr = 1,
+	       .pri_code = 2},
+	[10] = {
+		.mask = 0x00000040,
+		.qimr = 1,
+		.pri_code = 1},
+	[11] = {
+		.mask = 0x00000020,
+		.qimr = 1,
+		.pri_code = 2},
+	[12] = {
+		.mask = 0x00000010,
+		.qimr = 1,
+		.pri_code = 3},
+	[13] = {
+		.mask = 0x00000008,
+		.qimr = 1,
+		.pri_code = 4},
+	[14] = {
+		.mask = 0x00000004,
+		.qimr = 1,
+		.pri_code = 5},
+	[15] = {
+		.mask = 0x00000002,
+		.qimr = 1,
+		.pri_code = 6},
+	[20] = {
+		.mask = 0x10000000,
+		.qimr = 0,
+		.pri_code = 3},
+	[25] = {
+		.mask = 0x00800000,
+		.qimr = 0,
+		.pri_code = 0},
+	[26] = {
+		.mask = 0x00400000,
+		.qimr = 0,
+		.pri_code = 1},
+	[27] = {
+		.mask = 0x00200000,
+		.qimr = 0,
+		.pri_code = 2},
+	[28] = {
+		.mask = 0x00100000,
+		.qimr = 0,
+		.pri_code = 3},
+	[32] = {
+		.mask = 0x80000000,
+		.qimr = 1,
+		.pri_code = 0},
+	[33] = {
+		.mask = 0x40000000,
+		.qimr = 1,
+		.pri_code = 1},
+	[34] = {
+		.mask = 0x20000000,
+		.qimr = 1,
+		.pri_code = 2},
+	[35] = {
+		.mask = 0x10000000,
+		.qimr = 1,
+		.pri_code = 3},
+	[36] = {
+		.mask = 0x08000000,
+		.qimr = 1,
+		.pri_code = 4},
+	[40] = {
+		.mask = 0x00800000,
+		.qimr = 1,
+		.pri_code = 0},
+	[41] = {
+		.mask = 0x00400000,
+		.qimr = 1,
+		.pri_code = 1},
+	[42] = {
+		.mask = 0x00200000,
+		.qimr = 1,
+		.pri_code = 2},
+	[43] = {
+		.mask = 0x00100000,
+		.qimr = 1,
+		.pri_code = 3},
+};
+
+struct hw_interrupt_type qe_ic = {
+	.typename = "QE IC",
+	.enable = qe_ic_enable_irq,
+	.disable = qe_ic_disable_irq,
+	.ack = qe_ic_disable_irq_and_ack,
+	.end = qe_ic_end_irq,
+};
+
+static int qe_ic_get_low_irq(struct pt_regs *regs)
+{
+	struct qe_ic_private *p_qe_ic = primary_qe_ic;
+	int irq = -1;
+
+	/* get the low byte of SIVEC to get the interrupt source vector. */
+	irq = (in_be32(&p_qe_ic->regs->qivec) >> 24) >> 2;
+
+	if (irq == 0)		/* 0 --> no irq is pending */
+		return -1;
+
+	return irq + p_qe_ic->irq_offset;
+}
+
+static int qe_ic_get_high_irq(struct pt_regs *regs)
+{
+	struct qe_ic_private *p_qe_ic = primary_qe_ic;
+	int irq = -1;
+
+	/* get the high byte of SIVEC to get the interrupt source vector. */
+	irq = (in_be32(&p_qe_ic->regs->qhivec) >> 24) >> 2;
+
+	if (irq == 0)		/* 0 --> no irq is pending */
+		return -1;
+
+	return irq + p_qe_ic->irq_offset;
+}
+
+static irqreturn_t qe_ic_cascade_low(int irq, void *dev_id,
+				     struct pt_regs *regs)
+{
+	while ((irq = qe_ic_get_low_irq(regs)) >= 0)
+		__do_IRQ(irq, regs);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t qe_ic_cascade_high(int irq, void *dev_id,
+				      struct pt_regs *regs)
+{
+	while ((irq = qe_ic_get_high_irq(regs)) >= 0)
+		__do_IRQ(irq, regs);
+	return IRQ_HANDLED;
+}
+
+static struct irqaction qe_ic_low_irqaction = {
+	.handler = qe_ic_cascade_low,
+	.flags = SA_INTERRUPT,
+	.mask = CPU_MASK_NONE,
+	.name = "qe_ic_cascade_low",
+};
+
+static struct irqaction qe_ic_high_irqaction = {
+	.handler = qe_ic_cascade_high,
+	.flags = SA_INTERRUPT,
+	.mask = CPU_MASK_NONE,
+	.name = "qe_ic_cascade_high",
+};
+
+int qe_ic_init(phys_addr_t phys_addr,
+	       unsigned int flags, unsigned int irq_offset)
+{
+	struct qe_ic_map *regs;
+	u8 grp, pri, shift = 0;
+	u32 tmp_qicr = 0, tmp_qricr = 0, tmp_qicnr = 0, tmp_mask;
+	int i, high_hctive = 0;
+	const u32 high_signal = 2;
+
+	primary_qe_ic = &p_qe_ic;
+	memset(primary_qe_ic, 0, sizeof(struct qe_ic_private));
+
+	/* initialize QE interrupt controller registers */
+	primary_qe_ic->regs = regs =
+	    (struct qe_ic_map *)ioremap(phys_addr, QE_IC_SIZE);
+	primary_qe_ic->irq_offset = irq_offset;
+
+	/* default priority scheme is grouped. If spread mode is    */
+	/* required, configure sicr accordingly.                    */
+	if (flags & QE_IC_SPREADMODE_GRP_W)
+		tmp_qicr |= QICR_GWCC;
+	if (flags & QE_IC_SPREADMODE_GRP_X)
+		tmp_qicr |= QICR_GXCC;
+	if (flags & QE_IC_SPREADMODE_GRP_Y)
+		tmp_qicr |= QICR_GYCC;
+	if (flags & QE_IC_SPREADMODE_GRP_Z)
+		tmp_qicr |= QICR_GZCC;
+	if (flags & QE_IC_SPREADMODE_GRP_RISCA)
+		tmp_qicr |= QICR_GRTA;
+	if (flags & QE_IC_SPREADMODE_GRP_RISCB)
+		tmp_qicr |= QICR_GRTB;
+
+	/* choose destination signal for highest priority interrupt */
+	if (flags & QE_IC_HIGH_SIGNAL) {
+		tmp_qicr |= (high_signal << QICR_HPIT_SHIFT);
+		high_hctive = 1;
+	}
+
+	out_be32(&regs->qicr, tmp_qicr);
+
+	tmp_mask = (1 << QE_IC_GRP_W_DEST_SIGNAL_SHIFT);
+	/* choose destination signal for highest priority interrupt in each
+	 * group */
+	for (grp = 0; grp < NUM_OF_QE_IC_GROUPS; grp++) {
+		/* the first 2 priorities in each group have a choice of
+		 * destination signal */
+		for (pri = 0; pri <= 1; pri++) {
+			if (flags & ((tmp_mask << (grp << 1)) << pri)) {
+				/* indicate whether QE High signal is
+				 * required */
+				if (!high_hctive)
+					high_hctive = 1;
+
+				/* The location of the bits relevant to
+				 * priority 0 in the   */
+				/* registers is always 2 bits left comparing
+				 * to priority 1. */
+				if (pri == 0)
+					shift = 2;
+
+				switch (grp) {
+				case (QE_IC_GRP_W):
+					shift += QICNR_WCC1T_SHIFT;
+					tmp_qicnr |= high_signal << shift;
+					break;
+				case (QE_IC_GRP_X):
+					shift += QICNR_XCC1T_SHIFT;
+					tmp_qicnr |= high_signal << shift;
+					break;
+				case (QE_IC_GRP_Y):
+					shift += QICNR_YCC1T_SHIFT;
+					tmp_qicnr |= high_signal << shift;
+					break;
+				case (QE_IC_GRP_Z):
+					shift += QICNR_ZCC1T_SHIFT;
+					tmp_qicnr |= high_signal << shift;
+					break;
+				case (QE_IC_GRP_RISCA):
+					shift += QRICR_RTA1T_SHIFT;
+					tmp_qricr |= high_signal << shift;
+					break;
+				case (QE_IC_GRP_RISCB):
+					shift += QRICR_RTB1T_SHIFT;
+					tmp_qricr |= high_signal << shift;
+					break;
+				default:
+					break;
+				}
+			}
+		}
+	}
+
+	if (tmp_qicnr)
+		out_be32(&regs->qicnr, tmp_qicnr);
+	if (tmp_qricr)
+		out_be32(&regs->qricr, tmp_qricr);
+
+	for (i = primary_qe_ic->irq_offset;
+	     i < (NR_QE_IC_INTS + primary_qe_ic->irq_offset); i++) {
+		irq_desc[i].handler = &qe_ic;
+		irq_desc[i].status = IRQ_LEVEL;
+	}
+
+	/* register QE_IC interrupt controller in the a higher hirarchy
+	 * controller */
+	setup_irq(IRQ_QE_LOW, &qe_ic_low_irqaction);
+
+	if (high_hctive)
+		/* register QE_IC high interrupt source in the higher
+		 * hirarchy controller */
+		setup_irq(IRQ_QE_HIGH, &qe_ic_high_irqaction);
+
+	printk("QE IC (%d IRQ sources) at %p\n", NR_QE_IC_INTS,
+	       primary_qe_ic->regs);
+	return 0;
+}
+
+void qe_ic_free(void)
+{
+}
+
+void qe_ic_enable_irq(unsigned int irq)
+{
+	struct qe_ic_private *p_qe_ic = primary_qe_ic;
+	unsigned int src = irq - p_qe_ic->irq_offset;
+	u32 qimr;
+
+	if (qe_ic_info[src].qimr) {
+		qimr = in_be32(&((struct qe_ic_private *)p_qe_ic)->regs->qimr);
+		out_be32(&((struct qe_ic_private *)p_qe_ic)->regs->qimr,
+			 qimr | (qe_ic_info[src].mask));
+	} else {
+		qimr = in_be32(&((struct qe_ic_private *)p_qe_ic)->regs->qrimr);
+		out_be32(&((struct qe_ic_private *)p_qe_ic)->regs->qrimr,
+			 qimr | (qe_ic_info[src].mask));
+	}
+}
+
+void qe_ic_disable_irq(unsigned int irq)
+{
+	struct qe_ic_private *p_qe_ic = primary_qe_ic;
+	unsigned int src = irq - p_qe_ic->irq_offset;
+	u32 qimr;
+
+	if (qe_ic_info[src].qimr) {
+		qimr = in_be32(&((struct qe_ic_private *)p_qe_ic)->regs->qimr);
+		out_be32(&((struct qe_ic_private *)p_qe_ic)->regs->qimr,
+			 qimr & ~(qe_ic_info[src].mask));
+	} else {
+		qimr = in_be32(&((struct qe_ic_private *)p_qe_ic)->regs->qrimr);
+		out_be32(&((struct qe_ic_private *)p_qe_ic)->regs->qrimr,
+			 qimr & ~(qe_ic_info[src].mask));
+	}
+}
+
+void qe_ic_disable_irq_and_ack(unsigned int irq)
+{
+	qe_ic_disable_irq(irq);
+}
+
+void qe_ic_end_irq(unsigned int irq)
+{
+
+	if (!(irq_desc[irq].status & (IRQ_DISABLED | IRQ_INPROGRESS))
+	    && irq_desc[irq].action)
+		qe_ic_enable_irq(irq);
+}
+
+void qe_ic_modify_highest_priority(unsigned int irq)
+{
+	struct qe_ic_private *p_qe_ic = primary_qe_ic;
+	unsigned int src = irq - p_qe_ic->irq_offset;
+	u32 tmp_qicr = 0;
+
+	tmp_qicr = in_be32(&p_qe_ic->regs->qicr);
+	out_be32(&p_qe_ic->regs->qicr, (u32) (tmp_qicr | ((u8) src << 24)));
+}
+
+void qe_ic_modify_priority(enum qe_ic_grp_id grp,
+			   unsigned int pri0,
+			   unsigned int pri1,
+			   unsigned int pri2,
+			   unsigned int pri3,
+			   unsigned int pri4,
+			   unsigned int pri5,
+			   unsigned int pri6, unsigned int pri7)
+{
+	struct qe_ic_private *p_qe_ic = primary_qe_ic;
+	volatile u32 *p_qip = 0;
+	u32 tmp_qip = 0;
+	u8 tmp_array[8] = { 0, 0, 0, 0, 0, 0, 0, 0 };
+	signed char code_array[8], i = 0, j = 0;
+
+	code_array[0] = (signed char)(pri0 ? qe_ic_info[pri0].pri_code : -1);
+	code_array[1] = (signed char)(pri1 ? qe_ic_info[pri1].pri_code : -1);
+	code_array[2] = (signed char)(pri2 ? qe_ic_info[pri2].pri_code : -1);
+	code_array[3] = (signed char)(pri3 ? qe_ic_info[pri3].pri_code : -1);
+	code_array[4] = (signed char)(pri4 ? qe_ic_info[pri4].pri_code : -1);
+	code_array[5] = (signed char)(pri5 ? qe_ic_info[pri5].pri_code : -1);
+	code_array[6] = (signed char)(pri6 ? qe_ic_info[pri6].pri_code : -1);
+	code_array[7] = (signed char)(pri7 ? qe_ic_info[pri7].pri_code : -1);
+
+	for (i = 0; i < 8; i++) {
+		if (code_array[i] == -1)
+			break;
+		tmp_array[code_array[i]] = 1;
+	}
+
+	for (; i < 8; i++) {
+		while (tmp_array[j] && j < 8)
+			j++;
+		code_array[i] = j;
+		tmp_array[j] = 1;
+	}
+
+	tmp_qip = (u32) (code_array[0] << QIPCC_SHIFT_PRI0 |
+			 code_array[1] << QIPCC_SHIFT_PRI1 |
+			 code_array[2] << QIPCC_SHIFT_PRI2 |
+			 code_array[3] << QIPCC_SHIFT_PRI3 |
+			 code_array[4] << QIPCC_SHIFT_PRI4 |
+			 code_array[5] << QIPCC_SHIFT_PRI5 |
+			 code_array[6] << QIPCC_SHIFT_PRI6 |
+			 code_array[7] << QIPCC_SHIFT_PRI7);
+
+	switch (grp) {
+	case (QE_IC_GRP_W):
+		p_qip = &(p_qe_ic->regs->qipwcc);
+		break;
+	case (QE_IC_GRP_X):
+		p_qip = &(p_qe_ic->regs->qipxcc);
+		break;
+	case (QE_IC_GRP_Y):
+		p_qip = &(p_qe_ic->regs->qipycc);
+		break;
+	case (QE_IC_GRP_Z):
+		p_qip = &(p_qe_ic->regs->qipzcc);
+		break;
+	case (QE_IC_GRP_RISCA):
+		p_qip = &(p_qe_ic->regs->qiprta);
+		break;
+	case (QE_IC_GRP_RISCB):
+		p_qip = &(p_qe_ic->regs->qiprtb);
+		break;
+	default:
+		break;
+	}
+
+	out_be32(p_qip, tmp_qip);
+}
+
+void qe_ic_dump_regs(void)
+{
+	struct qe_ic_private *p_qe_ic = primary_qe_ic;
+
+	printk(KERN_INFO "QE IC registars:\n");
+	printk(KERN_INFO "Base address: 0x%08x\n", (u32) p_qe_ic->regs);
+	printk(KERN_INFO "qicr  : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qicr, in_be32(&p_qe_ic->regs->qicr));
+	printk(KERN_INFO "qivec : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qivec, in_be32(&p_qe_ic->regs->qivec));
+	printk(KERN_INFO "qripnr: addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qripnr, in_be32(&p_qe_ic->regs->qripnr));
+	printk(KERN_INFO "qipnr : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qipnr, in_be32(&p_qe_ic->regs->qipnr));
+	printk(KERN_INFO "qipxcc: addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qipxcc, in_be32(&p_qe_ic->regs->qipxcc));
+	printk(KERN_INFO "qipycc: addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qipycc, in_be32(&p_qe_ic->regs->qipycc));
+	printk(KERN_INFO "qipwcc: addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qipwcc, in_be32(&p_qe_ic->regs->qipwcc));
+	printk(KERN_INFO "qipzcc: addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qipzcc, in_be32(&p_qe_ic->regs->qipzcc));
+	printk(KERN_INFO "qimr  : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qimr, in_be32(&p_qe_ic->regs->qimr));
+	printk(KERN_INFO "qrimr : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qrimr, in_be32(&p_qe_ic->regs->qrimr));
+	printk(KERN_INFO "qicnr : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qicnr, in_be32(&p_qe_ic->regs->qicnr));
+	printk(KERN_INFO "qiprta: addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qiprta, in_be32(&p_qe_ic->regs->qiprta));
+	printk(KERN_INFO "qiprtb: addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qiprtb, in_be32(&p_qe_ic->regs->qiprtb));
+	printk(KERN_INFO "qricr : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qricr, in_be32(&p_qe_ic->regs->qricr));
+	printk(KERN_INFO "qhivec: addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & p_qe_ic->regs->qhivec, in_be32(&p_qe_ic->regs->qhivec));
+}
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.h b/arch/powerpc/sysdev/qe_lib/qe_ic.h
new file mode 100644
index 0000000..6662ad2
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.h
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Shlomi Gridish <gridish@freescale.com>
+ *
+ * Description:
+ * QE IC private definitions and structure.
+ *
+ * Changelog:
+ * Jun 21, 2006 Li Yang <LeoLi@freescale.com>
+ * - Style fix; port to powerpc arch
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __QE_IC_H__
+#define __QE_IC_H__
+
+typedef struct qe_ic_map {
+	volatile u32 qicr;
+	volatile u32 qivec;
+	volatile u32 qripnr;
+	volatile u32 qipnr;
+	volatile u32 qipxcc;
+	volatile u32 qipycc;
+	volatile u32 qipwcc;
+	volatile u32 qipzcc;
+	volatile u32 qimr;
+	volatile u32 qrimr;
+	volatile u32 qicnr;
+	volatile u8 res0[0x4];
+	volatile u32 qiprta;
+	volatile u32 qiprtb;
+	volatile u8 res1[0x4];
+	volatile u32 qricr;
+	volatile u8 res2[0x20];
+	volatile u32 qhivec;
+	volatile u8 res3[0x1C];
+} __attribute__ ((packed)) qe_ic_map_t;
+
+
+#define QE_IC_SIZE sizeof(struct qe_ic_map)
+
+/* Interrupt priority registers */
+#define QIPCC_SHIFT_PRI0        29
+#define QIPCC_SHIFT_PRI1        26
+#define QIPCC_SHIFT_PRI2        23
+#define QIPCC_SHIFT_PRI3        20
+#define QIPCC_SHIFT_PRI4        13
+#define QIPCC_SHIFT_PRI5        10
+#define QIPCC_SHIFT_PRI6        7
+#define QIPCC_SHIFT_PRI7        4
+
+/* QICR priority modes */
+#define QICR_GWCC               0x00040000
+#define QICR_GXCC               0x00020000
+#define QICR_GYCC               0x00010000
+#define QICR_GZCC               0x00080000
+#define QICR_GRTA               0x00200000
+#define QICR_GRTB               0x00400000
+#define QICR_HPIT_SHIFT         8
+
+/* QICNR */
+#define QICNR_WCC1T_SHIFT       20
+#define QICNR_ZCC1T_SHIFT       28
+#define QICNR_YCC1T_SHIFT       12
+#define QICNR_XCC1T_SHIFT       4
+
+/* QRICR */
+#define QRICR_RTA1T_SHIFT       20
+#define QRICR_RTB1T_SHIFT       28
+
+struct qe_ic_private {
+	struct qe_ic_map *regs;
+	unsigned int irq_offset;
+} qe_ic_private_t;
+
+extern struct hw_interrupt_type qe_ic;
+extern int qe_ic_get_irq(struct pt_regs *regs);
+
+#endif				/* __QE_IC_H__ */
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
new file mode 100644
index 0000000..a943c27
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -0,0 +1,275 @@
+/*
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Li Yang <LeoLi@freescale.com>
+ *
+ * Description:
+ * QE Parallel I/O ports configuration routines.  Based on code from
+ * Shlomi Gridish <gridish@freescale.com>
+ *
+ * Changelog:
+ * Jun 21, 2006	Initial version
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/stddef.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <sysdev/fsl_soc.h>
+#undef DEBUG
+
+#define NUM_OF_PINS     32
+#define NUM_OF_PAR_IOS  7
+
+typedef struct par_io {
+	struct {
+		u32 cpodr;	/* Open drain register */
+		u32 cpdata;	/* Data register */
+		u32 cpdir1;	/* Direction register */
+		u32 cpdir2;	/* Direction register */
+		u32 cppar1;	/* Pin assignment register */
+		u32 cppar2;	/* Pin assignment register */
+	} io_regs[NUM_OF_PAR_IOS];
+} par_io_t;
+
+typedef struct qe_par_io {
+	u8 res[0xc];
+	u32 cepier;		/* QE ports interrupt event register */
+	u32 cepimr;		/* QE ports mask event register */
+	u32 cepicr;		/* QE ports control event register */
+} qe_par_io_t;
+
+static int qe_irq_ports[NUM_OF_PAR_IOS][NUM_OF_PINS] = {
+	/* 0-7 */          /* 8-15 */      /* 16 - 23 */     /* 24 - 31 */
+	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1, 1,0,0,0,0,0,0,0, 0,0,0,0,0,1,1,0},
+	{0,0,0,1,0,1,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0, 0,0,1,1,0,0,0,0},
+	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,1,1,1,0,0},
+	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 1,1,0,0,0,0,0,0, 0,0,1,1,0,0,0,0},
+	{0,0,0,0,0,0,0,0, 0,0,0,0,1,1,0,0, 0,0,0,0,0,0,0,0, 1,1,1,1,0,0,0,1},
+	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,1,0,0,0, 0,0,0,0,0,0,0,0},
+	{0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,0, 0,0,0,0,0,0,0,1}
+};
+
+
+static u8 get_irq_num(u8 port, u8 pin)
+{
+	int i, j;
+	u8 num = 0;
+
+	if (qe_irq_ports[port][pin] == 0) 
+		return -1;
+	for (j = 0; j <= port; j++)
+		for (i = 0; i < pin; i++)
+			if (qe_irq_ports[j][i])
+				num++;
+	return num;
+}
+
+static par_io_t *par_io = NULL;
+static qe_par_io_t *qe_par_io = NULL;
+
+int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
+		      int assignment, int has_irq)
+{
+	u32 pinMask1bit, pinMask2bits, newMask2bits, tmp_val;
+
+	if (!par_io) {
+		par_io = (par_io_t *) ioremap(get_immrbase() + 0x1400,
+					      sizeof(par_io_t));
+		qe_par_io = (qe_par_io_t *) ioremap(get_immrbase() + 0xC00,
+						    sizeof(qe_par_io_t));
+
+		/* clear event bits in the event register of the QE ports */
+		out_be32(&qe_par_io->cepier, 0xFFFFFFFF);
+	}
+
+	/* calculate pin location for single and 2 bits  information */
+	pinMask1bit = (u32) (1 << (NUM_OF_PINS - (pin + 1)));
+
+	/* Set open drain, if required */
+	tmp_val = in_be32(&par_io->io_regs[port].cpodr);
+	if (open_drain)
+		out_be32(&par_io->io_regs[port].cpodr, pinMask1bit | tmp_val);
+	else
+		out_be32(&par_io->io_regs[port].cpodr, ~pinMask1bit & tmp_val);
+
+	/* define direction */
+	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
+	    in_be32(&par_io->io_regs[port].cpdir2) :
+	    in_be32(&par_io->io_regs[port].cpdir1);
+
+	/* get all bits mask for 2 bit per port */
+	pinMask2bits = (u32) (0x3 <<
+			      (NUM_OF_PINS -
+			       (pin % (NUM_OF_PINS / 2) + 1) * 2));
+
+	/* Get the final mask we need for the right definition */
+	newMask2bits = (u32) (dir <<
+			      (NUM_OF_PINS -
+			       (pin % (NUM_OF_PINS / 2) + 1) * 2));
+
+	/* clear and set 2 bits mask */
+	if (pin > (NUM_OF_PINS / 2) - 1) {
+		out_be32(&par_io->io_regs[port].cpdir2,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io->io_regs[port].cpdir2, newMask2bits | tmp_val);
+	} else {
+		out_be32(&par_io->io_regs[port].cpdir1,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io->io_regs[port].cpdir1, newMask2bits | tmp_val);
+	}
+	/* define pin assignment */
+	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
+	    in_be32(&par_io->io_regs[port].cppar2) :
+	    in_be32(&par_io->io_regs[port].cppar1);
+
+	newMask2bits = (u32) (assignment << (NUM_OF_PINS -
+			(pin % (NUM_OF_PINS / 2) + 1) * 2));
+	/* clear and set 2 bits mask */
+	if (pin > (NUM_OF_PINS / 2) - 1) {
+		out_be32(&par_io->io_regs[port].cppar2,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io->io_regs[port].cppar2, newMask2bits | tmp_val);
+	} else {
+		out_be32(&par_io->io_regs[port].cppar1,
+			 ~pinMask2bits & tmp_val);
+		tmp_val &= ~pinMask2bits;
+		out_be32(&par_io->io_regs[port].cppar1, newMask2bits | tmp_val);
+	}
+
+	/* Set interrupt mask if the pin generates interrupt */
+	if (has_irq) {
+		int irq = get_irq_num(port, pin);
+		u32 mask = 0;
+
+		if (irq == -1) {
+			printk(KERN_WARNING "Port %d, pin %d is can't be "
+					"interrupt\n", port, pin);
+			return -EINVAL;
+		}
+		mask = 0x80000000 >> irq;
+
+		tmp_val = in_be32(&qe_par_io->cepimr);
+		out_be32(&qe_par_io->cepimr, mask | tmp_val);
+	}
+
+	return 0;
+}
+
+EXPORT_SYMBOL(par_io_config_pin);
+
+int par_io_data_set(u8 port, u8 pin, u8 val)
+{
+	u32 pin_mask, tmp_val;
+
+	if (port >= NUM_OF_PAR_IOS)
+		return -EINVAL;
+	if (pin >= NUM_OF_PINS)
+		return -EINVAL;
+	/* calculate pin location */
+	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - pin));
+
+	tmp_val = in_be32(&par_io->io_regs[port].cpdata);
+
+	if (val == 0)		/* clear  */
+		out_be32(&par_io->io_regs[port].cpdata, ~pin_mask & tmp_val);
+	else			/* set */
+		out_be32(&par_io->io_regs[port].cpdata, pin_mask | tmp_val);
+
+	return 0;
+}
+
+EXPORT_SYMBOL(par_io_data_set);
+
+int par_io_of_config(struct device_node *np)
+{
+	struct device_node *pio;
+	phandle *ph;
+	int pio_map_len;
+	unsigned int *pio_map;
+	
+	ph = (phandle *) get_property(np, "pio-handle", NULL);
+	if (ph == 0) {
+		printk(KERN_ERR "pio-handle not available \n");
+		return -1;
+	}
+		
+	pio = of_find_node_by_phandle(*ph);
+
+	pio_map = (unsigned int *)
+		get_property(pio, "pio-map", &pio_map_len);
+	if (pio_map == NULL) {
+		printk(KERN_ERR "pio-map is not set! \n");
+		return -1;
+	}
+	pio_map_len /= sizeof(unsigned int);
+	if ((pio_map_len % 6) != 0) {
+		printk(KERN_ERR "pio-map format wrong! \n");
+		return -1;
+	}
+
+	while (pio_map_len > 0) {
+		par_io_config_pin((u8) pio_map[0], (u8) pio_map[1],
+				(int) pio_map[2], (int) pio_map[3],
+				(int) pio_map[4], (int) pio_map[5]);
+		pio_map += 6;
+		pio_map_len -= 6;
+	}
+	of_node_put(pio);
+	return 0;
+}
+EXPORT_SYMBOL(par_io_of_config);
+
+#ifdef DEBUG
+static void dump_par_io(void)
+{
+	int i;
+
+	printk(KERN_INFO "PAR IO registars:\n");
+	printk(KERN_INFO "Base address: 0x%08x\n", (u32) par_io);
+	for (i = 0; i < NUM_OF_PAR_IOS; i++) {
+		printk(KERN_INFO "cpodr[%d] : addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cpodr,
+		       in_be32(&par_io->io_regs[i].cpodr));
+		printk(KERN_INFO "cpdata[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cpdata,
+		       in_be32(&par_io->io_regs[i].cpdata));
+		printk(KERN_INFO "cpdir1[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cpdir1,
+		       in_be32(&par_io->io_regs[i].cpdir1));
+		printk(KERN_INFO "cpdir2[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cpdir2,
+		       in_be32(&par_io->io_regs[i].cpdir2));
+		printk(KERN_INFO "cppar1[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cppar1,
+		       in_be32(&par_io->io_regs[i].cppar1));
+		printk(KERN_INFO "cppar2[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io->io_regs[i].cppar2,
+		       in_be32(&par_io->io_regs[i].cppar2));
+	}
+
+	printk(KERN_INFO "QE PAR IO registars:\n");
+	printk(KERN_INFO "Base address: 0x%08x\n", (u32) qe_par_io);
+	printk(KERN_INFO "cepier : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & qe_par_io->cepier, in_be32(&qe_par_io->cepier));
+	printk(KERN_INFO "cepimr : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & qe_par_io->cepimr, in_be32(&qe_par_io->cepimr));
+	printk(KERN_INFO "cepicr : addr - 0x%08x, val - 0x%08x\n",
+	       (u32) & qe_par_io->cepicr, in_be32(&qe_par_io->cepicr));
+}
+
+EXPORT_SYMBOL(dump_par_io);
+#endif
