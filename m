Return-Path: <jacmet@sunsite.dk>
Received: from nanv.dk (vps.korsgaard.com [64.79.194.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0BF2DDF40
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jan 2008 22:39:09 +1100 (EST)
Message-Id: <20080121104800.223553000@sunsite.dk>
References: <20080121103434.397382000@sunsite.dk>
Date: Mon, 21 Jan 2008 11:34:38 +0100
From: Peter Korsgaard <jacmet@sunsite.dk>
To: dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, grant.likely@secretlab.ca
Subject: [patch v4 4/4] USB: add Cypress c67x00 OTG controller gadget driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds USB gadget support for the Cypress c67x00 family of devices.

This is work in progress and not ready to be committed yet. I'm posting this
to show how it fits with the rest of the driver and to collect feedback.

The driver works good enought to use g_serial, but there are still issues
to be solved. The biggest issue is that endpoint 0 is currently handled by
the BIOS inside the c67x00, so the gadget stack never sees the data.
The BIOS also has other deficiencies, E.G. see the patching done in
c67x00_ll_susb_init().
---
 drivers/usb/Kconfig                |    2 
 drivers/usb/Makefile               |    2 
 drivers/usb/c67x00/Kconfig         |   21 
 drivers/usb/c67x00/Makefile        |    7 
 drivers/usb/c67x00/c67x00-drv.c    |   11 
 drivers/usb/c67x00/c67x00-ll-hpi.c |  184 +++++++
 drivers/usb/c67x00/c67x00-udc.c    |  905 +++++++++++++++++++++++++++++++++++++
 drivers/usb/c67x00/c67x00-udc.h    |   50 ++
 drivers/usb/c67x00/c67x00.h        |   18 
 drivers/usb/gadget/Kconfig         |    7 
 drivers/usb/gadget/gadget_chips.h  |    8 
 drivers/usb/host/Kconfig           |   12 
 12 files changed, 1212 insertions(+), 15 deletions(-)

Index: linux-2.6/drivers/usb/c67x00/c67x00-udc.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/usb/c67x00/c67x00-udc.c
@@ -0,0 +1,905 @@
+/*
+ * c67x00-udc.c: Cypress C67X00 USB device controller
+ *
+ * Copyright (C) 2006-2008 Barco N.V.
+ *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
+ *    based on multiple device controller drivers inside the linux kernel.
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
+#include <linux/device.h>
+#include <linux/usb.h>
+#include <linux/usb/c67x00.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/ch9.h>
+
+#include "c67x00.h"
+#include "c67x00-udc.h"
+
+/* Defined in DEVICE n ENDPOINT STATUS REGISTERS */
+#define OVERFLOW_FLG		0x0800	/* Receive overflow */
+#define UNDERFLOW_FLG		0x0400	/* Receive underflow */
+#define OUT_EXCEPTION_FLG	0x0200	/* OUT received when armed for IN */
+#define IN_EXCEPTION_FLG	0x0100	/* IN received when armed for OUT */
+#define STALL_FLG		0x0080	/* Stall sent */
+#define NAK_FLG			0x0040	/* NAK sent */
+#define LENGTH_EXCEPT_FLG	0x0020	/* Overflow or Underflow occured */
+#define SETUP_FLG		0x0010	/* SETUP packet received */
+#define SEQ_STAT		0x0008	/* Last Data Toggle Sequence bit sent
+						or received */
+#define TIMEOUT_FLG		0x0004	/* Last transmission timed out */
+#define ERROR_FLG		0x0002	/* CRC Err detected in last
+						reception*/
+#define ACK_FLG			0x0001	/* Last transaction ACK'D (sent
+						or received) */
+
+/* Defined in DEVICE n ENDPOINT CONTROL REGISTERS */
+#define DIR_SEL_IN	0x0004	/* Last transmission timed out */
+#define EP_ENABLE	0x0002	/* Enable Endpoint */
+
+
+
+struct c67x00_request {
+	struct usb_request req;
+	struct list_head queue;
+};
+
+
+
+struct c67x00_udc_ep {
+	struct usb_ep ep;
+	struct c67x00_udc *udc;
+
+	struct list_head queue;
+	int ep_num;
+	int is_ep_in;
+	int enable;
+	int stopped;
+	int start_io;
+};
+
+#define C67X00_MAX_NB_END_POINTS 8
+
+struct c67x00_udc {
+	spinlock_t lock;
+	struct c67x00_sie *sie;
+	struct usb_gadget gadget;
+	struct usb_gadget_driver *driver;
+	struct c67x00_udc_ep ep[C67X00_MAX_NB_END_POINTS];
+	struct work_struct io_work;
+	int config_nr;
+	/* The highest string descriptor entry
+	   (used to retrieve descriptors from gadget driver) */
+	int top_str_id;
+	u16 string_desc_addr;
+};
+
+const static unsigned char get_descriptor_device[] = {
+	USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE,
+	USB_REQ_GET_DESCRIPTOR,
+	0x00,
+	USB_DT_DEVICE,
+	0x00,
+	0x00,
+	0x12,
+	0x00
+};
+
+const static unsigned char get_descriptor_config[] = {
+	USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE,
+	USB_REQ_GET_DESCRIPTOR,
+	0x00,
+	USB_DT_CONFIG,
+	0x00,
+	0x00,
+	0x40,
+	0x00
+};
+
+static unsigned char get_descriptor_string[] = {
+	USB_DIR_IN | USB_TYPE_STANDARD | USB_RECIP_DEVICE,
+	USB_REQ_GET_DESCRIPTOR,
+	0x00,
+	USB_DT_STRING,
+	0x00,
+	0x00,
+	0xFF,
+	0x00
+};
+
+#define SIEx_DEV_DESC_LOC(x)	((x) ? (CY_UDC_DESC_BASE_ADDRESS + 0x200) \
+				 : CY_UDC_DESC_BASE_ADDRESS)
+#define SIEx_CONF_DESC_LOC(x)	(SIEx_DEV_DESC_LOC(x) + 32)
+
+/* ------------------------------------------------------------------------- */
+/* gadget ops */
+
+static int c67x00_get_frame(struct usb_gadget *_gadget)
+{
+	printk(KERN_DEBUG "c67x00-udc : c67x00_get_frame\n");
+	return -ENODEV;
+}
+
+static int c67x00_wakeup(struct usb_gadget *_gadget)
+{
+	printk(KERN_DEBUG "c67x00-udc : c67x00_wakeup\n");
+	return -ENODEV;
+}
+
+static int c67x00_selfpowered(struct usb_gadget *_gadget,
+			      int is_selfpowered)
+{
+	printk(KERN_DEBUG "c67x00-udc : c67x00_selfpowered\n");
+	return -ENODEV;
+}
+
+static int c67x00_vbus_session(struct usb_gadget *_gadget, int is_active)
+{
+	printk(KERN_DEBUG "c67x00-udc : c67x00_vbus_session\n");
+	return -ENODEV;
+}
+
+static int c67x00_pullup(struct usb_gadget *_gadget, int is_on)
+{
+	printk(KERN_DEBUG "c67x00-udc : c67x00_pullup\n");
+	return -ENODEV;
+}
+
+
+static const struct usb_gadget_ops c67x00_udc_ops = {
+	.get_frame = c67x00_get_frame,
+	.wakeup = c67x00_wakeup,
+	.set_selfpowered = c67x00_selfpowered,
+	.vbus_session = c67x00_vbus_session,
+	.pullup = c67x00_pullup
+};
+
+
+
+/*
+ * the sie and gadget_driver get probed/registered from 2 totally independant
+ * places, this datastructure binds them together
+ */
+static struct c67x00_udc controller = {
+	.gadget = {
+		.ops = &c67x00_udc_ops,
+		.name = "c67x00_udc",
+		.speed = USB_SPEED_FULL,
+		.is_dualspeed = 1,
+		.is_a_peripheral = 1,
+		.dev = {
+			.bus_id = "gadget",
+		},
+	},
+};
+
+
+/*----------------------------------------------------------------------------*/
+
+static void c67x00_udc_set_configuration(struct c67x00_sie *sie, u16 config)
+{
+	struct usb_ctrlrequest request;
+	struct c67x00_udc *udc = sie->private_data;
+
+	dev_dbg(sie_dev(sie), "set configuration %d\n", config);
+
+	request.bRequest = USB_REQ_SET_CONFIGURATION;
+	request.bRequestType = 0;
+	request.wValue = cpu_to_le16(config);
+	udc->driver->setup(&udc->gadget, &request);
+}
+
+static int c67x00_udc_parse_descriptor(struct c67x00_udc *udc,
+				       struct c67x00_request *req)
+{
+	int retval = 0;
+	u8 *buf = req->req.buf;
+
+	if (req->req.length < 2)
+		return 0;
+
+	switch (buf[1]) {
+	case USB_DT_DEVICE: {
+		struct usb_device_descriptor *desc = req->req.buf;
+
+		/* Look for the highest stringIndex */
+		if (desc->iManufacturer > udc->top_str_id)
+			udc->top_str_id = desc->iManufacturer;
+		if (desc->iProduct > udc->top_str_id)
+			udc->top_str_id = desc->iProduct;
+		if (desc->iSerialNumber > udc->top_str_id)
+			udc->top_str_id = desc->iSerialNumber;
+
+		/* Write descriptor to C67x00 memory */
+		c67x00_ll_write_mem_le16(udc->sie->dev,
+					 SIEx_DEV_DESC_LOC(udc->sie->sie_num),
+					 req->req.buf, req->req.length);
+
+		/* Write vector address to c67x00 */
+		c67x00_ll_set_device_descriptor_location(
+			udc->sie, SIEx_DEV_DESC_LOC(udc->sie->sie_num));
+
+		retval = 1;
+		break;
+	}
+
+	case USB_DT_CONFIG: {
+		struct usb_config_descriptor *desc = req->req.buf;
+		int offset;
+		u16 length;
+
+		/* store config number to pass to the gadget driver,
+		   once the c67x00 is configured */
+		udc->config_nr = desc->bConfigurationValue;
+
+		length = le16_to_cpu(desc->wTotalLength);
+
+		if (desc->iConfiguration > udc->top_str_id)
+			udc->top_str_id = desc->iConfiguration;
+
+		offset = desc->bLength;
+
+		while (offset < length) {
+			if (buf[offset + 1] == USB_DT_INTERFACE) {
+				struct usb_interface_descriptor *if_desc =
+					(struct usb_interface_descriptor *)
+					(buf + offset);
+
+				if (if_desc->iInterface > udc->top_str_id)
+					udc->top_str_id = if_desc->iInterface;
+			}
+
+			offset += buf[offset];
+		}
+
+		if ((length % 8) == 0) {
+			/* BIOS can't handle descriptors with size multiple
+			   of xfer size */
+			length += 1;
+			/* desc->wTotalLength = cpu_to_le16(length); */
+		}
+
+		/* BIOS can only handle configuration 1,
+		   so make sure the config nr is 1 */
+		desc->bConfigurationValue = 1;
+
+		c67x00_ll_write_mem_le16(udc->sie->dev,
+					 SIEx_CONF_DESC_LOC(udc->sie->sie_num),
+					 req->req.buf, length);
+
+		/* Write vector address to SW interrupt */
+		c67x00_ll_set_configuration_descriptor_location(
+			udc->sie, SIEx_CONF_DESC_LOC(udc->sie->sie_num));
+
+		/* String descriptors start behind configuration descriptor */
+		udc->string_desc_addr =
+			SIEx_CONF_DESC_LOC(udc->sie->sie_num) + length;
+
+		/* Make sure the address is even */
+		if (udc->string_desc_addr & 0x01)
+			udc->string_desc_addr++;
+
+		/* Write string descriptor vector address */
+		c67x00_ll_set_string_descriptor_location(
+			udc->sie, udc->string_desc_addr);
+
+		retval = 1;
+		break;
+	}
+
+	case USB_DT_STRING:
+		/* Write string descriptor */
+		c67x00_ll_write_mem_le16(udc->sie->dev, udc->string_desc_addr,
+					 req->req.buf, req->req.length);
+
+		/* set address to end of this descriptor */
+		udc->string_desc_addr += req->req.length;
+
+		retval = 1;
+		break;
+	}
+
+	return retval;
+}
+
+/*
+ * done - retire a request; caller blocked irqs
+ */
+static void c67x00_udc_done(struct c67x00_udc_ep *ep,
+			    struct c67x00_request *req, int status)
+{
+	int stopped = ep->stopped;
+
+	list_del_init(&req->queue);
+
+	if (likely(req->req.status == -EINPROGRESS))
+		req->req.status = status;
+	else
+		status = req->req.status;
+/*
+	if (status && status != -ESHUTDOWN)
+		DBG(DBG_VERBOSE, "complete %s req %p stat %d len %u/%u\n",
+			ep->ep.name, &req->req, status,
+			req->req.actual, req->req.length);
+*/
+
+	/* don't modify queue heads during completion callback */
+	ep->stopped = 1;
+	req->req.complete(&ep->ep, &req->req);
+	ep->stopped = stopped;
+}
+
+/*----------- UDC send/receive functions -------------------------------------*/
+
+static void c67x00_udc_start_io_irq(struct c67x00_udc_ep *ep)
+{
+	struct c67x00_sie *sie = ep->udc->sie;
+	struct c67x00_request *req =
+		list_entry(ep->queue.next, struct c67x00_request, queue);
+
+	if (ep->is_ep_in)
+		c67x00_ll_susb_start_send(sie, ep->ep_num,
+					  req->req.buf, req->req.length);
+	else
+		c67x00_ll_susb_start_receive(sie, ep->ep_num, req->req.length);
+}
+
+static void c67x00_udc_io_work(struct work_struct *_udc)
+{
+	int i = 0;
+	struct c67x00_udc *udc =
+	    container_of(_udc, struct c67x00_udc, io_work);
+
+	for (i = 0; i < C67X00_MAX_NB_END_POINTS; i++) {
+		struct c67x00_udc_ep *ep = &udc->ep[i];
+		if (ep->start_io) {
+			ep->start_io = 0;
+			c67x00_udc_start_io_irq(ep);
+		}
+	}
+}
+
+static void c67x00_udc_schedule_io_irq(struct c67x00_udc_ep *ep)
+{
+	ep->start_io = 1;
+
+	/* start work queue */
+	schedule_work(&ep->udc->io_work);
+}
+
+static void c67x00_udc_done_irq(struct c67x00_udc_ep *ep, int status)
+{
+	struct c67x00_request *req;
+	struct c67x00_sie *sie = ep->udc->sie;
+	int result;
+
+	result = c67x00_ll_susb_get_transfer_status(sie, ep->ep_num);
+	if (result < 0) {
+		dev_err(sie_dev(sie), "udc_done_irq error (%d)\n", result);
+		return;
+	}
+
+	if (unlikely(list_empty(&ep->queue)))
+		return;
+
+	req = list_entry(ep->queue.next, struct c67x00_request, queue);
+
+	req->req.actual = req->req.length - result;
+
+	if (!ep->is_ep_in && ep->ep_num != 0)
+		c67x00_ll_susb_receive(sie, ep->ep_num,
+				       req->req.buf, req->req.actual);
+
+	c67x00_udc_done(ep, req, 0);
+	if (!list_empty(&ep->queue) && !ep->stopped)
+		/* restart io req */
+		c67x00_udc_schedule_io_irq(ep);
+}
+
+/* -------------------------------------------------------------------------- */
+/* endpoints */
+
+static const char *c67x00_ep_name[C67X00_MAX_NB_END_POINTS] = {
+	"ep0", "ep1out-bulk", "ep2in-bulk", "ep3", "ep4", "ep5", "ep6", "ep7"
+};
+
+
+/* -------------------------------------------------------------------------- */
+/* ep opts */
+
+/*
+ * empties entire endpoint queue
+ */
+static void c67x00_nuke_ep(struct c67x00_udc_ep *ep, int status)
+{
+	ep->stopped = 1;
+
+	while (!list_empty(&ep->queue)) {
+		struct c67x00_request *req =
+			list_entry(ep->queue.next, struct c67x00_request,
+				   queue);
+		c67x00_udc_done(ep, req, status);
+	}
+}
+
+static int c67x00_ep_enable(struct usb_ep *_ep,
+			    const struct usb_endpoint_descriptor *desc)
+{
+	struct c67x00_udc_ep *ep;
+	struct c67x00_sie *sie;
+	u16 maxpacket;
+
+	ep = container_of(_ep, struct c67x00_udc_ep, ep);
+	sie = ep->udc->sie;
+
+	maxpacket = le16_to_cpu(desc->wMaxPacketSize);
+
+	c67x00_ll_set_device_ep_status(sie, ep->ep_num, 0x0000);
+
+	if (desc->bEndpointAddress & USB_DIR_IN) {
+		ep->is_ep_in = 1;
+		c67x00_ll_set_ep_ctrl_reg(sie, ep->ep_num,
+					  EP_ENABLE | DIR_SEL_IN);
+		c67x00_ll_set_ep_packet_size_reg(sie, ep->ep_num, maxpacket);
+	} else {
+		ep->is_ep_in = 0;
+		c67x00_ll_set_ep_ctrl_reg(sie, ep->ep_num, EP_ENABLE);
+		c67x00_ll_set_ep_packet_size_reg(sie, ep->ep_num, maxpacket);
+	}
+
+	ep->enable = 1;
+	ep->stopped = 0;
+	ep->ep.maxpacket = maxpacket;
+
+	return 0;
+}
+
+static int c67x00_ep_disable(struct usb_ep *_ep)
+{
+	unsigned long flags;
+	struct c67x00_udc_ep *ep;
+
+	ep = container_of(_ep, struct c67x00_udc_ep, ep);
+
+	dev_dbg(sie_dev(ep->udc->sie), "ep_disable %s\n", _ep->name);
+
+	spin_lock_irqsave(&ep->udc->lock, flags);
+
+	ep->enable = 0;
+	ep->stopped = 1;
+
+	c67x00_nuke_ep(ep, -ESHUTDOWN);
+
+	spin_unlock_irqrestore(&ep->udc->lock, flags);
+
+	return 0;
+}
+
+
+struct usb_request *c67x00_ep_alloc_request(struct usb_ep *_ep,
+					    gfp_t gfp_flags)
+{
+	struct c67x00_request *req;
+
+	req = kzalloc(sizeof(struct c67x00_request), gfp_flags);
+	if (!req)
+		return NULL;
+
+	INIT_LIST_HEAD(&req->queue);
+	return &req->req;
+}
+
+static void c67x00_ep_free_request(struct usb_ep *_ep,
+				   struct usb_request *_req)
+{
+	struct c67x00_request *req = NULL;
+	struct c67x00_udc_ep *ep;
+
+	ep = container_of(_ep, struct c67x00_udc_ep, ep);
+	dev_dbg(sie_dev(ep->udc->sie), "free_request %s\n", _ep->name);
+
+	req = container_of(_req, struct c67x00_request, req);
+
+	if (_req)
+		kfree(req);
+}
+
+static int c67x00_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
+			   gfp_t gfp_flags)
+{
+	struct c67x00_udc_ep *ep;
+	struct c67x00_request *req;
+	unsigned long flags;
+	int request = 0;
+	struct c67x00_udc *dev;
+
+	req = container_of(_req, struct c67x00_request, req);
+	if (unlikely
+	    (!_req || !_req->complete || !_req->buf
+	     || !list_empty(&req->queue))) {
+		printk(KERN_WARNING "bad params\n");
+		return -EINVAL;
+	}
+
+	ep = container_of(_ep, struct c67x00_udc_ep, ep);
+	if (unlikely(!_ep)) {
+		dev_warn(sie_dev(ep->udc->sie), "bad ep\n");
+		return -EINVAL;
+	}
+
+	dev = ep->udc;
+	if (unlikely
+	    (!dev->driver || dev->gadget.speed == USB_SPEED_UNKNOWN)) {
+		dev_warn(sie_dev(ep->udc->sie), "bogus device state\n");
+		return -ESHUTDOWN;
+	}
+
+	if (ep->ep_num == 0) {
+		/* The gadget driver returns the descriptors through this way */
+		if (!c67x00_udc_parse_descriptor(dev, req)) {
+			req->req.actual = req->req.length;
+			return -EINVAL;
+		} else {
+			req->req.status = 0;
+			req->req.actual = req->req.length;
+			req->req.complete(&ep->ep, &req->req);
+			return 0;
+		}
+
+	}
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	_req->status = -EINPROGRESS;
+	_req->actual = 0;
+
+	/* Start I/O queue if the list was empty */
+	if (list_empty(&ep->queue) && !ep->stopped)
+		request = 1;
+
+	/* Add the request to the queue of the endpoint */
+	list_add_tail(&req->queue, &ep->queue);
+
+	if (request)
+		c67x00_udc_schedule_io_irq(ep);
+
+	spin_unlock_irqrestore(&dev->lock, flags);
+
+	return 0;
+}
+
+
+static int c67x00_ep_dequeue(struct usb_ep *_ep, struct usb_request *_req)
+{
+	struct c67x00_udc_ep *ep;
+	struct c67x00_request *req;
+	unsigned long flags;
+
+	ep = container_of(_ep, struct c67x00_udc_ep, ep);
+	if (!_ep || ep->ep_num == 0)
+		return -EINVAL;
+
+	dev_dbg(sie_dev(ep->udc->sie), "dequeue %s\n", _ep->name);
+
+	spin_lock_irqsave(&ep->udc->lock, flags);
+
+	/* make sure it's actually queued on this endpoint */
+	list_for_each_entry(req, &ep->queue, queue) {
+		if (&req->req == _req)
+			break;
+	}
+	if (&req->req != _req) {
+		spin_unlock_irqrestore(&ep->udc->lock, flags);
+		return -EINVAL;
+	}
+
+	c67x00_udc_done(ep, req, -ECONNRESET);
+
+	spin_unlock_irqrestore(&ep->udc->lock, flags);
+	return 0;
+}
+
+
+
+static int c67x00_ep_set_halt(struct usb_ep *_ep, int value)
+{
+	printk(KERN_WARNING "c67x00-udc : ep set_halt %s\n", _ep->name);
+	return -ENODEV;
+}
+
+static void c67x00_ep_fifo_flush(struct usb_ep *_ep)
+{
+	printk(KERN_WARNING "c67x00-udc : ep fifo_flush %s\n", _ep->name);
+}
+
+
+static const struct usb_ep_ops c67x00_ep_ops = {
+	.enable = c67x00_ep_enable,
+	.disable = c67x00_ep_disable,
+
+	.alloc_request = c67x00_ep_alloc_request,
+	.free_request = c67x00_ep_free_request,
+
+	.queue = c67x00_ep_queue,
+	.dequeue = c67x00_ep_dequeue,
+
+	.set_halt = c67x00_ep_set_halt,
+	.fifo_flush = c67x00_ep_fifo_flush,
+};
+
+/* -------------------------------------------------------------------------- */
+
+void c67x00_udc_msg_received(struct c67x00_sie *sie, u16 msg)
+{
+	struct c67x00_udc *udc = sie->private_data;
+	u16 EPx_msg_mask = /*SUSB_EP0_MSG | */ SUSB_EP1_MSG
+		| SUSB_EP2_MSG
+		| SUSB_EP3_MSG
+		| SUSB_EP4_MSG
+		| SUSB_EP5_MSG
+		| SUSB_EP6_MSG
+		| SUSB_EP7_MSG;
+
+	if ((msg & EPx_msg_mask) != 0) {
+		int i, mask = 0x01;
+
+		for (i = 0; i < C67X00_MAX_NB_END_POINTS; i++, mask <<= 1)
+			if (msg & mask)
+				c67x00_udc_done_irq(&udc->ep[i], 0);
+	}
+
+	if (msg & SUSB_RST_MSG) {
+		int i;
+		dev_dbg(sie_dev(sie),
+			 "udc_msg_rec (0x%04X) : SUSB_RST_MSG\n", msg);
+
+		for (i = 0; i < C67X00_MAX_NB_END_POINTS; i++) {
+			struct c67x00_udc_ep *ep = &udc->ep[i];
+			if (i != 0 && ep->enable) {
+				ep->stopped = 1;
+				c67x00_nuke_ep(ep, -ESHUTDOWN);
+			}
+		}
+		if (udc->driver && udc->driver->disconnect)
+			udc->driver->disconnect(&udc->gadget);
+	}
+
+	if (msg & SUSB_SOF_MSG) {
+		dev_dbg(sie_dev(sie),
+			 "udc_msg_rec (0x%04X) : SUSB_SOF_MSG\n", msg);
+	}
+
+	if (msg & SUSB_CFG_MSG) {
+		dev_dbg(sie_dev(sie),
+			 "udc_msg_rec (0x%04X) : SUSB_CFG_MSG\n", msg);
+		/* the c67x00 BIOS only supports 1 configuration,
+		   so it must be configuration 1 */
+		c67x00_udc_set_configuration(sie, udc->config_nr);
+	}
+
+	if (msg & SUSB_SUS_MSG) {
+		dev_dbg(sie_dev(sie),
+			 "udc_msg_rec (0x%04X) : SUSB_SUS_MSG\n", msg);
+	}
+
+	if (msg & SUSB_ID_MSG) {
+		dev_dbg(sie_dev(sie),
+			 "udc_msg_rec (0x%04X) : SUSB_ID_MSG\n", msg);
+	}
+
+	if (msg & SUSB_VBUS_MSG) {
+		dev_dbg(sie_dev(sie),
+			 "udc_msg_rec (0x%04X) : SUSB_VBUS_MSG\n", msg);
+	}
+}
+
+
+/*
+ * This function is called from the interrupt handler in c67x00-drv.c
+ */
+static void c67x00_udc_irq(struct c67x00_sie *sie, u16 int_status, u16 msg)
+{
+	u16 device_status;
+
+	if (msg)
+		c67x00_udc_msg_received(sie, msg);
+
+	device_status = c67x00_ll_usb_get_status(sie);
+
+	if (int_status & SOFEOP_FLG(sie->sie_num))
+		c67x00_ll_usb_clear_status(sie, SOF_EOP_IRQ_FLG);
+
+	if (int_status & RESET_FLG(sie->sie_num)) {
+		dev_info(sie_dev(sie), "sie%d : reset IRQ\n",
+			 sie->sie_num);
+
+		/* Handle reset here */
+		c67x00_ll_usb_clear_status(sie, RESET_IRQ_FLG);
+	}
+
+	if (int_status & DONE_FLG(sie->sie_num))
+		dev_info(sie_dev(sie), "sie%d : done IRQ -> "
+			 "device status 0x%04X\n",
+			 sie->sie_num, device_status);
+}
+
+
+int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+{
+	struct c67x00_udc *udc = &controller;
+	int i, retval;
+
+	if (!driver
+/*		|| driver->speed < USB_SPEED_FULL*/
+	    || !driver->bind || !driver->setup) {
+
+		printk(KERN_ERR
+		       "c67x00 : invalid gadget driver provided\n");
+		return -EINVAL;
+	}
+
+
+	spin_lock(&udc->lock);
+	if (!udc->sie || udc->driver) {
+		spin_unlock(&udc->lock);
+		return -EBUSY;
+	}
+
+	udc->driver = driver;
+	udc->gadget.dev.driver = &driver->driver;
+	udc->config_nr = 1;
+	udc->top_str_id = 0;
+	device_add(&udc->gadget.dev);
+
+	driver->driver.bus = NULL;
+
+	dev_dbg(sie_dev(udc->sie), "Binding %s to SIE%d\n",
+		 driver->function, udc->sie->sie_num);
+
+	retval = driver->bind(&udc->gadget);
+	if (retval) {
+		dev_warn(sie_dev(udc->sie), "Driver bind failed\n");
+		goto error;
+	}
+
+	/* retrieve descriptors from gadget and program them in device */
+	udc->driver->setup(&udc->gadget,
+			   (struct usb_ctrlrequest *)
+			   get_descriptor_device);
+	udc->driver->setup(&udc->gadget,
+			   (struct usb_ctrlrequest *)
+			   get_descriptor_config);
+
+	for (i = 0; i <= udc->top_str_id; i++) {
+		get_descriptor_string[2] = i;
+		udc->driver->setup(&udc->gadget,
+				   (struct usb_ctrlrequest *)
+				   get_descriptor_string);
+	}
+
+	spin_unlock(&udc->lock);
+
+	/* enable device */
+	c67x00_ll_susb_init(udc->sie);
+
+	return 0;
+
+error :
+	udc->driver = NULL;
+	udc->gadget.dev.driver = NULL;
+	device_del(&udc->gadget.dev);
+
+	spin_unlock(&udc->lock);
+
+	return retval;
+}
+EXPORT_SYMBOL(usb_gadget_register_driver);
+
+int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
+{
+	struct c67x00_udc *udc = &controller;
+
+	printk(KERN_WARNING "c67x00-udc : usb_gadget_unregister_driver\n");
+
+	spin_lock(&udc->lock);
+	if (udc->driver != driver) {
+		spin_unlock(&udc->lock);
+		return -EINVAL;
+	}
+
+	udc->driver = NULL;
+
+	driver->unbind(&udc->gadget);
+	device_del(&udc->gadget.dev);
+
+	c67x00_ll_susb_disable(udc->sie);
+
+	spin_unlock(&udc->lock);
+	return 0;
+}
+EXPORT_SYMBOL(usb_gadget_unregister_driver);
+
+/* -------------------------------------------------------------------------- */
+
+int c67x00_udc_probe(struct c67x00_sie *sie)
+{
+	struct c67x00_udc *udc = &controller;
+	unsigned long flags;
+	int i;
+
+	if (udc->sie) {
+		dev_err(sie_dev(sie),
+			"Only 1 peripheral port supported, check sie_config\n");
+		return -EBUSY;
+	}
+
+	spin_lock_init(&udc->lock);
+	INIT_WORK(&udc->io_work, c67x00_udc_io_work);
+	INIT_LIST_HEAD(&udc->gadget.ep_list);
+
+	udc->gadget.ep0 = &udc->ep[0].ep;
+	INIT_LIST_HEAD(&udc->gadget.ep0->ep_list);
+	for (i = 0; i < C67X00_MAX_NB_END_POINTS; i++) {
+		struct c67x00_udc_ep *ep = &udc->ep[i];
+		if (i != 0) {
+			INIT_LIST_HEAD(&udc->ep[i].ep.ep_list);
+			list_add_tail(&udc->ep[i].ep.ep_list,
+				      &udc->gadget.ep_list);
+		}
+		ep->ep.name = c67x00_ep_name[i];
+		ep->ep.ops = &c67x00_ep_ops;
+		ep->enable = 0;
+		ep->start_io = 0;
+		if (i == 0)
+			ep->ep.maxpacket = 8;
+		else
+			/* Size is set when endpoint is enabled */
+			ep->ep.maxpacket = 512;
+		ep->ep_num = i;
+		ep->udc = udc;
+		INIT_LIST_HEAD(&ep->queue);
+	}
+
+	udc->sie = sie;
+	udc->gadget.dev.parent = &sie->dev->pdev->dev;
+	device_initialize(&udc->gadget.dev);
+
+	spin_lock_irqsave(&sie->lock, flags);
+	sie->private_data = udc;
+	sie->irq = c67x00_udc_irq;
+	spin_unlock_irqrestore(&sie->lock, flags);
+
+	return 0;
+}
+
+void c67x00_udc_remove(struct c67x00_sie *sie)
+{
+	struct c67x00_udc *udc = sie->private_data;
+
+	if (!udc) {
+		dev_err(sie_dev(sie), "No udc found!\n");
+		return;
+	}
+
+	/* gadget driver must not be registered */
+	BUG_ON(udc->driver != NULL);
+
+	spin_lock(&udc->lock);
+	sie->private_data = NULL;
+	udc->sie = NULL;
+	spin_unlock(&udc->lock);
+}
Index: linux-2.6/drivers/usb/c67x00/c67x00-udc.h
===================================================================
--- /dev/null
+++ linux-2.6/drivers/usb/c67x00/c67x00-udc.h
@@ -0,0 +1,50 @@
+/*
+ * c67x00-udc.h: Cypress C67X00 USB device controller
+ *
+ * Copyright (C) 2006-2008 Barco N.V.
+ *    Derived from the Cypress cy7c67200/300 ezusb linux driver and
+ *    based on multiple device controller drivers inside the linux kernel.
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
+#ifndef _USB_C67X00_UDC_H
+#define _USB_C67X00_UDC_H
+
+#include <linux/kernel.h>
+
+#include "c67x00.h"
+
+#ifdef CONFIG_USB_GADGET_C67X00
+/* Functions used by drv */
+int c67x00_udc_probe(struct c67x00_sie *sie);
+void c67x00_udc_remove(struct c67x00_sie *sie);
+
+#else
+static inline int c67x00_udc_probe(struct c67x00_sie *sie)
+{
+	printk(KERN_ERR "udc requested but CONFIG_USB_GADGET_C67X00 "
+	       "not enabled!\n");
+	return -ENODEV;
+}
+
+static inline void c67x00_udc_remove(struct c67x00_sie *sie)
+{
+}
+
+#endif				/* CONFIG_USB_GADGET_C67X00 */
+
+#endif				/* _USB_C67X00_UDC_H */
Index: linux-2.6/drivers/usb/c67x00/c67x00-drv.c
===================================================================
--- linux-2.6.orig/drivers/usb/c67x00/c67x00-drv.c
+++ linux-2.6/drivers/usb/c67x00/c67x00-drv.c
@@ -42,6 +42,7 @@
 
 #include "c67x00.h"
 #include "c67x00-hcd.h"
+#include "c67x00-udc.h"
 
 static void c67x00_probe_sie(struct c67x00_sie *sie,
 			     struct c67x00_device *dev, int sie_num)
@@ -56,6 +57,11 @@
 		c67x00_hcd_probe(sie);
 		break;
 
+	case C67X00_SIE_PERIPHERAL_A:
+	case C67X00_SIE_PERIPHERAL_B:
+		c67x00_udc_probe(sie);
+		break;
+
 	case C67X00_SIE_UNUSED:
 		dev_info(sie_dev(sie),
 			 "Not using SIE %d as requested\n", sie->sie_num);
@@ -76,6 +82,11 @@
 		c67x00_hcd_remove(sie);
 		break;
 
+	case C67X00_SIE_PERIPHERAL_A:
+	case C67X00_SIE_PERIPHERAL_B:
+		c67x00_udc_remove(sie);
+		break;
+
 	default:
 		break;
 	}
Index: linux-2.6/drivers/usb/c67x00/c67x00-ll-hpi.c
===================================================================
--- linux-2.6.orig/drivers/usb/c67x00/c67x00-ll-hpi.c
+++ linux-2.6/drivers/usb/c67x00/c67x00-ll-hpi.c
@@ -393,6 +393,190 @@
 }
 
 /* -------------------------------------------------------------------------- */
+void c67x00_ll_susb_init(struct c67x00_sie *sie)
+{
+	struct c67x00_device *dev = sie->dev;
+	struct lcp_int_data data;
+	u16 addr;
+	int rc;
+
+	/* The BIOS SUSB_INIT_INT handler for some reason is hardcoded to only
+	   enable peripheral support for port A. Relocate the routine to RAM
+	   and patch out that instruction (mov [r10-0xe],[r8]) */
+	addr = hpi_read_word(dev, SUSB_INIT_INT_LOC);
+
+	/* already patched? */
+	if (addr != CY_UDC_BIOS_REPLACE_BASE) {
+		u16 buf[64]; /* should be plenty for the handler */
+		int i;
+
+		c67x00_ll_read_mem_le16(dev, addr, buf, sizeof(buf));
+
+		/* patch it */
+		for (i = 0; i < (ARRAY_SIZE(buf)-1); i++) {
+			if ((buf[i] == cpu_to_le16(0x0432))
+			    && (buf[i+1] == cpu_to_le16(0xfff2))) {
+				buf[i] = buf[i+1] = 0; /* nop */
+				break;
+			}
+		}
+
+		if (i >= ARRAY_SIZE(buf))
+			dev_warn(sie_dev(sie), "BIOS code not recognized, "
+				 "port B may not be available\n");
+
+		c67x00_ll_write_mem_le16(dev, CY_UDC_BIOS_REPLACE_BASE,
+					 buf, sizeof(buf));
+		hpi_write_word(dev, SUSB_INIT_INT_LOC,
+			       CY_UDC_BIOS_REPLACE_BASE);
+	}
+
+	hpi_clear_bits(dev, HPI_IRQ_ROUTING_REG,
+		       SOFEOP_TO_HPI_EN(sie->sie_num));
+	hpi_set_bits(dev,
+		     HPI_IRQ_ROUTING_REG,
+		     SOFEOP_TO_CPU_EN(sie->sie_num)
+		     | RESUME_TO_HPI_ENABLE(sie->sie_num)
+		     | ID_TO_HPI_ENABLE | VBUS_TO_HPI_ENABLE);
+
+	hpi_set_bits(dev,
+		     DEVICE_N_IRQ_EN_REG(sie->sie_num),
+		     SOF_EOP_TMOUT_IRQ_EN | ID_IRQ_EN | VBUS_IRQ_EN);
+
+	hpi_clear_bits(dev,
+		       USB_CTL_REG(sie->sie_num),
+		       SOF_EOP_EN(0) | SOF_EOP_EN(1));
+
+	if (sie->mode == C67X00_SIE_PERIPHERAL_A)
+		hpi_write_word(dev, DEVICE_N_PORT_SEL(sie->sie_num),  0x0000);
+	else
+		hpi_write_word(dev, DEVICE_N_PORT_SEL(sie->sie_num),  0x4000);
+
+	data.regs[1] = 0; /* full speed */
+	data.regs[2] = sie->sie_num + 1;
+	rc = c67x00_comm_exec_int(dev, SUSB_INIT_INT, &data);
+
+	if ((hpi_read_word(sie->dev, USB_CTL_REG(sie->sie_num)) & HOST_MODE))
+		dev_warn(sie_dev(sie),
+			 "SIE %d not set to peri mode\n", sie->sie_num);
+
+	BUG_ON(rc); /* No return path for error code; crash spectacularly */
+
+	hpi_set_bits(dev,
+		     DEVICE_N_IRQ_EN_REG(sie->sie_num),
+		     SOF_EOP_TMOUT_IRQ_EN | ID_IRQ_EN | VBUS_IRQ_EN);
+
+	dev_info(sie_dev(sie),
+		 "Peripheral USB device setup on SIE%d\n",
+		 sie->sie_num);
+}
+
+void c67x00_ll_susb_disable(struct c67x00_sie *sie)
+{
+	hpi_write_word(sie->dev, DEVICE_N_IRQ_EN_REG(sie->sie_num), 0);
+	hpi_write_word(sie->dev, USB_CTL_REG(sie->sie_num),  0x0000);
+}
+
+u16 c67x00_ll_get_device_ep_status(struct c67x00_sie *sie, int ep)
+{
+	return hpi_read_word(sie->dev,
+			     DEVICE_N_ENDPOINT_N_STAT_REG(sie->sie_num, ep));
+}
+
+void c67x00_ll_set_device_ep_status(struct c67x00_sie *sie,
+				    int ep, u16 value)
+{
+	hpi_write_word(sie->dev,
+		       DEVICE_N_ENDPOINT_N_STAT_REG(sie->sie_num, ep),
+		       value);
+}
+
+void c67x00_ll_set_device_descriptor_location(struct c67x00_sie *sie,
+					      u16 address)
+{
+	hpi_write_word(sie->dev, SUSBx_DEV_DESC_VEC(sie->sie_num), address);
+}
+
+void c67x00_ll_set_configuration_descriptor_location(struct c67x00_sie *sie,
+						     u16 address)
+{
+	hpi_write_word(sie->dev, SUSBx_CONF_DESC_VEC(sie->sie_num), address);
+}
+
+void c67x00_ll_set_string_descriptor_location(struct c67x00_sie *sie,
+					      u16 address)
+{
+	hpi_write_word(sie->dev, SUSBx_STRING_DESC_VEC(sie->sie_num), address);
+}
+
+int c67x00_ll_susb_start_send(struct c67x00_sie *sie, int ep,
+			      void *data, int len)
+{
+	u16 header[4];
+	struct lcp_int_data regs;
+
+	c67x00_ll_write_mem_le16(sie->dev, CY_UDC_REQ_BUFFER_ADDR(ep),
+				 data, len);
+
+	header[0] = 0;
+	header[1] = cpu_to_le16(CY_UDC_REQ_BUFFER_ADDR(ep));
+	header[2] = cpu_to_le16(len);
+	header[3] = 0;
+
+	c67x00_ll_write_mem_le16(sie->dev, CY_UDC_REQ_HEADER_ADDR(ep), header,
+				 sizeof(header));
+
+	regs.regs[0] = 0;
+	regs.regs[1] = ep;
+	regs.regs[8] = CY_UDC_REQ_HEADER_ADDR(ep);
+
+	return c67x00_comm_exec_int(sie->dev, SUSBx_SEND_INT(sie->sie_num),
+				    &regs);
+}
+
+int c67x00_ll_susb_start_receive(struct c67x00_sie *sie, int ep, int len)
+{
+	u16 header[4];
+	struct lcp_int_data regs;
+
+	header[0] = 0;
+	header[1] = cpu_to_le16(CY_UDC_REQ_BUFFER_ADDR(ep));
+	header[2] = cpu_to_le16(len);
+	header[3] = 0;
+
+	c67x00_ll_write_mem_le16(sie->dev, CY_UDC_REQ_HEADER_ADDR(ep), header,
+				 sizeof(header));
+
+	regs.regs[0] = 0;
+	regs.regs[1] = ep;
+	regs.regs[8] = CY_UDC_REQ_HEADER_ADDR(ep);
+
+	return c67x00_comm_exec_int(sie->dev, SUSBx_RECEIVE_INT(sie->sie_num),
+				    &regs);
+}
+
+int c67x00_ll_susb_get_transfer_status(struct c67x00_sie *sie, int ep)
+{
+	u16 header[4];
+	u16 result = c67x00_get_comm_reg(sie->dev, 0);
+
+	if (result)
+		return -result;
+
+	c67x00_ll_read_mem_le16(sie->dev, CY_UDC_REQ_HEADER_ADDR(ep),
+				header, sizeof(header));
+	/* nr of bytes not transferred */
+	return le16_to_cpu(header[2]);
+}
+
+void c67x00_ll_susb_receive(struct c67x00_sie *sie, int ep,
+			    void *data, int len)
+{
+	c67x00_ll_read_mem_le16(sie->dev, CY_UDC_REQ_BUFFER_ADDR(ep),
+				data, len);
+}
+
+/* -------------------------------------------------------------------------- */
 
 void c67x00_ll_irq(struct c67x00_device *dev, u16 int_status)
 {
Index: linux-2.6/drivers/usb/c67x00/c67x00.h
===================================================================
--- linux-2.6.orig/drivers/usb/c67x00/c67x00.h
+++ linux-2.6/drivers/usb/c67x00/c67x00.h
@@ -287,6 +287,24 @@
 void c67x00_ll_husb_init_host_port(struct c67x00_sie *sie);
 void c67x00_ll_husb_reset_port(struct c67x00_sie *sie, int port);
 
+/* Slave specific functions */
+void c67x00_ll_susb_init(struct c67x00_sie *sie);
+void c67x00_ll_susb_disable(struct c67x00_sie *sie);
+u16 c67x00_ll_get_device_ep_status(struct c67x00_sie *sie, int ep);
+void c67x00_ll_set_device_ep_status(struct c67x00_sie *sie, int ep, u16 value);
+void c67x00_ll_set_device_descriptor_location(struct c67x00_sie *sie,
+					      u16 address);
+void c67x00_ll_set_configuration_descriptor_location(struct c67x00_sie *sie,
+						     u16 address);
+void c67x00_ll_set_string_descriptor_location(struct c67x00_sie *sie,
+					      u16 address);
+int c67x00_ll_susb_start_send(struct c67x00_sie *sie, int ep,
+			      void *data, int len);
+int c67x00_ll_susb_start_receive(struct c67x00_sie *sie, int ep, int len);
+int c67x00_ll_susb_get_transfer_status(struct c67x00_sie *sie, int ep);
+void c67x00_ll_susb_receive(struct c67x00_sie *sie, int ep,
+			    void *data, int len);
+
 /* Called by c67x00_irq to handle lcp interrupts */
 void c67x00_ll_irq(struct c67x00_device *dev, u16 int_status);
 
Index: linux-2.6/drivers/usb/c67x00/Makefile
===================================================================
--- linux-2.6.orig/drivers/usb/c67x00/Makefile
+++ linux-2.6/drivers/usb/c67x00/Makefile
@@ -6,6 +6,9 @@
 	EXTRA_CFLAGS		+= -DDEBUG
 endif
 
-obj-$(CONFIG_USB_C67X00_HCD)	+= c67x00.o
+obj-$(CONFIG_USB_C67X00_DRV)	+= c67x00.o
 
-c67x00-objs := c67x00-drv.o c67x00-ll-hpi.o c67x00-hcd.o c67x00-sched.o
+c67x00-y			+= c67x00-drv.o c67x00-ll-hpi.o
+
+c67x00-$(CONFIG_USB_C67X00_HCD) += c67x00-hcd.o c67x00-sched.o
+c67x00-$(CONFIG_USB_GADGET_C67X00)	+= c67x00-udc.o
Index: linux-2.6/drivers/usb/gadget/Kconfig
===================================================================
--- linux-2.6.orig/drivers/usb/gadget/Kconfig
+++ linux-2.6/drivers/usb/gadget/Kconfig
@@ -324,6 +324,13 @@
 	depends on USB_GADGET_AT91
 	default USB_GADGET
 
+config USB_GADGET_C67X00
+	boolean "Cypress C67X00 Gadget support"
+	depends on USB_C67X00_DRV
+	select USB_GADGET_SELECTED
+	help
+	  This enables the gadget functionality of the Cypress C67X00.
+
 config USB_GADGET_DUMMY_HCD
 	boolean "Dummy HCD (DEVELOPMENT)"
 	depends on (USB=y || (USB=m && USB_GADGET=m)) && EXPERIMENTAL
Index: linux-2.6/drivers/usb/gadget/gadget_chips.h
===================================================================
--- linux-2.6.orig/drivers/usb/gadget/gadget_chips.h
+++ linux-2.6/drivers/usb/gadget/gadget_chips.h
@@ -147,6 +147,12 @@
 #define	gadget_is_m66592(g)	0
 #endif
 
+#ifdef CONFIG_USB_GADGET_C67X00
+#define	gadget_is_c67x00(g)	!strcmp("c67x00_udc", (g)->name)
+#else
+#define	gadget_is_c67x00(g)	0
+#endif
+
 
 // CONFIG_USB_GADGET_SX2
 // CONFIG_USB_GADGET_AU1X00
@@ -212,5 +218,7 @@
 		return 0x20;
 	else if (gadget_is_m66592(gadget))
 		return 0x21;
+	else if (gadget_is_c67x00(gadget))
+		return 0x22;
 	return -ENOENT;
 }
Index: linux-2.6/drivers/usb/host/Kconfig
===================================================================
--- linux-2.6.orig/drivers/usb/host/Kconfig
+++ linux-2.6/drivers/usb/host/Kconfig
@@ -261,15 +261,3 @@
 	  To compile this driver as a module, choose M here: the
 	  module will be called r8a66597-hcd.
 
-config USB_C67X00_HCD
-	tristate "Cypress C67x00 HCD support"
-	depends on USB
-	help
-	  The Cypress C67x00 (EZ-Host/EZ-OTG) chips are dual-role
-	  host/peripheral/OTG USB controllers.
-
-	  Enable this option to support this chip in host controller mode.
-	  If unsure, say N.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called c67x00.
Index: linux-2.6/drivers/usb/Makefile
===================================================================
--- linux-2.6.orig/drivers/usb/Makefile
+++ linux-2.6/drivers/usb/Makefile
@@ -17,7 +17,7 @@
 obj-$(CONFIG_USB_U132_HCD)	+= host/
 obj-$(CONFIG_USB_R8A66597_HCD)	+= host/
 
-obj-$(CONFIG_USB_C67X00_HCD)	+= c67x00/
+obj-$(CONFIG_USB_C67X00_DRV)	+= c67x00/
 
 obj-$(CONFIG_USB_ACM)		+= class/
 obj-$(CONFIG_USB_PRINTER)	+= class/
Index: linux-2.6/drivers/usb/Kconfig
===================================================================
--- linux-2.6.orig/drivers/usb/Kconfig
+++ linux-2.6/drivers/usb/Kconfig
@@ -91,6 +91,8 @@
 
 source "drivers/usb/host/Kconfig"
 
+source "drivers/usb/c67x00/Kconfig"
+
 source "drivers/usb/class/Kconfig"
 
 source "drivers/usb/storage/Kconfig"
Index: linux-2.6/drivers/usb/c67x00/Kconfig
===================================================================
--- /dev/null
+++ linux-2.6/drivers/usb/c67x00/Kconfig
@@ -0,0 +1,21 @@
+#
+# Cypress C67x00 USB controller
+#
+config USB_C67X00_DRV
+	tristate "Cypress C67x00 support"
+	# only allowed to be =y if both USB!=m and USB_GADGET!=m
+	depends on (!USB && USB_GADGET) || (!USB_GADGET && USB) || (USB && USB_GADGET)
+	help
+	  The Cypress C67x00 (EZ-Host/EZ-OTG) chips are dual-role
+	  host/peripheral USB controllers.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called c67x00.
+
+config USB_C67X00_HCD
+	bool "Cypress C67X00 HCD support"
+	depends on USB && USB_C67X00_DRV
+	default y
+	help
+	  Enable this option to support the Cypress C67x00 in host
+	  controller mode.

--
Bye, Peter Korsgaard
