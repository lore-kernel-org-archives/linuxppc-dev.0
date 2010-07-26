Return-Path: <fchen@apm.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EF2FEB6F14
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jul 2010 04:49:54 +1000 (EST)
From: Fushen Chen <fchen@apm.com>
To: linux-usb@vger.kernel.org
Subject: [PATCH 2/2 v1.03] Add support for DWC OTG PCD function.
Date: Mon, 26 Jul 2010 11:49:42 -0700
Message-Id: <12801701833351-git-send-email-fchen@apm.com>
In-Reply-To: <12801701823001-git-send-email-fchen@apm.com>
References: <12801701823001-git-send-email-fchen@apm.com>
Cc: linuxppc-dev@ozlabs.org, gregkh@suse.de, Mark Miesfeld <mmiesfeld@apm.com>,
	Fushen Chen <fchen@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds support for the USB peripheral controller on APM SoC using
Synopsys Designware IP.

Signed-off-by: Fushen Chen <fchen@apm.com>
Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
---
 drivers/usb/dwc_otg/dwc_otg_pcd.c      | 1748 ++++++++++++++++++++++++
 drivers/usb/dwc_otg/dwc_otg_pcd.h      |  149 +++
 drivers/usb/dwc_otg/dwc_otg_pcd_intr.c | 2270 ++++++++++++++++++++++++++++++++
 drivers/usb/gadget/Kconfig             |   21 +
 drivers/usb/gadget/gadget_chips.h      |    7 +
 5 files changed, 4195 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_pcd.c
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_pcd.h
 create mode 100644 drivers/usb/dwc_otg/dwc_otg_pcd_intr.c

diff --git a/drivers/usb/dwc_otg/dwc_otg_pcd.c b/drivers/usb/dwc_otg/dwc_otg_pcd.c
new file mode 100644
index 0000000..b817ca3
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_pcd.c
@@ -0,0 +1,1748 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+/*
+ * This file implements the Peripheral Controller Driver.
+ *
+ * The Peripheral Controller Driver (PCD) is responsible for
+ * translating requests from the Function Driver into the appropriate
+ * actions on the DWC_otg controller. It isolates the Function Driver
+ * from the specifics of the controller by providing an API to the
+ * Function Driver.
+ *
+ * The Peripheral Controller Driver for Linux will implement the
+ * Gadget API, so that the existing Gadget drivers can be used.
+ * (Gadget Driver is the Linux terminology for a Function Driver.)
+ *
+ * The Linux Gadget API is defined in the header file linux/usb/gadget.h. The
+ * USB EP operations API is defined in the structure usb_ep_ops and the USB
+ * Controller API is defined in the structure usb_gadget_ops
+ *
+ * An important function of the PCD is managing interrupts generated
+ * by the DWC_otg controller. The implementation of the DWC_otg device
+ * mode interrupt service routines is in dwc_otg_pcd_intr.c.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/delay.h>
+
+#include "dwc_otg_pcd.h"
+
+/*
+ * Static PCD pointer for use in usb_gadget_register_driver and
+ * usb_gadget_unregister_driver.  Initialized in dwc_otg_pcd_init.
+ */
+static struct dwc_pcd *s_pcd;
+
+static inline int need_stop_srp_timer(struct core_if *core_if)
+{
+	if (core_if->core_params->phy_type != DWC_PHY_TYPE_PARAM_FS ||
+			!core_if->core_params->i2c_enable)
+		return core_if->srp_timer_started ? 1 : 0;
+	return 0;
+}
+
+/**
+ * Tests if the module is set to FS or if the PHY_TYPE is FS. If so, then the
+ * gadget should not report as dual-speed capable.
+ */
+static inline int check_is_dual_speed(struct core_if *core_if)
+{
+	if (core_if->core_params->speed == DWC_SPEED_PARAM_FULL ||
+			(core_if->hwcfg2.b.hs_phy_type == 2 &&
+			core_if->hwcfg2.b.fs_phy_type == 1 &&
+			core_if->core_params->ulpi_fs_ls))
+		return 0;
+	return 1;
+}
+
+/**
+ * Tests if driver is OTG capable.
+ */
+static inline int check_is_otg(struct core_if *core_if)
+{
+	if (core_if->hwcfg2.b.op_mode ==
+			DWC_HWCFG2_OP_MODE_NO_SRP_CAPABLE_DEVICE ||
+			core_if->hwcfg2.b.op_mode ==
+			DWC_HWCFG2_OP_MODE_NO_SRP_CAPABLE_HOST ||
+			core_if->hwcfg2.b.op_mode ==
+			DWC_HWCFG2_OP_MODE_SRP_CAPABLE_DEVICE ||
+			core_if->hwcfg2.b.op_mode ==
+			DWC_HWCFG2_OP_MODE_SRP_CAPABLE_HOST)
+		return 0;
+	return 1;
+}
+
+/**
+ * This function completes a request. It calls the request call back.
+ */
+void request_done(struct pcd_ep *ep, struct pcd_request *req, int status)
+{
+	unsigned stopped = ep->stopped;
+
+	list_del_init(&req->queue);
+	if (req->req.status == -EINPROGRESS)
+		req->req.status = status;
+	else
+		status = req->req.status;
+
+	if (GET_CORE_IF(ep->pcd)->dma_enable) {
+		if (req->mapped) {
+			dma_unmap_single(ep->pcd->gadget.dev.parent,
+				req->req.dma, req->req.length,
+				ep->dwc_ep.is_in ? DMA_TO_DEVICE :
+				DMA_FROM_DEVICE);
+			req->req.dma = DMA_ADDR_INVALID;
+			req->mapped = 0;
+		} else {
+			dma_sync_single_for_cpu(ep->pcd->gadget.dev.parent,
+				req->req.dma, req->req.length,
+				ep->dwc_ep.is_in ? DMA_TO_DEVICE :
+				DMA_FROM_DEVICE);
+		}
+	}
+
+	/* don't modify queue heads during completion callback */
+	ep->stopped = 1;
+	spin_unlock(&ep->pcd->lock);
+	req->req.complete(&ep->ep, &req->req);
+	spin_lock(&ep->pcd->lock);
+
+	if (ep->pcd->request_pending > 0)
+		--ep->pcd->request_pending;
+	ep->stopped = stopped;
+
+	/*
+	 * Added-sr: 2007-07-26
+	 *
+	 * Finally, when the current request is done, mark this endpoint
+	 * as not active, so that new requests can be processed.
+	 */
+	if (dwc_has_feature(GET_CORE_IF(ep->pcd), DWC_LIMITED_XFER))
+		ep->dwc_ep.active = 0;
+}
+
+/**
+ * This function terminates all the requsts in the EP request queue.
+ */
+void request_nuke(struct pcd_ep *ep)
+{
+	struct pcd_request *req;
+
+	ep->stopped = 1;
+
+	/* called with irqs blocked?? */
+	while (!list_empty(&ep->queue)) {
+		req = list_entry(ep->queue.next, struct pcd_request, queue);
+		request_done(ep, req, -ESHUTDOWN);
+	}
+}
+
+/*
+ * The following sections briefly describe the behavior of the Gadget
+ * API endpoint operations implemented in the DWC_otg driver
+ * software. Detailed descriptions of the generic behavior of each of
+ * these functions can be found in the Linux header file
+ * include/linux/usb_gadget.h.
+ *
+ * The Gadget API provides wrapper functions for each of the function
+ * pointers defined in usb_ep_ops. The Gadget Driver calls the wrapper
+ * function, which then calls the underlying PCD function. The
+ * following sections are named according to the wrapper
+ * functions. Within each section, the corresponding DWC_otg PCD
+ * function name is specified.
+ *
+ */
+
+/**
+ * This function assigns periodic Tx FIFO to an periodic EP in shared Tx FIFO
+ * mode
+ */
+static u32 assign_perio_tx_fifo(struct core_if *core_if)
+{
+	u32 mask = 1;
+	u32 i;
+
+	for (i = 0; i < core_if->hwcfg4.b.num_dev_perio_in_ep; ++i) {
+		if (!(mask & core_if->p_tx_msk)) {
+			core_if->p_tx_msk |= mask;
+			return i + 1;
+		}
+		mask <<= 1;
+	}
+	return 0;
+}
+
+/**
+ * This function releases periodic Tx FIFO in shared Tx FIFO mode
+ */
+static void release_perio_tx_fifo(struct core_if *core_if, u32 fifo_num)
+{
+	core_if->p_tx_msk = (core_if->p_tx_msk & (1 << (fifo_num - 1)))
+				^ core_if->p_tx_msk;
+}
+
+/**
+ * This function assigns periodic Tx FIFO to an periodic EP in shared Tx FIFO
+ * mode
+ */
+static u32 assign_tx_fifo(struct core_if *core_if)
+{
+	u32 mask = 1;
+	u32 i;
+
+	for (i = 0; i < core_if->hwcfg4.b.num_in_eps; ++i) {
+		if (!(mask & core_if->tx_msk)) {
+			core_if->tx_msk |= mask;
+			return i + 1;
+		}
+		mask <<= 1;
+	}
+	return 0;
+}
+
+/**
+ * This function releases periodic Tx FIFO in shared Tx FIFO mode
+ */
+static void release_tx_fifo(struct core_if *core_if, u32 fifo_num)
+{
+	core_if->tx_msk = (core_if->tx_msk & (1 << (fifo_num - 1)))
+				^ core_if->tx_msk;
+}
+
+/**
+ * Sets an in endpoint's tx fifo based on the hardware configuration.
+ */
+static void set_in_ep_tx_fifo(struct dwc_pcd *pcd, struct pcd_ep *ep,
+		const struct usb_endpoint_descriptor *desc)
+{
+	if (pcd->otg_dev->core_if->en_multiple_tx_fifo) {
+		ep->dwc_ep.tx_fifo_num = assign_tx_fifo(pcd->otg_dev->core_if);
+	} else {
+		ep->dwc_ep.tx_fifo_num = 0;
+
+		/* If ISOC EP then assign a Periodic Tx FIFO. */
+		if ((desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
+			USB_ENDPOINT_XFER_ISOC)
+			ep->dwc_ep.tx_fifo_num =
+				assign_perio_tx_fifo(pcd->otg_dev->core_if);
+	}
+}
+
+/**
+ * This function activates an EP.  The Device EP control register for
+ * the EP is configured as defined in the ep structure.  Note: This function is
+ * not used for EP0.
+ */
+void dwc_otg_ep_activate(struct core_if *core_if, struct dwc_ep *ep)
+{
+	struct device_if *dev_if = core_if->dev_if;
+	union depctl_data depctl;
+	u32 *addr;
+	union daint_data daintmsk = {.d32 = 0};
+
+	/* Read DEPCTLn register */
+	if (ep->is_in == 1) {
+		addr = &dev_if->in_ep_regs[ep->num]->diepctl;
+		daintmsk.ep.in = 1 << ep->num;
+	} else {
+		addr = &dev_if->out_ep_regs[ep->num]->doepctl;
+		daintmsk.ep.out = 1 << ep->num;
+	}
+
+	/* If the EP is already active don't change the EP Control register */
+	depctl.d32 = dwc_read_reg32(addr);
+	if (!depctl.b.usbactep) {
+		depctl.b.mps = ep->maxpacket;
+		depctl.b.eptype = ep->type;
+		depctl.b.txfnum = ep->tx_fifo_num;
+		depctl.b.setd0pid = 1;
+		depctl.b.usbactep = 1;
+		dwc_write_reg32(addr, depctl.d32);
+	}
+
+	/* Enable the Interrupt for this EP */
+	dwc_modify_reg32(&dev_if->dev_global_regs->daintmsk, 0, daintmsk.d32);
+
+	ep->stall_clear_flag = 0;
+}
+
+/**
+ * This function is called by the Gadget Driver for each EP to be
+ * configured for the current configuration (SET_CONFIGURATION).
+ *
+ * This function initializes the dwc_otg_ep_t data structure, and then
+ * calls dwc_otg_ep_activate.
+ */
+static int dwc_otg_pcd_ep_enable(struct usb_ep *_ep,
+	const struct usb_endpoint_descriptor *desc)
+{
+	struct pcd_ep *ep = NULL;
+	struct dwc_pcd *pcd = NULL;
+	unsigned long flags;
+
+	ep = container_of(_ep, struct pcd_ep, ep);
+	if (!_ep || !desc || ep->desc || desc->bDescriptorType !=
+			USB_DT_ENDPOINT) {
+		printk(KERN_WARNING "%s, bad ep or descriptor\n", __func__);
+		return -EINVAL;
+	}
+
+	if (ep == &ep->pcd->ep0) {
+		printk(KERN_WARNING "%s, bad ep(0)\n", __func__);
+		return -EINVAL;
+	}
+
+	/* Check FIFO size */
+	if (!desc->wMaxPacketSize) {
+		printk(KERN_WARNING "%s, bad %s maxpacket\n", __func__,
+				_ep->name);
+		return -ERANGE;
+	}
+
+	pcd = ep->pcd;
+	if (!pcd->driver || pcd->gadget.speed == USB_SPEED_UNKNOWN) {
+		printk(KERN_WARNING "%s, bogus device state\n", __func__);
+		return -ESHUTDOWN;
+	}
+
+	spin_lock_irqsave(&pcd->lock, flags);
+	ep->desc = desc;
+	ep->ep.maxpacket = le16_to_cpu(desc->wMaxPacketSize);
+
+	/* Activate the EP */
+	ep->stopped = 0;
+	ep->dwc_ep.is_in = (USB_DIR_IN & desc->bEndpointAddress) != 0;
+	ep->dwc_ep.maxpacket = ep->ep.maxpacket;
+	ep->dwc_ep.type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
+
+	if (ep->dwc_ep.is_in)
+		set_in_ep_tx_fifo(pcd, ep, desc);
+
+	/* Set initial data PID. */
+	if ((desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
+			USB_ENDPOINT_XFER_BULK)
+		ep->dwc_ep.data_pid_start = 0;
+
+	dwc_otg_ep_activate(GET_CORE_IF(pcd), &ep->dwc_ep);
+	spin_unlock_irqrestore(&pcd->lock, flags);
+	return 0;
+}
+
+/**
+ * This function deactivates an EP.  This is done by clearing the USB Active EP
+ * bit in the Device EP control register.  Note: This function is not used for
+ * EP0. EP0 cannot be deactivated.
+ */
+static void dwc_otg_ep_deactivate(struct core_if *core_if, struct dwc_ep *ep)
+{
+	union depctl_data depctl = {.d32 = 0};
+	u32 *addr;
+	union daint_data daintmsk = {.d32 = 0};
+
+	/* Read DEPCTLn register */
+	if (ep->is_in == 1) {
+		addr = &core_if->dev_if->in_ep_regs[ep->num]->diepctl;
+		daintmsk.ep.in = 1 << ep->num;
+	} else {
+		addr = &core_if->dev_if->out_ep_regs[ep->num]->doepctl;
+		daintmsk.ep.out = 1 << ep->num;
+	}
+
+	depctl.b.usbactep = 0;
+	dwc_write_reg32(addr, depctl.d32);
+
+	/* Disable the Interrupt for this EP */
+	dwc_modify_reg32(&core_if->dev_if->dev_global_regs->daintmsk,
+			daintmsk.d32, 0);
+}
+
+/**
+ * This function is called when an EP is disabled due to disconnect or
+ * change in configuration. Any pending requests will terminate with a
+ * status of -ESHUTDOWN.
+ *
+ * This function modifies the dwc_otg_ep_t data structure for this EP,
+ * and then calls dwc_otg_ep_deactivate.
+ */
+static int dwc_otg_pcd_ep_disable(struct usb_ep *_ep)
+{
+	struct pcd_ep *ep;
+	struct core_if *core_if;
+	unsigned long flags;
+
+	ep = container_of(_ep, struct pcd_ep, ep);
+	if (!_ep || !ep->desc)
+		return -EINVAL;
+
+	core_if = ep->pcd->otg_dev->core_if;
+
+	spin_lock_irqsave(&ep->pcd->lock, flags);
+
+	request_nuke(ep);
+	dwc_otg_ep_deactivate(core_if, &ep->dwc_ep);
+
+	ep->desc = NULL;
+	ep->stopped = 1;
+	if (ep->dwc_ep.is_in) {
+		release_perio_tx_fifo(core_if, ep->dwc_ep.tx_fifo_num);
+		release_tx_fifo(core_if, ep->dwc_ep.tx_fifo_num);
+	}
+
+	spin_unlock_irqrestore(&ep->pcd->lock, flags);
+
+	return 0;
+}
+
+/**
+ * This function allocates a request object to use with the specified
+ * endpoint.
+ */
+static struct usb_request *dwc_otg_pcd_alloc_request(struct usb_ep *_ep,
+				gfp_t gfp_flags)
+{
+	struct pcd_request *req;
+
+	if (!_ep) {
+		printk(KERN_WARNING "%s() Invalid EP\n", __func__);
+		return 0;
+	}
+
+	req = kzalloc(sizeof(struct pcd_request), gfp_flags);
+	if (!req) {
+		printk(KERN_WARNING "%s() request allocation failed\n",
+				__func__);
+		return 0;
+	}
+
+	req->req.dma = DMA_ADDR_INVALID;
+	INIT_LIST_HEAD(&req->queue);
+
+	return &req->req;
+}
+
+/**
+ * This function frees a request object.
+ */
+static void dwc_otg_pcd_free_request(struct usb_ep *_ep,
+				     struct usb_request *_req)
+{
+	struct pcd_request *req;
+
+	if (!_ep || !_req) {
+		printk(KERN_WARNING "%s() nvalid ep or req argument\n",
+			__func__);
+		return;
+	}
+
+	req = container_of(_req, struct pcd_request, req);
+	kfree(req);
+}
+
+/*
+ * In dedicated Tx FIFO mode, enable the Non-Periodic Tx FIFO empty interrupt.
+ * Otherwise, enable the Tx FIFO epmty interrupt. The data will be written into
+ * the fifo by the ISR.
+ */
+static void enable_tx_fifo_empty_intr(struct core_if *c_if, struct dwc_ep *ep)
+{
+	union gintmsk_data intr_mask = {.d32 = 0};
+	struct device_if *d_if = c_if->dev_if;
+	struct core_global_regs *glbl_regs = c_if->core_global_regs;
+
+	if (!c_if->en_multiple_tx_fifo) {
+		intr_mask.b.nptxfempty = 1;
+		dwc_modify_reg32(&glbl_regs->gintsts, intr_mask.d32, 0);
+		dwc_modify_reg32(&glbl_regs->gintmsk, intr_mask.d32,
+					intr_mask.d32);
+	} else if (ep->xfer_len) {
+		/* Enable the Tx FIFO Empty Interrupt for this EP */
+		u32 fifoemptymsk = 1 << ep->num;
+		dwc_modify_reg32(&d_if->dev_global_regs->dtknqr4_fifoemptymsk,
+					0, fifoemptymsk);
+	}
+}
+
+static void set_next_ep(struct device_if *dev_if, u8 num)
+{
+	union depctl_data depctl;
+
+	depctl.d32 = dwc_read_reg32(&dev_if->in_ep_regs[0]->diepctl);
+	depctl.b.nextep = num;
+
+	dwc_write_reg32(&dev_if->in_ep_regs[0]->diepctl, depctl.d32);
+}
+
+/**
+ * This function does the setup for a data transfer for an EP and
+ * starts the transfer.  For an IN transfer, the packets will be loaded into the
+ * appropriate Tx FIFO in the ISR. For OUT transfers, the packets are unloaded
+ * from the Rx FIFO in the ISR.
+ *
+ */
+void dwc_otg_ep_start_transfer(struct core_if *c_if, struct dwc_ep *ep)
+{
+	union depctl_data depctl;
+	union deptsiz_data deptsiz;
+	struct device_if *d_if = c_if->dev_if;
+	struct core_global_regs *glbl_regs = c_if->core_global_regs;
+
+	if (ep->is_in) {
+		struct device_in_ep_regs *in_regs = d_if->in_ep_regs[ep->num];
+		union gnptxsts_data gtxstatus;
+		gtxstatus.d32 = dwc_read_reg32(&glbl_regs->gnptxsts);
+
+		if (!c_if->en_multiple_tx_fifo && !gtxstatus.b.nptxqspcavail)
+			return;
+
+		depctl.d32 = dwc_read_reg32(&(in_regs->diepctl));
+		deptsiz.d32 = dwc_read_reg32(&(in_regs->dieptsiz));
+
+		/* Zero Length Packet? */
+		if (!ep->xfer_len) {
+			deptsiz.b.xfersize = 0;
+			deptsiz.b.pktcnt = 1;
+		} else {
+			/*
+			 * Program the transfer size and packet count as
+			 * follows:
+			 *
+			 * xfersize = N * maxpacket + short_packet
+			 * pktcnt = N + (short_packet exist ? 1 : 0)
+			 */
+
+			/*
+			 * Added-sr: 2007-07-26
+			 *
+			 * Since the 405EZ (Ultra) only support 2047 bytes as
+			 * max transfer size, we have to split up bigger
+			 * transfers into multiple transfers of 1024 bytes sized
+			 * messages. I happens often, that transfers of 4096
+			 * bytes are required (zero-gadget,
+			 * file_storage-gadget).
+			 */
+			if (dwc_has_feature(c_if, DWC_LIMITED_XFER)) {
+				if (ep->xfer_len > MAX_XFER_LEN) {
+					ep->bytes_pending = ep->xfer_len
+						- MAX_XFER_LEN;
+					ep->xfer_len = MAX_XFER_LEN;
+				}
+			}
+
+			deptsiz.b.xfersize = ep->xfer_len;
+			deptsiz.b.pktcnt = (ep->xfer_len - 1 + ep->maxpacket) /
+						ep->maxpacket;
+		}
+		dwc_write_reg32(&in_regs->dieptsiz, deptsiz.d32);
+
+		if (c_if->dma_enable)
+			dwc_write_reg32(&in_regs->diepdma, ep->dma_addr);
+		else if (ep->type != DWC_OTG_EP_TYPE_ISOC)
+			enable_tx_fifo_empty_intr(c_if, ep);
+
+		/* EP enable, IN data in FIFO */
+		depctl.b.cnak = 1;
+		depctl.b.epena = 1;
+		dwc_write_reg32(&in_regs->diepctl, depctl.d32);
+
+		if (c_if->dma_enable)
+			set_next_ep(d_if, ep->num);
+	} else {
+		struct device_out_ep_regs *out_regs =
+			d_if->out_ep_regs[ep->num];
+
+		depctl.d32 = dwc_read_reg32(&out_regs->doepctl);
+		deptsiz.d32 = dwc_read_reg32(&out_regs->doeptsiz);
+
+		/*
+		 * Program the transfer size and packet count as follows:
+		 *
+		 * pktcnt = N
+		 * xfersize = N * maxpacket
+		 */
+		if (!ep->xfer_len) {
+			deptsiz.b.xfersize = ep->maxpacket;
+			deptsiz.b.pktcnt = 1;
+		} else {
+			deptsiz.b.pktcnt = (ep->xfer_len + ep->maxpacket - 1) /
+					ep->maxpacket;
+			deptsiz.b.xfersize = deptsiz.b.pktcnt * ep->maxpacket;
+		}
+		dwc_write_reg32(&out_regs->doeptsiz, deptsiz.d32);
+
+		if (c_if->dma_enable)
+			dwc_write_reg32(&out_regs->doepdma, ep->dma_addr);
+
+		if (ep->type == DWC_OTG_EP_TYPE_ISOC) {
+			if (ep->even_odd_frame)
+				depctl.b.setd1pid = 1;
+			else
+				depctl.b.setd0pid = 1;
+		}
+
+		/* EP enable */
+		depctl.b.cnak = 1;
+		depctl.b.epena = 1;
+		dwc_write_reg32(&out_regs->doepctl, depctl.d32);
+	}
+}
+
+/**
+ * This function does the setup for a data transfer for EP0 and starts
+ * the transfer.  For an IN transfer, the packets will be loaded into
+ * the appropriate Tx FIFO in the ISR. For OUT transfers, the packets are
+ * unloaded from the Rx FIFO in the ISR.
+ */
+void dwc_otg_ep0_start_transfer(struct core_if *c_if, struct dwc_ep *ep)
+{
+	union depctl_data depctl;
+	union deptsiz0_data deptsiz;
+	struct device_if *d_if = c_if->dev_if;
+	struct core_global_regs *glbl_regs = c_if->core_global_regs;
+
+	ep->total_len = ep->xfer_len;
+
+	if (ep->is_in) {
+		struct device_in_ep_regs *in_regs = d_if->in_ep_regs[0];
+		union gnptxsts_data gtxstatus;
+
+		gtxstatus.d32 = dwc_read_reg32(&glbl_regs->gnptxsts);
+
+		if (!c_if->en_multiple_tx_fifo && !gtxstatus.b.nptxqspcavail)
+			return;
+
+		depctl.d32 = dwc_read_reg32(&in_regs->diepctl);
+		deptsiz.d32 = dwc_read_reg32(&in_regs->dieptsiz);
+
+		/* Zero Length Packet? */
+		if (!ep->xfer_len) {
+			deptsiz.b.xfersize = 0;
+			deptsiz.b.pktcnt = 1;
+		} else {
+			/*
+			 * Program the transfer size and packet count  as
+			 * follows:
+			 *
+			 *  xfersize = N * maxpacket + short_packet
+			 *  pktcnt = N + (short_packet exist ? 1 : 0)
+			 */
+			if (ep->xfer_len > ep->maxpacket) {
+				ep->xfer_len = ep->maxpacket;
+				deptsiz.b.xfersize = ep->maxpacket;
+			} else {
+				deptsiz.b.xfersize = ep->xfer_len;
+			}
+			deptsiz.b.pktcnt = 1;
+		}
+		dwc_write_reg32(&in_regs->dieptsiz, deptsiz.d32);
+
+		if (c_if->dma_enable)
+			dwc_write_reg32(&in_regs->diepdma, ep->dma_addr);
+
+		/* EP enable, IN data in FIFO */
+		depctl.b.cnak = 1;
+		depctl.b.epena = 1;
+		dwc_write_reg32(&in_regs->diepctl, depctl.d32);
+
+		if (!c_if->dma_enable)
+			enable_tx_fifo_empty_intr(c_if, ep);
+	} else {
+		struct device_out_ep_regs *out_regs =
+			d_if->out_ep_regs[ep->num];
+
+		depctl.d32 = dwc_read_reg32(&out_regs->doepctl);
+		deptsiz.d32 = dwc_read_reg32(&out_regs->doeptsiz);
+
+		/*
+		 * Program the transfer size and packet count as follows:
+		 *
+		 * xfersize = N * (maxpacket + 4 - (maxpacket % 4))
+		 * pktcnt = N
+		 */
+		if (!ep->xfer_len) {
+			deptsiz.b.xfersize = ep->maxpacket;
+			deptsiz.b.pktcnt = 1;
+		} else {
+			deptsiz.b.pktcnt = (ep->xfer_len + ep->maxpacket - 1) /
+						ep->maxpacket;
+			deptsiz.b.xfersize = deptsiz.b.pktcnt * ep->maxpacket;
+		}
+		dwc_write_reg32(&out_regs->doeptsiz, deptsiz.d32);
+
+		if (c_if->dma_enable)
+			dwc_write_reg32(&out_regs->doepdma, ep->dma_addr);
+
+		/* EP enable */
+		depctl.b.cnak = 1;
+		depctl.b.epena = 1;
+		dwc_write_reg32(&out_regs->doepctl, depctl.d32);
+	}
+}
+
+/**
+ * This function is used to submit an I/O Request to an EP.
+ *
+ *	- When the request completes the request's completion callback
+ *	  is called to return the request to the driver.
+ *	- An EP, except control EPs, may have multiple requests
+ *	  pending.
+ *	- Once submitted the request cannot be examined or modified.
+ *	- Each request is turned into one or more packets.
+ *	- A BULK EP can queue any amount of data; the transfer is
+ *	  packetized.
+ *	- Zero length Packets are specified with the request 'zero'
+ *	  flag.
+ */
+static int dwc_otg_pcd_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
+				gfp_t gfp_flags)
+{
+	int prevented = 0;
+	struct pcd_request *req;
+	struct pcd_ep *ep;
+	struct dwc_pcd *pcd;
+	struct core_if *core_if;
+	unsigned long flags = 0;
+
+	req = container_of(_req, struct pcd_request, req);
+	if (!_req || !_req->complete || !_req->buf ||
+			!list_empty(&req->queue)) {
+		printk(KERN_WARNING "%s, bad params\n", __func__);
+		return -EINVAL;
+	}
+
+	ep = container_of(_ep, struct pcd_ep, ep);
+	if (!_ep || (!ep->desc && ep->dwc_ep.num != 0)) {
+		printk(KERN_WARNING "%s, bad ep\n", __func__);
+		return -EINVAL;
+	}
+
+	pcd = ep->pcd;
+	if (!pcd->driver || pcd->gadget.speed == USB_SPEED_UNKNOWN) {
+		printk(KERN_WARNING "%s, bogus device state\n", __func__);
+		return -ESHUTDOWN;
+	}
+	core_if = pcd->otg_dev->core_if;
+
+	if (!core_if->core_params->opt) {
+		if (ep->dwc_ep.num != 0) {
+			printk(KERN_ERR "%s queue req %p, len %d buf %p\n",
+				_ep->name, _req, _req->length, _req->buf);
+		}
+	}
+
+	if (GET_CORE_IF(pcd)->dma_enable) {
+		if (_req->dma == DMA_ADDR_INVALID) {
+			_req->dma = dma_map_single(pcd->gadget.dev.parent,
+				_req->buf, _req->length, ep->dwc_ep.is_in ?
+				DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			req->mapped = 1;
+		} else {
+			dma_sync_single_for_device(pcd->gadget.dev.parent,
+				_req->dma, _req->length, ep->dwc_ep.is_in ?
+				DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			req->mapped = 0;
+		}
+	}
+
+	spin_lock_irqsave(&ep->pcd->lock, flags);
+
+	_req->status = -EINPROGRESS;
+	_req->actual = 0;
+
+	/* Start the transfer */
+	if (list_empty(&ep->queue) && !ep->stopped) {
+		/* EP0 Transfer? */
+		if (ep->dwc_ep.num == 0) {
+			switch (pcd->ep0state) {
+			case EP0_IN_DATA_PHASE:
+				break;
+			case EP0_OUT_DATA_PHASE:
+				if (pcd->request_config) {
+					/* Complete STATUS PHASE */
+					ep->dwc_ep.is_in = 1;
+					pcd->ep0state = EP0_STATUS;
+				}
+				break;
+			default:
+				spin_unlock_irqrestore(&pcd->lock, flags);
+				return -EL2HLT;
+			}
+
+			ep->dwc_ep.dma_addr = _req->dma;
+			ep->dwc_ep.start_xfer_buff = _req->buf;
+			ep->dwc_ep.xfer_buff = _req->buf;
+			ep->dwc_ep.xfer_len = _req->length;
+			ep->dwc_ep.xfer_count = 0;
+			ep->dwc_ep.sent_zlp = 0;
+			ep->dwc_ep.total_len = ep->dwc_ep.xfer_len;
+
+			dwc_otg_ep0_start_transfer(core_if, &ep->dwc_ep);
+		} else {
+			/* Setup and start the Transfer */
+			ep->dwc_ep.dma_addr = _req->dma;
+			ep->dwc_ep.start_xfer_buff = _req->buf;
+			ep->dwc_ep.xfer_buff = _req->buf;
+			ep->dwc_ep.xfer_len = _req->length;
+			ep->dwc_ep.xfer_count = 0;
+			ep->dwc_ep.sent_zlp = 0;
+			ep->dwc_ep.total_len = ep->dwc_ep.xfer_len;
+
+			dwc_otg_ep_start_transfer(core_if, &ep->dwc_ep);
+		}
+	}
+
+	if (req || prevented) {
+		++pcd->request_pending;
+		list_add_tail(&req->queue, &ep->queue);
+
+		if (ep->dwc_ep.is_in && ep->stopped && !core_if->dma_enable) {
+			/*
+			 *  Device IN endpoint interrupt mask register is laid
+			 *  out exactly the same as the device IN endpoint
+			 *  interrupt register.
+			 */
+			union diepint_data diepmsk = {.d32 = 0};
+			diepmsk.b.intktxfemp = 1;
+
+			dwc_modify_reg32(
+				&core_if->dev_if->dev_global_regs->diepmsk,
+				0, diepmsk.d32);
+		}
+	}
+
+	spin_unlock_irqrestore(&pcd->lock, flags);
+	return 0;
+}
+
+/**
+ * This function cancels an I/O request from an EP.
+ */
+static int dwc_otg_pcd_ep_dequeue(struct usb_ep *_ep,
+				  struct usb_request *_req)
+{
+	struct pcd_request *req;
+	struct pcd_ep *ep;
+	struct dwc_pcd *pcd;
+	unsigned long flags;
+
+	ep = container_of(_ep, struct pcd_ep, ep);
+	if (!_ep || !_req || (!ep->desc && ep->dwc_ep.num != 0)) {
+		printk(KERN_WARNING "%s, bad argument\n", __func__);
+		return -EINVAL;
+	}
+
+	pcd = ep->pcd;
+	if (!pcd->driver || pcd->gadget.speed == USB_SPEED_UNKNOWN) {
+		printk(KERN_WARNING "%s, bogus device state\n", __func__);
+		return -ESHUTDOWN;
+	}
+
+	spin_lock_irqsave(&pcd->lock, flags);
+
+	/* make sure it's actually queued on this endpoint */
+	list_for_each_entry(req, &ep->queue, queue)
+		if (&req->req == _req)
+			break;
+
+	if (&req->req != _req) {
+		spin_unlock_irqrestore(&pcd->lock, flags);
+		return -EINVAL;
+	}
+
+	if (!list_empty(&req->queue))
+		request_done(ep, req, -ECONNRESET);
+	else
+		req = 0;
+
+	spin_unlock_irqrestore(&pcd->lock, flags);
+
+	return req ? 0 : -EOPNOTSUPP;
+}
+
+/**
+ * Set the EP STALL.
+ */
+void dwc_otg_ep_set_stall(struct core_if *core_if, struct dwc_ep *ep)
+{
+	union depctl_data depctl;
+	u32 *depctl_addr;
+
+	if (ep->is_in) {
+		depctl_addr = &(core_if->dev_if->in_ep_regs[ep->num]->diepctl);
+		depctl.d32 = dwc_read_reg32(depctl_addr);
+
+		/* set the disable and stall bits */
+		if (depctl.b.epena)
+			depctl.b.epdis = 1;
+		depctl.b.stall = 1;
+		dwc_write_reg32(depctl_addr, depctl.d32);
+	} else {
+		depctl_addr = &(core_if->dev_if->out_ep_regs[ep->num]->doepctl);
+		depctl.d32 = dwc_read_reg32(depctl_addr);
+
+		/* set the stall bit */
+		depctl.b.stall = 1;
+		dwc_write_reg32(depctl_addr, depctl.d32);
+	}
+}
+
+/**
+ * Clear the EP STALL.
+ */
+void dwc_otg_ep_clear_stall(struct core_if *core_if, struct dwc_ep *ep)
+{
+	union depctl_data depctl;
+	u32 *depctl_addr;
+
+	if (ep->is_in == 1)
+		depctl_addr = &(core_if->dev_if->in_ep_regs[ep->num]->diepctl);
+	else
+		depctl_addr = &(core_if->dev_if->out_ep_regs[ep->num]->doepctl);
+
+	depctl.d32 = dwc_read_reg32(depctl_addr);
+
+	/* clear the stall bits */
+	depctl.b.stall = 0;
+
+	/*
+	 * USB Spec 9.4.5: For endpoints using data toggle, regardless
+	 * of whether an endpoint has the Halt feature set, a
+	 * ClearFeature(ENDPOINT_HALT) request always results in the
+	 * data toggle being reinitialized to DATA0.
+	 */
+	if (ep->type == DWC_OTG_EP_TYPE_INTR ||
+			ep->type == DWC_OTG_EP_TYPE_BULK)
+		depctl.b.setd0pid = 1;	/* DATA0 */
+
+	dwc_write_reg32(depctl_addr, depctl.d32);
+}
+
+/**
+ * usb_ep_set_halt stalls an endpoint.
+ *
+ * usb_ep_clear_halt clears an endpoint halt and resets its data
+ * toggle.
+ *
+ * Both of these functions are implemented with the same underlying
+ * function. The behavior depends on the val argument:
+ *	- 0 means clear_halt.
+ *	- 1 means set_halt,
+ *	- 2 means clear stall lock flag.
+ *	- 3 means set  stall lock flag.
+ */
+static int dwc_otg_pcd_ep_set_halt(struct usb_ep *_ep, int val)
+{
+	int retval = 0;
+	unsigned long flags;
+	struct pcd_ep *ep = NULL;
+
+	ep = container_of(_ep, struct pcd_ep, ep);
+	if (!_ep || (!ep->desc && ep != &ep->pcd->ep0) ||
+			ep->desc->bmAttributes == USB_ENDPOINT_XFER_ISOC) {
+		printk(KERN_WARNING "%s, bad ep\n", __func__);
+		return -EINVAL;
+	}
+
+	spin_lock_irqsave(&ep->pcd->lock, flags);
+
+	if (ep->dwc_ep.is_in && !list_empty(&ep->queue)) {
+		printk(KERN_WARNING "%s() %s XFer In process\n", __func__,
+				_ep->name);
+		retval = -EAGAIN;
+	} else if (val == 0) {
+		dwc_otg_ep_clear_stall(ep->pcd->otg_dev->core_if, &ep->dwc_ep);
+	} else if (val == 1) {
+		if (ep->dwc_ep.num == 0)
+			ep->pcd->ep0state = EP0_STALL;
+
+		ep->stopped = 1;
+		dwc_otg_ep_set_stall(ep->pcd->otg_dev->core_if, &ep->dwc_ep);
+	} else if (val == 2) {
+		ep->dwc_ep.stall_clear_flag = 0;
+	} else if (val == 3) {
+		ep->dwc_ep.stall_clear_flag = 1;
+	}
+
+	spin_unlock_irqrestore(&ep->pcd->lock, flags);
+	return retval;
+}
+
+static struct usb_ep_ops dwc_otg_pcd_ep_ops = {
+	.enable = dwc_otg_pcd_ep_enable,
+	.disable = dwc_otg_pcd_ep_disable,
+	.alloc_request = dwc_otg_pcd_alloc_request,
+	.free_request = dwc_otg_pcd_free_request,
+	.queue = dwc_otg_pcd_ep_queue,
+	.dequeue = dwc_otg_pcd_ep_dequeue,
+	.set_halt = dwc_otg_pcd_ep_set_halt,
+	.fifo_status = 0,
+	.fifo_flush = 0,
+};
+
+/**
+ * Gets the current USB frame number from the DTS register. This is the frame
+ * number from the last SOF packet.
+ */
+static u32 dwc_otg_get_frame_number(struct core_if *core_if)
+{
+	union dsts_data dsts;
+	dsts.d32 = dwc_read_reg32(&core_if->dev_if->dev_global_regs->dsts);
+	return dsts.b.soffn;
+}
+/**
+ * The following gadget operations will be implemented in the DWC_otg
+ * PCD. Functions in the API that are not described below are not
+ * implemented.
+ *
+ * The Gadget API provides wrapper functions for each of the function
+ * pointers defined in usb_gadget_ops. The Gadget Driver calls the
+ * wrapper function, which then calls the underlying PCD function. The
+ * following sections are named according to the wrapper functions
+ * (except for ioctl, which doesn't have a wrapper function). Within
+ * each section, the corresponding DWC_otg PCD function name is
+ * specified.
+ *
+ */
+
+/**
+ *Gets the USB Frame number of the last SOF.
+ */
+static int dwc_otg_pcd_get_frame(struct usb_gadget *_gadget)
+{
+	struct dwc_pcd *pcd;
+
+	if (!_gadget) {
+		return -ENODEV;
+	} else {
+		pcd = container_of(_gadget, struct dwc_pcd, gadget);
+		dwc_otg_get_frame_number(GET_CORE_IF(pcd));
+	}
+
+	return 0;
+}
+
+/**
+ * This function is called when the SRP timer expires.  The SRP should complete
+ * within 6 seconds.
+ */
+static void srp_timeout(unsigned long data)
+{
+	union gotgctl_data gotgctl;
+	struct dwc_pcd *pcd = (struct dwc_pcd *)data;
+	struct core_if *core_if = pcd->otg_dev->core_if;
+	u32 *addr = otg_ctl_reg(pcd);
+
+	gotgctl.d32 = dwc_read_reg32(addr);
+	core_if->srp_timer_started = 0;
+
+	if (core_if->core_params->phy_type == DWC_PHY_TYPE_PARAM_FS &&
+			core_if->core_params->i2c_enable) {
+		printk(KERN_INFO "SRP Timeout\n");
+
+		if (core_if->srp_success && gotgctl.b.bsesvld) {
+			if (core_if->pcd_cb && core_if->pcd_cb->resume_wakeup)
+				core_if->pcd_cb->resume_wakeup(
+						core_if->pcd_cb->p);
+
+			/* Clear Session Request */
+			gotgctl.d32 = 0;
+			gotgctl.b.sesreq = 1;
+			dwc_modify_reg32(addr, gotgctl.d32, 0);
+
+			core_if->srp_success = 0;
+		} else {
+			printk(KERN_ERR "Device not connected/responding\n");
+			gotgctl.b.sesreq = 0;
+			dwc_write_reg32(addr, gotgctl.d32);
+		}
+	} else if (gotgctl.b.sesreq) {
+		printk(KERN_INFO "SRP Timeout\n");
+		printk(KERN_ERR "Device not connected/responding\n");
+
+		gotgctl.b.sesreq = 0;
+		dwc_write_reg32(addr, gotgctl.d32);
+	} else {
+		printk(KERN_INFO " SRP GOTGCTL=%0x\n", gotgctl.d32);
+	}
+}
+
+
+
+/**
+ * Start the SRP timer to detect when the SRP does not complete within
+ * 6 seconds.
+ */
+static void dwc_otg_pcd_start_srp_timer(struct dwc_pcd *pcd)
+{
+	struct timer_list *srp_timer = &pcd->srp_timer;
+
+	GET_CORE_IF(pcd)->srp_timer_started = 1;
+
+	init_timer(srp_timer);
+	srp_timer->function = srp_timeout;
+	srp_timer->data = (unsigned long)pcd;
+	srp_timer->expires = jiffies + (HZ * 6);
+
+	add_timer(srp_timer);
+}
+
+static void dwc_otg_pcd_initiate_srp(struct dwc_pcd *pcd)
+{
+	union gotgctl_data mem;
+	union gotgctl_data val;
+	u32 *addr = otg_ctl_reg(pcd);
+
+	val.d32 = dwc_read_reg32(addr);
+	if (val.b.sesreq) {
+		printk(KERN_ERR "Session Request Already active!\n");
+		return;
+	}
+
+	printk(KERN_NOTICE "Session Request Initated\n");
+	mem.d32 = dwc_read_reg32(addr);
+	mem.b.sesreq = 1;
+	dwc_write_reg32(addr, mem.d32);
+
+	/* Start the SRP timer */
+	dwc_otg_pcd_start_srp_timer(pcd);
+	return;
+}
+
+static void dwc_otg_pcd_remote_wakeup(struct dwc_pcd *pcd, int set)
+{
+	union dctl_data dctl = {.d32 = 0};
+	u32 *addr = dev_ctl_reg(pcd);
+
+	if (dwc_otg_is_device_mode(GET_CORE_IF(pcd))) {
+		if (pcd->remote_wakeup_enable) {
+			if (set) {
+				dctl.b.rmtwkupsig = 1;
+				dwc_modify_reg32(addr, 0, dctl.d32);
+				msleep(1);
+				dwc_modify_reg32(addr, dctl.d32, 0);
+			}
+		}
+	}
+}
+
+/**
+ * Initiates Session Request Protocol (SRP) to wakeup the host if no
+ * session is in progress. If a session is already in progress, but
+ * the device is suspended, remote wakeup signaling is started.
+ *
+ */
+static int dwc_otg_pcd_wakeup(struct usb_gadget *_gadget)
+{
+	unsigned long flags;
+	struct dwc_pcd *pcd;
+	union dsts_data dsts;
+	union gotgctl_data gotgctl;
+
+	if (!_gadget)
+		return -ENODEV;
+	else
+		pcd = container_of(_gadget, struct dwc_pcd, gadget);
+
+	spin_lock_irqsave(&pcd->lock, flags);
+
+	/*
+	 * This function starts the Protocol if no session is in progress. If
+	 * a session is already in progress, but the device is suspended,
+	 * remote wakeup signaling is started.
+	 */
+
+	/* Check if valid session */
+	gotgctl.d32 = dwc_read_reg32(otg_ctl_reg(pcd));
+	if (gotgctl.b.bsesvld) {
+		/* Check if suspend state */
+		dsts.d32 = dwc_read_reg32(dev_sts_reg(pcd));
+		if (dsts.b.suspsts)
+			dwc_otg_pcd_remote_wakeup(pcd, 1);
+	} else {
+		dwc_otg_pcd_initiate_srp(pcd);
+	}
+
+	spin_unlock_irqrestore(&pcd->lock, flags);
+	return 0;
+}
+
+static const struct usb_gadget_ops dwc_otg_pcd_ops = {
+	.get_frame = dwc_otg_pcd_get_frame,
+	.wakeup = dwc_otg_pcd_wakeup,
+	/* not selfpowered */
+};
+
+/**
+ * This function updates the otg values in the gadget structure.
+ */
+void dwc_otg_pcd_update_otg(struct dwc_pcd *pcd, const unsigned reset)
+{
+	if (!pcd->gadget.is_otg)
+		return;
+
+	if (reset) {
+		pcd->b_hnp_enable = 0;
+		pcd->a_hnp_support = 0;
+		pcd->a_alt_hnp_support = 0;
+	}
+
+	pcd->gadget.b_hnp_enable = pcd->b_hnp_enable;
+	pcd->gadget.a_hnp_support = pcd->a_hnp_support;
+	pcd->gadget.a_alt_hnp_support = pcd->a_alt_hnp_support;
+}
+
+/**
+ * This function is the top level PCD interrupt handler.
+ */
+static irqreturn_t dwc_otg_pcd_irq(int _irq, void *dev)
+{
+	struct dwc_pcd *pcd = dev;
+	int retval = IRQ_NONE;
+
+	retval = dwc_otg_pcd_handle_intr(pcd);
+	return IRQ_RETVAL(retval);
+}
+
+/**
+ * PCD Callback function for initializing the PCD when switching to
+ * device mode.
+ */
+static int dwc_otg_pcd_start_cb(void *_p)
+{
+	struct dwc_pcd *pcd = (struct dwc_pcd *)_p;
+
+	/* Initialize the Core for Device mode. */
+	if (dwc_otg_is_device_mode(GET_CORE_IF(pcd)))
+		dwc_otg_core_dev_init(GET_CORE_IF(pcd));
+
+	return 1;
+}
+
+/**
+ * PCD Callback function for stopping the PCD when switching to Host
+ * mode.
+ */
+static int dwc_otg_pcd_stop_cb(void *_p)
+{
+	dwc_otg_pcd_stop((struct dwc_pcd *)_p);
+	return 1;
+}
+
+/**
+ * PCD Callback function for notifying the PCD when resuming from
+ * suspend.
+ *
+ * @param _p void pointer to the <code>struct dwc_pcd</code>
+ */
+static int dwc_otg_pcd_suspend_cb(void *_p)
+{
+	struct dwc_pcd *pcd = (struct dwc_pcd *)_p;
+
+	if (pcd->driver && pcd->driver->suspend) {
+		spin_unlock(&pcd->lock);
+		pcd->driver->suspend(&pcd->gadget);
+		spin_lock(&pcd->lock);
+	}
+	return 1;
+}
+
+/**
+ * PCD Callback function for notifying the PCD when resuming from
+ * suspend.
+ */
+static int dwc_otg_pcd_resume_cb(void *_p)
+{
+	struct dwc_pcd *pcd = (struct dwc_pcd *)_p;
+	struct core_if *core_if = pcd->otg_dev->core_if;
+
+	if (pcd->driver && pcd->driver->resume) {
+		spin_unlock(&pcd->lock);
+		pcd->driver->resume(&pcd->gadget);
+		spin_lock(&pcd->lock);
+	}
+
+	/* Maybe stop the SRP timeout timer. */
+	if (need_stop_srp_timer(core_if))  {
+		core_if->srp_timer_started = 0;
+		del_timer_sync(&pcd->srp_timer);
+	}
+	return 1;
+}
+
+/**
+ * PCD Callback structure for handling mode switching.
+ */
+static struct cil_callbacks pcd_callbacks = {
+	.start = dwc_otg_pcd_start_cb,
+	.stop = dwc_otg_pcd_stop_cb,
+	.suspend = dwc_otg_pcd_suspend_cb,
+	.resume_wakeup = dwc_otg_pcd_resume_cb,
+	.p = 0, /* Set at registration */
+};
+
+/**
+ * Tasklet
+ *
+ */
+static void start_xfer_tasklet_func(unsigned long data)
+{
+	struct dwc_pcd *pcd = (struct dwc_pcd *)data;
+	union depctl_data diepctl;
+	int num = pcd->otg_dev->core_if->dev_if->num_in_eps;
+	u32 i;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pcd->lock, flags);
+	diepctl.d32 = dwc_read_reg32(in_ep_ctl_reg(pcd, 0));
+
+	if (pcd->ep0.queue_sof) {
+		pcd->ep0.queue_sof = 0;
+		start_next_request(&pcd->ep0);
+	}
+
+	for (i = 0; i < num; i++) {
+		union depctl_data diepctl;
+		diepctl.d32 = dwc_read_reg32(in_ep_ctl_reg(pcd, i));
+
+		if (pcd->in_ep[i].queue_sof) {
+			pcd->in_ep[i].queue_sof = 0;
+			start_next_request(&pcd->in_ep[i]);
+		}
+	}
+	spin_unlock_irqrestore(&pcd->lock, flags);
+}
+
+static struct tasklet_struct start_xfer_tasklet = {
+	.next = NULL,
+	.state = 0,
+	.count = ATOMIC_INIT(0),
+	.func = start_xfer_tasklet_func,
+	.data = 0,
+};
+
+/**
+ * This function initialized the pcd Dp structures to there default
+ * state.
+ */
+void __devinit dwc_otg_pcd_reinit(struct dwc_pcd *pcd)
+{
+	static const char *names[] = {
+		"ep0", "ep1in", "ep2in", "ep3in", "ep4in", "ep5in",
+		"ep6in", "ep7in", "ep8in", "ep9in", "ep10in", "ep11in",
+		"ep12in", "ep13in", "ep14in", "ep15in", "ep1out", "ep2out",
+		"ep3out", "ep4out", "ep5out", "ep6out", "ep7out", "ep8out",
+		"ep9out", "ep10out", "ep11out", "ep12out", "ep13out",
+		"ep14out", "ep15out"
+	};
+
+	u32 i;
+	int in_ep_cntr, out_ep_cntr;
+	u32 hwcfg1;
+	u32 num_in_eps = (GET_CORE_IF(pcd))->dev_if->num_in_eps;
+	u32 num_out_eps = (GET_CORE_IF(pcd))->dev_if->num_out_eps;
+	struct pcd_ep *ep;
+
+	INIT_LIST_HEAD(&pcd->gadget.ep_list);
+
+	pcd->gadget.ep0 = &pcd->ep0.ep;
+	pcd->gadget.speed = USB_SPEED_UNKNOWN;
+	INIT_LIST_HEAD(&pcd->gadget.ep0->ep_list);
+
+	/* Initialize the EP0 structure. */
+	ep = &pcd->ep0;
+
+	/* Init EP structure */
+	ep->desc = NULL;
+	ep->pcd = pcd;
+	ep->stopped = 1;
+
+	/* Init DWC ep structure */
+	ep->dwc_ep.num = 0;
+	ep->dwc_ep.active = 0;
+	ep->dwc_ep.tx_fifo_num = 0;
+
+	/* Control until ep is actvated */
+	ep->dwc_ep.type = DWC_OTG_EP_TYPE_CONTROL;
+	ep->dwc_ep.maxpacket = MAX_PACKET_SIZE;
+	ep->dwc_ep.dma_addr = 0;
+	ep->dwc_ep.start_xfer_buff = 0;
+	ep->dwc_ep.xfer_buff = 0;
+	ep->dwc_ep.xfer_len = 0;
+	ep->dwc_ep.xfer_count = 0;
+	ep->dwc_ep.sent_zlp = 0;
+	ep->dwc_ep.total_len = 0;
+	ep->queue_sof = 0;
+
+	/* Init the usb_ep structure. */
+	ep->ep.name = names[0];
+	ep->ep.ops = &dwc_otg_pcd_ep_ops;
+
+	ep->ep.maxpacket = MAX_PACKET_SIZE;
+	list_add_tail(&ep->ep.ep_list, &pcd->gadget.ep_list);
+	INIT_LIST_HEAD(&ep->queue);
+
+	/* Initialize the EP structures. */
+	in_ep_cntr = 0;
+	hwcfg1 = (GET_CORE_IF(pcd))->hwcfg1.d32 >> 3;
+
+	for (i = 1; in_ep_cntr < num_in_eps; i++) {
+		if (!(hwcfg1 & 0x1)) {
+			struct pcd_ep *ep = &pcd->in_ep[in_ep_cntr];
+			in_ep_cntr++;
+
+			/* Init EP structure */
+			ep->desc = NULL;
+			ep->pcd = pcd;
+			ep->stopped = 1;
+
+			/* Init DWC ep structure */
+			ep->dwc_ep.is_in = 1;
+			ep->dwc_ep.num = i;
+			ep->dwc_ep.active = 0;
+			ep->dwc_ep.tx_fifo_num = 0;
+
+			/* Control until ep is actvated */
+			ep->dwc_ep.type = DWC_OTG_EP_TYPE_CONTROL;
+			ep->dwc_ep.maxpacket = MAX_PACKET_SIZE;
+			ep->dwc_ep.dma_addr = 0;
+			ep->dwc_ep.start_xfer_buff = 0;
+			ep->dwc_ep.xfer_buff = 0;
+			ep->dwc_ep.xfer_len = 0;
+			ep->dwc_ep.xfer_count = 0;
+			ep->dwc_ep.sent_zlp = 0;
+			ep->dwc_ep.total_len = 0;
+			ep->queue_sof = 0;
+
+			ep->ep.name = names[i];
+			ep->ep.ops = &dwc_otg_pcd_ep_ops;
+
+			ep->ep.maxpacket = MAX_PACKET_SIZE;
+			list_add_tail(&ep->ep.ep_list, &pcd->gadget.ep_list);
+			INIT_LIST_HEAD(&ep->queue);
+		}
+		hwcfg1 >>= 2;
+	}
+
+	out_ep_cntr = 0;
+	hwcfg1 = (GET_CORE_IF(pcd))->hwcfg1.d32 >> 2;
+	for (i = 1; out_ep_cntr < num_out_eps; i++) {
+		if (!(hwcfg1 & 0x1)) {
+			struct pcd_ep *ep = &pcd->out_ep[out_ep_cntr];
+			out_ep_cntr++;
+
+			/* Init EP structure */
+			ep->desc = NULL;
+			ep->pcd = pcd;
+			ep->stopped = 1;
+
+			/* Init DWC ep structure */
+			ep->dwc_ep.is_in = 0;
+			ep->dwc_ep.num = i;
+			ep->dwc_ep.active = 0;
+			ep->dwc_ep.tx_fifo_num = 0;
+
+			/* Control until ep is actvated */
+			ep->dwc_ep.type = DWC_OTG_EP_TYPE_CONTROL;
+			ep->dwc_ep.maxpacket = MAX_PACKET_SIZE;
+			ep->dwc_ep.dma_addr = 0;
+			ep->dwc_ep.start_xfer_buff = 0;
+			ep->dwc_ep.xfer_buff = 0;
+			ep->dwc_ep.xfer_len = 0;
+			ep->dwc_ep.xfer_count = 0;
+			ep->dwc_ep.sent_zlp = 0;
+			ep->dwc_ep.total_len = 0;
+			ep->queue_sof = 0;
+
+			ep->ep.name = names[15 + i];
+			ep->ep.ops = &dwc_otg_pcd_ep_ops;
+
+			ep->ep.maxpacket = MAX_PACKET_SIZE;
+			list_add_tail(&ep->ep.ep_list, &pcd->gadget.ep_list);
+			INIT_LIST_HEAD(&ep->queue);
+		}
+		hwcfg1 >>= 2;
+	}
+
+	/* remove ep0 from the list.  There is a ep0 pointer. */
+	list_del_init(&pcd->ep0.ep.ep_list);
+
+	pcd->ep0state = EP0_DISCONNECT;
+	pcd->ep0.ep.maxpacket = MAX_EP0_SIZE;
+	pcd->ep0.dwc_ep.maxpacket = MAX_EP0_SIZE;
+	pcd->ep0.dwc_ep.type = DWC_OTG_EP_TYPE_CONTROL;
+}
+
+/**
+ * This function releases the Gadget device.
+ * required by device_unregister().
+ */
+static void dwc_otg_pcd_gadget_release(struct device *dev)
+{
+	printk(KERN_INFO "%s(%p)\n", __func__, dev);
+}
+
+/**
+ * Allocates the buffers for the setup packets when the PCD portion of the
+ * driver is first initialized.
+ */
+static int __devinit init_pkt_buffs(struct device *dev, struct dwc_pcd *pcd)
+{
+	if (pcd->otg_dev->core_if->dma_enable) {
+		pcd->dwc_pool = dma_pool_create("dwc_otg_pcd", dev,
+				sizeof(*pcd->setup_pkt) * 5, 32, 0);
+		if (!pcd->dwc_pool)
+			return -ENOMEM;
+		pcd->setup_pkt = dma_pool_alloc(pcd->dwc_pool, GFP_KERNEL,
+				&pcd->setup_pkt_dma_handle);
+		if (!pcd->setup_pkt)
+			goto error;
+		pcd->status_buf = dma_pool_alloc(pcd->dwc_pool, GFP_KERNEL,
+				&pcd->status_buf_dma_handle);
+		if (!pcd->status_buf)
+			goto error1;
+	} else {
+		pcd->setup_pkt =  kmalloc(sizeof(*pcd->setup_pkt) * 5,
+			GFP_KERNEL);
+		if (!pcd->setup_pkt)
+			return -ENOMEM;
+		pcd->status_buf = kmalloc(sizeof(u16), GFP_KERNEL);
+		if (!pcd->status_buf)  {
+			kfree(pcd->setup_pkt);
+			return -ENOMEM;
+		}
+	}
+	return 0;
+
+error1:
+	dma_pool_free(pcd->dwc_pool, pcd->setup_pkt, pcd->setup_pkt_dma_handle);
+error:
+	dma_pool_destroy(pcd->dwc_pool);
+	return -ENOMEM;
+}
+
+/**
+ * This function initializes the PCD portion of the driver.
+ */
+int __devinit dwc_otg_pcd_init(struct device *dev)
+{
+	static char pcd_name[] = "dwc_otg_pcd";
+	struct dwc_pcd *pcd;
+	struct dwc_otg_device *otg_dev = dev_get_drvdata(dev);
+	struct core_if *core_if = otg_dev->core_if;
+	int retval = 0;
+
+	/* Allocate PCD structure */
+	pcd = kzalloc(sizeof(*pcd), GFP_KERNEL);
+	if (!pcd) {
+		retval = -ENOMEM;
+		goto err;
+	}
+
+	spin_lock_init(&pcd->lock);
+
+	otg_dev->pcd = pcd;
+	s_pcd = pcd;
+	pcd->gadget.name = pcd_name;
+
+	dev_set_name(&pcd->gadget.dev, "gadget");
+	pcd->otg_dev = otg_dev;
+	pcd->gadget.dev.parent = dev;
+	pcd->gadget.dev.release = dwc_otg_pcd_gadget_release;
+	pcd->gadget.ops = &dwc_otg_pcd_ops;
+
+	if (core_if->hwcfg4.b.ded_fifo_en)
+		printk(KERN_INFO "Dedicated Tx FIFOs mode\n");
+	else
+		printk(KERN_INFO "Shared Tx FIFO mode\n");
+
+	pcd->gadget.is_dualspeed = check_is_dual_speed(core_if);
+	pcd->gadget.is_otg = check_is_otg(core_if);
+
+	/* Register the gadget device */
+	retval = device_register(&pcd->gadget.dev);
+
+	/* Initialized the Core for Device mode. */
+	if (dwc_otg_is_device_mode(core_if))
+		dwc_otg_core_dev_init(core_if);
+
+	/*  Initialize EP structures */
+	dwc_otg_pcd_reinit(pcd);
+
+	/* Register the PCD Callbacks. */
+	dwc_otg_cil_register_pcd_callbacks(core_if, &pcd_callbacks, pcd);
+
+	/* Setup interupt handler */
+	retval = request_irq(otg_dev->irq, dwc_otg_pcd_irq, IRQF_SHARED,
+				pcd->gadget.name, pcd);
+	if (retval) {
+		printk(KERN_ERR "request of irq%d failed\n", otg_dev->irq);
+		retval = -EBUSY;
+		goto err_cleanup;
+	}
+
+	/* Initialize the DMA buffer for SETUP packets */
+	retval = init_pkt_buffs(dev, pcd);
+	if (retval)
+		goto err_cleanup;
+
+	/* Initialize tasklet */
+	start_xfer_tasklet.data = (unsigned long) pcd;
+	pcd->start_xfer_tasklet = &start_xfer_tasklet;
+	return 0;
+
+err_cleanup:
+	kfree(pcd);
+	otg_dev->pcd = 0;
+	s_pcd = 0;
+
+err:
+	return retval;
+}
+
+/**
+ * Cleanup the PCD.
+ */
+void __devexit dwc_otg_pcd_remove(struct device *dev)
+{
+	struct dwc_otg_device *otg_dev = dev_get_drvdata(dev);
+	struct dwc_pcd *pcd = otg_dev->pcd;
+
+	/* Free the IRQ */
+	free_irq(otg_dev->irq, pcd);
+
+	/* start with the driver above us */
+	if (pcd->driver) {
+		/* should have been done already by driver model core */
+		printk(KERN_WARNING "driver '%s' is still registered\n",
+				pcd->driver->driver.name);
+		usb_gadget_unregister_driver(pcd->driver);
+	}
+	if (pcd->start_xfer_tasklet)
+		tasklet_kill(pcd->start_xfer_tasklet);
+	tasklet_kill(&pcd->test_mode_tasklet);
+
+	device_unregister(&pcd->gadget.dev);
+	if (GET_CORE_IF(pcd)->dma_enable) {
+		dma_pool_free(pcd->dwc_pool, pcd->setup_pkt,
+				pcd->setup_pkt_dma_handle);
+		dma_pool_free(pcd->dwc_pool, pcd->status_buf,
+				pcd->status_buf_dma_handle);
+		dma_pool_destroy(pcd->dwc_pool);
+	} else {
+		kfree(pcd->setup_pkt);
+		kfree(pcd->status_buf);
+	}
+	kfree(pcd);
+	otg_dev->pcd = 0;
+}
+
+/**
+ * This function registers a gadget driver with the PCD.
+ *
+ * When a driver is successfully registered, it will receive control
+ * requests including set_configuration(), which enables non-control
+ * requests.  then usb traffic follows until a disconnect is reported.
+ * then a host may connect again, or the driver might get unbound.
+ */
+int usb_gadget_register_driver(struct usb_gadget_driver *driver)
+{
+	int retval;
+
+	if (!driver || driver->speed == USB_SPEED_UNKNOWN || !driver->bind ||
+			!driver->unbind || !driver->disconnect ||
+			!driver->setup)
+		return -EINVAL;
+
+	if (s_pcd == 0)
+		return -ENODEV;
+
+	if (s_pcd->driver != 0)
+		return -EBUSY;
+
+	/* hook up the driver */
+	s_pcd->driver = driver;
+	s_pcd->gadget.dev.driver = &driver->driver;
+
+	retval = driver->bind(&s_pcd->gadget);
+	if (retval) {
+		struct core_if *core_if;
+		printk(KERN_ERR "bind to driver %s --> error %d\n",
+			driver->driver.name, retval);
+		core_if = s_pcd->otg_dev->core_if;
+		otg_set_peripheral(core_if->xceiv, &s_pcd->gadget);
+		s_pcd->driver = 0;
+		s_pcd->gadget.dev.driver = 0;
+		return retval;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(usb_gadget_register_driver);
+
+/**
+ * This function unregisters a gadget driver
+ */
+int usb_gadget_unregister_driver(struct usb_gadget_driver *driver)
+{
+	struct core_if *core_if;
+
+	if (!s_pcd)
+		return -ENODEV;
+	if (!driver || driver != s_pcd->driver)
+		return -EINVAL;
+
+	core_if = s_pcd->otg_dev->core_if;
+	core_if->xceiv->state = OTG_STATE_UNDEFINED;
+	otg_set_peripheral(core_if->xceiv, NULL);
+
+	driver->unbind(&s_pcd->gadget);
+	s_pcd->driver = 0;
+
+	return 0;
+}
+EXPORT_SYMBOL(usb_gadget_unregister_driver);
diff --git a/drivers/usb/dwc_otg/dwc_otg_pcd.h b/drivers/usb/dwc_otg/dwc_otg_pcd.h
new file mode 100644
index 0000000..b4d8a01
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_pcd.h
@@ -0,0 +1,149 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#if !defined(__DWC_PCD_H__)
+#define __DWC_PCD_H__
+
+#include "dwc_otg_driver.h"
+
+/*
+ * This file contains the structures, constants, and interfaces for
+ * the Perpherial Contoller Driver (PCD).
+ *
+ * The Peripheral Controller Driver (PCD) for Linux will implement the
+ * Gadget API, so that the existing Gadget drivers can be used.	 For
+ * the Mass Storage Function driver the File-backed USB Storage Gadget
+ * (FBS) driver will be used.  The FBS driver supports the
+ * Control-Bulk (CB), Control-Bulk-Interrupt (CBI), and Bulk-Only
+ * transports.
+ *
+ */
+
+/* Invalid DMA Address */
+#define DMA_ADDR_INVALID			(~(dma_addr_t)0)
+/* Maxpacket size for EP0 */
+#define MAX_EP0_SIZE				64
+/* Maxpacket size for any EP */
+#define MAX_PACKET_SIZE				1024
+
+/*
+ * Get the pointer to the core_if from the pcd pointer.
+ */
+#define GET_CORE_IF(_pcd) (_pcd->otg_dev->core_if)
+
+/*
+ * DWC_otg request structure.
+ * This structure is a list of requests.
+ */
+struct pcd_request {
+	struct usb_request req;		/* USB Request. */
+	struct list_head queue;		/* queue of these requests. */
+	unsigned mapped:1;
+};
+
+static inline u32 *in_ep_int_reg(struct dwc_pcd *pd, int i)
+{
+	return (u32 *) &GET_CORE_IF(pd)->dev_if->in_ep_regs[i]->diepint;
+}
+static inline u32 *out_ep_int_reg(struct dwc_pcd *pd, int i)
+{
+	return (u32 *) &GET_CORE_IF(pd)->dev_if->out_ep_regs[i]->doepint;
+}
+static inline u32 *in_ep_ctl_reg(struct dwc_pcd *pd, int i)
+{
+	return (u32 *) &GET_CORE_IF(pd)->dev_if->in_ep_regs[i]->diepctl;
+}
+
+static inline u32 *out_ep_ctl_reg(struct dwc_pcd *pd, int i)
+{
+	return (u32 *) &GET_CORE_IF(pd)->dev_if->out_ep_regs[i]->doepctl;
+}
+
+static inline u32 *dev_ctl_reg(struct dwc_pcd *pd)
+{
+	return (u32 *) &(GET_CORE_IF(pd)->dev_if->dev_global_regs->dctl);
+}
+
+static inline u32 *dev_diepmsk_reg(struct dwc_pcd *pd)
+{
+	return (u32 *) &(GET_CORE_IF(pd)->dev_if->dev_global_regs->diepmsk);
+}
+
+static inline u32 *dev_sts_reg(struct dwc_pcd *pd)
+{
+	return (u32 *) &(GET_CORE_IF(pd)->dev_if->dev_global_regs->dsts);
+}
+
+static inline u32 *otg_ctl_reg(struct dwc_pcd *pd)
+{
+	return (u32 *) &(GET_CORE_IF(pd)->core_global_regs->gotgctl);
+}
+
+extern int  __init dwc_otg_pcd_init(struct device *dev);
+
+/*
+ * The following functions support managing the DWC_otg controller in device
+ * mode.
+ */
+extern void dwc_otg_ep_activate(struct core_if *core_if, struct dwc_ep *ep);
+extern void dwc_otg_ep_start_transfer(struct core_if *_if, struct dwc_ep *ep);
+extern void dwc_otg_ep_set_stall(struct core_if *core_if, struct dwc_ep *ep);
+extern void dwc_otg_ep_clear_stall(struct core_if *core_if, struct dwc_ep *ep);
+extern void dwc_otg_pcd_remove(struct device *dev);
+extern int dwc_otg_pcd_handle_intr(struct dwc_pcd *pcd);
+extern void dwc_otg_pcd_stop(struct dwc_pcd *pcd);
+extern void request_nuke(struct pcd_ep *ep);
+extern void dwc_otg_pcd_update_otg(struct dwc_pcd *pcd, const unsigned reset);
+extern void dwc_otg_ep0_start_transfer(struct core_if *_if, struct dwc_ep *ep);
+
+extern void request_done(struct pcd_ep *ep, struct pcd_request *req,
+				int _status);
+
+extern void start_next_request(struct pcd_ep *ep);
+#endif
diff --git a/drivers/usb/dwc_otg/dwc_otg_pcd_intr.c b/drivers/usb/dwc_otg/dwc_otg_pcd_intr.c
new file mode 100644
index 0000000..ae962c8
--- /dev/null
+++ b/drivers/usb/dwc_otg/dwc_otg_pcd_intr.c
@@ -0,0 +1,2270 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by APM and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
+ * Modified by Stefan Roese <sr@denx.de>, DENX Software Engineering
+ *
+ * Synopsys HS OTG Linux Software Driver and documentation (hereinafter,
+ * "Software") is an Unsupported proprietary work of Synopsys, Inc. unless
+ * otherwise expressly agreed to in writing between Synopsys and you.
+ *
+ * The Software IS NOT an item of Licensed Software or Licensed Product under
+ * any End User Software License Agreement or Agreement for Licensed Product
+ * with Synopsys or any supplement thereto. You are permitted to use and
+ * redistribute this Software in source and binary forms, with or without
+ * modification, provided that redistributions of source code must retain this
+ * notice. You may not view, use, disclose, copy or distribute this file or
+ * any information contained herein except pursuant to this license grant from
+ * Synopsys. If you do not agree with this notice, including the disclaimer
+ * below, then you are not authorized to use the Software.
+ *
+ * THIS SOFTWARE IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN "AS IS" BASIS
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS BE LIABLE FOR ANY DIRECT,
+ * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
+ * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
+ * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
+ * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
+ * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
+ * DAMAGE.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
+ * or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
+ * for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software Foundation,
+ * Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "dwc_otg_driver.h"
+#include "dwc_otg_pcd.h"
+
+/**
+ * This function returns pointer to in ep struct with number num
+ */
+static struct pcd_ep *get_in_ep(struct dwc_pcd *pcd, u32 num)
+{
+	u32 i;
+	int num_in_eps = GET_CORE_IF(pcd)->dev_if->num_in_eps;
+
+	if (num == 0) {
+		return &pcd->ep0;
+	} else {
+		for (i = 0; i < num_in_eps; ++i) {
+			if (pcd->in_ep[i].dwc_ep.num == num)
+				return &pcd->in_ep[i];
+		}
+	}
+	return 0;
+}
+
+/**
+ * This function returns pointer to out ep struct with number num
+ */
+static struct pcd_ep *get_out_ep(struct dwc_pcd *pcd, u32 num)
+{
+	u32 i;
+	int num_out_eps = GET_CORE_IF(pcd)->dev_if->num_out_eps;
+
+	if (num == 0) {
+		return &pcd->ep0;
+	} else {
+		for (i = 0; i < num_out_eps; ++i) {
+			if (pcd->out_ep[i].dwc_ep.num == num)
+				return &pcd->out_ep[i];
+		}
+	}
+	return 0;
+}
+
+/**
+ * This functions gets a pointer to an EP from the wIndex address
+ * value of the control request.
+ */
+static struct pcd_ep *get_ep_by_addr(struct dwc_pcd *pcd, u16 index)
+{
+	struct pcd_ep *ep;
+
+	if (!(index & USB_ENDPOINT_NUMBER_MASK))
+		return &pcd->ep0;
+
+	list_for_each_entry(ep, &pcd->gadget.ep_list, ep.ep_list) {
+		u8 bEndpointAddress;
+
+		if (!ep->desc)
+			continue;
+
+		bEndpointAddress = ep->desc->bEndpointAddress;
+		if ((index ^ bEndpointAddress) & USB_DIR_IN)
+			continue;
+
+		if ((index & 0x0f) == (bEndpointAddress & 0x0f))
+			return ep;
+	}
+	return NULL;
+}
+
+/**
+ * This function checks the EP request queue, if the queue is not
+ * empty the next request is started.
+ */
+void start_next_request(struct pcd_ep *ep)
+{
+	struct pcd_request *req = NULL;
+
+	if (!list_empty(&ep->queue)) {
+		req = list_entry(ep->queue.next, struct pcd_request, queue);
+
+		/* Setup and start the Transfer */
+		ep->dwc_ep.start_xfer_buff = req->req.buf;
+		ep->dwc_ep.xfer_buff = req->req.buf;
+		ep->dwc_ep.xfer_len = req->req.length;
+		ep->dwc_ep.xfer_count = 0;
+		ep->dwc_ep.dma_addr = req->req.dma;
+		ep->dwc_ep.sent_zlp = 0;
+		ep->dwc_ep.total_len = ep->dwc_ep.xfer_len;
+
+		/*
+		 * Added-sr: 2007-07-26
+		 *
+		 * When a new transfer will be started, mark this
+		 * endpoint as active. This way it will be blocked
+		 * for further transfers, until the current transfer
+		 * is finished.
+		 */
+		if (dwc_has_feature(GET_CORE_IF(ep->pcd), DWC_LIMITED_XFER))
+			ep->dwc_ep.active = 1;
+
+		dwc_otg_ep_start_transfer(GET_CORE_IF(ep->pcd), &ep->dwc_ep);
+	}
+}
+
+/**
+ * This function handles the SOF Interrupts. At this time the SOF
+ * Interrupt is disabled.
+ */
+static int dwc_otg_pcd_handle_sof_intr(struct dwc_pcd *pcd)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	union gintsts_data gintsts;
+
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.sofintr = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+	return 1;
+}
+
+/**
+ * This function reads the 8 bytes of the setup packet from the Rx FIFO into the
+ * destination buffer.  It is called from the Rx Status Queue Level (RxStsQLvl)
+ * interrupt routine when a SETUP packet has been received in Slave mode.
+ */
+static void dwc_otg_read_setup_packet(struct core_if *core_if, u32 *dest)
+{
+	dest[0] = dwc_read_datafifo32(core_if->data_fifo[0]);
+	dest[1] = dwc_read_datafifo32(core_if->data_fifo[0]);
+}
+/**
+ * This function handles the Rx Status Queue Level Interrupt, which
+ * indicates that there is a least one packet in the Rx FIFO.  The
+ * packets are moved from the FIFO to memory, where they will be
+ * processed when the Endpoint Interrupt Register indicates Transfer
+ * Complete or SETUP Phase Done.
+ *
+ * Repeat the following until the Rx Status Queue is empty:
+ *	 -# Read the Receive Status Pop Register (GRXSTSP) to get Packet
+ *		info
+ *	 -# If Receive FIFO is empty then skip to step Clear the interrupt
+ *		and exit
+ *	 -# If SETUP Packet call dwc_otg_read_setup_packet to copy the
+ *		SETUP data to the buffer
+ *	 -# If OUT Data Packet call dwc_otg_read_packet to copy the data
+ *		to the destination buffer
+ */
+static int dwc_otg_pcd_handle_rx_status_q_level_intr(struct dwc_pcd *pcd)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union gintmsk_data gintmask = {.d32 = 0};
+	union device_grxsts_data status;
+	struct pcd_ep *ep;
+	union gintsts_data gintsts;
+
+	/* Disable the Rx Status Queue Level interrupt */
+	gintmask.b.rxstsqlvl = 1;
+	dwc_modify_reg32(&global_regs->gintmsk, gintmask.d32, 0);
+
+	/* Get the Status from the top of the FIFO */
+	status.d32 = dwc_read_reg32(&global_regs->grxstsp);
+
+	/* Get pointer to EP structure */
+	ep = get_out_ep(pcd, status.b.epnum);
+
+	switch (status.b.pktsts) {
+	case DWC_DSTS_GOUT_NAK:
+		break;
+	case DWC_STS_DATA_UPDT:
+		if (status.b.bcnt && ep->dwc_ep.xfer_buff) {
+			dwc_otg_read_packet(core_if, ep->dwc_ep.xfer_buff,
+						status.b.bcnt);
+			ep->dwc_ep.xfer_count += status.b.bcnt;
+			ep->dwc_ep.xfer_buff += status.b.bcnt;
+		}
+		break;
+	case DWC_STS_XFER_COMP:
+		break;
+	case DWC_DSTS_SETUP_COMP:
+		break;
+	case DWC_DSTS_SETUP_UPDT:
+		dwc_otg_read_setup_packet(core_if, pcd->setup_pkt->d32);
+		ep->dwc_ep.xfer_count += status.b.bcnt;
+		break;
+	default:
+		break;
+	}
+
+	/* Enable the Rx Status Queue Level interrupt */
+	dwc_modify_reg32(&global_regs->gintmsk, 0, gintmask.d32);
+
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.rxstsqlvl = 1;
+	dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+	return 1;
+}
+
+/**
+ * This function examines the Device IN Token Learning Queue to
+ * determine the EP number of the last IN token received.  This
+ * implementation is for the Mass Storage device where there are only
+ * 2 IN EPs (Control-IN and BULK-IN).
+ *
+ * The EP numbers for the first six IN Tokens are in DTKNQR1 and there
+ * are 8 EP Numbers in each of the other possible DTKNQ Registers.
+ */
+static int get_ep_of_last_in_token(struct core_if *core_if)
+{
+	struct device_global_regs *regs = core_if->dev_if->dev_global_regs;
+	const u32 TOKEN_Q_DEPTH = core_if->hwcfg2.b.dev_token_q_depth;
+
+	/* Number of Token Queue Registers */
+	const int DTKNQ_REG_CNT = (TOKEN_Q_DEPTH + 7) / 8;
+	union dtknq1_data dtknqr1;
+	u32 in_tkn_epnums[4];
+	int ndx;
+	u32 i;
+	u32 *addr = &regs->dtknqr1;
+	int epnum = 0;
+
+	/* Read the DTKNQ Registers */
+	for (i = 0; i <= DTKNQ_REG_CNT; i++) {
+		in_tkn_epnums[i] = dwc_read_reg32(addr);
+
+		if (addr == &regs->dvbusdis)
+			addr = &regs->dtknqr3_dthrctl;
+		else
+			++addr;
+	}
+
+	/* Copy the DTKNQR1 data to the bit field. */
+	dtknqr1.d32 = in_tkn_epnums[0];
+
+	/* Get the EP numbers */
+	in_tkn_epnums[0] = dtknqr1.b.epnums0_5;
+	ndx = dtknqr1.b.intknwptr - 1;
+
+	if (ndx == -1) {
+		/*
+		 * Calculate the max queue position.
+		 */
+		int cnt = TOKEN_Q_DEPTH;
+
+		if (TOKEN_Q_DEPTH <= 6)
+			cnt = TOKEN_Q_DEPTH - 1;
+		else if (TOKEN_Q_DEPTH <= 14)
+			cnt = TOKEN_Q_DEPTH - 7;
+		else if (TOKEN_Q_DEPTH <= 22)
+			cnt = TOKEN_Q_DEPTH - 15;
+		else
+			cnt = TOKEN_Q_DEPTH - 23;
+
+		epnum = (in_tkn_epnums[DTKNQ_REG_CNT - 1] >> (cnt * 4)) & 0xF;
+	} else {
+		if (ndx <= 5) {
+			epnum = (in_tkn_epnums[0] >> (ndx * 4)) & 0xF;
+		} else if (ndx <= 13) {
+			ndx -= 6;
+			epnum = (in_tkn_epnums[1] >> (ndx * 4)) & 0xF;
+		} else if (ndx <= 21) {
+			ndx -= 14;
+			epnum = (in_tkn_epnums[2] >> (ndx * 4)) & 0xF;
+		} else if (ndx <= 29) {
+			ndx -= 22;
+			epnum = (in_tkn_epnums[3] >> (ndx * 4)) & 0xF;
+		}
+	}
+
+	return epnum;
+}
+
+static inline int count_dwords(struct pcd_ep *ep, u32 len)
+{
+	if (len > ep->dwc_ep.maxpacket)
+		len = ep->dwc_ep.maxpacket;
+	return (len + 3) / 4;
+}
+
+/**
+ * This function writes a packet into the Tx FIFO associated with the EP.  For
+ * non-periodic EPs the non-periodic Tx FIFO is written.  For periodic EPs the
+ * periodic Tx FIFO associated with the EP is written with all packets for the
+ * next micro-frame.
+ *
+ * The buffer is padded to DWORD on a per packet basis in
+ * slave/dma mode if the MPS is not DWORD aligned.  The last packet, if
+ * short, is also padded to a multiple of DWORD.
+ *
+ * ep->xfer_buff always starts DWORD aligned in memory and is a
+ * multiple of DWORD in length
+ *
+ * ep->xfer_len can be any number of bytes
+ *
+ * ep->xfer_count is a multiple of ep->maxpacket until the last packet
+ *
+ * FIFO access is DWORD
+ */
+static void dwc_otg_ep_write_packet(struct core_if *core_if, struct dwc_ep *ep,
+				int dma)
+{
+	u32 i;
+	u32 byte_count;
+	u32 dword_count;
+	u32 *fifo;
+	u32 *data_buff = (u32 *) ep->xfer_buff;
+
+	if (ep->xfer_count >= ep->xfer_len)
+		return;
+
+	/* Find the byte length of the packet either short packet or MPS */
+	if ((ep->xfer_len - ep->xfer_count) < ep->maxpacket)
+		byte_count = ep->xfer_len - ep->xfer_count;
+	else
+		byte_count = ep->maxpacket;
+
+	/*
+	 * Find the DWORD length, padded by extra bytes as neccessary if MPS
+	 * is not a multiple of DWORD
+	 */
+	dword_count = (byte_count + 3) / 4;
+
+	fifo = core_if->data_fifo[ep->num];
+
+	if (!dma)
+		for (i = 0; i < dword_count; i++, data_buff++)
+			dwc_write_datafifo32(fifo, *data_buff);
+
+	ep->xfer_count += byte_count;
+	ep->xfer_buff += byte_count;
+	ep->dma_addr += byte_count;
+}
+
+/**
+ * This interrupt occurs when the non-periodic Tx FIFO is half-empty.
+ * The active request is checked for the next packet to be loaded into
+ * the non-periodic Tx FIFO.
+ */
+static int dwc_otg_pcd_handle_np_tx_fifo_empty_intr(struct dwc_pcd *pcd)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	union gnptxsts_data txstatus = {.d32 = 0 };
+	union gintsts_data gintsts = {.d32 = 0};
+	int epnum = 0;
+	struct pcd_ep *ep;
+	u32 len;
+	int dwords;
+
+	/* Get the epnum from the IN Token Learning Queue. */
+	epnum = get_ep_of_last_in_token(core_if);
+	ep = get_in_ep(pcd, epnum);
+
+	txstatus.d32 = dwc_read_reg32(&global_regs->gnptxsts);
+
+	/*
+	 * While there is space in the queue, space in the FIFO, and data to
+	 * tranfer, write packets to the Tx FIFO
+	 */
+	len = ep->dwc_ep.xfer_len - ep->dwc_ep.xfer_count;
+	dwords = count_dwords(ep, len);
+	while (txstatus.b.nptxqspcavail > 0 &&
+			txstatus.b.nptxfspcavail > dwords &&
+			ep->dwc_ep.xfer_count < ep->dwc_ep.xfer_len) {
+		/*
+		 * Added-sr: 2007-07-26
+		 *
+		 * When a new transfer will be started, mark this
+		 * endpoint as active. This way it will be blocked
+		 * for further transfers, until the current transfer
+		 * is finished.
+		 */
+		if (dwc_has_feature(core_if, DWC_LIMITED_XFER))
+			ep->dwc_ep.active = 1;
+
+		dwc_otg_ep_write_packet(core_if, &ep->dwc_ep, 0);
+		len = ep->dwc_ep.xfer_len - ep->dwc_ep.xfer_count;
+		dwords = count_dwords(ep, len);
+		txstatus.d32 = dwc_read_reg32(&global_regs->gnptxsts);
+	}
+
+	/* Clear nptxfempty interrupt */
+	gintsts.b.nptxfempty = 1;
+	dwc_write_reg32(&global_regs->gintsts, gintsts.d32);
+
+	/* Re-enable tx-fifo empty interrupt, if packets are stil pending */
+	if (len)
+		dwc_modify_reg32(&global_regs->gintmsk, 0, gintsts.d32);
+	return 1;
+}
+
+/**
+ * This function is called when dedicated Tx FIFO Empty interrupt occurs.
+ * The active request is checked for the next packet to be loaded into
+ * apropriate Tx FIFO.
+ */
+static int write_empty_tx_fifo(struct dwc_pcd *pcd, u32 epnum)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	struct device_in_ep_regs *regs;
+	union dtxfsts_data txstatus = {.d32 = 0};
+	struct pcd_ep *ep;
+	u32 len;
+	int dwords;
+	union diepint_data diepint;
+
+	ep = get_in_ep(pcd, epnum);
+	regs = core_if->dev_if->in_ep_regs[epnum];
+
+	txstatus.d32 = dwc_read_reg32(&regs->dtxfsts);
+
+	/*
+	 * While there is space in the queue, space in the FIFO and data to
+	 * tranfer, write packets to the Tx FIFO
+	 */
+	len = ep->dwc_ep.xfer_len - ep->dwc_ep.xfer_count;
+	dwords = count_dwords(ep, len);
+	while (txstatus.b.txfspcavail > dwords && ep->dwc_ep.xfer_count <
+			ep->dwc_ep.xfer_len && ep->dwc_ep.xfer_len != 0) {
+		dwc_otg_ep_write_packet(core_if, &ep->dwc_ep, 0);
+		len = ep->dwc_ep.xfer_len - ep->dwc_ep.xfer_count;
+		dwords = count_dwords(ep, len);
+		txstatus.d32 = dwc_read_reg32(&regs->dtxfsts);
+	}
+	/* Clear emptyintr */
+	diepint.b.emptyintr = 1;
+	dwc_write_reg32(in_ep_int_reg(pcd, epnum), diepint.d32);
+	return 1;
+}
+
+/**
+ * This function is called when the Device is disconnected.  It stops any active
+ * requests and informs the Gadget driver of the disconnect.
+ */
+void dwc_otg_pcd_stop(struct dwc_pcd *pcd)
+{
+	int i, num_in_eps, num_out_eps;
+	struct pcd_ep *ep;
+	union gintmsk_data intr_mask = {.d32 = 0};
+
+	num_in_eps = GET_CORE_IF(pcd)->dev_if->num_in_eps;
+	num_out_eps = GET_CORE_IF(pcd)->dev_if->num_out_eps;
+
+	/* Don't disconnect drivers more than once */
+	if (pcd->ep0state == EP0_DISCONNECT)
+		return;
+	pcd->ep0state = EP0_DISCONNECT;
+
+	/* Reset the OTG state. */
+	dwc_otg_pcd_update_otg(pcd, 1);
+
+	/* Disable the NP Tx Fifo Empty Interrupt. */
+	intr_mask.b.nptxfempty = 1;
+	dwc_modify_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintmsk,
+				intr_mask.d32, 0);
+
+	/* Flush the FIFOs */
+	dwc_otg_flush_tx_fifo(GET_CORE_IF(pcd), 0);
+	dwc_otg_flush_rx_fifo(GET_CORE_IF(pcd));
+
+	/* Prevent new request submissions, kill any outstanding requests  */
+	ep = &pcd->ep0;
+	request_nuke(ep);
+
+	/* Prevent new request submissions, kill any outstanding requests  */
+	for (i = 0; i < num_in_eps; i++)
+		request_nuke((struct pcd_ep *) &pcd->in_ep[i]);
+
+	/* Prevent new request submissions, kill any outstanding requests  */
+	for (i = 0; i < num_out_eps; i++)
+		request_nuke((struct pcd_ep *) &pcd->out_ep[i]);
+
+	/* Report disconnect; the driver is already quiesced */
+	if (pcd->driver && pcd->driver->disconnect) {
+		spin_unlock(&pcd->lock);
+		pcd->driver->disconnect(&pcd->gadget);
+		spin_lock(&pcd->lock);
+	}
+}
+
+/**
+ * This interrupt indicates that ...
+ */
+static int dwc_otg_pcd_handle_i2c_intr(struct dwc_pcd *pcd)
+{
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union gintsts_data gintsts;
+
+	printk(KERN_INFO "Interrupt handler not implemented for i2cintr\n");
+
+	/* Turn off and clean the interrupt */
+	intr_mask.b.i2cintr = 1;
+	dwc_modify_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintmsk,
+				intr_mask.d32, 0);
+
+	gintsts.d32 = 0;
+	gintsts.b.i2cintr = 1;
+	dwc_write_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintsts,
+				gintsts.d32);
+
+	return 1;
+}
+
+/**
+ * This interrupt indicates that ...
+ */
+static int dwc_otg_pcd_handle_early_suspend_intr(struct dwc_pcd *pcd)
+{
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union gintsts_data gintsts;
+
+	printk(KERN_INFO "Early Suspend Detected\n");
+
+	/* Turn off and clean the interrupt */
+	intr_mask.b.erlysuspend = 1;
+	dwc_modify_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintmsk,
+				intr_mask.d32, 0);
+
+	gintsts.d32 = 0;
+	gintsts.b.erlysuspend = 1;
+	dwc_write_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintsts,
+				gintsts.d32);
+
+	return 1;
+}
+
+/**
+ * This function configures EPO to receive SETUP packets.
+ *
+ * Program the following fields in the endpoint specific registers for Control
+ * OUT EP 0, in order to receive a setup packet:
+ *
+ * - DOEPTSIZ0.Packet Count = 3 (To receive up to 3 back to back setup packets)
+ *
+ * - DOEPTSIZE0.Transfer Size = 24 Bytes (To receive up to 3 back to back setup
+ *   packets)
+ *
+ * In DMA mode, DOEPDMA0 Register with a memory address to store any setup
+ * packets received
+ */
+static void ep0_out_start(struct core_if *core_if, struct dwc_pcd *pcd)
+{
+	struct device_if *dev_if = core_if->dev_if;
+	union deptsiz0_data doeptsize0 = {.d32 = 0};
+
+	doeptsize0.b.supcnt = 3;
+	doeptsize0.b.pktcnt = 1;
+	doeptsize0.b.xfersize = 8 * 3;
+	dwc_write_reg32(&dev_if->out_ep_regs[0]->doeptsiz, doeptsize0.d32);
+
+	if (core_if->dma_enable) {
+		union depctl_data doepctl = {.d32 = 0};
+
+		dwc_write_reg32(&dev_if->out_ep_regs[0]->doepdma,
+				pcd->setup_pkt_dma_handle);
+
+		doepctl.b.epena = 1;
+		doepctl.b.usbactep = 1;
+		dwc_write_reg32(out_ep_ctl_reg(pcd, 0), doepctl.d32);
+	}
+}
+
+/**
+ * This interrupt occurs when a USB Reset is detected.  When the USB Reset
+ * Interrupt occurs the device state is set to DEFAULT and the EP0 state is set
+ * to IDLE.
+ *
+ * Set the NAK bit for all OUT endpoints (DOEPCTLn.SNAK = 1)
+ *
+ * Unmask the following interrupt bits:
+ *  - DAINTMSK.INEP0 = 1 (Control 0 IN endpoint)
+ *  - DAINTMSK.OUTEP0 = 1 (Control 0 OUT endpoint)
+ *  - DOEPMSK.SETUP = 1
+ *  - DOEPMSK.XferCompl = 1
+ *  - DIEPMSK.XferCompl = 1
+ *  - DIEPMSK.TimeOut = 1
+ *
+ * Program the following fields in the endpoint specific registers for Control
+ * OUT EP 0, in order to receive a setup packet
+ *  - DOEPTSIZ0.Packet Count = 3 (To receive up to 3 back to back setup packets)
+ *  - DOEPTSIZE0.Transfer Size = 24 Bytes (To receive up to 3 back to back setup
+ *    packets)
+ *
+ *  - In DMA mode, DOEPDMA0 Register with a memory address to store any setup
+ *    packets received
+ *
+ * At this point, all the required initialization, except for enabling
+ * the control 0 OUT endpoint is done, for receiving SETUP packets.
+ *
+ * Note that the bits in the Device IN endpoint mask register (diepmsk) are laid
+ * out exactly the same as the Device IN endpoint interrupt register (diepint.)
+ * Likewise for Device OUT endpoint mask / interrupt registers (doepmsk /
+ * doepint.)
+ */
+static int dwc_otg_pcd_handle_usb_reset_intr(struct dwc_pcd *pcd)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	struct device_if *dev_if = core_if->dev_if;
+	union depctl_data doepctl = {.d32 = 0};
+	union daint_data daintmsk = {.d32 = 0};
+	union doepint_data doepmsk = {.d32 = 0};
+	union diepint_data diepmsk = {.d32 = 0};
+	union dcfg_data dcfg = {.d32 = 0};
+	union grstctl_data resetctl = {.d32 = 0};
+	union dctl_data dctl = {.d32 = 0};
+	u32 i;
+	union gintsts_data gintsts = {.d32 = 0 };
+
+	printk(KERN_INFO "USB RESET\n");
+
+	/* reset the HNP settings */
+	dwc_otg_pcd_update_otg(pcd, 1);
+
+	/* Clear the Remote Wakeup Signalling */
+	dctl.b.rmtwkupsig = 1;
+	dwc_modify_reg32(dev_ctl_reg(pcd), dctl.d32, 0);
+
+	/* Set NAK for all OUT EPs */
+	doepctl.b.snak = 1;
+	for (i = 0; i <= dev_if->num_out_eps; i++)
+		dwc_write_reg32(out_ep_ctl_reg(pcd, i), doepctl.d32);
+
+	/* Flush the NP Tx FIFO */
+	dwc_otg_flush_tx_fifo(core_if, 0);
+
+	/* Flush the Learning Queue */
+	resetctl.b.intknqflsh = 1;
+	dwc_write_reg32(&core_if->core_global_regs->grstctl, resetctl.d32);
+
+	daintmsk.b.inep0 = 1;
+	daintmsk.b.outep0 = 1;
+	dwc_write_reg32(&dev_if->dev_global_regs->daintmsk, daintmsk.d32);
+
+	doepmsk.b.setup = 1;
+	doepmsk.b.xfercompl = 1;
+	doepmsk.b.ahberr = 1;
+	doepmsk.b.epdisabled = 1;
+	dwc_write_reg32(&dev_if->dev_global_regs->doepmsk, doepmsk.d32);
+
+	diepmsk.b.xfercompl = 1;
+	diepmsk.b.timeout = 1;
+	diepmsk.b.epdisabled = 1;
+	diepmsk.b.ahberr = 1;
+	diepmsk.b.intknepmis = 1;
+	dwc_write_reg32(&dev_if->dev_global_regs->diepmsk, diepmsk.d32);
+
+	/* Reset Device Address */
+	dcfg.d32 = dwc_read_reg32(&dev_if->dev_global_regs->dcfg);
+	dcfg.b.devaddr = 0;
+	dwc_write_reg32(&dev_if->dev_global_regs->dcfg, dcfg.d32);
+
+	/* setup EP0 to receive SETUP packets */
+	ep0_out_start(core_if, pcd);
+
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.usbreset = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+
+	return 1;
+}
+
+/**
+ * Get the device speed from the device status register and convert it
+ * to USB speed constant.
+ */
+static int get_device_speed(struct dwc_pcd *pcd)
+{
+	union dsts_data dsts;
+	enum usb_device_speed speed = USB_SPEED_UNKNOWN;
+
+	dsts.d32 = dwc_read_reg32(dev_sts_reg(pcd));
+
+	switch (dsts.b.enumspd) {
+	case DWC_DSTS_ENUMSPD_HS_PHY_30MHZ_OR_60MHZ:
+		speed = USB_SPEED_HIGH;
+		break;
+	case DWC_DSTS_ENUMSPD_FS_PHY_30MHZ_OR_60MHZ:
+	case DWC_DSTS_ENUMSPD_FS_PHY_48MHZ:
+		speed = USB_SPEED_FULL;
+		break;
+	case DWC_DSTS_ENUMSPD_LS_PHY_6MHZ:
+		speed = USB_SPEED_LOW;
+		break;
+	}
+	return speed;
+}
+
+/**
+ * This function enables EP0 OUT to receive SETUP packets and configures EP0
+ * IN for transmitting packets.  It is normally called when the "Enumeration
+ * Done" interrupt occurs.
+ */
+static void dwc_otg_ep0_activate(struct core_if *core_if, struct dwc_ep *ep)
+{
+	struct device_if *dev_if = core_if->dev_if;
+	union dsts_data dsts;
+	union depctl_data diepctl;
+	union depctl_data doepctl;
+	union dctl_data dctl = {.d32 = 0};
+
+	/* Read the Device Status and Endpoint 0 Control registers */
+	dsts.d32 = dwc_read_reg32(&dev_if->dev_global_regs->dsts);
+	diepctl.d32 = dwc_read_reg32(&dev_if->in_ep_regs[0]->diepctl);
+	doepctl.d32 = dwc_read_reg32(&dev_if->out_ep_regs[0]->doepctl);
+
+	/* Set the MPS of the IN EP based on the enumeration speed */
+	switch (dsts.b.enumspd) {
+	case DWC_DSTS_ENUMSPD_HS_PHY_30MHZ_OR_60MHZ:
+	case DWC_DSTS_ENUMSPD_FS_PHY_30MHZ_OR_60MHZ:
+	case DWC_DSTS_ENUMSPD_FS_PHY_48MHZ:
+		diepctl.b.mps = DWC_DEP0CTL_MPS_64;
+		break;
+	case DWC_DSTS_ENUMSPD_LS_PHY_6MHZ:
+		diepctl.b.mps = DWC_DEP0CTL_MPS_8;
+		break;
+	}
+	dwc_write_reg32(&dev_if->in_ep_regs[0]->diepctl, diepctl.d32);
+
+	/* Enable OUT EP for receive */
+	doepctl.b.epena = 1;
+	dwc_write_reg32(&dev_if->out_ep_regs[0]->doepctl, doepctl.d32);
+
+	dctl.b.cgnpinnak = 1;
+	dwc_modify_reg32(&dev_if->dev_global_regs->dctl, dctl.d32, dctl.d32);
+}
+
+/**
+ * Read the device status register and set the device speed in the
+ * data structure.
+ * Set up EP0 to receive SETUP packets by calling dwc_ep0_activate.
+ */
+static int dwc_otg_pcd_handle_enum_done_intr(struct dwc_pcd *pcd)
+{
+	struct pcd_ep *ep0 = &pcd->ep0;
+	union gintsts_data gintsts;
+	union gusbcfg_data gusbcfg;
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	struct core_global_regs *global_regs = core_if->core_global_regs;
+	u32 gsnpsid = global_regs->gsnpsid;
+	u8 utmi16b, utmi8b;
+
+	if (gsnpsid >= (u32)0x4f54260a) {
+		utmi16b = 5;
+		utmi8b = 9;
+	} else {
+		utmi16b = 4;
+		utmi8b = 8;
+	}
+	dwc_otg_ep0_activate(GET_CORE_IF(pcd), &ep0->dwc_ep);
+
+	pcd->ep0state = EP0_IDLE;
+	ep0->stopped = 0;
+	pcd->gadget.speed = get_device_speed(pcd);
+
+	gusbcfg.d32 = dwc_read_reg32(&global_regs->gusbcfg);
+
+	/* Set USB turnaround time based on device speed and PHY interface. */
+	if (pcd->gadget.speed == USB_SPEED_HIGH) {
+		switch (core_if->hwcfg2.b.hs_phy_type) {
+		case DWC_HWCFG2_HS_PHY_TYPE_ULPI:
+			gusbcfg.b.usbtrdtim = 9;
+			break;
+		case DWC_HWCFG2_HS_PHY_TYPE_UTMI:
+			if (core_if->hwcfg4.b.utmi_phy_data_width == 0)
+				gusbcfg.b.usbtrdtim = utmi8b;
+			else if (core_if->hwcfg4.b.utmi_phy_data_width == 1)
+				gusbcfg.b.usbtrdtim = utmi16b;
+			else if (core_if->core_params->phy_utmi_width == 8)
+				gusbcfg.b.usbtrdtim = utmi8b;
+			else
+				gusbcfg.b.usbtrdtim = utmi16b;
+			break;
+		case DWC_HWCFG2_HS_PHY_TYPE_UTMI_ULPI:
+			if (gusbcfg.b.ulpi_utmi_sel == 1) {
+				gusbcfg.b.usbtrdtim = 9;
+			} else {
+				if (core_if->core_params->phy_utmi_width == 16)
+					gusbcfg.b.usbtrdtim = utmi16b;
+				else
+					gusbcfg.b.usbtrdtim = utmi8b;
+			}
+			break;
+		}
+	} else {
+		/* Full or low speed */
+		gusbcfg.b.usbtrdtim = 9;
+	}
+	dwc_write_reg32(&global_regs->gusbcfg, gusbcfg.d32);
+
+	/* Clear interrupt */
+	gintsts.d32 = 0;
+	gintsts.b.enumdone = 1;
+	dwc_write_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintsts,
+			 gintsts.d32);
+
+	return 1;
+}
+
+/**
+ * This interrupt indicates that the ISO OUT Packet was dropped due to
+ * Rx FIFO full or Rx Status Queue Full.  If this interrupt occurs
+ * read all the data from the Rx FIFO.
+ */
+static int dwc_otg_pcd_handle_isoc_out_packet_dropped_intr(struct dwc_pcd *pcd)
+{
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union gintsts_data gintsts;
+
+	printk(KERN_INFO "Interrupt Handler not implemented for ISOC Out "
+			"Dropped\n");
+
+	/* Turn off and clear the interrupt */
+	intr_mask.b.isooutdrop = 1;
+	dwc_modify_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintmsk,
+				intr_mask.d32, 0);
+
+	gintsts.d32 = 0;
+	gintsts.b.isooutdrop = 1;
+	dwc_write_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintsts,
+			 gintsts.d32);
+
+	return 1;
+}
+
+/**
+ * This interrupt indicates the end of the portion of the micro-frame
+ * for periodic transactions.  If there is a periodic transaction for
+ * the next frame, load the packets into the EP periodic Tx FIFO.
+ */
+static int dwc_otg_pcd_handle_end_periodic_frame_intr(struct dwc_pcd *pcd)
+{
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union gintsts_data gintsts;
+
+	printk(KERN_INFO "Interrupt handler not implemented for End of "
+		"Periodic Portion of Micro-Frame Interrupt");
+
+	/* Turn off and clear the interrupt */
+	intr_mask.b.eopframe = 1;
+	dwc_modify_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintmsk,
+				intr_mask.d32, 0);
+
+	gintsts.d32 = 0;
+	gintsts.b.eopframe = 1;
+	dwc_write_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintsts,
+				gintsts.d32);
+
+	return 1;
+}
+
+/**
+ * This interrupt indicates that EP of the packet on the top of the
+ * non-periodic Tx FIFO does not match EP of the IN Token received.
+ *
+ * The "Device IN Token Queue" Registers are read to determine the
+ * order the IN Tokens have been received.  The non-periodic Tx FIFO is flushed,
+ * so it can be reloaded in the order seen in the IN Token Queue.
+ */
+static int dwc_otg_pcd_handle_ep_mismatch_intr(struct core_if *core_if)
+{
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union gintsts_data gintsts;
+
+	printk(KERN_INFO "Interrupt handler not implemented for End Point "
+				"Mismatch\n");
+
+	/* Turn off and clear the interrupt */
+	intr_mask.b.epmismatch = 1;
+	dwc_modify_reg32(&core_if->core_global_regs->gintmsk,
+				intr_mask.d32, 0);
+
+	gintsts.d32 = 0;
+	gintsts.b.epmismatch = 1;
+	dwc_write_reg32(&core_if->core_global_regs->gintsts, gintsts.d32);
+	return 1;
+}
+
+/**
+ * This funcion stalls EP0.
+ */
+static void ep0_do_stall(struct dwc_pcd *pcd, const int val)
+{
+	struct pcd_ep *ep0 = &pcd->ep0;
+	struct usb_ctrlrequest *ctrl = &pcd->setup_pkt->req;
+
+	printk(KERN_WARNING "req %02x.%02x protocol STALL; err %d\n",
+		ctrl->bRequestType, ctrl->bRequest, val);
+
+	ep0->dwc_ep.is_in = 1;
+	dwc_otg_ep_set_stall(pcd->otg_dev->core_if, &ep0->dwc_ep);
+
+	pcd->ep0.stopped = 1;
+	pcd->ep0state = EP0_IDLE;
+	ep0_out_start(GET_CORE_IF(pcd), pcd);
+}
+
+/**
+ * This functions delegates the setup command to the gadget driver.
+ */
+static void do_gadget_setup(struct dwc_pcd *pcd,
+				   struct usb_ctrlrequest *ctrl)
+{
+	int ret = 0;
+
+	if (pcd->driver && pcd->driver->setup) {
+		spin_unlock(&pcd->lock);
+		ret = pcd->driver->setup(&pcd->gadget, ctrl);
+		spin_lock(&pcd->lock);
+
+		if (ret < 0)
+			ep0_do_stall(pcd, ret);
+
+		/** This is a g_file_storage gadget driver specific
+		 * workaround: a DELAYED_STATUS result from the fsg_setup
+		 * routine will result in the gadget queueing a EP0 IN status
+		 * phase for a two-stage control transfer.
+		 *
+		 * Exactly the same as a SET_CONFIGURATION/SET_INTERFACE except
+		 * that this is a class specific request.  Need a generic way to
+		 * know when the gadget driver will queue the status phase.
+		 *
+		 * Can we assume when we call the gadget driver setup() function
+		 * that it will always queue and require the following flag?
+		 * Need to look into this.
+		 */
+		if (ret == 256 + 999)
+			pcd->request_config = 1;
+	}
+}
+
+/**
+ * This function starts the Zero-Length Packet for the IN status phase
+ * of a 2 stage control transfer.
+ */
+static void do_setup_in_status_phase(struct dwc_pcd *pcd)
+{
+	struct pcd_ep *ep0 = &pcd->ep0;
+
+	if (pcd->ep0state == EP0_STALL)
+		return;
+
+	pcd->ep0state = EP0_STATUS;
+
+	ep0->dwc_ep.xfer_len = 0;
+	ep0->dwc_ep.xfer_count = 0;
+	ep0->dwc_ep.is_in = 1;
+	ep0->dwc_ep.dma_addr = pcd->setup_pkt_dma_handle;
+	dwc_otg_ep0_start_transfer(GET_CORE_IF(pcd), &ep0->dwc_ep);
+
+	/* Prepare for more SETUP Packets */
+	ep0_out_start(GET_CORE_IF(pcd), pcd);
+}
+
+/**
+ * This function starts the Zero-Length Packet for the OUT status phase
+ * of a 2 stage control transfer.
+ */
+static void do_setup_out_status_phase(struct dwc_pcd *pcd)
+{
+	struct pcd_ep *ep0 = &pcd->ep0;
+
+	if (pcd->ep0state == EP0_STALL)
+		return;
+	pcd->ep0state = EP0_STATUS;
+
+	ep0->dwc_ep.xfer_len = 0;
+	ep0->dwc_ep.xfer_count = 0;
+	ep0->dwc_ep.is_in = 0;
+	ep0->dwc_ep.dma_addr = pcd->setup_pkt_dma_handle;
+	dwc_otg_ep0_start_transfer(GET_CORE_IF(pcd), &ep0->dwc_ep);
+
+	/* Prepare for more SETUP Packets */
+	ep0_out_start(GET_CORE_IF(pcd), pcd);
+}
+
+/**
+ * Clear the EP halt (STALL) and if pending requests start the
+ * transfer.
+ */
+static void pcd_clear_halt(struct dwc_pcd *pcd, struct pcd_ep *ep)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+
+	if (!ep->dwc_ep.stall_clear_flag)
+		dwc_otg_ep_clear_stall(core_if, &ep->dwc_ep);
+
+	/* Reactive the EP */
+	dwc_otg_ep_activate(core_if, &ep->dwc_ep);
+
+	if (ep->stopped) {
+		ep->stopped = 0;
+		/* If there is a request in the EP queue start it */
+
+		/*
+		 * start_next_request(), outside of interrupt context at some
+		 * time after the current time, after a clear-halt setup packet.
+		 * Still need to implement ep mismatch in the future if a gadget
+		 * ever uses more than one endpoint at once
+		 */
+		if (core_if->dma_enable) {
+			ep->queue_sof = 1;
+			tasklet_schedule(pcd->start_xfer_tasklet);
+		} else {
+			/*
+			 * Added-sr: 2007-07-26
+			 *
+			 * To re-enable this endpoint it's important to
+			 * set this next_ep number. Otherwise the endpoint
+			 * will not get active again after stalling.
+			 */
+			if (dwc_has_feature(core_if, DWC_LIMITED_XFER))
+				start_next_request(ep);
+		}
+	}
+
+	/* Start Control Status Phase */
+	do_setup_in_status_phase(pcd);
+}
+
+/**
+ * This function is called when the SET_FEATURE TEST_MODE Setup packet is sent
+ * from the host.  The Device Control register is written with the Test Mode
+ * bits set to the specified Test Mode.  This is done as a tasklet so that the
+ * "Status" phase of the control transfer completes before transmitting the TEST
+ * packets.
+ *
+ */
+static void do_test_mode(unsigned long data)
+{
+	union dctl_data dctl;
+	struct dwc_pcd *pcd = (struct dwc_pcd *) data;
+	int test_mode = pcd->test_mode;
+
+	dctl.d32 = dwc_read_reg32(dev_ctl_reg(pcd));
+	switch (test_mode) {
+	case 1:		/* TEST_J */
+		dctl.b.tstctl = 1;
+		break;
+	case 2:		/* TEST_K */
+		dctl.b.tstctl = 2;
+		break;
+	case 3:		/* TEST_SE0_NAK */
+		dctl.b.tstctl = 3;
+		break;
+	case 4:		/* TEST_PACKET */
+		dctl.b.tstctl = 4;
+		break;
+	case 5:		/* TEST_FORCE_ENABLE */
+		dctl.b.tstctl = 5;
+		break;
+	}
+	dwc_write_reg32(dev_ctl_reg(pcd), dctl.d32);
+}
+
+/**
+ * This function process the SET_FEATURE Setup Commands.
+ */
+static void do_set_feature(struct dwc_pcd *pcd)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	struct core_global_regs *regs = core_if->core_global_regs;
+	struct usb_ctrlrequest ctrl = pcd->setup_pkt->req;
+	struct pcd_ep *ep = NULL;
+	int otg_cap = core_if->core_params->otg_cap;
+	union gotgctl_data gotgctl = {.d32 = 0};
+
+	switch (ctrl.bRequestType & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		switch (__le16_to_cpu(ctrl.wValue)) {
+		case USB_DEVICE_REMOTE_WAKEUP:
+			pcd->remote_wakeup_enable = 1;
+			break;
+		case USB_DEVICE_TEST_MODE:
+			/*
+			 * Setup the Test Mode tasklet to do the Test
+			 * Packet generation after the SETUP Status
+			 * phase has completed.
+			 */
+
+			pcd->test_mode_tasklet.next = 0;
+			pcd->test_mode_tasklet.state = 0;
+			atomic_set(&pcd->test_mode_tasklet.count, 0);
+
+			pcd->test_mode_tasklet.func = do_test_mode;
+			pcd->test_mode_tasklet.data = (unsigned long)pcd;
+			pcd->test_mode = __le16_to_cpu(ctrl.wIndex) >> 8;
+			tasklet_schedule(&pcd->test_mode_tasklet);
+
+			break;
+		case USB_DEVICE_B_HNP_ENABLE:
+			/* dev may initiate HNP */
+			if (otg_cap == DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE) {
+				pcd->b_hnp_enable = 1;
+				dwc_otg_pcd_update_otg(pcd, 0);
+				/*
+				 * gotgctl.devhnpen cleared by a
+				 * USB Reset?
+				 */
+				gotgctl.b.devhnpen = 1;
+				gotgctl.b.hnpreq = 1;
+				dwc_write_reg32(&regs->gotgctl, gotgctl.d32);
+			} else {
+				ep0_do_stall(pcd, -EOPNOTSUPP);
+			}
+			break;
+		case USB_DEVICE_A_HNP_SUPPORT:
+			/* RH port supports HNP */
+			if (otg_cap == DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE) {
+				pcd->a_hnp_support = 1;
+				dwc_otg_pcd_update_otg(pcd, 0);
+			} else {
+				ep0_do_stall(pcd, -EOPNOTSUPP);
+			}
+			break;
+		case USB_DEVICE_A_ALT_HNP_SUPPORT:
+			/* other RH port does */
+			if (otg_cap == DWC_OTG_CAP_PARAM_HNP_SRP_CAPABLE) {
+				pcd->a_alt_hnp_support = 1;
+				dwc_otg_pcd_update_otg(pcd, 0);
+			} else {
+				ep0_do_stall(pcd, -EOPNOTSUPP);
+			}
+			break;
+		}
+		do_setup_in_status_phase(pcd);
+		break;
+	case USB_RECIP_INTERFACE:
+		do_gadget_setup(pcd, &ctrl);
+		break;
+	case USB_RECIP_ENDPOINT:
+		if (__le16_to_cpu(ctrl.wValue) == USB_ENDPOINT_HALT) {
+			ep = get_ep_by_addr(pcd, __le16_to_cpu(ctrl.wIndex));
+
+			if (ep == 0) {
+				ep0_do_stall(pcd, -EOPNOTSUPP);
+				return;
+			}
+
+			ep->stopped = 1;
+			dwc_otg_ep_set_stall(core_if, &ep->dwc_ep);
+		}
+		do_setup_in_status_phase(pcd);
+		break;
+	}
+}
+
+/**
+ * This function process the CLEAR_FEATURE Setup Commands.
+ */
+static void do_clear_feature(struct dwc_pcd *pcd)
+{
+	struct usb_ctrlrequest ctrl = pcd->setup_pkt->req;
+	struct pcd_ep *ep = NULL;
+
+	switch (ctrl.bRequestType & USB_RECIP_MASK) {
+	case USB_RECIP_DEVICE:
+		switch (__le16_to_cpu(ctrl.wValue)) {
+		case USB_DEVICE_REMOTE_WAKEUP:
+			pcd->remote_wakeup_enable = 0;
+			break;
+		case USB_DEVICE_TEST_MODE:
+			/* Add CLEAR_FEATURE for TEST modes. */
+			break;
+		}
+		do_setup_in_status_phase(pcd);
+		break;
+	case USB_RECIP_ENDPOINT:
+		ep = get_ep_by_addr(pcd, __le16_to_cpu(ctrl.wIndex));
+		if (ep == 0) {
+			ep0_do_stall(pcd, -EOPNOTSUPP);
+			return;
+		}
+
+		pcd_clear_halt(pcd, ep);
+		break;
+	}
+}
+
+/**
+ * This function processes SETUP commands.  In Linux, the USB Command processing
+ * is done in two places - the first being the PCD and the second in the Gadget
+ * Driver (for example, the File-Backed Storage Gadget Driver).
+ *
+ * GET_STATUS: Command is processed as defined in chapter 9 of the USB 2.0
+ * Specification chapter 9
+ *
+ * CLEAR_FEATURE: The Device and Endpoint requests are the ENDPOINT_HALT feature
+ * is procesed, all others the interface requests are ignored.
+ *
+ * SET_FEATURE: The Device and Endpoint requests are processed by the PCD.
+ * Interface requests are passed to the Gadget Driver.
+ *
+ * SET_ADDRESS: PCD, Program the DCFG reg, with device address received
+ *
+ * GET_DESCRIPTOR: Gadget Driver, Return the requested descriptor
+ *
+ * SET_DESCRIPTOR: Gadget Driver, Optional - not implemented by any of the
+ * existing Gadget Drivers.
+ *
+ * SET_CONFIGURATION: Gadget Driver, Disable all EPs and enable EPs for new
+ * configuration.
+ *
+ * GET_CONFIGURATION: Gadget Driver, Return the current configuration
+ *
+ * SET_INTERFACE: Gadget Driver, Disable all EPs and enable EPs for new
+ * configuration.
+ *
+ * GET_INTERFACE: Gadget Driver, Return the current interface.
+ *
+ * SYNC_FRAME:  Display debug message.
+ *
+ * When the SETUP Phase Done interrupt occurs, the PCD SETUP commands are
+ * processed by pcd_setup. Calling the Function Driver's setup function from
+ * pcd_setup processes the gadget SETUP commands.
+ */
+static void pcd_setup(struct dwc_pcd *pcd)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	struct device_if *dev_if = core_if->dev_if;
+	struct usb_ctrlrequest ctrl = pcd->setup_pkt->req;
+	struct pcd_ep *ep;
+	struct pcd_ep *ep0 = &pcd->ep0;
+	u16 *status = pcd->status_buf;
+	union deptsiz0_data doeptsize0 = {.d32 = 0};
+
+	doeptsize0.d32 = dwc_read_reg32(&dev_if->out_ep_regs[0]->doeptsiz);
+
+	/* handle > 1 setup packet , assert error for now */
+	if (core_if->dma_enable && (doeptsize0.b.supcnt < 2))
+		printk(KERN_ERR "\n\n	 CANNOT handle > 1 setup packet in "
+				"DMA mode\n\n");
+
+	/* Clean up the request queue */
+	request_nuke(ep0);
+	ep0->stopped = 0;
+
+	if (ctrl.bRequestType & USB_DIR_IN) {
+		ep0->dwc_ep.is_in = 1;
+		pcd->ep0state = EP0_IN_DATA_PHASE;
+	} else {
+		ep0->dwc_ep.is_in = 0;
+		pcd->ep0state = EP0_OUT_DATA_PHASE;
+	}
+
+	if ((ctrl.bRequestType & USB_TYPE_MASK) != USB_TYPE_STANDARD) {
+		/*
+		 * Handle non-standard (class/vendor) requests in the gadget
+		 * driver
+		 */
+		do_gadget_setup(pcd, &ctrl);
+		return;
+	}
+
+	switch (ctrl.bRequest) {
+	case USB_REQ_GET_STATUS:
+		switch (ctrl.bRequestType & USB_RECIP_MASK) {
+		case USB_RECIP_DEVICE:
+			*status = 0x1;		/* Self powered */
+			*status |= pcd->remote_wakeup_enable << 1;
+			break;
+		case USB_RECIP_INTERFACE:
+			*status = 0;
+			break;
+		case USB_RECIP_ENDPOINT:
+			ep = get_ep_by_addr(pcd, __le16_to_cpu(ctrl.wIndex));
+			if (ep == 0 || __le16_to_cpu(ctrl.wLength) > 2) {
+				ep0_do_stall(pcd, -EOPNOTSUPP);
+				return;
+			}
+			*status = ep->stopped;
+			break;
+		}
+
+		*status = __cpu_to_le16(*status);
+
+		pcd->ep0_pending = 1;
+		ep0->dwc_ep.start_xfer_buff = (u8 *) status;
+		ep0->dwc_ep.xfer_buff = (u8 *) status;
+		ep0->dwc_ep.dma_addr = pcd->status_buf_dma_handle;
+		ep0->dwc_ep.xfer_len = 2;
+		ep0->dwc_ep.xfer_count = 0;
+		ep0->dwc_ep.total_len = ep0->dwc_ep.xfer_len;
+		dwc_otg_ep0_start_transfer(GET_CORE_IF(pcd), &ep0->dwc_ep);
+		break;
+	case USB_REQ_CLEAR_FEATURE:
+		do_clear_feature(pcd);
+		break;
+	case USB_REQ_SET_FEATURE:
+		do_set_feature(pcd);
+		break;
+	case USB_REQ_SET_ADDRESS:
+		if (ctrl.bRequestType == USB_RECIP_DEVICE) {
+			union dcfg_data dcfg = {.d32 = 0};
+
+			dcfg.b.devaddr = __le16_to_cpu(ctrl.wValue);
+			dwc_modify_reg32(&dev_if->dev_global_regs->dcfg, 0,
+						dcfg.d32);
+			do_setup_in_status_phase(pcd);
+			return;
+		}
+		break;
+	case USB_REQ_SET_INTERFACE:
+	case USB_REQ_SET_CONFIGURATION:
+		pcd->request_config = 1;	/* Configuration changed */
+		do_gadget_setup(pcd, &ctrl);
+		break;
+	case USB_REQ_SYNCH_FRAME:
+		do_gadget_setup(pcd, &ctrl);
+		break;
+	default:
+		/* Call the Gadget Driver's setup functions */
+		do_gadget_setup(pcd, &ctrl);
+		break;
+	}
+}
+
+/**
+ * This function completes the ep0 control transfer.
+ */
+static int ep0_complete_request(struct pcd_ep *ep)
+{
+	struct core_if *core_if = GET_CORE_IF(ep->pcd);
+	struct device_if *dev_if = core_if->dev_if;
+	struct device_in_ep_regs *in_regs = dev_if->in_ep_regs[ep->dwc_ep.num];
+	union deptsiz0_data deptsiz;
+	struct pcd_request *req;
+	int is_last = 0;
+	struct dwc_pcd *pcd = ep->pcd;
+
+	if (pcd->ep0_pending && list_empty(&ep->queue)) {
+		if (ep->dwc_ep.is_in)
+			do_setup_out_status_phase(pcd);
+		else
+			do_setup_in_status_phase(pcd);
+
+		pcd->ep0_pending = 0;
+		pcd->ep0state = EP0_STATUS;
+		return 1;
+	}
+
+	if (list_empty(&ep->queue))
+		return 0;
+
+	req = list_entry(ep->queue.next, struct pcd_request, queue);
+
+	if (pcd->ep0state == EP0_STATUS) {
+		is_last = 1;
+	} else if (ep->dwc_ep.is_in) {
+		deptsiz.d32 = dwc_read_reg32(&in_regs->dieptsiz);
+
+		if (deptsiz.b.xfersize == 0) {
+			req->req.actual = ep->dwc_ep.xfer_count;
+			do_setup_out_status_phase(pcd);
+		}
+	} else {
+		/* This is ep0-OUT */
+		req->req.actual = ep->dwc_ep.xfer_count;
+		do_setup_in_status_phase(pcd);
+	}
+
+	/* Complete the request */
+	if (is_last) {
+		request_done(ep, req, 0);
+		ep->dwc_ep.start_xfer_buff = 0;
+		ep->dwc_ep.xfer_buff = 0;
+		ep->dwc_ep.xfer_len = 0;
+		return 1;
+	}
+	return 0;
+}
+
+/**
+ * This function completes the request for the EP.  If there are additional
+ * requests for the EP in the queue they will be started.
+ */
+static void complete_ep(struct pcd_ep *ep)
+{
+	struct core_if *core_if = GET_CORE_IF(ep->pcd);
+	struct device_if *dev_if = core_if->dev_if;
+	struct device_in_ep_regs *in_ep_regs =
+		dev_if->in_ep_regs[ep->dwc_ep.num];
+	union deptsiz_data deptsiz;
+	struct pcd_request *req = NULL;
+	int is_last = 0;
+
+	/* Get any pending requests */
+	if (!list_empty(&ep->queue))
+		req = list_entry(ep->queue.next, struct pcd_request, queue);
+
+	if (ep->dwc_ep.is_in) {
+		deptsiz.d32 = dwc_read_reg32(&in_ep_regs->dieptsiz);
+
+		if (core_if->dma_enable  && !deptsiz.b.xfersize)
+			ep->dwc_ep.xfer_count = ep->dwc_ep.xfer_len;
+
+		if (deptsiz.b.xfersize == 0 && deptsiz.b.pktcnt == 0 &&
+				ep->dwc_ep.xfer_count == ep->dwc_ep.xfer_len)
+			is_last = 1;
+		else
+			printk(KERN_WARNING "Incomplete transfer (%s-%s "
+				"[siz=%d pkt=%d])\n", ep->ep.name,
+				ep->dwc_ep.is_in ? "IN" : "OUT",
+				deptsiz.b.xfersize, deptsiz.b.pktcnt);
+	} else {
+		struct device_out_ep_regs *out_ep_regs =
+		    dev_if->out_ep_regs[ep->dwc_ep.num];
+		deptsiz.d32 = dwc_read_reg32(&out_ep_regs->doeptsiz);
+		is_last = 1;
+	}
+
+	/* Complete the request */
+	if (is_last) {
+		/*
+		 * Added-sr: 2007-07-26
+		 *
+		 * Since the 405EZ (Ultra) only support 2047 bytes as
+		 * max transfer size, we have to split up bigger transfers
+		 * into multiple transfers of 1024 bytes sized messages.
+		 * I happens often, that transfers of 4096 bytes are
+		 * required (zero-gadget, file_storage-gadget).
+		 */
+		if ((dwc_has_feature(core_if, DWC_LIMITED_XFER)) &&
+				ep->dwc_ep.bytes_pending) {
+			struct device_in_ep_regs *in_regs =
+				core_if->dev_if->in_ep_regs[ep->dwc_ep.num];
+			union gintmsk_data intr_mask = { .d32 = 0};
+
+			ep->dwc_ep.xfer_len = ep->dwc_ep.bytes_pending;
+			if (ep->dwc_ep.xfer_len > MAX_XFER_LEN) {
+				ep->dwc_ep.bytes_pending = ep->dwc_ep.xfer_len -
+					MAX_XFER_LEN;
+				ep->dwc_ep.xfer_len = MAX_XFER_LEN;
+			} else {
+				ep->dwc_ep.bytes_pending = 0;
+			}
+
+			/*
+			 * Restart the current transfer with the next "chunk"
+			 * of data.
+			 */
+			ep->dwc_ep.xfer_count = 0;
+
+			deptsiz.d32 = dwc_read_reg32(&(in_regs->dieptsiz));
+			deptsiz.b.xfersize = ep->dwc_ep.xfer_len;
+			deptsiz.b.pktcnt = (ep->dwc_ep.xfer_len - 1 +
+				ep->dwc_ep.maxpacket) / ep->dwc_ep.maxpacket;
+			dwc_write_reg32(&in_regs->dieptsiz, deptsiz.d32);
+
+			intr_mask.b.nptxfempty = 1;
+			dwc_modify_reg32(&core_if->core_global_regs->gintsts,
+						intr_mask.d32, 0);
+			dwc_modify_reg32(&core_if->core_global_regs->gintmsk,
+						intr_mask.d32, intr_mask.d32);
+
+			/*
+			 * Just return here if message was not completely
+			 * transferred.
+			 */
+			return;
+		}
+		if (core_if->dma_enable)
+			req->req.actual = ep->dwc_ep.xfer_len -
+				deptsiz.b.xfersize;
+		else
+			req->req.actual = ep->dwc_ep.xfer_count;
+
+		request_done(ep, req, 0);
+		ep->dwc_ep.start_xfer_buff = 0;
+		ep->dwc_ep.xfer_buff = 0;
+		ep->dwc_ep.xfer_len = 0;
+
+		/* If there is a request in the queue start it. */
+		start_next_request(ep);
+	}
+}
+
+/**
+ * This function continues control IN transfers started by
+ * dwc_otg_ep0_start_transfer, when the transfer does not fit in a
+ * single packet.  NOTE: The DIEPCTL0/DOEPCTL0 registers only have one
+ * bit for the packet count.
+ */
+static void dwc_otg_ep0_continue_transfer(struct core_if *c_if,
+	struct dwc_ep *ep)
+{
+	union depctl_data depctl;
+	union deptsiz0_data deptsiz;
+	union gintmsk_data intr_mask = {.d32 = 0};
+	struct device_if *d_if = c_if->dev_if;
+	struct core_global_regs *glbl_regs = c_if->core_global_regs;
+
+	if (ep->is_in) {
+		struct device_in_ep_regs *in_regs = d_if->in_ep_regs[0];
+		union gnptxsts_data tx_status = {.d32 = 0};
+
+		tx_status.d32 = dwc_read_reg32(&glbl_regs->gnptxsts);
+
+		depctl.d32 = dwc_read_reg32(&in_regs->diepctl);
+		deptsiz.d32 = dwc_read_reg32(&in_regs->dieptsiz);
+
+		/*
+		 * Program the transfer size and packet count as follows:
+		 *   xfersize = N * maxpacket + short_packet
+		 *   pktcnt = N + (short_packet exist ? 1 : 0)
+		 */
+		if (ep->total_len - ep->xfer_count > ep->maxpacket)
+			deptsiz.b.xfersize = ep->maxpacket;
+		else
+			deptsiz.b.xfersize = ep->total_len - ep->xfer_count;
+
+		deptsiz.b.pktcnt = 1;
+		ep->xfer_len += deptsiz.b.xfersize;
+		dwc_write_reg32(&in_regs->dieptsiz, deptsiz.d32);
+
+		/* Write the DMA register */
+		if (c_if->hwcfg2.b.architecture == DWC_INT_DMA_ARCH)
+			dwc_write_reg32(&in_regs->diepdma, ep->dma_addr);
+
+		/* EP enable, IN data in FIFO */
+		depctl.b.cnak = 1;
+		depctl.b.epena = 1;
+		dwc_write_reg32(&in_regs->diepctl, depctl.d32);
+
+		/*
+		 * Enable the Non-Periodic Tx FIFO empty interrupt, the
+		 * data will be written into the fifo by the ISR.
+		 */
+		if (!c_if->dma_enable) {
+			/* First clear it from GINTSTS */
+			intr_mask.b.nptxfempty = 1;
+			dwc_write_reg32(&glbl_regs->gintsts, intr_mask.d32);
+
+			/* To avoid spurious NPTxFEmp intr */
+			dwc_modify_reg32(&glbl_regs->gintmsk, intr_mask.d32, 0);
+		}
+	}
+}
+
+/**
+ * This function handles EP0 Control transfers.
+ *
+ * The state of the control tranfers are tracked in ep0state
+ */
+static void handle_ep0(struct dwc_pcd *pcd)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	struct pcd_ep *ep0 = &pcd->ep0;
+
+	switch (pcd->ep0state) {
+	case EP0_DISCONNECT:
+		break;
+	case EP0_IDLE:
+		pcd->request_config = 0;
+		pcd_setup(pcd);
+		break;
+	case EP0_IN_DATA_PHASE:
+		if (core_if->dma_enable)
+			/*
+			 * For EP0 we can only program 1 packet at a time so we
+			 * need to do the calculations after each complete.
+			 * Call write_packet to make the calculations, as in
+			 * slave mode, and use those values to determine if we
+			 * can complete.
+			 */
+			dwc_otg_ep_write_packet(core_if, &ep0->dwc_ep, 1);
+		else
+			dwc_otg_ep_write_packet(core_if, &ep0->dwc_ep, 0);
+
+		if (ep0->dwc_ep.xfer_count < ep0->dwc_ep.total_len)
+			dwc_otg_ep0_continue_transfer(core_if, &ep0->dwc_ep);
+		else
+			ep0_complete_request(ep0);
+		break;
+	case EP0_OUT_DATA_PHASE:
+		ep0_complete_request(ep0);
+		break;
+	case EP0_STATUS:
+		ep0_complete_request(ep0);
+		pcd->ep0state = EP0_IDLE;
+		ep0->stopped = 1;
+		ep0->dwc_ep.is_in = 0;		/* OUT for next SETUP */
+
+		/* Prepare for more SETUP Packets */
+		if (core_if->dma_enable) {
+			ep0_out_start(core_if, pcd);
+		} else {
+			int i;
+			union depctl_data diepctl;
+
+			diepctl.d32 = dwc_read_reg32(in_ep_ctl_reg(pcd, 0));
+			if (pcd->ep0.queue_sof) {
+				pcd->ep0.queue_sof = 0;
+				start_next_request(&pcd->ep0);
+			}
+
+			diepctl.d32 = dwc_read_reg32(in_ep_ctl_reg(pcd, 0));
+			if (pcd->ep0.queue_sof) {
+				pcd->ep0.queue_sof = 0;
+				start_next_request(&pcd->ep0);
+			}
+
+			for (i = 0; i < core_if->dev_if->num_in_eps; i++) {
+				diepctl.d32 =
+					dwc_read_reg32(in_ep_ctl_reg(pcd, i));
+
+				if (pcd->in_ep[i].queue_sof) {
+					pcd->in_ep[i].queue_sof = 0;
+					start_next_request(&pcd->in_ep[i]);
+				}
+			}
+		}
+		break;
+	case EP0_STALL:
+		printk(KERN_ERR "EP0 STALLed, should not get here "
+				"handle_ep0()\n");
+		break;
+	}
+}
+
+/**
+ * Restart transfer
+ */
+static void restart_transfer(struct dwc_pcd *pcd, const u32 ep_num)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	struct device_if *dev_if = core_if->dev_if;
+	union deptsiz_data dieptsiz = {.d32 = 0};
+	struct pcd_ep *ep;
+
+	dieptsiz.d32 = dwc_read_reg32(&dev_if->in_ep_regs[ep_num]->dieptsiz);
+	ep = get_in_ep(pcd, ep_num);
+
+	/*
+	 * If pktcnt is not 0, and xfersize is 0, and there is a buffer,
+	 * resend the last packet.
+	 */
+	if (dieptsiz.b.pktcnt && !dieptsiz.b.xfersize &&
+			ep->dwc_ep.start_xfer_buff) {
+		if (ep->dwc_ep.xfer_len <= ep->dwc_ep.maxpacket) {
+			ep->dwc_ep.xfer_count = 0;
+			ep->dwc_ep.xfer_buff = ep->dwc_ep.start_xfer_buff;
+		} else {
+			ep->dwc_ep.xfer_count -= ep->dwc_ep.maxpacket;
+
+			/* convert packet size to dwords. */
+			ep->dwc_ep.xfer_buff -= ep->dwc_ep.maxpacket;
+		}
+		ep->stopped = 0;
+
+		if (!ep_num)
+			dwc_otg_ep0_start_transfer(core_if, &ep->dwc_ep);
+		else
+			dwc_otg_ep_start_transfer(core_if, &ep->dwc_ep);
+	}
+}
+
+/**
+ * Handle the IN EP Transfer Complete interrupt.
+ *
+ * If dedicated fifos are enabled, then the Tx FIFO empty interrupt for the EP
+ * is disabled.  Otherwise the NP Tx FIFO empty interrupt is  disabled.
+ */
+static void handle_in_ep_xfr_complete_intr(struct dwc_pcd *pcd,
+			struct pcd_ep *ep, u32 num)
+{
+	struct core_if *c_if = GET_CORE_IF(pcd);
+	struct device_if *d_if = c_if->dev_if;
+	struct dwc_ep *dwc_ep = &ep->dwc_ep;
+	union diepint_data epint = {.d32 = 0};
+
+	if (c_if->en_multiple_tx_fifo) {
+		u32 fifoemptymsk = 0x1 << dwc_ep->num;
+		dwc_modify_reg32(&d_if->dev_global_regs->dtknqr4_fifoemptymsk,
+					fifoemptymsk, 0);
+	} else {
+		union gintmsk_data intr_mask = {.d32 = 0};
+		intr_mask.b.nptxfempty = 1;
+		dwc_modify_reg32(&c_if->core_global_regs->gintmsk,
+					intr_mask.d32, 0);
+	}
+
+	/* Clear the interrupt, then complete the transfer */
+	epint.b.xfercompl = 1;
+	dwc_write_reg32(&d_if->in_ep_regs[num]->diepint, epint.d32);
+
+	if (!num)
+		handle_ep0(pcd);
+	else
+		complete_ep(ep);
+}
+
+/**
+ * Handle the IN EP disable interrupt.
+ */
+static void handle_in_ep_disable_intr(struct dwc_pcd *pcd,
+				const u32 ep_num)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	struct device_if *dev_if = core_if->dev_if;
+	union deptsiz_data dieptsiz = {.d32 = 0};
+	union dctl_data dctl = {.d32 = 0};
+	struct pcd_ep *ep;
+	struct dwc_ep *dwc_ep;
+	union diepint_data diepint = {.d32 = 0};
+
+	ep = get_in_ep(pcd, ep_num);
+	dwc_ep = &ep->dwc_ep;
+
+	dieptsiz.d32 = dwc_read_reg32(&dev_if->in_ep_regs[ep_num]->dieptsiz);
+
+	if (ep->stopped) {
+		/* Flush the Tx FIFO */
+		dwc_otg_flush_tx_fifo(core_if, dwc_ep->tx_fifo_num);
+
+		/* Clear the Global IN NP NAK */
+		dctl.d32 = 0;
+		dctl.b.cgnpinnak = 1;
+		dwc_modify_reg32(dev_ctl_reg(pcd), dctl.d32, 0);
+
+		if (dieptsiz.b.pktcnt || dieptsiz.b.xfersize)
+			restart_transfer(pcd, ep_num);
+	} else {
+		if (dieptsiz.b.pktcnt || dieptsiz.b.xfersize)
+			restart_transfer(pcd, ep_num);
+	}
+	/* Clear epdisabled */
+	diepint.b.epdisabled = 1;
+	dwc_write_reg32(in_ep_int_reg(pcd, ep_num), diepint.d32);
+
+}
+
+/**
+ * Handler for the IN EP timeout handshake interrupt.
+ */
+static void handle_in_ep_timeout_intr(struct dwc_pcd *pcd, const u32 ep_num)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	struct pcd_ep *ep;
+	union dctl_data dctl = {.d32 = 0};
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union diepint_data diepint = {.d32 = 0};
+
+	ep = get_in_ep(pcd, ep_num);
+
+	/* Disable the NP Tx Fifo Empty Interrrupt */
+	if (!core_if->dma_enable) {
+		intr_mask.b.nptxfempty = 1;
+		dwc_modify_reg32(&core_if->core_global_regs->gintmsk,
+					intr_mask.d32, 0);
+	}
+
+	/* Non-periodic EP */
+	/* Enable the Global IN NAK Effective Interrupt */
+	intr_mask.b.ginnakeff = 1;
+	dwc_modify_reg32(&core_if->core_global_regs->gintmsk, 0, intr_mask.d32);
+
+	/* Set Global IN NAK */
+	dctl.b.sgnpinnak = 1;
+	dwc_modify_reg32(dev_ctl_reg(pcd), dctl.d32, dctl.d32);
+	ep->stopped = 1;
+
+	/* Clear timeout */
+	diepint.b.timeout = 1;
+	dwc_write_reg32(in_ep_int_reg(pcd, ep_num), diepint.d32);
+}
+
+/**
+ * Handles the IN Token received with TxF Empty interrupt.
+ *
+ * For the 405EZ, only start the next transfer, when currently no other transfer
+ * is active on this endpoint.
+ *
+ * Note that the bits in the Device IN endpoint mask register are laid out
+ * exactly the same as the Device IN endpoint interrupt register.
+ */
+static void handle_in_ep_tx_fifo_empty_intr(struct dwc_pcd *pcd,
+			struct pcd_ep *ep, u32 num)
+{
+	union diepint_data diepint = {.d32 = 0};
+
+	if (!ep->stopped && num) {
+		union diepint_data diepmsk = {.d32 = 0};
+		diepmsk.b.intktxfemp = 1;
+		dwc_modify_reg32(dev_diepmsk_reg(pcd), diepmsk.d32, 0);
+
+		if (dwc_has_feature(GET_CORE_IF(pcd), DWC_LIMITED_XFER)) {
+			if (!ep->dwc_ep.active)
+				start_next_request(ep);
+		} else {
+			start_next_request(ep);
+		}
+	}
+	/* Clear intktxfemp */
+	diepint.b.intktxfemp = 1;
+	dwc_write_reg32(in_ep_int_reg(pcd, num), diepint.d32);
+}
+
+static void handle_in_ep_nak_effective_intr(struct dwc_pcd *pcd,
+			struct pcd_ep *ep, u32 num)
+{
+	union depctl_data diepctl = {.d32 = 0};
+	union diepint_data diepint = {.d32 = 0};
+
+	/* Periodic EP */
+	if (ep->disabling) {
+		diepctl.d32 = 0;
+		diepctl.b.snak = 1;
+		diepctl.b.epdis = 1;
+		dwc_modify_reg32(in_ep_ctl_reg(pcd, num), diepctl.d32,
+					diepctl.d32);
+	}
+	/* Clear inepnakeff */
+	diepint.b.inepnakeff = 1;
+	dwc_write_reg32(in_ep_int_reg(pcd, num), diepint.d32);
+
+}
+
+/**
+ * This function returns the Device IN EP Interrupt register
+ */
+static inline u32 dwc_otg_read_diep_intr(struct core_if *core_if,
+						struct dwc_ep *ep)
+{
+	struct device_if *dev_if = core_if->dev_if;
+	u32 v, msk, emp;
+	msk = dwc_read_reg32(&dev_if->dev_global_regs->diepmsk);
+	emp = dwc_read_reg32(&dev_if->dev_global_regs->dtknqr4_fifoemptymsk);
+	msk |= ((emp >> ep->num) & 0x1) << 7;
+	v = dwc_read_reg32(&dev_if->in_ep_regs[ep->num]->diepint) & msk;
+	return v;
+}
+
+/**
+ * This function reads the Device All Endpoints Interrupt register and
+ * returns the IN endpoint interrupt bits.
+ */
+static inline u32 dwc_otg_read_dev_all_in_ep_intr(struct core_if *_if)
+{
+	u32 v;
+	v = dwc_read_reg32(&_if->dev_if->dev_global_regs->daint) &
+		dwc_read_reg32(&_if->dev_if->dev_global_regs->daintmsk);
+	return v & 0xffff;
+}
+
+/**
+ * This interrupt indicates that an IN EP has a pending Interrupt.
+ * The sequence for handling the IN EP interrupt is shown below:
+ *
+ * - Read the Device All Endpoint Interrupt register
+ * - Repeat the following for each IN EP interrupt bit set (from LSB to MSB).
+ *
+ * - Read the Device Endpoint Interrupt (DIEPINTn) register
+ * - If "Transfer Complete" call the request complete function
+ * - If "Endpoint Disabled" complete the EP disable procedure.
+ * - If "AHB Error Interrupt" log error
+ * - If "Time-out Handshake" log error
+ * - If "IN Token Received when TxFIFO Empty" write packet to Tx FIFO.
+ * - If "IN Token EP Mismatch" (disable, this is handled by EP Mismatch
+ *   Interrupt)
+ */
+static int dwc_otg_pcd_handle_in_ep_intr(struct dwc_pcd *pcd)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	union diepint_data diepint = {.d32 = 0};
+	u32 ep_intr;
+	u32 epnum = 0;
+	struct pcd_ep *ep;
+	struct dwc_ep *dwc_ep;
+
+	/* Read in the device interrupt bits */
+	ep_intr = dwc_otg_read_dev_all_in_ep_intr(core_if);
+
+	/* Service the Device IN interrupts for each endpoint */
+	while (ep_intr) {
+		if (ep_intr & 0x1) {
+			union diepint_data c_diepint;
+
+			/* Get EP pointer */
+			ep = get_in_ep(pcd, epnum);
+			dwc_ep = &ep->dwc_ep;
+
+			diepint.d32 = dwc_otg_read_diep_intr(core_if, dwc_ep);
+
+			/* Transfer complete */
+			if (diepint.b.xfercompl)
+				handle_in_ep_xfr_complete_intr(pcd, ep, epnum);
+
+			/* Endpoint disable */
+			if (diepint.b.epdisabled)
+				handle_in_ep_disable_intr(pcd, epnum);
+
+			/* AHB Error */
+			if (diepint.b.ahberr) {
+				/* Clear ahberr */
+				c_diepint.d32 = 0;
+				c_diepint.b.ahberr = 1;
+				dwc_write_reg32(in_ep_int_reg(pcd, epnum),
+					c_diepint.d32);
+			}
+
+			/* TimeOUT Handshake (non-ISOC IN EPs) */
+			if (diepint.b.timeout)
+				handle_in_ep_timeout_intr(pcd, epnum);
+
+			/* IN Token received with TxF Empty */
+			if (diepint.b.intktxfemp)
+				handle_in_ep_tx_fifo_empty_intr(pcd, ep, epnum);
+
+			/* IN Token Received with EP mismatch */
+			if (diepint.b.intknepmis) {
+				/* Clear intknepmis */
+				c_diepint.d32 = 0;
+				c_diepint.b.intknepmis = 1;
+				dwc_write_reg32(in_ep_int_reg(pcd, epnum),
+					c_diepint.d32);
+			}
+
+			/* IN Endpoint NAK Effective */
+			if (diepint.b.inepnakeff)
+				handle_in_ep_nak_effective_intr(pcd, ep, epnum);
+
+			/* IN EP Tx FIFO Empty Intr */
+			if (diepint.b.emptyintr)
+				write_empty_tx_fifo(pcd, epnum);
+		}
+		epnum++;
+		ep_intr >>= 1;
+	}
+	return 1;
+}
+
+/**
+ * This function reads the Device All Endpoints Interrupt register and
+ * returns the OUT endpoint interrupt bits.
+ */
+static inline u32 dwc_otg_read_dev_all_out_ep_intr(struct core_if *_if)
+{
+	u32 v;
+	v = dwc_read_reg32(&_if->dev_if->dev_global_regs->daint) &
+		dwc_read_reg32(&_if->dev_if->dev_global_regs->daintmsk);
+	return (v & 0xffff0000) >> 16;
+}
+
+/**
+ * This function returns the Device OUT EP Interrupt register
+ */
+static inline u32 dwc_otg_read_doep_intr(struct core_if *core_if,
+						struct dwc_ep *ep)
+{
+	struct device_if *dev_if = core_if->dev_if;
+	u32 v;
+	v = dwc_read_reg32(&dev_if->out_ep_regs[ep->num]->doepint) &
+			dwc_read_reg32(&dev_if->dev_global_regs->doepmsk);
+	return v;
+}
+
+/**
+ * This interrupt indicates that an OUT EP has a pending Interrupt.
+ * The sequence for handling the OUT EP interrupt is shown below:
+ *
+ * - Read the Device All Endpoint Interrupt register.
+ * - Repeat the following for each OUT EP interrupt bit set (from LSB to MSB).
+ *
+ * - Read the Device Endpoint Interrupt (DOEPINTn) register
+ * - If "Transfer Complete" call the request complete function
+ * - If "Endpoint Disabled" complete the EP disable procedure.
+ * - If "AHB Error Interrupt" log error
+ * - If "Setup Phase Done" process Setup Packet (See Standard USB Command
+ *   Processing)
+ */
+static int dwc_otg_pcd_handle_out_ep_intr(struct dwc_pcd *pcd)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+	u32 ep_intr;
+	union doepint_data doepint = {.d32 = 0};
+	u32 epnum = 0;
+	struct dwc_ep *dwc_ep;
+
+	/* Read in the device interrupt bits */
+	ep_intr = dwc_otg_read_dev_all_out_ep_intr(core_if);
+	while (ep_intr) {
+		if (ep_intr & 0x1) {
+			union doepint_data c_doepint;
+
+			dwc_ep = &((get_out_ep(pcd, epnum))->dwc_ep);
+			doepint.d32 = dwc_otg_read_doep_intr(core_if, dwc_ep);
+
+			/* Transfer complete */
+			if (doepint.b.xfercompl) {
+				/* Clear xfercompl */
+				c_doepint.d32 = 0;
+				c_doepint.b.xfercompl = 1;
+				dwc_write_reg32(out_ep_int_reg(pcd, epnum),
+						c_doepint.d32);
+				if (epnum == 0)
+					handle_ep0(pcd);
+				else
+					complete_ep(get_out_ep(pcd, epnum));
+			}
+
+			/* Endpoint disable */
+			if (doepint.b.epdisabled) {
+				/* Clear epdisabled */
+				c_doepint.d32 = 0;
+				c_doepint.b.epdisabled = 1;
+				dwc_write_reg32(out_ep_int_reg(pcd, epnum),
+						c_doepint.d32);
+			}
+
+			/* AHB Error */
+			if (doepint.b.ahberr) {
+				c_doepint.d32 = 0;
+				c_doepint.b.ahberr = 1;
+				dwc_write_reg32(out_ep_int_reg(pcd, epnum),
+						c_doepint.d32);
+			}
+
+		    /* Setup Phase Done (control EPs) */
+		    if (doepint.b.setup) {
+				c_doepint.d32 = 0;
+				c_doepint.b.setup = 1;
+				dwc_write_reg32(out_ep_int_reg(pcd, epnum),
+						c_doepint.d32);
+				handle_ep0(pcd);
+			}
+		}
+		epnum++;
+		ep_intr >>= 1;
+	}
+	return 1;
+}
+
+/**
+ * Incomplete ISO IN Transfer Interrupt.  This interrupt indicates one of the
+ * following conditions occurred while transmitting an ISOC transaction.
+ *
+ * - Corrupted IN Token for ISOC EP.
+ * - Packet not complete in FIFO.
+ *
+ * The follow actions should be taken:
+ * - Determine the EP
+ * - Set incomplete flag in dwc_ep structure
+ *  - Disable EP.  When "Endpoint Disabled" interrupt is received Flush FIFO
+ */
+static int dwc_otg_pcd_handle_incomplete_isoc_in_intr(struct dwc_pcd *pcd)
+{
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union gintsts_data gintsts = {.d32 = 0};
+
+	printk(KERN_INFO "Interrupt handler not implemented for IN ISOC "
+				"Incomplete\n");
+
+	/* Turn off and clear the interrupt */
+	intr_mask.b.incomplisoin = 1;
+	dwc_modify_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintmsk,
+				intr_mask.d32, 0);
+
+	gintsts.b.incomplisoin = 1;
+	dwc_write_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintsts,
+				gintsts.d32);
+	return 1;
+}
+
+/**
+ * Incomplete ISO OUT Transfer Interrupt.  This interrupt indicates that the
+ * core has dropped an ISO OUT packet.  The following conditions can be the
+ * cause:
+ *
+ * - FIFO Full, the entire packet would not fit in the FIFO.
+ * - CRC Error
+ * - Corrupted Token
+ *
+ * The follow actions should be taken:
+ * - Determine the EP
+ * - Set incomplete flag in dwc_ep structure
+ * - Read any data from the FIFO
+ * - Disable EP.  When "Endpoint Disabled" interrupt is received re-enable EP.
+ */
+static int dwc_otg_pcd_handle_incomplete_isoc_out_intr(struct dwc_pcd *pcd)
+{
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union gintsts_data gintsts = {.d32 = 0};
+
+	printk(KERN_INFO "Interrupt handler not implemented for OUT ISOC "
+				"Incomplete\n");
+
+	/* Turn off and clear the interrupt */
+	intr_mask.b.incomplisoout = 1;
+	dwc_modify_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintmsk,
+				intr_mask.d32, 0);
+
+	gintsts.b.incomplisoout = 1;
+	dwc_write_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintsts,
+				gintsts.d32);
+	return 1;
+}
+
+/**
+ * This function handles the Global IN NAK Effective interrupt.
+ */
+static int dwc_otg_pcd_handle_in_nak_effective(struct dwc_pcd *pcd)
+{
+	struct device_if *dev_if = GET_CORE_IF(pcd)->dev_if;
+	union depctl_data diepctl = {.d32 = 0};
+	union depctl_data diepctl_rd = {.d32 = 0};
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union gintsts_data gintsts = {.d32 = 0};
+	u32 i;
+
+	/* Disable all active IN EPs */
+	diepctl.b.epdis = 1;
+	diepctl.b.snak = 1;
+	for (i = 0; i <= dev_if->num_in_eps; i++) {
+		diepctl_rd.d32 = dwc_read_reg32(in_ep_ctl_reg(pcd, i));
+		if (diepctl_rd.b.epena)
+			dwc_write_reg32(in_ep_ctl_reg(pcd, i), diepctl.d32);
+	}
+
+	/* Disable the Global IN NAK Effective Interrupt */
+	intr_mask.b.ginnakeff = 1;
+	dwc_modify_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintmsk,
+				intr_mask.d32, 0);
+
+	/* Clear interrupt */
+	gintsts.b.ginnakeff = 1;
+	dwc_write_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintsts,
+			gintsts.d32);
+	return 1;
+}
+
+/**
+ * This function handles the Global OUT NAK Effective interrupt.
+ */
+static int dwc_otg_pcd_handle_out_nak_effective(struct dwc_pcd *pcd)
+{
+	union gintmsk_data intr_mask = {.d32 = 0};
+	union gintsts_data gintsts = {.d32 = 0};
+
+	printk(KERN_INFO "Interrupt handler not implemented for Global IN "
+			"NAK Effective\n");
+
+	/* Turn off and clear the interrupt */
+	intr_mask.b.goutnakeff = 1;
+	dwc_modify_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintmsk,
+				intr_mask.d32, 0);
+
+	/* Clear goutnakeff */
+	gintsts.b.goutnakeff = 1;
+	dwc_write_reg32(&GET_CORE_IF(pcd)->core_global_regs->gintsts,
+				gintsts.d32);
+	return 1;
+}
+
+/**
+ * PCD interrupt handler.
+ *
+ * The PCD handles the device interrupts.  Many conditions can cause a
+ * device interrupt. When an interrupt occurs, the device interrupt
+ * service routine determines the cause of the interrupt and
+ * dispatches handling to the appropriate function. These interrupt
+ * handling functions are described below.
+ *
+ * All interrupt registers are processed from LSB to MSB.
+ *
+ */
+int dwc_otg_pcd_handle_intr(struct dwc_pcd *pcd)
+{
+	struct core_if *core_if = GET_CORE_IF(pcd);
+
+	union gintsts_data gintr_status;
+	int ret = 0;
+
+	if (dwc_otg_is_device_mode(core_if)) {
+		spin_lock(&pcd->lock);
+
+		gintr_status.d32 = dwc_otg_read_core_intr(core_if);
+		if (!gintr_status.d32) {
+			spin_unlock(&pcd->lock);
+			return 0;
+		}
+
+		if (gintr_status.b.sofintr)
+			ret |= dwc_otg_pcd_handle_sof_intr(pcd);
+		if (gintr_status.b.rxstsqlvl)
+			ret |= dwc_otg_pcd_handle_rx_status_q_level_intr(pcd);
+		if (gintr_status.b.nptxfempty)
+			ret |= dwc_otg_pcd_handle_np_tx_fifo_empty_intr(pcd);
+		if (gintr_status.b.ginnakeff)
+			ret |= dwc_otg_pcd_handle_in_nak_effective(pcd);
+		if (gintr_status.b.goutnakeff)
+			ret |= dwc_otg_pcd_handle_out_nak_effective(pcd);
+		if (gintr_status.b.i2cintr)
+			ret |= dwc_otg_pcd_handle_i2c_intr(pcd);
+		if (gintr_status.b.erlysuspend)
+			ret |= dwc_otg_pcd_handle_early_suspend_intr(pcd);
+		if (gintr_status.b.usbreset)
+			ret |= dwc_otg_pcd_handle_usb_reset_intr(pcd);
+		if (gintr_status.b.enumdone)
+			ret |= dwc_otg_pcd_handle_enum_done_intr(pcd);
+		if (gintr_status.b.isooutdrop)
+			ret |=
+			dwc_otg_pcd_handle_isoc_out_packet_dropped_intr(pcd);
+		if (gintr_status.b.eopframe)
+			ret |= dwc_otg_pcd_handle_end_periodic_frame_intr(pcd);
+		if (gintr_status.b.epmismatch)
+			ret |= dwc_otg_pcd_handle_ep_mismatch_intr(core_if);
+		if (gintr_status.b.inepint)
+			ret |= dwc_otg_pcd_handle_in_ep_intr(pcd);
+		if (gintr_status.b.outepintr)
+			ret |= dwc_otg_pcd_handle_out_ep_intr(pcd);
+		if (gintr_status.b.incomplisoin)
+			ret |= dwc_otg_pcd_handle_incomplete_isoc_in_intr(pcd);
+		if (gintr_status.b.incomplisoout)
+			ret |= dwc_otg_pcd_handle_incomplete_isoc_out_intr(pcd);
+
+		spin_unlock(&pcd->lock);
+	}
+	return ret;
+}
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index dd3b251..714d521 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -362,6 +362,27 @@ config USB_GADGET_MUSB_HDRC
 	  This OTG-capable silicon IP is used in dual designs including
 	  the TI DaVinci, OMAP 243x, OMAP 343x, TUSB 6010, and ADI Blackfin
 
+# dwc_otg builds in ../dwc_otg along with host support
+config USB_GADGET_DWC_HDRC
+	boolean "DesignWare USB Peripheral"
+	depends on DWC_OTG_MODE || DWC_DEVICE_ONLY
+	select USB_GADGET_DUALSPEED
+	select USB_GADGET_SELECTED
+	select USB_OTG
+	help
+	 This OTG-capable Designware USB IP
+
+config USB_OTG
+	boolean "OTG Support"
+	depends on USB_GADGET_DWC_HDRC
+	help
+	   The most notable feature of USB OTG is support for a
+	   "Dual-Role" device, which can act as either a device
+	   or a host.  The initial role choice can be changed
+	   later, when two dual-role devices talk to each other.
+
+	   Select this only if your board has a Mini-AB connector.
+
 config USB_GADGET_M66592
 	boolean "Renesas M66592 USB Peripheral Controller"
 	select USB_GADGET_DUALSPEED
diff --git a/drivers/usb/gadget/gadget_chips.h b/drivers/usb/gadget/gadget_chips.h
index e511fec..e190844 100644
--- a/drivers/usb/gadget/gadget_chips.h
+++ b/drivers/usb/gadget/gadget_chips.h
@@ -142,6 +142,11 @@
 #define gadget_is_s3c_hsotg(g)    0
 #endif
 
+#if defined(CONFIG_DWC_OTG_MODE) || defined(CONFIG_DWC_DEVICE_ONLY)
+#define gadget_is_dwc_otg_pcd(g)	(!strcmp("dwc_otg_pcd", (g)->name))
+#else
+#define gadget_is_dwc_otg_pcd(g)	0
+#endif
 
 /**
  * usb_gadget_controller_number - support bcdDevice id convention
@@ -200,6 +205,8 @@ static inline int usb_gadget_controller_number(struct usb_gadget *gadget)
 		return 0x25;
 	else if (gadget_is_s3c_hsotg(gadget))
 		return 0x26;
+	else if (gadget_is_dwc_otg_pcd(gadget))
+		return 0x27;
 	return -ENOENT;
 }
 
-- 
1.7.1
