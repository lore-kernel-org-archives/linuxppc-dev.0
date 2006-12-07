Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5F34067C5A
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 11:17:21 +1100 (EST)
Message-ID: <45775D89.7030904@am.sony.com>
Date: Wed, 06 Dec 2006 16:17:13 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] ps3: add vuart support
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Adds support for the PS3 virtual UART (vuart).  The vuart provides a
bi-directional byte stream data link between logical partitions.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

This is needed for the ps3 graphics driver and the ps3 power
management support.  Please apply.

 arch/powerpc/platforms/ps3/Kconfig |   11 
 drivers/ps3/Makefile               |    1 
 drivers/ps3/vuart.c                |  971 +++++++++++++++++++++++++++++++++++++
 drivers/ps3/vuart.h                |   94 +++
 4 files changed, 1077 insertions(+)

--- cell--common--7.orig/arch/powerpc/platforms/ps3/Kconfig
+++ cell--common--7/arch/powerpc/platforms/ps3/Kconfig
@@ -40,4 +40,15 @@ config PS3_USE_LPAR_ADDR
 
 	  If you have any doubt, choose the default y.
 
+config PS3_VUART
+	depends on PPC_PS3
+	tristate "PS3 Virtual UART support"
+	default y
+	help
+	  Include support for the PS3 Virtual UART.
+
+	  This support is required for several system services
+	  including the System Manager and AV Settings.  In
+	  general, all users will say Y or M.
+
 endmenu
--- cell--common--7.orig/drivers/ps3/Makefile
+++ cell--common--7/drivers/ps3/Makefile
@@ -1 +1,2 @@
 obj-y += system-bus.o
+obj-$(CONFIG_PS3_VUART) += vuart.o
--- /dev/null
+++ cell--common--7/drivers/ps3/vuart.c
@@ -0,0 +1,971 @@
+/*
+ *  PS3 virtual uart
+ *
+ *  Copyright (C) 2006 Sony Computer Entertainment Inc.
+ *  Copyright 2006 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+#define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <asm/ps3.h>
+
+#include <asm/lv1call.h>
+#include <asm/bitops.h>
+
+#include "vuart.h"
+
+MODULE_AUTHOR("Sony Corporation");
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("ps3 vuart");
+
+/**
+ * vuart - An inter-partition data link service.
+ *  port 0: PS3 AV Settings.
+ *  port 2: PS3 System Manager.
+ *
+ * The vuart provides a bi-directional byte stream data link between logical
+ * partitions.  Its primary role is as a communications link between the guest
+ * OS and the system policy module.  The current HV does not support any
+ * connections other than those listed.
+ */
+
+enum {PORT_COUNT = 3,};
+
+enum vuart_param {
+	PARAM_TX_TRIGGER = 0,
+	PARAM_RX_TRIGGER = 1,
+	PARAM_INTERRUPT_MASK = 2,
+	PARAM_RX_BUF_SIZE = 3, /* read only */
+	PARAM_RX_BYTES = 4, /* read only */
+	PARAM_TX_BUF_SIZE = 5, /* read only */
+	PARAM_TX_BYTES = 6, /* read only */
+	PARAM_INTERRUPT_STATUS = 7, /* read only */
+};
+
+enum vuart_interrupt_bit {
+	INTERRUPT_BIT_TX = 0,
+	INTERRUPT_BIT_RX = 1,
+	INTERRUPT_BIT_DISCONNECT = 2,
+};
+
+enum vuart_interrupt_mask {
+	INTERRUPT_MASK_TX = 1,
+	INTERRUPT_MASK_RX = 2,
+	INTERRUPT_MASK_DISCONNECT = 4,
+};
+
+/**
+ * struct ports_bmp - bitmap indicating ports needing service
+ *
+ * A 256 bit read only bitmap indicating ports needing service.  Do not write
+ * to these bits.  Needs 4 byte alignment.
+ */
+
+struct ports_bmp
+{
+	u64 status;
+	u64 unused[3];
+} __attribute__ ((packed));
+
+#define dump_ports_bmp(_b) _dump_ports_bmp(_b, __func__, __LINE__)
+static void __attribute__ ((unused)) _dump_ports_bmp(
+	const struct ports_bmp* bmp, const char* func, int line)
+{
+	pr_debug("%s:%d: ports_bmp: %016lxh\n", func, line, bmp->status);
+}
+
+static int match_id_to_port_number(enum ps3_match_id match_id,
+	unsigned int *port_number)
+{
+	switch(match_id) {
+	case PS3_MATCH_ID_AV_SETTINGS:
+		*port_number = 0;
+		return 0;
+	case PS3_MATCH_ID_SYSTEM_MANAGER:
+		*port_number = 2;
+		return 0;
+	default:
+		BUG();
+		*port_number = UINT_MAX;
+		return -EINVAL;
+	};
+}
+
+#define dump_port_params(_b) _dump_port_params(_b, __func__, __LINE__)
+static void __attribute__ ((unused)) _dump_port_params(unsigned int port_number,
+	const char* func, int line)
+{
+#if defined(DEBUG)
+	static const char *strings[] = {
+		"tx_trigger      ",
+		"rx_trigger      ",
+		"interrupt_mask  ",
+		"rx_buf_size     ",
+		"rx_bytes        ",
+		"tx_buf_size     ",
+		"tx_bytes        ",
+		"interrupt_status",
+	};
+	int result;
+	unsigned int i;
+	u64 value;
+
+	for (i = 0; i < ARRAY_SIZE(strings); i++) {
+		result = lv1_get_virtual_uart_param(port_number, i, &value);
+
+		if (result) {
+			pr_debug("%s:%d: port_%u: %s failed: %s\n", func, line,
+				port_number, strings[i], ps3_result(result));
+			continue;
+		}
+		pr_debug("%s:%d: port_%u: %s = %llxh\n",
+			func, line, port_number, strings[i], value);
+	}
+#endif
+}
+
+struct vuart_triggers {
+	unsigned long rx;
+	unsigned long tx;
+};
+
+int vuart_get_triggers(struct ps3_vuart_port_device *dev,
+	struct vuart_triggers *trig)
+{
+	int result;
+	unsigned long size;
+	unsigned long val;
+
+	result = lv1_get_virtual_uart_param(dev->port_number,
+		PARAM_TX_TRIGGER, &trig->tx);
+
+	if (result) {
+		pr_debug("%s:%d: port_%u: tx_trigger failed: %s\n", __func__,
+			__LINE__, dev->port_number, ps3_result(result));
+		return result;
+	}
+
+	result = lv1_get_virtual_uart_param(dev->port_number,
+		PARAM_RX_BUF_SIZE, &size);
+
+	if (result) {
+		pr_debug("%s:%d: port_%u: tx_buf_size failed: %s\n", __func__,
+			__LINE__, dev->port_number, ps3_result(result));
+		return result;
+	}
+
+	result = lv1_get_virtual_uart_param(dev->port_number,
+		PARAM_RX_TRIGGER, &val);
+
+	if (result) {
+		pr_debug("%s:%d: port_%u: rx_trigger failed: %s\n", __func__,
+			__LINE__, dev->port_number, ps3_result(result));
+		return result;
+	}
+
+	trig->rx = size - val;
+
+	pr_debug("%s:%d: port_%u: tx %lxh, rx %lxh\n", __func__, __LINE__,
+		dev->port_number, trig->tx, trig->rx);
+
+	return result;
+}
+
+int vuart_set_triggers(struct ps3_vuart_port_device *dev, unsigned int tx,
+	unsigned int rx)
+{
+	int result;
+	unsigned long size;
+
+	result = lv1_set_virtual_uart_param(dev->port_number,
+		PARAM_TX_TRIGGER, tx);
+
+	if (result) {
+		pr_debug("%s:%d: port_%u: tx_trigger failed: %s\n", __func__,
+			__LINE__, dev->port_number, ps3_result(result));
+		return result;
+	}
+
+	result = lv1_get_virtual_uart_param(dev->port_number,
+		PARAM_RX_BUF_SIZE, &size);
+
+	if (result) {
+		pr_debug("%s:%d: port_%u: tx_buf_size failed: %s\n", __func__,
+			__LINE__, dev->port_number, ps3_result(result));
+		return result;
+	}
+
+	result = lv1_set_virtual_uart_param(dev->port_number,
+		PARAM_RX_TRIGGER, size - rx);
+
+	if (result) {
+		pr_debug("%s:%d: port_%u: rx_trigger failed: %s\n", __func__,
+			__LINE__, dev->port_number, ps3_result(result));
+		return result;
+	}
+
+	pr_debug("%s:%d: port_%u: tx %xh, rx %xh\n", __func__, __LINE__,
+		dev->port_number, tx, rx);
+
+	return result;
+}
+
+static int
+vuart_set_triggers_ex (struct ps3_vuart_port_device *dev,
+	const struct vuart_triggers *trig)
+{
+	return vuart_set_triggers(dev, trig->tx, trig->rx);
+}
+
+static int get_rx_bytes_waiting(struct ps3_vuart_port_device *dev,
+	unsigned long *bytes_waiting)
+{
+	int result = lv1_get_virtual_uart_param(dev->port_number,
+		PARAM_RX_BYTES, bytes_waiting);
+
+	if (result)
+		pr_debug("%s:%d: port_%u: rx_bytes failed: %s\n", __func__,
+			__LINE__, dev->port_number, ps3_result(result));
+
+	pr_debug("%s:%d: port_%u: %lxh\n", __func__, __LINE__,
+		dev->port_number, *bytes_waiting);
+	return result;
+}
+
+static int set_interrupt_mask(struct ps3_vuart_port_device *dev,
+	unsigned long mask)
+{
+	int result;
+
+	pr_debug("%s:%d: port_%u: %lxh\n", __func__, __LINE__,
+		dev->port_number, mask);
+
+	dev->interrupt_mask = mask;
+
+	result = lv1_set_virtual_uart_param(dev->port_number,
+		PARAM_INTERRUPT_MASK, dev->interrupt_mask);
+
+	if (result)
+		pr_debug("%s:%d: port_%u: interrupt_mask failed: %s\n",
+			__func__, __LINE__, dev->port_number,
+			ps3_result(result));
+
+	return result;
+}
+
+static int get_interrupt_status(struct ps3_vuart_port_device *dev,
+	unsigned long *status)
+{
+	int result = lv1_get_virtual_uart_param(dev->port_number,
+		PARAM_INTERRUPT_STATUS, status);
+
+	if (result)
+		pr_debug("%s:%d: port_%u: interrupt_status failed: %s\n",
+			__func__, __LINE__, dev->port_number,
+			ps3_result(result));
+
+	pr_debug("%s:%d: port_%u: m %lxh, s %lxh, m&s %lxh\n",
+		__func__, __LINE__, dev->port_number, dev->interrupt_mask,
+		*status, dev->interrupt_mask & *status);
+
+	return result;
+}
+
+static int enable_interrupt_tx(struct ps3_vuart_port_device *dev)
+{
+	return (dev->interrupt_mask & INTERRUPT_MASK_TX) ? 0
+		: set_interrupt_mask(dev, dev->interrupt_mask
+		| INTERRUPT_MASK_TX);
+}
+
+static int enable_interrupt_rx(struct ps3_vuart_port_device *dev)
+{
+	return (dev->interrupt_mask & INTERRUPT_MASK_RX) ? 0
+		: set_interrupt_mask(dev, dev->interrupt_mask
+		| INTERRUPT_MASK_RX);
+}
+
+static int enable_interrupt_disconnect(struct ps3_vuart_port_device *dev)
+{
+	return (dev->interrupt_mask & INTERRUPT_MASK_DISCONNECT) ? 0
+		: set_interrupt_mask(dev, dev->interrupt_mask
+		| INTERRUPT_MASK_DISCONNECT);
+}
+
+static int disable_interrupt_tx(struct ps3_vuart_port_device *dev)
+{
+	return (dev->interrupt_mask & INTERRUPT_MASK_TX)
+		? set_interrupt_mask(dev, dev->interrupt_mask
+		& ~INTERRUPT_MASK_TX) : 0;
+}
+
+static int disable_interrupt_rx(struct ps3_vuart_port_device *dev)
+{
+	return (dev->interrupt_mask & INTERRUPT_MASK_RX)
+		? set_interrupt_mask(dev, dev->interrupt_mask
+		& ~INTERRUPT_MASK_RX) : 0;
+}
+
+static int disable_interrupt_disconnect(struct ps3_vuart_port_device *dev)
+{
+	return (dev->interrupt_mask & INTERRUPT_MASK_DISCONNECT)
+		? set_interrupt_mask(dev, dev->interrupt_mask
+		& ~INTERRUPT_MASK_DISCONNECT) : 0;
+}
+
+/**
+ * raw_write - Low level write helper.
+ *
+ * Do not call raw_write directly, use ps3_vuart_write.
+ */
+
+static int raw_write(struct ps3_vuart_port_device *dev, const void* buf,
+	unsigned int bytes, unsigned long *bytes_written)
+{
+	int result;
+
+	pr_debug("%s:%d: port_%u: %xh\n", __func__, __LINE__,
+		dev->port_number, bytes);
+
+	result = lv1_write_virtual_uart(dev->port_number,
+		ps3_mm_phys_to_lpar(__pa(buf)), bytes, bytes_written);
+
+	if (result) {
+		pr_debug("%s:%d: port_%u: lv1_write_virtual_uart failed: %s\n",
+			__func__, __LINE__, dev->port_number,
+			ps3_result(result));
+		return result;
+	}
+
+	dev->stats.bytes_written += *bytes_written;
+
+	pr_debug("%s:%d: port_%u: wrote %lxh/%xh=>%lxh\n",
+		__func__, __LINE__, dev->port_number, *bytes_written, bytes,
+		dev->stats.bytes_written);
+
+	return result;
+}
+
+/**
+ * raw_read - Low level read helper.
+ *
+ * Do not call raw_read directly, use ps3_vuart_read.
+ */
+
+static int raw_read(struct ps3_vuart_port_device *dev, void* buf,
+	unsigned int bytes, unsigned long *bytes_read)
+{
+	int result;
+
+	pr_debug("%s:%d: port_%u: %xh\n", __func__, __LINE__,
+		dev->port_number, bytes);
+
+	result = lv1_read_virtual_uart(dev->port_number,
+		ps3_mm_phys_to_lpar(__pa(buf)), bytes, bytes_read);
+
+	if (result) {
+		pr_debug("%s:%d: port_%u: lv1_read_virtual_uart failed: %s\n",
+			__func__, __LINE__, dev->port_number,
+			ps3_result(result));
+		return result;
+	}
+
+	dev->stats.bytes_read += *bytes_read;
+
+	pr_debug("%s:%d: port_%u: read %lxh/%xh=>%lxh\n",
+		__func__, __LINE__, dev->port_number, *bytes_read, bytes,
+		dev->stats.bytes_read);
+
+	return result;
+}
+
+/**
+ * struct list_buffer - An element for a port device fifo buffer list.
+ */
+
+struct list_buffer {
+	struct list_head link;
+	const unsigned char *head;
+	const unsigned char *tail;
+	unsigned long dbg_number;
+	unsigned char data[];
+};
+
+/**
+ * ps3_vuart_write - the entry point for writing data to a port
+ *
+ * If the port is idle on entry as much of the incoming data is written to
+ * the port as the port will accept.  Otherwise a list buffer is created
+ * and any remaning incoming data is copied to that buffer.  The buffer is
+ * then enqueued for transmision via the transmit interrupt.
+ */
+
+int ps3_vuart_write(struct ps3_vuart_port_device *dev, const void* buf,
+	unsigned int bytes)
+{
+	static unsigned long dbg_number;
+	int result;
+	unsigned long flags;
+	struct list_buffer *lb;
+
+	pr_debug("%s:%d: port_%u: %u(%xh) bytes\n",
+		__func__, __LINE__, dev->port_number, bytes, bytes);
+
+	spin_lock_irqsave(&dev->tx_list.lock, flags);
+
+	if (list_empty(&dev->tx_list.head)) {
+		unsigned long bytes_written;
+
+		result = raw_write(dev, buf, bytes, &bytes_written);
+
+		spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+
+		if (result) {
+			pr_debug("%s:%d: raw_write failed\n",
+				__func__, __LINE__);
+			return result;
+		}
+
+		if (bytes_written == bytes) {
+			pr_debug(" <- %s:%d: port_%u: wrote %xh bytes\n",
+				__func__, __LINE__, dev->port_number, bytes);
+			return 0;
+		}
+
+		bytes -= bytes_written;
+		buf += bytes_written;
+	} else
+		spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+
+	lb = kmalloc(sizeof(struct list_buffer) + bytes, GFP_KERNEL);
+
+	if (!lb) {
+		return -ENOMEM;
+	}
+
+	memcpy(lb->data, buf, bytes);
+	lb->head = lb->data;
+	lb->tail = lb->data + bytes;
+	lb->dbg_number = ++dbg_number;
+
+	spin_lock_irqsave(&dev->tx_list.lock, flags);
+	list_add_tail(&lb->link, &dev->tx_list.head);
+	enable_interrupt_tx(dev);
+	spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+
+	pr_debug("%s:%d: port_%u: queued buf_%lu, %xh bytes\n",
+		__func__, __LINE__, dev->port_number, lb->dbg_number, bytes);
+
+	return 0;
+}
+
+/**
+ * ps3_vuart_read - the entry point for reading data from a port
+ *
+ * If enough bytes to satisfy the request are held in the buffer list those
+ * bytes are dequeued and copied to the caller's buffer.  Emptied list buffers
+ * are retiered.  If the request cannot be statified by bytes held in the list
+ * buffers -EAGAIN is returned.
+ */
+
+int ps3_vuart_read(struct ps3_vuart_port_device *dev, void* buf,
+	unsigned int bytes)
+{
+	unsigned long flags;
+	struct list_buffer *lb, *n;
+	unsigned long bytes_read;
+
+	pr_debug("%s:%d: port_%u: %u(%xh) bytes\n",
+		__func__, __LINE__, dev->port_number, bytes, bytes);
+
+	spin_lock_irqsave(&dev->rx_list.lock, flags);
+
+	if (dev->rx_list.bytes_held < bytes) {
+		spin_unlock_irqrestore(&dev->rx_list.lock, flags);
+		pr_debug(" <- %s:%d: port_%u: starved for %lxh bytes\n",
+			__func__, __LINE__, dev->port_number,
+			bytes - dev->rx_list.bytes_held);
+		return -EAGAIN;
+	}
+
+	list_for_each_entry_safe(lb, n, &dev->rx_list.head, link) {
+		bytes_read = min((unsigned int)(lb->tail - lb->head), bytes);
+
+		memcpy(buf, lb->head, bytes_read);
+		buf += bytes_read;
+		bytes -= bytes_read;
+		dev->rx_list.bytes_held -= bytes_read;
+
+		if (bytes_read < lb->tail - lb->head) {
+			lb->head += bytes_read;
+			spin_unlock_irqrestore(&dev->rx_list.lock, flags);
+
+			pr_debug(" <- %s:%d: port_%u: dequeued buf_%lu, "
+				"%lxh bytes\n", __func__, __LINE__,
+				dev->port_number, lb->dbg_number, bytes_read);
+			return 0;
+		}
+
+		pr_debug("%s:%d free buf_%lu\n", __func__, __LINE__,
+			lb->dbg_number);
+
+		list_del(&lb->link);
+		kfree(lb);
+	}
+	spin_unlock_irqrestore(&dev->rx_list.lock, flags);
+
+	pr_debug("%s:%d: port_%u: dequeued buf_%lu, %xh bytes\n",
+		__func__, __LINE__, dev->port_number, lb->dbg_number, bytes);
+
+	return 0;
+}
+
+/**
+ * handle_interrupt_tx - third stage transmit interrupt handler
+ *
+ * Services the transmit interrupt for the port.  Writes as much data from the
+ * buffer list as the port will accept.  Retires any emptied list buffers and
+ * adjusts the final list buffer state for a partial write.
+ */
+
+static int handle_interrupt_tx(struct ps3_vuart_port_device *dev)
+{
+	int result = 0;
+	unsigned long flags;
+	struct list_buffer *lb, *n;
+	unsigned long bytes_total = 0;
+
+	pr_debug("%s:%d port_%u\n", __func__, __LINE__, dev->port_number);
+
+	spin_lock_irqsave(&dev->tx_list.lock, flags);
+
+	list_for_each_entry_safe(lb, n, &dev->tx_list.head, link) {
+
+		unsigned long bytes_written;
+
+		result = raw_write(dev, lb->head, lb->tail - lb->head,
+			&bytes_written);
+
+		if (result) {
+			pr_debug("%s:%d: raw_write failed\n",
+				__func__, __LINE__);
+			break;
+		}
+
+		bytes_total += bytes_written;
+
+		if (bytes_written < lb->tail - lb->head) {
+			lb->head += bytes_written;
+			pr_debug("%s:%d cleared buf_%lu, %lxh bytes\n",
+				__func__, __LINE__, lb->dbg_number,
+				bytes_written);
+			goto port_full;
+		}
+
+		pr_debug("%s:%d free buf_%lu\n", __func__, __LINE__,
+			lb->dbg_number);
+
+		list_del(&lb->link);
+		kfree(lb);
+	}
+
+	disable_interrupt_tx(dev);
+port_full:
+	spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+	pr_debug("%s:%d wrote %lxh bytes total\n", __func__, __LINE__,
+		bytes_total);
+	return result;
+}
+
+/**
+ * handle_interrupt_rx - third stage receive interrupt handler
+ *
+ * Services the receive interrupt for the port.  Creates a list buffer and
+ * copies all waiting port data to that buffer and enqueues the buffer in the
+ * buffer list.  Buffer list data is dequeued via ps3_vuart_read.
+ */
+
+static int handle_interrupt_rx(struct ps3_vuart_port_device *dev)
+{
+	static unsigned long dbg_number;
+	int result = 0;
+	unsigned long flags;
+	struct list_buffer *lb;
+	unsigned long bytes;
+
+	pr_debug("%s:%d port_%u\n", __func__, __LINE__, dev->port_number);
+
+	result = get_rx_bytes_waiting(dev, &bytes);
+
+	if (result)
+		return -EIO;
+
+	BUG_ON(!bytes);
+
+	/* add some extra space for recently arrived data */
+
+	bytes += 128;
+
+	lb = kmalloc(sizeof(struct list_buffer) + bytes, GFP_ATOMIC);
+
+	if (!lb)
+		return -ENOMEM;
+
+	raw_read(dev, lb->data, bytes, &bytes);
+
+	lb->head = lb->data;
+	lb->tail = lb->data + bytes;
+	lb->dbg_number = ++dbg_number;
+
+	spin_lock_irqsave(&dev->rx_list.lock, flags);
+	list_add_tail(&lb->link, &dev->rx_list.head);
+	dev->rx_list.bytes_held += bytes;
+	spin_unlock_irqrestore(&dev->rx_list.lock, flags);
+
+	pr_debug("%s:%d: port_%u: queued buf_%lu, %lxh bytes\n",
+		__func__, __LINE__, dev->port_number, lb->dbg_number, bytes);
+
+	return 0;
+}
+
+static int handle_interrupt_disconnect(struct ps3_vuart_port_device *dev)
+{
+	pr_debug("%s:%d port_%u\n", __func__, __LINE__, dev->port_number);
+	BUG_ON("no support");
+	return -1;
+}
+
+/**
+ * handle_port_interrupt - second stage interrupt handler
+ *
+ * Services any pending interrupt types for the port.  Passes control to the
+ * third stage type specific interrupt handler.  Returns control to the first
+ * stage handler after one iteration.
+ */
+
+static int handle_port_interrupt(struct ps3_vuart_port_device *dev)
+{
+	int result;
+	unsigned long status;
+
+	result = get_interrupt_status(dev, &status);
+
+	if (result)
+		return result;
+
+	pr_debug("%s:%d port_%u: status: %lxh\n", __func__, __LINE__,
+		dev->port_number, status);
+
+	if (status & INTERRUPT_MASK_DISCONNECT) {
+		dev->stats.disconnect_interrupts++;
+		result = handle_interrupt_disconnect(dev);
+		if (result)
+			disable_interrupt_disconnect(dev);
+	}
+
+	if (status & INTERRUPT_MASK_TX) {
+		dev->stats.tx_interrupts++;
+		result = handle_interrupt_tx(dev);
+		if (result)
+			disable_interrupt_tx(dev);
+	}
+
+	if (status & INTERRUPT_MASK_RX) {
+		dev->stats.rx_interrupts++;
+		result = handle_interrupt_rx(dev);
+		if (result)
+			disable_interrupt_rx(dev);
+	}
+
+	return 0;
+}
+
+struct vuart_private {
+	unsigned int in_use;
+	unsigned int virq;
+	struct ps3_vuart_port_device *devices[PORT_COUNT];
+	const struct ports_bmp bmp;
+};
+
+/**
+ * vuart_irq_handler - first stage interrupt handler
+ *
+ * Loops finding any interrupting port and its associated instance data.
+ * Passes control to the second stage port specific interrupt handler.  Loops
+ * until all outstanding interrupts are serviced.
+ */
+
+static irqreturn_t vuart_irq_handler(int irq, void *_private)
+{
+	struct vuart_private *private;
+
+	BUG_ON(!_private);
+	private = (struct vuart_private *)_private;
+
+	while (1) {
+		unsigned int port;
+
+		dump_ports_bmp(&private->bmp);
+
+		port = (BITS_PER_LONG - 1) - __ilog2(private->bmp.status);
+
+		if (port == BITS_PER_LONG)
+			break;
+
+		BUG_ON(port >= PORT_COUNT);
+		BUG_ON(!private->devices[port]);
+
+		handle_port_interrupt(private->devices[port]);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int ps3_vuart_match(struct device *_dev, struct device_driver *_drv)
+{
+	int result;
+	struct ps3_vuart_port_driver *drv = to_ps3_vuart_port_driver(_drv);
+	struct ps3_vuart_port_device *dev = to_ps3_vuart_port_device(_dev);
+
+	result = dev->match_id == drv->match_id;
+
+	pr_info("%s:%d: dev=%u(%s), drv=%u(%s): %s\n", __func__, __LINE__,
+		dev->match_id, dev->core.bus_id, drv->match_id, drv->core.name,
+		(result ? "match" : "miss"));
+
+	return result;
+}
+
+static struct vuart_private vuart_private;
+
+static int ps3_vuart_probe(struct device *_dev)
+{
+	int result;
+	unsigned long tmp;
+	struct ps3_vuart_port_device *dev = to_ps3_vuart_port_device(_dev);
+	struct ps3_vuart_port_driver *drv =
+		to_ps3_vuart_port_driver(_dev->driver);
+
+	pr_debug("%s:%d: %s\n", __func__, __LINE__,
+		dev->core.bus_id);
+
+	BUG_ON(!drv);
+
+	result = match_id_to_port_number(dev->match_id, &dev->port_number);
+
+	if (result) {
+		pr_debug("%s:%d: unknown match_id (%d)\n",
+			__func__, __LINE__, dev->match_id);
+		result = -EINVAL;
+		goto fail_match;
+	}
+
+	if (vuart_private.devices[dev->port_number]) {
+		pr_debug("%s:%d: port busy (%d)\n",
+			__func__, __LINE__, dev->port_number);
+		result = -EBUSY;
+		goto fail_match;
+	}
+
+	vuart_private.devices[dev->port_number] = dev;
+
+	INIT_LIST_HEAD(&dev->tx_list.head);
+	spin_lock_init(&dev->tx_list.lock);
+	INIT_LIST_HEAD(&dev->rx_list.head);
+	spin_lock_init(&dev->rx_list.lock);
+
+	vuart_private.in_use++;
+	if (vuart_private.in_use == 1) {
+		result = ps3_alloc_vuart_irq((void*)&vuart_private.bmp.status,
+			&vuart_private.virq);
+
+		if (result) {
+			pr_debug("%s:%d: ps3_alloc_vuart_irq failed (%d)\n",
+				__func__, __LINE__, result);
+			result = -EPERM;
+			goto fail_alloc_irq;
+		}
+
+		result = request_irq(vuart_private.virq, vuart_irq_handler,
+			IRQF_DISABLED, "vuart", &vuart_private);
+
+		if (result) {
+			pr_info("%s:%d: request_irq failed (%d)\n",
+				__func__, __LINE__, result);
+			goto fail_request_irq;
+		}
+	}
+
+	set_interrupt_mask(dev, INTERRUPT_MASK_RX);
+
+	/* clear stale pending interrupts */
+	get_interrupt_status(dev, &tmp);
+
+	vuart_set_triggers(dev, 1, 1);
+
+	if (drv->probe)
+		result = drv->probe(dev);
+	else {
+		result = 0;
+		pr_info("%s:%d: %s no probe method\n", __func__, __LINE__,
+			dev->core.bus_id);
+	}
+
+	if (result) {
+		pr_debug("%s:%d: drv->probe failed\n",
+			__func__, __LINE__);
+		goto fail_probe;
+	}
+
+	return result;
+
+fail_probe:
+fail_request_irq:
+	vuart_private.in_use--;
+	if (!vuart_private.in_use) {
+		ps3_free_vuart_irq(vuart_private.virq);
+		vuart_private.virq = NO_IRQ;
+	}
+fail_alloc_irq:
+fail_match:
+	pr_debug("%s:%d failed\n", __func__, __LINE__);
+	return result;
+}
+
+static int ps3_vuart_remove(struct device *_dev)
+{
+	struct ps3_vuart_port_device *dev = to_ps3_vuart_port_device(_dev);
+	struct ps3_vuart_port_driver *drv =
+		to_ps3_vuart_port_driver(_dev->driver);
+
+	pr_debug("%s:%d: %s\n", __func__, __LINE__, dev->core.bus_id);
+
+	BUG_ON(vuart_private.in_use < 1);
+
+	if (drv->remove)
+		drv->remove(dev);
+	else
+		pr_debug("%s:%d: %s no remove method\n", __func__, __LINE__,
+			dev->core.bus_id);
+
+	vuart_private.in_use--;
+
+	if (!vuart_private.in_use) {
+		free_irq(vuart_private.virq, &vuart_private);
+		ps3_free_vuart_irq(vuart_private.virq);
+		vuart_private.virq = NO_IRQ;
+	}
+	return 0;
+}
+
+/**
+ * ps3_vuart - The vuart instance.
+ *
+ * The vuart is managed as a bus that port devices connect to.
+ */
+
+struct bus_type ps3_vuart = {
+        .name = "ps3_vuart",
+	.match = ps3_vuart_match,
+	.probe = ps3_vuart_probe,
+	.remove = ps3_vuart_remove,
+};
+
+int __init ps3_vuart_init(void)
+{
+	int result;
+
+	pr_debug("%s:%d:\n", __func__, __LINE__);
+	result = bus_register(&ps3_vuart);
+	BUG_ON(result);
+	return result;
+}
+
+void __exit ps3_vuart_exit(void)
+{
+	pr_debug("%s:%d:\n", __func__, __LINE__);
+	bus_unregister(&ps3_vuart);
+}
+
+core_initcall(ps3_vuart_init);
+module_exit(ps3_vuart_exit);
+
+/**
+ * ps3_vuart_port_release_device - Remove a vuart port device.
+ */
+
+static void ps3_vuart_port_release_device(struct device *_dev)
+{
+	struct ps3_vuart_port_device *dev = to_ps3_vuart_port_device(_dev);
+#if defined(DEBUG)
+	memset(dev, 0xad, sizeof(struct ps3_vuart_port_device));
+#endif
+	kfree(dev);
+}
+
+/**
+ * ps3_vuart_port_device_register - Add a vuart port device.
+ */
+
+int ps3_vuart_port_device_register(struct ps3_vuart_port_device *dev)
+{
+	int result;
+	static unsigned int dev_count = 1;
+
+	dev->core.parent = NULL;
+	dev->core.bus = &ps3_vuart;
+	dev->core.release = ps3_vuart_port_release_device;
+
+	snprintf(dev->core.bus_id, sizeof(dev->core.bus_id), "vuart_%02x",
+		dev_count++);
+
+	pr_debug("%s:%d add %s\n", __func__, __LINE__, dev->core.bus_id);
+
+	result = device_register(&dev->core);
+
+	return result;
+}
+
+EXPORT_SYMBOL_GPL(ps3_vuart_port_device_register);
+
+/**
+ * ps3_vuart_port_driver_register - Add a vuart port device driver.
+ */
+
+int ps3_vuart_port_driver_register(struct ps3_vuart_port_driver *drv)
+{
+	int result;
+
+	pr_debug("%s:%d: (%s)\n", __func__, __LINE__, drv->core.name);
+	drv->core.bus = &ps3_vuart;
+	result = driver_register(&drv->core);
+	return result;
+}
+
+EXPORT_SYMBOL_GPL(ps3_vuart_port_driver_register);
+
+/**
+ * ps3_vuart_port_driver_unregister - Remove a vuart port device driver.
+ */
+
+void ps3_vuart_port_driver_unregister(struct ps3_vuart_port_driver *drv)
+{
+	driver_unregister(&drv->core);
+}
+
+EXPORT_SYMBOL_GPL(ps3_vuart_port_driver_unregister);
--- /dev/null
+++ cell--common--7/drivers/ps3/vuart.h
@@ -0,0 +1,94 @@
+/*
+ *  PS3 virtual uart
+ *
+ *  Copyright (C) 2006 Sony Computer Entertainment Inc.
+ *  Copyright 2006 Sony Corp.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#if !defined(_PS3_VUART_H)
+#define _PS3_VUART_H
+
+struct ps3_vuart_stats {
+	unsigned long bytes_written;
+	unsigned long bytes_read;
+	unsigned long tx_interrupts;
+	unsigned long rx_interrupts;
+	unsigned long disconnect_interrupts;
+};
+
+/**
+ * struct ps3_vuart_port_device - a device on a vuart port
+ */
+
+struct ps3_vuart_port_device {
+	enum ps3_match_id match_id;
+	struct device core;
+
+	/* private driver variables */
+	unsigned int port_number;
+	unsigned long interrupt_mask;
+	struct {
+		spinlock_t lock;
+		struct list_head head;
+	} tx_list;
+	struct {
+		unsigned long bytes_held;
+		spinlock_t lock;
+		struct list_head head;
+	} rx_list;
+	struct ps3_vuart_stats stats;
+};
+
+/**
+ * struct ps3_vuart_port_driver - a driver for a device on a vuart port
+ */
+
+struct ps3_vuart_port_driver {
+	enum ps3_match_id match_id;
+	struct device_driver core;
+	int (*probe)(struct ps3_vuart_port_device *);
+	int (*remove)(struct ps3_vuart_port_device *);
+	int (*tx_event)(struct ps3_vuart_port_device *dev);
+	int (*rx_event)(struct ps3_vuart_port_device *dev);
+	int (*disconnect_event)(struct ps3_vuart_port_device *dev);
+	/* int (*suspend)(struct ps3_vuart_port_device *, pm_message_t); */
+	/* int (*resume)(struct ps3_vuart_port_device *); */
+};
+
+int ps3_vuart_port_device_register(struct ps3_vuart_port_device *dev);
+int ps3_vuart_port_driver_register(struct ps3_vuart_port_driver *drv);
+void ps3_vuart_port_driver_unregister(struct ps3_vuart_port_driver *drv);
+int ps3_vuart_write(struct ps3_vuart_port_device *dev,
+	const void* buf, unsigned int bytes);
+int ps3_vuart_read(struct ps3_vuart_port_device *dev, void* buf,
+	unsigned int bytes);
+static inline struct ps3_vuart_port_driver *to_ps3_vuart_port_driver(
+	struct device_driver *_drv)
+{
+	return container_of(_drv, struct ps3_vuart_port_driver, core);
+}
+static inline struct ps3_vuart_port_device *to_ps3_vuart_port_device(
+	struct device *_dev)
+{
+	return container_of(_dev, struct ps3_vuart_port_device, core);
+}
+
+int ps3_vuart_write(struct ps3_vuart_port_device *dev, const void* buf,
+	unsigned int bytes);
+int ps3_vuart_read(struct ps3_vuart_port_device *dev, void* buf,
+	unsigned int bytes);
+
+#endif
