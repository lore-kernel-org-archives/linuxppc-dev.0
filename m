Return-Path: <fchen@apm.com>
Received: from denmail01.apm.COM (denmail01-v4020.amcc.com [192.195.68.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2403CB6F0C
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 08:22:20 +1000 (EST)
From: Fushen Chen <fchen@apm.com>
To: linux-usb@vger.kernel.org
Subject: [PATCH 6/9] Add Synopsys DesignWare HS USB OTG Controller driver.
Date: Tue, 29 Jun 2010 14:26:59 -0700
Message-Id: <12778468242972-git-send-email-fchen@apm.com>
In-Reply-To: <12778468242073-git-send-email-fchen@apm.com>
References: <12778468223309-git-send-email-fchen@apm.com>
	<12778468233898-git-send-email-fchen@apm.com>
	<12778468231438-git-send-email-fchen@apm.com>
	<1277846824673-git-send-email-fchen@apm.com>
	<12778468242073-git-send-email-fchen@apm.com>
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

Implements functions to manage Queue Heads and Queue
Transfer Descriptors of DWC USB OTG Controller.

Signed-off-by: Fushen Chen <fchen@apm.com>
Signed-off-by: Mark Miesfeld <mmiesfeld@apm.com>
---
 drivers/usb/otg/dwc_otg_hcd_queue.c |  584 +++++++++++++++++++++++++++++++++++
 1 files changed, 584 insertions(+), 0 deletions(-)
 create mode 100644 drivers/usb/otg/dwc_otg_hcd_queue.c

diff --git a/drivers/usb/otg/dwc_otg_hcd_queue.c b/drivers/usb/otg/dwc_otg_hcd_queue.c
new file mode 100644
index 0000000..a33c0da
--- /dev/null
+++ b/drivers/usb/otg/dwc_otg_hcd_queue.c
@@ -0,0 +1,584 @@
+/*
+ * DesignWare HS OTG controller driver
+ *
+ * Author: Mark Miesfeld <mmiesfeld@apm.com>
+ *
+ * Based on versions provided by AMCC and Synopsis which are:
+ *	Copyright (C) 2009-2010 AppliedMicro(www.apm.com)
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
+ * This file contains the functions to manage Queue Heads and Queue
+ * Transfer Descriptors.
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/list.h>
+#include <linux/interrupt.h>
+#include <linux/string.h>
+
+#include "dwc_otg_driver.h"
+#include "dwc_otg_hcd.h"
+#include "dwc_otg_regs.h"
+
+static inline int is_fs_ls(enum usb_device_speed speed)
+{
+	return speed == USB_SPEED_FULL || speed == USB_SPEED_LOW;
+}
+
+/* Allocates memory for a QH structure. */
+static inline struct dwc_qh *dwc_otg_hcd_qh_alloc(void)
+{
+	return kmalloc(sizeof(struct dwc_qh), GFP_ATOMIC);
+}
+
+/**
+ * Initializes a QH structure to initialize the QH.
+ */
+#define SCHEDULE_SLOP 10
+static void dwc_otg_hcd_qh_init(struct dwc_hcd *hcd, struct dwc_qh *qh,
+	struct urb *urb)
+{
+	memset(qh, 0, sizeof(struct dwc_qh));
+
+	/* Initialize QH */
+	switch (usb_pipetype(urb->pipe)) {
+	case PIPE_CONTROL:
+		qh->ep_type = USB_ENDPOINT_XFER_CONTROL;
+		break;
+	case PIPE_BULK:
+		qh->ep_type = USB_ENDPOINT_XFER_BULK;
+		break;
+	case PIPE_ISOCHRONOUS:
+		qh->ep_type = USB_ENDPOINT_XFER_ISOC;
+		break;
+	case PIPE_INTERRUPT:
+		qh->ep_type = USB_ENDPOINT_XFER_INT;
+		break;
+	}
+
+	qh->ep_is_in = usb_pipein(urb->pipe) ? 1 : 0;
+	qh->data_toggle = DWC_OTG_HC_PID_DATA0;
+	qh->maxp = usb_maxpacket(urb->dev, urb->pipe, !(usb_pipein(urb->pipe)));
+
+	INIT_LIST_HEAD(&qh->qtd_list);
+	INIT_LIST_HEAD(&qh->qh_list_entry);
+
+	qh->channel = NULL;
+
+	/*
+	 * FS/LS Enpoint on HS Hub NOT virtual root hub
+	 */
+	qh->do_split = 0;
+	if (is_fs_ls(urb->dev->speed) && urb->dev->tt && urb->dev->tt->hub &&
+	    urb->dev->tt->hub->devnum != 1)
+		qh->do_split = 1;
+
+	if (qh->ep_type == USB_ENDPOINT_XFER_INT ||
+	    qh->ep_type == USB_ENDPOINT_XFER_ISOC) {
+		/* Compute scheduling parameters once and save them. */
+		union hprt0_data hprt;
+		int bytecount = dwc_hb_mult(qh->maxp) *
+			dwc_max_packet(qh->maxp);
+
+		qh->usecs = usb_calc_bus_time(urb->dev->speed,
+				usb_pipein(urb->pipe),
+				(qh->ep_type == USB_ENDPOINT_XFER_ISOC),
+				bytecount);
+
+		/* Start in a slightly future (micro)frame. */
+		qh->sched_frame = dwc_frame_num_inc(hcd->frame_number,
+							SCHEDULE_SLOP);
+		qh->interval = urb->interval;
+
+		hprt.d32 = dwc_read_reg32(hcd->core_if->host_if->hprt0);
+		if (hprt.b.prtspd == DWC_HPRT0_PRTSPD_HIGH_SPEED &&
+		    is_fs_ls(urb->dev->speed)) {
+			qh->interval *= 8;
+			qh->sched_frame |= 0x7;
+			qh->start_split_frame = qh->sched_frame;
+		}
+	}
+}
+
+/**
+ * This function allocates and initializes a QH.
+ */
+static struct dwc_qh *dwc_otg_hcd_qh_create(struct dwc_hcd *hcd,
+		struct urb *urb)
+{
+	struct dwc_qh *qh;
+
+	/* Allocate memory */
+	qh = dwc_otg_hcd_qh_alloc();
+	if (qh == NULL)
+		return NULL;
+
+	dwc_otg_hcd_qh_init(hcd, qh, urb);
+	return qh;
+}
+
+/**
+ * Free each QTD in the QH's QTD-list then free the QH.  QH should already be
+ * removed from a list.  QTD list should already be empty if called from URB
+ * Dequeue.
+ */
+void dwc_otg_hcd_qh_free(struct dwc_qh *qh)
+{
+	struct dwc_qtd *qtd;
+	struct list_head *pos, *temp;
+
+	/* Free each QTD in the QTD list */
+	list_for_each_safe(pos, temp, &qh->qtd_list) {
+		list_del(pos);
+		qtd = dwc_list_to_qtd(pos);
+		dwc_otg_hcd_qtd_free(qtd);
+	}
+	kfree(qh);
+}
+
+
+
+/**
+ * Checks that a channel is available for a periodic transfer.
+ *
+ * Currently assuming that there is a dedicated host channnel for each
+ * periodic transaction plus at least one host channel for non-periodic
+ * transactions.
+ */
+static int periodic_channel_available(struct dwc_hcd *hcd)
+{
+	int status;
+	int total = hcd->core_if->core_params->host_channels;
+
+	if (hcd->periodic_channels + hcd->non_periodic_channels < total &&
+	    hcd->periodic_channels < total - 1) {
+		status = 0;
+	} else {
+		printk(KERN_NOTICE "%s: Total channels: %d, Periodic: %d, "
+			"Non-periodic: %d\n", __func__, total,
+			hcd->periodic_channels,
+			hcd->non_periodic_channels);
+		status = -ENOSPC;
+	}
+
+	return status;
+}
+
+/**
+ * Checks that there is sufficient bandwidth for the specified QH in the
+ * periodic schedule. For simplicity, this calculation assumes that all the
+ * transfers in the periodic schedule may occur in the same (micro)frame.
+ */
+static int check_periodic_bandwidth(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	int status = 0;
+	u16 max_claimed_usecs;
+
+	/*
+	 * For high speed mode:
+	 * Max periodic usecs is 80% x 125 usec = 100 usec.
+	 *
+	 * For full speed mode:
+	 * Max periodic usecs is 90% x 1000 usec = 900 usec.
+	 */
+	if (hcd->core_if->core_params->speed == DWC_SPEED_PARAM_HIGH)
+		max_claimed_usecs = 100 - qh->usecs;
+	else
+		max_claimed_usecs = 900 - qh->usecs;
+
+	if (hcd->periodic_usecs > max_claimed_usecs) {
+		printk(KERN_NOTICE "%s: already claimed usecs %d, required "
+			"usecs %d\n", __func__, hcd->periodic_usecs,
+			qh->usecs);
+		status = -ENOSPC;
+	}
+
+	return status;
+}
+
+/**
+ * Checks that the max transfer size allowed in a host channel is large enough
+ * to handle the maximum data transfer in a single (micro)frame for a periodic
+ * transfer.
+ */
+static int check_max_xfer_size(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	int status = 0;
+	u32 max_xfer_size;
+	u32 max_channel_xfer_size;
+
+	max_xfer_size = dwc_max_packet(qh->maxp) * dwc_hb_mult(qh->maxp);
+	max_channel_xfer_size = hcd->core_if->core_params->max_transfer_size;
+
+	if (max_xfer_size > max_channel_xfer_size) {
+		printk(KERN_NOTICE "%s: Periodic xfer length %d > max xfer "
+			"length for channel %d\n", __func__, max_xfer_size,
+			max_channel_xfer_size);
+		status = -ENOSPC;
+	}
+
+	return status;
+}
+
+/**
+ * Schedules an interrupt or isochronous transfer in the periodic schedule.
+ */
+static int schedule_periodic(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	int status;
+	struct usb_bus *bus = hcd_to_bus(dwc_otg_hcd_to_hcd(hcd));
+
+	status = periodic_channel_available(hcd);
+	if (status) {
+		printk(KERN_NOTICE "%s: No host channel available for periodic "
+			"transfer.\n", __func__);
+		return status;
+	}
+
+	status = check_periodic_bandwidth(hcd, qh);
+	if (status) {
+		printk(KERN_NOTICE "%s: Insufficient periodic bandwidth for "
+			"periodic transfer.\n", __func__);
+		return status;
+	}
+
+	status = check_max_xfer_size(hcd, qh);
+	if (status) {
+		printk(KERN_NOTICE "%s: Channel max transfer size too small "
+			"for periodic transfer.\n", __func__);
+		return status;
+	}
+
+	/* Always start in the inactive schedule. */
+	list_add_tail(&qh->qh_list_entry, &hcd->periodic_sched_inactive);
+
+	/* Reserve the periodic channel. */
+	hcd->periodic_channels++;
+
+	/* Update claimed usecs per (micro)frame. */
+	hcd->periodic_usecs += qh->usecs;
+
+	/*
+	 * Update average periodic bandwidth claimed and # periodic reqs for
+	 * usbfs.
+	 */
+	bus->bandwidth_allocated += qh->usecs / qh->interval;
+
+	if (qh->ep_type == USB_ENDPOINT_XFER_INT)
+		bus->bandwidth_int_reqs++;
+	else
+		bus->bandwidth_isoc_reqs++;
+
+	return status;
+}
+
+/**
+ * This function adds a QH to either the non periodic or periodic schedule if
+ * it is not already in the schedule. If the QH is already in the schedule, no
+ * action is taken.
+ */
+static int dwc_otg_hcd_qh_add(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	int status = 0;
+
+	/* QH may already be in a schedule. */
+	if (!list_empty(&qh->qh_list_entry))
+		goto done;
+
+	/*
+	 * Add the new QH to the appropriate schedule. For non-periodic, always
+	 * start in the inactive schedule.
+	 */
+	if (dwc_qh_is_non_per(qh))
+		list_add_tail(&qh->qh_list_entry,
+			&hcd->non_periodic_sched_inactive);
+	else
+		status = schedule_periodic(hcd, qh);
+
+done:
+	return status;
+}
+
+/**
+ * Removes an interrupt or isochronous transfer from the periodic schedule.
+ */
+static void deschedule_periodic(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	struct usb_bus *bus = hcd_to_bus(dwc_otg_hcd_to_hcd(hcd));
+
+	list_del_init(&qh->qh_list_entry);
+
+	/* Release the periodic channel reservation. */
+	hcd->periodic_channels--;
+
+	/* Update claimed usecs per (micro)frame. */
+	hcd->periodic_usecs -= qh->usecs;
+
+	/*
+	 * Update average periodic bandwidth claimed and # periodic reqs for
+	 * usbfs.
+	 */
+	bus->bandwidth_allocated -= qh->usecs / qh->interval;
+
+	if (qh->ep_type == USB_ENDPOINT_XFER_INT)
+		bus->bandwidth_int_reqs--;
+	else
+		bus->bandwidth_isoc_reqs--;
+}
+
+/**
+ * Removes a QH from either the non-periodic or periodic schedule.  Memory is
+ * not freed.
+ */
+void dwc_otg_hcd_qh_remove(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	/* Do nothing if QG is not in a	schedule */
+	if (list_empty(&qh->qh_list_entry))
+		return;
+
+	if (dwc_qh_is_non_per(qh)) {
+		if (hcd->non_periodic_qh_ptr == &qh->qh_list_entry)
+			hcd->non_periodic_qh_ptr =
+				hcd->non_periodic_qh_ptr->next;
+
+		list_del_init(&qh->qh_list_entry);
+	} else
+		deschedule_periodic(hcd, qh);
+
+}
+
+/**
+ *  Schedule the next continuing periodic split transfer
+ */
+static void sched_next_per_split_xfr(struct dwc_qh *qh, u16 fr_num,
+					int sched_split)
+{
+	if (sched_split) {
+		qh->sched_frame = fr_num;
+
+		if (dwc_frame_num_le(fr_num,
+		    dwc_frame_num_inc(qh->start_split_frame, 1))) {
+			/*
+			 * Allow one frame to elapse after start split
+			 * microframe before scheduling complete split, but DONT
+			 * if we are doing the next start split in the
+			 * same frame for an ISOC out.
+			 */
+			if (qh->ep_type != USB_ENDPOINT_XFER_ISOC ||
+			    qh->ep_is_in)
+				qh->sched_frame = dwc_frame_num_inc(
+					qh->sched_frame, 1);
+		}
+	} else {
+		qh->sched_frame = dwc_frame_num_inc(qh->start_split_frame,
+				      qh->interval);
+
+		if (dwc_frame_num_le(qh->sched_frame, fr_num))
+			qh->sched_frame = fr_num;
+
+		qh->sched_frame |= 0x7;
+		qh->start_split_frame = qh->sched_frame;
+	}
+}
+
+/**
+ * Deactivates a periodic QH.  The QH is removed from the periodic queued
+ * schedule. If there are any QTDs still attached to the QH, the QH is added to
+ * either the periodic inactive schedule or the periodic ready schedule and its
+ * next scheduled frame is calculated. The QH is placed in the ready schedule if
+ * the scheduled frame has been reached already. Otherwise it's placed in the
+ * inactive schedule. If there are no QTDs attached to the QH, the QH is
+ * completely removed from the periodic schedule.
+ */
+static void deactivate_periodic_qh(struct dwc_hcd *hcd, struct dwc_qh *qh,
+			int sched_next_split)
+{
+	/* unsigned long flags; */
+	u16 fr_num = dwc_otg_hcd_get_frame_number(dwc_otg_hcd_to_hcd(hcd));
+
+	/* local_irq_save(flags); */
+
+	if (qh->do_split)
+		sched_next_per_split_xfr(qh, fr_num, sched_next_split);
+	else {
+		qh->sched_frame = dwc_frame_num_inc(qh->sched_frame,
+						qh->interval);
+		if (dwc_frame_num_le(qh->sched_frame, fr_num))
+			qh->sched_frame = fr_num;
+	}
+
+	if (list_empty(&qh->qtd_list))
+		dwc_otg_hcd_qh_remove(hcd, qh);
+	else {
+		/*
+		 * Remove from periodic_sched_queued and move to appropriate
+		 * queue.
+		 */
+		if (qh->sched_frame == fr_num)
+			list_move(&qh->qh_list_entry,
+				&hcd->periodic_sched_ready);
+		else
+			list_move(&qh->qh_list_entry,
+				&hcd->periodic_sched_inactive);
+	}
+
+	/* local_irq_restore(flags); */
+}
+
+/**
+ * Deactivates a non-periodic QH.  Removes the QH from the active non-periodic
+ * schedule. The QH is added to the inactive non-periodic schedule if any QTDs
+ * are still attached to the QH.
+ */
+static void deactivate_non_periodic_qh(struct dwc_hcd *hcd, struct dwc_qh *qh)
+{
+	dwc_otg_hcd_qh_remove(hcd, qh);
+	if (!list_empty(&qh->qtd_list))
+		dwc_otg_hcd_qh_add(hcd, qh);
+}
+
+/**
+ * Deactivates a QH.  Determines if the QH is periodic or non-periodic and takes
+ * the appropriate action.
+ */
+void dwc_otg_hcd_qh_deactivate(struct dwc_hcd *hcd, struct dwc_qh *qh,
+		int sched_next_periodic_split)
+{
+	if (dwc_qh_is_non_per(qh))
+		deactivate_non_periodic_qh(hcd, qh);
+	else
+		deactivate_periodic_qh(hcd, qh, sched_next_periodic_split);
+}
+
+/**
+ * Initializes a QTD structure.
+ */
+static void dwc_otg_hcd_qtd_init(struct dwc_qtd *qtd, struct urb *urb)
+{
+	memset(qtd, 0, sizeof(struct dwc_qtd));
+	qtd->urb = urb;
+
+	if (usb_pipecontrol(urb->pipe)) {
+		/*
+		 * The only time the QTD data toggle is used is on the data
+		 * phase of control transfers. This phase always starts with
+		 * DATA1.
+		 */
+		qtd->data_toggle = DWC_OTG_HC_PID_DATA1;
+		qtd->control_phase = DWC_OTG_CONTROL_SETUP;
+	}
+
+	/* start split */
+	qtd->complete_split = 0;
+	qtd->isoc_split_pos = DWC_HCSPLIT_XACTPOS_ALL;
+	qtd->isoc_split_offset = 0;
+
+	/* Store the qtd ptr in the urb to reference what QTD. */
+	urb->hcpriv = qtd;
+
+	INIT_LIST_HEAD(&qtd->qtd_list_entry);
+	return;
+}
+
+/* Allocates memory for a QTD structure. */
+static inline struct dwc_qtd *dwc_otg_hcd_qtd_alloc(gfp_t _mem_flags)
+{
+	return kmalloc(sizeof(struct dwc_qtd), _mem_flags);
+}
+
+/**
+ * This function allocates and initializes a QTD.
+ */
+struct dwc_qtd *dwc_otg_hcd_qtd_create(struct urb *urb,  gfp_t _mem_flags)
+{
+	struct dwc_qtd *qtd = dwc_otg_hcd_qtd_alloc(_mem_flags);
+
+	if (!qtd)
+		return NULL;
+
+	dwc_otg_hcd_qtd_init(qtd, urb);
+	return qtd;
+}
+
+
+
+/**
+ * This function adds a QTD to the QTD-list of a QH.  It will find the correct
+ * QH to place the QTD into.  If it does not find a QH, then it will create a
+ * new QH. If the QH to which the QTD is added is not currently scheduled, it
+ * is placed into the proper schedule based on its EP type.
+ *
+ */
+int dwc_otg_hcd_qtd_add(struct dwc_qtd *qtd,  struct dwc_hcd *hcd)
+{
+	struct usb_host_endpoint *ep;
+	struct dwc_qh *qh;
+	int retval = 0;
+	struct urb *urb = qtd->urb;
+
+	/*
+	 * Get the QH which holds the QTD-list to insert to. Create QH if it
+	 * doesn't exist.
+	 */
+	ep = dwc_urb_to_endpoint(urb);
+
+	qh = (struct dwc_qh *) ep->hcpriv;
+	if (!qh) {
+		qh = dwc_otg_hcd_qh_create(hcd, urb);
+		if (!qh)
+			goto done;
+
+		ep->hcpriv = qh;
+	}
+
+	retval = dwc_otg_hcd_qh_add(hcd, qh);
+	if (!retval)
+		list_add_tail(&qtd->qtd_list_entry, &qh->qtd_list);
+
+done:
+	return retval;
+}
-- 
1.6.0.1
