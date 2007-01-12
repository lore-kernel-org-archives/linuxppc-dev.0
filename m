Return-Path: <akira2.iguchi@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5DC7BDDEB9
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 21:00:00 +1100 (EST)
Received: from wall11.toshiba.co.jp (wall11 [133.199.90.149])
	by imx12.toshiba.co.jp  with ESMTP id l0C9xuOR018935
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:59:56 +0900 (JST)
Received: (from root@localhost) by wall11.toshiba.co.jp  id l0C9xtYK024747
	for linuxppc-dev@ozlabs.org; Fri, 12 Jan 2007 18:59:55 +0900 (JST)
Received: from mx12.toshiba.co.jp (localhost [127.0.0.1])
	by ovp11.toshiba.co.jp  with ESMTP id l0C9xsTn014255
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 18:59:54 +0900 (JST)
Message-Id: <200701120959.l0C9xrxr010012@toshiba.co.jp>
MIME-Version: 1.0
Date: Fri, 12 Jan 2007 19:02:20 +0900
From: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
To: linux-ide@vger.kernel.org
Subject: [PATCH 4/4] drivers/ata: PATA driver
	for Celleb
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds kernel configuration and driver code
for Celleb.

Because this PATA controller supports only 32bit access,
this driver define low-level calls in ata_io_operations.

Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>
Signed-off-by: Akira Iguchi <akira2.iguchi@toshiba.co.jp>
---

--- linux-2.6.20-rc4/drivers/ata/Kconfig.orig	2007-01-13 01:01:34.000000000 +0900
+++ linux-2.6.20-rc4/drivers/ata/Kconfig	2007-01-13 01:02:44.000000000 +0900
@@ -518,6 +518,15 @@ config PATA_IXP4XX_CF
 
 	  If unsure, say N.
 
+config PATA_SCC
+        tristate "Toshiba's Cell Reference Set IDE support"
+        depends on PCI
+        help
+          This option enables support for the built-in IDE controller on
+          Toshiba Cell Reference Board.
+
+          If unsure, say N.
+
 endif
 endmenu
 
--- linux-2.6.20-rc4/drivers/ata/Makefile.orig	2007-01-13 01:01:38.000000000 +0900
+++ linux-2.6.20-rc4/drivers/ata/Makefile	2007-01-13 01:02:50.000000000 +0900
@@ -56,6 +56,7 @@ obj-$(CONFIG_PATA_WINBOND_VLB)	+= pata_w
 obj-$(CONFIG_PATA_SIS)		+= pata_sis.o
 obj-$(CONFIG_PATA_TRIFLEX)	+= pata_triflex.o
 obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
+obj-$(CONFIG_PATA_SCC)		+= pata_scc.o
 obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
 # Should be last but one libata driver
 obj-$(CONFIG_ATA_GENERIC)	+= ata_generic.o
--- linux-2.6.20-rc4/drivers/ata/pata_scc.c.orig	2007-01-13 01:02:11.000000000 +0900
+++ linux-2.6.20-rc4/drivers/ata/pata_scc.c	2007-01-13 01:50:04.000000000 +0900
@@ -0,0 +1,1141 @@
+/*
+ * Support for IDE interfaces on Celleb platform
+ *
+ * (C) Copyright 2006 TOSHIBA CORPORATION
+ *
+ * This code is based on drivers/ata/ata_piix.c:
+ *  Copyright 2003-2005 Red Hat Inc
+ *  Copyright 2003-2005 Jeff Garzik
+ *  Copyright (C) 1998-1999 Andrzej Krzysztofowicz, Author and Maintainer
+ *  Copyright (C) 1998-2000 Andre Hedrick <andre@linux-ide.org>
+ *  Copyright (C) 2003 Red Hat Inc <alan@redhat.com>
+ *
+ * and drivers/ata/libata-core.c:
+ *  Copyright 2003-2004 Red Hat, Inc.  All rights reserved.
+ *  Copyright 2003-2004 Jeff Garzik
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+
+#define DRV_NAME		"ata_scc"
+#define DRV_VERSION		"0.1"
+
+#define PCI_DEVICE_ID_TOSHIBA_SCC_ATA		0x01b4
+
+/* offset of CTRL registers */
+#define SCC_CTL_PIOSHT		0x000
+#define SCC_CTL_PIOCT		0x004
+#define SCC_CTL_MDMACT		0x008
+#define SCC_CTL_MCRCST		0x00C
+#define SCC_CTL_SDMACT		0x010
+#define SCC_CTL_SCRCST		0x014
+#define SCC_CTL_UDENVT		0x018
+#define SCC_CTL_TDVHSEL		0x020
+#define SCC_CTL_MODEREG		0x024
+#define SCC_CTL_ECMODE		0xF00
+#define SCC_CTL_MAEA0		0xF50
+#define SCC_CTL_MAEC0		0xF54
+#define SCC_CTL_CCKCTRL		0xFF0
+
+/* offset of BMID registers */
+#define SCC_DMA_CMD		0x000
+#define SCC_DMA_STATUS		0x004
+#define SCC_DMA_TABLE_OFS	0x008
+#define SCC_DMA_INTMASK		0x010
+#define SCC_DMA_INTST		0x014
+#define SCC_DMA_PTERADD		0x018
+#define SCC_REG_CMD_ADDR	0x020
+#define SCC_REG_DATA		0x000
+#define SCC_REG_ERR		0x004
+#define SCC_REG_FEATURE		0x004
+#define SCC_REG_NSECT		0x008
+#define SCC_REG_LBAL		0x00C
+#define SCC_REG_LBAM		0x010
+#define SCC_REG_LBAH		0x014
+#define SCC_REG_DEVICE		0x018
+#define SCC_REG_STATUS		0x01C
+#define SCC_REG_CMD		0x01C
+#define SCC_REG_ALTSTATUS	0x020
+
+/* register value */
+#define TDVHSEL_MASTER		0x00000001
+#define TDVHSEL_SLAVE		0x00000004
+
+#define MODE_JCUSFEN		0x00000080
+
+#define ECMODE_VALUE		0x01
+
+#define CCKCTRL_ATARESET	0x00040000
+#define CCKCTRL_BUFCNT		0x00020000
+#define CCKCTRL_CRST		0x00010000
+#define CCKCTRL_OCLKEN		0x00000100
+#define CCKCTRL_ATACLKOEN	0x00000002
+#define CCKCTRL_LCLKEN		0x00000001
+
+#define QCHCD_IOS_SS		0x00000001
+
+#define QCHSD_STPDIAG		0x00020000
+
+#define INTMASK_MSK		0xD1000012
+#define INTSTS_SERROR		0x80000000
+#define INTSTS_PRERR		0x40000000
+#define INTSTS_RERR		0x10000000
+#define INTSTS_ICERR		0x01000000
+#define INTSTS_BMSINT		0x00000010
+#define INTSTS_BMHE		0x00000008
+#define INTSTS_IOIRQS		0x00000004
+#define INTSTS_INTRQ		0x00000002
+#define INTSTS_ACTEINT		0x00000001
+
+
+typedef struct scc_ports {
+	unsigned long ctl_base;
+	unsigned long dma_base;
+} scc_ports;
+
+/* PIO transfer mode table */
+/* JCHST */
+static const unsigned long JCHSTtbl[2][7] = {
+	{0x0E, 0x05, 0x02, 0x03, 0x02, 0x00, 0x00},	/* 100MHz */
+	{0x13, 0x07, 0x04, 0x04, 0x03, 0x00, 0x00}	/* 133MHz */
+};
+
+/* JCHHT */
+static const unsigned long JCHHTtbl[2][7] = {
+	{0x0E, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00},	/* 100MHz */
+	{0x13, 0x03, 0x03, 0x03, 0x03, 0x00, 0x00}	/* 133MHz */
+};
+
+/* JCHCT */
+static const unsigned long JCHCTtbl[2][7] = {
+	{0x1D, 0x1D, 0x1C, 0x0B, 0x06, 0x00, 0x00},	/* 100MHz */
+	{0x27, 0x26, 0x26, 0x0E, 0x09, 0x00, 0x00}	/* 133MHz */
+};
+
+/* DMA transfer mode  table */
+/* JCHDCTM/JCHDCTS */
+static const unsigned long JCHDCTxtbl[2][7] = {
+	{0x0A, 0x06, 0x04, 0x03, 0x01, 0x00, 0x00},	/* 100MHz */
+	{0x0E, 0x09, 0x06, 0x04, 0x02, 0x01, 0x00}	/* 133MHz */
+};
+
+/* JCSTWTM/JCSTWTS  */
+static const unsigned long JCSTWTxtbl[2][7] = {
+	{0x06, 0x04, 0x03, 0x02, 0x02, 0x02, 0x00},	/* 100MHz */
+	{0x09, 0x06, 0x04, 0x02, 0x02, 0x02, 0x02}	/* 133MHz */
+};
+
+/* JCTSS */
+static const unsigned long JCTSStbl[2][7] = {
+	{0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x00},	/* 100MHz */
+	{0x05, 0x05, 0x05, 0x05, 0x05, 0x05, 0x05}	/* 133MHz */
+};
+
+/* JCENVT */
+static const unsigned long JCENVTtbl[2][7] = {
+	{0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x00},	/* 100MHz */
+	{0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02}	/* 133MHz */
+};
+
+/* JCACTSELS/JCACTSELM */
+static const unsigned long JCACTSELtbl[2][7] = {
+	{0x00, 0x00, 0x00, 0x00, 0x01, 0x01, 0x00},	/* 100MHz */
+	{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01}	/* 133MHz */
+};
+
+static const struct pci_device_id scc_pci_tbl[] = {
+	{PCI_VENDOR_ID_TOSHIBA_2, PCI_DEVICE_ID_TOSHIBA_SCC_ATA,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0},
+	{ }	/* terminate list */
+};
+
+static u8 scc_inb (unsigned long port)
+{
+	return (u8) in_be32((void __iomem *)port);
+}
+
+static u16 scc_inw (unsigned long port)
+{
+	return (u16) in_be32((void __iomem *)port);
+}
+
+static void scc_insw (unsigned long port, void *addr, u32 count)
+{
+	u16 *buf16 = (u16 *) addr;
+	void __iomem *mmio = (void __iomem *) port;
+
+	while (count--)
+		*buf16++ = le16_to_cpu(in_be32(mmio));
+}
+
+static u32 scc_inl (unsigned long port)
+{
+	return (u32) in_be32((void __iomem *)port);
+}
+
+static void scc_outb (u8 val, unsigned long port)
+{
+	out_be32((void __iomem *)port, val);
+}
+
+static void scc_outw (u16 val, unsigned long port)
+{
+	out_be32((void __iomem *)port, val);
+}
+
+static void scc_outsw (unsigned long port, void *addr, u32 count)
+{
+	u16 *buf16 = (u16 *) addr;
+	void __iomem *mmio = (void __iomem *) port;
+
+	while (count--)
+		out_be32(mmio, cpu_to_le16(*buf16++));
+}
+
+static void scc_outl (u32 val, unsigned long port)
+{
+	out_be32((void __iomem *)port, val);
+}
+
+/**
+ *	scc_set_piomode - Initialize host controller PATA PIO timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: um
+ *
+ *	Set PIO mode for device.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void scc_set_piomode (struct ata_port *ap, struct ata_device *adev)
+{
+	unsigned int pio = adev->pio_mode - XFER_PIO_0;
+	struct scc_ports *ports = ap->host->private_data;
+	unsigned long cckctrl_port = ports->ctl_base + SCC_CTL_CCKCTRL;
+	unsigned long piosht_port = ports->ctl_base + SCC_CTL_PIOSHT;
+	unsigned long pioct_port = ports->ctl_base + SCC_CTL_PIOCT;
+	unsigned long reg;
+	int offset;
+
+	reg = ap->io_ops->INL(cckctrl_port);
+	if (reg & CCKCTRL_ATACLKOEN)
+		offset = 1;	/* 133MHz */
+	else
+		offset = 0;	/* 100MHz */
+
+	reg = JCHSTtbl[offset][pio] << 16 | JCHHTtbl[offset][pio];
+	ap->io_ops->OUTL(reg, piosht_port);
+	reg = JCHCTtbl[offset][pio];
+	ap->io_ops->OUTL(reg, pioct_port);
+}
+
+/**
+ *	scc_set_dmamode - Initialize host controller PATA DMA timings
+ *	@ap: Port whose timings we are configuring
+ *	@adev: um
+ *	@udma: udma mode, 0 - 6
+ *
+ *	Set UDMA mode for device.
+ *
+ *	LOCKING:
+ *	None (inherited from caller).
+ */
+
+static void scc_set_dmamode (struct ata_port *ap, struct ata_device *adev)
+{
+	unsigned int udma = adev->dma_mode;
+	unsigned int is_slave = (adev->devno != 0);
+	u8 speed = udma;
+	struct scc_ports *ports = ap->host->private_data;
+	unsigned long cckctrl_port = ports->ctl_base + SCC_CTL_CCKCTRL;
+	unsigned long mdmact_port = ports->ctl_base + SCC_CTL_MDMACT;
+	unsigned long mcrcst_port = ports->ctl_base + SCC_CTL_MCRCST;
+	unsigned long sdmact_port = ports->ctl_base + SCC_CTL_SDMACT;
+	unsigned long scrcst_port = ports->ctl_base + SCC_CTL_SCRCST;
+	unsigned long udenvt_port = ports->ctl_base + SCC_CTL_UDENVT;
+	unsigned long tdvhsel_port = ports->ctl_base + SCC_CTL_TDVHSEL;
+	int offset, idx;
+
+	if (ap->io_ops->INL(cckctrl_port) & CCKCTRL_ATACLKOEN) 
+		offset = 1;	/* 133MHz */
+	else
+		offset = 0;	/* 100MHz */
+
+	if (speed >= XFER_UDMA_0)
+		idx = speed - XFER_UDMA_0;
+	else
+		return;
+
+	if (is_slave) {
+		ap->io_ops->OUTL(JCHDCTxtbl[offset][idx], sdmact_port);
+		ap->io_ops->OUTL(JCSTWTxtbl[offset][idx], scrcst_port);
+		ap->io_ops->OUTL((ap->io_ops->INL(tdvhsel_port) & ~TDVHSEL_SLAVE) | (JCACTSELtbl[offset][idx] << 2), tdvhsel_port);
+	} else {
+		ap->io_ops->OUTL(JCHDCTxtbl[offset][idx], mdmact_port);
+		ap->io_ops->OUTL(JCSTWTxtbl[offset][idx], mcrcst_port);
+		ap->io_ops->OUTL((ap->io_ops->INL(tdvhsel_port) & ~TDVHSEL_MASTER) | JCACTSELtbl[offset][idx], tdvhsel_port);
+	}
+	ap->io_ops->OUTL(JCTSStbl[offset][idx] << 16 | JCENVTtbl[offset][idx], udenvt_port);
+}
+
+/**
+ *	scc_bmdma_setup - Set up PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	Note: Original code is ata_bmdma_setup_pio().
+ */
+
+static void scc_bmdma_setup (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	unsigned int rw = (qc->tf.flags & ATA_TFLAG_WRITE);
+	u8 dmactl;
+
+	/* load PRD table addr. */
+	if (qc->ap->flags & ATA_FLAG_MMIO)
+		mb();	/* make sure PRD table writes are visible to controller */
+	ap->io_ops->OUTL(ap->prd_dma, ap->ioaddr.bmdma_addr + SCC_DMA_TABLE_OFS);
+
+	/* specify data direction, triple-check start bit is clear */
+	dmactl = ap->io_ops->INB(ap->ioaddr.bmdma_addr + SCC_DMA_CMD);
+	dmactl &= ~(ATA_DMA_WR | ATA_DMA_START);
+	if (!rw)
+		dmactl |= ATA_DMA_WR;
+	ap->io_ops->OUTB(dmactl, ap->ioaddr.bmdma_addr + SCC_DMA_CMD);
+
+	/* issue r/w command */
+	ap->ops->exec_command(ap, &qc->tf);
+}
+
+/**
+ *	scc_bmdma_start - Start a PCI IDE BMDMA transaction
+ *	@qc: Info associated with this ATA transaction.
+ *
+ *	Note: Original code is ata_bmdma_start_pio().
+ */
+
+static void scc_bmdma_start (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	u8 dmactl;
+
+	/* start host DMA transaction */
+	dmactl = ap->io_ops->INB(ap->ioaddr.bmdma_addr + SCC_DMA_CMD);
+	ap->io_ops->OUTB(dmactl | ATA_DMA_START, ap->ioaddr.bmdma_addr + SCC_DMA_CMD);
+}
+
+/**
+ *	scc_bmdma_stop - Stop PCI IDE BMDMA transfer
+ *	@qc: Command we are ending DMA for
+ *
+ *	Note: Original code is ata_bmdma_stop().
+ */
+
+static void scc_bmdma_stop (struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct scc_ports *ports = ap->host->private_data;
+	u32 reg;
+
+	while (1) {
+		reg = ap->io_ops->INL(ports->dma_base + SCC_DMA_INTST);
+
+		if (reg & INTSTS_SERROR) {
+			printk(KERN_WARNING "%s: SERROR\n", DRV_NAME);
+			ap->io_ops->OUTL(INTSTS_SERROR|INTSTS_BMSINT,
+					 ports->dma_base + SCC_DMA_INTST);
+			ap->io_ops->OUTL(ap->io_ops->INL(ports->dma_base + SCC_DMA_CMD) & ~ATA_DMA_START, 
+					 ports->dma_base + SCC_DMA_CMD);
+			continue;
+		}
+
+		if (reg & INTSTS_PRERR) {
+			u32 maea0, maec0;
+
+			maea0 = ap->io_ops->INL(ports->ctl_base + SCC_CTL_MAEA0);
+			maec0 = ap->io_ops->INL(ports->ctl_base + SCC_CTL_MAEC0);
+
+			printk(KERN_WARNING "%s: PRERR [addr:%x cmd:%x]\n", DRV_NAME, maea0, maec0);
+			ap->io_ops->OUTL(INTSTS_PRERR|INTSTS_BMSINT,
+					 ports->dma_base + SCC_DMA_INTST);
+			ap->io_ops->OUTL(ap->io_ops->INL(ports->dma_base + SCC_DMA_CMD) & ~ATA_DMA_START,
+					 ports->dma_base + SCC_DMA_CMD);
+			continue;
+		}
+
+		if (reg & INTSTS_RERR) {
+			printk(KERN_WARNING "%s: Response Error\n", DRV_NAME);
+			ap->io_ops->OUTL(INTSTS_RERR|INTSTS_BMSINT,
+					 ports->dma_base + SCC_DMA_INTST);
+			ap->io_ops->OUTL(ap->io_ops->INL(ports->dma_base + SCC_DMA_CMD) & ~ATA_DMA_START,
+					 ports->dma_base + SCC_DMA_CMD);
+			continue;
+		}
+
+		if (reg & INTSTS_ICERR) {
+			ap->io_ops->OUTL(ap->io_ops->INL(ports->dma_base + SCC_DMA_CMD) & ~ATA_DMA_START,
+					 ports->dma_base + SCC_DMA_CMD);
+			printk(KERN_WARNING "%s: Illegal Configuration\n", DRV_NAME);
+			ap->io_ops->OUTL(INTSTS_ICERR|INTSTS_BMSINT,
+					 ports->dma_base + SCC_DMA_INTST);
+			continue;
+		}
+
+		if (reg & INTSTS_BMSINT) {
+			unsigned int classes;
+			printk(KERN_WARNING "%s: Internal Bus Error\n", DRV_NAME);
+			ap->io_ops->OUTL(INTSTS_BMSINT,
+					 ports->dma_base + SCC_DMA_INTST);
+			/* TBD: SW reset */
+			ata_std_softreset(ap, &classes);
+			continue;
+		}
+
+		if (reg & INTSTS_BMHE) {
+			ap->io_ops->OUTL(INTSTS_BMHE,
+					 ports->dma_base + SCC_DMA_INTST);
+			continue;
+		}
+
+		if (reg & INTSTS_ACTEINT) {
+			ap->io_ops->OUTL(INTSTS_ACTEINT,
+					 ports->dma_base + SCC_DMA_INTST);
+			continue;
+		}
+
+		if (reg & INTSTS_IOIRQS) {
+			ap->io_ops->OUTL(INTSTS_IOIRQS,
+					 ports->dma_base + SCC_DMA_INTST);
+			continue;
+		}
+		break;
+	}
+
+	/* clear start/stop bit */
+	ap->io_ops->OUTB(ap->io_ops->INB(ports->dma_base + SCC_DMA_CMD) & ~ATA_DMA_START,
+			 ports->dma_base + SCC_DMA_CMD);
+
+	/* one-PIO-cycle guaranteed wait, per spec, for HDMA1:0 transition */
+	ata_altstatus(ap);	/* dummy read */
+}
+
+/**
+ *	scc_bmdma_status - Read PCI IDE BMDMA status
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Note: Original code is ata_bmdma_status().
+ */
+
+static u8 scc_bmdma_status (struct ata_port *ap)
+{
+	u8 host_stat;
+	host_stat = ap->io_ops->INB(ap->ioaddr.bmdma_addr + SCC_DMA_STATUS);
+	return host_stat;
+}
+
+/**
+ *	scc_data_xfer - Transfer data by MMIO
+ *	@adev: device for this I/O
+ *	@buf: data buffer
+ *	@buflen: buffer length
+ *	@write_data: read/write
+ *
+ *	Note: Original code is ata_mmio_data_xfer().
+ */
+
+static void scc_data_xfer (struct ata_device *adev, unsigned char *buf,
+			   unsigned int buflen, int write_data)
+{
+	struct ata_port *ap = adev->ap;
+	unsigned int words = buflen >> 1;
+
+	/* Transfer multiple of 2 bytes */
+	if (write_data)
+		ap->io_ops->OUTSW(ap->ioaddr.data_addr, buf, words);
+	else
+		ap->io_ops->INSW(ap->ioaddr.data_addr, buf, words);
+	
+	/* Transfer trailing 1 byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		u16 align_buf[1] = { 0 };
+		unsigned char *trailing_buf = buf + buflen - 1;
+
+		if (write_data) {
+			memcpy(align_buf, trailing_buf, 1);
+			ap->io_ops->OUTW(cpu_to_le16(align_buf[0]), ap->ioaddr.data_addr);
+		} else {
+			align_buf[0] = le16_to_cpu(ap->io_ops->INW(ap->ioaddr.data_addr));
+			memcpy(trailing_buf, align_buf, 1);
+		}
+	}
+}
+
+/**
+ *	scc_irq_ack - Acknowledge a device interrupt.
+ *	@ap: Port on which interrupts are enabled.
+ *
+ *	Note: Original code is ata_irq_ack().
+ */
+
+static inline u8 scc_irq_ack (struct ata_port *ap, unsigned int chk_drq)
+{
+	unsigned int bits = chk_drq ? ATA_BUSY | ATA_DRQ : ATA_BUSY;
+	u8 host_stat, post_stat, status;
+
+	status = ata_busy_wait(ap, bits, 1000);
+	if (status & bits)
+		if (ata_msg_err(ap))
+			printk(KERN_ERR "abnormal status 0x%X\n", status);
+
+	/* get controller status; clear intr, err bits */
+	host_stat = ap->io_ops->INB(ap->ioaddr.bmdma_addr + SCC_DMA_STATUS);
+	ap->io_ops->OUTB(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
+			 ap->ioaddr.bmdma_addr + SCC_DMA_STATUS);
+
+	post_stat = ap->io_ops->INB(ap->ioaddr.bmdma_addr + SCC_DMA_STATUS);
+
+	if (ata_msg_intr(ap))
+		printk(KERN_INFO "%s: irq ack: host_stat 0x%X, new host_stat 0x%X, drv_stat 0x%X\n",
+		       __FUNCTION__,
+		       host_stat, post_stat, status);
+
+	return status;
+}
+
+/**
+ *	scc_pata_prereset - prepare for reset
+ *	@ap: ATA port to be reset
+ *
+ */
+static int scc_pata_prereset (struct ata_port *ap)
+{
+	ap->cbl = ATA_CBL_PATA80;
+	return ata_std_prereset(ap);
+}
+
+/**
+ *	scc_error_handler - Stock error handler for BMDMA controller
+ *	@ap: port to handle error for
+ *
+ */
+
+static void scc_error_handler (struct ata_port *ap)
+{
+	ata_bmdma_drive_eh(ap, scc_pata_prereset, ata_std_softreset, NULL,
+			   ata_std_postreset);
+}
+
+/**
+ *	scc_host_intr - Handle host interrupt for given (port, task)
+ *	@ap: Port on which interrupt arrived (possibly...)
+ *	@qc: Taskfile currently active in engine
+ *
+ *	Note: Original code is ata_host_intr().
+ */
+
+static inline unsigned int scc_host_intr (struct ata_port *ap,
+					  struct ata_queued_cmd *qc)
+{
+	struct ata_eh_info *ehi = &ap->eh_info;
+	u8 status, host_stat = 0;
+
+	VPRINTK("ata%u: protocol %d task_state %d\n",
+		ap->id, qc->tf.protocol, ap->hsm_task_state);
+
+	/* Check whether we are expecting interrupt in this state */
+	switch (ap->hsm_task_state) {
+	case HSM_ST_FIRST:
+		/* Some pre-ATAPI-4 devices assert INTRQ
+		 * at this state when ready to receive CDB.
+		 */
+
+		/* Check the ATA_DFLAG_CDB_INTR flag is enough here.
+		 * The flag was turned on only for atapi devices.
+		 * No need to check is_atapi_taskfile(&qc->tf) again.
+		 */
+		if (!(qc->dev->flags & ATA_DFLAG_CDB_INTR))
+			goto idle_irq;
+		break;
+	case HSM_ST_LAST:
+		if (qc->tf.protocol == ATA_PROT_DMA ||
+		    qc->tf.protocol == ATA_PROT_ATAPI_DMA) {
+			/* check status of DMA engine */
+			host_stat = ap->ops->bmdma_status(ap);
+			VPRINTK("ata%u: host_stat 0x%X\n", ap->id, host_stat);
+
+			/* before we do anything else, clear DMA-Start bit */
+			ap->ops->bmdma_stop(qc);
+
+			if (unlikely(host_stat & ATA_DMA_ERR)) {
+				/* error when transfering data to/from memory */
+				qc->err_mask |= AC_ERR_HOST_BUS;
+				ap->hsm_task_state = HSM_ST_ERR;
+			}
+		}
+		break;
+	case HSM_ST:
+		break;
+	default:
+		goto idle_irq;
+	}
+
+	/* check altstatus */
+	status = ata_altstatus(ap);
+	if (status & ATA_BUSY)
+		goto idle_irq;
+
+	/* check main status, clearing INTRQ */
+	status = ata_chk_status(ap);
+	if (unlikely(status & ATA_BUSY))
+		goto idle_irq;
+
+	/* ack bmdma irq events */
+	ap->ops->irq_clear(ap);
+
+	ata_hsm_move(ap, qc, status, 0);
+
+	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA ||
+				       qc->tf.protocol == ATA_PROT_ATAPI_DMA))
+		ata_ehi_push_desc(ehi, "BMDMA stat 0x%x", host_stat);
+
+	return 1;	/* irq handled */
+
+idle_irq:
+	ap->stats.idle_irq++;
+
+#ifdef ATA_IRQ_TRAP
+	if ((ap->stats.idle_irq % 1000) == 0) {
+		scc_irq_ack(ap, 0); /* debug trap */
+		ata_port_printk(ap, KERN_WARNING, "irq trap\n");
+		return 1;
+	}
+#endif
+
+	return 0;	/* irq not handled */
+}
+
+/**
+ *	scc_interrupt - ATA host interrupt handler
+ *	@irq: irq line (unused)
+ *	@dev_instance: pointer to our ata_host_set information structure
+ *
+ *	Note: Original code is ata_interrupt().
+ */
+
+static irqreturn_t scc_interrupt (int irq, void *dev_instance)
+{
+	struct ata_host *host = dev_instance;
+	unsigned int i;
+	unsigned int handled = 0;
+	unsigned long flags;
+
+	/* TODO: make _irqsave conditional on x86 PCI IDE legacy mode */
+	spin_lock_irqsave(&host->lock, flags);
+
+	for (i = 0; i < host->n_ports; i++) {
+		struct ata_port *ap;
+
+		ap = host->ports[i];
+		if (ap &&
+		    !(ap->flags & ATA_FLAG_DISABLED)) {
+			struct ata_queued_cmd *qc;
+
+			qc = ata_qc_from_tag(ap, ap->active_tag);
+			if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
+			    (qc->flags & ATA_QCFLAG_ACTIVE))
+				handled |= scc_host_intr(ap, qc);
+		}
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return IRQ_RETVAL(handled);
+}
+
+/**
+ *	scc_bmdma_irq_clear - Clear PCI IDE BMDMA interrupt.
+ *	@ap: Port associated with this ATA transaction.
+ *
+ *	Note: Original code is ata_bmdma_irq_clear().
+ */
+
+static void scc_bmdma_irq_clear (struct ata_port *ap)
+{
+	unsigned long addr = ap->ioaddr.bmdma_addr + SCC_DMA_STATUS;
+
+	if (!ap->ioaddr.bmdma_addr)
+		return;
+
+	ap->io_ops->OUTB(ap->io_ops->INB(addr), addr);
+}
+
+/**
+ *	scc_port_start - Set port up for dma.
+ *	@ap: Port to initialize
+ *
+ *	Allocate space for PRD table using ata_port_start().
+ *	Set PRD table address for PTERADD. (PRD Transfer End Read)
+ */
+
+static int scc_port_start (struct ata_port *ap)
+{
+	struct scc_ports *ports = ap->host->private_data;
+	int rc;
+
+	rc = ata_port_start(ap);
+	if (rc)
+		return rc;
+
+	ap->io_ops->OUTB(ap->prd_dma, ports->dma_base + SCC_DMA_PTERADD);
+	return 0;
+}
+
+/**
+ *	scc_port_stop - Undo scc_port_start()
+ *	@ap: Port to shut down
+ *
+ *	Reset PTERADD and Free the PRD table.
+ */
+
+static void scc_port_stop (struct ata_port *ap)
+{
+	struct scc_ports *ports = ap->host->private_data;
+
+	ap->io_ops->OUTB(0, ports->dma_base + SCC_DMA_PTERADD);
+	ata_port_stop(ap);
+}
+
+/**
+ *	remove_mmio_scc - Free the private data
+ *	@pdev: pci_dev to shut down
+ */
+
+static void remove_mmio_scc (struct pci_dev *pdev)
+{
+	struct scc_ports *ports = pci_get_drvdata(pdev);
+	unsigned long ctl_addr = pci_resource_start(pdev, 0);
+	unsigned long dma_addr = pci_resource_start(pdev, 1);
+	unsigned long ctl_size = pci_resource_len(pdev, 0);
+	unsigned long dma_size = pci_resource_len(pdev, 1);
+
+	pci_set_drvdata(pdev, NULL);
+	iounmap((void __iomem *)ports->dma_base);
+	iounmap((void __iomem *)ports->ctl_base);
+	release_mem_region(dma_addr, dma_size);
+	release_mem_region(ctl_addr, ctl_size);
+}
+
+static void scc_host_stop (struct ata_host *host)
+{
+	struct scc_ports *ports = host->private_data;
+
+	ata_host_stop(host);
+	remove_mmio_scc(to_pci_dev(host->dev));
+	kfree(ports);
+}
+
+/**
+ *	scc_std_ports - initialize ioaddr with SCC PATA port offsets.
+ *	@ioaddr: IO address structure to be initialized
+ *
+ *	Note: Original code is ata_std_ports().
+ */
+
+static void scc_std_ports (struct ata_ioports *ioaddr)
+{
+	ioaddr->data_addr = ioaddr->cmd_addr + SCC_REG_DATA;
+	ioaddr->error_addr = ioaddr->cmd_addr + SCC_REG_ERR;
+	ioaddr->feature_addr = ioaddr->cmd_addr + SCC_REG_FEATURE;
+	ioaddr->nsect_addr = ioaddr->cmd_addr + SCC_REG_NSECT;
+	ioaddr->lbal_addr = ioaddr->cmd_addr + SCC_REG_LBAL;
+	ioaddr->lbam_addr = ioaddr->cmd_addr + SCC_REG_LBAM;
+	ioaddr->lbah_addr = ioaddr->cmd_addr + SCC_REG_LBAH;
+	ioaddr->device_addr = ioaddr->cmd_addr + SCC_REG_DEVICE;
+	ioaddr->status_addr = ioaddr->cmd_addr + SCC_REG_STATUS;
+	ioaddr->command_addr = ioaddr->cmd_addr + SCC_REG_CMD;
+}
+
+/**
+ *	scc_pci_init_native_mode - Initialize native-mode driver
+ *	@pdev:  pci device to be initialized
+ *	@port:  array[2] of pointers to port info structures.
+ *	@ports: bitmap of ports present
+ *
+ *	Note: Original code is ata_pci_init_native_mode().
+ */
+
+static struct ata_probe_ent *
+scc_pci_init_native_mode (struct pci_dev *pdev, struct ata_port_info **port,
+			  int ports)
+{
+	struct ata_probe_ent *probe_ent =
+		ata_probe_ent_alloc(pci_dev_to_dev(pdev), port[0]);
+	int p = 0;
+	unsigned long bmdma;
+	struct scc_ports *scc_port = pci_get_drvdata(pdev);
+
+	if (!probe_ent)
+		return NULL;
+
+	probe_ent->irq = pdev->irq;
+	probe_ent->irq_flags = IRQF_SHARED;
+
+	if (ports & ATA_PORT_PRIMARY) {
+		probe_ent->port[p].cmd_addr = scc_port->dma_base + SCC_REG_CMD_ADDR;
+		probe_ent->port[p].altstatus_addr =
+			probe_ent->port[p].ctl_addr =
+			probe_ent->port[p].cmd_addr + SCC_REG_ALTSTATUS;
+		bmdma = scc_port->dma_base;
+		if (bmdma)
+			probe_ent->port[p].bmdma_addr = bmdma;
+		scc_std_ports(&probe_ent->port[p]);
+		p++;
+	}
+
+	probe_ent->n_ports = p;
+	return probe_ent;
+}
+
+/**
+ *	scc_pci_init_one - Initialize/register PCI IDE host controller
+ *	@pdev: Controller to be initialized
+ *	@port_info: Information from low-level host driver
+ *	@n_ports: Number of ports attached to host controller
+ *
+ *	Note: Original code is ata_pci_init_one().
+ */
+
+static int scc_pci_init_one (struct pci_dev *pdev,
+			     struct ata_port_info **port_info,
+			     unsigned int n_ports)
+{
+	struct ata_probe_ent *probe_ent = NULL;
+	struct ata_port_info *port[2];
+	int rc;
+
+	DPRINTK("ENTER\n");
+
+	BUG_ON(n_ports < 1 || n_ports > 2);
+
+	port[0] = port_info[0];
+	if (n_ports > 1)
+		port[1] = port_info[1];
+	else
+		port[1] = port[0];
+
+	/* FIXME: Really for ATA it isn't safe because the device may be
+	   multi-purpose and we want to leave it alone if it was already
+	   enabled. Secondly for shared use as Arjan says we want refcounting
+
+	   Checking dev->is_enabled is insufficient as this is not set at
+	   boot for the primary video which is BIOS enabled
+	*/
+
+	rc = pci_enable_device(pdev);
+	if (rc)
+		return rc;
+
+	/* TODO: If we get no DMA mask we should fall back to PIO */
+	rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		goto err_out;
+	rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+	if (rc)
+		goto err_out;
+
+	if (n_ports == 2)
+		probe_ent = scc_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY | ATA_PORT_SECONDARY);
+	else
+		probe_ent = scc_pci_init_native_mode(pdev, port, ATA_PORT_PRIMARY);
+
+	if (!probe_ent) {
+		rc = -ENOMEM;
+		goto err_out;
+	}
+
+	pci_set_master(pdev);
+
+	if (!ata_device_add(probe_ent)) {
+		rc = -ENODEV;
+		goto err_out_ent;
+	}
+
+	kfree(probe_ent);
+
+	return 0;
+
+err_out_ent:
+	kfree(probe_ent);
+err_out:
+	pci_disable_device(pdev);
+	return rc;
+}
+
+/**
+ *	setup_mmio_scc	-	map CTRL/BMID region
+ *	@pdev: PCI device we are configuring
+ *	@name: device name
+ */
+
+static int setup_mmio_scc (struct pci_dev *pdev, const char *name)
+{
+	unsigned long ctl_addr = pci_resource_start(pdev, 0);
+	unsigned long dma_addr = pci_resource_start(pdev, 1);
+	unsigned long ctl_size = pci_resource_len(pdev, 0);
+	unsigned long dma_size = pci_resource_len(pdev, 1);
+	struct scc_ports *scc_port;
+	void __iomem *ctl_base, *dma_base;
+
+	scc_port = (struct scc_ports*)kzalloc(sizeof(struct scc_ports), GFP_KERNEL);
+	if (!scc_port)
+		return -ENOMEM;
+
+	if (!request_mem_region(ctl_addr, ctl_size, name)) {
+		printk(KERN_WARNING "%s: IDE controller MMIO ports not available.\n", DRV_NAME);
+		goto fail_0;
+	}
+
+	if (!request_mem_region(dma_addr, dma_size, name)) {
+		printk(KERN_WARNING "%s: IDE controller MMIO ports not available.\n", DRV_NAME);
+		goto fail_1;
+	}
+
+	if ((ctl_base = ioremap(ctl_addr, ctl_size)) == NULL)
+		goto fail_2;
+
+	if ((dma_base = ioremap(dma_addr, dma_size)) == NULL)
+		goto fail_3;
+	pci_set_master(pdev);
+	scc_port->ctl_base = (unsigned long)ctl_base;
+	scc_port->dma_base = (unsigned long)dma_base;
+	pci_set_drvdata(pdev, (void *)scc_port);
+
+	return 0;
+
+fail_3:
+	iounmap(ctl_base);
+fail_2:
+	release_mem_region(dma_addr, dma_size);
+fail_1:
+	release_mem_region(ctl_addr, ctl_size);
+fail_0:
+	kfree(scc_port);
+	return -ENOMEM;
+}
+
+static struct scsi_host_template scc_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.emulated		= ATA_SHT_EMULATED,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.proc_name		= DRV_NAME,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
+	.bios_param		= ata_std_bios_param,
+	.resume			= ata_scsi_device_resume,
+	.suspend		= ata_scsi_device_suspend,
+};
+
+static const struct ata_port_operations scc_port_ops = {
+	.port_disable		= ata_port_disable,
+	.set_piomode		= scc_set_piomode,
+	.set_dmamode		= scc_set_dmamode,
+	.mode_filter		= ata_pci_default_filter,
+
+	.tf_load		= ata_tf_load,
+	.tf_read		= ata_tf_read,
+	.exec_command		= ata_exec_command,
+	.check_status		= ata_check_status,
+	.dev_select		= ata_std_dev_select,
+
+	.bmdma_setup		= scc_bmdma_setup,
+	.bmdma_start		= scc_bmdma_start,
+	.bmdma_stop		= scc_bmdma_stop,
+	.bmdma_status		= scc_bmdma_status,
+	.data_xfer		= scc_data_xfer,
+
+	.qc_prep		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
+	.freeze			= ata_bmdma_freeze,
+	.thaw			= ata_bmdma_thaw,
+	.error_handler		= scc_error_handler,
+	.post_internal_cmd	= scc_bmdma_stop,
+
+	.irq_handler		= scc_interrupt,
+	.irq_clear		= scc_bmdma_irq_clear,
+
+	.port_start		= scc_port_start,
+	.port_stop		= scc_port_stop,
+	.host_stop		= scc_host_stop,
+};
+
+static struct ata_io_operations scc_io_ops = {
+	.OUTB			= scc_outb,
+	.OUTW			= scc_outw,
+	.OUTL			= scc_outl,
+	.OUTSW			= scc_outsw,
+	.INB			= scc_inb,
+	.INW			= scc_inw,
+	.INL			= scc_inl,
+	.INSW			= scc_insw,
+};
+
+static struct ata_port_info scc_port_info[] = {
+	{
+		.sht		= &scc_sht,
+		.flags		= ATA_FLAG_SLAVE_POSS | ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY,
+		.pio_mask	= 0x1f,	/* pio0-4 */
+		.mwdma_mask	= 0x00,
+		.udma_mask	= ATA_UDMA6,
+		.port_ops	= &scc_port_ops,
+		.io_ops		= &scc_io_ops,
+	},
+};
+
+/**
+ *	scc_init_one - Register SCC PATA device with kernel services
+ *	@pdev: PCI device to register
+ *	@ent: Entry in scc_pci_tbl matching with @pdev
+ *
+ *	LOCKING:
+ *	Inherited from PCI layer (may sleep).
+ *
+ *	RETURNS:
+ *	Zero on success, or -ERRNO value.
+ */
+
+static int scc_init_one (struct pci_dev *pdev, const struct pci_device_id *ent)
+{
+	static int printed_version;
+	struct ata_port_info port_info[2];
+	struct ata_port_info *ppinfo[2] = { &port_info[0], &port_info[1] };
+	struct scc_ports *ports;
+	unsigned long port_flags;
+	int rc;
+	void __iomem *cckctrl_port, *intmask_port, *mode_port, *ecmode_port;
+	u32 reg = 0;
+
+	if (!printed_version++)
+		dev_printk(KERN_DEBUG, &pdev->dev,
+			   "version " DRV_VERSION "\n");
+
+	rc = setup_mmio_scc(pdev, DRV_NAME);
+	if (rc < 0)
+		return rc;
+
+	ports = pci_get_drvdata(pdev);
+	cckctrl_port = (void __iomem *)ports->ctl_base + SCC_CTL_CCKCTRL;
+	mode_port = (void __iomem *)ports->ctl_base + SCC_CTL_MODEREG;
+	ecmode_port = (void __iomem *)ports->ctl_base + SCC_CTL_ECMODE;
+	intmask_port = (void __iomem *)ports->dma_base + SCC_DMA_INTMASK;
+
+	/* controller initialization */
+	reg = 0;
+	out_be32(cckctrl_port, reg);
+	reg |= CCKCTRL_ATACLKOEN;
+	out_be32(cckctrl_port, reg);
+	reg |= CCKCTRL_LCLKEN | CCKCTRL_OCLKEN;
+	out_be32(cckctrl_port, reg);
+	reg |= CCKCTRL_CRST;
+	out_be32(cckctrl_port, reg);
+
+	for (;;) {
+		reg = in_be32(cckctrl_port);
+		if (reg & CCKCTRL_CRST)
+			break;
+		udelay(5000);
+	}
+
+	reg |= CCKCTRL_ATARESET;
+	out_be32(cckctrl_port, reg);
+
+	out_be32(ecmode_port, ECMODE_VALUE);
+	out_be32(mode_port, MODE_JCUSFEN);
+	out_be32(intmask_port, INTMASK_MSK);
+
+	if (in_be32((void __iomem *)ports->dma_base + SCC_DMA_STATUS) & QCHSD_STPDIAG) {
+		printk(KERN_WARNING "%s: failed to detect 80c cable. (PDIAG# is high)\n", DRV_NAME);
+		remove_mmio_scc(pdev);
+		kfree(ports);
+		return -EIO;
+	}
+
+	port_info[0] = scc_port_info[ent->driver_data];
+	port_info[1] = scc_port_info[ent->driver_data];
+	port_info[0].private_data = ports;
+	port_info[1].private_data = ports;
+
+	port_flags = port_info[0].flags;
+
+	return scc_pci_init_one(pdev, ppinfo, 1);	/* n_ports must be 1 */
+}
+
+static struct pci_driver scc_pci_driver = {
+	.name			= DRV_NAME,
+	.id_table		= scc_pci_tbl,
+	.probe			= scc_init_one,
+	.remove			= ata_pci_remove_one,
+#ifdef CONFIG_PM
+	.suspend		= ata_pci_device_suspend,
+	.resume			= ata_pci_device_resume,
+#endif
+};
+
+static int __init scc_init (void)
+{
+	int rc;
+
+	DPRINTK("pci_register_driver\n");
+	rc = pci_register_driver(&scc_pci_driver);
+	if (rc)
+		return rc;
+
+	DPRINTK("done\n");
+	return 0;
+}
+
+static void __exit scc_exit (void)
+{
+	pci_unregister_driver(&scc_pci_driver);
+}
+
+module_init(scc_init);
+module_exit(scc_exit);
+
+MODULE_AUTHOR("Toshiba corp");
+MODULE_DESCRIPTION("SCSI low-level driver for Toshiba SCC PATA controller");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, scc_pci_tbl);
+MODULE_VERSION(DRV_VERSION);
+
