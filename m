Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E2ECEB7DED
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 02:11:44 +1000 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linux-usb@vger.kernel.org
Subject: [PATCH 3/4] USB: add USB OTG support for MPC5121 SoC
Date: Tue, 27 Apr 2010 18:11:37 +0200
Message-Id: <1272384698-4359-4-git-send-email-agust@denx.de>
In-Reply-To: <1272384698-4359-1-git-send-email-agust@denx.de>
References: <1272384698-4359-1-git-send-email-agust@denx.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Wolfgang Denk <wd@denx.de>, Detlev Zundel <dzu@denx.de>,
	Greg Kroah-Hartman <gregkh@suse.de>, linuxppc-dev@ozlabs.org,
	Bruce Schmid <duck@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds Freescale USB OTG driver and extends Freescale
USB SoC Device Controller driver and FSL EHCI driver
to support OTG operation on MPC5121.

Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Bruce Schmid <duck@freescale.com>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/include/asm/fsl_usb_io.h |  106 +++
 drivers/usb/gadget/fsl_udc_core.c     |  357 ++++++++--
 drivers/usb/gadget/fsl_usb2_udc.h     |   14 +
 drivers/usb/host/ehci-fsl.c           |  261 +++++++-
 drivers/usb/host/ehci-fsl.h           |    3 +
 drivers/usb/host/ehci-hub.c           |   39 ++
 drivers/usb/host/ehci.h               |    5 +
 drivers/usb/otg/Kconfig               |    8 +
 drivers/usb/otg/Makefile              |    2 +
 drivers/usb/otg/fsl_otg.c             | 1199 +++++++++++++++++++++++++++++++++
 drivers/usb/otg/fsl_otg.h             |  418 ++++++++++++
 drivers/usb/otg/otg.c                 |   17 +
 drivers/usb/otg/otg_fsm.c             |  368 ++++++++++
 drivers/usb/otg/otg_fsm.h             |  154 +++++
 include/linux/fsl_devices.h           |   15 +
 15 files changed, 2867 insertions(+), 99 deletions(-)
 create mode 100644 arch/powerpc/include/asm/fsl_usb_io.h
 create mode 100644 drivers/usb/otg/fsl_otg.c
 create mode 100644 drivers/usb/otg/fsl_otg.h
 create mode 100644 drivers/usb/otg/otg_fsm.c
 create mode 100644 drivers/usb/otg/otg_fsm.h

diff --git a/arch/powerpc/include/asm/fsl_usb_io.h b/arch/powerpc/include/asm/fsl_usb_io.h
new file mode 100644
index 0000000..20c42ef
--- /dev/null
+++ b/arch/powerpc/include/asm/fsl_usb_io.h
@@ -0,0 +1,106 @@
+/* Copyright (c) 2008 Freescale Semiconductor Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef _FSL_USB_IO_H
+#define _FSL_USB_IO_H
+
+/*
+ * On some SoCs, the USB controller registers can be big or little endian,
+ * depending on the version of the chip.  For these SoCs, the kernel
+ * should be configured with CONFIG_USB_FSL_BIG_ENDIAN_MMIO enabled.
+ *
+ * Platform code for SoCs that have BE USB registers should set
+ * pdata->big_endian_mmio flag.
+ *
+ * In order to be able to run the same kernel binary on 2 different
+ * versions of an SoC, the BE/LE decision must be made at run time.
+ * _fsl_readl and fsl_writel are pointers to the BE or LE readl()
+ * and writel() functions, and fsl_readl() and fsl_writel() call through
+ * those pointers.
+ *
+ * For SoCs with the usual LE USB registers, don't enable
+ * CONFIG_USB_FSL_BIG_ENDIAN_MMIO, and then fsl_readl() and fsl_writel()
+ * are just macro wrappers for in_le32() and out_le32().
+ *
+ * In either (LE or mixed) case, the function fsl_set_usb_accessors()
+ * should be called at probe time, to either set up the readl/writel
+ * function pointers (mixed case), or do nothing (LE case).
+ *
+ * The host USB drivers already have a mechanism to handle BE/LE
+ * registers.  The functionality here is intended to be used by the
+ * gadget and OTG transceiver drivers.
+ *
+ * This file also contains controller-to-cpu accessors for the
+ * USB descriptors, since their endianess is also SoC dependant.
+ * The kernel option CONFIG_USB_FSL_BIG_ENDIAN_DESC configures
+ * which way to go.
+ */
+
+#ifdef CONFIG_USB_FSL_BIG_ENDIAN_MMIO
+static u32 __maybe_unused _fsl_readl_be(const unsigned __iomem *p)
+{
+	return in_be32(p);
+}
+static u32 __maybe_unused _fsl_readl_le(const unsigned __iomem *p)
+{
+	return in_le32(p);
+}
+
+static void __maybe_unused _fsl_writel_be(u32 v, unsigned __iomem *p)
+{
+	out_be32(p, v);
+}
+static void __maybe_unused _fsl_writel_le(u32 v, unsigned __iomem *p)
+{
+	out_le32(p, v);
+}
+
+static u32 (*_fsl_readl)(const unsigned __iomem *p);
+static void (*_fsl_writel)(u32 v, unsigned __iomem *p);
+
+#define fsl_readl(p)		(*_fsl_readl)((p))
+#define fsl_writel(v, p)	(*_fsl_writel)((v), (p))
+
+static inline void fsl_set_usb_accessors(struct fsl_usb2_platform_data *pdata)
+{
+	if (pdata->big_endian_mmio) {
+		_fsl_readl = _fsl_readl_be;
+		_fsl_writel = _fsl_writel_be;
+	} else {
+		_fsl_readl = _fsl_readl_le;
+		_fsl_writel = _fsl_writel_le;
+	}
+}
+
+#else /* CONFIG_USB_FSL_BIG_ENDIAN_MMIO */
+
+#define fsl_readl(addr)		in_le32((addr))
+#define fsl_writel(val32, addr) out_le32((addr), (val32))
+
+static inline void fsl_set_usb_accessors(struct fsl_usb2_platform_data *pdata)
+{
+}
+#endif /* CONFIG_USB_FSL_BIG_ENDIAN_MMIO */
+
+#ifdef CONFIG_USB_FSL_BIG_ENDIAN_DESC
+#define cpu_to_hc32(x)	(x)
+#define hc32_to_cpu(x)	(x)
+#else
+#define cpu_to_hc32(x)	cpu_to_le32((x))
+#define hc32_to_cpu(x)	le32_to_cpu((x))
+#endif
+
+#endif /* _FSL_USB_IO_H */
diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index fa3d142..b5361a8 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -45,6 +45,7 @@
 #include <asm/system.h>
 #include <asm/unaligned.h>
 #include <asm/dma.h>
+#include <asm/cacheflush.h>
 
 #include "fsl_usb2_udc.h"
 
@@ -76,10 +77,7 @@ fsl_ep0_desc = {
 
 static void fsl_ep_fifo_flush(struct usb_ep *_ep);
 
-#ifdef CONFIG_PPC32
-#define fsl_readl(addr)		in_le32(addr)
-#define fsl_writel(val32, addr) out_le32(addr, val32)
-#else
+#ifndef CONFIG_PPC32
 #define fsl_readl(addr)		readl(addr)
 #define fsl_writel(val32, addr) writel(val32, addr)
 #endif
@@ -182,6 +180,8 @@ static int dr_controller_setup(struct fsl_udc *udc)
 	unsigned int ctrl;
 #endif
 	unsigned long timeout;
+	struct fsl_usb2_platform_data *pdata = udc->pdata;
+
 #define FSL_UDC_RESET_TIMEOUT 1000
 
 	/* Config PHY interface */
@@ -226,9 +226,12 @@ static int dr_controller_setup(struct fsl_udc *udc)
 
 	/* Set the controller as device mode */
 	tmp = fsl_readl(&dr_regs->usbmode);
+	tmp &= ~USB_MODE_CTRL_MODE_MASK;	/* clear mode bits */
 	tmp |= USB_MODE_CTRL_MODE_DEVICE;
 	/* Disable Setup Lockout */
 	tmp |= USB_MODE_SETUP_LOCK_OFF;
+	if (pdata->es)
+		tmp |= USB_MODE_ES;
 	fsl_writel(tmp, &dr_regs->usbmode);
 
 	/* Clear the setup status */
@@ -244,20 +247,24 @@ static int dr_controller_setup(struct fsl_udc *udc)
 
 	/* Config control enable i/o output, cpu endian register */
 #ifndef CONFIG_ARCH_MXC
-	ctrl = __raw_readl(&usb_sys_regs->control);
-	ctrl |= USB_CTRL_IOENB;
-	__raw_writel(ctrl, &usb_sys_regs->control);
+	if (pdata->have_sysif_regs) {
+		ctrl = __raw_readl(&usb_sys_regs->control);
+		ctrl |= USB_CTRL_IOENB;
+		__raw_writel(ctrl, &usb_sys_regs->control);
+	}
 #endif
 
 #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
 	/* Turn on cache snooping hardware, since some PowerPC platforms
 	 * wholly rely on hardware to deal with cache coherent. */
 
-	/* Setup Snooping for all the 4GB space */
-	tmp = SNOOP_SIZE_2GB;	/* starts from 0x0, size 2G */
-	__raw_writel(tmp, &usb_sys_regs->snoop1);
-	tmp |= 0x80000000;	/* starts from 0x8000000, size 2G */
-	__raw_writel(tmp, &usb_sys_regs->snoop2);
+	if (pdata->have_sysif_regs) {
+		/* Setup Snooping for all the 4GB space */
+		tmp = SNOOP_SIZE_2GB;	/* starts from 0x0, size 2G */
+		__raw_writel(tmp, &usb_sys_regs->snoop1);
+		tmp |= 0x80000000;	/* starts from 0x8000000, size 2G */
+		__raw_writel(tmp, &usb_sys_regs->snoop2);
+	}
 #endif
 
 	return 0;
@@ -295,6 +302,19 @@ static void dr_controller_stop(struct fsl_udc *udc)
 {
 	unsigned int tmp;
 
+	pr_debug("%s\n", __func__);
+
+	/* if we're in OTG mode, and the Host is currently using the port,
+	 * stop now and don't rip the controller out from under the
+	 * ehci driver
+	 */
+	if (udc->gadget.is_otg) {
+		if (!(fsl_readl(&dr_regs->otgsc) & OTGSC_STS_USB_ID)) {
+			pr_debug("udc: Leaving early\n");
+			return;
+		}
+	}
+
 	/* disable all INTR */
 	fsl_writel(0, &dr_regs->usbintr);
 
@@ -413,7 +433,7 @@ static void struct_ep_qh_setup(struct fsl_udc *udc, unsigned char ep_num,
 	if (zlt)
 		tmp |= EP_QUEUE_HEAD_ZLT_SEL;
 
-	p_QH->max_pkt_length = cpu_to_le32(tmp);
+	p_QH->max_pkt_length = cpu_to_hc32(tmp);
 	p_QH->next_dtd_ptr = 1;
 	p_QH->size_ioc_int_sts = 0;
 
@@ -622,7 +642,7 @@ static void fsl_queue_td(struct fsl_ep *ep, struct fsl_req *req)
 		struct fsl_req *lastreq;
 		lastreq = list_entry(ep->queue.prev, struct fsl_req, queue);
 		lastreq->tail->next_td_ptr =
-			cpu_to_le32(req->head->td_dma & DTD_ADDR_MASK);
+			cpu_to_hc32(req->head->td_dma & DTD_ADDR_MASK);
 		/* Read prime bit, if 1 goto done */
 		if (fsl_readl(&dr_regs->endpointprime) & bitmask)
 			goto out;
@@ -647,10 +667,10 @@ static void fsl_queue_td(struct fsl_ep *ep, struct fsl_req *req)
 
 	/* Write dQH next pointer and terminate bit to 0 */
 	temp = req->head->td_dma & EP_QUEUE_HEAD_NEXT_POINTER_MASK;
-	dQH->next_dtd_ptr = cpu_to_le32(temp);
+	dQH->next_dtd_ptr = cpu_to_hc32(temp);
 
 	/* Clear active and halt bit */
-	temp = cpu_to_le32(~(EP_QUEUE_HEAD_STATUS_ACTIVE
+	temp = cpu_to_hc32(~(EP_QUEUE_HEAD_STATUS_ACTIVE
 			| EP_QUEUE_HEAD_STATUS_HALT));
 	dQH->size_ioc_int_sts &= temp;
 
@@ -688,17 +708,17 @@ static struct ep_td_struct *fsl_build_dtd(struct fsl_req *req, unsigned *length,
 
 	dtd->td_dma = *dma;
 	/* Clear reserved field */
-	swap_temp = cpu_to_le32(dtd->size_ioc_sts);
+	swap_temp = hc32_to_cpu(dtd->size_ioc_sts);
 	swap_temp &= ~DTD_RESERVED_FIELDS;
-	dtd->size_ioc_sts = cpu_to_le32(swap_temp);
+	dtd->size_ioc_sts = cpu_to_hc32(swap_temp);
 
 	/* Init all of buffer page pointers */
 	swap_temp = (u32) (req->req.dma + req->req.actual);
-	dtd->buff_ptr0 = cpu_to_le32(swap_temp);
-	dtd->buff_ptr1 = cpu_to_le32(swap_temp + 0x1000);
-	dtd->buff_ptr2 = cpu_to_le32(swap_temp + 0x2000);
-	dtd->buff_ptr3 = cpu_to_le32(swap_temp + 0x3000);
-	dtd->buff_ptr4 = cpu_to_le32(swap_temp + 0x4000);
+	dtd->buff_ptr0 = cpu_to_hc32(swap_temp);
+	dtd->buff_ptr1 = cpu_to_hc32(swap_temp + 0x1000);
+	dtd->buff_ptr2 = cpu_to_hc32(swap_temp + 0x2000);
+	dtd->buff_ptr3 = cpu_to_hc32(swap_temp + 0x3000);
+	dtd->buff_ptr4 = cpu_to_hc32(swap_temp + 0x4000);
 
 	req->req.actual += *length;
 
@@ -722,7 +742,7 @@ static struct ep_td_struct *fsl_build_dtd(struct fsl_req *req, unsigned *length,
 	if (*is_last && !req->req.no_interrupt)
 		swap_temp |= DTD_IOC;
 
-	dtd->size_ioc_sts = cpu_to_le32(swap_temp);
+	dtd->size_ioc_sts = cpu_to_hc32(swap_temp);
 
 	mb();
 
@@ -749,7 +769,7 @@ static int fsl_req_to_dtd(struct fsl_req *req)
 			is_first = 0;
 			req->head = dtd;
 		} else {
-			last_dtd->next_td_ptr = cpu_to_le32(dma);
+			last_dtd->next_td_ptr = cpu_to_hc32(dma);
 			last_dtd->next_td_virt = dtd;
 		}
 		last_dtd = dtd;
@@ -757,7 +777,7 @@ static int fsl_req_to_dtd(struct fsl_req *req)
 		req->dtd_count++;
 	} while (!is_last);
 
-	dtd->next_td_ptr = cpu_to_le32(DTD_NEXT_TERMINATE);
+	dtd->next_td_ptr = cpu_to_hc32(DTD_NEXT_TERMINATE);
 
 	req->tail = dtd;
 
@@ -970,6 +990,36 @@ out:
 	return status;
 }
 
+static int fsl_ep_fifo_status(struct usb_ep *_ep)
+{
+	struct fsl_ep *ep;
+	struct fsl_udc *udc;
+	int size = 0;
+	u32 bitmask;
+	struct ep_queue_head *d_qh;
+
+	ep = container_of(_ep, struct fsl_ep, ep);
+	if (!_ep || (!ep->desc && ep_index(ep) != 0))
+		return -ENODEV;
+
+	udc = (struct fsl_udc *)ep->udc;
+
+	if (!udc->driver || udc->gadget.speed == USB_SPEED_UNKNOWN)
+		return -ESHUTDOWN;
+
+	d_qh = &ep->udc->ep_qh[ep_index(ep) * 2 + ep_is_in(ep)];
+
+	bitmask = (ep_is_in(ep)) ? (1 << (ep_index(ep) + 16)) :
+	    (1 << (ep_index(ep)));
+
+	if (fsl_readl(&dr_regs->endptstatus) & bitmask)
+		size = (d_qh->size_ioc_int_sts & DTD_PACKET_SIZE)
+		    >> DTD_LENGTH_BIT_POS;
+
+	pr_debug("%s %u\n", __func__, size);
+	return size;
+}
+
 static void fsl_ep_fifo_flush(struct usb_ep *_ep)
 {
 	struct fsl_ep *ep;
@@ -1022,6 +1072,7 @@ static struct usb_ep_ops fsl_ep_ops = {
 	.dequeue = fsl_ep_dequeue,
 
 	.set_halt = fsl_ep_set_halt,
+	.fifo_status = fsl_ep_fifo_status,
 	.fifo_flush = fsl_ep_fifo_flush,	/* flush fifo */
 };
 
@@ -1236,6 +1287,10 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
 	req = udc->status_req;
 	/* Fill in the reqest structure */
 	*((u16 *) req->req.buf) = cpu_to_le16(tmp);
+
+	/* flush cache for the req buffer */
+	flush_dcache_range((u32)req->req.buf, (u32)req->req.buf + 8);
+
 	req->ep = ep;
 	req->req.length = 2;
 	req->req.status = -EINPROGRESS;
@@ -1288,6 +1343,7 @@ static void setup_received_irq(struct fsl_udc *udc,
 		/* Status phase from udc */
 	{
 		int rc = -EOPNOTSUPP;
+		u16 ptc = 0;
 
 		if ((setup->bRequestType & (USB_RECIP_MASK | USB_TYPE_MASK))
 				== (USB_RECIP_ENDPOINT | USB_TYPE_STANDARD)) {
@@ -1309,17 +1365,19 @@ static void setup_received_irq(struct fsl_udc *udc,
 				| USB_TYPE_STANDARD)) {
 			/* Note: The driver has not include OTG support yet.
 			 * This will be set when OTG support is added */
-			if (!gadget_is_otg(&udc->gadget))
-				break;
-			else if (setup->bRequest == USB_DEVICE_B_HNP_ENABLE)
-				udc->gadget.b_hnp_enable = 1;
-			else if (setup->bRequest == USB_DEVICE_A_HNP_SUPPORT)
-				udc->gadget.a_hnp_support = 1;
-			else if (setup->bRequest ==
-					USB_DEVICE_A_ALT_HNP_SUPPORT)
-				udc->gadget.a_alt_hnp_support = 1;
-			else
-				break;
+			if (wValue == USB_DEVICE_TEST_MODE)
+				ptc = wIndex >> 8;
+			else if (gadget_is_otg(&udc->gadget)) {
+				if (setup->bRequest ==
+				    USB_DEVICE_B_HNP_ENABLE)
+					udc->gadget.b_hnp_enable = 1;
+				else if (setup->bRequest ==
+					 USB_DEVICE_A_HNP_SUPPORT)
+					udc->gadget.a_hnp_support = 1;
+				else if (setup->bRequest ==
+					 USB_DEVICE_A_ALT_HNP_SUPPORT)
+					udc->gadget.a_alt_hnp_support = 1;
+			}
 			rc = 0;
 		} else
 			break;
@@ -1328,6 +1386,15 @@ static void setup_received_irq(struct fsl_udc *udc,
 			if (ep0_prime_status(udc, EP_DIR_IN))
 				ep0stall(udc);
 		}
+		if (ptc) {
+			u32 tmp;
+
+			mdelay(10);
+			tmp = fsl_readl(&dr_regs->portsc1) | (ptc << 16);
+			fsl_writel(tmp, &dr_regs->portsc1);
+			printk(KERN_INFO "udc: switch to test mode %d.\n", ptc);
+		}
+
 		return;
 	}
 
@@ -1402,6 +1469,7 @@ static void tripwire_handler(struct fsl_udc *udc, u8 ep_num, u8 *buffer_ptr)
 {
 	u32 temp;
 	struct ep_queue_head *qh;
+	struct fsl_usb2_platform_data *pdata = udc->pdata;
 
 	qh = &udc->ep_qh[ep_num * 2 + EP_DIR_OUT];
 
@@ -1416,7 +1484,16 @@ static void tripwire_handler(struct fsl_udc *udc, u8 ep_num, u8 *buffer_ptr)
 		fsl_writel(temp | USB_CMD_SUTW, &dr_regs->usbcmd);
 
 		/* Copy the setup packet to local buffer */
-		memcpy(buffer_ptr, (u8 *) qh->setup_buffer, 8);
+		if (pdata->le_setup_buf) {
+			u32 *p = (u32 *)buffer_ptr;
+			u32 *s = (u32 *)qh->setup_buffer;
+
+			/* Convert little endian setup buffer to CPU endian */
+			*p++ = le32_to_cpu(*s++);
+			*p = le32_to_cpu(*s);
+		} else {
+			memcpy(buffer_ptr, (u8 *) qh->setup_buffer, 8);
+		}
 	} while (!(fsl_readl(&dr_regs->usbcmd) & USB_CMD_SUTW));
 
 	/* Clear Setup Tripwire */
@@ -1440,19 +1517,19 @@ static int process_ep_req(struct fsl_udc *udc, int pipe,
 	actual = curr_req->req.length;
 
 	for (j = 0; j < curr_req->dtd_count; j++) {
-		remaining_length = (le32_to_cpu(curr_td->size_ioc_sts)
+		remaining_length = (hc32_to_cpu(curr_td->size_ioc_sts)
 					& DTD_PACKET_SIZE)
 				>> DTD_LENGTH_BIT_POS;
 		actual -= remaining_length;
 
-		if ((errors = le32_to_cpu(curr_td->size_ioc_sts) &
-						DTD_ERROR_MASK)) {
+		errors = hc32_to_cpu(curr_td->size_ioc_sts);
+		if (errors & DTD_ERROR_MASK) {
 			if (errors & DTD_STATUS_HALTED) {
 				ERR("dTD error %08x QH=%d\n", errors, pipe);
 				/* Clear the errors and Halt condition */
-				tmp = le32_to_cpu(curr_qh->size_ioc_int_sts);
+				tmp = hc32_to_cpu(curr_qh->size_ioc_int_sts);
 				tmp &= ~errors;
-				curr_qh->size_ioc_int_sts = cpu_to_le32(tmp);
+				curr_qh->size_ioc_int_sts = cpu_to_hc32(tmp);
 				status = -EPIPE;
 				/* FIXME: continue with next queued TD? */
 
@@ -1470,7 +1547,7 @@ static int process_ep_req(struct fsl_udc *udc, int pipe,
 				ERR("Unknown error has occured (0x%x)!\n",
 					errors);
 
-		} else if (le32_to_cpu(curr_td->size_ioc_sts)
+		} else if (hc32_to_cpu(curr_td->size_ioc_sts)
 				& DTD_STATUS_ACTIVE) {
 			VDBG("Request not complete");
 			status = REQ_UNCOMPLETE;
@@ -1559,6 +1636,9 @@ static void port_change_irq(struct fsl_udc *udc)
 {
 	u32 speed;
 
+	if (udc->bus_reset)
+		udc->bus_reset = 0;
+
 	/* Bus resetting is finished */
 	if (!(fsl_readl(&dr_regs->portsc1) & PORTSCX_PORT_RESET)) {
 		/* Get the speed */
@@ -1666,6 +1746,8 @@ static void reset_irq(struct fsl_udc *udc)
 
 	if (fsl_readl(&dr_regs->portsc1) & PORTSCX_PORT_RESET) {
 		VDBG("Bus reset");
+		/* Bus is reseting */
+		udc->bus_reset = 1;
 		/* Reset all the queues, include XD, dTD, EP queue
 		 * head and TR Queue */
 		reset_queues(udc);
@@ -1743,6 +1825,7 @@ static irqreturn_t fsl_udc_irq(int irq, void *_udc)
 
 	/* Reset Received */
 	if (irq_src & USB_STS_RESET) {
+		VDBG("reset int");
 		reset_irq(udc);
 		status = IRQ_HANDLED;
 	}
@@ -1800,11 +1883,30 @@ int usb_gadget_register_driver(struct usb_gadget_driver *driver)
 		goto out;
 	}
 
-	/* Enable DR IRQ reg and Set usbcmd reg  Run bit */
-	dr_controller_run(udc_controller);
-	udc_controller->usb_state = USB_STATE_ATTACHED;
-	udc_controller->ep0_state = WAIT_FOR_SETUP;
-	udc_controller->ep0_dir = 0;
+	if (udc_controller->transceiver) {
+		/* Suspend the controller until OTG enable it */
+		udc_controller->stopped = 1;
+		printk(KERN_INFO "Suspend udc for OTG auto detect\n");
+
+		/* connect to bus through transceiver */
+		if (udc_controller->transceiver) {
+			retval = otg_set_peripheral(udc_controller->transceiver,
+						    &udc_controller->gadget);
+			if (retval < 0) {
+				ERR("can't bind to transceiver\n");
+				driver->unbind(&udc_controller->gadget);
+				udc_controller->gadget.dev.driver = 0;
+				udc_controller->driver = 0;
+				return retval;
+			}
+		}
+	} else {
+		/* Enable DR IRQ reg and Set usbcmd reg  Run bit */
+		dr_controller_run(udc_controller);
+		udc_controller->usb_state = USB_STATE_ATTACHED;
+		udc_controller->ep0_state = WAIT_FOR_SETUP;
+		udc_controller->ep0_dir = 0;
+	}
 	printk(KERN_INFO "%s: bind to driver %s\n",
 			udc_controller->gadget.name, driver->driver.name);
 
@@ -1882,8 +1984,11 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 	u32 tmp_reg;
 	struct fsl_ep *ep = NULL;
 	struct fsl_req *req;
-
+	struct fsl_usb2_platform_data *pdata;
 	struct fsl_udc *udc = udc_controller;
+
+	pdata = udc->pdata;
+
 	if (off != 0)
 		return 0;
 
@@ -2052,16 +2157,18 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 	next += t;
 
 #ifndef CONFIG_ARCH_MXC
-	tmp_reg = usb_sys_regs->snoop1;
-	t = scnprintf(next, size, "Snoop1 Reg : = [0x%x]\n\n", tmp_reg);
-	size -= t;
-	next += t;
+	if (pdata->have_sysif_regs) {
+		tmp_reg = usb_sys_regs->snoop1;
+		t = scnprintf(next, size, "Snoop1 Reg : = [0x%x]\n\n", tmp_reg);
+		size -= t;
+		next += t;
 
-	tmp_reg = usb_sys_regs->control;
-	t = scnprintf(next, size, "General Control Reg : = [0x%x]\n\n",
-			tmp_reg);
-	size -= t;
-	next += t;
+		tmp_reg = usb_sys_regs->control;
+		t = scnprintf(next, size, "General Control Reg : = [0x%x]\n\n",
+				tmp_reg);
+		size -= t;
+		next += t;
+	}
 #endif
 
 	/* ------fsl_udc, fsl_ep, fsl_request structure information ----- */
@@ -2196,6 +2303,7 @@ static int __init struct_udc_setup(struct fsl_udc *udc,
 	udc->usb_state = USB_STATE_POWERED;
 	udc->ep0_dir = 0;
 	udc->remote_wakeup = 0;	/* default to 0 on reset */
+	spin_lock_init(&udc->lock);
 
 	return 0;
 }
@@ -2242,6 +2350,7 @@ static int __init struct_ep_setup(struct fsl_udc *udc, unsigned char index,
 static int __init fsl_udc_probe(struct platform_device *pdev)
 {
 	struct resource *res;
+	struct fsl_usb2_platform_data *pdata;
 	int ret = -ENODEV;
 	unsigned int i;
 	u32 dccparams;
@@ -2257,9 +2366,26 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	pdata = pdev->dev.platform_data;
 	spin_lock_init(&udc_controller->lock);
 	udc_controller->stopped = 1;
+	udc_controller->pdata = pdata;
+
+#ifdef CONFIG_USB_OTG
+	/* Memory and interrupt resources will be passed from OTG */
+	udc_controller->transceiver = otg_get_transceiver();
+	if (!udc_controller->transceiver) {
+		printk(KERN_ERR "Can't find OTG driver!\n");
+		ret = -ENODEV;
+		goto err_kfree;
+	}
 
+	res = otg_get_resources();
+	if (!res) {
+		DBG("resource not registered!\n");
+		return -ENODEV;
+	}
+#else
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res) {
 		ret = -ENXIO;
@@ -2272,16 +2398,30 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 		ret = -EBUSY;
 		goto err_kfree;
 	}
-
+#endif
 	dr_regs = ioremap(res->start, resource_size(res));
 	if (!dr_regs) {
 		ret = -ENOMEM;
 		goto err_release_mem_region;
 	}
 
+	pdata->regs = (void *)dr_regs;
+
+	/*
+	 * do platform specific init: check the clock, grab/config pins, etc.
+	 */
+	if (pdata->platform_init && pdata->platform_init(pdev)) {
+		ret = -ENODEV;
+		goto err_iounmap_noclk;
+	}
+
+	/* Set accessors only after pdata->platform_init() !!! */
+	fsl_set_usb_accessors(pdata);
+
 #ifndef CONFIG_ARCH_MXC
-	usb_sys_regs = (struct usb_sys_interface *)
-			((u32)dr_regs + USB_DR_SYS_OFFSET);
+	if (pdata->have_sysif_regs)
+		usb_sys_regs = (struct usb_sys_interface *)
+				((u32)dr_regs + USB_DR_SYS_OFFSET);
 #endif
 
 	/* Initialize USB clocks */
@@ -2300,7 +2440,12 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	/* DEN is bidirectional ep number, max_ep doubles the number */
 	udc_controller->max_ep = (dccparams & DCCPARAMS_DEN_MASK) * 2;
 
+#ifdef CONFIG_USB_OTG
+	res++;
+	udc_controller->irq = res->start;
+#else
 	udc_controller->irq = platform_get_irq(pdev, 0);
+#endif
 	if (!udc_controller->irq) {
 		ret = -ENODEV;
 		goto err_iounmap;
@@ -2321,9 +2466,11 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 		goto err_free_irq;
 	}
 
-	/* initialize usb hw reg except for regs for EP,
-	 * leave usbintr reg untouched */
-	dr_controller_setup(udc_controller);
+	if (!udc_controller->transceiver) {
+		/* initialize usb hw reg except for regs for EP,
+		 * leave usbintr reg untouched */
+		dr_controller_setup(udc_controller);
+	}
 
 	fsl_udc_clk_finalize(pdev);
 
@@ -2343,6 +2490,9 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto err_free_irq;
 
+	if (udc_controller->transceiver)
+		udc_controller->gadget.is_otg = 1;
+
 	/* setup QH and epctrl for ep0 */
 	ep0_setup(udc_controller);
 
@@ -2381,11 +2531,14 @@ err_unregister:
 err_free_irq:
 	free_irq(udc_controller->irq, udc_controller);
 err_iounmap:
+	if (pdata->platform_uninit)
+		pdata->platform_uninit(pdev);
 	fsl_udc_clk_release();
 err_iounmap_noclk:
 	iounmap(dr_regs);
 err_release_mem_region:
-	release_mem_region(res->start, res->end - res->start + 1);
+	if (!udc_controller->transceiver)
+		release_mem_region(res->start, res->end - res->start + 1);
 err_kfree:
 	kfree(udc_controller);
 	udc_controller = NULL;
@@ -2397,7 +2550,8 @@ err_kfree:
  */
 static int __exit fsl_udc_remove(struct platform_device *pdev)
 {
-	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct resource __maybe_unused *res;
+	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
 
 	DECLARE_COMPLETION(done);
 
@@ -2418,12 +2572,22 @@ static int __exit fsl_udc_remove(struct platform_device *pdev)
 	dma_pool_destroy(udc_controller->td_pool);
 	free_irq(udc_controller->irq, udc_controller);
 	iounmap(dr_regs);
+#ifndef CONFIG_USB_OTG
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, res->end - res->start + 1);
+#endif
 
 	device_unregister(&udc_controller->gadget.dev);
 	/* free udc --wait for the release() finished */
 	wait_for_completion(&done);
 
+	/*
+	 * do platform specific un-initialization:
+	 * release iomux pins, etc.
+	 */
+	if (pdata->platform_uninit)
+		pdata->platform_uninit(pdev);
+
 	return 0;
 }
 
@@ -2454,6 +2618,62 @@ static int fsl_udc_resume(struct platform_device *pdev)
 	return 0;
 }
 
+static int fsl_udc_otg_suspend(struct device *dev, pm_message_t state)
+{
+	struct fsl_udc *udc = udc_controller;
+	u32 mode, usbcmd;
+
+	mode = fsl_readl(&dr_regs->usbmode) & USB_MODE_CTRL_MODE_MASK;
+
+	pr_debug("%s(): mode 0x%x stopped %d\n", __func__, mode, udc->stopped);
+
+	/*
+	 * If the controller is already stopped, then this must be a
+	 * PM suspend.  Remember this fact, so that we will leave the
+	 * controller stopped at PM resume time.
+	 */
+	if (udc->stopped) {
+		pr_debug("gadget already stopped, leaving early\n");
+		udc->already_stopped = 1;
+		return 0;
+	}
+
+	if (mode != USB_MODE_CTRL_MODE_DEVICE) {
+		pr_debug("gadget not in device mode, leaving early\n");
+		return 0;
+	}
+
+	/* stop the controller */
+	usbcmd = fsl_readl(&dr_regs->usbcmd) & ~USB_CMD_RUN_STOP;
+	fsl_writel(usbcmd, &dr_regs->usbcmd);
+
+	udc->stopped = 1;
+
+	pr_info("USB Gadget suspended\n");
+
+	return 0;
+}
+
+static int fsl_udc_otg_resume(struct device *dev)
+{
+	pr_debug("%s(): stopped %d  already_stopped %d\n", __func__,
+		 udc_controller->stopped, udc_controller->already_stopped);
+
+	/*
+	 * If the controller was stopped at suspend time, then
+	 * don't resume it now.
+	 */
+	if (udc_controller->already_stopped) {
+		udc_controller->already_stopped = 0;
+		pr_debug("gadget was already stopped, leaving early\n");
+		return 0;
+	}
+
+	pr_info("USB Gadget resume\n");
+
+	return fsl_udc_resume(NULL);
+}
+
 /*-------------------------------------------------------------------------
 	Register entry point for the peripheral controller driver
 --------------------------------------------------------------------------*/
@@ -2466,6 +2686,9 @@ static struct platform_driver udc_driver = {
 	.driver  = {
 		.name = (char *)driver_name,
 		.owner = THIS_MODULE,
+		/* udc suspend/resume called from OTG driver */
+		.suspend = fsl_udc_otg_suspend,
+		.resume  = fsl_udc_otg_resume,
 	},
 };
 
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index 20aecee..fe901f4 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -275,7 +275,9 @@ struct usb_sys_interface {
 #define  USB_MODE_CTRL_MODE_IDLE              0x00000000
 #define  USB_MODE_CTRL_MODE_DEVICE            0x00000002
 #define  USB_MODE_CTRL_MODE_HOST              0x00000003
+#define  USB_MODE_CTRL_MODE_MASK              0x00000003
 #define  USB_MODE_CTRL_MODE_RSV               0x00000001
+#define  USB_MODE_ES                          0x00000004 /* Endian Select */
 #define  USB_MODE_SETUP_LOCK_OFF              0x00000008
 #define  USB_MODE_STREAM_DISABLE              0x00000010
 /* Endpoint Flush Register */
@@ -461,6 +463,7 @@ struct fsl_ep {
 struct fsl_udc {
 	struct usb_gadget gadget;
 	struct usb_gadget_driver *driver;
+	struct fsl_usb2_platform_data *pdata;
 	struct completion *done;	/* to make sure release() is done */
 	struct fsl_ep *eps;
 	unsigned int max_ep;
@@ -473,6 +476,7 @@ struct fsl_udc {
 	unsigned vbus_active:1;
 	unsigned stopped:1;
 	unsigned remote_wakeup:1;
+	unsigned already_stopped:1;
 
 	struct ep_queue_head *ep_qh;	/* Endpoints Queue-Head */
 	struct fsl_req *status_req;	/* ep0 status request */
@@ -483,6 +487,7 @@ struct fsl_udc {
 	dma_addr_t ep_qh_dma;		/* dma address of QH */
 
 	u32 max_pipes;          /* Device max pipes */
+	u32 bus_reset;		/* Device is bus reseting */
 	u32 resume_state;	/* USB state to resume */
 	u32 usb_state;		/* USB current state */
 	u32 ep0_state;		/* Endpoint zero state */
@@ -581,4 +586,13 @@ static inline void fsl_udc_clk_release(void)
 }
 #endif
 
+#ifdef CONFIG_USB_OTG
+/* Get platform resource from OTG driver */
+extern struct resource *otg_get_resources(void);
+#endif
+
+#ifdef CONFIG_PPC32
+#include <asm/fsl_usb_io.h>
+#endif
+
 #endif
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 6b3f1df..461de88 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -77,37 +77,53 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 		return -ENODEV;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res) {
-		dev_err(&pdev->dev,
-			"Found HC with no IRQ. Check %s setup!\n",
-			dev_name(&pdev->dev));
-		return -ENODEV;
-	}
-	irq = res->start;
-
 	hcd = usb_create_hcd(driver, &pdev->dev, dev_name(&pdev->dev));
 	if (!hcd) {
 		retval = -ENOMEM;
 		goto err1;
 	}
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res) {
-		dev_err(&pdev->dev,
-			"Found HC with no register addr. Check %s setup!\n",
-			dev_name(&pdev->dev));
-		retval = -ENODEV;
-		goto err2;
-	}
-	hcd->rsrc_start = res->start;
-	hcd->rsrc_len = res->end - res->start + 1;
-	if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
-				driver->description)) {
-		dev_dbg(&pdev->dev, "controller already in use\n");
-		retval = -EBUSY;
-		goto err2;
+#if defined(CONFIG_USB_OTG)
+	if (pdata->operating_mode == FSL_USB2_DR_OTG) {
+		res = otg_get_resources();
+		if (!res) {
+			dev_err(&pdev->dev,
+				"Found HC with no IRQ. Check %s setup!\n",
+				dev_name(&pdev->dev));
+			return -ENODEV;
+		}
+		irq = res[1].start;
+		hcd->rsrc_start = res[0].start;
+		hcd->rsrc_len = res[0].end - res[0].start + 1;
+	} else
+#endif
+	{
+		res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+		if (!res) {
+			dev_err(&pdev->dev,
+				"Found HC with no IRQ. Check %s setup!\n",
+				dev_name(&pdev->dev));
+			return -ENODEV;
+		}
+		irq = res->start;
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+		if (!res) {
+			dev_err(&pdev->dev, "Found HC with no register addr. "
+				"Check %s setup!\n", dev_name(&pdev->dev));
+			retval = -ENODEV;
+			goto err2;
+		}
+		hcd->rsrc_start = res->start;
+		hcd->rsrc_len = res->end - res->start + 1;
+		if (!request_mem_region(hcd->rsrc_start, hcd->rsrc_len,
+					driver->description)) {
+			dev_dbg(&pdev->dev, "controller already in use\n");
+			retval = -EBUSY;
+			goto err2;
+		}
 	}
+
 	hcd->regs = ioremap(hcd->rsrc_start, hcd->rsrc_len);
 
 	if (hcd->regs == NULL) {
@@ -126,6 +142,8 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 		goto err3;
 	}
 
+	hcd->power_budget = pdata->power_budget;
+
 	/*
 	 * Check if it is MPC5121 SoC, otherwise set pdata->have_sysif_regs
 	 * flag for 83xx or 8536 system interface registers.
@@ -153,12 +171,38 @@ static int usb_hcd_fsl_probe(const struct hc_driver *driver,
 	retval = usb_add_hcd(hcd, irq, IRQF_DISABLED | IRQF_SHARED);
 	if (retval != 0)
 		goto err4;
+
+#ifdef CONFIG_USB_OTG
+	if (pdata->operating_mode == FSL_USB2_DR_OTG) {
+		struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+
+		dbg("pdev=0x%p  hcd=0x%p  ehci=0x%p\n", pdev, hcd, ehci);
+
+		ehci->transceiver = otg_get_transceiver();
+		dbg("ehci->transceiver=0x%p\n", ehci->transceiver);
+
+		if (ehci->transceiver) {
+			retval = otg_set_host(ehci->transceiver,
+					      &ehci_to_hcd(ehci)->self);
+			if (retval) {
+				if (ehci->transceiver)
+					put_device(ehci->transceiver->dev);
+				goto err4;
+			}
+		} else {
+			printk(KERN_ERR "can't find transceiver\n");
+			retval = -ENODEV;
+			goto err4;
+		}
+	}
+#endif
 	return retval;
 
       err4:
 	iounmap(hcd->regs);
       err3:
-	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	if (pdata->operating_mode != FSL_USB2_DR_OTG)
+		release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
       err2:
 	usb_put_hcd(hcd);
       err1:
@@ -183,6 +227,14 @@ static void usb_hcd_fsl_remove(struct usb_hcd *hcd,
 			       struct platform_device *pdev)
 {
 	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+
+	if (ehci->transceiver) {
+		otg_set_host(ehci->transceiver, NULL);
+		put_device(ehci->transceiver->dev);
+	} else {
+		release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
+	}
 
 	usb_remove_hcd(hcd);
 
@@ -193,7 +245,6 @@ static void usb_hcd_fsl_remove(struct usb_hcd *hcd,
 	if (pdata->platform_uninit)
 		pdata->platform_uninit(pdev);
 	iounmap(hcd->regs);
-	release_mem_region(hcd->rsrc_start, hcd->rsrc_len);
 	usb_put_hcd(hcd);
 }
 
@@ -351,6 +402,15 @@ struct ehci_fsl {
 
 #ifdef CONFIG_PM
 
+static int ehci_fsl_drv_restore(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+
+	usb_root_hub_lost_power(hcd->self.root_hub);
+	return 0;
+}
+
+#ifndef CONFIG_PPC_MPC512x
 static struct ehci_fsl *hcd_to_ehci_fsl(struct usb_hcd *hcd)
 {
 	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
@@ -392,21 +452,157 @@ static int ehci_fsl_drv_resume(struct device *dev)
 	return 0;
 }
 
-static int ehci_fsl_drv_restore(struct device *dev)
+static const struct dev_pm_ops ehci_fsl_pm_ops = {
+	.suspend = ehci_fsl_drv_suspend,
+	.resume = ehci_fsl_drv_resume,
+	.restore = ehci_fsl_drv_restore,
+};
+
+#define EHCI_FSL_PM_OPS		(&ehci_fsl_pm_ops)
+
+#else /* CONFIG_PPC_MPC512x */
+
+static int ehci_fsl_mpc512x_drv_suspend(struct device *dev)
 {
 	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	struct fsl_usb2_platform_data *pdata = dev->platform_data;
+	u32 tmp;
+
+#ifdef DEBUG
+	u32 mode = ehci_readl(ehci, hcd->regs + FSL_SOC_USB_USBMODE);
+	mode &= USBMODE_CM_MASK;
+	tmp = ehci_readl(ehci, hcd->regs + 0x140);	/* usbcmd */
+
+	dev_dbg(dev, "('%s'): suspend=%d already_suspended=%d "
+		"mode=%d  usbcmd %08x\n", pdata->name, pdata->suspended,
+		pdata->already_suspended, mode, tmp);
+#endif
+
+	/*
+	 * If the controller is already suspended, then this must be a
+	 * PM suspend.  Remember this fact, so that we will leave the
+	 * controller suspended at PM resume time.
+	 */
+	if (pdata->suspended) {
+		dev_dbg(dev, "already suspended, leaving early\n");
+		pdata->already_suspended = 1;
+		return 0;
+	}
+
+	dev_dbg(dev, "suspending...\n");
+
+	hcd->state = HC_STATE_SUSPENDED;
+	dev->power.power_state = PMSG_SUSPEND;
+
+	/* ignore non-host interrupts */
+	clear_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+
+	/* stop the controller */
+	tmp = ehci_readl(ehci, &ehci->regs->command);
+	tmp &= ~CMD_RUN;
+	ehci_writel(ehci, tmp, &ehci->regs->command);
+
+	/* save EHCI registers */
+	pdata->pm_command = ehci_readl(ehci, &ehci->regs->command);
+	pdata->pm_command &= ~CMD_RUN;
+	pdata->pm_status  = ehci_readl(ehci, &ehci->regs->status);
+	pdata->pm_intr_enable  = ehci_readl(ehci, &ehci->regs->intr_enable);
+	pdata->pm_frame_index  = ehci_readl(ehci, &ehci->regs->frame_index);
+	pdata->pm_segment  = ehci_readl(ehci, &ehci->regs->segment);
+	pdata->pm_frame_list  = ehci_readl(ehci, &ehci->regs->frame_list);
+	pdata->pm_async_next  = ehci_readl(ehci, &ehci->regs->async_next);
+	pdata->pm_configured_flag  =
+		ehci_readl(ehci, &ehci->regs->configured_flag);
+	pdata->pm_portsc = ehci_readl(ehci, &ehci->regs->port_status[0]);
+	pdata->pm_usbgenctrl = ehci_readl(ehci,
+					  hcd->regs + FSL_SOC_USB_USBGENCTRL);
+
+	/* clear the W1C bits */
+	pdata->pm_portsc &= cpu_to_hc32(ehci, ~PORT_RWC_BITS);
+
+	pdata->suspended = 1;
+
+	/* clear PP to cut power to the port */
+	tmp = ehci_readl(ehci, &ehci->regs->port_status[0]);
+	tmp &= ~PORT_POWER;
+	ehci_writel(ehci, tmp, &ehci->regs->port_status[0]);
 
-	usb_root_hub_lost_power(hcd->self.root_hub);
 	return 0;
 }
 
-static struct dev_pm_ops ehci_fsl_pm_ops = {
-	.suspend = ehci_fsl_drv_suspend,
-	.resume = ehci_fsl_drv_resume,
+static int ehci_fsl_mpc512x_drv_resume(struct device *dev)
+{
+	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	struct fsl_usb2_platform_data *pdata = dev->platform_data;
+	u32 tmp;
+
+	dev_dbg(dev, "('%s'): suspend=%d already_suspended=%d\n",
+		pdata->name, pdata->suspended, pdata->already_suspended);
+
+	/*
+	 * If the controller was already suspended at suspend time,
+	 * then don't resume it now.
+	 */
+	if (pdata->already_suspended) {
+		dev_dbg(dev, "already suspended, leaving early\n");
+		pdata->already_suspended = 0;
+		return 0;
+	}
+
+	if (!pdata->suspended) {
+		dev_dbg(dev, "not suspended, leaving early\n");
+		return 0;
+	}
+
+	pdata->suspended = 0;
+
+	dev_dbg(dev, "resuming...\n");
+
+	/* set host mode */
+	tmp = USBMODE_CM_HOST | (pdata->es ? USBMODE_ES : 0);
+	ehci_writel(ehci, tmp, hcd->regs + FSL_SOC_USB_USBMODE);
+
+	ehci_writel(ehci, pdata->pm_usbgenctrl,
+		    hcd->regs + FSL_SOC_USB_USBGENCTRL);
+	ehci_writel(ehci, ISIPHYCTRL_PXE | ISIPHYCTRL_PHYE,
+		    hcd->regs + FSL_SOC_USB_ISIPHYCTRL);
+
+	/* restore EHCI registers */
+	ehci_writel(ehci, pdata->pm_command, &ehci->regs->command);
+	ehci_writel(ehci, pdata->pm_intr_enable, &ehci->regs->intr_enable);
+	ehci_writel(ehci, pdata->pm_frame_index, &ehci->regs->frame_index);
+	ehci_writel(ehci, pdata->pm_segment, &ehci->regs->segment);
+	ehci_writel(ehci, pdata->pm_frame_list, &ehci->regs->frame_list);
+	ehci_writel(ehci, pdata->pm_async_next, &ehci->regs->async_next);
+	ehci_writel(ehci, pdata->pm_configured_flag,
+		    &ehci->regs->configured_flag);
+	ehci_writel(ehci, pdata->pm_portsc, &ehci->regs->port_status[0]);
+
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	hcd->state = HC_STATE_RUNNING;
+	dev->power.power_state = PMSG_ON;
+
+	tmp = ehci_readl(ehci, &ehci->regs->command);
+	tmp |= CMD_RUN;
+	ehci_writel(ehci, tmp, &ehci->regs->command);
+
+	usb_hcd_resume_root_hub(hcd);
+
+	return 0;
+}
+
+static const struct dev_pm_ops ehci_fsl_mpc512x_pm_ops = {
+	.suspend = ehci_fsl_mpc512x_drv_suspend,
+	.resume = ehci_fsl_mpc512x_drv_resume,
 	.restore = ehci_fsl_drv_restore,
 };
 
-#define EHCI_FSL_PM_OPS		(&ehci_fsl_pm_ops)
+#define EHCI_FSL_PM_OPS		(&ehci_fsl_mpc512x_pm_ops)
+
+#endif /* CONFIG_PPC_MPC512x */
+
 #else
 #define EHCI_FSL_PM_OPS		NULL
 #endif /* CONFIG_PM */
@@ -450,6 +646,7 @@ static const struct hc_driver ehci_fsl_hc_driver = {
 	.hub_control = ehci_hub_control,
 	.bus_suspend = ehci_bus_suspend,
 	.bus_resume = ehci_bus_resume,
+	.start_port_reset = ehci_start_port_reset,
 	.relinquish_port = ehci_relinquish_port,
 	.port_handed_over = ehci_port_handed_over,
 
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index faeaea5..652888e 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -52,4 +52,7 @@
 #define FSL_SOC_USB_SICTRL	0x410	/* NOTE: big-endian */
 #define FSL_SOC_USB_CTRL	0x500	/* NOTE: big-endian */
 #define SNOOP_SIZE_2GB		0x1e
+
+extern struct resource *otg_get_resources(void);
+
 #endif				/* _EHCI_FSL_H */
diff --git a/drivers/usb/host/ehci-hub.c b/drivers/usb/host/ehci-hub.c
index c7178bc..30fb3d4 100644
--- a/drivers/usb/host/ehci-hub.c
+++ b/drivers/usb/host/ehci-hub.c
@@ -27,6 +27,7 @@
  */
 
 /*-------------------------------------------------------------------------*/
+#include <linux/usb/otg.h>
 
 #define	PORT_WAKE_BITS	(PORT_WKOC_E|PORT_WKDISC_E|PORT_WKCONN_E)
 
@@ -607,6 +608,37 @@ ehci_hub_descriptor (
 	desc->wHubCharacteristics = cpu_to_le16(temp);
 }
 
+#ifdef CONFIG_USB_OTG
+static int ehci_start_port_reset(struct usb_hcd *hcd, unsigned port)
+{
+	struct ehci_hcd *ehci = hcd_to_ehci(hcd);
+	u32 status;
+
+	if (!port)
+		return -EINVAL;
+	port--;
+
+	/* start port reset before HNP protocol time out */
+	status = readl(&ehci->regs->port_status[port]);
+	if (!(status & PORT_CONNECT))
+		return -ENODEV;
+
+	/* khubd will finish the reset later */
+	if (ehci_is_TDI(ehci))
+		writel(PORT_RESET | (status & ~(PORT_CSC | PORT_PEC
+				| PORT_OCC)), &ehci->regs->port_status[port]);
+	else
+		writel(PORT_RESET, &ehci->regs->port_status[port]);
+
+	return 0;
+}
+#else
+static int ehci_start_port_reset(struct usb_hcd *hcd, unsigned port)
+{
+	return 0;
+}
+#endif /* CONFIG_USB_OTG */
+
 /*-------------------------------------------------------------------------*/
 
 static int ehci_hub_control (
@@ -675,6 +707,13 @@ static int ehci_hub_control (
 				goto error;
 			if (ehci->no_selective_suspend)
 				break;
+#if defined CONFIG_USB_OTG
+			if ((hcd->self.otg_port == (wIndex + 1))
+					&& hcd->self.b_hnp_enable) {
+				otg_start_hnp(ehci->transceiver);
+				break;
+			}
+#endif
 			if (temp & PORT_SUSPEND) {
 				if ((temp & PORT_PE) == 0)
 					goto error;
diff --git a/drivers/usb/host/ehci.h b/drivers/usb/host/ehci.h
index 556c0b4..12432cb 100644
--- a/drivers/usb/host/ehci.h
+++ b/drivers/usb/host/ehci.h
@@ -158,6 +158,11 @@ struct ehci_hcd {			/* one per controller */
 	struct dentry		*debug_periodic;
 	struct dentry		*debug_registers;
 #endif
+	/*
+	 * OTG controllers and transceivers need software interaction
+	 */
+	struct otg_transceiver	*transceiver;
+	u32			power_budget;
 };
 
 /* convert between an HCD pointer and the corresponding EHCI_HCD */
diff --git a/drivers/usb/otg/Kconfig b/drivers/usb/otg/Kconfig
index 3d2d3e5..ff22db4 100644
--- a/drivers/usb/otg/Kconfig
+++ b/drivers/usb/otg/Kconfig
@@ -69,4 +69,12 @@ config NOP_USB_XCEIV
 	 built-in with usb ip or which are autonomous and doesn't require any
 	 phy programming such as ISP1x04 etc.
 
+config FSL_USB2_OTG
+	bool "Freescale USB OTG Transceiver Driver"
+	depends on USB_EHCI_FSL
+	select USB_OTG
+	select USB_OTG_UTILS
+	help
+	  Enable this to support Freescale USB OTG transceiver.
+
 endif # USB || OTG
diff --git a/drivers/usb/otg/Makefile b/drivers/usb/otg/Makefile
index aeb49a8..d66e2c3 100644
--- a/drivers/usb/otg/Makefile
+++ b/drivers/usb/otg/Makefile
@@ -11,6 +11,8 @@ obj-$(CONFIG_ISP1301_OMAP)	+= isp1301_omap.o
 obj-$(CONFIG_TWL4030_USB)	+= twl4030-usb.o
 obj-$(CONFIG_NOP_USB_XCEIV)	+= nop-usb-xceiv.o
 obj-$(CONFIG_USB_ULPI)		+= ulpi.o
+fsl_usb2_otg-objs		:= fsl_otg.o otg_fsm.o
+obj-$(CONFIG_FSL_USB2_OTG)	+= fsl_usb2_otg.o
 
 ccflags-$(CONFIG_USB_DEBUG)	+= -DDEBUG
 ccflags-$(CONFIG_USB_GADGET_DEBUG) += -DDEBUG
diff --git a/drivers/usb/otg/fsl_otg.c b/drivers/usb/otg/fsl_otg.c
new file mode 100644
index 0000000..4cc8152
--- /dev/null
+++ b/drivers/usb/otg/fsl_otg.c
@@ -0,0 +1,1199 @@
+/*
+ * Copyright (C) 2007,2008 Freescale semiconductor, Inc.
+ *
+ * Author: Li Yang <LeoLi@freescale.com>
+ *         Jerry Huang <Chang-Ming.Huang@freescale.com>
+ *
+ * Initialization based on code from Shlomi Gridish.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/smp_lock.h>
+#include <linux/proc_fs.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/timer.h>
+#include <linux/usb.h>
+#include <linux/device.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/gadget.h>
+#include <linux/workqueue.h>
+#include <linux/time.h>
+#include <linux/fsl_devices.h>
+#include <linux/platform_device.h>
+#include <linux/uaccess.h>
+
+#include <asm/irq.h>
+#include <asm/system.h>
+#include <asm/byteorder.h>
+#include <asm/unaligned.h>
+
+#include "fsl_otg.h"
+
+#define CONFIG_USB_OTG_DEBUG_FILES
+#define DRIVER_VERSION "Revision: 1.55"
+#define DRIVER_AUTHOR "Jerry Huang/Li Yang"
+#define DRIVER_DESC "Freescale USB OTG Driver"
+#define DRIVER_INFO DRIVER_VERSION " " DRIVER_DESC
+
+MODULE_DESCRIPTION("Freescale USB OTG Transceiver Driver");
+
+static const char driver_name[] = "fsl-usb2-otg";
+
+const pm_message_t otg_suspend_state = {
+	.event = 1,
+};
+
+#define HA_DATA_PULSE 1
+
+static struct usb_dr_mmap *usb_dr_regs;
+static struct fsl_otg *fsl_otg_dev;
+static int srp_wait_done;
+
+/* FSM timers */
+struct fsl_otg_timer *a_wait_vrise_tmr, *a_wait_bcon_tmr, *a_aidl_bdis_tmr,
+	*b_ase0_brst_tmr, *b_se0_srp_tmr;
+
+/* Driver specific timers */
+struct fsl_otg_timer *b_data_pulse_tmr, *b_vbus_pulse_tmr, *b_srp_fail_tmr,
+	*b_srp_wait_tmr, *a_wait_enum_tmr;
+
+static struct list_head active_timers;
+
+static struct fsl_otg_config fsl_otg_initdata = {
+	.otg_port = 1,
+};
+
+/* Routines to access transceiver ULPI registers */
+u8 view_ulpi(u8 addr)
+{
+	u32 temp;
+
+	temp = 0x40000000 | (addr << 16);
+	temp = cpu_to_le32(temp);
+	fsl_writel(temp, &usb_dr_regs->ulpiview);
+	udelay(1000);
+	while (temp & 0x40)
+		temp = fsl_readl(&usb_dr_regs->ulpiview);
+	return (le32_to_cpu(temp) & 0x0000ff00) >> 8;
+}
+
+int write_ulpi(u8 addr, u8 data)
+{
+	u32 temp;
+
+	temp = 0x60000000 | (addr << 16) | data;
+	temp = cpu_to_hc32(temp);
+	fsl_writel(temp, &usb_dr_regs->ulpiview);
+	return 0;
+}
+
+/* -------------------------------------------------------------*/
+/* Operations that will be called from OTG Finite State Machine */
+
+/* Charge vbus for vbus pulsing in SRP */
+void fsl_otg_chrg_vbus(int on)
+{
+	u32 tmp;
+
+	tmp = fsl_readl(&usb_dr_regs->otgsc) & ~OTGSC_INTSTS_MASK;
+
+	if (on)
+		/* stop discharging, start charging */
+		tmp = (tmp & ~OTGSC_CTRL_VBUS_DISCHARGE) |
+			OTGSC_CTRL_VBUS_CHARGE;
+	else
+		/* stop charging */
+		tmp &= ~OTGSC_CTRL_VBUS_CHARGE;
+
+	fsl_writel(tmp, &usb_dr_regs->otgsc);
+}
+
+/* Discharge vbus through a resistor to ground */
+void fsl_otg_dischrg_vbus(int on)
+{
+	u32 tmp;
+
+	tmp = fsl_readl(&usb_dr_regs->otgsc) & ~OTGSC_INTSTS_MASK;
+
+	if (on)
+		/* stop charging, start discharging */
+		tmp = (tmp & ~OTGSC_CTRL_VBUS_CHARGE) |
+			OTGSC_CTRL_VBUS_DISCHARGE;
+	else
+		/* stop discharging */
+		tmp &= ~OTGSC_CTRL_VBUS_DISCHARGE;
+
+	fsl_writel(tmp, &usb_dr_regs->otgsc);
+}
+
+/* A-device driver vbus, controlled through PP bit in PORTSC */
+void fsl_otg_drv_vbus(int on)
+{
+/*
+	if (on)
+		usb_dr_regs->portsc =
+		    cpu_to_le32((le32_to_cpu(usb_dr_regs->portsc) &
+				 ~PORTSC_W1C_BITS) | PORTSC_PORT_POWER);
+	else
+		usb_dr_regs->portsc =
+		    cpu_to_le32(le32_to_cpu(usb_dr_regs->portsc) &
+				~PORTSC_W1C_BITS & ~PORTSC_PORT_POWER);
+*/
+}
+
+/*
+ * Pull-up D+, signalling connect by periperal. Also used in
+ * data-line pulsing in SRP
+ */
+void fsl_otg_loc_conn(int on)
+{
+	u32 tmp;
+
+	tmp = fsl_readl(&usb_dr_regs->otgsc) & ~OTGSC_INTSTS_MASK;
+
+	if (on)
+		tmp |= OTGSC_CTRL_DATA_PULSING;
+	else
+		tmp &= ~OTGSC_CTRL_DATA_PULSING;
+
+	fsl_writel(tmp, &usb_dr_regs->otgsc);
+}
+
+/* Generate SOF by host.  This is controlled through suspend/resume the
+ * port.  In host mode, controller will automatically send SOF.
+ * Suspend will block the data on the port.
+ */
+void fsl_otg_loc_sof(int on)
+{
+	u32 tmp;
+
+	tmp = fsl_readl(&fsl_otg_dev->dr_mem_map->portsc) & ~PORTSC_W1C_BITS;
+	if (on)
+		tmp |= PORTSC_PORT_FORCE_RESUME;
+	else
+		tmp |= PORTSC_PORT_SUSPEND;
+
+	fsl_writel(tmp, &fsl_otg_dev->dr_mem_map->portsc);
+
+}
+
+/* Start SRP pulsing by data-line pulsing, followed with v-bus pulsing. */
+void fsl_otg_start_pulse(void)
+{
+	u32 tmp;
+
+	srp_wait_done = 0;
+#ifdef HA_DATA_PULSE
+	tmp = fsl_readl(&usb_dr_regs->otgsc) & ~OTGSC_INTSTS_MASK;
+	tmp |= OTGSC_HA_DATA_PULSE;
+	fsl_writel(tmp, &usb_dr_regs->otgsc);
+#else
+	fsl_otg_loc_conn(1);
+#endif
+
+	fsl_otg_add_timer(b_data_pulse_tmr);
+}
+
+void b_data_pulse_end(unsigned long foo)
+{
+#ifdef HA_DATA_PULSE
+#else
+	fsl_otg_loc_conn(0);
+#endif
+
+	/* Do VBUS pulse after data pulse */
+	fsl_otg_pulse_vbus();
+}
+
+void fsl_otg_pulse_vbus(void)
+{
+	srp_wait_done = 0;
+	fsl_otg_chrg_vbus(1);
+	/* start the timer to end vbus charge */
+	fsl_otg_add_timer(b_vbus_pulse_tmr);
+}
+
+void b_vbus_pulse_end(unsigned long foo)
+{
+	fsl_otg_chrg_vbus(0);
+
+	/* As USB3300 using the same a_sess_vld and b_sess_vld voltage
+	 * we need to discharge the bus for a while to distinguish
+	 * residual voltage of vbus pulsing and A device pull up */
+	fsl_otg_dischrg_vbus(1);
+	fsl_otg_add_timer(b_srp_wait_tmr);
+}
+
+void b_srp_end(unsigned long foo)
+{
+	fsl_otg_dischrg_vbus(0);
+	srp_wait_done = 1;
+
+	if ((fsl_otg_dev->otg.state == OTG_STATE_B_SRP_INIT) &&
+	    fsl_otg_dev->fsm.b_sess_vld)
+		fsl_otg_dev->fsm.b_srp_done = 1;
+}
+
+/* Workaround for a_host suspending too fast.  When a_bus_req=0,
+ * a_host will start by SRP.  It needs to set b_hnp_enable before
+ * actually suspending to start HNP
+ */
+void a_wait_enum(unsigned long foo)
+{
+	VDBG("a_wait_enum timeout\n");
+	if (!fsl_otg_dev->otg.host->b_hnp_enable)
+		fsl_otg_add_timer(a_wait_enum_tmr);
+	else
+		otg_statemachine(&fsl_otg_dev->fsm);
+}
+
+/* ------------------------------------------------------*/
+
+/* The timeout callback function to set time out bit */
+void set_tmout(unsigned long indicator)
+{
+	*(int *)indicator = 1;
+}
+
+/* Initialize timers */
+int fsl_otg_init_timers(struct otg_fsm *fsm)
+{
+	/* FSM used timers */
+	a_wait_vrise_tmr = otg_timer_initializer(&set_tmout, TA_WAIT_VRISE,
+				(unsigned long)&fsm->a_wait_vrise_tmout);
+	if (a_wait_vrise_tmr == NULL)
+		return -ENOMEM;
+
+	a_wait_bcon_tmr = otg_timer_initializer(&set_tmout, TA_WAIT_BCON,
+				(unsigned long)&fsm->a_wait_bcon_tmout);
+	if (a_wait_bcon_tmr == NULL)
+		return -ENOMEM;
+
+	a_aidl_bdis_tmr = otg_timer_initializer(&set_tmout, TA_AIDL_BDIS,
+				(unsigned long)&fsm->a_aidl_bdis_tmout);
+	if (a_aidl_bdis_tmr == NULL)
+		return -ENOMEM;
+
+	b_ase0_brst_tmr = otg_timer_initializer(&set_tmout, TB_ASE0_BRST,
+				(unsigned long)&fsm->b_ase0_brst_tmout);
+	if (b_ase0_brst_tmr == NULL)
+		return -ENOMEM;
+
+	b_se0_srp_tmr = otg_timer_initializer(&set_tmout, TB_SE0_SRP,
+				(unsigned long)&fsm->b_se0_srp);
+	if (b_se0_srp_tmr == NULL)
+		return -ENOMEM;
+
+	b_srp_fail_tmr = otg_timer_initializer(&set_tmout, TB_SRP_FAIL,
+				(unsigned long)&fsm->b_srp_done);
+	if (b_srp_fail_tmr == NULL)
+		return -ENOMEM;
+
+	a_wait_enum_tmr = otg_timer_initializer(&a_wait_enum, 10,
+				(unsigned long)&fsm);
+	if (a_wait_enum_tmr == NULL)
+		return -ENOMEM;
+
+	/* device driver used timers */
+	b_srp_wait_tmr = otg_timer_initializer(&b_srp_end, TB_SRP_WAIT, 0);
+	if (b_srp_wait_tmr == NULL)
+		return -ENOMEM;
+
+	b_data_pulse_tmr = otg_timer_initializer(&b_data_pulse_end,
+				TB_DATA_PLS, 0);
+	if (b_data_pulse_tmr == NULL)
+		return -ENOMEM;
+
+	b_vbus_pulse_tmr = otg_timer_initializer(&b_vbus_pulse_end,
+				TB_VBUS_PLS, 0);
+	if (b_vbus_pulse_tmr == NULL)
+		return -ENOMEM;
+
+	return 0;
+}
+
+/* Uninitialize timers */
+void fsl_otg_uninit_timers(void)
+{
+	/* FSM used timers */
+	if (a_wait_vrise_tmr != NULL)
+		kfree(a_wait_vrise_tmr);
+	if (a_wait_bcon_tmr != NULL)
+		kfree(a_wait_bcon_tmr);
+	if (a_aidl_bdis_tmr != NULL)
+		kfree(a_aidl_bdis_tmr);
+	if (b_ase0_brst_tmr != NULL)
+		kfree(b_ase0_brst_tmr);
+	if (b_se0_srp_tmr != NULL)
+		kfree(b_se0_srp_tmr);
+	if (b_srp_fail_tmr != NULL)
+		kfree(b_srp_fail_tmr);
+	if (a_wait_enum_tmr != NULL)
+		kfree(a_wait_enum_tmr);
+
+	/* device driver used timers */
+	if (b_srp_wait_tmr != NULL)
+		kfree(b_srp_wait_tmr);
+	if (b_data_pulse_tmr != NULL)
+		kfree(b_data_pulse_tmr);
+	if (b_vbus_pulse_tmr != NULL)
+		kfree(b_vbus_pulse_tmr);
+}
+
+/* Add timer to timer list */
+void fsl_otg_add_timer(void *gtimer)
+{
+	struct fsl_otg_timer *timer = (struct fsl_otg_timer *)gtimer;
+	struct fsl_otg_timer *tmp_timer;
+
+	/* Check if the timer is already in the active list,
+	 * if so update timer count
+	 */
+	list_for_each_entry(tmp_timer, &active_timers, list)
+	    if (tmp_timer == timer) {
+		timer->count = timer->expires;
+		return;
+	}
+	timer->count = timer->expires;
+	list_add_tail(&timer->list, &active_timers);
+}
+
+/* Remove timer from the timer list; clear timeout status */
+void fsl_otg_del_timer(void *gtimer)
+{
+	struct fsl_otg_timer *timer = (struct fsl_otg_timer *)gtimer;
+	struct fsl_otg_timer *tmp_timer, *del_tmp;
+
+	list_for_each_entry_safe(tmp_timer, del_tmp, &active_timers, list)
+		if (tmp_timer == timer)
+			list_del(&timer->list);
+}
+
+/* Reduce timer count by 1, and find timeout conditions.
+ * Called by fsl_otg 1ms timer interrupt
+ */
+int fsl_otg_tick_timer(void)
+{
+	struct fsl_otg_timer *tmp_timer, *del_tmp;
+	int expired = 0;
+
+	list_for_each_entry_safe(tmp_timer, del_tmp, &active_timers, list) {
+		tmp_timer->count--;
+		/* check if timer expires */
+		if (!tmp_timer->count) {
+			list_del(&tmp_timer->list);
+			tmp_timer->function(tmp_timer->data);
+			expired = 1;
+		}
+	}
+
+	return expired;
+}
+
+/* Reset controller, not reset the bus */
+void otg_reset_controller(void)
+{
+	u32 command;
+
+	command = fsl_readl(&usb_dr_regs->usbcmd);
+	command |= (1 << 1);
+	fsl_writel(command, &usb_dr_regs->usbcmd);
+	while (fsl_readl(&usb_dr_regs->usbcmd) & (1 << 1))
+		;
+}
+
+/* Call suspend/resume routines in host driver */
+int fsl_otg_start_host(struct otg_fsm *fsm, int on)
+{
+	struct otg_transceiver *xceiv = fsm->transceiver;
+	struct device *dev;
+	struct fsl_otg *otg_dev = container_of(xceiv, struct fsl_otg, otg);
+	u32 retval = 0;
+
+	if (!xceiv->host)
+		return -ENODEV;
+	dev = xceiv->host->controller;
+
+	/* Update a_vbus_vld state as a_vbus_vld int is disabled
+	 * in device mode
+	 */
+	fsm->a_vbus_vld =
+		!!(fsl_readl(&usb_dr_regs->otgsc) & OTGSC_STS_A_VBUS_VALID);
+	if (on) {
+		/* start fsl usb host controller */
+		if (otg_dev->host_working)
+			goto end;
+		else {
+			otg_reset_controller();
+			VDBG("host on......\n");
+			if (dev->driver->pm && dev->driver->pm->resume) {
+				retval = dev->driver->pm->resume(dev);
+				if (fsm->id) {
+					/* default-b */
+					fsl_otg_drv_vbus(1);
+					/* Workaround: b_host can't driver
+					 * vbus, but PP in PORTSC needs to
+					 * be 1 for host to work.
+					 * So we set drv_vbus bit in
+					 * transceiver to 0 thru ULPI. */
+					write_ulpi(0x0c, 0x20);
+				}
+			}
+
+			otg_dev->host_working = 1;
+		}
+	} else {
+		/* stop fsl usb host controller */
+		if (!otg_dev->host_working)
+			goto end;
+		else {
+			VDBG("host off......\n");
+			if (dev && dev->driver) {
+				if (dev->driver->pm && dev->driver->pm->suspend)
+					retval = dev->driver->pm->suspend(dev);
+				if (fsm->id)
+					/* default-b */
+					fsl_otg_drv_vbus(0);
+			}
+			otg_dev->host_working = 0;
+		}
+	}
+end:
+	return retval;
+}
+
+/* Call suspend and resume function in udc driver
+ * to stop and start udc driver.
+ */
+int fsl_otg_start_gadget(struct otg_fsm *fsm, int on)
+{
+	struct otg_transceiver *xceiv = fsm->transceiver;
+	struct device *dev;
+
+	if (!xceiv->gadget || !xceiv->gadget->dev.parent)
+		return -ENODEV;
+
+	VDBG("gadget %s\n", on ? "on" : "off");
+	dev = xceiv->gadget->dev.parent;
+
+	if (on) {
+		if (dev->driver->resume)
+			dev->driver->resume(dev);
+	} else {
+		if (dev->driver->suspend)
+			dev->driver->suspend(dev, otg_suspend_state);
+	}
+
+	return 0;
+}
+
+/* Called by initialization code of host driver.  Register host controller
+ * to the OTG.  Suspend host for OTG role detection.
+ */
+static int fsl_otg_set_host(struct otg_transceiver *otg_p, struct usb_bus *host)
+{
+	struct fsl_otg *otg_dev = container_of(otg_p, struct fsl_otg, otg);
+
+	if (!otg_p || otg_dev != fsl_otg_dev)
+		return -ENODEV;
+
+	otg_p->host = host;
+
+	otg_dev->fsm.a_bus_drop = 0;
+	otg_dev->fsm.a_bus_req = 1;
+
+	if (host) {
+		VDBG("host off......\n");
+
+		otg_p->host->otg_port = fsl_otg_initdata.otg_port;
+		otg_p->host->is_b_host = otg_dev->fsm.id;
+		/* must leave time for khubd to finish its thing
+		 * before yanking the host driver out from under it,
+		 * so suspend the host after a short delay.
+		 */
+		otg_dev->host_working = 1;
+		schedule_delayed_work(&otg_dev->otg_event, 100);
+		return 0;
+	} else {		/* host driver going away */
+
+		if (!(fsl_readl(&otg_dev->dr_mem_map->otgsc) &
+		      OTGSC_STS_USB_ID)) {
+			/* Mini-A cable connected */
+			struct otg_fsm *fsm = &otg_dev->fsm;
+
+			otg_p->state = OTG_STATE_UNDEFINED;
+			fsm->protocol = PROTO_UNDEF;
+		}
+	}
+
+	otg_dev->host_working = 0;
+
+	otg_statemachine(&otg_dev->fsm);
+
+	return 0;
+}
+
+/* Called by initialization code of udc.  Register udc to OTG.*/
+static int fsl_otg_set_peripheral(struct otg_transceiver *otg_p,
+				  struct usb_gadget *gadget)
+{
+	struct fsl_otg *otg_dev = container_of(otg_p, struct fsl_otg, otg);
+
+	VDBG("otg_dev 0x%x\n", (int)otg_dev);
+	VDBG("fsl_otg_dev 0x%x\n", (int)fsl_otg_dev);
+
+	if (!otg_p || otg_dev != fsl_otg_dev)
+		return -ENODEV;
+
+	if (!gadget) {
+		if (!otg_dev->otg.default_a)
+			otg_p->gadget->ops->vbus_draw(otg_p->gadget, 0);
+		usb_gadget_vbus_disconnect(otg_dev->otg.gadget);
+		otg_dev->otg.gadget = 0;
+		otg_dev->fsm.b_bus_req = 0;
+		otg_statemachine(&otg_dev->fsm);
+		return 0;
+	}
+
+	otg_p->gadget = gadget;
+	otg_p->gadget->is_a_peripheral = !otg_dev->fsm.id;
+
+	otg_dev->fsm.b_bus_req = 1;
+
+	/* start the gadget right away if the ID pin says Mini-B */
+	DBG("ID pin=%d\n", otg_dev->fsm.id);
+	if (otg_dev->fsm.id == 1) {
+		fsl_otg_start_host(&otg_dev->fsm, 0);
+		otg_drv_vbus(&otg_dev->fsm, 0);
+		fsl_otg_start_gadget(&otg_dev->fsm, 1);
+	}
+
+	return 0;
+}
+
+/* Set OTG port power, only for B-device */
+static int fsl_otg_set_power(struct otg_transceiver *otg_p, unsigned mA)
+{
+	if (!fsl_otg_dev)
+		return -ENODEV;
+	if (otg_p->state == OTG_STATE_B_PERIPHERAL)
+		printk(KERN_INFO "FSL OTG:Draw %d mA\n", mA);
+
+	return 0;
+}
+
+/* Delayed pin detect interrupt processing.
+ *
+ * When the Mini-A cable is disconnected from the board,
+ * the pin-detect interrupt happens before the disconnnect
+ * interrupts for the connected device(s).  In order to
+ * process the disconnect interrupt(s) prior to switching
+ * roles, the pin-detect interrupts are delayed, and handled
+ * by this routine.
+ */
+static void fsl_otg_event(struct work_struct *work)
+{
+	struct fsl_otg *og = container_of(work, struct fsl_otg, otg_event.work);
+	struct otg_fsm *fsm = &og->fsm;
+
+	if (fsm->id) {		/* switch to gadget */
+		fsl_otg_start_host(fsm, 0);
+		otg_drv_vbus(fsm, 0);
+		fsl_otg_start_gadget(fsm, 1);
+	}
+}
+
+/* B-device start SRP */
+static int fsl_otg_start_srp(struct otg_transceiver *otg_p)
+{
+	struct fsl_otg *otg_dev = container_of(otg_p, struct fsl_otg, otg);
+
+	if (!otg_p || otg_dev != fsl_otg_dev
+	    || otg_p->state != OTG_STATE_B_IDLE)
+		return -ENODEV;
+
+	otg_dev->fsm.b_bus_req = 1;
+	otg_statemachine(&otg_dev->fsm);
+
+	return 0;
+}
+
+/* A_host suspend will call this function to start hnp */
+static int fsl_otg_start_hnp(struct otg_transceiver *otg_p)
+{
+	struct fsl_otg *otg_dev = container_of(otg_p, struct fsl_otg, otg);
+
+	if (!otg_p || otg_dev != fsl_otg_dev)
+		return -ENODEV;
+
+	/* printk("start_hnp.............\n"); */
+	/* clear a_bus_req to enter a_suspend state */
+	otg_dev->fsm.a_bus_req = 0;
+	otg_statemachine(&otg_dev->fsm);
+
+	return 0;
+}
+
+/* Interrupt handler.  OTG/host/peripheral share the same int line.
+ * OTG driver clears OTGSC interrupts and leaves USB interrupts
+ * intact.  It needs to have knowledge of some USB interrupts
+ * such as port change.
+ */
+irqreturn_t fsl_otg_isr(int irq, void *dev_id)
+{
+	struct otg_fsm *fsm = &((struct fsl_otg *)dev_id)->fsm;
+	struct otg_transceiver *otg = &((struct fsl_otg *)dev_id)->otg;
+	u32 otg_int_src, otg_sc;
+
+	otg_sc = fsl_readl(&usb_dr_regs->otgsc);
+	otg_int_src = otg_sc & OTGSC_INTSTS_MASK & (otg_sc >> 8);
+
+	/* Only clear otg interrupts */
+	fsl_writel(otg_sc, &usb_dr_regs->otgsc);
+
+	/*FIXME: ID change not generate when init to 0 */
+	fsm->id = (otg_sc & OTGSC_STS_USB_ID) ? 1 : 0;
+	otg->default_a = (fsm->id == 0);
+
+	/* process OTG interrupts */
+	if (otg_int_src) {
+		if (otg_int_src & OTGSC_INTSTS_USB_ID) {
+			fsm->id = (otg_sc & OTGSC_STS_USB_ID) ? 1 : 0;
+			otg->default_a = (fsm->id == 0);
+			/* clear conn information */
+			if (fsm->id)
+				fsm->b_conn = 0;
+			else
+				fsm->a_conn = 0;
+
+			if (otg->host)
+				otg->host->is_b_host = fsm->id;
+			if (otg->gadget)
+				otg->gadget->is_a_peripheral = !fsm->id;
+			VDBG("ID int (ID is %d)\n", fsm->id);
+
+			if (fsm->id) {	/* switch to gadget */
+				schedule_delayed_work(
+					&((struct fsl_otg *)dev_id)->otg_event,
+					100);
+			} else {	/* switch to host */
+				cancel_delayed_work(&
+						    ((struct fsl_otg *)dev_id)->
+						    otg_event);
+				fsl_otg_start_gadget(fsm, 0);
+				otg_drv_vbus(fsm, 1);
+				fsl_otg_start_host(fsm, 1);
+			}
+			return IRQ_HANDLED;
+		}
+	}
+	return IRQ_NONE;
+}
+
+static struct otg_fsm_ops fsl_otg_ops = {
+	.chrg_vbus = fsl_otg_chrg_vbus,
+	.drv_vbus = fsl_otg_drv_vbus,
+	.loc_conn = fsl_otg_loc_conn,
+	.loc_sof = fsl_otg_loc_sof,
+	.start_pulse = fsl_otg_start_pulse,
+
+	.add_timer = fsl_otg_add_timer,
+	.del_timer = fsl_otg_del_timer,
+
+	.start_host = fsl_otg_start_host,
+	.start_gadget = fsl_otg_start_gadget,
+};
+
+/* Initialize the global variable fsl_otg_dev and request IRQ for OTG */
+static int fsl_otg_conf(struct platform_device *pdev)
+{
+	int status;
+	struct fsl_otg *fsl_otg_tc;
+	struct fsl_usb2_platform_data *pdata;
+
+	pdata = pdev->dev.platform_data;
+
+	DBG();
+
+	if (fsl_otg_dev)
+		return 0;
+
+	/* allocate space to fsl otg device */
+	fsl_otg_tc = kzalloc(sizeof(struct fsl_otg), GFP_KERNEL);
+	if (!fsl_otg_tc)
+		return -ENODEV;
+
+	INIT_DELAYED_WORK(&fsl_otg_tc->otg_event, fsl_otg_event);
+
+	INIT_LIST_HEAD(&active_timers);
+	status = fsl_otg_init_timers(&fsl_otg_tc->fsm);
+	if (status) {
+		printk(KERN_INFO "Couldn't init OTG timers\n");
+		fsl_otg_uninit_timers();
+		kfree(fsl_otg_tc);
+		return status;
+	}
+	spin_lock_init(&fsl_otg_tc->fsm.lock);
+
+	/* Set OTG state machine operations */
+	fsl_otg_tc->fsm.ops = &fsl_otg_ops;
+
+	/* initialize the otg structure */
+	fsl_otg_tc->otg.label = DRIVER_DESC;
+	fsl_otg_tc->otg.set_host = fsl_otg_set_host;
+	fsl_otg_tc->otg.set_peripheral = fsl_otg_set_peripheral;
+	fsl_otg_tc->otg.set_power = fsl_otg_set_power;
+	fsl_otg_tc->otg.start_hnp = fsl_otg_start_hnp;
+	fsl_otg_tc->otg.start_srp = fsl_otg_start_srp;
+
+	fsl_otg_dev = fsl_otg_tc;
+
+	/* Store the otg transceiver */
+	status = otg_set_transceiver(&fsl_otg_tc->otg);
+	if (status) {
+		printk(KERN_WARNING ": unable to register OTG transceiver.\n");
+		return status;
+	}
+
+	return 0;
+}
+
+/* OTG Initialization*/
+int usb_otg_start(struct platform_device *pdev)
+{
+	struct fsl_otg *p_otg;
+	struct otg_transceiver *otg_trans = otg_get_transceiver();
+	struct otg_fsm *fsm;
+	int status;
+	struct resource *res;
+	u32 temp;
+	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
+
+	p_otg = container_of(otg_trans, struct fsl_otg, otg);
+	fsm = &p_otg->fsm;
+
+	/* Initialize the state machine structure with default values */
+	SET_OTG_STATE(otg_trans, OTG_STATE_UNDEFINED);
+	fsm->transceiver = &p_otg->otg;
+
+	/* We don't require predefined MEM/IRQ resource index */
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENXIO;
+
+	/* We don't request_mem_region here to enable resource sharing
+	 * with host/device */
+
+	usb_dr_regs = ioremap(res->start, sizeof(struct usb_dr_mmap));
+	p_otg->dr_mem_map = (struct usb_dr_mmap *)usb_dr_regs;
+	pdata->regs = (void *)usb_dr_regs;
+
+	/* request irq */
+	p_otg->irq = platform_get_irq(pdev, 0);
+	status = request_irq(p_otg->irq, fsl_otg_isr,
+				IRQF_SHARED, driver_name, p_otg);
+	if (status) {
+		dev_dbg(p_otg->otg.dev, "can't get IRQ %d, error %d\n",
+			p_otg->irq, status);
+		iounmap(p_otg->dr_mem_map);
+		kfree(p_otg);
+		return status;
+	}
+
+	if (pdata->platform_init && pdata->platform_init(pdev) != 0)
+		return -EINVAL;
+
+	fsl_set_usb_accessors(pdata);
+
+	/* Export DR controller resources */
+	otg_set_resources(pdev->resource);
+
+	/* stop the controller */
+	temp = fsl_readl(&p_otg->dr_mem_map->usbcmd);
+	temp &= ~USB_CMD_RUN_STOP;
+	fsl_writel(temp, &p_otg->dr_mem_map->usbcmd);
+
+	/* reset the controller */
+	temp = fsl_readl(&p_otg->dr_mem_map->usbcmd);
+	temp |= USB_CMD_CTRL_RESET;
+	fsl_writel(temp, &p_otg->dr_mem_map->usbcmd);
+
+	/* wait reset completed */
+	while (fsl_readl(&p_otg->dr_mem_map->usbcmd) & USB_CMD_CTRL_RESET)
+		;
+
+	/* configure the VBUSHS as IDLE(both host and device) */
+	temp = USB_MODE_STREAM_DISABLE | (pdata->es ? USB_MODE_ES : 0);
+	fsl_writel(temp, &p_otg->dr_mem_map->usbmode);
+
+	/* configure PHY interface */
+	temp = fsl_readl(&p_otg->dr_mem_map->portsc);
+	temp &= ~(PORTSC_PHY_TYPE_SEL | PORTSC_PTW);
+	switch (pdata->phy_mode) {
+	case FSL_USB2_PHY_ULPI:
+		temp |= PORTSC_PTS_ULPI;
+		break;
+	case FSL_USB2_PHY_UTMI_WIDE:
+		temp |= PORTSC_PTW_16BIT;
+		/* fall through */
+	case FSL_USB2_PHY_UTMI:
+		temp |= PORTSC_PTS_UTMI;
+		/* fall through */
+	default:
+		break;
+	}
+	fsl_writel(temp, &p_otg->dr_mem_map->portsc);
+
+	if (pdata->have_sysif_regs) {
+		/* configure control enable IO output, big endian register */
+		temp = __raw_readl(&p_otg->dr_mem_map->control);
+		temp |= USB_CTRL_IOENB;
+		__raw_writel(temp, &p_otg->dr_mem_map->control);
+	}
+
+	/* disable all interrupt and clear all OTGSC status */
+	temp = fsl_readl(&p_otg->dr_mem_map->otgsc);
+	temp &= ~OTGSC_INTERRUPT_ENABLE_BITS_MASK;
+	temp |= OTGSC_INTERRUPT_STATUS_BITS_MASK | OTGSC_CTRL_VBUS_DISCHARGE;
+	fsl_writel(temp, &p_otg->dr_mem_map->otgsc);
+
+
+	/*
+	 * The identification (id) input is FALSE when a Mini-A plug is inserted
+	 * in the devices Mini-AB receptacle. Otherwise, this input is TRUE.
+	 * Also: record initial state of ID pin
+	 */
+	if (fsl_readl(&p_otg->dr_mem_map->otgsc) & OTGSC_STS_USB_ID) {
+		p_otg->otg.state = OTG_STATE_UNDEFINED;
+		p_otg->fsm.id = 1;
+	} else {
+		p_otg->otg.state = OTG_STATE_A_IDLE;
+		p_otg->fsm.id = 0;
+	}
+
+	DBG("initial ID pin=%d\n", p_otg->fsm.id);
+
+	/* enable OTG ID pin interrupt */
+	temp = fsl_readl(&p_otg->dr_mem_map->otgsc);
+	temp |= OTGSC_INTR_USB_ID_EN;
+	temp &= ~(OTGSC_CTRL_VBUS_DISCHARGE | OTGSC_INTR_1MS_TIMER_EN);
+	fsl_writel(temp, &p_otg->dr_mem_map->otgsc);
+
+	return 0;
+}
+
+/*-------------------------------------------------------------------------
+		PROC File System Support
+-------------------------------------------------------------------------*/
+#ifdef CONFIG_USB_OTG_DEBUG_FILES
+
+#include <linux/seq_file.h>
+
+static const char proc_filename[] = "driver/fsl_usb2_otg";
+
+static int otg_proc_read(char *page, char **start, off_t off, int count,
+			 int *eof, void *_dev)
+{
+	struct otg_fsm *fsm = &fsl_otg_dev->fsm;
+	char *buf = page;
+	char *next = buf;
+	unsigned size = count;
+	unsigned long flags;
+	int t;
+	u32 tmp_reg;
+
+	if (off != 0)
+		return 0;
+
+	spin_lock_irqsave(&fsm->lock, flags);
+
+	/* ------basic driver infomation ---- */
+	t = scnprintf(next, size,
+		      DRIVER_DESC "\n" "fsl_usb2_otg version: %s\n\n",
+		      DRIVER_VERSION);
+	size -= t;
+	next += t;
+
+	/* ------ Registers ----- */
+	tmp_reg = fsl_readl(&usb_dr_regs->otgsc);
+	t = scnprintf(next, size, "OTGSC reg: %08x\n", tmp_reg);
+	size -= t;
+	next += t;
+
+	tmp_reg = fsl_readl(&usb_dr_regs->portsc);
+	t = scnprintf(next, size, "PORTSC reg: %08x\n", tmp_reg);
+	size -= t;
+	next += t;
+
+	tmp_reg = fsl_readl(&usb_dr_regs->usbmode);
+	t = scnprintf(next, size, "USBMODE reg: %08x\n", tmp_reg);
+	size -= t;
+	next += t;
+
+	tmp_reg = fsl_readl(&usb_dr_regs->usbcmd);
+	t = scnprintf(next, size, "USBCMD reg: %08x\n", tmp_reg);
+	size -= t;
+	next += t;
+
+	tmp_reg = fsl_readl(&usb_dr_regs->usbsts);
+	t = scnprintf(next, size, "USBSTS reg: %08x\n", tmp_reg);
+	size -= t;
+	next += t;
+
+	tmp_reg = fsl_readl(&usb_dr_regs->usbintr);
+	t = scnprintf(next, size, "USBINTR reg: %08x\n", tmp_reg);
+	size -= t;
+	next += t;
+
+	/* ------ State ----- */
+	t = scnprintf(next, size,
+		      "OTG state: %s\n\n",
+		      state_string(fsl_otg_dev->otg.state));
+	size -= t;
+	next += t;
+
+	/* ------ State Machine Variables ----- */
+	t = scnprintf(next, size, "a_bus_req: %d\n", fsm->a_bus_req);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "b_bus_req: %d\n", fsm->b_bus_req);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "a_bus_resume: %d\n", fsm->a_bus_resume);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "a_bus_suspend: %d\n", fsm->a_bus_suspend);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "a_conn: %d\n", fsm->a_conn);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "a_sess_vld: %d\n", fsm->a_sess_vld);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "a_srp_det: %d\n", fsm->a_srp_det);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "a_vbus_vld: %d\n", fsm->a_vbus_vld);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "b_bus_resume: %d\n", fsm->b_bus_resume);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "b_bus_suspend: %d\n", fsm->b_bus_suspend);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "b_conn: %d\n", fsm->b_conn);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "b_se0_srp: %d\n", fsm->b_se0_srp);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "b_sess_end: %d\n", fsm->b_sess_end);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "b_sess_vld: %d\n", fsm->b_sess_vld);
+	size -= t;
+	next += t;
+
+	t = scnprintf(next, size, "id: %d\n", fsm->id);
+	size -= t;
+	next += t;
+
+	spin_unlock_irqrestore(&fsm->lock, flags);
+
+	*eof = 1;
+	return count - size;
+}
+
+#define create_proc_file()	create_proc_read_entry(proc_filename, \
+				0, NULL, otg_proc_read, NULL)
+
+#define remove_proc_file()	remove_proc_entry(proc_filename, NULL)
+
+#else				/* !CONFIG_USB_OTG_DEBUG_FILES */
+
+#define create_proc_file()	do {} while (0)
+#define remove_proc_file()	do {} while (0)
+
+#endif				/*CONFIG_USB_OTG_DEBUG_FILES */
+
+/*----------------------------------------------------------*/
+/* Char driver interface to control some OTG input */
+
+/* This function handle some ioctl command,such as get otg
+ * status and set host suspend
+ */
+static int fsl_otg_ioctl(struct inode *inode, struct file *file,
+			 unsigned int cmd, unsigned long arg)
+{
+	u32 retval = 0;
+
+	switch (cmd) {
+	case GET_OTG_STATUS:
+		retval = fsl_otg_dev->host_working;
+		break;
+
+	case SET_A_SUSPEND_REQ:
+		fsl_otg_dev->fsm.a_suspend_req = arg;
+		break;
+
+	case SET_A_BUS_DROP:
+		fsl_otg_dev->fsm.a_bus_drop = arg;
+		break;
+
+	case SET_A_BUS_REQ:
+		fsl_otg_dev->fsm.a_bus_req = arg;
+		break;
+
+	case SET_B_BUS_REQ:
+		fsl_otg_dev->fsm.b_bus_req = arg;
+		break;
+
+	default:
+		break;
+	}
+
+	otg_statemachine(&fsl_otg_dev->fsm);
+
+	return retval;
+}
+
+static int fsl_otg_open(struct inode *inode, struct file *file)
+{
+
+	return 0;
+}
+
+static int fsl_otg_release(struct inode *inode, struct file *file)
+{
+
+	return 0;
+}
+
+static const struct file_operations otg_fops = {
+	.owner = THIS_MODULE,
+	.llseek = NULL,
+	.read = NULL,
+	.write = NULL,
+	.ioctl = fsl_otg_ioctl,
+	.open = fsl_otg_open,
+	.release = fsl_otg_release,
+};
+
+static int __init fsl_otg_probe(struct platform_device *pdev)
+{
+	int status;
+
+	DBG("pdev=0x%p\n", pdev);
+
+	if (!pdev)
+		return -ENODEV;
+
+	if (!pdev->dev.platform_data)
+		return -ENOMEM;
+
+	/* configure the OTG */
+	status = fsl_otg_conf(pdev);
+	if (status) {
+		printk(KERN_INFO "Couldn't init OTG module\n");
+		return -status;
+	}
+
+	/* start OTG */
+	status = usb_otg_start(pdev);
+
+	if (register_chrdev(FSL_OTG_MAJOR, FSL_OTG_NAME, &otg_fops)) {
+		printk(KERN_WARNING FSL_OTG_NAME
+		       ": unable to register FSL OTG device\n");
+		return -EIO;
+	}
+
+	create_proc_file();
+
+	return status;
+}
+
+static int __exit fsl_otg_remove(struct platform_device *pdev)
+{
+	struct fsl_usb2_platform_data *pdata = pdev->dev.platform_data;
+
+	otg_set_transceiver(NULL);
+	free_irq(fsl_otg_dev->irq, fsl_otg_dev);
+
+	iounmap((void *)usb_dr_regs);
+
+	kfree(fsl_otg_dev);
+
+	remove_proc_file();
+
+	unregister_chrdev(FSL_OTG_MAJOR, FSL_OTG_NAME);
+
+	if (pdata->platform_uninit)
+		pdata->platform_uninit(pdev);
+
+	return 0;
+}
+
+struct platform_driver fsl_otg_driver = {
+	.probe = fsl_otg_probe,
+	.remove = fsl_otg_remove,
+	.driver = {
+		.name = driver_name,
+		.owner = THIS_MODULE,
+	},
+};
+
+/*-------------------------------------------------------------------------*/
+
+static int __init fsl_usb_otg_init(void)
+{
+	printk(KERN_INFO DRIVER_DESC " loaded, %s\n", DRIVER_VERSION);
+	return platform_driver_register(&fsl_otg_driver);
+}
+
+static void __exit fsl_usb_otg_exit(void)
+{
+	platform_driver_unregister(&fsl_otg_driver);
+	printk(KERN_INFO DRIVER_DESC " unloaded\n");
+}
+
+module_init(fsl_usb_otg_init);
+module_exit(fsl_usb_otg_exit);
+
+MODULE_DESCRIPTION(DRIVER_INFO);
+MODULE_AUTHOR(DRIVER_AUTHOR);
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/otg/fsl_otg.h b/drivers/usb/otg/fsl_otg.h
new file mode 100644
index 0000000..d4a2505
--- /dev/null
+++ b/drivers/usb/otg/fsl_otg.h
@@ -0,0 +1,418 @@
+/* Copyright (C) 2007,2008 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include "otg_fsm.h"
+#include <linux/usb/otg.h>
+#include <linux/ioctl.h>
+
+#ifdef CONFIG_PPC32
+#include <asm/fsl_usb_io.h>
+#endif
+
+ /* USB Command  Register Bit Masks */
+#define USB_CMD_RUN_STOP		(0x1<<0)
+#define USB_CMD_CTRL_RESET		(0x1<<1)
+#define USB_CMD_PERIODIC_SCHEDULE_EN	(0x1<<4)
+#define USB_CMD_ASYNC_SCHEDULE_EN	(0x1<<5)
+#define USB_CMD_INT_AA_DOORBELL	(0x1<<6)
+#define USB_CMD_ASP			(0x3<<8)
+#define USB_CMD_ASYNC_SCH_PARK_EN	(0x1<<11)
+#define USB_CMD_SUTW			(0x1<<13)
+#define USB_CMD_ATDTW			(0x1<<14)
+#define USB_CMD_ITC			(0xFF<<16)
+
+/* bit 15,3,2 are frame list size */
+#define USB_CMD_FRAME_SIZE_1024		(0x0<<15 | 0x0<<2)
+#define USB_CMD_FRAME_SIZE_512		(0x0<<15 | 0x1<<2)
+#define USB_CMD_FRAME_SIZE_256		(0x0<<15 | 0x2<<2)
+#define USB_CMD_FRAME_SIZE_128		(0x0<<15 | 0x3<<2)
+#define USB_CMD_FRAME_SIZE_64		(0x1<<15 | 0x0<<2)
+#define USB_CMD_FRAME_SIZE_32		(0x1<<15 | 0x1<<2)
+#define USB_CMD_FRAME_SIZE_16		(0x1<<15 | 0x2<<2)
+#define USB_CMD_FRAME_SIZE_8		(0x1<<15 | 0x3<<2)
+
+/* bit 9-8 are async schedule park mode count */
+#define USB_CMD_ASP_00			(0x0<<8)
+#define USB_CMD_ASP_01			(0x1<<8)
+#define USB_CMD_ASP_10			(0x2<<8)
+#define USB_CMD_ASP_11			(0x3<<8)
+#define USB_CMD_ASP_BIT_POS		(8)
+
+/* bit 23-16 are interrupt threshold control */
+#define USB_CMD_ITC_NO_THRESHOLD	(0x00<<16)
+#define USB_CMD_ITC_1_MICRO_FRM		(0x01<<16)
+#define USB_CMD_ITC_2_MICRO_FRM		(0x02<<16)
+#define USB_CMD_ITC_4_MICRO_FRM		(0x04<<16)
+#define USB_CMD_ITC_8_MICRO_FRM		(0x08<<16)
+#define USB_CMD_ITC_16_MICRO_FRM	(0x10<<16)
+#define USB_CMD_ITC_32_MICRO_FRM	(0x20<<16)
+#define USB_CMD_ITC_64_MICRO_FRM	(0x40<<16)
+#define USB_CMD_ITC_BIT_POS		(16)
+
+/* USB Status Register Bit Masks */
+#define USB_STS_INT			(0x1<<0)
+#define USB_STS_ERR			(0x1<<1)
+#define USB_STS_PORT_CHANGE		(0x1<<2)
+#define USB_STS_FRM_LST_ROLL		(0x1<<3)
+#define USB_STS_SYS_ERR			(0x1<<4)
+#define USB_STS_IAA			(0x1<<5)
+#define USB_STS_RESET_RECEIVED		(0x1<<6)
+#define USB_STS_SOF			(0x1<<7)
+#define USB_STS_DCSUSPEND		(0x1<<8)
+#define USB_STS_HC_HALTED		(0x1<<12)
+#define USB_STS_RCL			(0x1<<13)
+#define USB_STS_PERIODIC_SCHEDULE	(0x1<<14)
+#define USB_STS_ASYNC_SCHEDULE		(0x1<<15)
+
+/* USB Interrupt Enable Register Bit Masks */
+#define USB_INTR_INT_EN			(0x1<<0)
+#define USB_INTR_ERR_INT_EN		(0x1<<1)
+#define USB_INTR_PC_DETECT_EN		(0x1<<2)
+#define USB_INTR_FRM_LST_ROLL_EN	(0x1<<3)
+#define USB_INTR_SYS_ERR_EN		(0x1<<4)
+#define USB_INTR_ASYN_ADV_EN		(0x1<<5)
+#define USB_INTR_RESET_EN		(0x1<<6)
+#define USB_INTR_SOF_EN			(0x1<<7)
+#define USB_INTR_DEVICE_SUSPEND		(0x1<<8)
+
+/* Device Address bit masks */
+#define USB_DEVICE_ADDRESS_MASK		(0x7F<<25)
+#define USB_DEVICE_ADDRESS_BIT_POS	(25)
+/* PORTSC  Register Bit Masks,Only one PORT in OTG mode*/
+#define PORTSC_CURRENT_CONNECT_STATUS	(0x1<<0)
+#define PORTSC_CONNECT_STATUS_CHANGE	(0x1<<1)
+#define PORTSC_PORT_ENABLE		(0x1<<2)
+#define PORTSC_PORT_EN_DIS_CHANGE	(0x1<<3)
+#define PORTSC_OVER_CURRENT_ACT		(0x1<<4)
+#define PORTSC_OVER_CUURENT_CHG		(0x1<<5)
+#define PORTSC_PORT_FORCE_RESUME	(0x1<<6)
+#define PORTSC_PORT_SUSPEND		(0x1<<7)
+#define PORTSC_PORT_RESET		(0x1<<8)
+#define PORTSC_LINE_STATUS_BITS		(0x3<<10)
+#define PORTSC_PORT_POWER		(0x1<<12)
+#define PORTSC_PORT_INDICTOR_CTRL	(0x3<<14)
+#define PORTSC_PORT_TEST_CTRL		(0xF<<16)
+#define PORTSC_WAKE_ON_CONNECT_EN	(0x1<<20)
+#define PORTSC_WAKE_ON_CONNECT_DIS	(0x1<<21)
+#define PORTSC_WAKE_ON_OVER_CURRENT	(0x1<<22)
+#define PORTSC_PHY_LOW_POWER_SPD	(0x1<<23)
+#define PORTSC_PORT_FORCE_FULL_SPEED	(0x1<<24)
+#define PORTSC_PORT_SPEED_MASK		(0x3<<26)
+#define PORTSC_TRANSCEIVER_WIDTH	(0x1<<28)
+#define PORTSC_PHY_TYPE_SEL		(0x3<<30)
+/* bit 11-10 are line status */
+#define PORTSC_LINE_STATUS_SE0		(0x0<<10)
+#define PORTSC_LINE_STATUS_JSTATE	(0x1<<10)
+#define PORTSC_LINE_STATUS_KSTATE	(0x2<<10)
+#define PORTSC_LINE_STATUS_UNDEF	(0x3<<10)
+#define PORTSC_LINE_STATUS_BIT_POS	(10)
+
+/* bit 15-14 are port indicator control */
+#define PORTSC_PIC_OFF			(0x0<<14)
+#define PORTSC_PIC_AMBER		(0x1<<14)
+#define PORTSC_PIC_GREEN		(0x2<<14)
+#define PORTSC_PIC_UNDEF		(0x3<<14)
+#define PORTSC_PIC_BIT_POS		(14)
+
+/* bit 19-16 are port test control */
+#define PORTSC_PTC_DISABLE		(0x0<<16)
+#define PORTSC_PTC_JSTATE		(0x1<<16)
+#define PORTSC_PTC_KSTATE		(0x2<<16)
+#define PORTSC_PTC_SEQNAK		(0x3<<16)
+#define PORTSC_PTC_PACKET		(0x4<<16)
+#define PORTSC_PTC_FORCE_EN		(0x5<<16)
+#define PORTSC_PTC_BIT_POS		(16)
+
+/* bit 27-26 are port speed */
+#define PORTSC_PORT_SPEED_FULL		(0x0<<26)
+#define PORTSC_PORT_SPEED_LOW		(0x1<<26)
+#define PORTSC_PORT_SPEED_HIGH		(0x2<<26)
+#define PORTSC_PORT_SPEED_UNDEF		(0x3<<26)
+#define PORTSC_SPEED_BIT_POS		(26)
+
+/* bit 28 is parallel transceiver width for UTMI interface */
+#define PORTSC_PTW			(0x1<<28)
+#define PORTSC_PTW_8BIT			(0x0<<28)
+#define PORTSC_PTW_16BIT		(0x1<<28)
+
+/* bit 31-30 are port transceiver select */
+#define PORTSC_PTS_UTMI			(0x0<<30)
+#define PORTSC_PTS_ULPI			(0x2<<30)
+#define PORTSC_PTS_FSLS_SERIAL		(0x3<<30)
+#define PORTSC_PTS_BIT_POS		(30)
+
+#define PORTSC_W1C_BITS                    \
+       (PORTSC_CONNECT_STATUS_CHANGE |     \
+	PORTSC_PORT_EN_DIS_CHANGE    |     \
+	PORTSC_OVER_CUURENT_CHG)
+
+/* OTG Status Control Register Bit Masks */
+#define OTGSC_CTRL_VBUS_DISCHARGE	(0x1<<0)
+#define OTGSC_CTRL_VBUS_CHARGE		(0x1<<1)
+#define OTGSC_CTRL_OTG_TERMINATION	(0x1<<3)
+#define OTGSC_CTRL_DATA_PULSING		(0x1<<4)
+#define OTGSC_CTRL_ID_PULL_EN		(0x1<<5)
+#define OTGSC_HA_DATA_PULSE		(0x1<<6)
+#define OTGSC_HA_BA			(0x1<<7)
+#define OTGSC_STS_USB_ID		(0x1<<8)
+#define OTGSC_STS_A_VBUS_VALID		(0x1<<9)
+#define OTGSC_STS_A_SESSION_VALID	(0x1<<10)
+#define OTGSC_STS_B_SESSION_VALID	(0x1<<11)
+#define OTGSC_STS_B_SESSION_END		(0x1<<12)
+#define OTGSC_STS_1MS_TOGGLE		(0x1<<13)
+#define OTGSC_STS_DATA_PULSING		(0x1<<14)
+#define OTGSC_INTSTS_USB_ID		(0x1<<16)
+#define OTGSC_INTSTS_A_VBUS_VALID	(0x1<<17)
+#define OTGSC_INTSTS_A_SESSION_VALID	(0x1<<18)
+#define OTGSC_INTSTS_B_SESSION_VALID	(0x1<<19)
+#define OTGSC_INTSTS_B_SESSION_END	(0x1<<20)
+#define OTGSC_INTSTS_1MS		(0x1<<21)
+#define OTGSC_INTSTS_DATA_PULSING	(0x1<<22)
+#define OTGSC_INTR_USB_ID_EN		(0x1<<24)
+#define OTGSC_INTR_A_VBUS_VALID_EN	(0x1<<25)
+#define OTGSC_INTR_A_SESSION_VALID_EN	(0x1<<26)
+#define OTGSC_INTR_B_SESSION_VALID_EN	(0x1<<27)
+#define OTGSC_INTR_B_SESSION_END_EN	(0x1<<28)
+#define OTGSC_INTR_1MS_TIMER_EN		(0x1<<29)
+#define OTGSC_INTR_DATA_PULSING_EN	(0x1<<30)
+#define OTGSC_INTSTS_MASK		(0x00ff0000)
+
+/* USB MODE Register Bit Masks */
+#define  USB_MODE_CTRL_MODE_IDLE	(0x0<<0)
+#define  USB_MODE_CTRL_MODE_DEVICE	(0x2<<0)
+#define  USB_MODE_CTRL_MODE_HOST	(0x3<<0)
+#define  USB_MODE_CTRL_MODE_RSV		(0x1<<0)
+#define  USB_MODE_SETUP_LOCK_OFF	(0x1<<3)
+#define  USB_MODE_STREAM_DISABLE	(0x1<<4)
+#define  USB_MODE_ES			(0x1<<2) /* Endian Select */
+
+#define MPC8349_OTG_IRQ			(38)
+#define CFG_IMMR_BASE			(0xfe000000)
+#define MPC83xx_USB_DR_BASE		(CFG_IMMR_BASE + 0x23000)
+
+/* control Register Bit Masks */
+#define  USB_CTRL_IOENB			(0x1<<2)
+#define  USB_CTRL_ULPI_INT0EN		(0x1<<0)
+
+/* BCSR5 */
+#define BCSR5_INT_USB			(0x02)
+
+/* USB module clk cfg */
+#define SCCR_OFFS			(0xA08)
+#define SCCR_USB_CLK_DISABLE		(0x00000000)	/* USB clk disable */
+#define SCCR_USB_MPHCM_11		(0x00c00000)
+#define SCCR_USB_MPHCM_01		(0x00400000)
+#define SCCR_USB_MPHCM_10		(0x00800000)
+#define SCCR_USB_DRCM_11		(0x00300000)
+#define SCCR_USB_DRCM_01		(0x00100000)
+#define SCCR_USB_DRCM_10		(0x00200000)
+
+#define SICRL_OFFS			(0x114)
+#define SICRL_USB0			(0x40000000)
+#define SICRL_USB1			(0x20000000)
+
+#define SICRH_OFFS			(0x118)
+#define SICRH_USB_UTMI			(0x00020000)
+
+/* OTG interrupt enable bit masks */
+#define  OTGSC_INTERRUPT_ENABLE_BITS_MASK  \
+	(OTGSC_INTR_USB_ID_EN            | \
+	OTGSC_INTR_1MS_TIMER_EN		 | \
+	OTGSC_INTR_A_VBUS_VALID_EN       | \
+	OTGSC_INTR_A_SESSION_VALID_EN    | \
+	OTGSC_INTR_B_SESSION_VALID_EN    | \
+	OTGSC_INTR_B_SESSION_END_EN      | \
+	OTGSC_INTR_DATA_PULSING_EN)
+
+/* OTG interrupt status bit masks */
+#define  OTGSC_INTERRUPT_STATUS_BITS_MASK  \
+	(OTGSC_INTSTS_USB_ID          |    \
+	OTGSC_INTR_1MS_TIMER_EN       |    \
+	OTGSC_INTSTS_A_VBUS_VALID     |    \
+	OTGSC_INTSTS_A_SESSION_VALID  |    \
+	OTGSC_INTSTS_B_SESSION_VALID  |    \
+	OTGSC_INTSTS_B_SESSION_END    |    \
+	OTGSC_INTSTS_DATA_PULSING)
+
+/*
+ *  A-DEVICE timing  constants
+ */
+
+/* Wait for VBUS Rise  */
+#define TA_WAIT_VRISE	(100)	/* a_wait_vrise 100 ms, section: 6.6.5.1 */
+
+/* Wait for B-Connect */
+#define TA_WAIT_BCON	(10000)  /* a_wait_bcon > 1 sec, section: 6.6.5.2
+				  * This is only used to get out of
+				  * OTG_STATE_A_WAIT_BCON state if there was
+				  * no connection for these many milliseconds
+				  */
+
+/* A-Idle to B-Disconnect */
+/* It is necessary for this timer to be more than 750 ms because of a bug in OPT
+ * test 5.4 in which B OPT disconnects after 750 ms instead of 75ms as stated
+ * in the test description
+ */
+#define TA_AIDL_BDIS	(5000)	/* a_suspend minimum 200 ms, section: 6.6.5.3 */
+
+/* B-Idle to A-Disconnect */
+#define TA_BIDL_ADIS	(12)	/* 3 to 200 ms */
+
+/* B-device timing constants */
+
+
+/* Data-Line Pulse Time*/
+#define TB_DATA_PLS	(10)	/* b_srp_init,continue 5~10ms, section:5.3.3 */
+#define TB_DATA_PLS_MIN	(5)	/* minimum 5 ms */
+#define TB_DATA_PLS_MAX	(10)	/* maximum 10 ms */
+
+/* SRP Initiate Time  */
+#define TB_SRP_INIT	(100)	/* b_srp_init,maximum 100 ms, section:5.3.8 */
+
+/* SRP Fail Time  */
+#define TB_SRP_FAIL	(7000)	/* b_srp_init,Fail time 5~30s, section:6.8.2.2*/
+
+/* SRP result wait time */
+#define TB_SRP_WAIT	(60)
+
+/* VBus time */
+#define TB_VBUS_PLS	(30)	/* time to keep vbus pulsing asserted */
+
+/* Discharge time */
+/* This time should be less than 10ms. It varies from system to system. */
+#define TB_VBUS_DSCHRG	(8)
+
+/* A-SE0 to B-Reset  */
+#define TB_ASE0_BRST	(20)	/* b_wait_acon, mini 3.125 ms,section:6.8.2.4 */
+
+/* A bus suspend timer before we can switch to b_wait_aconn */
+#define TB_A_SUSPEND	(7)
+#define TB_BUS_RESUME	(12)
+
+/* SE0 Time Before SRP */
+#define TB_SE0_SRP	(2)	/* b_idle,minimum 2 ms, section:5.3.2 */
+
+
+#define SET_OTG_STATE(otg_ptr, newstate)	((otg_ptr)->state = newstate)
+
+struct usb_dr_mmap {
+	/* Capability register */
+	u8 res1[256];
+	u16 caplength;		/* Capability Register Length */
+	u16 hciversion;		/* Host Controller Interface Version */
+	u32 hcsparams;		/* Host Controller Structual Parameters */
+	u32 hccparams;		/* Host Controller Capability Parameters */
+	u8 res2[20];
+	u32 dciversion;		/* Device Controller Interface Version */
+	u32 dccparams;		/* Device Controller Capability Parameters */
+	u8 res3[24];
+	/* Operation register */
+	u32 usbcmd;		/* USB Command Register */
+	u32 usbsts;		/* USB Status Register */
+	u32 usbintr;		/* USB Interrupt Enable Register */
+	u32 frindex;		/* Frame Index Register */
+	u8 res4[4];
+	u32 deviceaddr;		/* Device Address */
+	u32 endpointlistaddr;	/* Endpoint List Address Register */
+	u8 res5[4];
+	u32 burstsize;		/* Master Interface Data Burst Size Register */
+	u32 txttfilltuning;	/* Transmit FIFO Tuning Controls Register */
+	u8 res6[8];
+	u32 ulpiview;		/* ULPI register access */
+	u8 res7[12];
+	u32 configflag;		/* Configure Flag Register */
+	u32 portsc;		/* Port 1 Status and Control Register */
+	u8 res8[28];
+	u32 otgsc;		/* On-The-Go Status and Control */
+	u32 usbmode;		/* USB Mode Register */
+	u32 endptsetupstat;	/* Endpoint Setup Status Register */
+	u32 endpointprime;	/* Endpoint Initialization Register */
+	u32 endptflush;		/* Endpoint Flush Register */
+	u32 endptstatus;	/* Endpoint Status Register */
+	u32 endptcomplete;	/* Endpoint Complete Register */
+	u32 endptctrl[6];	/* Endpoint Control Registers */
+	u8 res9[552];
+	u32 snoop1;
+	u32 snoop2;
+	u32 age_cnt_thresh;	/* Age Count Threshold Register */
+	u32 pri_ctrl;		/* Priority Control Register */
+	u32 si_ctrl;		/* System Interface Control Register */
+	u8 res10[236];
+	u32 control;		/* General Purpose Control Register */
+};
+
+
+struct fsl_otg_timer {
+	unsigned long expires;	/* Number of count increase to timeout */
+	unsigned long count;	/* Tick counter */
+	void (*function)(unsigned long);	/* Timeout function */
+	unsigned long data;	/* Data passed to function */
+	struct list_head list;
+};
+
+inline struct fsl_otg_timer *otg_timer_initializer
+(void (*function)(unsigned long), unsigned long expires, unsigned long data)
+{
+	struct fsl_otg_timer *timer;
+	timer = kmalloc(sizeof(struct fsl_otg_timer), GFP_KERNEL);
+	if (timer == NULL)
+		return NULL;
+	timer->function = function;
+	timer->expires = expires;
+	timer->data = data;
+	return timer;
+}
+
+struct fsl_otg {
+	struct otg_transceiver otg;
+	struct otg_fsm fsm;
+	struct usb_dr_mmap *dr_mem_map;
+	struct delayed_work otg_event;
+
+	/* used for usb host */
+	struct work_struct work_wq;
+	u8	host_working;
+
+	int irq;
+};
+
+struct fsl_otg_config {
+	u8 otg_port;
+};
+
+/*For SRP and HNP handle*/
+#define FSL_OTG_MAJOR	66
+#define FSL_OTG_NAME	"fsl-usb2-otg"
+/*Command to OTG driver(ioctl)*/
+#define OTG_IOCTL_MAGIC		FSL_OTG_MAJOR
+/*if otg work as host,it should return 1,otherwise it return 0*/
+#define GET_OTG_STATUS		_IOR(OTG_IOCTL_MAGIC, 1, int)
+#define SET_A_SUSPEND_REQ	_IOW(OTG_IOCTL_MAGIC, 2, int)
+#define SET_A_BUS_DROP		_IOW(OTG_IOCTL_MAGIC, 3, int)
+#define SET_A_BUS_REQ		_IOW(OTG_IOCTL_MAGIC, 4, int)
+#define SET_B_BUS_REQ		_IOW(OTG_IOCTL_MAGIC, 5, int)
+#define GET_A_SUSPEND_REQ	_IOR(OTG_IOCTL_MAGIC, 6, int)
+#define GET_A_BUS_DROP		_IOR(OTG_IOCTL_MAGIC, 7, int)
+#define GET_A_BUS_REQ		_IOR(OTG_IOCTL_MAGIC, 8, int)
+#define GET_B_BUS_REQ		_IOR(OTG_IOCTL_MAGIC, 9, int)
+
+extern const char *state_string(enum usb_otg_state state);
+extern int otg_set_resources(struct resource *resources);
+
+void fsl_otg_add_timer(void *timer);
+void fsl_otg_del_timer(void *timer);
+void fsl_otg_pulse_vbus(void);
diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
index 0a43a7d..a694b67 100644
--- a/drivers/usb/otg/otg.c
+++ b/drivers/usb/otg/otg.c
@@ -64,3 +64,20 @@ int otg_set_transceiver(struct otg_transceiver *x)
 	return 0;
 }
 EXPORT_SYMBOL(otg_set_transceiver);
+
+#ifdef CONFIG_FSL_USB2_OTG
+static struct resource *otg_resources;
+
+struct resource *otg_get_resources(void)
+{
+	return otg_resources;
+}
+EXPORT_SYMBOL(otg_get_resources);
+
+int otg_set_resources(struct resource *resources)
+{
+	otg_resources = resources;
+	return 0;
+}
+EXPORT_SYMBOL(otg_set_resources);
+#endif
diff --git a/drivers/usb/otg/otg_fsm.c b/drivers/usb/otg/otg_fsm.c
new file mode 100644
index 0000000..1d8606f
--- /dev/null
+++ b/drivers/usb/otg/otg_fsm.c
@@ -0,0 +1,368 @@
+/* OTG Finite State Machine from OTG spec
+ *
+ * Copyright (C) 2007,2008 Freescale Semiconductor, Inc.
+ *
+ * Author:	Li Yang <LeoLi@freescale.com>
+ *		Jerry Huang <Chang-Ming.Huang@freescale.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/delay.h>
+#include <linux/usb.h>
+#include <linux/usb/gadget.h>
+#include <linux/usb/otg.h>
+#include <linux/types.h>
+
+#include "otg_fsm.h"
+
+const char *state_string(enum usb_otg_state state)
+{
+	switch (state) {
+	case OTG_STATE_A_IDLE:		return "a_idle";
+	case OTG_STATE_A_WAIT_VRISE:	return "a_wait_vrise";
+	case OTG_STATE_A_WAIT_BCON:	return "a_wait_bcon";
+	case OTG_STATE_A_HOST:		return "a_host";
+	case OTG_STATE_A_SUSPEND:	return "a_suspend";
+	case OTG_STATE_A_PERIPHERAL:	return "a_peripheral";
+	case OTG_STATE_A_WAIT_VFALL:	return "a_wait_vfall";
+	case OTG_STATE_A_VBUS_ERR:	return "a_vbus_err";
+	case OTG_STATE_B_IDLE:		return "b_idle";
+	case OTG_STATE_B_SRP_INIT:	return "b_srp_init";
+	case OTG_STATE_B_PERIPHERAL:	return "b_peripheral";
+	case OTG_STATE_B_WAIT_ACON:	return "b_wait_acon";
+	case OTG_STATE_B_HOST:		return "b_host";
+	default:			return "UNDEFINED";
+	}
+}
+
+/* Change USB protocol when there is a protocol change */
+static int otg_set_protocol(struct otg_fsm *fsm, int protocol)
+{
+	int ret = 0;
+
+	if (fsm->protocol != protocol) {
+		VDBG("Changing role fsm->protocol= %d; new protocol= %d\n",
+			fsm->protocol, protocol);
+		/* stop old protocol */
+		if (fsm->protocol == PROTO_HOST)
+			ret = fsm->ops->start_host(fsm, 0);
+		else if (fsm->protocol == PROTO_GADGET)
+			ret = fsm->ops->start_gadget(fsm, 0);
+		if (ret)
+			return ret;
+
+		/* start new protocol */
+		if (protocol == PROTO_HOST)
+			ret = fsm->ops->start_host(fsm, 1);
+		else if (protocol == PROTO_GADGET)
+			ret = fsm->ops->start_gadget(fsm, 1);
+		if (ret)
+			return ret;
+
+		fsm->protocol = protocol;
+		return 0;
+	}
+
+	return 0;
+}
+
+static int state_changed;
+
+/* Called when leaving a state.  Do state clean up jobs here */
+void otg_leave_state(struct otg_fsm *fsm, enum usb_otg_state old_state)
+{
+	switch (old_state) {
+	case OTG_STATE_B_IDLE:
+		otg_del_timer(fsm, b_se0_srp_tmr);
+		fsm->b_se0_srp = 0;
+		break;
+	case OTG_STATE_B_SRP_INIT:
+		fsm->b_srp_done = 0;
+		break;
+	case OTG_STATE_B_PERIPHERAL:
+		break;
+	case OTG_STATE_B_WAIT_ACON:
+		otg_del_timer(fsm, b_ase0_brst_tmr);
+		fsm->b_ase0_brst_tmout = 0;
+		break;
+	case OTG_STATE_B_HOST:
+		break;
+	case OTG_STATE_A_IDLE:
+		break;
+	case OTG_STATE_A_WAIT_VRISE:
+		otg_del_timer(fsm, a_wait_vrise_tmr);
+		fsm->a_wait_vrise_tmout = 0;
+		break;
+	case OTG_STATE_A_WAIT_BCON:
+		otg_del_timer(fsm, a_wait_bcon_tmr);
+		fsm->a_wait_bcon_tmout = 0;
+		break;
+	case OTG_STATE_A_HOST:
+		otg_del_timer(fsm, a_wait_enum_tmr);
+		break;
+	case OTG_STATE_A_SUSPEND:
+		otg_del_timer(fsm, a_aidl_bdis_tmr);
+		fsm->a_aidl_bdis_tmout = 0;
+		fsm->a_suspend_req = 0;
+		break;
+	case OTG_STATE_A_PERIPHERAL:
+		break;
+	case OTG_STATE_A_WAIT_VFALL:
+		otg_del_timer(fsm, a_wait_vrise_tmr);
+		break;
+	case OTG_STATE_A_VBUS_ERR:
+		break;
+	default:
+		break;
+	}
+}
+
+/* Called when entering a state */
+int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
+{
+	state_changed = 1;
+	if (fsm->transceiver->state == new_state)
+		return 0;
+	VDBG("Set state: %s\n", state_string(new_state));
+	otg_leave_state(fsm, fsm->transceiver->state);
+	switch (new_state) {
+	case OTG_STATE_B_IDLE:
+		otg_drv_vbus(fsm, 0);
+		otg_chrg_vbus(fsm, 0);
+		otg_loc_conn(fsm, 0);
+		otg_loc_sof(fsm, 0);
+		otg_set_protocol(fsm, PROTO_UNDEF);
+		otg_add_timer(fsm, b_se0_srp_tmr);
+		break;
+	case OTG_STATE_B_SRP_INIT:
+		otg_start_pulse(fsm);
+		otg_loc_sof(fsm, 0);
+		otg_set_protocol(fsm, PROTO_UNDEF);
+		otg_add_timer(fsm, b_srp_fail_tmr);
+		break;
+	case OTG_STATE_B_PERIPHERAL:
+		otg_chrg_vbus(fsm, 0);
+		otg_loc_conn(fsm, 1);
+		otg_loc_sof(fsm, 0);
+		otg_set_protocol(fsm, PROTO_GADGET);
+		break;
+	case OTG_STATE_B_WAIT_ACON:
+		otg_chrg_vbus(fsm, 0);
+		otg_loc_conn(fsm, 0);
+		otg_loc_sof(fsm, 0);
+		otg_set_protocol(fsm, PROTO_HOST);
+		otg_add_timer(fsm, b_ase0_brst_tmr);
+		fsm->a_bus_suspend = 0;
+		break;
+	case OTG_STATE_B_HOST:
+		otg_chrg_vbus(fsm, 0);
+		otg_loc_conn(fsm, 0);
+		otg_loc_sof(fsm, 1);
+		otg_set_protocol(fsm, PROTO_HOST);
+		usb_bus_start_enum(fsm->transceiver->host,
+				fsm->transceiver->host->otg_port);
+		break;
+	case OTG_STATE_A_IDLE:
+		otg_drv_vbus(fsm, 0);
+		otg_chrg_vbus(fsm, 0);
+		otg_loc_conn(fsm, 0);
+		otg_loc_sof(fsm, 0);
+		otg_set_protocol(fsm, PROTO_HOST);
+		break;
+	case OTG_STATE_A_WAIT_VRISE:
+		otg_drv_vbus(fsm, 1);
+		otg_loc_conn(fsm, 0);
+		otg_loc_sof(fsm, 0);
+		otg_set_protocol(fsm, PROTO_HOST);
+		otg_add_timer(fsm, a_wait_vrise_tmr);
+		break;
+	case OTG_STATE_A_WAIT_BCON:
+		otg_drv_vbus(fsm, 1);
+		otg_loc_conn(fsm, 0);
+		otg_loc_sof(fsm, 0);
+		otg_set_protocol(fsm, PROTO_HOST);
+		otg_add_timer(fsm, a_wait_bcon_tmr);
+		break;
+	case OTG_STATE_A_HOST:
+		otg_drv_vbus(fsm, 1);
+		otg_loc_conn(fsm, 0);
+		otg_loc_sof(fsm, 1);
+		otg_set_protocol(fsm, PROTO_HOST);
+		/*
+		 * When HNP is triggered while a_bus_req = 0, a_host will
+		 * suspend too fast to complete a_set_b_hnp_en
+		 */
+		if (!fsm->a_bus_req || fsm->a_suspend_req)
+			otg_add_timer(fsm, a_wait_enum_tmr);
+		break;
+	case OTG_STATE_A_SUSPEND:
+		otg_drv_vbus(fsm, 1);
+		otg_loc_conn(fsm, 0);
+		otg_loc_sof(fsm, 0);
+		otg_set_protocol(fsm, PROTO_HOST);
+		otg_add_timer(fsm, a_aidl_bdis_tmr);
+
+		break;
+	case OTG_STATE_A_PERIPHERAL:
+		otg_loc_conn(fsm, 1);
+		otg_loc_sof(fsm, 0);
+		otg_set_protocol(fsm, PROTO_GADGET);
+		otg_drv_vbus(fsm, 1);
+		break;
+	case OTG_STATE_A_WAIT_VFALL:
+		otg_drv_vbus(fsm, 0);
+		otg_loc_conn(fsm, 0);
+		otg_loc_sof(fsm, 0);
+		otg_set_protocol(fsm, PROTO_HOST);
+		break;
+	case OTG_STATE_A_VBUS_ERR:
+		otg_drv_vbus(fsm, 0);
+		otg_loc_conn(fsm, 0);
+		otg_loc_sof(fsm, 0);
+		otg_set_protocol(fsm, PROTO_UNDEF);
+		break;
+	default:
+		break;
+	}
+
+	fsm->transceiver->state = new_state;
+	return 0;
+}
+
+/* State change judgement */
+int otg_statemachine(struct otg_fsm *fsm)
+{
+	enum usb_otg_state state;
+	unsigned long flags;
+
+	spin_lock_irqsave(&fsm->lock, flags);
+
+	state = fsm->transceiver->state;
+	state_changed = 0;
+	/* State machine state change judgement */
+
+	switch (state) {
+	case OTG_STATE_UNDEFINED:
+		VDBG("fsm->id = %d\n", fsm->id);
+		if (fsm->id)
+			otg_set_state(fsm, OTG_STATE_B_IDLE);
+		else
+			otg_set_state(fsm, OTG_STATE_A_IDLE);
+		break;
+	case OTG_STATE_B_IDLE:
+		if (!fsm->id)
+			otg_set_state(fsm, OTG_STATE_A_IDLE);
+		else if (fsm->b_sess_vld && fsm->transceiver->gadget)
+			otg_set_state(fsm, OTG_STATE_B_PERIPHERAL);
+		else if (fsm->b_bus_req && fsm->b_sess_end && fsm->b_se0_srp)
+			otg_set_state(fsm, OTG_STATE_B_SRP_INIT);
+		break;
+	case OTG_STATE_B_SRP_INIT:
+		if (!fsm->id || fsm->b_srp_done)
+			otg_set_state(fsm, OTG_STATE_B_IDLE);
+		break;
+	case OTG_STATE_B_PERIPHERAL:
+		if (!fsm->id || !fsm->b_sess_vld)
+			otg_set_state(fsm, OTG_STATE_B_IDLE);
+		else if (fsm->b_bus_req && fsm->transceiver->
+				gadget->b_hnp_enable && fsm->a_bus_suspend)
+			otg_set_state(fsm, OTG_STATE_B_WAIT_ACON);
+		break;
+	case OTG_STATE_B_WAIT_ACON:
+		if (fsm->a_conn)
+			otg_set_state(fsm, OTG_STATE_B_HOST);
+		else if (!fsm->id || !fsm->b_sess_vld)
+			otg_set_state(fsm, OTG_STATE_B_IDLE);
+		else if (fsm->a_bus_resume || fsm->b_ase0_brst_tmout) {
+			fsm->b_ase0_brst_tmout = 0;
+			otg_set_state(fsm, OTG_STATE_B_PERIPHERAL);
+		}
+		break;
+	case OTG_STATE_B_HOST:
+		if (!fsm->id || !fsm->b_sess_vld)
+			otg_set_state(fsm, OTG_STATE_B_IDLE);
+		else if (!fsm->b_bus_req || !fsm->a_conn)
+			otg_set_state(fsm, OTG_STATE_B_PERIPHERAL);
+		break;
+	case OTG_STATE_A_IDLE:
+		if (fsm->id)
+			otg_set_state(fsm, OTG_STATE_B_IDLE);
+		else if (!fsm->a_bus_drop && (fsm->a_bus_req || fsm->a_srp_det))
+			otg_set_state(fsm, OTG_STATE_A_WAIT_VRISE);
+		break;
+	case OTG_STATE_A_WAIT_VRISE:
+		if (fsm->id || fsm->a_bus_drop || fsm->a_vbus_vld ||
+				fsm->a_wait_vrise_tmout) {
+			otg_set_state(fsm, OTG_STATE_A_WAIT_BCON);
+		}
+		break;
+	case OTG_STATE_A_WAIT_BCON:
+		if (!fsm->a_vbus_vld)
+			otg_set_state(fsm, OTG_STATE_A_VBUS_ERR);
+		else if (fsm->b_conn)
+			otg_set_state(fsm, OTG_STATE_A_HOST);
+		else if (fsm->id | fsm->a_bus_drop | fsm->a_wait_bcon_tmout)
+			otg_set_state(fsm, OTG_STATE_A_WAIT_VFALL);
+		break;
+	case OTG_STATE_A_HOST:
+		if ((!fsm->a_bus_req || fsm->a_suspend_req) &&
+				fsm->transceiver->host->b_hnp_enable)
+			otg_set_state(fsm, OTG_STATE_A_SUSPEND);
+		else if (fsm->id || !fsm->b_conn || fsm->a_bus_drop)
+			otg_set_state(fsm, OTG_STATE_A_WAIT_BCON);
+		else if (!fsm->a_vbus_vld)
+			otg_set_state(fsm, OTG_STATE_A_VBUS_ERR);
+		break;
+	case OTG_STATE_A_SUSPEND:
+		if (!fsm->b_conn && fsm->transceiver->host->b_hnp_enable)
+			otg_set_state(fsm, OTG_STATE_A_PERIPHERAL);
+		else if (!fsm->b_conn && !fsm->transceiver->host->b_hnp_enable)
+			otg_set_state(fsm, OTG_STATE_A_WAIT_BCON);
+		else if (fsm->a_bus_req || fsm->b_bus_resume)
+			otg_set_state(fsm, OTG_STATE_A_HOST);
+		else if (fsm->id || fsm->a_bus_drop || fsm->a_aidl_bdis_tmout)
+			otg_set_state(fsm, OTG_STATE_A_WAIT_VFALL);
+		else if (!fsm->a_vbus_vld)
+			otg_set_state(fsm, OTG_STATE_A_VBUS_ERR);
+		break;
+	case OTG_STATE_A_PERIPHERAL:
+		if (fsm->id || fsm->a_bus_drop)
+			otg_set_state(fsm, OTG_STATE_A_WAIT_VFALL);
+		else if (fsm->b_bus_suspend)
+			otg_set_state(fsm, OTG_STATE_A_WAIT_BCON);
+		else if (!fsm->a_vbus_vld)
+			otg_set_state(fsm, OTG_STATE_A_VBUS_ERR);
+		break;
+	case OTG_STATE_A_WAIT_VFALL:
+		if (fsm->id || fsm->a_bus_req || (!fsm->a_sess_vld &&
+					!fsm->b_conn))
+			otg_set_state(fsm, OTG_STATE_A_IDLE);
+		break;
+	case OTG_STATE_A_VBUS_ERR:
+		if (fsm->id || fsm->a_bus_drop || fsm->a_clr_err)
+			otg_set_state(fsm, OTG_STATE_A_WAIT_VFALL);
+		break;
+	default:
+		break;
+	}
+	spin_unlock_irqrestore(&fsm->lock, flags);
+
+	VDBG("quit statemachine, changed = %d\n", state_changed);
+	return state_changed;
+}
diff --git a/drivers/usb/otg/otg_fsm.h b/drivers/usb/otg/otg_fsm.h
new file mode 100644
index 0000000..0cecf1d
--- /dev/null
+++ b/drivers/usb/otg/otg_fsm.h
@@ -0,0 +1,154 @@
+/* Copyright (C) 2007,2008 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#undef DEBUG
+#undef VERBOSE
+
+#ifdef DEBUG
+#define DBG(fmt, args...) printk(KERN_DEBUG "[%s]  " fmt , \
+				 __func__, ## args)
+#else
+#define DBG(fmt, args...)	do {} while (0)
+#endif
+
+#ifdef VERBOSE
+#define VDBG		DBG
+#else
+#define VDBG(stuff...)	do {} while (0)
+#endif
+
+#ifdef VERBOSE
+#define MPC_LOC printk("Current Location [%s]:[%d]\n", __FILE__, __LINE__)
+#else
+#define MPC_LOC do {} while (0)
+#endif
+
+#define PROTO_UNDEF	(0)
+#define PROTO_HOST	(1)
+#define PROTO_GADGET	(2)
+
+/* OTG state machine according to the OTG spec */
+struct otg_fsm {
+	/* Input */
+	int a_bus_resume;
+	int a_bus_suspend;
+	int a_conn;
+	int a_sess_vld;
+	int a_srp_det;
+	int a_vbus_vld;
+	int b_bus_resume;
+	int b_bus_suspend;
+	int b_conn;
+	int b_se0_srp;
+	int b_sess_end;
+	int b_sess_vld;
+	int id;
+
+	/* Internal variables */
+	int a_set_b_hnp_en;
+	int b_srp_done;
+	int b_hnp_enable;
+
+	/* Timeout indicator for timers */
+	int a_wait_vrise_tmout;
+	int a_wait_bcon_tmout;
+	int a_aidl_bdis_tmout;
+	int b_ase0_brst_tmout;
+
+	/* Informative variables */
+	int a_bus_drop;
+	int a_bus_req;
+	int a_clr_err;
+	int a_suspend_req;
+	int b_bus_req;
+
+	/* Output */
+	int drv_vbus;
+	int loc_conn;
+	int loc_sof;
+
+	struct otg_fsm_ops *ops;
+	struct otg_transceiver *transceiver;
+
+	/* Current usb protocol used: 0:undefine; 1:host; 2:client */
+	int protocol;
+	spinlock_t lock;
+};
+
+struct otg_fsm_ops {
+	void	(*chrg_vbus)(int on);
+	void	(*drv_vbus)(int on);
+	void	(*loc_conn)(int on);
+	void	(*loc_sof)(int on);
+	void	(*start_pulse)(void);
+	void	(*add_timer)(void *timer);
+	void	(*del_timer)(void *timer);
+	int	(*start_host)(struct otg_fsm *fsm, int on);
+	int	(*start_gadget)(struct otg_fsm *fsm, int on);
+};
+
+
+static inline void otg_chrg_vbus(struct otg_fsm *fsm, int on)
+{
+	fsm->ops->chrg_vbus(on);
+}
+
+static inline void otg_drv_vbus(struct otg_fsm *fsm, int on)
+{
+	if (fsm->drv_vbus != on) {
+		fsm->drv_vbus = on;
+		fsm->ops->drv_vbus(on);
+	}
+}
+
+static inline void otg_loc_conn(struct otg_fsm *fsm, int on)
+{
+	if (fsm->loc_conn != on) {
+		fsm->loc_conn = on;
+		fsm->ops->loc_conn(on);
+	}
+}
+
+static inline void otg_loc_sof(struct otg_fsm *fsm, int on)
+{
+	if (fsm->loc_sof != on) {
+		fsm->loc_sof = on;
+		fsm->ops->loc_sof(on);
+	}
+}
+
+static inline void otg_start_pulse(struct otg_fsm *fsm)
+{
+	fsm->ops->start_pulse();
+}
+
+static inline void otg_add_timer(struct otg_fsm *fsm, void *timer)
+{
+	fsm->ops->add_timer(timer);
+}
+
+static inline void otg_del_timer(struct otg_fsm *fsm, void *timer)
+{
+	fsm->ops->del_timer(timer);
+}
+
+int otg_statemachine(struct otg_fsm *fsm);
+
+/* Defined by device specific driver, for different timer implementation */
+extern struct fsl_otg_timer *a_wait_vrise_tmr, *a_wait_bcon_tmr,
+	*a_aidl_bdis_tmr, *b_ase0_brst_tmr, *b_se0_srp_tmr, *b_srp_fail_tmr,
+	*a_wait_enum_tmr;
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 7e64112..db06a6c 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -69,6 +69,7 @@ struct fsl_usb2_platform_data {
 	int (*platform_init) (struct platform_device *);
 	void (*platform_uninit) (struct platform_device *);
 	void __iomem			*regs;	/* ioremap'd register base */
+	unsigned			power_budget; /* hcd->power_budget */
 	unsigned			big_endian_mmio:1;
 	unsigned			big_endian_desc:1;
 	unsigned			es:1;		/* need USBMODE:ES */
@@ -76,6 +77,20 @@ struct fsl_usb2_platform_data {
 	unsigned			invert_drvvbus:1;
 	unsigned			invert_pwr_fault:1;
 	unsigned			le_setup_buf:1;
+	unsigned			suspended:1;
+	unsigned			already_suspended:1;
+
+	/* register save area for suspend/resume */
+	u32				pm_command;
+	u32				pm_status;
+	u32				pm_intr_enable;
+	u32				pm_frame_index;
+	u32				pm_segment;
+	u32				pm_frame_list;
+	u32				pm_async_next;
+	u32				pm_configured_flag;
+	u32				pm_portsc;
+	u32				pm_usbgenctrl;
 };
 
 /* Flags in fsl_usb2_mph_platform_data */
-- 
1.6.3.3
