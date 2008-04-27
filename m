Return-Path: <jacmet@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.190])
	by ozlabs.org (Postfix) with ESMTP id B7B85DDE22
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Apr 2008 17:02:59 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id g16so2706379nfd.9
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Apr 2008 00:02:58 -0700 (PDT)
Message-Id: <20080427070232.262001938@sunsite.dk>
References: <20080427065942.514492739@sunsite.dk>
Date: Sun, 27 Apr 2008 08:59:46 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: dbrownell@users.sourceforge.net, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, greg@kroah.com
Subject: [patch v11 4/4] USB: add Cypress c67x00 OTG controller gadget driver
Sender: Peter Korsgaard <jacmet@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
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
 drivers/usb/c67x00/c67x00-hcd.h    |   13 
 drivers/usb/c67x00/c67x00-ll-hpi.c |  204 ++++++
 drivers/usb/c67x00/c67x00-udc.c    | 1167 +++++++++++++++++++++++++++++++++++++
 drivers/usb/c67x00/c67x00-udc.h    |   48 +
 drivers/usb/c67x00/c67x00.h        |  107 ++-
 drivers/usb/gadget/Kconfig         |    7 
 drivers/usb/gadget/gadget_chips.h  |    8 
 drivers/usb/host/Kconfig           |   13 
 13 files changed, 1561 insertions(+), 49 deletions(-)

Index: linux-2.6/drivers/usb/c67x00/c67x00-udc.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/usb/c67x00/c67x00-udc.c
@@ -0,0 +1,1167 @@
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
+#include <linux/proc_fs.h>
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
+/* ep0 transfer state */
+#define WAIT_FOR_SETUP          0
+#define DATA_STATE_XMIT         1
+#define DATA_STATE_NEED_ZLP     2
+#define WAIT_FOR_OUT_STATUS     3
+#define DATA_STATE_RECV         4
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
+	int datatoggle;
+	int xfer_size;
+	/* could add descriptors here */
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
+	/* The highest string descriptor entry
+	   (used to retrieve descriptors from gadget driver) */
+	int connected;
+	int device_address;
+	int set_address;
+	int ep0_state;
+	int ep0_dir;
+	struct usb_ctrlrequest local_setup_buff;
+	struct c67x00_request *status_req;
+};
+
+
+/* ------------------------------------------------------------------------- */
+/* gadget ops */
+
+static int c67x00_get_frame(struct usb_gadget *_gadget)
+{
+	printk(KERN_DEBUG "c67x00-udc: c67x00_get_frame\n");
+	return -ENODEV;
+}
+
+static int c67x00_wakeup(struct usb_gadget *_gadget)
+{
+	printk(KERN_DEBUG "c67x00-udc: c67x00_wakeup\n");
+	return -ENODEV;
+}
+
+static int c67x00_selfpowered(struct usb_gadget *_gadget,
+			      int is_selfpowered)
+{
+	printk(KERN_DEBUG "c67x00-udc: c67x00_selfpowered\n");
+	return -ENODEV;
+}
+
+static int c67x00_vbus_session(struct usb_gadget *_gadget, int is_active)
+{
+	printk(KERN_DEBUG "c67x00-udc: c67x00_vbus_session\n");
+	return -ENODEV;
+}
+
+static int c67x00_pullup(struct usb_gadget *_gadget, int is_on)
+{
+	printk(KERN_DEBUG "c67x00-udc: c67x00_pullup\n");
+	return -ENODEV;
+}
+
+static const struct usb_gadget_ops c67x00_udc_ops = {
+	.get_frame = c67x00_get_frame,
+	.wakeup = c67x00_wakeup,
+	.set_selfpowered = c67x00_selfpowered,
+	.vbus_session = c67x00_vbus_session,
+	.pullup = c67x00_pullup
+};
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
+/*-------------------------------------------------------------------------
+		PROC File System Support
+-------------------------------------------------------------------------*/
+#ifdef CONFIG_USB_GADGET_DEBUG_FILES
+
+#include <linux/seq_file.h>
+
+static const char proc_filename[] = "driver/c67x00_udc";
+
+static int c67x00_proc_read(char *page, char **start, off_t off, int count,
+		int *eof, void *_dev)
+{
+	char *buf = page;
+	char *next = buf;
+	unsigned size = count;
+	unsigned long flags;
+	int t;
+	struct c67x00_udc *udc = &controller;
+
+	spin_lock_irqsave(&udc->lock, flags);
+
+	/* ------basic driver infomation ---- */
+	t = scnprintf(next, size, udc->connected ? "active\n" : "Inactive\n"));
+	size -= t;
+	next += t;
+
+	spin_unlock_irqrestore(&udc->lock, flags);
+
+	*eof = 1;
+	return count - size;
+}
+
+#define create_proc_file()	create_proc_read_entry(proc_filename, \
+				0, NULL, c67x00_proc_read, NULL)
+
+#define remove_proc_file()	remove_proc_entry(proc_filename, NULL)
+
+#else				/* !CONFIG_USB_GADGET_DEBUG_FILES */
+
+#define create_proc_file()	do {} while (0)
+#define remove_proc_file()	do {} while (0)
+
+#endif				/* CONFIG_USB_GADGET_DEBUG_FILES */
+
+
+/*----------------------------------------------------------------------------*/
+
+static void c67x00_udc_set_address(struct c67x00_udc *udc, u16 address)
+{
+	udc->device_address = address;
+	c67x00_ll_susb_set_addres(udc->sie, address);
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
+
+	/* don't modify queue heads during completion callback */
+	ep->stopped = 1;
+	if (req->req.complete)
+		req->req.complete(&ep->ep, &req->req);
+	ep->stopped = stopped;
+}
+
+/*----------- UDC send/receive functions -------------------------------------*/
+
+static void c67x00_udc_start_io_irq(struct c67x00_udc_ep *ep)
+{
+	int length;
+	struct c67x00_sie *sie = ep->udc->sie;
+	struct c67x00_request *req =
+		list_entry(ep->queue.next, struct c67x00_request, queue);
+
+	if ((ep->is_ep_in && ep->ep_num != 0)
+	    || (ep->ep_num == 0 && ep->udc->ep0_dir == USB_DIR_IN)) {
+
+		if (req->req.length - req->req.actual > ep->ep.maxpacket)
+			length = ep->ep.maxpacket;
+		else
+			length = req->req.length - req->req.actual;
+
+		c67x00_ll_susb_start_send(sie, ep->ep_num,
+			req->req.buf + req->req.actual, length, ep->datatoggle);
+		ep->datatoggle = ((ep->datatoggle == 0)?1:0);
+		ep->xfer_size = length;
+
+		req->req.actual += length; /* TODO move to udc_done_irq */
+	} else {
+		if (req->req.length - req->req.actual > ep->ep.maxpacket)
+			length = ep->ep.maxpacket;
+		else
+			length = req->req.length - req->req.actual;
+
+		c67x00_ll_susb_start_receive(sie, ep->ep_num, length);
+		ep->xfer_size = length;
+	}
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
+/* Set protocol stall on ep0, protocol stall will automatically be cleared
+   on new transaction */
+static void ep0stall(struct c67x00_udc *udc)
+{
+	c67x00_ll_set_ep_stall(udc->sie, 0);
+	udc->ep0_state = WAIT_FOR_SETUP;
+	udc->ep0_dir = USB_DIR_OUT;
+}
+
+/* Prime a status phase for ep0 */
+static int ep0_prime_status(struct c67x00_udc *udc, int direction)
+{
+	struct c67x00_request *req = udc->status_req;
+	struct c67x00_udc_ep *ep;
+	int status = 0;
+	int request = 0;
+
+	if (direction == USB_DIR_IN)
+		udc->ep0_dir = USB_DIR_IN;
+	else
+		udc->ep0_dir = USB_DIR_OUT;
+
+	ep = &udc->ep[0];
+	udc->ep0_state = WAIT_FOR_OUT_STATUS;
+
+	if (direction == USB_DIR_IN)
+		ep->is_ep_in = 1;
+	else
+		ep->is_ep_in = 0;
+
+	req->req.length = 0;
+	req->req.status = -EINPROGRESS;
+	req->req.actual = 0;
+	req->req.complete = NULL;
+
+	/* Start I/O queue if the list was empty */
+	if (list_empty(&ep->queue) /*&& !ep->stopped*/)
+		request = 1;
+
+	/* Add the request to the queue of the endpoint */
+	list_add_tail(&req->queue, &ep->queue);
+
+	if (request) {
+		dev_dbg(sie_dev(ep->udc->sie), "prime - schedule work\n");
+		c67x00_udc_schedule_io_irq(ep);
+	}
+
+	return status;
+}
+
+static void ep0_req_complete(struct c67x00_udc *udc,
+			     struct c67x00_udc_ep *ep0,
+			     struct c67x00_request *req)
+{
+	if (udc->set_address) {
+		/* Set the new address */
+		c67x00_udc_set_address(udc, udc->device_address);
+		udc->set_address = 0;
+	}
+
+	c67x00_udc_done(ep0, req, 0);
+
+	switch (udc->ep0_state) {
+	case DATA_STATE_XMIT:
+		/* receive status phase */
+		if (ep0_prime_status(udc, USB_DIR_OUT))
+			ep0stall(udc);
+		break;
+	case DATA_STATE_RECV:
+		/* send status phase */
+		if (ep0_prime_status(udc, USB_DIR_IN))
+			ep0stall(udc);
+		break;
+	case WAIT_FOR_OUT_STATUS:
+		udc->ep0_state = WAIT_FOR_SETUP;
+		break;
+	case WAIT_FOR_SETUP:
+		break;
+	default:
+		ep0stall(udc);
+		break;
+	}
+}
+
+static void c67x00_udc_done_irq(struct c67x00_udc_ep *ep, int status)
+{
+	struct c67x00_request *req;
+	struct c67x00_sie *sie = ep->udc->sie;
+	struct c67x00_udc *udc = ep->udc;
+
+	if (unlikely(list_empty(&ep->queue)))
+		return;
+
+	req = list_entry(ep->queue.next, struct c67x00_request, queue);
+
+	if (status == 0) {
+		if ((!ep->is_ep_in && ep->ep_num != 0)
+		    || (ep->ep_num == 0 && udc->ep0_dir == USB_DIR_OUT)) {
+			int cnt_result = c67x00_ll_get_device_ep_count_result(
+				sie, ep->ep_num);
+			int length = 0;
+			length = (ep->xfer_size - cnt_result);
+
+			if (length > 0) {
+				c67x00_ll_susb_receive(sie, ep->ep_num,
+					req->req.buf + req->req.actual, length);
+				req->req.actual += length;
+			}
+
+			if (ep->ep_num == 0
+			    && req->req.actual < req->req.length) {
+				c67x00_udc_schedule_io_irq(ep);
+				return;
+			}
+		} else {
+			if (req->req.actual < req->req.length) {
+				c67x00_udc_schedule_io_irq(ep);
+				return;
+			}
+		}
+	}
+
+	if (ep->ep_num == 0)
+		ep0_req_complete(udc, ep, req);
+	else {
+		c67x00_udc_done(ep, req, 0);
+		if (!list_empty(&ep->queue) && !ep->stopped)
+			/* restart io req */
+			c67x00_udc_schedule_io_irq(ep);
+	}
+
+}
+
+/* -------------------------------------------------------------------------- */
+/* endpoints */
+
+static const char *c67x00_ep_name[C67X00_MAX_NB_END_POINTS] = {
+	"ep0", "ep1", "ep2", "ep3", "ep4", "ep5", "ep6", "ep7"
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
+	if (ep->ep_num == 0)
+		ep->udc->ep0_state = DATA_STATE_XMIT;
+
+	spin_lock_irqsave(&dev->lock, flags);
+
+	_req->status = -EINPROGRESS;
+	_req->actual = 0;
+
+	/* Start I/O queue if the list was empty */
+	if (list_empty(&ep->queue) /*&& !ep->stopped*/)
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
+static int c67x00_ep_set_halt(struct usb_ep *_ep, int value)
+{
+	printk(KERN_WARNING "c67x00-udc: ep set_halt %s\n", _ep->name);
+	return -ENODEV;
+}
+
+static void c67x00_ep_fifo_flush(struct usb_ep *_ep)
+{
+	printk(KERN_WARNING "c67x00-udc: ep fifo_flush %s\n", _ep->name);
+}
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
+/*
+ * ch9 Get status
+ */
+static void ch9getstatus(struct c67x00_udc *udc, u8 request_type, u16 value,
+			 u16 index, u16 length)
+{
+	u16 tmp = 0;		/* Status, cpu endian */
+
+	struct c67x00_request *req;
+	struct c67x00_udc_ep *ep;
+	int request = 0;
+
+	ep = &udc->ep[0];
+
+	if ((request_type & USB_RECIP_MASK) == USB_RECIP_DEVICE) {
+		/* Get device status */
+		tmp = 1 << USB_DEVICE_SELF_POWERED;
+		dev_dbg(sie_dev(udc->sie),
+				 "get status device\n");
+	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_INTERFACE) {
+		/* Get interface status */
+		/* We don't have interface information in udc driver */
+		tmp = 0;
+		dev_dbg(sie_dev(udc->sie),
+				 "get status interface\n");
+	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_ENDPOINT) {
+		/* Get endpoint status */
+		tmp = 0;
+		dev_dbg(sie_dev(udc->sie),
+				 "get status ep\n");
+
+	}
+
+	udc->ep0_dir = USB_DIR_IN;
+	/* Borrow the per device status_req */
+	req = udc->status_req;
+	/* Fill in the reqest structure */
+	*((u16 *) req->req.buf) = cpu_to_le16(tmp);
+	req->req.length = 2;
+	req->req.status = -EINPROGRESS;
+	req->req.actual = 0;
+	req->req.complete = NULL;
+
+	/* prime the data phase */
+	/* Start I/O queue if the list was empty */
+	if (list_empty(&ep->queue) /*&& !ep->stopped*/)
+		request = 1;
+
+	/* Add the request to the queue of the endpoint */
+	list_add_tail(&req->queue, &ep->queue);
+
+	if (request) {
+		dev_dbg(sie_dev(ep->udc->sie), "prime - schedule work\n");
+		c67x00_udc_schedule_io_irq(ep);
+	}
+	udc->ep0_state = DATA_STATE_XMIT;
+	return;
+}
+
+static void setup_received_irq(struct c67x00_udc *udc)
+{
+	struct usb_ctrlrequest *setup = &udc->local_setup_buff;
+	u16 wValue = le16_to_cpu(setup->wValue);
+	u16 wIndex = le16_to_cpu(setup->wIndex);
+	u16 wLength = le16_to_cpu(setup->wLength);
+
+	c67x00_nuke_ep(&udc->ep[0], -ESHUTDOWN);
+
+	udc->ep[0].datatoggle = 1;
+
+	/* We process some stardard setup requests here */
+	switch (setup->bRequest) {
+	case USB_REQ_GET_STATUS:
+		/* Data+Status phase from udc */
+		if ((setup->bRequestType & (USB_DIR_IN | USB_TYPE_MASK))
+					!= (USB_DIR_IN | USB_TYPE_STANDARD))
+			break;
+		ch9getstatus(udc, setup->bRequestType, wValue, wIndex, wLength);
+		return;
+	case USB_REQ_SET_ADDRESS:
+		/* Status phase from udc */
+		if (setup->bRequestType != (USB_DIR_OUT | USB_TYPE_STANDARD
+						| USB_RECIP_DEVICE))
+			break;
+		udc->device_address = wValue;
+		udc->set_address = 1;
+
+		/* Status phase */
+		if (ep0_prime_status(udc, USB_DIR_IN))
+			ep0stall(udc);
+
+		return;
+#if 0 /* TODO add support */
+	case USB_REQ_CLEAR_FEATURE:
+	case USB_REQ_SET_FEATURE:
+		/* Status phase from udc */
+	{
+		int rc = -EOPNOTSUPP;
+
+		if ((setup->bRequestType & (USB_RECIP_MASK | USB_TYPE_MASK))
+				== (USB_RECIP_ENDPOINT | USB_TYPE_STANDARD)) {
+
+			if (wValue != 0 || wLength != 0 || pipe > udc->max_ep)
+				break;
+		} else if ((setup->bRequestType & (USB_RECIP_MASK
+				| USB_TYPE_MASK)) == (USB_RECIP_DEVICE
+				| USB_TYPE_STANDARD)) {
+			/* Note: The driver has not include OTG support yet.
+			 * This will be set when OTG support is added */
+			if (!gadget_is_otg(&udc->gadget))
+				break;
+			else if (setup->bRequest == USB_DEVICE_B_HNP_ENABLE)
+				udc->gadget.b_hnp_enable = 1;
+			else if (setup->bRequest == USB_DEVICE_A_HNP_SUPPORT)
+				udc->gadget.a_hnp_support = 1;
+			else if (setup->bRequest ==
+					USB_DEVICE_A_ALT_HNP_SUPPORT)
+				udc->gadget.a_alt_hnp_support = 1;
+			else
+				break;
+			rc = 0;
+		} else
+			break;
+
+		if (rc == 0) {
+			if (ep0_prime_status(udc, USB_DIR_IN))
+				ep0stall(udc);
+		}
+		return;
+	}
+#endif
+	default:
+		break;
+	}
+
+	/* Requests handled by gadget */
+	if (wLength) {
+		/* Data phase from gadget, status phase from udc */
+		udc->ep0_dir = (setup->bRequestType & USB_DIR_IN)
+				?  USB_DIR_IN : USB_DIR_OUT;
+		spin_unlock(&udc->lock);
+		if (udc->driver && udc->driver->setup
+		    && udc->driver->setup(&udc->gadget,
+					  &udc->local_setup_buff) < 0)
+			ep0stall(udc);
+
+		spin_lock(&udc->lock);
+		udc->ep0_state = (setup->bRequestType & USB_DIR_IN)
+				?  DATA_STATE_XMIT : DATA_STATE_RECV;
+	} else {
+		/* No data phase, IN status from gadget */
+		udc->ep0_dir = USB_DIR_IN;
+		spin_unlock(&udc->lock);
+		if (udc->driver->setup(&udc->gadget,
+				       &udc->local_setup_buff) < 0) {
+			ep0stall(udc);
+		}
+		spin_lock(&udc->lock);
+		udc->ep0_state = WAIT_FOR_OUT_STATUS;
+	}
+}
+
+static void c67x00_udc_ep_irq(struct c67x00_sie *sie, int ep)
+{
+	struct c67x00_udc *udc = &controller;
+	u16 ep_status = c67x00_ll_get_device_ep_status(sie, ep);
+	int status = 0;
+
+	if (ep_status & EP_IRQ_FLG_SETUP) {
+		dev_dbg(sie_dev(sie),
+				 "EP%d FLG_SETUP\n", ep);
+
+		c67x00_ll_susb_get_setup_data(sie, &udc->local_setup_buff);
+
+#if 0
+/* Only for outputting debug info -> setup is handled in setup_received_irq */
+		switch (udc->local_setup_buff.bRequestType & USB_TYPE_MASK) {
+		case USB_TYPE_STANDARD:
+			switch (udc->local_setup_buff.bRequest) {
+			case USB_REQ_GET_STATUS :
+				dev_dbg(sie_dev(sie),
+						 "GET_STATUS\n");
+
+				break;
+
+			case USB_REQ_CLEAR_FEATURE :
+				dev_dbg(sie_dev(sie),
+						 "CLEAR_FEATURE\n");
+
+				break;
+
+			case USB_REQ_SET_FEATURE :
+				dev_dbg(sie_dev(sie),
+						 "SET_FEATURE\n");
+
+				break;
+
+			case USB_REQ_SET_ADDRESS :
+				dev_dbg(sie_dev(sie),
+						 "SET_ADDRESS\n");
+
+				break;
+
+			case USB_REQ_GET_DESCRIPTOR :
+				dev_dbg(sie_dev(sie),
+						 "GET_DESCRIPTOR\n");
+
+				break;
+
+			case USB_REQ_SET_DESCRIPTOR :
+				dev_dbg(sie_dev(sie),
+						 "SET_DESCRIPTOR\n");
+
+				break;
+
+			case USB_REQ_GET_CONFIGURATION :
+				dev_dbg(sie_dev(sie),
+						 "GET_CONFIGURATION\n");
+
+				break;
+
+			case USB_REQ_SET_CONFIGURATION :
+				dev_dbg(sie_dev(sie),
+						 "SET_CONFIGURATION\n");
+
+				break;
+
+			case USB_REQ_GET_INTERFACE :
+				dev_dbg(sie_dev(sie),
+						 "GET_INTERFACE\n");
+
+				break;
+
+			case USB_REQ_SET_INTERFACE :
+				dev_dbg(sie_dev(sie),
+						 "SET_INTERFACE\n");
+
+				break;
+
+			case USB_REQ_SYNCH_FRAME :
+				dev_dbg(sie_dev(sie),
+						 "SYNCH_FRAME\n");
+
+				break;
+			default:
+				dev_dbg(sie_dev(sie),
+						 "UNKNOWN request\n");
+				break;
+
+			}
+			break;
+
+		case USB_TYPE_CLASS:
+			dev_dbg(sie_dev(sie),
+					 "EP%d CLASS request\n", ep);
+			break;
+
+		case USB_TYPE_VENDOR:
+			dev_dbg(sie_dev(sie),
+					 "EP%d VENDOR request\n", ep);
+			break;
+
+		default:
+			dev_dbg(sie_dev(sie),
+					 "EP%d UNKNOWN request\n", ep);
+			break;
+
+		}
+#endif
+		setup_received_irq(udc);
+
+	} else 	if (ep_status & EP_IRQ_FLG_ERROR) {
+		dev_dbg(sie_dev(sie), "EP%d FLG_ERROR\n", ep);
+		/* TODO resend instead */
+	} else {
+#if 0
+		if (ep_status & EP_IRQ_FLG_ACK)
+			dev_dbg(sie_dev(sie), "EP%d FLG_ACK\n", ep);
+
+		if (ep_status & EP_IRQ_FLG_TIMEOUT)
+			dev_dbg(sie_dev(sie), "EP%d FLG_TIMEOUT\n", ep);
+
+		if (ep_status & EP_IRQ_FLG_LEN_EXCEP)
+			dev_dbg(sie_dev(sie), "EP%d FLG_LEN_EXCEP\n", ep);
+
+		if (ep_status & EP_IRQ_FLG_NACK)
+			dev_dbg(sie_dev(sie), "EP%d FLG_NACK\n", ep);
+
+		if (ep_status & EP_IRQ_FLG_STALL)
+			dev_dbg(sie_dev(sie), "EP%d FLG_STALL\n", ep);
+
+		if (ep_status & EP_IRQ_FLG_IN_EXCEP)
+			dev_dbg(sie_dev(sie), "EP%d FLG_IN_EXCEP\n", ep);
+
+		if (ep_status & EP_IRQ_FLG_OUT_EXCEP)
+			dev_dbg(sie_dev(sie), "EP%d FLG_OUT_EXCEP\n", ep);
+
+		if (ep_status & EP_IRQ_FLG_UNDERFLOW)
+			dev_dbg(sie_dev(sie), "EP%d FLG_UNDERFLOW\n", ep);
+
+		if (ep_status & EP_IRQ_FLG_OVERFLOW)
+			dev_dbg(sie_dev(sie), "EP%d FLG_OVERFLOW\n", ep);
+#endif
+
+		c67x00_udc_done_irq(&udc->ep[ep], status);
+	}
+}
+
+/*
+ * This function is called from the interrupt handler in c67x00-drv.c
+ */
+static void c67x00_udc_irq(struct c67x00_sie *sie, u16 int_status, u16 msg)
+{
+	u16 device_status;
+	unsigned long flags = 0;
+	struct c67x00_udc *udc = sie->private_data;
+
+	spin_lock_irqsave(&udc->lock, flags);
+
+	device_status = c67x00_ll_usb_get_status(sie);
+
+	if (int_status & SOFEOP_FLG(sie->sie_num))
+		c67x00_ll_usb_clear_status(sie, SOF_EOP_IRQ_FLG);
+
+	if (int_status & RESET_FLG(sie->sie_num)) {
+		int i;
+
+		dev_dbg(sie_dev(sie), "sie%d: reset IRQ\n",
+			 sie->sie_num);
+
+		/* Handle reset here */
+		c67x00_ll_usb_clear_status(sie, RESET_IRQ_FLG);
+
+		for (i = 0; i < C67X00_MAX_NB_END_POINTS; i++) {
+			struct c67x00_udc_ep *ep = &udc->ep[i];
+			if (i != 0 && ep->enable) {
+				ep->stopped = 1;
+				c67x00_nuke_ep(ep, -ESHUTDOWN);
+			}
+			c67x00_ll_set_ep_ctrl_reg(sie, i,
+						  ((i == 0)?EP_ENABLE:0x00));
+		}
+
+		c67x00_udc_set_address(udc, 0);
+
+		if (udc->driver && udc->driver->disconnect)
+			udc->driver->disconnect(&udc->gadget);
+	}
+
+	if (int_status & DONE_FLG(sie->sie_num)) {
+		int i, mask = 0x01;
+		dev_dbg(sie_dev(sie), "sie%d: done IRQ -> "
+			"device status 0x%04X\n",
+			 sie->sie_num, device_status);
+
+		for (i = 0; i < C67X00_MAX_NB_END_POINTS; i++, mask <<= 1)
+			if (device_status & mask)
+				c67x00_udc_ep_irq(sie, i);
+
+		c67x00_ll_usb_clear_status(sie, device_status);
+
+	}
+	spin_unlock_irqrestore(&udc->lock, flags);
+}
+
+int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+{
+	struct c67x00_udc *udc = &controller;
+	int retval;
+
+	if (!driver || !driver->bind || !driver->setup) {
+		printk(KERN_ERR
+		       "c67x00-udc: invalid gadget driver provided\n");
+		return -EINVAL;
+	}
+
+	spin_lock(&udc->lock);
+	if (!udc->sie || udc->driver) {
+		spin_unlock(&udc->lock);
+		return -EBUSY;
+	}
+
+	udc->driver = driver;
+	udc->gadget.dev.driver = &driver->driver;
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
+	spin_unlock(&udc->lock);
+
+	/* enable device */
+	c67x00_ll_susb_init(udc->sie);
+
+	return 0;
+
+ error:
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
+	printk(KERN_WARNING "c67x00-udc: usb_gadget_unregister_driver\n");
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
+		INIT_LIST_HEAD(&udc->ep[i].ep.ep_list);
+		if (i != 0) {
+			list_add_tail(&udc->ep[i].ep.ep_list,
+				      &udc->gadget.ep_list);
+		}
+		ep->ep.name = c67x00_ep_name[i];
+		ep->ep.ops = &c67x00_ep_ops;
+		ep->enable = 0;
+		ep->stopped = 0;
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
+	udc->connected = 0;
+	udc->set_address = 0;
+	udc->status_req = container_of(
+		c67x00_ep_alloc_request(NULL, GFP_KERNEL),
+		struct c67x00_request, req);
+
+	device_initialize(&udc->gadget.dev);
+
+	spin_lock_irqsave(&sie->lock, flags);
+	sie->private_data = udc;
+	sie->irq = c67x00_udc_irq;
+	spin_unlock_irqrestore(&sie->lock, flags);
+
+	create_proc_file();
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
+	/* TODO free status_request member */
+	sie->private_data = NULL;
+	udc->sie = NULL;
+	spin_unlock(&udc->lock);
+}
Index: linux-2.6/drivers/usb/c67x00/c67x00-udc.h
===================================================================
--- /dev/null
+++ linux-2.6/drivers/usb/c67x00/c67x00-udc.h
@@ -0,0 +1,48 @@
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
@@ -54,9 +54,6 @@
 #define HUSB_SIE_INIT_INT(x)		((x) ? 0x0073 : 0x0072)
 #define HUSB_RESET_INT			0x0074
 
-#define SUSB_INIT_INT			0x0071
-#define SUSB_INIT_INT_LOC		(SUSB_INIT_INT * 2)
-
 /* -----------------------------------------------------------------------
  * HPI implementation
  *
@@ -296,6 +293,7 @@
 	return rc;
 }
 
+
 /* -------------------------------------------------------------------------- */
 /* Host specific functions */
 
@@ -372,6 +370,206 @@
 }
 
 /* -------------------------------------------------------------------------- */
+void c67x00_ll_susb_init(struct c67x00_sie *sie)
+{
+	struct c67x00_device *dev = sie->dev;
+
+	hpi_clear_bits(dev, HPI_IRQ_ROUTING_REG,
+		       SOFEOP_TO_CPU_EN(sie->sie_num));
+	hpi_set_bits(dev, HPI_IRQ_ROUTING_REG,
+		     SOFEOP_TO_HPI_EN(sie->sie_num)
+		     | RESUME_TO_HPI_ENABLE(sie->sie_num)
+		     | RESET_TO_HPI_ENABLE(sie->sie_num)
+		     | DONE_TO_HPI_ENABLE(sie->sie_num)
+		     | ID_TO_HPI_ENABLE | VBUS_TO_HPI_ENABLE);
+
+	hpi_set_bits(dev,
+		     DEVICE_N_IRQ_EN_REG(sie->sie_num),
+		     DEV_EP0_IRQ_EN
+		     | DEV_EP1_IRQ_EN
+		     | DEV_EP2_IRQ_EN
+		     | DEV_EP3_IRQ_EN
+		     | DEV_EP4_IRQ_EN
+		     | DEV_EP5_IRQ_EN
+		     | DEV_EP6_IRQ_EN
+		     | DEV_EP7_IRQ_EN
+		     | DEV_RESET_IRQ_EN
+		     | DEV_SOF_EOP_IRQ_EN
+		     | DEV_SOF_TMOUT_IRQ_EN
+		     | DEV_ID_IRQ_EN
+		     | DEV_VBUS_IRQ_EN);
+
+	hpi_clear_bits(dev,
+		       USB_CTL_REG(sie->sie_num),
+		       SOF_EOP_EN(0) | SOF_EOP_EN(1));
+
+	if (sie->mode == C67X00_SIE_PERIPHERAL_A)
+		hpi_write_word(dev, DEVICE_N_PORT_SEL(sie->sie_num),
+			       PERIPHERAL_PORT_A);
+	else
+		hpi_write_word(dev, DEVICE_N_PORT_SEL(sie->sie_num),
+			       PERIPHERAL_PORT_B);
+
+	/* Clear endpoint0 status register register */
+	hpi_write_word(sie->dev,
+		       DEVICE_N_ENDPOINT_N_STAT_REG(sie->sie_num, 0), 0);
+	/* Clear address register */
+	hpi_write_word(sie->dev, DEVICE_N_ADDRESS(sie->sie_num), 0);
+	/* Clear the interrupts */
+	hpi_write_word(sie->dev, USB_STAT_REG(sie->sie_num), 0xFFFF);
+	/* reset SOF/EOP time-out counter */
+	hpi_write_word(sie->dev,
+		       DEVICE_N_SOF_EOP_COUNT_REG(sie->sie_num), 0x3138);
+
+	hpi_set_bits(dev,
+		     USB_CTL_REG(sie->sie_num),
+		     SOF_EOP_EN(0) | SOF_EOP_EN(1)
+		     | PORT_RES_EN(0) | PORT_RES_EN(1));
+
+	hpi_set_bits(sie->dev, HW_IRQ_EN_REG,
+		     HOST_DEVICE_x_IRQ_EN(sie->sie_num));
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
+void c67x00_ll_set_ep_ctrl_reg(struct c67x00_sie *sie, int ep_num, u16 val)
+{
+	hpi_write_word(sie->dev,
+		       DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep_num), val);
+}
+
+void c67x00_ll_set_ep_stall(struct c67x00_sie *sie, int ep_num)
+{
+	hpi_set_bits(sie->dev,
+		     DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep_num),
+		     EP_CTRL_STALL_ENABLE);
+}
+
+void c67x00_ll_set_ep_packet_size_reg(struct c67x00_sie *sie, int ep_num,
+				      u16 val)
+{
+	/* This undocumented register needs to be set to the packet size
+	   Normally the BIOS sets this correctly when it is able to parse
+	   the configuration descriptor correctly */
+	hpi_write_word(sie->dev,
+		       (DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep_num)
+			+ 0x0A), val);
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
+u16 c67x00_ll_get_device_ep_count_result(struct c67x00_sie *sie, int ep)
+{
+	return hpi_read_word(sie->dev,
+			     DEVICE_N_ENDPOINT_N_COUNT_RESULT_REG(
+				     sie->sie_num, ep));
+}
+
+int c67x00_ll_susb_start_send(struct c67x00_sie *sie, int ep,
+			      void *data, int len, int data_toggle)
+{
+	dev_dbg(sie_dev(sie),
+		 "Send data on sie%d ep%d (len %d)\n", sie->sie_num, ep, len);
+
+	c67x00_ll_write_mem_le16(sie->dev, CY_UDC_REQ_BUFFER_ADDR(ep),
+				 data, len);
+
+	if (data_toggle)
+		hpi_set_bits(sie->dev,
+			     DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep),
+			     EP_CTRL_SEQ_SEL);
+	else
+		hpi_clear_bits(sie->dev,
+			       DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep),
+			       EP_CTRL_SEQ_SEL);
+
+	hpi_clear_bits(sie->dev, DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep),
+		       EP_CTRL_STALL_ENABLE);
+	hpi_set_bits(sie->dev, DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep),
+		     EP_CTRL_DIR_SEL);
+
+	hpi_write_word(sie->dev,
+		       DEVICE_N_ENDPOINT_N_ADDRESS_REG(sie->sie_num, ep),
+		       CY_UDC_REQ_BUFFER_ADDR(ep));
+	hpi_write_word(sie->dev,
+		       DEVICE_N_ENDPOINT_N_COUNT_REG(sie->sie_num, ep), len);
+	hpi_set_bits(sie->dev,
+		     DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep),
+		     EP_CTRL_ARM_EN);
+
+	return 0;
+}
+
+int c67x00_ll_susb_start_receive(struct c67x00_sie *sie, int ep, int len)
+{
+	dev_dbg(sie_dev(sie),
+		"Start receive data on sie%d ep%d (len %d)\n",
+		sie->sie_num, ep, len);
+
+	if (ep == 0)
+		hpi_set_bits(sie->dev,
+			     DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep),
+			     EP_CTRL_SEQ_SEL | EP_CTRL_ENABLE);
+
+	hpi_clear_bits(sie->dev,
+		       DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep),
+		       EP_CTRL_STALL_ENABLE);
+	hpi_clear_bits(sie->dev,
+		       DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep),
+		       EP_CTRL_DIR_SEL);
+	hpi_write_word(sie->dev,
+		       DEVICE_N_ENDPOINT_N_ADDRESS_REG(sie->sie_num, ep),
+		       CY_UDC_REQ_BUFFER_ADDR(ep));
+	hpi_write_word(sie->dev,
+		       DEVICE_N_ENDPOINT_N_COUNT_REG(sie->sie_num, ep), len);
+	hpi_set_bits(sie->dev,
+		     DEVICE_N_ENDPOINT_N_CTL_REG(sie->sie_num, ep),
+		     EP_CTRL_ARM_EN);
+	return 0;
+}
+
+void c67x00_ll_susb_receive(struct c67x00_sie *sie, int ep,
+			    void *data, int len)
+{
+	c67x00_ll_read_mem_le16(sie->dev, CY_UDC_REQ_BUFFER_ADDR(ep),
+				data, len);
+}
+
+
+void c67x00_ll_susb_get_setup_data(struct c67x00_sie *sie, void *data)
+{
+	c67x00_ll_read_mem_le16(sie->dev,
+				DEVICE_SETUP_PACKET_ADDRESS(sie->sie_num),
+				data, 8);
+}
+
+void c67x00_ll_susb_set_addres(struct c67x00_sie *sie, u16 address)
+{
+	hpi_write_word(sie->dev, DEVICE_N_ADDRESS(sie->sie_num),
+				address);
+}
+
+/* -------------------------------------------------------------------------- */
 
 void c67x00_ll_irq(struct c67x00_device *dev, u16 int_status)
 {
Index: linux-2.6/drivers/usb/c67x00/c67x00.h
===================================================================
--- linux-2.6.orig/drivers/usb/c67x00/c67x00.h
+++ linux-2.6/drivers/usb/c67x00/c67x00.h
@@ -35,6 +35,9 @@
 
 /* Hardware Revision Register */
 #define HW_REV_REG		0xC004
+#define HW_IRQ_EN_REG		0xC00E
+
+#define HOST_DEVICE_x_IRQ_EN(x) ((x) ? 0x0200 : 0x0100)
 
 /* General USB registers */
 /* ===================== */
@@ -50,18 +53,8 @@
 /* USB status register - Notice it has different content in hcd/udc mode */
 #define USB_STAT_REG(x)		((x) ? 0xC0B0 : 0xC090)
 
-#define EP0_IRQ_FLG		0x0001
-#define EP1_IRQ_FLG		0x0002
-#define EP2_IRQ_FLG		0x0004
-#define EP3_IRQ_FLG		0x0008
-#define EP4_IRQ_FLG		0x0010
-#define EP5_IRQ_FLG		0x0020
-#define EP6_IRQ_FLG		0x0040
-#define EP7_IRQ_FLG		0x0080
 #define RESET_IRQ_FLG		0x0100
 #define SOF_EOP_IRQ_FLG		0x0200
-#define ID_IRQ_FLG		0x4000
-#define VBUS_IRQ_FLG		0x8000
 
 /* USB Host only registers */
 /* ======================= */
@@ -78,9 +71,6 @@
 #define HOST_IRQ_EN_REG(x)	((x) ? 0xC0AC : 0xC08C)
 
 #define SOF_EOP_IRQ_EN		0x0200	/* SOF/EOP Interrupt Enable  */
-#define SOF_EOP_TMOUT_IRQ_EN	0x0800	/* SOF/EOP Timeout Interrupt Enable  */
-#define ID_IRQ_EN		0x4000	/* ID interrupt enable */
-#define VBUS_IRQ_EN		0x8000	/* VBUS interrupt enable */
 #define DONE_IRQ_EN		0x0001	/* Done Interrupt Enable  */
 
 /* USB status register */
@@ -99,18 +89,74 @@
 /* Device n Port Sel reg */
 #define DEVICE_N_PORT_SEL(x)	((x) ? 0xC0A4 : 0xC084)
 
+#define PERIPHERAL_PORT_A	0x0000
+#define PERIPHERAL_PORT_B	0x4000
+
 /* Device n Interrupt Enable Register */
 #define DEVICE_N_IRQ_EN_REG(x)	((x) ? 0xC0AC : 0xC08C)
 
+#define DEV_EP0_IRQ_EN		0x0001
+#define DEV_EP1_IRQ_EN		0x0002
+#define DEV_EP2_IRQ_EN		0x0004
+#define DEV_EP3_IRQ_EN		0x0008
+#define DEV_EP4_IRQ_EN		0x0010
+#define DEV_EP5_IRQ_EN		0x0020
+#define DEV_EP6_IRQ_EN		0x0040
+#define DEV_EP7_IRQ_EN		0x0080
+#define DEV_RESET_IRQ_EN	0x0100
+#define DEV_SOF_EOP_IRQ_EN	0x0200
+#define DEV_SOF_TMOUT_IRQ_EN	0x0800	/* SOF/EOP Timeout Interrupt Enable  */
+#define DEV_ID_IRQ_EN		0x4000
+#define DEV_VBUS_IRQ_EN		0x8000
+
+/* Endpoint control register */
 #define DEVICE_N_ENDPOINT_N_CTL_REG(dev, ep)	((dev)  		\
 						 ? (0x0280 + (ep << 4)) \
 						 : (0x0200 + (ep << 4)))
+#define EP_CTRL_ARM_EN		0x0001
+#define EP_CTRL_ENABLE		0X0002
+#define EP_CTRL_DIR_SEL		0x0004
+#define EP_CTRL_NACK_IRQ_EN	0x0008
+#define EP_CTRL_ISO_ENABLE	0x0010
+#define EP_CTRL_STALL_ENABLE	0x0020
+#define EP_CTRL_SEQ_SEL		0x0040
+#define EP_CTRL_IO_IGNORE	0x0080
+
+#define DEVICE_N_ENDPOINT_N_ADDRESS_REG(dev, ep) ((dev)  		\
+						 ? (0x0282 + (ep << 4)) \
+						 : (0x0202 + (ep << 4)))
+#define DEVICE_N_ENDPOINT_N_COUNT_REG(dev, ep)	((dev)  		\
+						 ? (0x0284 + (ep << 4)) \
+						 : (0x0204 + (ep << 4)))
 #define DEVICE_N_ENDPOINT_N_STAT_REG(dev, ep)	((dev)			\
 						 ? (0x0286 + (ep << 4)) \
 						 : (0x0206 + (ep << 4)))
+#define DEVICE_N_ENDPOINT_N_COUNT_RESULT_REG(dev, ep) ((dev)  		\
+						 ? (0x0288 + (ep << 4)) \
+						 : (0x0208 + (ep << 4)))
 
 #define DEVICE_N_ADDRESS(dev)	((dev) ? (0xC0AE) : (0xC08E))
 
+#define DEVICE_N_SOF_EOP_COUNT_REG(dev)	((dev) ? (0xC0B4) : (0xC094))
+
+#define DEVICE_SETUP_PACKET_ADDRESS(dev)	((dev) ? (0x0308) : (0x0300))
+
+
+#define EP_IRQ_FLG_ACK			0x0001
+#define EP_IRQ_FLG_ERROR		0x0002
+#define EP_IRQ_FLG_TIMEOUT		0x0004
+#define EP_IRQ_FLG_SEQ			0x0008
+#define EP_IRQ_FLG_SETUP		0x0010
+#define EP_IRQ_FLG_LEN_EXCEP	0x0020
+#define EP_IRQ_FLG_NACK			0x0040
+#define EP_IRQ_FLG_STALL		0x0080
+#define EP_IRQ_FLG_IN_EXCEP		0x0100
+#define EP_IRQ_FLG_OUT_EXCEP	0x0200
+#define EP_IRQ_FLG_UNDERFLOW	0x0400
+#define EP_IRQ_FLG_OVERFLOW		0x0800
+
+
+
 /* HPI registers */
 /* ============= */
 
@@ -159,13 +205,6 @@
 
 /* BIOS interrupt routines */
 
-#define SUSBx_RECEIVE_INT(x)	((x) ? 97 : 81)
-#define SUSBx_SEND_INT(x)	((x) ? 96 : 80)
-
-#define SUSBx_DEV_DESC_VEC(x)	((x) ? 0x00D4 : 0x00B4)
-#define SUSBx_CONF_DESC_VEC(x)	((x) ? 0x00D6 : 0x00B6)
-#define SUSBx_STRING_DESC_VEC(x) ((x) ? 0x00D8 : 0x00B8)
-
 #define CY_HCD_BUF_ADDR		0x500	/* Base address for host */
 #define SIE_TD_SIZE		0x200	/* size of the td list */
 #define SIE_TD_BUF_SIZE		0x400	/* size of the data buffer */
@@ -173,16 +212,6 @@
 #define SIE_TD_OFFSET(host)	((host) ? (SIE_TD_SIZE+SIE_TD_BUF_SIZE) : 0)
 #define SIE_BUF_OFFSET(host)	(SIE_TD_OFFSET(host) + SIE_TD_SIZE)
 
-/* Base address of HCD + 2 x TD_SIZE + 2 x TD_BUF_SIZE */
-#define CY_UDC_REQ_HEADER_BASE	0x1100
-/* 8- byte request headers for IN/OUT transfers */
-#define CY_UDC_REQ_HEADER_SIZE	8
-
-#define CY_UDC_REQ_HEADER_ADDR(ep_num)	(CY_UDC_REQ_HEADER_BASE + \
-					 ((ep_num) * CY_UDC_REQ_HEADER_SIZE))
-#define CY_UDC_DESC_BASE_ADDRESS	(CY_UDC_REQ_HEADER_ADDR(8))
-
-#define CY_UDC_BIOS_REPLACE_BASE	0x1800
 #define CY_UDC_REQ_BUFFER_BASE		0x2000
 #define CY_UDC_REQ_BUFFER_SIZE		0x0400
 #define CY_UDC_REQ_BUFFER_ADDR(ep_num)	(CY_UDC_REQ_BUFFER_BASE + \
@@ -283,6 +312,24 @@
 void c67x00_ll_husb_init_host_port(struct c67x00_sie *sie);
 void c67x00_ll_husb_reset_port(struct c67x00_sie *sie, int port);
 
+/* Slave specific functions */
+void c67x00_ll_susb_init(struct c67x00_sie *sie);
+void c67x00_ll_susb_disable(struct c67x00_sie *sie);
+void c67x00_ll_set_ep_ctrl_reg(struct c67x00_sie *sie, int ep_num, u16 val);
+void c67x00_ll_set_ep_stall(struct c67x00_sie *sie, int ep_num);
+void c67x00_ll_set_ep_packet_size_reg(struct c67x00_sie *sie, int ep_num,
+				      u16 val);
+u16 c67x00_ll_get_device_ep_status(struct c67x00_sie *sie, int ep);
+void c67x00_ll_set_device_ep_status(struct c67x00_sie *sie, int ep, u16 value);
+u16 c67x00_ll_get_device_ep_count_result(struct c67x00_sie *sie, int ep);
+int c67x00_ll_susb_start_send(struct c67x00_sie *sie, int ep,
+			      void *data, int len, int data_toggle);
+int c67x00_ll_susb_start_receive(struct c67x00_sie *sie, int ep, int len);
+void c67x00_ll_susb_receive(struct c67x00_sie *sie, int ep,
+			    void *data, int len);
+void c67x00_ll_susb_get_setup_data(struct c67x00_sie *sie, void *data);
+void c67x00_ll_susb_set_addres(struct c67x00_sie *sie, u16 address);
+
 /* Called by c67x00_irq to handle lcp interrupts */
 void c67x00_ll_irq(struct c67x00_device *dev, u16 int_status);
 
Index: linux-2.6/drivers/usb/c67x00/Makefile
===================================================================
--- linux-2.6.orig/drivers/usb/c67x00/Makefile
+++ linux-2.6/drivers/usb/c67x00/Makefile
@@ -4,6 +4,9 @@
 
 ccflags-$(CONFIG_USB_DEBUG)		+= -DDEBUG
 
-obj-$(CONFIG_USB_C67X00_HCD)		+= c67x00.o
+obj-$(CONFIG_USB_C67X00_DRV)		+= c67x00.o
 
-c67x00-objs := c67x00-drv.o c67x00-ll-hpi.o c67x00-hcd.o c67x00-sched.o
+c67x00-y				+= c67x00-drv.o c67x00-ll-hpi.o
+
+c67x00-$(CONFIG_USB_C67X00_HCD)		+= c67x00-hcd.o c67x00-sched.o
+c67x00-$(CONFIG_USB_GADGET_C67X00)	+= c67x00-udc.o
Index: linux-2.6/drivers/usb/gadget/Kconfig
===================================================================
--- linux-2.6.orig/drivers/usb/gadget/Kconfig
+++ linux-2.6/drivers/usb/gadget/Kconfig
@@ -335,6 +335,13 @@
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
 	depends on USB=y || (USB=m && USB_GADGET=m)
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
@@ -4,19 +4,6 @@
 comment "USB Host Controller Drivers"
 	depends on USB
 
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
-
 config USB_EHCI_HCD
 	tristate "EHCI HCD (USB 2.0) support"
 	depends on USB && USB_ARCH_HAS_EHCI
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
@@ -97,6 +97,8 @@
 
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
Index: linux-2.6/drivers/usb/c67x00/c67x00-hcd.h
===================================================================
--- linux-2.6.orig/drivers/usb/c67x00/c67x00-hcd.h
+++ linux-2.6/drivers/usb/c67x00/c67x00-hcd.h
@@ -112,8 +112,21 @@
  * Functions used by c67x00-drv
  */
 
+#ifdef CONFIG_USB_C67X00_HCD
 int c67x00_hcd_probe(struct c67x00_sie *sie);
 void c67x00_hcd_remove(struct c67x00_sie *sie);
+#else
+static inline int c67x00_hcd_probe(struct c67x00_sie *sie)
+{
+	printk(KERN_ERR "hcd requested but CONFIG_USB_C67X00_HCD "
+	       "not enabled!\n");
+	return -ENODEV;
+}
+
+static inline void c67x00_hcd_remove(struct c67x00_sie *sie)
+{
+}
+#endif				/* CONFIG_USB_C67X00_HCD */
 
 /* ---------------------------------------------------------------------
  * Transfer Descriptor scheduling functions

-- 
Bye, Peter Korsgaard
