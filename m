Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 98473DDE49
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 09:23:53 +1100 (EST)
Message-ID: <45C8FFEF.2080702@am.sony.com>
Date: Tue, 06 Feb 2007 14:23:43 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/3] PS3: Vuart cleanups
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Cleanups for the PS3 vuart driver.

- Hide driver private data from external interface with new structure
  ps3_vuart_port_priv.
- Fix masking bug in ps3_vuart_get_interrupt_status().
- Add new helper routine ps3_vuart_clear_rx_bytes() to flush rx buffer.
- Add new variable probe_mutex to serialize probe and destroy routines.
- Rename some symbols.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
Paul,

These three patches add ppc_md.restart() and ppc_md.power_off(), and
support for the power button.

Please consider for 2.6.21.

-Geoff


 drivers/ps3/vuart.c       |  335 ++++++++++++++++++++++++++++------------------
 drivers/ps3/vuart.h       |   30 ++++
 include/asm-powerpc/ps3.h |   22 ---
 3 files changed, 240 insertions(+), 147 deletions(-)

--- ps3-linux-dev.orig/drivers/ps3/vuart.c
+++ ps3-linux-dev/drivers/ps3/vuart.c
@@ -30,7 +30,7 @@
 
 MODULE_AUTHOR("Sony Corporation");
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("ps3 vuart");
+MODULE_DESCRIPTION("PS3 vuart");
 
 /**
  * vuart - An inter-partition data link service.
@@ -157,7 +157,7 @@ int ps3_vuart_get_triggers(struct ps3_vu
 	unsigned long size;
 	unsigned long val;
 
-	result = lv1_get_virtual_uart_param(dev->port_number,
+	result = lv1_get_virtual_uart_param(dev->priv->port_number,
 		PARAM_TX_TRIGGER, &trig->tx);
 
 	if (result) {
@@ -166,7 +166,7 @@ int ps3_vuart_get_triggers(struct ps3_vu
 		return result;
 	}
 
-	result = lv1_get_virtual_uart_param(dev->port_number,
+	result = lv1_get_virtual_uart_param(dev->priv->port_number,
 		PARAM_RX_BUF_SIZE, &size);
 
 	if (result) {
@@ -175,7 +175,7 @@ int ps3_vuart_get_triggers(struct ps3_vu
 		return result;
 	}
 
-	result = lv1_get_virtual_uart_param(dev->port_number,
+	result = lv1_get_virtual_uart_param(dev->priv->port_number,
 		PARAM_RX_TRIGGER, &val);
 
 	if (result) {
@@ -198,7 +198,7 @@ int ps3_vuart_set_triggers(struct ps3_vu
 	int result;
 	unsigned long size;
 
-	result = lv1_set_virtual_uart_param(dev->port_number,
+	result = lv1_set_virtual_uart_param(dev->priv->port_number,
 		PARAM_TX_TRIGGER, tx);
 
 	if (result) {
@@ -207,7 +207,7 @@ int ps3_vuart_set_triggers(struct ps3_vu
 		return result;
 	}
 
-	result = lv1_get_virtual_uart_param(dev->port_number,
+	result = lv1_get_virtual_uart_param(dev->priv->port_number,
 		PARAM_RX_BUF_SIZE, &size);
 
 	if (result) {
@@ -216,7 +216,7 @@ int ps3_vuart_set_triggers(struct ps3_vu
 		return result;
 	}
 
-	result = lv1_set_virtual_uart_param(dev->port_number,
+	result = lv1_set_virtual_uart_param(dev->priv->port_number,
 		PARAM_RX_TRIGGER, size - rx);
 
 	if (result) {
@@ -232,9 +232,9 @@ int ps3_vuart_set_triggers(struct ps3_vu
 }
 
 static int ps3_vuart_get_rx_bytes_waiting(struct ps3_vuart_port_device *dev,
-	unsigned long *bytes_waiting)
+	u64 *bytes_waiting)
 {
-	int result = lv1_get_virtual_uart_param(dev->port_number,
+	int result = lv1_get_virtual_uart_param(dev->priv->port_number,
 		PARAM_RX_BYTES, bytes_waiting);
 
 	if (result)
@@ -253,10 +253,10 @@ static int ps3_vuart_set_interrupt_mask(
 
 	dev_dbg(&dev->core, "%s:%d: %lxh\n", __func__, __LINE__, mask);
 
-	dev->interrupt_mask = mask;
+	dev->priv->interrupt_mask = mask;
 
-	result = lv1_set_virtual_uart_param(dev->port_number,
-		PARAM_INTERRUPT_MASK, dev->interrupt_mask);
+	result = lv1_set_virtual_uart_param(dev->priv->port_number,
+		PARAM_INTERRUPT_MASK, dev->priv->interrupt_mask);
 
 	if (result)
 		dev_dbg(&dev->core, "%s:%d: interrupt_mask failed: %s\n",
@@ -265,62 +265,64 @@ static int ps3_vuart_set_interrupt_mask(
 	return result;
 }
 
-static int ps3_vuart_get_interrupt_mask(struct ps3_vuart_port_device *dev,
+static int ps3_vuart_get_interrupt_status(struct ps3_vuart_port_device *dev,
 	unsigned long *status)
 {
-	int result = lv1_get_virtual_uart_param(dev->port_number,
-		PARAM_INTERRUPT_STATUS, status);
+	u64 tmp;
+	int result = lv1_get_virtual_uart_param(dev->priv->port_number,
+		PARAM_INTERRUPT_STATUS, &tmp);
 
 	if (result)
 		dev_dbg(&dev->core, "%s:%d: interrupt_status failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 
+	*status = tmp & dev->priv->interrupt_mask;
+
 	dev_dbg(&dev->core, "%s:%d: m %lxh, s %lxh, m&s %lxh\n",
-		__func__, __LINE__, dev->interrupt_mask, *status,
-		dev->interrupt_mask & *status);
+		__func__, __LINE__, dev->priv->interrupt_mask, tmp, *status);
 
 	return result;
 }
 
 int ps3_vuart_enable_interrupt_tx(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_TX) ? 0
-		: ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_TX) ? 0
+		: ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		| INTERRUPT_MASK_TX);
 }
 
 int ps3_vuart_enable_interrupt_rx(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_RX) ? 0
-		: ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_RX) ? 0
+		: ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		| INTERRUPT_MASK_RX);
 }
 
 int ps3_vuart_enable_interrupt_disconnect(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_DISCONNECT) ? 0
-		: ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_DISCONNECT) ? 0
+		: ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		| INTERRUPT_MASK_DISCONNECT);
 }
 
 int ps3_vuart_disable_interrupt_tx(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_TX)
-		? ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_TX)
+		? ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		& ~INTERRUPT_MASK_TX) : 0;
 }
 
 int ps3_vuart_disable_interrupt_rx(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_RX)
-		? ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_RX)
+		? ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		& ~INTERRUPT_MASK_RX) : 0;
 }
 
 int ps3_vuart_disable_interrupt_disconnect(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_DISCONNECT)
-		? ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_DISCONNECT)
+		? ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		& ~INTERRUPT_MASK_DISCONNECT) : 0;
 }
 
@@ -335,9 +337,7 @@ static int ps3_vuart_raw_write(struct ps
 {
 	int result;
 
-	dev_dbg(&dev->core, "%s:%d: %xh\n", __func__, __LINE__, bytes);
-
-	result = lv1_write_virtual_uart(dev->port_number,
+	result = lv1_write_virtual_uart(dev->priv->port_number,
 		ps3_mm_phys_to_lpar(__pa(buf)), bytes, bytes_written);
 
 	if (result) {
@@ -346,10 +346,10 @@ static int ps3_vuart_raw_write(struct ps
 		return result;
 	}
 
-	dev->stats.bytes_written += *bytes_written;
+	dev->priv->stats.bytes_written += *bytes_written;
 
-	dev_dbg(&dev->core, "%s:%d: wrote %lxh/%xh=>%lxh\n", __func__,
-		__LINE__, *bytes_written, bytes, dev->stats.bytes_written);
+	dev_dbg(&dev->core, "%s:%d: wrote %lxh/%xh=>%lxh\n", __func__, __LINE__,
+		*bytes_written, bytes, dev->priv->stats.bytes_written);
 
 	return result;
 }
@@ -367,7 +367,7 @@ static int ps3_vuart_raw_read(struct ps3
 
 	dev_dbg(&dev->core, "%s:%d: %xh\n", __func__, __LINE__, bytes);
 
-	result = lv1_read_virtual_uart(dev->port_number,
+	result = lv1_read_virtual_uart(dev->priv->port_number,
 		ps3_mm_phys_to_lpar(__pa(buf)), bytes, bytes_read);
 
 	if (result) {
@@ -376,15 +376,58 @@ static int ps3_vuart_raw_read(struct ps3
 		return result;
 	}
 
-	dev->stats.bytes_read += *bytes_read;
+	dev->priv->stats.bytes_read += *bytes_read;
 
 	dev_dbg(&dev->core, "%s:%d: read %lxh/%xh=>%lxh\n", __func__, __LINE__,
-		*bytes_read, bytes, dev->stats.bytes_read);
+		*bytes_read, bytes, dev->priv->stats.bytes_read);
 
 	return result;
 }
 
 /**
+ * ps3_vuart_clear_rx_bytes - Discard bytes received.
+ * @bytes: Max byte count to discard, zero = all pending.
+ *
+ * Used to clear pending rx interrupt source.  Will not block.
+ */
+
+void ps3_vuart_clear_rx_bytes(struct ps3_vuart_port_device *dev,
+	unsigned int bytes)
+{
+	int result;
+	u64 bytes_waiting;
+	void* tmp;
+
+	result = ps3_vuart_get_rx_bytes_waiting(dev, &bytes_waiting);
+
+	BUG_ON(result);
+
+	bytes = bytes ? min(bytes, (unsigned int)bytes_waiting) : bytes_waiting;
+
+	dev_dbg(&dev->core, "%s:%d: %u\n", __func__, __LINE__, bytes);
+
+	if (!bytes)
+		return;
+
+	/* Add some extra space for recently arrived data. */
+
+	bytes += 128;
+
+	tmp = kmalloc(bytes, GFP_KERNEL);
+
+	if (!tmp)
+		return;
+
+	ps3_vuart_raw_read(dev, tmp, bytes, &bytes_waiting);
+
+	kfree(tmp);
+
+	/* Don't include these bytes in the stats. */
+
+	dev->priv->stats.bytes_read -= bytes_waiting;
+}
+
+/**
  * struct list_buffer - An element for a port device fifo buffer list.
  */
 
@@ -416,14 +459,14 @@ int ps3_vuart_write(struct ps3_vuart_por
 	dev_dbg(&dev->core, "%s:%d: %u(%xh) bytes\n", __func__, __LINE__,
 		bytes, bytes);
 
-	spin_lock_irqsave(&dev->tx_list.lock, flags);
+	spin_lock_irqsave(&dev->priv->tx_list.lock, flags);
 
-	if (list_empty(&dev->tx_list.head)) {
+	if (list_empty(&dev->priv->tx_list.head)) {
 		unsigned long bytes_written;
 
 		result = ps3_vuart_raw_write(dev, buf, bytes, &bytes_written);
 
-		spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+		spin_unlock_irqrestore(&dev->priv->tx_list.lock, flags);
 
 		if (result) {
 			dev_dbg(&dev->core,
@@ -441,7 +484,7 @@ int ps3_vuart_write(struct ps3_vuart_por
 		bytes -= bytes_written;
 		buf += bytes_written;
 	} else
-		spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+		spin_unlock_irqrestore(&dev->priv->tx_list.lock, flags);
 
 	lb = kmalloc(sizeof(struct list_buffer) + bytes, GFP_KERNEL);
 
@@ -454,10 +497,10 @@ int ps3_vuart_write(struct ps3_vuart_por
 	lb->tail = lb->data + bytes;
 	lb->dbg_number = ++dbg_number;
 
-	spin_lock_irqsave(&dev->tx_list.lock, flags);
-	list_add_tail(&lb->link, &dev->tx_list.head);
+	spin_lock_irqsave(&dev->priv->tx_list.lock, flags);
+	list_add_tail(&lb->link, &dev->priv->tx_list.head);
 	ps3_vuart_enable_interrupt_tx(dev);
-	spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+	spin_unlock_irqrestore(&dev->priv->tx_list.lock, flags);
 
 	dev_dbg(&dev->core, "%s:%d: queued buf_%lu, %xh bytes\n",
 		__func__, __LINE__, lb->dbg_number, bytes);
@@ -484,44 +527,42 @@ int ps3_vuart_read(struct ps3_vuart_port
 	dev_dbg(&dev->core, "%s:%d: %u(%xh) bytes\n", __func__, __LINE__,
 		bytes, bytes);
 
-	spin_lock_irqsave(&dev->rx_list.lock, flags);
+	spin_lock_irqsave(&dev->priv->rx_list.lock, flags);
 
-	if (dev->rx_list.bytes_held < bytes) {
-		spin_unlock_irqrestore(&dev->rx_list.lock, flags);
+	if (dev->priv->rx_list.bytes_held < bytes) {
+		spin_unlock_irqrestore(&dev->priv->rx_list.lock, flags);
 		dev_dbg(&dev->core, "%s:%d: starved for %lxh bytes\n",
-			__func__, __LINE__, bytes - dev->rx_list.bytes_held);
+			__func__, __LINE__,
+			bytes - dev->priv->rx_list.bytes_held);
 		return -EAGAIN;
 	}
 
-	list_for_each_entry_safe(lb, n, &dev->rx_list.head, link) {
+	list_for_each_entry_safe(lb, n, &dev->priv->rx_list.head, link) {
 		bytes_read = min((unsigned int)(lb->tail - lb->head), bytes);
 
 		memcpy(buf, lb->head, bytes_read);
 		buf += bytes_read;
 		bytes -= bytes_read;
-		dev->rx_list.bytes_held -= bytes_read;
+		dev->priv->rx_list.bytes_held -= bytes_read;
 
 		if (bytes_read < lb->tail - lb->head) {
 			lb->head += bytes_read;
-			spin_unlock_irqrestore(&dev->rx_list.lock, flags);
-
-			dev_dbg(&dev->core,
-				"%s:%d: dequeued buf_%lu, %lxh bytes\n",
-				__func__, __LINE__, lb->dbg_number, bytes_read);
+			dev_dbg(&dev->core, "%s:%d: buf_%lu: dequeued %lxh "
+				"bytes\n", __func__, __LINE__, lb->dbg_number,
+				bytes_read);
+			spin_unlock_irqrestore(&dev->priv->rx_list.lock, flags);
 			return 0;
 		}
 
-		dev_dbg(&dev->core, "%s:%d free buf_%lu\n", __func__, __LINE__,
-			lb->dbg_number);
+		dev_dbg(&dev->core, "%s:%d: buf_%lu: free, dequeued %lxh "
+			"bytes\n", __func__, __LINE__, lb->dbg_number,
+			bytes_read);
 
 		list_del(&lb->link);
 		kfree(lb);
 	}
-	spin_unlock_irqrestore(&dev->rx_list.lock, flags);
-
-	dev_dbg(&dev->core, "%s:%d: dequeued buf_%lu, %xh bytes\n",
-		__func__, __LINE__, lb->dbg_number, bytes);
 
+	spin_unlock_irqrestore(&dev->priv->rx_list.lock, flags);
 	return 0;
 }
 
@@ -542,9 +583,9 @@ static int ps3_vuart_handle_interrupt_tx
 
 	dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
 
-	spin_lock_irqsave(&dev->tx_list.lock, flags);
+	spin_lock_irqsave(&dev->priv->tx_list.lock, flags);
 
-	list_for_each_entry_safe(lb, n, &dev->tx_list.head, link) {
+	list_for_each_entry_safe(lb, n, &dev->priv->tx_list.head, link) {
 
 		unsigned long bytes_written;
 
@@ -578,7 +619,7 @@ static int ps3_vuart_handle_interrupt_tx
 
 	ps3_vuart_disable_interrupt_tx(dev);
 port_full:
-	spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+	spin_unlock_irqrestore(&dev->priv->tx_list.lock, flags);
 	dev_dbg(&dev->core, "%s:%d wrote %lxh bytes total\n",
 		__func__, __LINE__, bytes_total);
 	return result;
@@ -609,7 +650,7 @@ static int ps3_vuart_handle_interrupt_rx
 
 	BUG_ON(!bytes);
 
-	/* add some extra space for recently arrived data */
+	/* Add some extra space for recently arrived data. */
 
 	bytes += 128;
 
@@ -624,12 +665,12 @@ static int ps3_vuart_handle_interrupt_rx
 	lb->tail = lb->data + bytes;
 	lb->dbg_number = ++dbg_number;
 
-	spin_lock_irqsave(&dev->rx_list.lock, flags);
-	list_add_tail(&lb->link, &dev->rx_list.head);
-	dev->rx_list.bytes_held += bytes;
-	spin_unlock_irqrestore(&dev->rx_list.lock, flags);
+	spin_lock_irqsave(&dev->priv->rx_list.lock, flags);
+	list_add_tail(&lb->link, &dev->priv->rx_list.head);
+	dev->priv->rx_list.bytes_held += bytes;
+	spin_unlock_irqrestore(&dev->priv->rx_list.lock, flags);
 
-	dev_dbg(&dev->core, "%s:%d: queued buf_%lu, %lxh bytes\n",
+	dev_dbg(&dev->core, "%s:%d: buf_%lu: queued %lxh bytes\n",
 		__func__, __LINE__, lb->dbg_number, bytes);
 
 	return 0;
@@ -656,7 +697,7 @@ static int ps3_vuart_handle_port_interru
 	int result;
 	unsigned long status;
 
-	result = ps3_vuart_get_interrupt_mask(dev, &status);
+	result = ps3_vuart_get_interrupt_status(dev, &status);
 
 	if (result)
 		return result;
@@ -665,21 +706,21 @@ static int ps3_vuart_handle_port_interru
 		status);
 
 	if (status & INTERRUPT_MASK_DISCONNECT) {
-		dev->stats.disconnect_interrupts++;
+		dev->priv->stats.disconnect_interrupts++;
 		result = ps3_vuart_handle_interrupt_disconnect(dev);
 		if (result)
 			ps3_vuart_disable_interrupt_disconnect(dev);
 	}
 
 	if (status & INTERRUPT_MASK_TX) {
-		dev->stats.tx_interrupts++;
+		dev->priv->stats.tx_interrupts++;
 		result = ps3_vuart_handle_interrupt_tx(dev);
 		if (result)
 			ps3_vuart_disable_interrupt_tx(dev);
 	}
 
 	if (status & INTERRUPT_MASK_RX) {
-		dev->stats.rx_interrupts++;
+		dev->priv->stats.rx_interrupts++;
 		result = ps3_vuart_handle_interrupt_rx(dev);
 		if (result)
 			ps3_vuart_disable_interrupt_rx(dev);
@@ -688,12 +729,13 @@ static int ps3_vuart_handle_port_interru
 	return 0;
 }
 
-struct vuart_private {
-	unsigned int in_use;
+struct vuart_bus_priv {
+	const struct ports_bmp bmp;
 	unsigned int virq;
+	struct semaphore probe_mutex;
+	int use_count;
 	struct ps3_vuart_port_device *devices[PORT_COUNT];
-	const struct ports_bmp bmp;
-};
+} static vuart_bus_priv;
 
 /**
  * ps3_vuart_irq_handler - first stage interrupt handler
@@ -705,25 +747,25 @@ struct vuart_private {
 
 static irqreturn_t ps3_vuart_irq_handler(int irq, void *_private)
 {
-	struct vuart_private *private;
+	struct vuart_bus_priv *bus_priv;
 
 	BUG_ON(!_private);
-	private = (struct vuart_private *)_private;
+	bus_priv = (struct vuart_bus_priv *)_private;
 
 	while (1) {
 		unsigned int port;
 
-		dump_ports_bmp(&private->bmp);
+		dump_ports_bmp(&bus_priv->bmp);
 
-		port = (BITS_PER_LONG - 1) - __ilog2(private->bmp.status);
+		port = (BITS_PER_LONG - 1) - __ilog2(bus_priv->bmp.status);
 
 		if (port == BITS_PER_LONG)
 			break;
 
 		BUG_ON(port >= PORT_COUNT);
-		BUG_ON(!private->devices[port]);
+		BUG_ON(!bus_priv->devices[port]);
 
-		ps3_vuart_handle_port_interrupt(private->devices[port]);
+		ps3_vuart_handle_port_interrupt(bus_priv->devices[port]);
 	}
 
 	return IRQ_HANDLED;
@@ -744,12 +786,10 @@ static int ps3_vuart_match(struct device
 	return result;
 }
 
-static struct vuart_private vuart_private;
-
 static int ps3_vuart_probe(struct device *_dev)
 {
 	int result;
-	unsigned long tmp;
+	unsigned int port_number;
 	struct ps3_vuart_port_device *dev = to_ps3_vuart_port_device(_dev);
 	struct ps3_vuart_port_driver *drv =
 		to_ps3_vuart_port_driver(_dev->driver);
@@ -758,7 +798,12 @@ static int ps3_vuart_probe(struct device
 
 	BUG_ON(!drv);
 
-	result = ps3_vuart_match_id_to_port(dev->match_id, &dev->port_number);
+	down(&vuart_bus_priv.probe_mutex);
+
+	/* Setup vuart_bus_priv.devices[]. */
+
+	result = ps3_vuart_match_id_to_port(dev->match_id,
+		&port_number);
 
 	if (result) {
 		dev_dbg(&dev->core, "%s:%d: unknown match_id (%d)\n",
@@ -767,24 +812,36 @@ static int ps3_vuart_probe(struct device
 		goto fail_match;
 	}
 
-	if (vuart_private.devices[dev->port_number]) {
+	if (vuart_bus_priv.devices[port_number]) {
 		dev_dbg(&dev->core, "%s:%d: port busy (%d)\n", __func__,
-			__LINE__, dev->port_number);
+			__LINE__, port_number);
 		result = -EBUSY;
 		goto fail_match;
 	}
 
-	vuart_private.devices[dev->port_number] = dev;
+	vuart_bus_priv.devices[port_number] = dev;
+
+	/* Setup dev->priv. */
+
+	dev->priv = kzalloc(sizeof(struct ps3_vuart_port_priv), GFP_KERNEL);
+
+	if (!dev->priv) {
+		result = -ENOMEM;
+		goto fail_alloc;
+	}
+
+	dev->priv->port_number = port_number;
+
+	INIT_LIST_HEAD(&dev->priv->tx_list.head);
+	spin_lock_init(&dev->priv->tx_list.lock);
+
+	INIT_LIST_HEAD(&dev->priv->rx_list.head);
+	spin_lock_init(&dev->priv->rx_list.lock);
 
-	INIT_LIST_HEAD(&dev->tx_list.head);
-	spin_lock_init(&dev->tx_list.lock);
-	INIT_LIST_HEAD(&dev->rx_list.head);
-	spin_lock_init(&dev->rx_list.lock);
+	if (++vuart_bus_priv.use_count == 1) {
 
-	vuart_private.in_use++;
-	if (vuart_private.in_use == 1) {
 		result = ps3_alloc_vuart_irq(PS3_BINDING_CPU_ANY,
-			(void*)&vuart_private.bmp.status, &vuart_private.virq);
+			(void*)&vuart_bus_priv.bmp.status, &vuart_bus_priv.virq);
 
 		if (result) {
 			dev_dbg(&dev->core,
@@ -794,8 +851,8 @@ static int ps3_vuart_probe(struct device
 			goto fail_alloc_irq;
 		}
 
-		result = request_irq(vuart_private.virq, ps3_vuart_irq_handler,
-			IRQF_DISABLED, "vuart", &vuart_private);
+		result = request_irq(vuart_bus_priv.virq, ps3_vuart_irq_handler,
+			IRQF_DISABLED, "vuart", &vuart_bus_priv);
 
 		if (result) {
 			dev_info(&dev->core, "%s:%d: request_irq failed (%d)\n",
@@ -804,10 +861,11 @@ static int ps3_vuart_probe(struct device
 		}
 	}
 
-	ps3_vuart_set_interrupt_mask(dev, INTERRUPT_MASK_RX);
-
 	/* clear stale pending interrupts */
-	ps3_vuart_get_interrupt_mask(dev, &tmp);
+
+	ps3_vuart_clear_rx_bytes(dev, 0);
+
+	ps3_vuart_set_interrupt_mask(dev, INTERRUPT_MASK_RX);
 
 	ps3_vuart_set_triggers(dev, 1, 1);
 
@@ -822,20 +880,27 @@ static int ps3_vuart_probe(struct device
 	if (result) {
 		dev_dbg(&dev->core, "%s:%d: drv->probe failed\n",
 			__func__, __LINE__);
+		down(&vuart_bus_priv.probe_mutex);
 		goto fail_probe;
 	}
 
+	up(&vuart_bus_priv.probe_mutex);
+
 	return result;
 
 fail_probe:
+	ps3_vuart_set_interrupt_mask(dev, 0);
 fail_request_irq:
-	vuart_private.in_use--;
-	if (!vuart_private.in_use) {
-		ps3_free_vuart_irq(vuart_private.virq);
-		vuart_private.virq = NO_IRQ;
-	}
+	ps3_free_vuart_irq(vuart_bus_priv.virq);
+	vuart_bus_priv.virq = NO_IRQ;
 fail_alloc_irq:
+	--vuart_bus_priv.use_count;
+	kfree(dev->priv);
+	dev->priv = NULL;
+fail_alloc:
+	vuart_bus_priv.devices[port_number] = 0;
 fail_match:
+	up(&vuart_bus_priv.probe_mutex);
 	dev_dbg(&dev->core, "%s:%d failed\n", __func__, __LINE__);
 	return result;
 }
@@ -846,10 +911,12 @@ static int ps3_vuart_remove(struct devic
 	struct ps3_vuart_port_driver *drv =
 		to_ps3_vuart_port_driver(_dev->driver);
 
+	down(&vuart_bus_priv.probe_mutex);
+
 	dev_dbg(&dev->core, "%s:%d: %s\n", __func__, __LINE__,
 		dev->core.bus_id);
 
-	BUG_ON(vuart_private.in_use < 1);
+	BUG_ON(vuart_bus_priv.use_count < 1);
 
 	if (drv->remove)
 		drv->remove(dev);
@@ -857,13 +924,19 @@ static int ps3_vuart_remove(struct devic
 		dev_dbg(&dev->core, "%s:%d: %s no remove method\n", __func__,
 			__LINE__, dev->core.bus_id);
 
-	vuart_private.in_use--;
+	vuart_bus_priv.devices[dev->priv->port_number] = 0;
 
-	if (!vuart_private.in_use) {
-		free_irq(vuart_private.virq, &vuart_private);
-		ps3_free_vuart_irq(vuart_private.virq);
-		vuart_private.virq = NO_IRQ;
+	if (--vuart_bus_priv.use_count == 0) {
+		BUG();
+		free_irq(vuart_bus_priv.virq, &vuart_bus_priv);
+		ps3_free_vuart_irq(vuart_bus_priv.virq);
+		vuart_bus_priv.virq = NO_IRQ;
 	}
+
+	kfree(dev->priv);
+	dev->priv = NULL;
+
+	up(&vuart_bus_priv.probe_mutex);
 	return 0;
 }
 
@@ -884,12 +957,12 @@ static void ps3_vuart_shutdown(struct de
 }
 
 /**
- * ps3_vuart - The vuart instance.
+ * ps3_vuart_bus - The vuart bus instance.
  *
  * The vuart is managed as a bus that port devices connect to.
  */
 
-struct bus_type ps3_vuart = {
+struct bus_type ps3_vuart_bus = {
         .name = "ps3_vuart",
 	.match = ps3_vuart_match,
 	.probe = ps3_vuart_probe,
@@ -897,24 +970,25 @@ struct bus_type ps3_vuart = {
 	.shutdown = ps3_vuart_shutdown,
 };
 
-int __init ps3_vuart_init(void)
+int __init ps3_vuart_bus_init(void)
 {
 	int result;
 
 	pr_debug("%s:%d:\n", __func__, __LINE__);
-	result = bus_register(&ps3_vuart);
+	init_MUTEX(&vuart_bus_priv.probe_mutex);
+	result = bus_register(&ps3_vuart_bus);
 	BUG_ON(result);
 	return result;
 }
 
-void __exit ps3_vuart_exit(void)
+void __exit ps3_vuart_bus_exit(void)
 {
 	pr_debug("%s:%d:\n", __func__, __LINE__);
-	bus_unregister(&ps3_vuart);
+	bus_unregister(&ps3_vuart_bus);
 }
 
-core_initcall(ps3_vuart_init);
-module_exit(ps3_vuart_exit);
+core_initcall(ps3_vuart_bus_init);
+module_exit(ps3_vuart_bus_exit);
 
 /**
  * ps3_vuart_port_release_device - Remove a vuart port device.
@@ -923,10 +997,14 @@ module_exit(ps3_vuart_exit);
 static void ps3_vuart_port_release_device(struct device *_dev)
 {
 	struct ps3_vuart_port_device *dev = to_ps3_vuart_port_device(_dev);
+
+	dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
+	dump_stack();
+
 #if defined(DEBUG)
-	memset(dev, 0xad, sizeof(struct ps3_vuart_port_device));
+	BUG_ON(dev->priv && "forgot to free");
+	memset(&dev->core, 0, sizeof(dev->core));
 #endif
-	kfree(dev);
 }
 
 /**
@@ -938,8 +1016,10 @@ int ps3_vuart_port_device_register(struc
 	int result;
 	static unsigned int dev_count = 1;
 
+	BUG_ON(dev->priv && "forgot to free");
+
 	dev->core.parent = NULL;
-	dev->core.bus = &ps3_vuart;
+	dev->core.bus = &ps3_vuart_bus;
 	dev->core.release = ps3_vuart_port_release_device;
 
 	snprintf(dev->core.bus_id, sizeof(dev->core.bus_id), "vuart_%02x",
@@ -963,7 +1043,7 @@ int ps3_vuart_port_driver_register(struc
 	int result;
 
 	pr_debug("%s:%d: (%s)\n", __func__, __LINE__, drv->core.name);
-	drv->core.bus = &ps3_vuart;
+	drv->core.bus = &ps3_vuart_bus;
 	result = driver_register(&drv->core);
 	return result;
 }
@@ -976,6 +1056,7 @@ EXPORT_SYMBOL_GPL(ps3_vuart_port_driver_
 
 void ps3_vuart_port_driver_unregister(struct ps3_vuart_port_driver *drv)
 {
+	pr_debug("%s:%d: (%s)\n", __func__, __LINE__, drv->core.name);
 	driver_unregister(&drv->core);
 }
 
--- ps3-linux-dev.orig/drivers/ps3/vuart.h
+++ ps3-linux-dev/drivers/ps3/vuart.h
@@ -21,6 +21,36 @@
 #if !defined(_PS3_VUART_H)
 #define _PS3_VUART_H
 
+#include <asm/ps3.h>
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
+ * struct ps3_vuart_port_priv - private vuart device data.
+ */
+
+struct ps3_vuart_port_priv {
+	unsigned int port_number;
+	u64 interrupt_mask;
+
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
 /**
  * struct ps3_vuart_port_driver - a driver for a device on a vuart port
  */
--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -355,13 +355,7 @@ extern struct bus_type ps3_system_bus_ty
 
 /* vuart routines */
 
-struct ps3_vuart_stats {
-	unsigned long bytes_written;
-	unsigned long bytes_read;
-	unsigned long tx_interrupts;
-	unsigned long rx_interrupts;
-	unsigned long disconnect_interrupts;
-};
+struct ps3_vuart_port_priv;
 
 /**
  * struct ps3_vuart_port_device - a device on a vuart port
@@ -370,20 +364,8 @@ struct ps3_vuart_stats {
 struct ps3_vuart_port_device {
 	enum ps3_match_id match_id;
 	struct device core;
+	struct ps3_vuart_port_priv* priv; /* private driver variables */
 
-	/* private driver variables */
-	unsigned int port_number;
-	u64 interrupt_mask;
-	struct {
-		spinlock_t lock;
-		struct list_head head;
-	} tx_list;
-	struct {
-		unsigned long bytes_held;
-		spinlock_t lock;
-		struct list_head head;
-	} rx_list;
-	struct ps3_vuart_stats stats;
 };
 
 int ps3_vuart_port_device_register(struct ps3_vuart_port_device *dev);
Cleanups for the PS3 vuart driver.

- Hide driver private data from external interface with new structure
  ps3_vuart_port_priv.
- Fix masking bug in ps3_vuart_get_interrupt_status().
- Add new helper routine ps3_vuart_clear_rx_bytes() to flush rx buffer.
- Add new variable probe_mutex to serialize probe and destroy routines.
- Rename some symbols.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---
 drivers/ps3/vuart.c       |  335 ++++++++++++++++++++++++++++------------------
 drivers/ps3/vuart.h       |   30 ++++
 include/asm-powerpc/ps3.h |   22 ---
 3 files changed, 240 insertions(+), 147 deletions(-)

--- ps3-linux-dev.orig/drivers/ps3/vuart.c
+++ ps3-linux-dev/drivers/ps3/vuart.c
@@ -30,7 +30,7 @@
 
 MODULE_AUTHOR("Sony Corporation");
 MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("ps3 vuart");
+MODULE_DESCRIPTION("PS3 vuart");
 
 /**
  * vuart - An inter-partition data link service.
@@ -157,7 +157,7 @@ int ps3_vuart_get_triggers(struct ps3_vu
 	unsigned long size;
 	unsigned long val;
 
-	result = lv1_get_virtual_uart_param(dev->port_number,
+	result = lv1_get_virtual_uart_param(dev->priv->port_number,
 		PARAM_TX_TRIGGER, &trig->tx);
 
 	if (result) {
@@ -166,7 +166,7 @@ int ps3_vuart_get_triggers(struct ps3_vu
 		return result;
 	}
 
-	result = lv1_get_virtual_uart_param(dev->port_number,
+	result = lv1_get_virtual_uart_param(dev->priv->port_number,
 		PARAM_RX_BUF_SIZE, &size);
 
 	if (result) {
@@ -175,7 +175,7 @@ int ps3_vuart_get_triggers(struct ps3_vu
 		return result;
 	}
 
-	result = lv1_get_virtual_uart_param(dev->port_number,
+	result = lv1_get_virtual_uart_param(dev->priv->port_number,
 		PARAM_RX_TRIGGER, &val);
 
 	if (result) {
@@ -198,7 +198,7 @@ int ps3_vuart_set_triggers(struct ps3_vu
 	int result;
 	unsigned long size;
 
-	result = lv1_set_virtual_uart_param(dev->port_number,
+	result = lv1_set_virtual_uart_param(dev->priv->port_number,
 		PARAM_TX_TRIGGER, tx);
 
 	if (result) {
@@ -207,7 +207,7 @@ int ps3_vuart_set_triggers(struct ps3_vu
 		return result;
 	}
 
-	result = lv1_get_virtual_uart_param(dev->port_number,
+	result = lv1_get_virtual_uart_param(dev->priv->port_number,
 		PARAM_RX_BUF_SIZE, &size);
 
 	if (result) {
@@ -216,7 +216,7 @@ int ps3_vuart_set_triggers(struct ps3_vu
 		return result;
 	}
 
-	result = lv1_set_virtual_uart_param(dev->port_number,
+	result = lv1_set_virtual_uart_param(dev->priv->port_number,
 		PARAM_RX_TRIGGER, size - rx);
 
 	if (result) {
@@ -232,9 +232,9 @@ int ps3_vuart_set_triggers(struct ps3_vu
 }
 
 static int ps3_vuart_get_rx_bytes_waiting(struct ps3_vuart_port_device *dev,
-	unsigned long *bytes_waiting)
+	u64 *bytes_waiting)
 {
-	int result = lv1_get_virtual_uart_param(dev->port_number,
+	int result = lv1_get_virtual_uart_param(dev->priv->port_number,
 		PARAM_RX_BYTES, bytes_waiting);
 
 	if (result)
@@ -253,10 +253,10 @@ static int ps3_vuart_set_interrupt_mask(
 
 	dev_dbg(&dev->core, "%s:%d: %lxh\n", __func__, __LINE__, mask);
 
-	dev->interrupt_mask = mask;
+	dev->priv->interrupt_mask = mask;
 
-	result = lv1_set_virtual_uart_param(dev->port_number,
-		PARAM_INTERRUPT_MASK, dev->interrupt_mask);
+	result = lv1_set_virtual_uart_param(dev->priv->port_number,
+		PARAM_INTERRUPT_MASK, dev->priv->interrupt_mask);
 
 	if (result)
 		dev_dbg(&dev->core, "%s:%d: interrupt_mask failed: %s\n",
@@ -265,62 +265,64 @@ static int ps3_vuart_set_interrupt_mask(
 	return result;
 }
 
-static int ps3_vuart_get_interrupt_mask(struct ps3_vuart_port_device *dev,
+static int ps3_vuart_get_interrupt_status(struct ps3_vuart_port_device *dev,
 	unsigned long *status)
 {
-	int result = lv1_get_virtual_uart_param(dev->port_number,
-		PARAM_INTERRUPT_STATUS, status);
+	u64 tmp;
+	int result = lv1_get_virtual_uart_param(dev->priv->port_number,
+		PARAM_INTERRUPT_STATUS, &tmp);
 
 	if (result)
 		dev_dbg(&dev->core, "%s:%d: interrupt_status failed: %s\n",
 			__func__, __LINE__, ps3_result(result));
 
+	*status = tmp & dev->priv->interrupt_mask;
+
 	dev_dbg(&dev->core, "%s:%d: m %lxh, s %lxh, m&s %lxh\n",
-		__func__, __LINE__, dev->interrupt_mask, *status,
-		dev->interrupt_mask & *status);
+		__func__, __LINE__, dev->priv->interrupt_mask, tmp, *status);
 
 	return result;
 }
 
 int ps3_vuart_enable_interrupt_tx(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_TX) ? 0
-		: ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_TX) ? 0
+		: ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		| INTERRUPT_MASK_TX);
 }
 
 int ps3_vuart_enable_interrupt_rx(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_RX) ? 0
-		: ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_RX) ? 0
+		: ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		| INTERRUPT_MASK_RX);
 }
 
 int ps3_vuart_enable_interrupt_disconnect(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_DISCONNECT) ? 0
-		: ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_DISCONNECT) ? 0
+		: ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		| INTERRUPT_MASK_DISCONNECT);
 }
 
 int ps3_vuart_disable_interrupt_tx(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_TX)
-		? ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_TX)
+		? ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		& ~INTERRUPT_MASK_TX) : 0;
 }
 
 int ps3_vuart_disable_interrupt_rx(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_RX)
-		? ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_RX)
+		? ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		& ~INTERRUPT_MASK_RX) : 0;
 }
 
 int ps3_vuart_disable_interrupt_disconnect(struct ps3_vuart_port_device *dev)
 {
-	return (dev->interrupt_mask & INTERRUPT_MASK_DISCONNECT)
-		? ps3_vuart_set_interrupt_mask(dev, dev->interrupt_mask
+	return (dev->priv->interrupt_mask & INTERRUPT_MASK_DISCONNECT)
+		? ps3_vuart_set_interrupt_mask(dev, dev->priv->interrupt_mask
 		& ~INTERRUPT_MASK_DISCONNECT) : 0;
 }
 
@@ -335,9 +337,7 @@ static int ps3_vuart_raw_write(struct ps
 {
 	int result;
 
-	dev_dbg(&dev->core, "%s:%d: %xh\n", __func__, __LINE__, bytes);
-
-	result = lv1_write_virtual_uart(dev->port_number,
+	result = lv1_write_virtual_uart(dev->priv->port_number,
 		ps3_mm_phys_to_lpar(__pa(buf)), bytes, bytes_written);
 
 	if (result) {
@@ -346,10 +346,10 @@ static int ps3_vuart_raw_write(struct ps
 		return result;
 	}
 
-	dev->stats.bytes_written += *bytes_written;
+	dev->priv->stats.bytes_written += *bytes_written;
 
-	dev_dbg(&dev->core, "%s:%d: wrote %lxh/%xh=>%lxh\n", __func__,
-		__LINE__, *bytes_written, bytes, dev->stats.bytes_written);
+	dev_dbg(&dev->core, "%s:%d: wrote %lxh/%xh=>%lxh\n", __func__, __LINE__,
+		*bytes_written, bytes, dev->priv->stats.bytes_written);
 
 	return result;
 }
@@ -367,7 +367,7 @@ static int ps3_vuart_raw_read(struct ps3
 
 	dev_dbg(&dev->core, "%s:%d: %xh\n", __func__, __LINE__, bytes);
 
-	result = lv1_read_virtual_uart(dev->port_number,
+	result = lv1_read_virtual_uart(dev->priv->port_number,
 		ps3_mm_phys_to_lpar(__pa(buf)), bytes, bytes_read);
 
 	if (result) {
@@ -376,15 +376,58 @@ static int ps3_vuart_raw_read(struct ps3
 		return result;
 	}
 
-	dev->stats.bytes_read += *bytes_read;
+	dev->priv->stats.bytes_read += *bytes_read;
 
 	dev_dbg(&dev->core, "%s:%d: read %lxh/%xh=>%lxh\n", __func__, __LINE__,
-		*bytes_read, bytes, dev->stats.bytes_read);
+		*bytes_read, bytes, dev->priv->stats.bytes_read);
 
 	return result;
 }
 
 /**
+ * ps3_vuart_clear_rx_bytes - Discard bytes received.
+ * @bytes: Max byte count to discard, zero = all pending.
+ *
+ * Used to clear pending rx interrupt source.  Will not block.
+ */
+
+void ps3_vuart_clear_rx_bytes(struct ps3_vuart_port_device *dev,
+	unsigned int bytes)
+{
+	int result;
+	u64 bytes_waiting;
+	void* tmp;
+
+	result = ps3_vuart_get_rx_bytes_waiting(dev, &bytes_waiting);
+
+	BUG_ON(result);
+
+	bytes = bytes ? min(bytes, (unsigned int)bytes_waiting) : bytes_waiting;
+
+	dev_dbg(&dev->core, "%s:%d: %u\n", __func__, __LINE__, bytes);
+
+	if (!bytes)
+		return;
+
+	/* Add some extra space for recently arrived data. */
+
+	bytes += 128;
+
+	tmp = kmalloc(bytes, GFP_KERNEL);
+
+	if (!tmp)
+		return;
+
+	ps3_vuart_raw_read(dev, tmp, bytes, &bytes_waiting);
+
+	kfree(tmp);
+
+	/* Don't include these bytes in the stats. */
+
+	dev->priv->stats.bytes_read -= bytes_waiting;
+}
+
+/**
  * struct list_buffer - An element for a port device fifo buffer list.
  */
 
@@ -416,14 +459,14 @@ int ps3_vuart_write(struct ps3_vuart_por
 	dev_dbg(&dev->core, "%s:%d: %u(%xh) bytes\n", __func__, __LINE__,
 		bytes, bytes);
 
-	spin_lock_irqsave(&dev->tx_list.lock, flags);
+	spin_lock_irqsave(&dev->priv->tx_list.lock, flags);
 
-	if (list_empty(&dev->tx_list.head)) {
+	if (list_empty(&dev->priv->tx_list.head)) {
 		unsigned long bytes_written;
 
 		result = ps3_vuart_raw_write(dev, buf, bytes, &bytes_written);
 
-		spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+		spin_unlock_irqrestore(&dev->priv->tx_list.lock, flags);
 
 		if (result) {
 			dev_dbg(&dev->core,
@@ -441,7 +484,7 @@ int ps3_vuart_write(struct ps3_vuart_por
 		bytes -= bytes_written;
 		buf += bytes_written;
 	} else
-		spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+		spin_unlock_irqrestore(&dev->priv->tx_list.lock, flags);
 
 	lb = kmalloc(sizeof(struct list_buffer) + bytes, GFP_KERNEL);
 
@@ -454,10 +497,10 @@ int ps3_vuart_write(struct ps3_vuart_por
 	lb->tail = lb->data + bytes;
 	lb->dbg_number = ++dbg_number;
 
-	spin_lock_irqsave(&dev->tx_list.lock, flags);
-	list_add_tail(&lb->link, &dev->tx_list.head);
+	spin_lock_irqsave(&dev->priv->tx_list.lock, flags);
+	list_add_tail(&lb->link, &dev->priv->tx_list.head);
 	ps3_vuart_enable_interrupt_tx(dev);
-	spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+	spin_unlock_irqrestore(&dev->priv->tx_list.lock, flags);
 
 	dev_dbg(&dev->core, "%s:%d: queued buf_%lu, %xh bytes\n",
 		__func__, __LINE__, lb->dbg_number, bytes);
@@ -484,44 +527,42 @@ int ps3_vuart_read(struct ps3_vuart_port
 	dev_dbg(&dev->core, "%s:%d: %u(%xh) bytes\n", __func__, __LINE__,
 		bytes, bytes);
 
-	spin_lock_irqsave(&dev->rx_list.lock, flags);
+	spin_lock_irqsave(&dev->priv->rx_list.lock, flags);
 
-	if (dev->rx_list.bytes_held < bytes) {
-		spin_unlock_irqrestore(&dev->rx_list.lock, flags);
+	if (dev->priv->rx_list.bytes_held < bytes) {
+		spin_unlock_irqrestore(&dev->priv->rx_list.lock, flags);
 		dev_dbg(&dev->core, "%s:%d: starved for %lxh bytes\n",
-			__func__, __LINE__, bytes - dev->rx_list.bytes_held);
+			__func__, __LINE__,
+			bytes - dev->priv->rx_list.bytes_held);
 		return -EAGAIN;
 	}
 
-	list_for_each_entry_safe(lb, n, &dev->rx_list.head, link) {
+	list_for_each_entry_safe(lb, n, &dev->priv->rx_list.head, link) {
 		bytes_read = min((unsigned int)(lb->tail - lb->head), bytes);
 
 		memcpy(buf, lb->head, bytes_read);
 		buf += bytes_read;
 		bytes -= bytes_read;
-		dev->rx_list.bytes_held -= bytes_read;
+		dev->priv->rx_list.bytes_held -= bytes_read;
 
 		if (bytes_read < lb->tail - lb->head) {
 			lb->head += bytes_read;
-			spin_unlock_irqrestore(&dev->rx_list.lock, flags);
-
-			dev_dbg(&dev->core,
-				"%s:%d: dequeued buf_%lu, %lxh bytes\n",
-				__func__, __LINE__, lb->dbg_number, bytes_read);
+			dev_dbg(&dev->core, "%s:%d: buf_%lu: dequeued %lxh "
+				"bytes\n", __func__, __LINE__, lb->dbg_number,
+				bytes_read);
+			spin_unlock_irqrestore(&dev->priv->rx_list.lock, flags);
 			return 0;
 		}
 
-		dev_dbg(&dev->core, "%s:%d free buf_%lu\n", __func__, __LINE__,
-			lb->dbg_number);
+		dev_dbg(&dev->core, "%s:%d: buf_%lu: free, dequeued %lxh "
+			"bytes\n", __func__, __LINE__, lb->dbg_number,
+			bytes_read);
 
 		list_del(&lb->link);
 		kfree(lb);
 	}
-	spin_unlock_irqrestore(&dev->rx_list.lock, flags);
-
-	dev_dbg(&dev->core, "%s:%d: dequeued buf_%lu, %xh bytes\n",
-		__func__, __LINE__, lb->dbg_number, bytes);
 
+	spin_unlock_irqrestore(&dev->priv->rx_list.lock, flags);
 	return 0;
 }
 
@@ -542,9 +583,9 @@ static int ps3_vuart_handle_interrupt_tx
 
 	dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
 
-	spin_lock_irqsave(&dev->tx_list.lock, flags);
+	spin_lock_irqsave(&dev->priv->tx_list.lock, flags);
 
-	list_for_each_entry_safe(lb, n, &dev->tx_list.head, link) {
+	list_for_each_entry_safe(lb, n, &dev->priv->tx_list.head, link) {
 
 		unsigned long bytes_written;
 
@@ -578,7 +619,7 @@ static int ps3_vuart_handle_interrupt_tx
 
 	ps3_vuart_disable_interrupt_tx(dev);
 port_full:
-	spin_unlock_irqrestore(&dev->tx_list.lock, flags);
+	spin_unlock_irqrestore(&dev->priv->tx_list.lock, flags);
 	dev_dbg(&dev->core, "%s:%d wrote %lxh bytes total\n",
 		__func__, __LINE__, bytes_total);
 	return result;
@@ -609,7 +650,7 @@ static int ps3_vuart_handle_interrupt_rx
 
 	BUG_ON(!bytes);
 
-	/* add some extra space for recently arrived data */
+	/* Add some extra space for recently arrived data. */
 
 	bytes += 128;
 
@@ -624,12 +665,12 @@ static int ps3_vuart_handle_interrupt_rx
 	lb->tail = lb->data + bytes;
 	lb->dbg_number = ++dbg_number;
 
-	spin_lock_irqsave(&dev->rx_list.lock, flags);
-	list_add_tail(&lb->link, &dev->rx_list.head);
-	dev->rx_list.bytes_held += bytes;
-	spin_unlock_irqrestore(&dev->rx_list.lock, flags);
+	spin_lock_irqsave(&dev->priv->rx_list.lock, flags);
+	list_add_tail(&lb->link, &dev->priv->rx_list.head);
+	dev->priv->rx_list.bytes_held += bytes;
+	spin_unlock_irqrestore(&dev->priv->rx_list.lock, flags);
 
-	dev_dbg(&dev->core, "%s:%d: queued buf_%lu, %lxh bytes\n",
+	dev_dbg(&dev->core, "%s:%d: buf_%lu: queued %lxh bytes\n",
 		__func__, __LINE__, lb->dbg_number, bytes);
 
 	return 0;
@@ -656,7 +697,7 @@ static int ps3_vuart_handle_port_interru
 	int result;
 	unsigned long status;
 
-	result = ps3_vuart_get_interrupt_mask(dev, &status);
+	result = ps3_vuart_get_interrupt_status(dev, &status);
 
 	if (result)
 		return result;
@@ -665,21 +706,21 @@ static int ps3_vuart_handle_port_interru
 		status);
 
 	if (status & INTERRUPT_MASK_DISCONNECT) {
-		dev->stats.disconnect_interrupts++;
+		dev->priv->stats.disconnect_interrupts++;
 		result = ps3_vuart_handle_interrupt_disconnect(dev);
 		if (result)
 			ps3_vuart_disable_interrupt_disconnect(dev);
 	}
 
 	if (status & INTERRUPT_MASK_TX) {
-		dev->stats.tx_interrupts++;
+		dev->priv->stats.tx_interrupts++;
 		result = ps3_vuart_handle_interrupt_tx(dev);
 		if (result)
 			ps3_vuart_disable_interrupt_tx(dev);
 	}
 
 	if (status & INTERRUPT_MASK_RX) {
-		dev->stats.rx_interrupts++;
+		dev->priv->stats.rx_interrupts++;
 		result = ps3_vuart_handle_interrupt_rx(dev);
 		if (result)
 			ps3_vuart_disable_interrupt_rx(dev);
@@ -688,12 +729,13 @@ static int ps3_vuart_handle_port_interru
 	return 0;
 }
 
-struct vuart_private {
-	unsigned int in_use;
+struct vuart_bus_priv {
+	const struct ports_bmp bmp;
 	unsigned int virq;
+	struct semaphore probe_mutex;
+	int use_count;
 	struct ps3_vuart_port_device *devices[PORT_COUNT];
-	const struct ports_bmp bmp;
-};
+} static vuart_bus_priv;
 
 /**
  * ps3_vuart_irq_handler - first stage interrupt handler
@@ -705,25 +747,25 @@ struct vuart_private {
 
 static irqreturn_t ps3_vuart_irq_handler(int irq, void *_private)
 {
-	struct vuart_private *private;
+	struct vuart_bus_priv *bus_priv;
 
 	BUG_ON(!_private);
-	private = (struct vuart_private *)_private;
+	bus_priv = (struct vuart_bus_priv *)_private;
 
 	while (1) {
 		unsigned int port;
 
-		dump_ports_bmp(&private->bmp);
+		dump_ports_bmp(&bus_priv->bmp);
 
-		port = (BITS_PER_LONG - 1) - __ilog2(private->bmp.status);
+		port = (BITS_PER_LONG - 1) - __ilog2(bus_priv->bmp.status);
 
 		if (port == BITS_PER_LONG)
 			break;
 
 		BUG_ON(port >= PORT_COUNT);
-		BUG_ON(!private->devices[port]);
+		BUG_ON(!bus_priv->devices[port]);
 
-		ps3_vuart_handle_port_interrupt(private->devices[port]);
+		ps3_vuart_handle_port_interrupt(bus_priv->devices[port]);
 	}
 
 	return IRQ_HANDLED;
@@ -744,12 +786,10 @@ static int ps3_vuart_match(struct device
 	return result;
 }
 
-static struct vuart_private vuart_private;
-
 static int ps3_vuart_probe(struct device *_dev)
 {
 	int result;
-	unsigned long tmp;
+	unsigned int port_number;
 	struct ps3_vuart_port_device *dev = to_ps3_vuart_port_device(_dev);
 	struct ps3_vuart_port_driver *drv =
 		to_ps3_vuart_port_driver(_dev->driver);
@@ -758,7 +798,12 @@ static int ps3_vuart_probe(struct device
 
 	BUG_ON(!drv);
 
-	result = ps3_vuart_match_id_to_port(dev->match_id, &dev->port_number);
+	down(&vuart_bus_priv.probe_mutex);
+
+	/* Setup vuart_bus_priv.devices[]. */
+
+	result = ps3_vuart_match_id_to_port(dev->match_id,
+		&port_number);
 
 	if (result) {
 		dev_dbg(&dev->core, "%s:%d: unknown match_id (%d)\n",
@@ -767,24 +812,36 @@ static int ps3_vuart_probe(struct device
 		goto fail_match;
 	}
 
-	if (vuart_private.devices[dev->port_number]) {
+	if (vuart_bus_priv.devices[port_number]) {
 		dev_dbg(&dev->core, "%s:%d: port busy (%d)\n", __func__,
-			__LINE__, dev->port_number);
+			__LINE__, port_number);
 		result = -EBUSY;
 		goto fail_match;
 	}
 
-	vuart_private.devices[dev->port_number] = dev;
+	vuart_bus_priv.devices[port_number] = dev;
+
+	/* Setup dev->priv. */
+
+	dev->priv = kzalloc(sizeof(struct ps3_vuart_port_priv), GFP_KERNEL);
+
+	if (!dev->priv) {
+		result = -ENOMEM;
+		goto fail_alloc;
+	}
+
+	dev->priv->port_number = port_number;
+
+	INIT_LIST_HEAD(&dev->priv->tx_list.head);
+	spin_lock_init(&dev->priv->tx_list.lock);
+
+	INIT_LIST_HEAD(&dev->priv->rx_list.head);
+	spin_lock_init(&dev->priv->rx_list.lock);
 
-	INIT_LIST_HEAD(&dev->tx_list.head);
-	spin_lock_init(&dev->tx_list.lock);
-	INIT_LIST_HEAD(&dev->rx_list.head);
-	spin_lock_init(&dev->rx_list.lock);
+	if (++vuart_bus_priv.use_count == 1) {
 
-	vuart_private.in_use++;
-	if (vuart_private.in_use == 1) {
 		result = ps3_alloc_vuart_irq(PS3_BINDING_CPU_ANY,
-			(void*)&vuart_private.bmp.status, &vuart_private.virq);
+			(void*)&vuart_bus_priv.bmp.status, &vuart_bus_priv.virq);
 
 		if (result) {
 			dev_dbg(&dev->core,
@@ -794,8 +851,8 @@ static int ps3_vuart_probe(struct device
 			goto fail_alloc_irq;
 		}
 
-		result = request_irq(vuart_private.virq, ps3_vuart_irq_handler,
-			IRQF_DISABLED, "vuart", &vuart_private);
+		result = request_irq(vuart_bus_priv.virq, ps3_vuart_irq_handler,
+			IRQF_DISABLED, "vuart", &vuart_bus_priv);
 
 		if (result) {
 			dev_info(&dev->core, "%s:%d: request_irq failed (%d)\n",
@@ -804,10 +861,11 @@ static int ps3_vuart_probe(struct device
 		}
 	}
 
-	ps3_vuart_set_interrupt_mask(dev, INTERRUPT_MASK_RX);
-
 	/* clear stale pending interrupts */
-	ps3_vuart_get_interrupt_mask(dev, &tmp);
+
+	ps3_vuart_clear_rx_bytes(dev, 0);
+
+	ps3_vuart_set_interrupt_mask(dev, INTERRUPT_MASK_RX);
 
 	ps3_vuart_set_triggers(dev, 1, 1);
 
@@ -822,20 +880,27 @@ static int ps3_vuart_probe(struct device
 	if (result) {
 		dev_dbg(&dev->core, "%s:%d: drv->probe failed\n",
 			__func__, __LINE__);
+		down(&vuart_bus_priv.probe_mutex);
 		goto fail_probe;
 	}
 
+	up(&vuart_bus_priv.probe_mutex);
+
 	return result;
 
 fail_probe:
+	ps3_vuart_set_interrupt_mask(dev, 0);
 fail_request_irq:
-	vuart_private.in_use--;
-	if (!vuart_private.in_use) {
-		ps3_free_vuart_irq(vuart_private.virq);
-		vuart_private.virq = NO_IRQ;
-	}
+	ps3_free_vuart_irq(vuart_bus_priv.virq);
+	vuart_bus_priv.virq = NO_IRQ;
 fail_alloc_irq:
+	--vuart_bus_priv.use_count;
+	kfree(dev->priv);
+	dev->priv = NULL;
+fail_alloc:
+	vuart_bus_priv.devices[port_number] = 0;
 fail_match:
+	up(&vuart_bus_priv.probe_mutex);
 	dev_dbg(&dev->core, "%s:%d failed\n", __func__, __LINE__);
 	return result;
 }
@@ -846,10 +911,12 @@ static int ps3_vuart_remove(struct devic
 	struct ps3_vuart_port_driver *drv =
 		to_ps3_vuart_port_driver(_dev->driver);
 
+	down(&vuart_bus_priv.probe_mutex);
+
 	dev_dbg(&dev->core, "%s:%d: %s\n", __func__, __LINE__,
 		dev->core.bus_id);
 
-	BUG_ON(vuart_private.in_use < 1);
+	BUG_ON(vuart_bus_priv.use_count < 1);
 
 	if (drv->remove)
 		drv->remove(dev);
@@ -857,13 +924,19 @@ static int ps3_vuart_remove(struct devic
 		dev_dbg(&dev->core, "%s:%d: %s no remove method\n", __func__,
 			__LINE__, dev->core.bus_id);
 
-	vuart_private.in_use--;
+	vuart_bus_priv.devices[dev->priv->port_number] = 0;
 
-	if (!vuart_private.in_use) {
-		free_irq(vuart_private.virq, &vuart_private);
-		ps3_free_vuart_irq(vuart_private.virq);
-		vuart_private.virq = NO_IRQ;
+	if (--vuart_bus_priv.use_count == 0) {
+		BUG();
+		free_irq(vuart_bus_priv.virq, &vuart_bus_priv);
+		ps3_free_vuart_irq(vuart_bus_priv.virq);
+		vuart_bus_priv.virq = NO_IRQ;
 	}
+
+	kfree(dev->priv);
+	dev->priv = NULL;
+
+	up(&vuart_bus_priv.probe_mutex);
 	return 0;
 }
 
@@ -884,12 +957,12 @@ static void ps3_vuart_shutdown(struct de
 }
 
 /**
- * ps3_vuart - The vuart instance.
+ * ps3_vuart_bus - The vuart bus instance.
  *
  * The vuart is managed as a bus that port devices connect to.
  */
 
-struct bus_type ps3_vuart = {
+struct bus_type ps3_vuart_bus = {
         .name = "ps3_vuart",
 	.match = ps3_vuart_match,
 	.probe = ps3_vuart_probe,
@@ -897,24 +970,25 @@ struct bus_type ps3_vuart = {
 	.shutdown = ps3_vuart_shutdown,
 };
 
-int __init ps3_vuart_init(void)
+int __init ps3_vuart_bus_init(void)
 {
 	int result;
 
 	pr_debug("%s:%d:\n", __func__, __LINE__);
-	result = bus_register(&ps3_vuart);
+	init_MUTEX(&vuart_bus_priv.probe_mutex);
+	result = bus_register(&ps3_vuart_bus);
 	BUG_ON(result);
 	return result;
 }
 
-void __exit ps3_vuart_exit(void)
+void __exit ps3_vuart_bus_exit(void)
 {
 	pr_debug("%s:%d:\n", __func__, __LINE__);
-	bus_unregister(&ps3_vuart);
+	bus_unregister(&ps3_vuart_bus);
 }
 
-core_initcall(ps3_vuart_init);
-module_exit(ps3_vuart_exit);
+core_initcall(ps3_vuart_bus_init);
+module_exit(ps3_vuart_bus_exit);
 
 /**
  * ps3_vuart_port_release_device - Remove a vuart port device.
@@ -923,10 +997,14 @@ module_exit(ps3_vuart_exit);
 static void ps3_vuart_port_release_device(struct device *_dev)
 {
 	struct ps3_vuart_port_device *dev = to_ps3_vuart_port_device(_dev);
+
+	dev_dbg(&dev->core, "%s:%d\n", __func__, __LINE__);
+	dump_stack();
+
 #if defined(DEBUG)
-	memset(dev, 0xad, sizeof(struct ps3_vuart_port_device));
+	BUG_ON(dev->priv && "forgot to free");
+	memset(&dev->core, 0, sizeof(dev->core));
 #endif
-	kfree(dev);
 }
 
 /**
@@ -938,8 +1016,10 @@ int ps3_vuart_port_device_register(struc
 	int result;
 	static unsigned int dev_count = 1;
 
+	BUG_ON(dev->priv && "forgot to free");
+
 	dev->core.parent = NULL;
-	dev->core.bus = &ps3_vuart;
+	dev->core.bus = &ps3_vuart_bus;
 	dev->core.release = ps3_vuart_port_release_device;
 
 	snprintf(dev->core.bus_id, sizeof(dev->core.bus_id), "vuart_%02x",
@@ -963,7 +1043,7 @@ int ps3_vuart_port_driver_register(struc
 	int result;
 
 	pr_debug("%s:%d: (%s)\n", __func__, __LINE__, drv->core.name);
-	drv->core.bus = &ps3_vuart;
+	drv->core.bus = &ps3_vuart_bus;
 	result = driver_register(&drv->core);
 	return result;
 }
@@ -976,6 +1056,7 @@ EXPORT_SYMBOL_GPL(ps3_vuart_port_driver_
 
 void ps3_vuart_port_driver_unregister(struct ps3_vuart_port_driver *drv)
 {
+	pr_debug("%s:%d: (%s)\n", __func__, __LINE__, drv->core.name);
 	driver_unregister(&drv->core);
 }
 
--- ps3-linux-dev.orig/drivers/ps3/vuart.h
+++ ps3-linux-dev/drivers/ps3/vuart.h
@@ -21,6 +21,36 @@
 #if !defined(_PS3_VUART_H)
 #define _PS3_VUART_H
 
+#include <asm/ps3.h>
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
+ * struct ps3_vuart_port_priv - private vuart device data.
+ */
+
+struct ps3_vuart_port_priv {
+	unsigned int port_number;
+	u64 interrupt_mask;
+
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
 /**
  * struct ps3_vuart_port_driver - a driver for a device on a vuart port
  */
--- ps3-linux-dev.orig/include/asm-powerpc/ps3.h
+++ ps3-linux-dev/include/asm-powerpc/ps3.h
@@ -355,13 +355,7 @@ extern struct bus_type ps3_system_bus_ty
 
 /* vuart routines */
 
-struct ps3_vuart_stats {
-	unsigned long bytes_written;
-	unsigned long bytes_read;
-	unsigned long tx_interrupts;
-	unsigned long rx_interrupts;
-	unsigned long disconnect_interrupts;
-};
+struct ps3_vuart_port_priv;
 
 /**
  * struct ps3_vuart_port_device - a device on a vuart port
@@ -370,20 +364,8 @@ struct ps3_vuart_stats {
 struct ps3_vuart_port_device {
 	enum ps3_match_id match_id;
 	struct device core;
+	struct ps3_vuart_port_priv* priv; /* private driver variables */
 
-	/* private driver variables */
-	unsigned int port_number;
-	u64 interrupt_mask;
-	struct {
-		spinlock_t lock;
-		struct list_head head;
-	} tx_list;
-	struct {
-		unsigned long bytes_held;
-		spinlock_t lock;
-		struct list_head head;
-	} rx_list;
-	struct ps3_vuart_stats stats;
 };
 
 int ps3_vuart_port_device_register(struct ps3_vuart_port_device *dev);
