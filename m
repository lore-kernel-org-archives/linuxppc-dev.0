Return-Path: <chf.fritz@googlemail.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 92FE92C03DE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 21:25:39 +1100 (EST)
Received: by mail-bk0-f51.google.com with SMTP id e19so111780bku.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2012 03:25:39 -0700 (PDT)
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 6/7] usb: gadget: fsl_udc: purge global pointer usb_sys_regs
Date: Fri, 19 Oct 2012 12:24:44 +0200
Message-Id: <1350642285-8145-6-git-send-email-chf.fritz@googlemail.com>
In-Reply-To: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
References: <1350642156-8034-1-git-send-email-chf.fritz@googlemail.com>
Cc: Estevam Fabio-R49496 <r49496@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Chen Peter-B29397 <B29397@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-usb@vger.kernel.org,
 "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <daniel@caiaq.de>,
 Christian Hemp <c.hemp@phytec.de>, linuxppc-dev@lists.ozlabs.org,
 Teresa Gamez <T.Gamez@phytec.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move global driver pointer usb_sys_regs to private struct fsl_udc.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
Reviewed-by: Teresa Gamez <T.Gamez@phytec.de>
---
 drivers/usb/gadget/fsl_udc_core.c |   26 ++++++++++++--------------
 drivers/usb/gadget/fsl_usb2_udc.h |    1 +
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
index deaab62..35ebcd4 100644
--- a/drivers/usb/gadget/fsl_udc_core.c
+++ b/drivers/usb/gadget/fsl_udc_core.c
@@ -43,8 +43,6 @@ static const char driver_desc[] = DRIVER_DESC;
 
 static struct usb_dr_device *dr_regs;
 
-static struct usb_sys_interface *usb_sys_regs;
-
 static const struct usb_endpoint_descriptor
 fsl_ep0_desc = {
 	.bLength =		USB_DT_ENDPOINT_SIZE,
@@ -170,10 +168,10 @@ static int dr_controller_setup(struct fsl_udc *udc)
 		if (udc->pdata->have_sysif_regs) {
 			if (udc->pdata->controller_ver) {
 				/* controller version 1.6 or above */
-				ctrl = __raw_readl(&usb_sys_regs->control);
+				ctrl = readl(&udc->usb_sys_regs->control);
 				ctrl &= ~USB_CTRL_UTMI_PHY_EN;
 				ctrl |= USB_CTRL_USB_EN;
-				__raw_writel(ctrl, &usb_sys_regs->control);
+				writel(ctrl, &udc->usb_sys_regs->control);
 			}
 		}
 		portctrl |= PORTSCX_PTS_ULPI;
@@ -185,10 +183,10 @@ static int dr_controller_setup(struct fsl_udc *udc)
 		if (udc->pdata->have_sysif_regs) {
 			if (udc->pdata->controller_ver) {
 				/* controller version 1.6 or above */
-				ctrl = __raw_readl(&usb_sys_regs->control);
+				ctrl = readl(&udc->usb_sys_regs->control);
 				ctrl |= (USB_CTRL_UTMI_PHY_EN |
 					USB_CTRL_USB_EN);
-				__raw_writel(ctrl, &usb_sys_regs->control);
+				writel(ctrl, &udc->usb_sys_regs->control);
 				mdelay(FSL_UTMI_PHY_DLY); /* Delay for UTMI
 					PHY CLK to become stable - 10ms*/
 			}
@@ -254,9 +252,9 @@ static int dr_controller_setup(struct fsl_udc *udc)
 	/* Config control enable i/o output, cpu endian register */
 #ifndef CONFIG_ARCH_MXC
 	if (udc->pdata->have_sysif_regs) {
-		ctrl = __raw_readl(&usb_sys_regs->control);
+		ctrl = readl(&udc->usb_sys_regs->control);
 		ctrl |= USB_CTRL_IOENB;
-		__raw_writel(ctrl, &usb_sys_regs->control);
+		writel(ctrl, &udc->usb_sys_regs->control);
 	}
 #endif
 
@@ -267,9 +265,9 @@ static int dr_controller_setup(struct fsl_udc *udc)
 	if (udc->pdata->have_sysif_regs) {
 		/* Setup Snooping for all the 4GB space */
 		tmp = SNOOP_SIZE_2GB;	/* starts from 0x0, size 2G */
-		__raw_writel(tmp, &usb_sys_regs->snoop1);
+		writel(tmp, &udc->usb_sys_regs->snoop1);
 		tmp |= 0x80000000;	/* starts from 0x8000000, size 2G */
-		__raw_writel(tmp, &usb_sys_regs->snoop2);
+		writel(tmp, &udc->usb_sys_regs->snoop2);
 	}
 #endif
 
@@ -326,7 +324,7 @@ static void dr_controller_stop(struct fsl_udc *udc)
 	udc->stopped = 1;
 
 	/* disable IO output */
-/*	usb_sys_regs->control = 0; */
+/*	udc->usb_sys_regs->control = 0; */
 
 	/* set controller to Stop */
 	tmp = readl(&dr_regs->usbcmd);
@@ -2130,12 +2128,12 @@ static int fsl_proc_read(char *page, char **start, off_t off, int count,
 
 #ifndef CONFIG_ARCH_MXC
 	if (udc->pdata->have_sysif_regs) {
-		tmp_reg = usb_sys_regs->snoop1;
+		tmp_reg = udc->usb_sys_regs->snoop1;
 		t = scnprintf(next, size, "Snoop1 Reg : = [0x%x]\n\n", tmp_reg);
 		size -= t;
 		next += t;
 
-		tmp_reg = usb_sys_regs->control;
+		tmp_reg = udc->usb_sys_regs->control;
 		t = scnprintf(next, size, "General Control Reg : = [0x%x]\n\n",
 				tmp_reg);
 		size -= t;
@@ -2388,7 +2386,7 @@ static int __init fsl_udc_probe(struct platform_device *pdev)
 
 #ifndef CONFIG_ARCH_MXC
 	if (pdata->have_sysif_regs)
-		usb_sys_regs = (void *)dr_regs + USB_DR_SYS_OFFSET;
+		udc->usb_sys_regs = (void *)dr_regs + USB_DR_SYS_OFFSET;
 #endif
 
 	/* Initialize USB clocks */
diff --git a/drivers/usb/gadget/fsl_usb2_udc.h b/drivers/usb/gadget/fsl_usb2_udc.h
index a0123ae..0d888f4 100644
--- a/drivers/usb/gadget/fsl_usb2_udc.h
+++ b/drivers/usb/gadget/fsl_usb2_udc.h
@@ -498,6 +498,7 @@ struct fsl_udc {
 	dma_addr_t ep_qh_dma;		/* dma address of QH */
 
 	struct ep_td_struct *last_free_td;
+	struct usb_sys_interface *usb_sys_regs;
 
 	u32 max_pipes;          /* Device max pipes */
 	u32 bus_reset;		/* Device is bus resetting */
-- 
1.7.2.5
