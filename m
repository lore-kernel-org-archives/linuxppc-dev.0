Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 95655DDE05
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 10:52:56 +1100 (EST)
Received: from pd2mr6so.prod.shaw.ca (pd2mr6so-qfe3.prod.shaw.ca [10.0.141.9])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JTS00CEOAC6ZW40@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Dec 2007 16:52:54 -0700 (MST)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd2mr6so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JTS00DJ1AC00H50@pd2mr6so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 28 Dec 2007 16:52:54 -0700 (MST)
Received: from trillian.cg.shawcable.net ([70.72.177.167])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JTS00KAHABOK440@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 28 Dec 2007 16:52:47 -0700 (MST)
Date: Fri, 28 Dec 2007 16:52:31 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 1/4] USB: add Cypress c67x00 low level interface code
In-reply-to: <20071228234537.16003.56035.stgit@trillian.secretlab.ca>
To: linux-usb-devel@lists.sourceforge.net, akpm@osdl.org,
	dbrownell@users.sourceforge.net, gregkh@suse.de, linuxppc-dev@ozlabs.org,
	jacmet@sunsite.dk, stern@rowland.harvard.edu
Message-id: <20071228235231.16003.48711.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20071228234537.16003.56035.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

This patch adds the low level support code for the Cypress c67x00 family of
OTG controllers.  The low level code is responsible for register access and
implements the software protocol for communicating with the c67x00 device.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/usb/c67x00/c67x00-ll-hpi.c |  516 ++++++++++++++++++++++++++++++++++++
 drivers/usb/c67x00/c67x00.h        |  242 +++++++++++++++++
 2 files changed, 758 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/c67x00/c67x00-ll-hpi.c b/drivers/usb/c67x00/c67x00-ll-hpi.c
new file mode 100644
index 0000000..d6a95d6
--- /dev/null
+++ b/drivers/usb/c67x00/c67x00-ll-hpi.c
@@ -0,0 +1,516 @@
+/*
+ * c67x00-ll-hpi.c: Cypress C67X00 USB Low level interface using HPI
+ *
+ * Copyright (C) 2006-2007 Barco N.V.
+ *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
+ *    based on multiple host controller drivers inside the linux kernel.
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301  USA.
+ */
+
+#include <asm/io.h>
+#include <asm/byteorder.h>
+#include "c67x00.h"
+
+/* -------------------------------------------------------------------------- */
+/* Interface definitions */
+
+#define COMM_ACK			0x0FED
+#define COMM_NAK			0xDEAD
+
+#define COMM_CTRL_REG_ADDR		0x01BC
+#define COMM_CTRL_REG_DATA		0x01BE
+#define COMM_CTRL_REG_LOGIC		0x01C0
+#define COMM_WRITE_CTRL_REG		0xCE03
+#define COMM_READ_CTRL_REG		0xCE02
+
+#define COMM_RESET			0xFA50
+#define COMM_EXEC_INT			0xCE01
+#define COMM_INT_NUM			0x01C2
+/* Registers 0 to COMM_REGS-1 */
+#define COMM_R(x)			(0x01C4 + 2 * (x))
+
+#define HUSB_SIE_pCurrentTDPtr(x)	( (x) ? 0x01B2 : 0x01B0 )
+#define HUSB_SIE_pTDListDone_Sem(x)	( (x) ? 0x01B8 : 0x01B6 )
+#define HUSB_pEOT			0x01B4
+
+/* Software interrupts */
+/* 114, 115: */
+#define HUSB_SIE_INIT_INT(x)		( (x) ? 0x0073 : 0x0072 )
+#define HUSB_RESET_INT			0x0074	/* 116 */
+
+#define SUSB_INIT_INT			0x0071
+/* ---------------------------------------------------------------------
+ * HPI implementation
+ *
+ * The c67x00 chip also support control via SPI or HSS serial
+ * interfaces.  However, this driver assumes that register access can
+ * be performed from IRQ context.  While this is a safe assuption with
+ * the HPI interface, it is not true for the serial interfaces.
+ */
+
+/* HPI registers */
+#define HPI_DATA	0
+#define HPI_MAILBOX	1
+#define HPI_ADDR	2
+#define HPI_STATUS	3
+
+static inline u16 hpi_read_reg(struct c67x00_device *dev, int reg)
+{
+	return __raw_readw(dev->hpi.base + reg * dev->hpi.regstep);
+}
+
+static inline void hpi_write_reg(struct c67x00_device *dev, int reg, u16 value)
+{
+	__raw_writew(value, dev->hpi.base + reg * dev->hpi.regstep);
+}
+
+static inline u16 hpi_read_word_nolock(struct c67x00_device *dev, u16 reg)
+{
+	hpi_write_reg(dev, HPI_ADDR, reg);
+	return hpi_read_reg(dev, HPI_DATA);
+}
+
+static inline u16 hpi_read_word(struct c67x00_device *dev, u16 reg)
+{
+	u16 value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	value = hpi_read_word_nolock(dev, reg);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
+
+	return value;
+}
+
+static inline void hpi_write_word_nolock(struct c67x00_device *dev, u16 reg,
+					 u16 value)
+{
+	hpi_write_reg(dev, HPI_ADDR, reg);
+	hpi_write_reg(dev, HPI_DATA, value);
+}
+
+static inline void hpi_write_word(struct c67x00_device *dev, u16 reg, u16 value)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	hpi_write_word_nolock(dev, reg, value);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
+}
+
+/*
+ * Only data is little endian, addr has cpu endianess
+ */
+static inline void hpi_write_words_le16(struct c67x00_device *dev, u16 addr,
+					u16 * data, u16 count)
+{
+	unsigned long flags;
+	int i;
+
+	spin_lock_irqsave(&dev->hw_lock, flags);
+
+	hpi_write_reg(dev, HPI_ADDR, addr);
+	for (i = 0; i < count; i++)
+		hpi_write_reg(dev, HPI_DATA, cpu_to_le16(*data++));
+
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
+}
+
+/*
+ * Only data is little endian, addr has cpu endianess
+ */
+static inline void hpi_read_words_le16(struct c67x00_device *dev, u16 addr,
+				       u16 * data, u16 count)
+{
+	unsigned long flags;
+	int i;
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	hpi_write_reg(dev, HPI_ADDR, addr);
+	for (i = 0; i < count; i++)
+		*data++ = le16_to_cpu(hpi_read_reg(dev, HPI_DATA));
+
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
+}
+
+static inline void hpi_set_bits(struct c67x00_device *dev, u16 reg, u16 mask)
+{
+	u16 value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	value = hpi_read_word_nolock(dev, reg);
+	hpi_write_word_nolock(dev, reg, value | mask);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
+}
+
+static inline void hpi_clear_bits(struct c67x00_device *dev, u16 reg, u16 mask)
+{
+	u16 value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	value = hpi_read_word_nolock(dev, reg);
+	hpi_write_word_nolock(dev, reg, value & ~mask);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
+}
+
+static inline u16 hpi_recv_mbox(struct c67x00_device *dev)
+{
+	u16 value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	value = hpi_read_reg(dev, HPI_MAILBOX);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
+
+	return value;
+}
+
+static inline u16 hpi_send_mbox(struct c67x00_device *dev, u16 value)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	hpi_write_reg(dev, HPI_MAILBOX, value);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
+
+	return value;
+}
+
+u16 c67x00_ll_hpi_status(struct c67x00_device * dev)
+{
+	u16 value;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->hw_lock, flags);
+	value = hpi_read_reg(dev, HPI_STATUS);
+	spin_unlock_irqrestore(&dev->hw_lock, flags);
+
+	return value;
+}
+
+void c67x00_ll_hpi_reg_init(struct c67x00_device *dev)
+{
+	int i;
+
+	hpi_recv_mbox(dev);
+	c67x00_ll_hpi_status(dev);
+	hpi_write_word(dev, HPI_IRQ_ROUTING_REG, 0);
+
+	for (i=0; i<C67X00_SIES; i++) {
+		hpi_write_word(dev, SIEMSG_REG(i), 0);
+		hpi_read_word(dev, SIEMSG_REG(i));
+	}
+}
+
+void c67x00_ll_hpi_enable_sofeop(struct c67x00_sie *sie)
+{
+	hpi_set_bits(sie->dev, HPI_IRQ_ROUTING_REG,
+		     SOFEOP_TO_HPI_EN(sie->sie_num));
+}
+
+void c67x00_ll_hpi_disable_sofeop(struct c67x00_sie *sie)
+{
+	hpi_clear_bits(sie->dev, HPI_IRQ_ROUTING_REG,
+		       SOFEOP_TO_HPI_EN(sie->sie_num));
+}
+
+/* -------------------------------------------------------------------------- */
+/* Transactions */
+
+static inline u16 ll_recv_msg(struct c67x00_device *dev)
+{
+	u16 res;
+
+	res = wait_for_completion_timeout(&dev->lcp.msg_received, 5 * HZ);
+	WARN_ON(!res);
+
+	return (res == 0) ? -EIO : 0;
+}
+
+/* -------------------------------------------------------------------------- */
+
+u16 c67x00_comm_read_ctrl_reg(struct c67x00_device * dev, u16 addr)
+{
+	unsigned long msg, res;
+	int rc;
+
+	mutex_lock(&dev->lcp.mutex);
+	hpi_write_word(dev, COMM_CTRL_REG_ADDR, addr);
+	hpi_send_mbox(dev, COMM_READ_CTRL_REG);
+	rc = ll_recv_msg(dev);
+
+	BUG_ON(rc); /* No return path for error code; crash spectacularly */
+
+	msg = dev->lcp.last_msg;
+	if (msg != COMM_ACK) {
+		dev_warn(&dev->pdev->dev, "COMM_READ_CTRL_REG didn't ACK!\n");
+		res = 0;
+	} else {
+		res = hpi_read_word(dev, COMM_CTRL_REG_DATA);
+	}
+	mutex_unlock(&dev->lcp.mutex);
+	return res;
+}
+
+int c67x00_comm_exec_int(struct c67x00_device *dev, u16 nr,
+			 struct c67x00_lcp_int_data *data)
+{
+	int i, rc;
+
+	mutex_lock(&dev->lcp.mutex);
+	hpi_write_word(dev, COMM_INT_NUM, nr);
+	for (i = 0; i < COMM_REGS; i++)
+		hpi_write_word(dev, COMM_R(i), data->regs[i]);
+	hpi_send_mbox(dev, COMM_EXEC_INT);
+	rc = ll_recv_msg(dev);
+	mutex_unlock(&dev->lcp.mutex);
+
+	return rc;
+}
+
+/* -------------------------------------------------------------------------- */
+/* General functions */
+
+u16 c67x00_ll_get_siemsg(struct c67x00_device *dev, int sie)
+{
+	return hpi_read_word(dev, SIEMSG_REG(sie));
+}
+
+void c67x00_ll_set_siemsg(struct c67x00_device *dev, int sie, u16 val)
+{
+	hpi_write_word(dev, SIEMSG_REG(sie), val);
+}
+
+u16 c67x00_ll_get_usb_ctl(struct c67x00_sie *sie)
+{
+	return hpi_read_word(sie->dev, USB_CTL_REG(sie->sie_num));
+}
+
+/* -------------------------------------------------------------------------- */
+/* Host specific functions */
+
+void c67x00_ll_set_husb_eot(struct c67x00_device *dev, u16 value)
+{
+	mutex_lock(&dev->lcp.mutex);
+	hpi_write_word(dev, HUSB_pEOT, value);
+	mutex_unlock(&dev->lcp.mutex);
+}
+
+static inline void c67x00_ll_husb_sie_init(struct c67x00_sie *sie)
+{
+	struct c67x00_device *dev = sie->dev;
+	struct c67x00_lcp_int_data data;
+	int rc;
+
+	rc = c67x00_comm_exec_int(dev, HUSB_SIE_INIT_INT(sie->sie_num), &data);
+	BUG_ON(rc); /* No return path for error code; crash spectacularly */
+}
+
+void c67x00_ll_husb_reset(struct c67x00_sie *sie, int port)
+{
+	struct c67x00_device *dev = sie->dev;
+	struct c67x00_lcp_int_data data;
+	int rc;
+
+	data.regs[0] = 50;	/* Reset USB port for 50ms */
+	data.regs[1] = port | (sie->sie_num << 1);
+	rc = c67x00_comm_exec_int(dev, HUSB_RESET_INT, &data);
+	BUG_ON(rc); /* No return path for error code; crash spectacularly */
+}
+
+void c67x00_ll_husb_set_current_td(struct c67x00_sie *sie, u16 addr)
+{
+	hpi_write_word(sie->dev, HUSB_SIE_pCurrentTDPtr(sie->sie_num), addr);
+}
+
+u16 c67x00_ll_husb_get_current_td(struct c67x00_sie *sie)
+{
+	return hpi_read_word(sie->dev, HUSB_SIE_pCurrentTDPtr(sie->sie_num));
+}
+
+/**
+ * c67x00_ll_husb_clear_status - clear the host status bits
+ */
+void c67x00_ll_husb_clear_status(struct c67x00_sie *sie, u16 bits)
+{
+	hpi_write_word(sie->dev, HOST_STAT_REG(sie->sie_num), bits);
+}
+
+u16 c67x00_ll_husb_get_status(struct c67x00_sie *sie)
+{
+	return hpi_read_word(sie->dev, HOST_STAT_REG(sie->sie_num));
+}
+
+u16 c67x00_ll_husb_get_frame(struct c67x00_sie * sie)
+{
+	return hpi_read_word(sie->dev, HOST_FRAME_REG(sie->sie_num));
+}
+
+void c67x00_ll_husb_init_host_port(struct c67x00_sie *sie)
+{
+	/* Set port into host mode */
+	hpi_set_bits(sie->dev, USB_CTL_REG(sie->sie_num), HOST_MODE);
+	c67x00_ll_husb_sie_init(sie);
+	/* Clear interrupts */
+	c67x00_ll_husb_clear_status(sie, HOST_STAT_MASK);
+	/* Check */
+	if (!(hpi_read_word(sie->dev, USB_CTL_REG(sie->sie_num)) & HOST_MODE))
+		dev_warn(sie_dev(sie),
+			 "SIE %d not set to host mode\n", sie->sie_num);
+}
+
+void c67x00_ll_husb_reset_port(struct c67x00_sie *sie, int port)
+{
+	/* Clear connect change */
+	c67x00_ll_husb_clear_status(sie, PORT_CONNECT_CHANGE(port));
+
+	/* Enable interrupts */
+	hpi_set_bits(sie->dev, HPI_IRQ_ROUTING_REG,
+		     SOFEOP_TO_CPU_EN(sie->sie_num));
+	hpi_set_bits(sie->dev, HOST_IRQ_EN_REG(sie->sie_num),
+		     SOF_EOP_IRQ_EN | DONE_IRQ_EN);
+
+	/* Enable pull down transistors */
+	hpi_set_bits(sie->dev, USB_CTL_REG(sie->sie_num), PORT_RES_EN(port));
+}
+
+/* -------------------------------------------------------------------------- */
+void c67x00_ll_susb_init(struct c67x00_sie *sie)
+{
+	struct c67x00_device *dev = sie->dev;
+	struct c67x00_lcp_int_data data;
+	int rc;
+
+	data.regs[1] = 1;	/* full speed */
+	data.regs[2] = sie->sie_num + 1;
+	rc = c67x00_comm_exec_int(dev, SUSB_INIT_INT, &data);
+	BUG_ON(rc); /* No return path for error code; crash spectacularly */
+
+	hpi_clear_bits(dev, HPI_IRQ_ROUTING_REG,
+		       SOFEOP_TO_HPI_EN(sie->sie_num));
+	hpi_set_bits(dev, HPI_IRQ_ROUTING_REG, SOFEOP_TO_CPU_EN(sie->sie_num));
+}
+
+/* -------------------------------------------------------------------------- */
+
+void c67x00_ll_irq(struct c67x00_device *dev)
+{
+	if ((dev->int_status & MBX_OUT_FLG) == 0)
+		return;
+
+	dev->lcp.last_msg = hpi_recv_mbox(dev);
+	complete(&dev->lcp.msg_received);
+}
+
+/* -------------------------------------------------------------------------- */
+
+int c67x00_ll_reset(struct c67x00_device *dev)
+{
+	int rc;
+
+	mutex_lock(&dev->lcp.mutex);
+	hpi_send_mbox(dev, COMM_RESET);
+	rc = ll_recv_msg(dev);
+	mutex_unlock(&dev->lcp.mutex);
+
+	return rc;
+}
+
+/* -------------------------------------------------------------------------- */
+
+/**
+ * c67x00_write_mem_le16 - write into c67x00 memory
+ * Only data is little endian, addr has cpu endianess.
+ */
+void c67x00_ll_hpi_write_mem_le16(struct c67x00_device *dev, u16 addr, int len,
+				  char *data)
+{
+	/* Sanity check */
+	if (addr + len > 0xffff) {
+		dev_err(&dev->pdev->dev,
+			"Trying to write beyond writable region!\n");
+		return;
+	}
+
+	if (addr & 0x01) {
+		/* unaligned access */
+		u16 tmp;
+		tmp = hpi_read_word(dev, addr - 1);
+		tmp = (tmp & 0x00ff) | (*data++ << 8);
+		hpi_write_word(dev, addr - 1, tmp);
+		addr++;
+		len--;
+	}
+
+	hpi_write_words_le16(dev, addr, (u16 *) data, len / 2);
+	data += len & ~0x01;
+	addr += len & ~0x01;
+	len &= 0x01;
+
+	if (len) {
+		u16 tmp;
+		tmp = hpi_read_word(dev, addr);
+		tmp = (tmp & 0xff00) | (*data++);
+		hpi_write_word(dev, addr, tmp);
+		addr++;
+		len--;
+	}
+
+}
+
+/**
+ * c67x00_ll_hpi_read_mem_le16 - read from c67x00 memory
+ * Only data is little endian, addr has cpu endianess.
+ */
+void c67x00_ll_hpi_read_mem_le16(struct c67x00_device *dev, u16 addr, int len,
+				 char *data)
+{
+	if (addr & 0x01) {
+		/* unaligned access */
+		u16 tmp;
+		tmp = hpi_read_word(dev, addr - 1);
+		*data++ = (tmp >> 8) & 0x00ff;
+		addr++;
+		len--;
+	}
+
+	hpi_read_words_le16(dev, addr, (u16 *) data, len / 2);
+	data += len & ~0x01;
+	addr += len & ~0x01;
+	len &= 0x01;
+
+	if (len) {
+		u16 tmp;
+		tmp = hpi_read_word(dev, addr);
+		*data++ = tmp & 0x00ff;
+		addr++;
+		len--;
+	}
+}
+
+/* -------------------------------------------------------------------------- */
+
+void c67x00_ll_init(struct c67x00_device *dev)
+{
+	mutex_init(&dev->lcp.mutex);
+	init_completion(&dev->lcp.msg_received);
+}
+
+void c67x00_ll_release(struct c67x00_device *dev)
+{
+}
diff --git a/drivers/usb/c67x00/c67x00.h b/drivers/usb/c67x00/c67x00.h
new file mode 100644
index 0000000..00a38df
--- /dev/null
+++ b/drivers/usb/c67x00/c67x00.h
@@ -0,0 +1,242 @@
+/*
+ * c67x00.h: Cypress C67X00 USB register and field definitions
+ *
+ * Copyright (C) 2006-2007 Barco N.V.
+ *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
+ *    based on multiple host controller drivers inside the linux kernel.
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
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301  USA.
+ */
+
+#ifndef _USB_C67X00_H
+#define _USB_C67X00_H
+
+#include <linux/interrupt.h>
+#include <linux/list.h>
+#include <linux/platform_device.h>
+#include <linux/completion.h>
+#include <linux/mutex.h>
+
+/* ---------------------------------------------------------------------
+ * Cypress C67x00 register definitions
+ */
+
+/* Processor control registers */
+/* =========================== */
+
+/* Hardware Revision Register */
+#define HW_REV_REG		0xC004
+
+/* General USB registers */
+/* ===================== */
+
+/* USB Control Register */
+#define USB_CTL_REG(x)		( (x) ? 0xC0AA : 0xC08A )
+
+#define LOW_SPEED_PORT(x)	( (x) ? 0x0800 : 0x0400 )
+#define HOST_MODE		0x0200
+#define PORT_RES_EN(x)		( (x) ? 0x0100 : 0x0080 )
+#define SOF_EOP_EN(x)		( (x) ? 0x0002 : 0x0001 )
+
+/* USB Host only registers */
+/* ======================= */
+
+/* Host n Control Register */
+#define HOST_CTL_REG(x)		((x) ? 0xC0A0 : 0xC080)
+
+#define PREAMBLE_EN		0x0080	/* Preamble enable */
+#define SEQ_SEL			0x0040	/* Data Toggle Sequence Bit Select */
+#define ISO_EN			0x0010	/* Isochronous enable  */
+#define ARM_EN			0x0001	/* Arm operation */
+
+/* Host n Interrupt Enable Register */
+#define HOST_IRQ_EN_REG(x)	( (x) ? 0xC0AC : 0xC08C)
+
+#define SOF_EOP_IRQ_EN		0x0200	/* SOF/EOP Interrupt Enable  */
+#define DONE_IRQ_EN		0x0001	/* Done Interrupt Enable  */
+
+/* Host n status register */
+#define HOST_STAT_REG(x)	( (x) ? 0xC0B0 : 0xC090 )
+
+#define HOST_STAT_MASK		0x02FD
+#define SOF_EOP_IRQ_FLG		0x0200
+#define PORT_CONNECT_CHANGE(x)	( (x) ? 0x0020 : 0x0010 )
+#define PORT_SE0_STATUS(x)	( (x) ? 0x0008 : 0x0004 )
+
+/* Host Frame Register */
+#define HOST_FRAME_REG(x)	( (x) ? 0xC0B6 : 0xC096 )
+
+#define HOST_FRAME_MASK		0x07FF
+
+/* HPI registers */
+/* ============= */
+
+/* HPI Status register */
+#define SOFEOP_FLG(x)		(1 << ( (x) ? 12 : 10 ))
+#define SIEMSG_FLAG(x)		(1 << (4 + (x)))
+#define MBX_OUT_FLG		0x0001	/* Message out available */
+
+/* Interrupt routing register */
+#define HPI_IRQ_ROUTING_REG	0x0142
+
+#define SOFEOP_TO_HPI_EN(x)	( (x) ? 0x2000 : 0x0800 )
+#define SOFEOP_TO_CPU_EN(x)	( (x) ? 0x1000 : 0x0400 )
+
+/* SIE msg registers */
+#define SIEMSG_REG(x)		( (x) ? 0x0148 : 0x0144 )
+
+#define HUSB_TDListDone		0x1000
+
+#define CY_HCD_BUF_ADDR		0x500	/* Base address for host */
+#define SIE_TD_SIZE		0x200	/* size of the td list */
+#define SIE_TD_BUF_SIZE		0x400	/* size of the data buffer */
+
+#define SIE_TD_OFFSET(host)	( (host) ? (SIE_TD_SIZE+SIE_TD_BUF_SIZE) : 0 )
+#define SIE_BUF_OFFSET(host)	(SIE_TD_OFFSET(host) + SIE_TD_SIZE)
+
+/* ---------------------------------------------------------------------
+ * Driver data structures
+ */
+
+struct c67x00_device;
+
+/**
+ * struct c67x00_lcp
+ */
+struct c67x00_lcp {
+	/* Internal use only */
+	struct mutex mutex;
+	struct completion msg_received;
+	u16 last_msg;
+};
+
+/**
+ * struct c67x00_lcp_data
+ */
+#define COMM_REGS 14
+struct c67x00_lcp_int_data {
+	u16 regs[COMM_REGS];
+};
+
+/**
+ * struct c67x00_sie - Common data associated with an SIE
+ * @lock: lock to protect this struct
+ * @private_data: subdriver dependent data
+ * @pdev: platform device associated with this SIE, created in c67x00-drv.c
+ * @irq: subdriver depenent irq handler, set NULL when not used
+ * @msg_received: called when an SIEmsg has been received
+ * @dev: link to common driver structure
+ * @sie_num: SIE number on chip, starting from 0
+ * @mode: SIE mode (host/peripheral/otg/not used)
+ *
+ * Each SIE has a separate platform_device associated with it, because the
+ * hcd needs such a device for itself (TODO: use a struct device instead
+ * of a new platform device).
+ */
+struct c67x00_sie {
+	/* Entries to be used by the subdrivers */
+	spinlock_t lock;	/* protect this structure */
+	void *private_data;
+	struct platform_device *pdev;
+	void (*irq) (struct c67x00_sie * sie, u16 msg);
+
+	/* Read only: */
+	struct c67x00_device *dev;
+	int sie_num;
+	int mode;
+};
+
+#define sie_dev(s)	(&(s)->pdev->dev)
+
+struct c67x00_hpi {
+	void __iomem *base;
+	int regstep;
+};
+
+#define C67X00_SIES	2
+#define C67X00_PORTS	2
+
+/**
+ * struct c67x00_device - Common data structure for a c67x00 instance
+ * @hpi: hpi addresses
+ * @sie: array of sie's on this chip
+ * @pdata: configuration provided by the platform
+ * @hw_lock: hardware lock
+ * @int_status: interrupt status register, only valid in_interrupt()
+ * @lcp: link control protocol dependent data
+ */
+struct c67x00_device {
+	struct c67x00_hpi hpi;
+	struct c67x00_sie sie[C67X00_SIES];
+	struct platform_device *pdev;
+	struct c67x00_platform_data *pdata;
+	spinlock_t hw_lock;
+
+	u16 int_status;
+	struct c67x00_lcp lcp;
+};
+
+/* ---------------------------------------------------------------------
+ * HCD setup and teardown hooks; defined here because these are the
+ * only routines which are called directly by the core driver.
+ */
+extern int c67x00_hcd_probe(struct c67x00_sie *sie);
+extern void c67x00_hcd_remove(struct c67x00_sie *sie);
+
+/* ---------------------------------------------------------------------
+ * Low level interface functions
+ */
+
+/* Host Port Interface (hpi) functions */
+u16 c67x00_ll_hpi_status(struct c67x00_device *dev);
+void c67x00_ll_hpi_reg_init(struct c67x00_device *dev);
+void c67x00_ll_hpi_enable_sofeop(struct c67x00_sie *sie);
+void c67x00_ll_hpi_disable_sofeop(struct c67x00_sie *sie);
+
+/* General functions */
+u16 c67x00_ll_get_siemsg(struct c67x00_device *dev, int sie);
+void c67x00_ll_set_siemsg(struct c67x00_device *dev, int sie, u16 val);
+u16 c67x00_ll_get_usb_ctl(struct c67x00_sie *sie);
+
+/* Host specific functions */
+void c67x00_ll_set_husb_eot(struct c67x00_device *dev, u16 value);
+void c67x00_ll_husb_reset(struct c67x00_sie *sie, int port);
+void c67x00_ll_husb_set_current_td(struct c67x00_sie *sie, u16 addr);
+u16 c67x00_ll_husb_get_current_td(struct c67x00_sie *sie);
+void c67x00_ll_husb_clear_status(struct c67x00_sie *sie, u16 bits);
+u16 c67x00_ll_husb_get_status(struct c67x00_sie *sie);
+u16 c67x00_ll_husb_get_frame(struct c67x00_sie *sie);
+void c67x00_ll_husb_init_host_port(struct c67x00_sie *sie);
+void c67x00_ll_husb_reset_port(struct c67x00_sie *sie, int port);
+
+/* Slave specific functions */
+void c67x00_ll_susb_init(struct c67x00_sie *sie);
+
+/* Read and write to memory */
+void c67x00_ll_hpi_write_mem_le16(struct c67x00_device *dev, u16 addr,
+				  int len, char *data);
+void c67x00_ll_hpi_read_mem_le16(struct c67x00_device *dev, u16 addr,
+				 int len, char *data);
+
+/* Called by c67x00_irq to handle lcp interrupts */
+void c67x00_ll_irq(struct c67x00_device *dev);
+
+/* Setup and teardown */
+void c67x00_ll_init(struct c67x00_device *dev);
+void c67x00_ll_release(struct c67x00_device *dev);
+int c67x00_ll_reset(struct c67x00_device *dev);
+
+#endif				/* _USB_C67X00_H */
