Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 92325679E0
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 12:08:07 +1000 (EST)
Date: Mon, 2 Oct 2006 21:07:40 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2.1/7] Add QUICC Engine (QE) infrastructure
Message-Id: <20061002210740.2ede2953.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>


note: linuxppc-dev rejected patch 2/7, so I split 2/7 into two, of which this is the first. This patch only adds files in a new directory (arch/powerpc/sysdev/qe_lib) so as not to break git-bisect.


Add QUICC Engine (QE) configuration, header files, and
QE management and library code that are used by QE devices
drivers.

Includes Leo's modifications up to, and including, the
platform_device to of_device adaptation:

"The series of patches add generic QE infrastructure called
qe_lib, and MPC8360EMDS board support.  Qe_lib is used by
QE device drivers such as ucc_geth driver.

This version updates QE interrupt controller to use new irq
mapping mechanism, addresses all the comments received with
last submission and includes some style fixes.

v2: Change to use device tree for BCSR and MURAM;
Remove I/O port interrupt handling code as it is not generic
enough.

v3: Address comments from Kumar;  Update definition of several
device tree nodes;  Copyright style change."

In addition, the following changes have been made:

o removed typedefs
o uint -> u32 conversions
o removed following defines:
  QE_SIZEOF_BD, BD_BUFFER_ARG, BD_BUFFER_CLEAR, BD_BUFFER,
  BD_STATUS_AND_LENGTH_SET, BD_STATUS_AND_LENGTH, and BD_BUFFER_SET
  because they hid sizeof/in_be32/out_be32 operations from the reader.
o fixed qe_snums_init() serial num assignment to use a const array
o made CONFIG_UCC_FAST select UCC_SLOW
o reduced NR_QE_IC_INTS from 128 to 64
o remove _IO_BASE, etc. defines (not used)
o removed irrelevant comments, added others to resemble removed BD_ defines
o realigned struct definitions in headers
o various other style fixes including things like pinMask -> pin_mask
o fixed a ton of whitespace issues

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Shlomi Gridish <gridish@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>

---
 arch/powerpc/sysdev/qe_lib/Kconfig     |   30 ++
 arch/powerpc/sysdev/qe_lib/Makefile    |    8 
 arch/powerpc/sysdev/qe_lib/qe.c        |  177 ++++++++++
 arch/powerpc/sysdev/qe_lib/qe_common.c |  353 ++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/qe_ic.c     |  555 ++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/qe_ic.h     |  106 ++++++
 arch/powerpc/sysdev/qe_lib/qe_io.c     |  227 +++++++++++++
 arch/powerpc/sysdev/qe_lib/ucc.c       |  251 ++++++++++++++
 arch/powerpc/sysdev/qe_lib/ucc_fast.c  |  397 +++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/ucc_slow.c  |  404 +++++++++++++++++++++++
 10 files changed, 2508 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
new file mode 100644
index 0000000..a725e80
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -0,0 +1,30 @@
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
+	select UCC_SLOW
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
index 0000000..d15a3c2
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/Makefile
@@ -0,0 +1,8 @@
+#
+# Makefile for the linux ppc-specific parts of QE
+#
+obj-$(CONFIG_QUICC_ENGINE)+= qe_common.o qe_ic.o qe_io.o
+
+obj-$(CONFIG_UCC)	+= ucc.o
+obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
+obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
new file mode 100644
index 0000000..8c35f09
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -0,0 +1,177 @@
+/*
+ * arch/powerpc/sysdev/qe_lib/qe.c
+ *
+ * FSL QE SOC setup.
+ *
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Author: Li Yang <LeoLi@freescale.com>
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
+		r[1].start = r[1].end = irq_of_parse_and_map(np, 0);
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
+				    &r[0], 2);
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
+
+		ugeth_data.phy_interrupt = irq_of_parse_and_map(phy, 0);
+		ugeth_data.phy_interface = *((u32 *) get_property(phy,
+					"interface", NULL));
+
+		/*
+		 * FIXME: Work around for early chip rev
+		 * There's a bug in initial chip rev(s) in the RGMII ac
+		 * timing. The following compensates by writing to the reserved
+		 * QE Port Output Hold Registers (CPOH1?)
+		 */
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
+		if (ugeth_data.phy_interrupt != 0)
+			ugeth_data.board_flags |= FSL_UGETH_BRD_HAS_PHY_INTR;
+
+		of_node_put(phy);
+		of_node_put(mdio);
+
+		ret = platform_device_add_data(ugeth_dev, &ugeth_data,
+				sizeof(struct ucc_geth_platform_data));
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
index 0000000..666aa90
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_common.c
@@ -0,0 +1,353 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ * Based on cpm2_common.c from Dan Malek (dmalek@jlc.net)
+ *
+ * Description:
+ * General Purpose functions for the global management of the
+ * QUICC Engine (QE).
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
+#include <linux/ioport.h>
+#include <asm/irq.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+#include <asm/prom.h>
+#include <asm/rheap.h>
+
+static void qe_snums_init(void);
+static void qe_muram_init(void);
+static int qe_sdma_init(void);
+
+static DEFINE_SPINLOCK(qe_lock);
+
+/* QE snum state */
+enum qe_snum_state {
+	QE_SNUM_STATE_USED,	/* used */
+	QE_SNUM_STATE_FREE	/* free */
+};
+
+/* QE snum */
+struct qe_snum {
+	u8 num;				/* snum */
+	enum qe_snum_state state;	/* state */
+};
+
+/* We allocate this here because it is used almost exclusively for
+ * the communication processor devices.
+ */
+struct qe_immap *qe_immr = NULL;
+EXPORT_SYMBOL(qe_immr);
+
+static struct qe_snum snums[QE_NUM_OF_SNUM];	/* Dynamically allocated SNUMs */
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
+void qe_reset(void)
+{
+	if (qe_immr == NULL)
+		qe_immr = (struct qe_immap *) ioremap(get_qe_base(), QE_IMMAP_SIZE);
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
+int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input)
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
+EXPORT_SYMBOL(qe_issue_cmd);
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
+void qe_setbrg(u32 brg, u32 rate)
+{
+	volatile u32 *bp;
+	u32 divisor;
+	int div16 = 0;
+
+	bp = (u32 *) & qe_immr->brg.brgc1;
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
+/* Initialize SNUMs (thread serial numbers) according to
+ * QE Module Control chapter, SNUM table
+ */
+static void qe_snums_init(void)
+{
+	int i;
+	static const u8 snum_init[] = {
+		0x04, 0x05, 0x0C, 0x0D, 0x14, 0x15, 0x1C, 0x1D,
+		0x24, 0x25, 0x2C, 0x2D, 0x34, 0x35, 0x88, 0x89,
+		0x98, 0x99, 0xA8, 0xA9, 0xB8, 0xB9, 0xC8, 0xC9,
+		0xD8, 0xD9, 0xE8, 0xE9,
+	};
+
+	for (i = 0; i < QE_NUM_OF_SNUM; i++) {
+		snums[i].num = snum_init[i];
+		snums[i].state = QE_SNUM_STATE_FREE;
+	}
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
+EXPORT_SYMBOL(qe_put_snum);
+
+static int qe_sdma_init(void)
+{
+	struct sdma *sdma = &qe_immr->sdma;
+	u32 sdma_buf_offset;
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
+	struct device_node *np;
+	u32 address;
+	u64 size;
+	unsigned int flags;
+
+	/* initialize the info header */
+	rh_init(&qe_muram_info, 1,
+		sizeof(qe_boot_muram_rh_block) /
+		sizeof(qe_boot_muram_rh_block[0]), qe_boot_muram_rh_block);
+
+	/* Attach the usable muram area */
+	/* XXX: This is a subset of the available muram. It
+	 * varies with the processor and the microcode patches activated.
+	 */
+	if ((np = of_find_node_by_name(NULL, "data-only")) != NULL) {
+		address = *of_get_address(np, 0, &size, &flags);
+		of_node_put(np);
+		rh_attach_region(&qe_muram_info,
+			(void *)address, (int)size);
+	}
+}
+
+/* This function returns an index into the MURAM area.
+ */
+u32 qe_muram_alloc(u32 size, u32 align)
+{
+	void *start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	start = rh_alloc_align(&qe_muram_info, size, align, "QE");
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return (u32) start;
+}
+EXPORT_SYMBOL(qe_muram_alloc);
+
+int qe_muram_free(u32 offset)
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
+EXPORT_SYMBOL(qe_muram_free);
+
+/* not sure if this is ever needed */
+u32 qe_muram_alloc_fixed(u32 offset, u32 size)
+{
+	void *start;
+	unsigned long flags;
+
+	spin_lock_irqsave(&qe_muram_lock, flags);
+	start = rh_alloc_fixed(&qe_muram_info, (void *)offset, size, "commproc");
+	spin_unlock_irqrestore(&qe_muram_lock, flags);
+
+	return (u32) start;
+}
+EXPORT_SYMBOL(qe_muram_alloc_fixed);
+
+void qe_muram_dump(void)
+{
+	rh_dump(&qe_muram_info);
+}
+EXPORT_SYMBOL(qe_muram_dump);
+
+void *qe_muram_addr(u32 offset)
+{
+	return (void *)&qe_immr->muram[offset];
+}
+EXPORT_SYMBOL(qe_muram_addr);
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
new file mode 100644
index 0000000..f12af2d
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -0,0 +1,555 @@
+/*
+ * arch/powerpc/sysdev/qe_lib/qe_ic.c
+ *
+ * Copyright (C) 2006 Freescale Semicondutor, Inc.  All rights reserved.
+ *
+ * Author: Li Yang <leoli@freescale.com>
+ * Based on code from Shlomi Gridish <gridish@freescale.com>
+ *
+ * QUICC ENGINE Interrupt Controller
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/reboot.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/signal.h>
+#include <linux/sysdev.h>
+#include <linux/device.h>
+#include <linux/bootmem.h>
+#include <linux/spinlock.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/qe_ic.h>
+
+#include "qe_ic.h"
+
+static DEFINE_SPINLOCK(qe_ic_lock);
+
+static struct qe_ic_info qe_ic_info[] = {
+	[1] = {
+	       .mask = 0x00008000,
+	       .mask_reg = QEIC_CIMR,
+	       .pri_code = 0,
+	       .pri_reg = QEIC_CIPWCC,
+	       },
+	[2] = {
+	       .mask = 0x00004000,
+	       .mask_reg = QEIC_CIMR,
+	       .pri_code = 1,
+	       .pri_reg = QEIC_CIPWCC,
+	       },
+	[3] = {
+	       .mask = 0x00002000,
+	       .mask_reg = QEIC_CIMR,
+	       .pri_code = 2,
+	       .pri_reg = QEIC_CIPWCC,
+	       },
+	[10] = {
+		.mask = 0x00000040,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 1,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[11] = {
+		.mask = 0x00000020,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 2,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[12] = {
+		.mask = 0x00000010,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 3,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[13] = {
+		.mask = 0x00000008,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 4,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[14] = {
+		.mask = 0x00000004,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 5,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[15] = {
+		.mask = 0x00000002,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 6,
+		.pri_reg = QEIC_CIPZCC,
+		},
+	[20] = {
+		.mask = 0x10000000,
+		.mask_reg = QEIC_CRIMR,
+		.pri_code = 3,
+		.pri_reg = QEIC_CIPRTA,
+		},
+	[25] = {
+		.mask = 0x00800000,
+		.mask_reg = QEIC_CRIMR,
+		.pri_code = 0,
+		.pri_reg = QEIC_CIPRTB,
+		},
+	[26] = {
+		.mask = 0x00400000,
+		.mask_reg = QEIC_CRIMR,
+		.pri_code = 1,
+		.pri_reg = QEIC_CIPRTB,
+		},
+	[27] = {
+		.mask = 0x00200000,
+		.mask_reg = QEIC_CRIMR,
+		.pri_code = 2,
+		.pri_reg = QEIC_CIPRTB,
+		},
+	[28] = {
+		.mask = 0x00100000,
+		.mask_reg = QEIC_CRIMR,
+		.pri_code = 3,
+		.pri_reg = QEIC_CIPRTB,
+		},
+	[32] = {
+		.mask = 0x80000000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 0,
+		.pri_reg = QEIC_CIPXCC,
+		},
+	[33] = {
+		.mask = 0x40000000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 1,
+		.pri_reg = QEIC_CIPXCC,
+		},
+	[34] = {
+		.mask = 0x20000000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 2,
+		.pri_reg = QEIC_CIPXCC,
+		},
+	[35] = {
+		.mask = 0x10000000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 3,
+		.pri_reg = QEIC_CIPXCC,
+		},
+	[36] = {
+		.mask = 0x08000000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 4,
+		.pri_reg = QEIC_CIPXCC,
+		},
+	[40] = {
+		.mask = 0x00800000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 0,
+		.pri_reg = QEIC_CIPYCC,
+		},
+	[41] = {
+		.mask = 0x00400000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 1,
+		.pri_reg = QEIC_CIPYCC,
+		},
+	[42] = {
+		.mask = 0x00200000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 2,
+		.pri_reg = QEIC_CIPYCC,
+		},
+	[43] = {
+		.mask = 0x00100000,
+		.mask_reg = QEIC_CIMR,
+		.pri_code = 3,
+		.pri_reg = QEIC_CIPYCC,
+		},
+};
+
+static inline u32 qe_ic_read(volatile u32 __iomem * base, unsigned int reg)
+{
+	return in_be32(base + (reg >> 2));
+}
+
+static inline void qe_ic_write(volatile u32 __iomem * base, unsigned int reg,
+			       u32 value)
+{
+	out_be32(base + (reg >> 2), value);
+}
+
+static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
+{
+	return irq_desc[virq].chip_data;
+}
+
+#define virq_to_hw(virq)	((unsigned int)irq_map[virq].hwirq)
+
+static void qe_ic_unmask_irq(unsigned int virq)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	unsigned long flags;
+	u32 temp;
+
+	spin_lock_irqsave(&qe_ic_lock, flags);
+
+	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
+	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
+		    temp | qe_ic_info[src].mask);
+
+	spin_unlock_irqrestore(&qe_ic_lock, flags);
+}
+
+static void qe_ic_mask_irq(unsigned int virq)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	unsigned long flags;
+	u32 temp;
+
+	spin_lock_irqsave(&qe_ic_lock, flags);
+
+	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
+	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
+		    temp & ~qe_ic_info[src].mask);
+
+	spin_unlock_irqrestore(&qe_ic_lock, flags);
+}
+
+static void qe_ic_mask_irq_and_ack(unsigned int virq)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	unsigned long flags;
+	u32 temp;
+
+	spin_lock_irqsave(&qe_ic_lock, flags);
+
+	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].mask_reg);
+	qe_ic_write(qe_ic->regs, qe_ic_info[src].mask_reg,
+		    temp & ~qe_ic_info[src].mask);
+
+	/* There is nothing to do for ack here, ack is handled in ISR */
+
+	spin_unlock_irqrestore(&qe_ic_lock, flags);
+}
+
+static struct irq_chip qe_ic_irq_chip = {
+	.typename = " QEIC  ",
+	.unmask = qe_ic_unmask_irq,
+	.mask = qe_ic_mask_irq,
+	.mask_ack = qe_ic_mask_irq_and_ack,
+};
+
+static int qe_ic_host_match(struct irq_host *h, struct device_node *node)
+{
+	struct qe_ic *qe_ic = h->host_data;
+
+	/* Exact match, unless qe_ic node is NULL */
+	return qe_ic->of_node == NULL || qe_ic->of_node == node;
+}
+
+static int qe_ic_host_map(struct irq_host *h, unsigned int virq,
+			  irq_hw_number_t hw)
+{
+	struct qe_ic *qe_ic = h->host_data;
+	struct irq_chip *chip;
+
+	if (qe_ic_info[hw].mask == 0) {
+		printk(KERN_ERR "Can't map reserved IRQ \n");
+		return -EINVAL;
+	}
+	/* Default chip */
+	chip = &qe_ic->hc_irq;
+
+	set_irq_chip_data(virq, qe_ic);
+	get_irq_desc(virq)->status |= IRQ_LEVEL;
+
+	set_irq_chip_and_handler(virq, chip, handle_level_irq);
+
+	return 0;
+}
+
+static int qe_ic_host_xlate(struct irq_host *h, struct device_node *ct,
+			    u32 * intspec, unsigned int intsize,
+			    irq_hw_number_t * out_hwirq,
+			    unsigned int *out_flags)
+{
+	*out_hwirq = intspec[0];
+	if (intsize > 1)
+		*out_flags = intspec[1];
+	else
+		*out_flags = IRQ_TYPE_NONE;
+	return 0;
+}
+
+static struct irq_host_ops qe_ic_host_ops = {
+	.match = qe_ic_host_match,
+	.map = qe_ic_host_map,
+	.xlate = qe_ic_host_xlate,
+};
+
+/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+unsigned int qe_ic_get_low_irq(struct qe_ic *qe_ic, struct pt_regs *regs)
+{
+	int irq;
+
+	BUG_ON(qe_ic == NULL);
+
+	/* get the interrupt source vector. */
+	irq = qe_ic_read(qe_ic->regs, QEIC_CIVEC) >> 26;
+
+	if (irq == 0)
+		return NO_IRQ;
+
+	return irq_linear_revmap(qe_ic->irqhost, irq);
+}
+
+/* Return an interrupt vector or NO_IRQ if no interrupt is pending. */
+unsigned int qe_ic_get_high_irq(struct qe_ic *qe_ic, struct pt_regs *regs)
+{
+	int irq;
+
+	BUG_ON(qe_ic == NULL);
+
+	/* get the interrupt source vector. */
+	irq = qe_ic_read(qe_ic->regs, QEIC_CHIVEC) >> 26;
+
+	if (irq == 0)
+		return NO_IRQ;
+
+	return irq_linear_revmap(qe_ic->irqhost, irq);
+}
+
+/* FIXME: We mask all the QE Low interrupts while handling.  We should
+ * let other interrupt come in, but BAD interrupts are generated */
+void fastcall qe_ic_cascade_low(unsigned int irq, struct irq_desc *desc,
+				struct pt_regs *regs)
+{
+	struct qe_ic *qe_ic = desc->handler_data;
+	struct irq_chip *chip = irq_desc[irq].chip;
+
+	unsigned int cascade_irq = qe_ic_get_low_irq(qe_ic, regs);
+
+	chip->mask_ack(irq);
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq, regs);
+	chip->unmask(irq);
+}
+
+/* FIXME: We mask all the QE High interrupts while handling.  We should
+ * let other interrupt come in, but BAD interrupts are generated */
+void fastcall qe_ic_cascade_high(unsigned int irq, struct irq_desc *desc,
+				 struct pt_regs *regs)
+{
+	struct qe_ic *qe_ic = desc->handler_data;
+	struct irq_chip *chip = irq_desc[irq].chip;
+
+	unsigned int cascade_irq = qe_ic_get_high_irq(qe_ic, regs);
+
+	chip->mask_ack(irq);
+	if (cascade_irq != NO_IRQ)
+		generic_handle_irq(cascade_irq, regs);
+	chip->unmask(irq);
+}
+
+void __init qe_ic_init(struct device_node *node, unsigned int flags)
+{
+	struct qe_ic *qe_ic;
+	struct resource res;
+	u32 temp = 0, ret, high_active = 0;
+
+	qe_ic = alloc_bootmem(sizeof(struct qe_ic));
+	if (qe_ic == NULL)
+		return;
+
+	memset(qe_ic, 0, sizeof(struct qe_ic));
+	qe_ic->of_node = node ? of_node_get(node) : NULL;
+
+	qe_ic->irqhost = irq_alloc_host(IRQ_HOST_MAP_LINEAR,
+					NR_QE_IC_INTS, &qe_ic_host_ops, 0);
+	if (qe_ic->irqhost == NULL) {
+		of_node_put(node);
+		return;
+	}
+
+	ret = of_address_to_resource(node, 0, &res);
+	if (ret)
+		return;
+
+	qe_ic->regs = ioremap(res.start, res.end - res.start + 1);
+
+	qe_ic->irqhost->host_data = qe_ic;
+	qe_ic->hc_irq = qe_ic_irq_chip;
+
+	qe_ic->virq_high = irq_of_parse_and_map(node, 0);
+	qe_ic->virq_low = irq_of_parse_and_map(node, 1);
+
+	if (qe_ic->virq_low == NO_IRQ) {
+		printk(KERN_ERR "Failed to map QE_IC low IRQ\n");
+		return;
+	}
+
+	/* default priority scheme is grouped. If spread mode is    */
+	/* required, configure cicr accordingly.                    */
+	if (flags & QE_IC_SPREADMODE_GRP_W)
+		temp |= CICR_GWCC;
+	if (flags & QE_IC_SPREADMODE_GRP_X)
+		temp |= CICR_GXCC;
+	if (flags & QE_IC_SPREADMODE_GRP_Y)
+		temp |= CICR_GYCC;
+	if (flags & QE_IC_SPREADMODE_GRP_Z)
+		temp |= CICR_GZCC;
+	if (flags & QE_IC_SPREADMODE_GRP_RISCA)
+		temp |= CICR_GRTA;
+	if (flags & QE_IC_SPREADMODE_GRP_RISCB)
+		temp |= CICR_GRTB;
+
+	/* choose destination signal for highest priority interrupt */
+	if (flags & QE_IC_HIGH_SIGNAL) {
+		temp |= (SIGNAL_HIGH << CICR_HPIT_SHIFT);
+		high_active = 1;
+	}
+
+	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
+
+	set_irq_data(qe_ic->virq_low, qe_ic);
+	set_irq_chained_handler(qe_ic->virq_low, qe_ic_cascade_low);
+
+	if (qe_ic->virq_high != NO_IRQ) {
+		set_irq_data(qe_ic->virq_high, qe_ic);
+		set_irq_chained_handler(qe_ic->virq_high, qe_ic_cascade_high);
+	}
+
+	printk("QEIC (%d IRQ sources) at %p\n", NR_QE_IC_INTS, qe_ic->regs);
+}
+
+void qe_ic_set_highest_priority(unsigned int virq, int high)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	u32 temp = 0;
+
+	temp = qe_ic_read(qe_ic->regs, QEIC_CICR);
+
+	temp &= ~CICR_HP_MASK;
+	temp |= src << CICR_HP_SHIFT;
+
+	temp &= ~CICR_HPIT_MASK;
+	temp |= (high ? SIGNAL_HIGH : SIGNAL_LOW) << CICR_HPIT_SHIFT;
+
+	qe_ic_write(qe_ic->regs, QEIC_CICR, temp);
+}
+
+/* Set Priority level within its group, from 1 to 8 */
+int qe_ic_set_priority(unsigned int virq, unsigned int priority)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	u32 temp;
+
+	if (priority > 8 || priority == 0)
+		return -EINVAL;
+	if (src > 127)
+		return -EINVAL;
+	if (qe_ic_info[src].pri_reg == 0)
+		return -EINVAL;
+
+	temp = qe_ic_read(qe_ic->regs, qe_ic_info[src].pri_reg);
+
+	if (priority < 4) {
+		temp &= ~(0x7 << (32 - priority * 3));
+		temp |= qe_ic_info[src].pri_code << (32 - priority * 3);
+	} else {
+		temp &= ~(0x7 << (24 - priority * 3));
+		temp |= qe_ic_info[src].pri_code << (24 - priority * 3);
+	}
+
+	qe_ic_write(qe_ic->regs, qe_ic_info[src].pri_reg, temp);
+
+	return 0;
+}
+
+/* Set a QE priority to use high irq, only priority 1~2 can use high irq */
+int qe_ic_set_high_priority(unsigned int virq, unsigned int priority, int high)
+{
+	struct qe_ic *qe_ic = qe_ic_from_irq(virq);
+	unsigned int src = virq_to_hw(virq);
+	u32 temp, control_reg = QEIC_CICNR, shift = 0;
+
+	if (priority > 2 || priority == 0)
+		return -EINVAL;
+
+	switch (qe_ic_info[src].pri_reg) {
+	case QEIC_CIPZCC:
+		shift = CICNR_ZCC1T_SHIFT;
+		break;
+	case QEIC_CIPWCC:
+		shift = CICNR_WCC1T_SHIFT;
+		break;
+	case QEIC_CIPYCC:
+		shift = CICNR_YCC1T_SHIFT;
+		break;
+	case QEIC_CIPXCC:
+		shift = CICNR_XCC1T_SHIFT;
+		break;
+	case QEIC_CIPRTA:
+		shift = CRICR_RTA1T_SHIFT;
+		control_reg = QEIC_CRICR;
+		break;
+	case QEIC_CIPRTB:
+		shift = CRICR_RTB1T_SHIFT;
+		control_reg = QEIC_CRICR;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	shift += (2 - priority) * 2;
+	temp = qe_ic_read(qe_ic->regs, control_reg);
+	temp &= ~(SIGNAL_MASK << shift);
+	temp |= (high ? SIGNAL_HIGH : SIGNAL_LOW) << shift;
+	qe_ic_write(qe_ic->regs, control_reg, temp);
+
+	return 0;
+}
+
+static struct sysdev_class qe_ic_sysclass = {
+	set_kset_name("qe_ic"),
+};
+
+static struct sys_device device_qe_ic = {
+	.id = 0,
+	.cls = &qe_ic_sysclass,
+};
+
+static int __init init_qe_ic_sysfs(void)
+{
+	int rc;
+
+	printk(KERN_DEBUG "Registering qe_ic with sysfs...\n");
+
+	rc = sysdev_class_register(&qe_ic_sysclass);
+	if (rc) {
+		printk(KERN_ERR "Failed registering qe_ic sys class\n");
+		return -ENODEV;
+	}
+	rc = sysdev_register(&device_qe_ic);
+	if (rc) {
+		printk(KERN_ERR "Failed registering qe_ic sys device\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+subsys_initcall(init_qe_ic_sysfs);
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.h b/arch/powerpc/sysdev/qe_lib/qe_ic.h
new file mode 100644
index 0000000..74b1595
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.h
@@ -0,0 +1,106 @@
+/*
+ * arch/powerpc/sysdev/qe_lib/qe_ic.h
+ *
+ * QUICC ENGINE Interrupt Controller Header
+ *
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Author: Li Yang <leoli@freescale.com>
+ * Based on code from Shlomi Gridish <gridish@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef _POWERPC_SYSDEV_QE_IC_H
+#define _POWERPC_SYSDEV_QE_IC_H
+
+#include <asm/qe_ic.h>
+
+#define NR_QE_IC_INTS		64
+
+/* QE IC registers offset */
+#define QEIC_CICR		0x00
+#define QEIC_CIVEC		0x04
+#define QEIC_CRIPNR		0x08
+#define QEIC_CIPNR		0x0c
+#define QEIC_CIPXCC		0x10
+#define QEIC_CIPYCC		0x14
+#define QEIC_CIPWCC		0x18
+#define QEIC_CIPZCC		0x1c
+#define QEIC_CIMR		0x20
+#define QEIC_CRIMR		0x24
+#define QEIC_CICNR		0x28
+#define QEIC_CIPRTA		0x30
+#define QEIC_CIPRTB		0x34
+#define QEIC_CRICR		0x3c
+#define QEIC_CHIVEC		0x60
+
+/* Interrupt priority registers */
+#define CIPCC_SHIFT_PRI0	29
+#define CIPCC_SHIFT_PRI1	26
+#define CIPCC_SHIFT_PRI2	23
+#define CIPCC_SHIFT_PRI3	20
+#define CIPCC_SHIFT_PRI4	13
+#define CIPCC_SHIFT_PRI5	10
+#define CIPCC_SHIFT_PRI6	7
+#define CIPCC_SHIFT_PRI7	4
+
+/* CICR priority modes */
+#define CICR_GWCC		0x00040000
+#define CICR_GXCC		0x00020000
+#define CICR_GYCC		0x00010000
+#define CICR_GZCC		0x00080000
+#define CICR_GRTA		0x00200000
+#define CICR_GRTB		0x00400000
+#define CICR_HPIT_SHIFT		8
+#define CICR_HPIT_MASK		0x00000300
+#define CICR_HP_SHIFT		24
+#define CICR_HP_MASK		0x3f000000
+
+/* CICNR */
+#define CICNR_WCC1T_SHIFT	20
+#define CICNR_ZCC1T_SHIFT	28
+#define CICNR_YCC1T_SHIFT	12
+#define CICNR_XCC1T_SHIFT	4
+
+/* CRICR */
+#define CRICR_RTA1T_SHIFT	20
+#define CRICR_RTB1T_SHIFT	28
+
+/* Signal indicator */
+#define SIGNAL_MASK		3
+#define SIGNAL_HIGH		2
+#define SIGNAL_LOW		0
+
+struct qe_ic {
+	/* Control registers offset */
+	volatile u32 __iomem *regs;
+
+	/* The remapper for this QEIC */
+	struct irq_host *irqhost;
+
+	/* The "linux" controller struct */
+	struct irq_chip hc_irq;
+
+	/* The device node of the interrupt controller */
+	struct device_node *of_node;
+
+	/* VIRQ numbers of QE high/low irqs */
+	unsigned int virq_high;
+	unsigned int virq_low;
+};
+
+/*
+ * QE interrupt controller internal structure
+ */
+struct qe_ic_info {
+	u32 mask;	/* location of this source at the QIMR register. */
+	u32 mask_reg;	/* Mask register offset */
+	u8 pri_code;	/* for grouped interrupts sources - the interrupt
+			   code as appears at the group priority register. */
+	u32 pri_reg;		/* Group priority register offset */
+};
+
+#endif /* _POWERPC_SYSDEV_QE_IC_H */
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
new file mode 100644
index 0000000..56828f0
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -0,0 +1,227 @@
+/*
+ * arch/powerpc/sysdev/qe_lib/qe_io.c
+ *
+ * QE Parallel I/O ports configuration routines
+ *
+ * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
+ *
+ * Author: Li Yang <LeoLi@freescale.com>
+ * Based on code from Shlomi Gridish <gridish@freescale.com>
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
+#include <linux/ioport.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <sysdev/fsl_soc.h>
+
+#undef DEBUG
+
+#define NUM_OF_PINS	32
+
+struct port_regs {
+		u32 cpodr;	/* Open drain register */
+		u32 cpdata;	/* Data register */
+		u32 cpdir1;	/* Direction register */
+		u32 cpdir2;	/* Direction register */
+		u32 cppar1;	/* Pin assignment register */
+		u32 cppar2;	/* Pin assignment register */
+};
+
+static struct port_regs *par_io = NULL;
+static int num_par_io_ports = 0;
+
+int par_io_init(struct device_node *np)
+{
+	struct resource res;
+	int ret;
+	u32 *num_ports;
+
+	/* Map Parallel I/O ports registers */
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret)
+		return ret;
+	par_io = (struct port_regs *)ioremap(res.start, res.end - res.start + 1);
+
+	num_ports = get_property(np, "num-ports", NULL);
+	if (num_ports)
+		num_par_io_ports = *num_ports;
+
+	return 0;
+}
+
+int par_io_config_pin(u8 port, u8 pin, int dir, int open_drain,
+		      int assignment, int has_irq)
+{
+	u32 pin_mask1bit, pin_mask2bits, new_mask2bits, tmp_val;
+
+	if (!par_io)
+		return -1;
+
+	/* calculate pin location for single and 2 bits information */
+	pin_mask1bit = (u32) (1 << (NUM_OF_PINS - (pin + 1)));
+
+	/* Set open drain, if required */
+	tmp_val = in_be32(&par_io[port].cpodr);
+	if (open_drain)
+		out_be32(&par_io[port].cpodr, pin_mask1bit | tmp_val);
+	else
+		out_be32(&par_io[port].cpodr, ~pin_mask1bit & tmp_val);
+
+	/* define direction */
+	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
+		in_be32(&par_io[port].cpdir2) :
+		in_be32(&par_io[port].cpdir1);
+
+	/* get all bits mask for 2 bit per port */
+	pin_mask2bits = (u32) (0x3 << (NUM_OF_PINS -
+				(pin % (NUM_OF_PINS / 2) + 1) * 2));
+
+	/* Get the final mask we need for the right definition */
+	new_mask2bits = (u32) (dir << (NUM_OF_PINS -
+				(pin % (NUM_OF_PINS / 2) + 1) * 2));
+
+	/* clear and set 2 bits mask */
+	if (pin > (NUM_OF_PINS / 2) - 1) {
+		out_be32(&par_io[port].cpdir2,
+			 ~pin_mask2bits & tmp_val);
+		tmp_val &= ~pin_mask2bits;
+		out_be32(&par_io[port].cpdir2, new_mask2bits | tmp_val);
+	} else {
+		out_be32(&par_io[port].cpdir1,
+			 ~pin_mask2bits & tmp_val);
+		tmp_val &= ~pin_mask2bits;
+		out_be32(&par_io[port].cpdir1, new_mask2bits | tmp_val);
+	}
+	/* define pin assignment */
+	tmp_val = (pin > (NUM_OF_PINS / 2) - 1) ?
+		in_be32(&par_io[port].cppar2) :
+		in_be32(&par_io[port].cppar1);
+
+	new_mask2bits = (u32) (assignment << (NUM_OF_PINS -
+			(pin % (NUM_OF_PINS / 2) + 1) * 2));
+	/* clear and set 2 bits mask */
+	if (pin > (NUM_OF_PINS / 2) - 1) {
+		out_be32(&par_io[port].cppar2,
+			 ~pin_mask2bits & tmp_val);
+		tmp_val &= ~pin_mask2bits;
+		out_be32(&par_io[port].cppar2, new_mask2bits | tmp_val);
+	} else {
+		out_be32(&par_io[port].cppar1,
+			 ~pin_mask2bits & tmp_val);
+		tmp_val &= ~pin_mask2bits;
+		out_be32(&par_io[port].cppar1, new_mask2bits | tmp_val);
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(par_io_config_pin);
+
+int par_io_data_set(u8 port, u8 pin, u8 val)
+{
+	u32 pin_mask, tmp_val;
+
+	if (port >= num_par_io_ports)
+		return -EINVAL;
+	if (pin >= NUM_OF_PINS)
+		return -EINVAL;
+	/* calculate pin location */
+	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - pin));
+
+	tmp_val = in_be32(&par_io[port].cpdata);
+
+	if (val == 0)		/* clear */
+		out_be32(&par_io[port].cpdata, ~pin_mask & tmp_val);
+	else			/* set */
+		out_be32(&par_io[port].cpdata, pin_mask | tmp_val);
+
+	return 0;
+}
+EXPORT_SYMBOL(par_io_data_set);
+
+int par_io_of_config(struct device_node *np)
+{
+	struct device_node *pio;
+	phandle *ph;
+	int pio_map_len;
+	unsigned int *pio_map;
+
+	if (par_io == NULL) {
+		printk(KERN_ERR "par_io not initialized \n");
+		return -1;
+	}
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
+	for (i = 0; i < num_par_io_ports; i++) {
+		printk(KERN_INFO "cpodr[%d] : addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cpodr,
+		       in_be32(&par_io[i].cpodr));
+		printk(KERN_INFO "cpdata[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cpdata,
+		       in_be32(&par_io[i].cpdata));
+		printk(KERN_INFO "cpdir1[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cpdir1,
+		       in_be32(&par_io[i].cpdir1));
+		printk(KERN_INFO "cpdir2[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cpdir2,
+		       in_be32(&par_io[i].cpdir2));
+		printk(KERN_INFO "cppar1[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cppar1,
+		       in_be32(&par_io[i].cppar1));
+		printk(KERN_INFO "cppar2[%d]: addr - 0x%08x, val - 0x%08x\n",
+		       i, (u32) & par_io[i].cppar2,
+		       in_be32(&par_io[i].cppar2));
+	}
+
+}
+EXPORT_SYMBOL(dump_par_io);
+#endif /* DEBUG */
diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/qe_lib/ucc.c
new file mode 100644
index 0000000..916c9e5
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/ucc.c
@@ -0,0 +1,251 @@
+/*
+ * arch/powerpc/sysdev/qe_lib/ucc.c
+ *
+ * QE UCC API Set - UCC specific routines implementations.
+ *
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+#include <asm/ucc.h>
+
+static DEFINE_SPINLOCK(ucc_lock);
+
+int ucc_set_qe_mux_mii_mng(int ucc_num)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ucc_lock, flags);
+	out_be32(&qe_immr->qmx.cmxgcr,
+		 ((in_be32(&qe_immr->qmx.cmxgcr) &
+		   ~QE_CMXGCR_MII_ENET_MNG) |
+		  (ucc_num << QE_CMXGCR_MII_ENET_MNG_SHIFT)));
+	spin_unlock_irqrestore(&ucc_lock, flags);
+
+	return 0;
+}
+
+int ucc_set_type(int ucc_num, struct ucc_common *regs,
+		 enum ucc_speed_type speed)
+{
+	u8 guemr = 0;
+
+	/* check if the UCC number is in range. */
+	if ((ucc_num > UCC_MAX_NUM - 1) || (ucc_num < 0))
+		return -EINVAL;
+
+	guemr = regs->guemr;
+	guemr &= ~(UCC_GUEMR_MODE_MASK_RX | UCC_GUEMR_MODE_MASK_TX);
+	switch (speed) {
+	case UCC_SPEED_TYPE_SLOW:
+		guemr |= (UCC_GUEMR_MODE_SLOW_RX | UCC_GUEMR_MODE_SLOW_TX);
+		break;
+	case UCC_SPEED_TYPE_FAST:
+		guemr |= (UCC_GUEMR_MODE_FAST_RX | UCC_GUEMR_MODE_FAST_TX);
+		break;
+	default:
+		return -EINVAL;
+	}
+	regs->guemr = guemr;
+
+	return 0;
+}
+
+int ucc_init_guemr(struct ucc_common *regs)
+{
+	u8 guemr = 0;
+
+	if (!regs)
+		return -EINVAL;
+
+	/* Set bit 3 (which is reserved in the GUEMR register) to 1 */
+	guemr = UCC_GUEMR_SET_RESERVED3;
+
+	regs->guemr = guemr;
+
+	return 0;
+}
+
+static void get_cmxucr_reg(int ucc_num, volatile u32 ** p_cmxucr, u8 * reg_num,
+			   u8 * shift)
+{
+	switch (ucc_num) {
+	case 0: *p_cmxucr = &(qe_immr->qmx.cmxucr1);
+		*reg_num = 1;
+		*shift = 16;
+		break;
+	case 2: *p_cmxucr = &(qe_immr->qmx.cmxucr1);
+		*reg_num = 1;
+		*shift = 0;
+		break;
+	case 4: *p_cmxucr = &(qe_immr->qmx.cmxucr2);
+		*reg_num = 2;
+		*shift = 16;
+		break;
+	case 6: *p_cmxucr = &(qe_immr->qmx.cmxucr2);
+		*reg_num = 2;
+		*shift = 0;
+		break;
+	case 1: *p_cmxucr = &(qe_immr->qmx.cmxucr3);
+		*reg_num = 3;
+		*shift = 16;
+		break;
+	case 3: *p_cmxucr = &(qe_immr->qmx.cmxucr3);
+		*reg_num = 3;
+		*shift = 0;
+		break;
+	case 5: *p_cmxucr = &(qe_immr->qmx.cmxucr4);
+		*reg_num = 4;
+		*shift = 16;
+		break;
+	case 7: *p_cmxucr = &(qe_immr->qmx.cmxucr4);
+		*reg_num = 4;
+		*shift = 0;
+		break;
+	default:
+		break;
+	}
+}
+
+int ucc_mux_set_grant_tsa_bkpt(int ucc_num, int set, u32 mask)
+{
+	volatile u32 *p_cmxucr;
+	u8 reg_num;
+	u8 shift;
+
+	/* check if the UCC number is in range. */
+	if ((ucc_num > UCC_MAX_NUM - 1) || (ucc_num < 0))
+		return -EINVAL;
+
+	get_cmxucr_reg(ucc_num, &p_cmxucr, &reg_num, &shift);
+
+	if (set)
+		out_be32(p_cmxucr, in_be32(p_cmxucr) | (mask << shift));
+	else
+		out_be32(p_cmxucr, in_be32(p_cmxucr) & ~(mask << shift));
+
+	return 0;
+}
+
+int ucc_set_qe_mux_rxtx(int ucc_num, enum qe_clock clock, enum comm_dir mode)
+{
+	volatile u32 *p_cmxucr;
+	u8 reg_num;
+	u8 shift;
+	u32 clock_bits;
+	u32 clock_mask;
+	int source = -1;
+
+	/* check if the UCC number is in range. */
+	if ((ucc_num > UCC_MAX_NUM - 1) || (ucc_num < 0))
+		return -EINVAL;
+
+	if (!((mode == COMM_DIR_RX) || (mode == COMM_DIR_TX))) {
+		printk(KERN_ERR
+		       "ucc_set_qe_mux_rxtx: bad comm mode type passed.");
+		return -EINVAL;
+	}
+
+	get_cmxucr_reg(ucc_num, &p_cmxucr, &reg_num, &shift);
+
+	switch (reg_num) {
+	case 1:
+		switch (clock) {
+		case QE_BRG1:	source = 1; break;
+		case QE_BRG2:	source = 2; break;
+		case QE_BRG7:	source = 3; break;
+		case QE_BRG8:	source = 4; break;
+		case QE_CLK9:	source = 5; break;
+		case QE_CLK10:	source = 6; break;
+		case QE_CLK11:	source = 7; break;
+		case QE_CLK12:	source = 8; break;
+		case QE_CLK15:	source = 9; break;
+		case QE_CLK16:	source = 10; break;
+		default: 	source = -1; break;
+		}
+		break;
+	case 2:
+		switch (clock) {
+		case QE_BRG5:	source = 1; break;
+		case QE_BRG6:	source = 2; break;
+		case QE_BRG7:	source = 3; break;
+		case QE_BRG8:	source = 4; break;
+		case QE_CLK13:	source = 5; break;
+		case QE_CLK14:	source = 6; break;
+		case QE_CLK19:	source = 7; break;
+		case QE_CLK20:	source = 8; break;
+		case QE_CLK15:	source = 9; break;
+		case QE_CLK16:	source = 10; break;
+		default: 	source = -1; break;
+		}
+		break;
+	case 3:
+		switch (clock) {
+		case QE_BRG9:	source = 1; break;
+		case QE_BRG10:	source = 2; break;
+		case QE_BRG15:	source = 3; break;
+		case QE_BRG16:	source = 4; break;
+		case QE_CLK3:	source = 5; break;
+		case QE_CLK4:	source = 6; break;
+		case QE_CLK17:	source = 7; break;
+		case QE_CLK18:	source = 8; break;
+		case QE_CLK7:	source = 9; break;
+		case QE_CLK8:	source = 10; break;
+		default:	source = -1; break;
+		}
+		break;
+	case 4:
+		switch (clock) {
+		case QE_BRG13:	source = 1; break;
+		case QE_BRG14:	source = 2; break;
+		case QE_BRG15:	source = 3; break;
+		case QE_BRG16:	source = 4; break;
+		case QE_CLK5:	source = 5; break;
+		case QE_CLK6:	source = 6; break;
+		case QE_CLK21:	source = 7; break;
+		case QE_CLK22:	source = 8; break;
+		case QE_CLK7:	source = 9; break;
+		case QE_CLK8:	source = 10; break;
+		default: 	source = -1; break;
+		}
+		break;
+	default:
+		source = -1;
+		break;
+	}
+
+	if (source == -1) {
+		printk(KERN_ERR
+		     "ucc_set_qe_mux_rxtx: Bad combination of clock and UCC.");
+		return -ENOENT;
+	}
+
+	clock_bits = (u32) source;
+	clock_mask = QE_CMXUCR_TX_CLK_SRC_MASK;
+	if (mode == COMM_DIR_RX) {
+		clock_bits <<= 4;  /* Rx field is 4 bits to left of Tx field */
+		clock_mask <<= 4;  /* Rx field is 4 bits to left of Tx field */
+	}
+	clock_bits <<= shift;
+	clock_mask <<= shift;
+
+	out_be32(p_cmxucr, (in_be32(p_cmxucr) & ~clock_mask) | clock_bits);
+
+	return 0;
+}
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
new file mode 100644
index 0000000..d635738
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -0,0 +1,397 @@
+/*
+ * arch/powerpc/sysdev/qe_lib/ucc_fast.c
+ *
+ * QE UCC Fast API Set - UCC Fast specific routines implementations.
+ *
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/interrupt.h>
+
+#include <asm/io.h>
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#include <asm/ucc.h>
+#include <asm/ucc_fast.h>
+
+#define uccf_printk(level, format, arg...) \
+	printk(level format "\n", ## arg)
+
+#define uccf_dbg(format, arg...) \
+	uccf_printk(KERN_DEBUG , format , ## arg)
+#define uccf_err(format, arg...) \
+	uccf_printk(KERN_ERR , format , ## arg)
+#define uccf_info(format, arg...) \
+	uccf_printk(KERN_INFO , format , ## arg)
+#define uccf_warn(format, arg...) \
+	uccf_printk(KERN_WARNING , format , ## arg)
+
+#ifdef UCCF_VERBOSE_DEBUG
+#define uccf_vdbg uccf_dbg
+#else
+#define uccf_vdbg(fmt, args...) do { } while (0)
+#endif				/* UCCF_VERBOSE_DEBUG */
+
+void ucc_fast_dump_regs(struct ucc_fast_private * uccf)
+{
+	uccf_info("UCC%d Fast registers:", uccf->uf_info->ucc_num);
+	uccf_info("Base address: 0x%08x", (u32) uccf->uf_regs);
+
+	uccf_info("gumr  : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->gumr, in_be32(&uccf->uf_regs->gumr));
+	uccf_info("upsmr : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->upsmr, in_be32(&uccf->uf_regs->upsmr));
+	uccf_info("utodr : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->utodr, in_be16(&uccf->uf_regs->utodr));
+	uccf_info("udsr  : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->udsr, in_be16(&uccf->uf_regs->udsr));
+	uccf_info("ucce  : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->ucce, in_be32(&uccf->uf_regs->ucce));
+	uccf_info("uccm  : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->uccm, in_be32(&uccf->uf_regs->uccm));
+	uccf_info("uccs  : addr - 0x%08x, val - 0x%02x",
+		  (u32) & uccf->uf_regs->uccs, uccf->uf_regs->uccs);
+	uccf_info("urfb  : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->urfb, in_be32(&uccf->uf_regs->urfb));
+	uccf_info("urfs  : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->urfs, in_be16(&uccf->uf_regs->urfs));
+	uccf_info("urfet : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->urfet, in_be16(&uccf->uf_regs->urfet));
+	uccf_info("urfset: addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->urfset,
+		  in_be16(&uccf->uf_regs->urfset));
+	uccf_info("utfb  : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->utfb, in_be32(&uccf->uf_regs->utfb));
+	uccf_info("utfs  : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->utfs, in_be16(&uccf->uf_regs->utfs));
+	uccf_info("utfet : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->utfet, in_be16(&uccf->uf_regs->utfet));
+	uccf_info("utftt : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->utftt, in_be16(&uccf->uf_regs->utftt));
+	uccf_info("utpt  : addr - 0x%08x, val - 0x%04x",
+		  (u32) & uccf->uf_regs->utpt, in_be16(&uccf->uf_regs->utpt));
+	uccf_info("urtry : addr - 0x%08x, val - 0x%08x",
+		  (u32) & uccf->uf_regs->urtry, in_be32(&uccf->uf_regs->urtry));
+	uccf_info("guemr : addr - 0x%08x, val - 0x%02x",
+		  (u32) & uccf->uf_regs->guemr, uccf->uf_regs->guemr);
+}
+
+u32 ucc_fast_get_qe_cr_subblock(int uccf_num)
+{
+	switch (uccf_num) {
+	case 0:	return QE_CR_SUBBLOCK_UCCFAST1;
+	case 1: return QE_CR_SUBBLOCK_UCCFAST2;
+	case 2: return QE_CR_SUBBLOCK_UCCFAST3;
+	case 3: return QE_CR_SUBBLOCK_UCCFAST4;
+	case 4: return QE_CR_SUBBLOCK_UCCFAST5;
+	case 5: return QE_CR_SUBBLOCK_UCCFAST6;
+	case 6: return QE_CR_SUBBLOCK_UCCFAST7;
+	case 7:	return QE_CR_SUBBLOCK_UCCFAST8;
+	default: return QE_CR_SUBBLOCK_INVALID;
+	}
+}
+
+void ucc_fast_transmit_on_demand(struct ucc_fast_private * uccf)
+{
+	out_be16(&uccf->uf_regs->utodr, UCC_FAST_TOD);
+}
+
+void ucc_fast_enable(struct ucc_fast_private * uccf, enum comm_dir mode)
+{
+	struct ucc_fast *uf_regs;
+	u32 gumr;
+
+	uf_regs = uccf->uf_regs;
+
+	/* Enable reception and/or transmission on this UCC. */
+	gumr = in_be32(&uf_regs->gumr);
+	if (mode & COMM_DIR_TX) {
+		gumr |= UCC_FAST_GUMR_ENT;
+		uccf->enabled_tx = 1;
+	}
+	if (mode & COMM_DIR_RX) {
+		gumr |= UCC_FAST_GUMR_ENR;
+		uccf->enabled_rx = 1;
+	}
+	out_be32(&uf_regs->gumr, gumr);
+}
+
+void ucc_fast_disable(struct ucc_fast_private * uccf, enum comm_dir mode)
+{
+	struct ucc_fast *uf_regs;
+	u32 gumr;
+
+	uf_regs = uccf->uf_regs;
+
+	/* Disable reception and/or transmission on this UCC. */
+	gumr = in_be32(&uf_regs->gumr);
+	if (mode & COMM_DIR_TX) {
+		gumr &= ~UCC_FAST_GUMR_ENT;
+		uccf->enabled_tx = 0;
+	}
+	if (mode & COMM_DIR_RX) {
+		gumr &= ~UCC_FAST_GUMR_ENR;
+		uccf->enabled_rx = 0;
+	}
+	out_be32(&uf_regs->gumr, gumr);
+}
+
+int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** uccf_ret)
+{
+	struct ucc_fast_private *uccf;
+	struct ucc_fast *uf_regs;
+	u32 gumr = 0;
+	int ret;
+
+	uccf_vdbg("%s: IN", __FUNCTION__);
+
+	if (!uf_info)
+		return -EINVAL;
+
+	/* check if the UCC port number is in range. */
+	if ((uf_info->ucc_num < 0) || (uf_info->ucc_num > UCC_MAX_NUM - 1)) {
+		uccf_err("ucc_fast_init: Illagal UCC number!");
+		return -EINVAL;
+	}
+
+	/* Check that 'max_rx_buf_length' is properly aligned (4). */
+	if (uf_info->max_rx_buf_length & (UCC_FAST_MRBLR_ALIGNMENT - 1)) {
+		uccf_err("ucc_fast_init: max_rx_buf_length not aligned.");
+		return -EINVAL;
+	}
+
+	/* Validate Virtual Fifo register values */
+	if (uf_info->urfs < UCC_FAST_URFS_MIN_VAL) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register urfs too small.");
+		return -EINVAL;
+	}
+
+	if (uf_info->urfs & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register urfs not aligned.");
+		return -EINVAL;
+	}
+
+	if (uf_info->urfet & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register urfet not aligned.");
+		return -EINVAL;
+	}
+
+	if (uf_info->urfset & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		   ("ucc_fast_init: Virtual Fifo register urfset not aligned.");
+		return -EINVAL;
+	}
+
+	if (uf_info->utfs & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register utfs not aligned.");
+		return -EINVAL;
+	}
+
+	if (uf_info->utfet & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register utfet not aligned.");
+		return -EINVAL;
+	}
+
+	if (uf_info->utftt & (UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT - 1)) {
+		uccf_err
+		    ("ucc_fast_init: Virtual Fifo register utftt not aligned.");
+		return -EINVAL;
+	}
+
+	uccf =
+	    (struct ucc_fast_private *) kmalloc(sizeof(struct ucc_fast_private),
+					   GFP_KERNEL);
+	if (!uccf) {
+		uccf_err
+		    ("ucc_fast_init: No memory for UCC slow data structure!");
+		return -ENOMEM;
+	}
+	memset(uccf, 0, sizeof(struct ucc_fast_private));
+
+	/* Fill fast UCC structure */
+	uccf->uf_info = uf_info;
+	/* Set the PHY base address */
+	uccf->uf_regs =
+	    (struct ucc_fast *) ioremap(uf_info->regs, sizeof(struct ucc_fast));
+	if (uccf->uf_regs == NULL) {
+		uccf_err
+		    ("ucc_fast_init: No memory map for UCC slow controller!");
+		return -ENOMEM;
+	}
+
+	uccf->enabled_tx = 0;
+	uccf->enabled_rx = 0;
+	uccf->stopped_tx = 0;
+	uccf->stopped_rx = 0;
+	uf_regs = uccf->uf_regs;
+	uccf->p_ucce = (u32 *) & (uf_regs->ucce);
+	uccf->p_uccm = (u32 *) & (uf_regs->uccm);
+#ifdef STATISTICS
+	uccf->tx_frames = 0;
+	uccf->rx_frames = 0;
+	uccf->rx_discarded = 0;
+#endif				/* STATISTICS */
+
+	/* Init Guemr register */
+	if ((ret = ucc_init_guemr((struct ucc_common *) (uf_regs)))) {
+		uccf_err("ucc_fast_init: Could not init the guemr register.");
+		ucc_fast_free(uccf);
+		return ret;
+	}
+
+	/* Set UCC to fast type */
+	if ((ret = ucc_set_type(uf_info->ucc_num,
+				(struct ucc_common *) (uf_regs),
+				UCC_SPEED_TYPE_FAST))) {
+		uccf_err("ucc_fast_init: Could not set type to fast.");
+		ucc_fast_free(uccf);
+		return ret;
+	}
+
+	uccf->mrblr = uf_info->max_rx_buf_length;
+
+	/* Set GUMR */
+	/* For more details see the hardware spec. */
+	/* gumr starts as zero. */
+	if (uf_info->tci)
+		gumr |= UCC_FAST_GUMR_TCI;
+	gumr |= uf_info->ttx_trx;
+	if (uf_info->cdp)
+		gumr |= UCC_FAST_GUMR_CDP;
+	if (uf_info->ctsp)
+		gumr |= UCC_FAST_GUMR_CTSP;
+	if (uf_info->cds)
+		gumr |= UCC_FAST_GUMR_CDS;
+	if (uf_info->ctss)
+		gumr |= UCC_FAST_GUMR_CTSS;
+	if (uf_info->txsy)
+		gumr |= UCC_FAST_GUMR_TXSY;
+	if (uf_info->rsyn)
+		gumr |= UCC_FAST_GUMR_RSYN;
+	gumr |= uf_info->synl;
+	if (uf_info->rtsm)
+		gumr |= UCC_FAST_GUMR_RTSM;
+	gumr |= uf_info->renc;
+	if (uf_info->revd)
+		gumr |= UCC_FAST_GUMR_REVD;
+	gumr |= uf_info->tenc;
+	gumr |= uf_info->tcrc;
+	gumr |= uf_info->mode;
+	out_be32(&uf_regs->gumr, gumr);
+
+	/* Allocate memory for Tx Virtual Fifo */
+	uccf->ucc_fast_tx_virtual_fifo_base_offset =
+	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
+	if (IS_MURAM_ERR(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
+		uccf_err
+		    ("ucc_fast_init: Can not allocate MURAM memory for "
+			"struct ucc_fastx_virtual_fifo_base_offset.");
+		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
+		ucc_fast_free(uccf);
+		return -ENOMEM;
+	}
+
+	/* Allocate memory for Rx Virtual Fifo */
+	uccf->ucc_fast_rx_virtual_fifo_base_offset =
+	    qe_muram_alloc(uf_info->urfs +
+			   (u32)
+			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
+			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
+	if (IS_MURAM_ERR(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
+		uccf_err
+		    ("ucc_fast_init: Can not allocate MURAM memory for "
+			"ucc_fast_rx_virtual_fifo_base_offset.");
+		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
+		ucc_fast_free(uccf);
+		return -ENOMEM;
+	}
+
+	/* Set Virtual Fifo registers */
+	out_be16(&uf_regs->urfs, uf_info->urfs);
+	out_be16(&uf_regs->urfet, uf_info->urfet);
+	out_be16(&uf_regs->urfset, uf_info->urfset);
+	out_be16(&uf_regs->utfs, uf_info->utfs);
+	out_be16(&uf_regs->utfet, uf_info->utfet);
+	out_be16(&uf_regs->utftt, uf_info->utftt);
+	/* utfb, urfb are offsets from MURAM base */
+	out_be32(&uf_regs->utfb, uccf->ucc_fast_tx_virtual_fifo_base_offset);
+	out_be32(&uf_regs->urfb, uccf->ucc_fast_rx_virtual_fifo_base_offset);
+
+	/* Mux clocking */
+	/* Grant Support */
+	ucc_set_qe_mux_grant(uf_info->ucc_num, uf_info->grant_support);
+	/* Breakpoint Support */
+	ucc_set_qe_mux_bkpt(uf_info->ucc_num, uf_info->brkpt_support);
+	/* Set Tsa or NMSI mode. */
+	ucc_set_qe_mux_tsa(uf_info->ucc_num, uf_info->tsa);
+	/* If NMSI (not Tsa), set Tx and Rx clock. */
+	if (!uf_info->tsa) {
+		/* Rx clock routing */
+		if (uf_info->rx_clock != QE_CLK_NONE) {
+			if (ucc_set_qe_mux_rxtx
+			    (uf_info->ucc_num, uf_info->rx_clock,
+			     COMM_DIR_RX)) {
+				uccf_err
+		("ucc_fast_init: Illegal value for parameter 'RxClock'.");
+				ucc_fast_free(uccf);
+				return -EINVAL;
+			}
+		}
+		/* Tx clock routing */
+		if (uf_info->tx_clock != QE_CLK_NONE) {
+			if (ucc_set_qe_mux_rxtx
+			    (uf_info->ucc_num, uf_info->tx_clock,
+			     COMM_DIR_TX)) {
+				uccf_err
+		("ucc_fast_init: Illegal value for parameter 'TxClock'.");
+				ucc_fast_free(uccf);
+				return -EINVAL;
+			}
+		}
+	}
+
+	/* Set interrupt mask register at UCC level. */
+	out_be32(&uf_regs->uccm, uf_info->uccm_mask);
+
+	/* First, clear anything pending at UCC level,
+	 * otherwise, old garbage may come through
+	 * as soon as the dam is opened
+	 * Writing '1' clears
+	 */
+	out_be32(&uf_regs->ucce, 0xffffffff);
+
+	*uccf_ret = uccf;
+	return 0;
+}
+
+void ucc_fast_free(struct ucc_fast_private * uccf)
+{
+	if (!uccf)
+		return;
+
+	if (uccf->ucc_fast_tx_virtual_fifo_base_offset)
+		qe_muram_free(uccf->ucc_fast_tx_virtual_fifo_base_offset);
+
+	if (uccf->ucc_fast_rx_virtual_fifo_base_offset)
+		qe_muram_free(uccf->ucc_fast_rx_virtual_fifo_base_offset);
+
+	kfree(uccf);
+}
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
new file mode 100644
index 0000000..de86985
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -0,0 +1,404 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * QE UCC Slow API Set - UCC Slow specific routines implementations.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/interrupt.h>
+
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#include <asm/ucc.h>
+#include <asm/ucc_slow.h>
+
+#define uccs_printk(level, format, arg...) \
+        printk(level format "\n", ## arg)
+
+#define uccs_dbg(format, arg...) \
+	uccs_printk(KERN_DEBUG , format , ## arg)
+#define uccs_err(format, arg...) \
+	uccs_printk(KERN_ERR , format , ## arg)
+#define uccs_info(format, arg...) \
+	uccs_printk(KERN_INFO , format , ## arg)
+#define uccs_warn(format, arg...) \
+	uccs_printk(KERN_WARNING , format , ## arg)
+
+#ifdef UCCS_VERBOSE_DEBUG
+#define uccs_vdbg uccs_dbg
+#else
+#define uccs_vdbg(fmt, args...) do { } while (0)
+#endif				/* UCCS_VERBOSE_DEBUG */
+
+u32 ucc_slow_get_qe_cr_subblock(int uccs_num)
+{
+	switch (uccs_num) {
+	case 0: return QE_CR_SUBBLOCK_UCCSLOW1;
+	case 1: return QE_CR_SUBBLOCK_UCCSLOW2;
+	case 2: return QE_CR_SUBBLOCK_UCCSLOW3;
+	case 3: return QE_CR_SUBBLOCK_UCCSLOW4;
+	case 4: return QE_CR_SUBBLOCK_UCCSLOW5;
+	case 5: return QE_CR_SUBBLOCK_UCCSLOW6;
+	case 6: return QE_CR_SUBBLOCK_UCCSLOW7;
+	case 7: return QE_CR_SUBBLOCK_UCCSLOW8;
+	default: return QE_CR_SUBBLOCK_INVALID;
+	}
+}
+
+void ucc_slow_poll_transmitter_now(struct ucc_slow_private * uccs)
+{
+	out_be16(&uccs->us_regs->utodr, UCC_SLOW_TOD);
+}
+
+void ucc_slow_graceful_stop_tx(struct ucc_slow_private * uccs)
+{
+	struct ucc_slow_info *us_info = uccs->us_info;
+	u32 id;
+
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_GRACEFUL_STOP_TX, id,
+			 (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
+}
+
+void ucc_slow_stop_tx(struct ucc_slow_private * uccs)
+{
+	struct ucc_slow_info *us_info = uccs->us_info;
+	u32 id;
+
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_STOP_TX, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
+}
+
+void ucc_slow_restart_tx(struct ucc_slow_private * uccs)
+{
+	struct ucc_slow_info *us_info = uccs->us_info;
+	u32 id;
+
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_RESTART_TX, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
+}
+
+void ucc_slow_enable(struct ucc_slow_private * uccs, enum comm_dir mode)
+{
+	struct ucc_slow *us_regs;
+	u32 gumr_l;
+
+	us_regs = uccs->us_regs;
+
+	/* Enable reception and/or transmission on this UCC. */
+	gumr_l = in_be32(&us_regs->gumr_l);
+	if (mode & COMM_DIR_TX) {
+		gumr_l |= UCC_SLOW_GUMR_L_ENT;
+		uccs->enabled_tx = 1;
+	}
+	if (mode & COMM_DIR_RX) {
+		gumr_l |= UCC_SLOW_GUMR_L_ENR;
+		uccs->enabled_rx = 1;
+	}
+	out_be32(&us_regs->gumr_l, gumr_l);
+}
+
+void ucc_slow_disable(struct ucc_slow_private * uccs, enum comm_dir mode)
+{
+	struct ucc_slow *us_regs;
+	u32 gumr_l;
+
+	us_regs = uccs->us_regs;
+
+	/* Disable reception and/or transmission on this UCC. */
+	gumr_l = in_be32(&us_regs->gumr_l);
+	if (mode & COMM_DIR_TX) {
+		gumr_l &= ~UCC_SLOW_GUMR_L_ENT;
+		uccs->enabled_tx = 0;
+	}
+	if (mode & COMM_DIR_RX) {
+		gumr_l &= ~UCC_SLOW_GUMR_L_ENR;
+		uccs->enabled_rx = 0;
+	}
+	out_be32(&us_regs->gumr_l, gumr_l);
+}
+
+int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** uccs_ret)
+{
+	u32 i;
+	struct ucc_slow *us_regs;
+	u32 gumr;
+	u8 function_code = 0;
+	u8 *bd;
+	struct ucc_slow_private *uccs;
+	u32 id;
+	u32 command;
+	int ret;
+
+	uccs_vdbg("%s: IN", __FUNCTION__);
+
+	if (!us_info)
+		return -EINVAL;
+
+	/* check if the UCC port number is in range. */
+	if ((us_info->ucc_num < 0) || (us_info->ucc_num > UCC_MAX_NUM - 1)) {
+		uccs_err("ucc_slow_init: Illagal UCC number!");
+		return -EINVAL;
+	}
+
+	/*
+	 * Set mrblr
+	 * Check that 'max_rx_buf_length' is properly aligned (4), unless
+ 	 * rfw is 1, meaning that QE accepts one byte at a time, unlike normal
+	 * case when QE accepts 32 bits at a time.
+	 */
+	if ((!us_info->rfw) &&
+		(us_info->max_rx_buf_length & (UCC_SLOW_MRBLR_ALIGNMENT - 1))) {
+		uccs_err("max_rx_buf_length not aligned.");
+		return -EINVAL;
+	}
+
+	uccs = (struct ucc_slow_private *)
+		kmalloc(sizeof(struct ucc_slow_private), GFP_KERNEL);
+	if (!uccs) {
+		uccs_err
+		    ("ucc_slow_init: No memory for UCC slow data structure!");
+		return -ENOMEM;
+	}
+	memset(uccs, 0, sizeof(struct ucc_slow_private));
+
+	/* Fill slow UCC structure */
+	uccs->us_info = us_info;
+	uccs->saved_uccm = 0;
+	uccs->p_rx_frame = 0;
+	uccs->us_regs = us_info->us_regs;
+	us_regs = uccs->us_regs;
+	uccs->p_ucce = (u16 *) & (us_regs->ucce);
+	uccs->p_uccm = (u16 *) & (us_regs->uccm);
+#ifdef STATISTICS
+	uccs->rx_frames = 0;
+	uccs->tx_frames = 0;
+	uccs->rx_discarded = 0;
+#endif				/* STATISTICS */
+
+	/* Get PRAM base */
+	uccs->us_pram_offset = qe_muram_alloc(UCC_SLOW_PRAM_SIZE,
+						 ALIGNMENT_OF_UCC_SLOW_PRAM);
+	if (IS_MURAM_ERR(uccs->us_pram_offset)) {
+		uccs_err
+		    ("ucc_slow_init: Can not allocate MURAM memory "
+			"for Slow UCC.");
+		ucc_slow_free(uccs);
+		return -ENOMEM;
+	}
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, id, QE_CR_PROTOCOL_UNSPECIFIED,
+			(u32) uccs->us_pram_offset);
+
+	uccs->us_pram = qe_muram_addr(uccs->us_pram_offset);
+
+	/* Init Guemr register */
+	if ((ret = ucc_init_guemr((struct ucc_common *) (us_info->us_regs)))) {
+		uccs_err("ucc_slow_init: Could not init the guemr register.");
+		ucc_slow_free(uccs);
+		return ret;
+	}
+
+	/* Set UCC to slow type */
+	if ((ret = ucc_set_type(us_info->ucc_num,
+				(struct ucc_common *) (us_info->us_regs),
+				UCC_SPEED_TYPE_SLOW))) {
+		uccs_err("ucc_slow_init: Could not init the guemr register.");
+		ucc_slow_free(uccs);
+		return ret;
+	}
+
+	out_be16(&uccs->us_pram->mrblr, us_info->max_rx_buf_length);
+
+	INIT_LIST_HEAD(&uccs->confQ);
+
+	/* Allocate BDs. */
+	uccs->rx_base_offset =
+		qe_muram_alloc(us_info->rx_bd_ring_len * sizeof(struct qe_bd),
+				QE_ALIGNMENT_OF_BD);
+	if (IS_MURAM_ERR(uccs->rx_base_offset)) {
+		uccs_err("ucc_slow_init: No memory for Rx BD's.");
+		uccs->rx_base_offset = 0;
+		ucc_slow_free(uccs);
+		return -ENOMEM;
+	}
+
+	uccs->tx_base_offset =
+		qe_muram_alloc(us_info->tx_bd_ring_len * sizeof(struct qe_bd),
+			QE_ALIGNMENT_OF_BD);
+	if (IS_MURAM_ERR(uccs->tx_base_offset)) {
+		uccs_err("ucc_slow_init: No memory for Tx BD's.");
+		uccs->tx_base_offset = 0;
+		ucc_slow_free(uccs);
+		return -ENOMEM;
+	}
+
+	/* Init Tx bds */
+	bd = uccs->confBd = uccs->tx_bd = qe_muram_addr(uccs->tx_base_offset);
+	for (i = 0; i < us_info->tx_bd_ring_len; i++) {
+		/* clear bd buffer */
+		out_be32(&(((struct qe_bd *)bd)->buf), 0);
+		/* set bd status and length */
+		out_be32((u32*)bd, 0);
+		bd += sizeof(struct qe_bd);
+	}
+	bd -= sizeof(struct qe_bd);
+	/* set bd status and length */
+	out_be32((u32*)bd, T_W);	/* for last BD set Wrap bit */
+
+	/* Init Rx bds */
+	bd = uccs->rx_bd = qe_muram_addr(uccs->rx_base_offset);
+	for (i = 0; i < us_info->rx_bd_ring_len; i++) {
+		/* set bd status and length */
+		out_be32((u32*)bd, 0);
+		/* clear bd buffer */
+		out_be32(&(((struct qe_bd *)bd)->buf), 0);
+		bd += sizeof(struct qe_bd);
+	}
+	bd -= sizeof(struct qe_bd);
+	/* set bd status and length */
+	out_be32((u32*)bd, R_W);	/* for last BD set Wrap bit */
+
+	/* Set GUMR (For more details see the hardware spec.). */
+	/* gumr_h */
+	gumr = 0;
+	gumr |= us_info->tcrc;
+	if (us_info->cdp)
+		gumr |= UCC_SLOW_GUMR_H_CDP;
+	if (us_info->ctsp)
+		gumr |= UCC_SLOW_GUMR_H_CTSP;
+	if (us_info->cds)
+		gumr |= UCC_SLOW_GUMR_H_CDS;
+	if (us_info->ctss)
+		gumr |= UCC_SLOW_GUMR_H_CTSS;
+	if (us_info->tfl)
+		gumr |= UCC_SLOW_GUMR_H_TFL;
+	if (us_info->rfw)
+		gumr |= UCC_SLOW_GUMR_H_RFW;
+	if (us_info->txsy)
+		gumr |= UCC_SLOW_GUMR_H_TXSY;
+	if (us_info->rtsm)
+		gumr |= UCC_SLOW_GUMR_H_RTSM;
+	out_be32(&us_regs->gumr_h, gumr);
+
+	/* gumr_l */
+	gumr = 0;
+	if (us_info->tci)
+		gumr |= UCC_SLOW_GUMR_L_TCI;
+	if (us_info->rinv)
+		gumr |= UCC_SLOW_GUMR_L_RINV;
+	if (us_info->tinv)
+		gumr |= UCC_SLOW_GUMR_L_TINV;
+	if (us_info->tend)
+		gumr |= UCC_SLOW_GUMR_L_TEND;
+	gumr |= us_info->tdcr;
+	gumr |= us_info->rdcr;
+	gumr |= us_info->tenc;
+	gumr |= us_info->renc;
+	gumr |= us_info->diag;
+	gumr |= us_info->mode;
+	out_be32(&us_regs->gumr_l, gumr);
+
+	/* Function code registers */
+	/* function_code has initial value 0 */
+
+	/* if the data is in cachable memory, the 'global' */
+	/* in the function code should be set. */
+	function_code |= us_info->data_mem_part;
+	function_code |= QE_BMR_BYTE_ORDER_BO_MOT;	/* Required for QE */
+	uccs->us_pram->tfcr = function_code;
+	uccs->us_pram->rfcr = function_code;
+
+	/* rbase, tbase are offsets from MURAM base */
+	out_be16(&uccs->us_pram->rbase, uccs->us_pram_offset);
+	out_be16(&uccs->us_pram->tbase, uccs->us_pram_offset);
+
+	/* Mux clocking */
+	/* Grant Support */
+	ucc_set_qe_mux_grant(us_info->ucc_num, us_info->grant_support);
+	/* Breakpoint Support */
+	ucc_set_qe_mux_bkpt(us_info->ucc_num, us_info->brkpt_support);
+	/* Set Tsa or NMSI mode. */
+	ucc_set_qe_mux_tsa(us_info->ucc_num, us_info->tsa);
+	/* If NMSI (not Tsa), set Tx and Rx clock. */
+	if (!us_info->tsa) {
+		/* Rx clock routing */
+		if (ucc_set_qe_mux_rxtx
+		    (us_info->ucc_num, us_info->rx_clock, COMM_DIR_RX)) {
+			uccs_err
+			    ("ucc_slow_init: Illegal value for parameter"
+				" 'RxClock'.");
+			ucc_slow_free(uccs);
+			return -EINVAL;
+		}
+		/* Tx clock routing */
+		if (ucc_set_qe_mux_rxtx(us_info->ucc_num,
+				 us_info->tx_clock, COMM_DIR_TX)) {
+			uccs_err
+			    ("ucc_slow_init: Illegal value for parameter "
+				"'TxClock'.");
+			ucc_slow_free(uccs);
+			return -EINVAL;
+		}
+	}
+
+	/*
+	 * INTERRUPTS
+	 */
+	/* Set interrupt mask register at UCC level. */
+	out_be16(&us_regs->uccm, us_info->uccm_mask);
+
+	/* First, clear anything pending at UCC level, */
+	/* otherwise, old garbage may come through */
+	/* as soon as the dam is opened. */
+
+	/* Writing '1' clears */
+	out_be16(&us_regs->ucce, 0xffff);
+
+	/* Issue QE Init command */
+	if (us_info->init_tx && us_info->init_rx)
+		command = QE_INIT_TX_RX;
+	else if (us_info->init_tx)
+		command = QE_INIT_TX;
+	else
+		command = QE_INIT_RX;	/* We know at least one is TRUE */
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(command, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
+
+	*uccs_ret = uccs;
+	return 0;
+}
+
+void ucc_slow_free(struct ucc_slow_private * uccs)
+{
+	if (!uccs)
+		return;
+
+	if (uccs->rx_base_offset)
+		qe_muram_free(uccs->rx_base_offset);
+
+	if (uccs->tx_base_offset)
+		qe_muram_free(uccs->tx_base_offset);
+
+	if (uccs->us_pram) {
+		qe_muram_free(uccs->us_pram_offset);
+		uccs->us_pram = NULL;
+	}
+
+	kfree(uccs);
+}
-- 
1.4.2.3
