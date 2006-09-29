Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 6F1A067C17
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 20:34:51 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	k8TAYoY9016953
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 03:34:50 -0700 (MST)
Received: from zch01exm20.fsl.freescale.net (zch01exm20.ap.freescale.net
	[10.192.129.204])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k8TAYjhm011994
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Sep 2006 05:34:46 -0500 (CDT)
Message-ID: <451CF6EB.3020203@freescale.com>
Date: Fri, 29 Sep 2006 18:35:23 +0800
From: Li Yang <leoli@freescale.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [PATCH 4/9] qe_lib: Add UCC common API
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Shlomi Gridish <gridish@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com> 

---
 arch/powerpc/sysdev/qe_lib/ucc.c      |  346 ++++++++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/ucc_fast.c |  408 +++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/qe_lib/ucc_slow.c |  406 +++++++++++++++++++++++++++++++++
 include/asm-powerpc/ucc.h             |   84 +++++++
 include/asm-powerpc/ucc_fast.h        |  254 +++++++++++++++++++++
 include/asm-powerpc/ucc_slow.h        |  304 +++++++++++++++++++++++++
 6 files changed, 1802 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/arch/powerpc/sysdev/qe_lib/ucc.c
new file mode 100644
index 0000000..edb0acb
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/ucc.c
@@ -0,0 +1,346 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * QE UCC API Set - UCC specific routines implementations.
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
+	case (0):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr1);
+		*reg_num = 1;
+		*shift = 16;
+		break;
+	case (2):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr1);
+		*reg_num = 1;
+		*shift = 0;
+		break;
+	case (4):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr2);
+		*reg_num = 2;
+		*shift = 16;
+		break;
+	case (6):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr2);
+		*reg_num = 2;
+		*shift = 0;
+		break;
+	case (1):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr3);
+		*reg_num = 3;
+		*shift = 16;
+		break;
+	case (3):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr3);
+		*reg_num = 3;
+		*shift = 0;
+		break;
+	case (5):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr4);
+		*reg_num = 4;
+		*shift = 16;
+		break;
+	case (7):
+		*p_cmxucr = &(qe_immr->qmx.cmxucr4);
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
+int ucc_set_qe_mux_rxtx(int ucc_num, qe_clock_e clock, comm_dir_e mode)
+{
+	volatile u32 *p_cmxucr;
+	u8 reg_num;
+	u8 shift;
+	u32 clockBits;
+	u32 clockMask;
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
+	case (1):
+		switch (clock) {
+		case (QE_BRG1):
+			source = 1;
+			break;
+		case (QE_BRG2):
+			source = 2;
+			break;
+		case (QE_BRG7):
+			source = 3;
+			break;
+		case (QE_BRG8):
+			source = 4;
+			break;
+		case (QE_CLK9):
+			source = 5;
+			break;
+		case (QE_CLK10):
+			source = 6;
+			break;
+		case (QE_CLK11):
+			source = 7;
+			break;
+		case (QE_CLK12):
+			source = 8;
+			break;
+		case (QE_CLK15):
+			source = 9;
+			break;
+		case (QE_CLK16):
+			source = 10;
+			break;
+		default:
+			source = -1;
+			break;
+		}
+		break;
+	case (2):
+		switch (clock) {
+		case (QE_BRG5):
+			source = 1;
+			break;
+		case (QE_BRG6):
+			source = 2;
+			break;
+		case (QE_BRG7):
+			source = 3;
+			break;
+		case (QE_BRG8):
+			source = 4;
+			break;
+		case (QE_CLK13):
+			source = 5;
+			break;
+		case (QE_CLK14):
+			source = 6;
+			break;
+		case (QE_CLK19):
+			source = 7;
+			break;
+		case (QE_CLK20):
+			source = 8;
+			break;
+		case (QE_CLK15):
+			source = 9;
+			break;
+		case (QE_CLK16):
+			source = 10;
+			break;
+		default:
+			source = -1;
+			break;
+		}
+		break;
+	case (3):
+		switch (clock) {
+		case (QE_BRG9):
+			source = 1;
+			break;
+		case (QE_BRG10):
+			source = 2;
+			break;
+		case (QE_BRG15):
+			source = 3;
+			break;
+		case (QE_BRG16):
+			source = 4;
+			break;
+		case (QE_CLK3):
+			source = 5;
+			break;
+		case (QE_CLK4):
+			source = 6;
+			break;
+		case (QE_CLK17):
+			source = 7;
+			break;
+		case (QE_CLK18):
+			source = 8;
+			break;
+		case (QE_CLK7):
+			source = 9;
+			break;
+		case (QE_CLK8):
+			source = 10;
+			break;
+		default:
+			source = -1;
+			break;
+		}
+		break;
+	case (4):
+		switch (clock) {
+		case (QE_BRG13):
+			source = 1;
+			break;
+		case (QE_BRG14):
+			source = 2;
+			break;
+		case (QE_BRG15):
+			source = 3;
+			break;
+		case (QE_BRG16):
+			source = 4;
+			break;
+		case (QE_CLK5):
+			source = 5;
+			break;
+		case (QE_CLK6):
+			source = 6;
+			break;
+		case (QE_CLK21):
+			source = 7;
+			break;
+		case (QE_CLK22):
+			source = 8;
+			break;
+		case (QE_CLK7):
+			source = 9;
+			break;
+		case (QE_CLK8):
+			source = 10;
+			break;
+		default:
+			source = -1;
+			break;
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
+	clockBits = (u32) source;
+	clockMask = QE_CMXUCR_TX_CLK_SRC_MASK;
+	if (mode == COMM_DIR_RX) {
+		clockBits <<= 4;  /* Rx field is 4 bits to left of Tx field */
+		clockMask <<= 4;  /* Rx field is 4 bits to left of Tx field */
+	}
+	clockBits <<= shift;
+	clockMask <<= shift;
+
+	out_be32(p_cmxucr, (in_be32(p_cmxucr) & ~clockMask) | clockBits);
+
+	return 0;
+}
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
new file mode 100644
index 0000000..ea174d6
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -0,0 +1,408 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * QE UCC Fast API Set - UCC Fast specific routines implementations.
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
+#define uccf_printk(level, format, arg...)  \
+        printk(level format "\n", ## arg)
+
+#define uccf_dbg(format, arg...)            \
+        uccf_printk(KERN_DEBUG , format , ## arg)
+#define uccf_err(format, arg...)            \
+        uccf_printk(KERN_ERR , format , ## arg)
+#define uccf_info(format, arg...)           \
+        uccf_printk(KERN_INFO , format , ## arg)
+#define uccf_warn(format, arg...)           \
+        uccf_printk(KERN_WARNING , format , ## arg)
+
+#ifdef UCCF_VERBOSE_DEBUG
+#define uccf_vdbg uccf_dbg
+#else
+#define uccf_vdbg(fmt, args...) do { } while (0)
+#endif				/* UCCF_VERBOSE_DEBUG */
+
+void ucc_fast_dump_regs(ucc_fast_private_t * uccf)
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
+	case (0):
+		return (QE_CR_SUBBLOCK_UCCFAST1);
+	case (1):
+		return (QE_CR_SUBBLOCK_UCCFAST2);
+	case (2):
+		return (QE_CR_SUBBLOCK_UCCFAST3);
+	case (3):
+		return (QE_CR_SUBBLOCK_UCCFAST4);
+	case (4):
+		return (QE_CR_SUBBLOCK_UCCFAST5);
+	case (5):
+		return (QE_CR_SUBBLOCK_UCCFAST6);
+	case (6):
+		return (QE_CR_SUBBLOCK_UCCFAST7);
+	case (7):
+		return (QE_CR_SUBBLOCK_UCCFAST8);
+	default:
+		return QE_CR_SUBBLOCK_INVALID;
+	}
+}
+
+void ucc_fast_transmit_on_demand(ucc_fast_private_t * uccf)
+{
+	out_be16(&uccf->uf_regs->utodr, UCC_FAST_TOD);
+}
+
+void ucc_fast_enable(ucc_fast_private_t * uccf, comm_dir_e mode)
+{
+	ucc_fast_t *uf_regs;
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
+void ucc_fast_disable(ucc_fast_private_t * uccf, comm_dir_e mode)
+{
+	ucc_fast_t *uf_regs;
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
+int ucc_fast_init(ucc_fast_info_t * uf_info, ucc_fast_private_t ** uccf_ret)
+{
+	ucc_fast_private_t *uccf;
+	ucc_fast_t *uf_regs;
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
+	    (ucc_fast_private_t *) kmalloc(sizeof(ucc_fast_private_t),
+					   GFP_KERNEL);
+	if (!uccf) {
+		uccf_err
+		    ("ucc_fast_init: No memory for UCC slow data structure!");
+		return -ENOMEM;
+	}
+	memset(uccf, 0, sizeof(ucc_fast_private_t));
+
+	/* Fill fast UCC structure */
+	uccf->uf_info = uf_info;
+	/* Set the PHY base address */
+	uccf->uf_regs =
+	    (ucc_fast_t *) ioremap(uf_info->regs, sizeof(ucc_fast_t));
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
+	if ((ret = ucc_init_guemr((ucc_common_t *) (uf_regs)))) {
+		uccf_err("ucc_fast_init: Could not init the guemr register.");
+		ucc_fast_free(uccf);
+		return ret;
+	}
+
+	/* Set UCC to fast type */
+	if ((ret = ucc_set_type(uf_info->ucc_num,
+				(ucc_common_t *) (uf_regs),
+				UCC_SPEED_TYPE_FAST))) {
+		uccf_err("ucc_fast_init: Could not set type to fast.");
+		ucc_fast_free(uccf);
+		return ret;
+	}
+
+	uccf->mrblr = uf_info->max_rx_buf_length;
+
+	/* Set GUMR.                               */
+	/* For more details see the hardware spec. */
+	/* gumr starts as zero.                    */
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
+			"ucc_fast_tx_virtual_fifo_base_offset.");
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
+	/*
+	 * INTERRUPTS
+	 */
+	/* Set interrupt mask register at UCC level. */
+	out_be32(&uf_regs->uccm, uf_info->uccm_mask);
+
+	/* First, clear anything pending at UCC level, */
+	/* otherwise, old garbage may come through     */
+	/* as soon as the dam is opened.               */
+
+	/* Writing '1' clears */
+	out_be32(&uf_regs->ucce, 0xffffffff);
+
+	*uccf_ret = uccf;
+	return 0;
+}
+
+void ucc_fast_free(ucc_fast_private_t * uccf)
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
index 0000000..059491f
--- /dev/null
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -0,0 +1,406 @@
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
+#define uccs_printk(level, format, arg...)  \
+        printk(level format "\n", ## arg)
+
+#define uccs_dbg(format, arg...)            \
+        uccs_printk(KERN_DEBUG , format , ## arg)
+#define uccs_err(format, arg...)            \
+        uccs_printk(KERN_ERR , format , ## arg)
+#define uccs_info(format, arg...)           \
+        uccs_printk(KERN_INFO , format , ## arg)
+#define uccs_warn(format, arg...)           \
+        uccs_printk(KERN_WARNING , format , ## arg)
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
+	case (0):
+		return (QE_CR_SUBBLOCK_UCCSLOW1);
+	case (1):
+		return (QE_CR_SUBBLOCK_UCCSLOW2);
+	case (2):
+		return (QE_CR_SUBBLOCK_UCCSLOW3);
+	case (3):
+		return (QE_CR_SUBBLOCK_UCCSLOW4);
+	case (4):
+		return (QE_CR_SUBBLOCK_UCCSLOW5);
+	case (5):
+		return (QE_CR_SUBBLOCK_UCCSLOW6);
+	case (6):
+		return (QE_CR_SUBBLOCK_UCCSLOW7);
+	case (7):
+		return (QE_CR_SUBBLOCK_UCCSLOW8);
+	default:
+		return QE_CR_SUBBLOCK_INVALID;
+	}
+}
+
+void ucc_slow_poll_transmitter_now(ucc_slow_private_t * uccs)
+{
+	out_be16(&uccs->us_regs->utodr, UCC_SLOW_TOD);
+}
+
+void ucc_slow_graceful_stop_tx(ucc_slow_private_t * uccs)
+{
+	ucc_slow_info_t *us_info = uccs->us_info;
+	u32 id;
+
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_GRACEFUL_STOP_TX, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED,
+		     0);
+}
+
+void ucc_slow_stop_tx(ucc_slow_private_t * uccs)
+{
+	ucc_slow_info_t *us_info = uccs->us_info;
+	u32 id;
+
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_STOP_TX, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
+}
+
+void ucc_slow_restart_tx(ucc_slow_private_t * uccs)
+{
+	ucc_slow_info_t *us_info = uccs->us_info;
+	u32 id;
+
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_RESTART_TX, id, (u8) QE_CR_PROTOCOL_UNSPECIFIED, 0);
+}
+
+void ucc_slow_enable(ucc_slow_private_t * uccs, comm_dir_e mode)
+{
+	ucc_slow_t *us_regs;
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
+void ucc_slow_disable(ucc_slow_private_t * uccs, comm_dir_e mode)
+{
+	ucc_slow_t *us_regs;
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
+int ucc_slow_init(ucc_slow_info_t * us_info, ucc_slow_private_t ** uccs_ret)
+{
+	u32 i;
+	ucc_slow_t *us_regs;
+	u32 gumr;
+	u8 function_code = 0;
+	u8 *bd;
+	ucc_slow_private_t *uccs;
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
+	/* Set mrblr */
+	/* Check that 'max_rx_buf_length' is properly aligned (4), unless 
+	rfw is 1, meaning that QE accepts one byte at a time, unlike normal 
+	case when QE accepts 32 bits at a time. */
+	if ((!us_info->rfw)
+	    && (us_info->max_rx_buf_length & (UCC_SLOW_MRBLR_ALIGNMENT - 1))) {
+		uccs_err("max_rx_buf_length not aligned.");
+		return -EINVAL;
+	}
+
+	uccs =
+	    (ucc_slow_private_t *) kmalloc(sizeof(ucc_slow_private_t),
+					   GFP_KERNEL);
+	if (!uccs) {
+		uccs_err
+		    ("ucc_slow_init: No memory for UCC slow data structure!");
+		return -ENOMEM;
+	}
+	memset(uccs, 0, sizeof(ucc_slow_private_t));
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
+	uccs->us_pram_offset =
+	    qe_muram_alloc(UCC_SLOW_PRAM_SIZE, ALIGNMENT_OF_UCC_SLOW_PRAM);
+	if (IS_MURAM_ERR(uccs->us_pram_offset)) {
+		uccs_err
+		    ("ucc_slow_init: Can not allocate MURAM memory " \
+			"for Slow UCC.");
+		ucc_slow_free(uccs);
+		return -ENOMEM;
+	}
+	id = ucc_slow_get_qe_cr_subblock(us_info->ucc_num);
+	qe_issue_cmd(QE_ASSIGN_PAGE_TO_DEVICE, id, QE_CR_PROTOCOL_UNSPECIFIED,
+		     (u32) uccs->us_pram_offset);
+
+	uccs->us_pram = qe_muram_addr(uccs->us_pram_offset);
+
+	/* Init Guemr register */
+	if ((ret = ucc_init_guemr((ucc_common_t *) (us_info->us_regs)))) {
+		uccs_err("ucc_slow_init: Could not init the guemr register.");
+		ucc_slow_free(uccs);
+		return ret;
+	}
+
+	/* Set UCC to slow type */
+	if ((ret = ucc_set_type(us_info->ucc_num,
+				(ucc_common_t *) (us_info->us_regs),
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
+	    qe_muram_alloc(us_info->rx_bd_ring_len * UCC_SLOW_SIZE_OF_BD,
+			   QE_ALIGNMENT_OF_BD);
+	if (IS_MURAM_ERR(uccs->rx_base_offset)) {
+		uccs_err("ucc_slow_init: No memory for Rx BD's.");
+		uccs->rx_base_offset = 0;
+		ucc_slow_free(uccs);
+		return -ENOMEM;
+	}
+
+	uccs->tx_base_offset =
+	    qe_muram_alloc(us_info->tx_bd_ring_len * UCC_SLOW_SIZE_OF_BD,
+			   QE_ALIGNMENT_OF_BD);
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
+		BD_BUFFER_CLEAR(bd);
+		BD_STATUS_AND_LENGTH_SET(bd, 0);
+		bd += QE_SIZEOF_BD;
+	}
+	bd -= QE_SIZEOF_BD;
+	BD_STATUS_AND_LENGTH_SET(bd, T_W);	/* for last BD set Wrap bit */
+
+	/* Init Rx bds */
+	bd = uccs->rx_bd = qe_muram_addr(uccs->rx_base_offset);
+	for (i = 0; i < us_info->rx_bd_ring_len; i++) {
+		BD_STATUS_AND_LENGTH_SET(bd, 0);
+		BD_BUFFER_CLEAR(bd);
+		bd += QE_SIZEOF_BD;
+	}
+	bd -= QE_SIZEOF_BD;
+	BD_STATUS_AND_LENGTH_SET(bd, R_W);	/* for last BD set Wrap bit */
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
+	/* in the function code should be set.             */
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
+			    ("ucc_slow_init: Illegal value for parameter" \
+				" 'RxClock'.");
+			ucc_slow_free(uccs);
+			return -EINVAL;
+		}
+		/* Tx clock routing */
+		if (ucc_set_qe_mux_rxtx
+		    (us_info->ucc_num, us_info->tx_clock, COMM_DIR_TX)) {
+			uccs_err
+			    ("ucc_slow_init: Illegal value for parameter " \
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
+	/* otherwise, old garbage may come through     */
+	/* as soon as the dam is opened.               */
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
+void ucc_slow_free(ucc_slow_private_t * uccs)
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
diff --git a/include/asm-powerpc/ucc.h b/include/asm-powerpc/ucc.h
new file mode 100644
index 0000000..a1becec
--- /dev/null
+++ b/include/asm-powerpc/ucc.h
@@ -0,0 +1,84 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * Internal header file for UCC unit routines.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __UCC_H__
+#define __UCC_H__
+
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#define STATISTICS
+
+#define UCC_MAX_NUM     8
+
+/* Slow or fast type for UCCs.
+*/
+typedef enum ucc_speed_type {
+	UCC_SPEED_TYPE_FAST, UCC_SPEED_TYPE_SLOW
+} ucc_speed_type_e;
+
+/* Initial UCCs Parameter RAM address relative to: MEM_MAP_BASE (IMMR).
+*/
+typedef enum ucc_pram_initial_offset {
+	UCC_PRAM_OFFSET_UCC1 = 0x8400, 
+	UCC_PRAM_OFFSET_UCC2 = 0x8500, 
+	UCC_PRAM_OFFSET_UCC3 = 0x8600,
+	UCC_PRAM_OFFSET_UCC4 = 0x9000,
+	UCC_PRAM_OFFSET_UCC5 = 0x8000,
+	UCC_PRAM_OFFSET_UCC6 = 0x8100,
+	UCC_PRAM_OFFSET_UCC7 = 0x8200,
+	UCC_PRAM_OFFSET_UCC8 = 0x8300
+} ucc_pram_initial_offset_e;
+
+/* ucc_set_type
+ * Sets UCC to slow or fast mode.
+ *
+ *          ucc_num  - (In) number of UCC  (0-7).
+ *          regs     - (In) pointer to registers base for the UCC.
+ *          speed    - (In) slow or fast mode for UCC.
+ */
+int ucc_set_type(int ucc_num, struct ucc_common *regs,
+		 enum ucc_speed_type speed);
+
+/* ucc_init_guemr
+ * Init the Guemr register.
+ *
+ *          regs - (In) pointer to registers base for the UCC.
+ */
+int ucc_init_guemr(struct ucc_common *regs);
+
+int ucc_set_qe_mux_mii_mng(int ucc_num);
+
+int ucc_set_qe_mux_rxtx(int ucc_num, qe_clock_e clock, comm_dir_e mode);
+
+int ucc_mux_set_grant_tsa_bkpt(int ucc_num, int set, u32 mask);
+
+/* QE MUX clock routing for UCC 
+*/
+static inline int ucc_set_qe_mux_grant(int ucc_num, int set)
+{
+	return ucc_mux_set_grant_tsa_bkpt(ucc_num, set, QE_CMXUCR_GRANT);
+}
+
+static inline int ucc_set_qe_mux_tsa(int ucc_num, int set)
+{
+	return ucc_mux_set_grant_tsa_bkpt(ucc_num, set, QE_CMXUCR_TSA);
+}
+
+static inline int ucc_set_qe_mux_bkpt(int ucc_num, int set)
+{
+	return ucc_mux_set_grant_tsa_bkpt(ucc_num, set, QE_CMXUCR_BKPT);
+}
+
+#endif				/* __UCC_H__ */
diff --git a/include/asm-powerpc/ucc_fast.h b/include/asm-powerpc/ucc_fast.h
new file mode 100644
index 0000000..7bac2f8
--- /dev/null
+++ b/include/asm-powerpc/ucc_fast.h
@@ -0,0 +1,254 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * Internal header file for UCC FAST unit routines.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __UCC_FAST_H__
+#define __UCC_FAST_H__
+
+#include <linux/kernel.h>
+
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#include "ucc.h"
+
+/* Receive BD's status.
+*/
+#define R_E     0x80000000	/* buffer empty */
+#define R_W     0x20000000	/* wrap bit     */
+#define R_I     0x10000000	/* interrupt on reception  */
+#define R_L     0x08000000	/* last */
+#define R_F     0x04000000	/* first */
+
+/* transmit BD's status.
+*/
+#define T_R     0x80000000	/* ready bit */
+#define T_W     0x20000000	/* wrap bit */
+#define T_I     0x10000000	/* interrupt on completion */
+#define T_L     0x08000000	/* last */
+
+/* Rx Data buffer must be 4 bytes aligned in most cases.*/
+#define UCC_FAST_RX_ALIGN                  4
+#define UCC_FAST_MRBLR_ALIGNMENT           4
+#define UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT  8
+
+/* Sizes 
+*/
+#define UCC_FAST_URFS_MIN_VAL                           0x88
+#define UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR 8
+
+/* ucc_fast_channel_protocol_mode - UCC FAST mode.
+*/
+typedef enum ucc_fast_channel_protocol_mode {
+	UCC_FAST_PROTOCOL_MODE_HDLC = 0x00000000,
+	UCC_FAST_PROTOCOL_MODE_RESERVED01 = 0x00000001,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_QMC = 0x00000002,
+	UCC_FAST_PROTOCOL_MODE_RESERVED02 = 0x00000003,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_UART = 0x00000004,
+	UCC_FAST_PROTOCOL_MODE_RESERVED03 = 0x00000005,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_EX_MAC_1 = 0x00000006,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_EX_MAC_2 = 0x00000007,
+	UCC_FAST_PROTOCOL_MODE_RESERVED_BISYNC = 0x00000008,
+	UCC_FAST_PROTOCOL_MODE_RESERVED04 = 0x00000009,
+	UCC_FAST_PROTOCOL_MODE_ATM = 0x0000000A,
+	UCC_FAST_PROTOCOL_MODE_RESERVED05 = 0x0000000B,
+	UCC_FAST_PROTOCOL_MODE_ETHERNET = 0x0000000C,
+	UCC_FAST_PROTOCOL_MODE_RESERVED06 = 0x0000000D,
+	UCC_FAST_PROTOCOL_MODE_POS = 0x0000000E,
+	UCC_FAST_PROTOCOL_MODE_RESERVED07 = 0x0000000F
+} ucc_fast_channel_protocol_mode_e;
+
+/* ucc_fast_transparent_txrx - UCC Fast Transparent TX & RX
+*/
+typedef enum ucc_fast_transparent_txrx {
+	UCC_FAST_GUMR_TRANSPARENT_TTX_TRX_NORMAL = 0x00000000,
+	UCC_FAST_GUMR_TRANSPARENT_TTX_TRX_TRANSPARENT = 0x18000000
+} ucc_fast_transparent_txrx_e;
+
+/* UCC fast diagnostic mode
+*/
+typedef enum ucc_fast_diag_mode {
+	UCC_FAST_DIAGNOSTIC_NORMAL = 0x0,
+	UCC_FAST_DIAGNOSTIC_LOCAL_LOOP_BACK = 0x40000000,
+	UCC_FAST_DIAGNOSTIC_AUTO_ECHO = 0x80000000,
+	UCC_FAST_DIAGNOSTIC_LOOP_BACK_AND_ECHO = 0xC0000000
+} ucc_fast_diag_mode_e;
+
+/* UCC fast Sync length (transparent mode only)
+*/
+typedef enum ucc_fast_sync_len {
+	UCC_FAST_SYNC_LEN_NOT_USED = 0x0,
+	UCC_FAST_SYNC_LEN_AUTOMATIC = 0x00004000,
+	UCC_FAST_SYNC_LEN_8_BIT = 0x00008000,
+	UCC_FAST_SYNC_LEN_16_BIT = 0x0000C000
+} ucc_fast_sync_len_e;
+
+/* UCC fast RTS mode
+*/
+typedef enum ucc_fast_ready_to_send {
+	UCC_FAST_SEND_IDLES_BETWEEN_FRAMES = 0x00000000,
+	UCC_FAST_SEND_FLAGS_BETWEEN_FRAMES = 0x00002000
+} ucc_fast_ready_to_send_e;
+
+/* UCC fast receiver decoding mode
+*/
+typedef enum ucc_fast_rx_decoding_method {
+	UCC_FAST_RX_ENCODING_NRZ = 0x00000000,
+	UCC_FAST_RX_ENCODING_NRZI = 0x00000800,
+	UCC_FAST_RX_ENCODING_RESERVED0 = 0x00001000,
+	UCC_FAST_RX_ENCODING_RESERVED1 = 0x00001800
+} ucc_fast_rx_decoding_method_e;
+
+/* UCC fast transmitter encoding mode
+*/
+typedef enum ucc_fast_tx_encoding_method {
+	UCC_FAST_TX_ENCODING_NRZ = 0x00000000,
+	UCC_FAST_TX_ENCODING_NRZI = 0x00000100,
+	UCC_FAST_TX_ENCODING_RESERVED0 = 0x00000200,
+	UCC_FAST_TX_ENCODING_RESERVED1 = 0x00000300
+} ucc_fast_tx_encoding_method_e;
+
+/* UCC fast CRC length
+*/
+typedef enum ucc_fast_transparent_tcrc {
+	UCC_FAST_16_BIT_CRC = 0x00000000,
+	UCC_FAST_CRC_RESERVED0 = 0x00000040,
+	UCC_FAST_32_BIT_CRC = 0x00000080,
+	UCC_FAST_CRC_RESERVED1 = 0x000000C0
+} ucc_fast_transparent_tcrc_e;
+
+/* Fast UCC initialization structure.
+*/
+typedef struct ucc_fast_info {
+	int ucc_num;
+	qe_clock_e rx_clock;
+	qe_clock_e tx_clock;
+	u32 regs;
+	int irq;
+	u32 uccm_mask;
+	int bd_mem_part;
+	int brkpt_support;
+	int grant_support;
+	int tsa;
+	int cdp;
+	int cds;
+	int ctsp;
+	int ctss;
+	int tci;
+	int txsy;
+	int rtsm;
+	int revd;
+	int rsyn;
+	u16 max_rx_buf_length;
+	u16 urfs;
+	u16 urfet;
+	u16 urfset;
+	u16 utfs;
+	u16 utfet;
+	u16 utftt;
+	u16 ufpt;
+	ucc_fast_channel_protocol_mode_e mode;
+	ucc_fast_transparent_txrx_e ttx_trx;
+	ucc_fast_tx_encoding_method_e tenc;
+	ucc_fast_rx_decoding_method_e renc;
+	ucc_fast_transparent_tcrc_e tcrc;
+	ucc_fast_sync_len_e synl;
+} ucc_fast_info_t;
+
+typedef struct ucc_fast_private {
+	ucc_fast_info_t *uf_info;
+	ucc_fast_t *uf_regs;	/* a pointer to memory map of UCC regs. */
+	u32 *p_ucce;		/* a pointer to the event register in memory. */
+	u32 *p_uccm;		/* a pointer to the mask register in memory.  */
+	int enabled_tx;		/* Whether channel is enabled for Tx (ENT)  */
+	int enabled_rx;		/* Whether channel is enabled for Rx (ENR) */
+	int stopped_tx;		/* Whether channel has been stopped for Tx 
+				   (STOP_TX, etc.) */
+	int stopped_rx;		/* Whether channel has been stopped for Rx */
+	u32 ucc_fast_tx_virtual_fifo_base_offset;/* pointer to base of Tx 
+						    virtual fifo */
+	u32 ucc_fast_rx_virtual_fifo_base_offset;/* pointer to base of Rx 
+						    virtual fifo */
+#ifdef STATISTICS
+	u32 tx_frames;		/* Transmitted frames counter. */
+	u32 rx_frames;		/* Received frames counter (only frames 
+				   passed to application). */
+	u32 tx_discarded;	/* Discarded tx frames counter (frames that 
+				   were discarded by the driver due to errors).
+				   */
+	u32 rx_discarded;	/* Discarded rx frames counter (frames that 
+				   were discarded by the driver due to errors).
+				   */
+#endif				/* STATISTICS */
+	u16 mrblr;		/* maximum receive buffer length */
+} ucc_fast_private_t;
+
+/* ucc_fast_init
+ * Initializes Fast UCC according to user provided parameters.
+ *
+ *          uf_info  - (In) pointer to the fast UCC info structure.
+ *          uccf_ret - (Out) pointer to the fast UCC structure.
+ */
+int ucc_fast_init(ucc_fast_info_t * uf_info, ucc_fast_private_t ** uccf_ret);
+
+/* ucc_fast_free
+ * Frees all resources for fast UCC.
+ *
+ *          uccf - (In) pointer to the fast UCC structure.
+ */
+void ucc_fast_free(ucc_fast_private_t * uccf);
+
+/* ucc_fast_enable
+ * Enables a fast UCC port.
+ * This routine enables Tx and/or Rx through the General UCC Mode Register.
+ *
+ *          uccf - (In) pointer to the fast UCC structure.
+ *          mode - (In) TX, RX, or both.
+ */
+void ucc_fast_enable(ucc_fast_private_t * uccf, comm_dir_e mode);
+
+/* ucc_fast_disable
+ * Disables a fast UCC port.
+ * This routine disables Tx and/or Rx through the General UCC Mode Register.
+ *
+ *          uccf - (In) pointer to the fast UCC structure.
+ *          mode - (In) TX, RX, or both.
+ */
+void ucc_fast_disable(ucc_fast_private_t * uccf, comm_dir_e mode);
+
+/* ucc_fast_irq
+ * Handles interrupts on fast UCC.
+ * Called from the general interrupt routine to handle interrupts on fast UCC.
+ *
+ *          uccf - (In) pointer to the fast UCC structure.
+ */
+void ucc_fast_irq(ucc_fast_private_t * uccf);
+
+/* ucc_fast_transmit_on_demand
+ * Immediately forces a poll of the transmitter for data to be sent.
+ * Typically, the hardware performs a periodic poll for data that the
+ * transmit routine has set up to be transmitted. In cases where
+ * this polling cycle is not soon enough, this optional routine can
+ * be invoked to force a poll right away, instead. Proper use for
+ * each transmission for which this functionality is desired is to
+ * call the transmit routine and then this routine right after.
+ *
+ *          uccf - (In) pointer to the fast UCC structure.
+ */
+void ucc_fast_transmit_on_demand(ucc_fast_private_t * uccf);
+
+u32 ucc_fast_get_qe_cr_subblock(int uccf_num);
+
+void ucc_fast_dump_regs(ucc_fast_private_t * uccf);
+
+#endif				/* __UCC_FAST_H__ */
diff --git a/include/asm-powerpc/ucc_slow.h b/include/asm-powerpc/ucc_slow.h
new file mode 100644
index 0000000..3398e49
--- /dev/null
+++ b/include/asm-powerpc/ucc_slow.h
@@ -0,0 +1,304 @@
+/*
+ * Copyright (C) 2006 Freescale Semicondutor, Inc. All rights reserved.
+ *
+ * Authors: 	Shlomi Gridish <gridish@freescale.com>
+ * 		Li Yang <leoli@freescale.com>
+ *
+ * Description:
+ * Internal header file for UCC SLOW unit routines.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+#ifndef __UCC_SLOW_H__
+#define __UCC_SLOW_H__
+
+#include <linux/kernel.h>
+
+#include <asm/immap_qe.h>
+#include <asm/qe.h>
+
+#include "ucc.h"
+
+#define UCC_SLOW_SIZE_OF_BD QE_SIZEOF_BD
+
+/* transmit BD's status.
+*/
+#define T_R     0x80000000	/* ready bit */
+#define T_PAD   0x40000000	/* add pads to short frames */
+#define T_W     0x20000000	/* wrap bit */
+#define T_I     0x10000000	/* interrupt on completion */
+#define T_L     0x08000000	/* last */
+
+#define T_A     0x04000000	/* Address - the data transmitted as address
+				   chars */
+#define T_TC    0x04000000	/* transmit CRC */
+#define T_CM    0x02000000	/* continuous mode */
+#define T_DEF   0x02000000	/* collision on previous attempt to transmit. */
+#define T_P     0x01000000	/* Preamble - send Preamble sequence before
+				   data */
+#define T_HB    0x01000000	/* heartbeat. */
+#define T_NS    0x00800000	/* No Stop */
+#define T_LC    0x00800000	/* late collision. */
+#define T_RL    0x00400000	/* retransmission limit. */
+#define T_UN    0x00020000	/* underrun */
+#define T_CT    0x00010000	/* CTS lost */
+#define T_CSL   0x00010000	/* carrier sense lost.  */
+#define T_RC    0x003c0000	/* retry count.  */
+
+/* Receive BD's status.
+*/
+#define R_E     0x80000000	/* buffer empty */
+#define R_W     0x20000000	/* wrap bit */
+#define R_I     0x10000000	/* interrupt on reception */
+#define R_L     0x08000000	/* last */
+#define R_C     0x08000000	/* the last byte in this buffer is a cntl
+				   char */
+#define R_F     0x04000000	/* first */
+#define R_A     0x04000000	/* the first byte in this buffer is address
+				   byte */
+#define R_CM    0x02000000	/* continuous mode */
+#define R_ID    0x01000000	/* buffer close on reception of idles */
+#define R_M     0x01000000	/* Frame received because of promiscuous
+				   mode. */
+#define R_AM    0x00800000	/* Address match */
+#define R_DE    0x00800000	/* Address match */
+#define R_LG    0x00200000	/* Break received */
+#define R_BR    0x00200000	/* Frame length violation */
+#define R_NO    0x00100000	/* Rx Non Octet Aligned Packet */
+#define R_FR    0x00100000	/* Framing Error (no stop bit) character
+				   received */
+#define R_PR    0x00080000	/* Parity Error character received */
+#define R_AB    0x00080000	/* Frame Aborted */
+#define R_SH    0x00080000	/* frame is too short.  */
+#define R_CR    0x00040000	/* CRC Error */
+#define R_OV    0x00020000	/* Overrun */
+#define R_CD    0x00010000	/* CD lost */
+#define R_CL    0x00010000	/* this frame is closed because of a
+				   collision */
+
+/* Rx Data buffer must be 4 bytes aligned in most cases.*/
+#define UCC_SLOW_RX_ALIGN             4
+#define UCC_SLOW_MRBLR_ALIGNMENT      4
+#define UCC_SLOW_PRAM_SIZE            0x100
+#define ALIGNMENT_OF_UCC_SLOW_PRAM    64
+
+/* UCC Slow Channel Protocol Mode
+*/
+typedef enum ucc_slow_channel_protocol_mode {
+	UCC_SLOW_CHANNEL_PROTOCOL_MODE_QMC = 0x00000002,	/* QMC */
+	UCC_SLOW_CHANNEL_PROTOCOL_MODE_UART = 0x00000004,	/* UART */
+	UCC_SLOW_CHANNEL_PROTOCOL_MODE_BISYNC = 0x00000008	/* BISYNC */
+} ucc_slow_channel_protocol_mode_e;
+
+/* UCC Slow Transparent Transmit CRC (TCRC)
+*/
+typedef enum ucc_slow_transparent_tcrc {
+	UCC_SLOW_TRANSPARENT_TCRC_CCITT_CRC16 = 0x00000000,	/* 16-bit
+								   CCITT CRC
+								   (HDLC).
+								   (X16 + X12 
+								   + X5 + 1) */
+	UCC_SLOW_TRANSPARENT_TCRC_CRC16 = 0x00004000,	/* CRC16 (BISYNC).
+							   (X16 + X15 + X2 +
+							   1) */
+	UCC_SLOW_TRANSPARENT_TCRC_CCITT_CRC32 = 0x00008000	/* 32-bit
+								   CCITT CRC
+								   (Ethernet
+								   and HDLC). 
+								 */
+} ucc_slow_transparent_tcrc_e;
+
+/* UCC Slow oversampling rate for transmitter (TDCR)
+*/
+typedef enum ucc_slow_tx_oversampling_rate {
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_1 = 0x00000000,	/* 1x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_8 = 0x00010000,	/* 8x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_16 = 0x00020000,	/* 16x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_TX_TDCR_32 = 0x00030000	/* 32x clock
+								   mode */
+} ucc_slow_tx_oversampling_rate_e;
+
+/* UCC Slow Oversampling rate for receiver (RDCR)
+*/
+typedef enum ucc_slow_rx_oversampling_rate {
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_1 = 0x00000000,	/* 1x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_8 = 0x00004000,	/* 8x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_16 = 0x00008000,	/* 16x clock
+								   mode */
+	UCC_SLOW_OVERSAMPLING_RATE_RX_RDCR_32 = 0x0000c000	/* 32x clock
+								   mode */
+} ucc_slow_rx_oversampling_rate_e;
+
+/* UCC Slow Transmitter encoding method (TENC)
+*/
+typedef enum ucc_slow_tx_encoding_method {
+	UCC_SLOW_TRANSMITTER_ENCODING_METHOD_TENC_NRZ = 0x00000000,
+	UCC_SLOW_TRANSMITTER_ENCODING_METHOD_TENC_NRZI = 0x00000100
+} ucc_slow_tx_encoding_method_e;
+
+/* UCC Slow Receiver decoding method (RENC)
+*/
+typedef enum ucc_slow_rx_decoding_method {
+	UCC_SLOW_RECEIVER_DECODING_METHOD_RENC_NRZ = 0x00000000,
+	UCC_SLOW_RECEIVER_DECODING_METHOD_RENC_NRZI = 0x00000800
+} ucc_slow_rx_decoding_method_e;
+
+/* UCC Slow Diagnostic mode (DIAG)
+*/
+typedef enum ucc_slow_diag_mode {
+	UCC_SLOW_DIAG_MODE_NORMAL = 0x00000000,
+	UCC_SLOW_DIAG_MODE_LOOPBACK = 0x00000040,
+	UCC_SLOW_DIAG_MODE_ECHO = 0x00000080,
+	UCC_SLOW_DIAG_MODE_LOOPBACK_ECHO = 0x000000c0
+} ucc_slow_diag_mode_e;
+
+typedef struct ucc_slow_info {
+	int ucc_num;
+	qe_clock_e rx_clock;
+	qe_clock_e tx_clock;
+	ucc_slow_t *us_regs;
+	int irq;
+	u16 uccm_mask;
+	int data_mem_part;
+	int init_tx;
+	int init_rx;
+	u32 tx_bd_ring_len;
+	u32 rx_bd_ring_len;
+	int rx_interrupts;
+	int brkpt_support;
+	int grant_support;
+	int tsa;
+	int cdp;
+	int cds;
+	int ctsp;
+	int ctss;
+	int rinv;
+	int tinv;
+	int rtsm;
+	int rfw;
+	int tci;
+	int tend;
+	int tfl;
+	int txsy;
+	u16 max_rx_buf_length;
+	ucc_slow_transparent_tcrc_e tcrc;
+	ucc_slow_channel_protocol_mode_e mode;
+	ucc_slow_diag_mode_e diag;
+	ucc_slow_tx_oversampling_rate_e tdcr;
+	ucc_slow_rx_oversampling_rate_e rdcr;
+	ucc_slow_tx_encoding_method_e tenc;
+	ucc_slow_rx_decoding_method_e renc;
+} ucc_slow_info_t;
+
+typedef struct ucc_slow_private {
+	ucc_slow_info_t *us_info;
+	ucc_slow_t *us_regs;	/* a pointer to memory map of UCC regs.  */
+	ucc_slow_pram_t *us_pram;	/* a pointer to the parameter RAM.  */
+	uint us_pram_offset;
+	int enabled_tx;		/* Whether channel is enabled for Tx (ENT) */
+	int enabled_rx;		/* Whether channel is enabled for Rx (ENR) */
+	int stopped_tx;		/* Whether channel has been stopped for Tx
+				   (STOP_TX, etc.) */
+	int stopped_rx;		/* Whether channel has been stopped for Rx */
+	struct list_head confQ;	/* frames passed to chip waiting for tx */
+	u32 first_tx_bd_mask;	/* mask is used in Tx routine to save status
+				   and length for first BD in a frame.  */
+	uint tx_base_offset;	/* first BD in Tx BD table offset (In MURAM) */
+	uint rx_base_offset;	/* first BD in Rx BD table offset (In MURAM) */
+	u8 *confBd;		/* next BD for confirm after Tx */
+	u8 *tx_bd;		/* next BD for new Tx request */
+	u8 *rx_bd;		/* next BD to collect after Rx */
+	void *p_rx_frame;	/* accumulating receive frame */
+	u16 *p_ucce;		/* a pointer to the event register in memory. 
+				 */
+	u16 *p_uccm;		/* a pointer to the mask register in memory.
+				   */
+	u16 saved_uccm;		/* a saved mask for the RX Interrupt bits.  */
+#ifdef STATISTICS
+	u32 tx_frames;		/* Transmitted frames counters.  */
+	u32 rx_frames;		/* Received frames counters (only frames
+				   passed to application).  */
+	u32 rx_discarded;	/* Discarded frames counters (frames that
+				   were discarded by the driver due to
+				   errors). */
+#endif				/* STATISTICS */
+} ucc_slow_private_t;
+
+/* ucc_slow_init
+ * Initializes Slow UCC according to provided parameters.
+ *
+ *          us_info  - (In) pointer to the slow UCC info structure.
+ *          uccs_ret - (Out) pointer to the slow UCC structure.
+ */
+int ucc_slow_init(ucc_slow_info_t * us_info, ucc_slow_private_t ** uccs_ret);
+
+/* ucc_slow_free
+ * Frees all resources for slow UCC.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_free(ucc_slow_private_t * uccs);
+
+/* ucc_slow_enable
+ * Enables a fast UCC port.
+ * This routine enables Tx and/or Rx through the General UCC Mode Register.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ *          mode - (In) TX, RX, or both.
+ */
+void ucc_slow_enable(ucc_slow_private_t * uccs, comm_dir_e mode);
+
+/* ucc_slow_disable
+ * Disables a fast UCC port.
+ * This routine disables Tx and/or Rx through the General UCC Mode Register.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ *          mode - (In) TX, RX, or both.
+ */
+void ucc_slow_disable(ucc_slow_private_t * uccs, comm_dir_e mode);
+
+/* ucc_slow_poll_transmitter_now
+ * Immediately forces a poll of the transmitter for data to be sent.
+ * Typically, the hardware performs a periodic poll for data that the
+ * transmit routine has set up to be transmitted. In cases where
+ * this polling cycle is not soon enough, this optional routine can
+ * be invoked to force a poll right away, instead. Proper use for
+ * each transmission for which this functionality is desired is to
+ * call the transmit routine and then this routine right after.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_poll_transmitter_now(ucc_slow_private_t * uccs);
+
+/* ucc_slow_graceful_stop_tx
+ * Smoothly stops transmission on a specified slow UCC.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_graceful_stop_tx(ucc_slow_private_t * uccs);
+
+/* ucc_slow_stop_tx
+ * Stops transmission on a specified slow UCC.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_stop_tx(ucc_slow_private_t * uccs);
+
+/* ucc_slow_restart_x
+ * Restarts transmitting on a specified slow UCC.
+ *
+ *          uccs - (In) pointer to the slow UCC structure.
+ */
+void ucc_slow_restart_x(ucc_slow_private_t * uccs);
+
+u32 ucc_slow_get_qe_cr_subblock(int uccs_num);
+
+#endif				/* __UCC_SLOW_H__ */
