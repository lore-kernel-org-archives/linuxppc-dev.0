Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:70:0:1:25:1])
 by ozlabs.org (Postfix) with ESMTP id 0077AB6EF3
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Jan 2012 22:08:15 +1100 (EST)
Date: Wed, 18 Jan 2012 12:08:11 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Matthias Fuchs <matthias.fuchs@esd.eu>
Subject: Re: Problem with full speed devices on PowerPC MPC5121 host port
Message-ID: <20120118120811.04f7c601@wker>
In-Reply-To: <4F1581E2.9030400@esd.eu>
References: <Pine.LNX.4.44L0.1201061258040.1326-100000@iolanthe.rowland.org>
 <4F1581E2.9030400@esd.eu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/u2RwWdipJkF4qbgyp6tIdJ="
Cc: linuxppc-dev@ozlabs.org, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--MP_/u2RwWdipJkF4qbgyp6tIdJ=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Matthias,

On Tue, 17 Jan 2012 15:12:50 +0100
Matthias Fuchs <matthias.fuchs@esd.eu> wrote:

> On 06.01.2012 19:03, Alan Stern wrote:
> > On Fri, 6 Jan 2012, Matthias Fuchs wrote:
> > 
> >> For my eyes it does not really look like a general USB issue.
> >> It looks like a problem with the Freescale EHCI implementation that is
> >> influenced by high interrupt or internal bus load caused by the flood ping.
> > 
> > Indeed, it might be a problem with the built-in Transaction Translator.  
> > That would explain why it affect full-speed devices.
> > 
> > However, I would expect the resetting the controller hardware (which 
> > happens when you reload the ehci-fsl driver) would fix any such issues.  
> > It's hard to imagine how a problem could survive a reset like that.
> 
> I did the tests again. When the error occured I reloaded the ehci-hcd driver and reconnected the device. It ends up with some kernel messages 
> that come up time after time:
> 
> usb 1-1: new full-speed USB device number 2 using fsl-ehci
> usb 1-1: device descriptor read/64, error -110
> usb 1-1: device descriptor read/64, error -110
> usb 1-1: new full-speed USB device number 3 using fsl-ehci
> usb 1-1: device descriptor read/64, error -110
> usb 1-1: device descriptor read/64, error -110
> usb 1-1: new full-speed USB device number 4 using fsl-ehci
> usb 1-1: device not accepting address 4, error -110
> usb 1-1: new full-speed USB device number 5 using fsl-ehci
> usb 1-1: device not accepting address 5, error -110
> hub 1-0:1.0: unable to enumerate USB device on port 1
> 
> A recommondation from freescale was to check the TXFILLTUNING register settings ("Initialization of this registers can produce problem if full-speed device is used").
> 
> So I tried various values in the TXFILLTUNING register (I added this
> code to ehci_reset()). Finally I disabled USB streaming mode in the USBMODE register (set bit USBMODE_SDIS - btw., it should be defined as "1 << 4" in ehci_def.h at least for the MPC5121).
> 
> All this does not fix the problem or even have an impact.

Can you try the attached patch? Does it have an impact?

Best regards,
Anatolij

--MP_/u2RwWdipJkF4qbgyp6tIdJ=
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-usb-ehci-fsl-set-INCR8-mode-for-system-bus-interface.patch

>From 4cf7463af262230fcc0db95b2f47b0dcbf76daa9 Mon Sep 17 00:00:00 2001
From: Anatolij Gustschin <agust@denx.de>
Date: Wed, 18 Jan 2012 01:01:06 +0100
Subject: [PATCH] usb: ehci-fsl: set INCR8 mode for system bus interface

Port commit 69b4acc1dc4aa98a8f1016684fc99aba10156f87
(USB: Set INCR8 mode for system bus interface.) from Freescale
ltib 2.6.24 kernel for mpc512x:

This is a work-around for the USB-bus-hang problem observed
on MPC512x when there is heavy simultaneous PATA write activity.

See also "12.4 The USB controller can issue transactions that lock
up the AHB bus under certain conditions" in MPC5121e (M36P) Errata

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/usb/host/ehci-fsl.c |   10 ++++++++++
 drivers/usb/host/ehci-fsl.h |    2 ++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index e90344a..a6a6722 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -346,6 +346,14 @@ static int ehci_fsl_setup(struct usb_hcd *hcd)
 
 	ehci_reset(ehci);
 
+#ifdef CONFIG_PPC_MPC512x
+	/*
+	 * set SBUSCFG:AHBBRST so that control msgs don't
+	 * fail when doing heavy PATA writes.
+	 */
+	ehci_writel(ehci, SBUSCFG_INCR8, hcd->regs + FSL_SOC_USB_SBUSCFG);
+#endif
+
 	retval = ehci_fsl_reinit(ehci);
 	return retval;
 }
@@ -469,6 +477,8 @@ static int ehci_fsl_mpc512x_drv_resume(struct device *dev)
 	ehci_writel(ehci, ISIPHYCTRL_PXE | ISIPHYCTRL_PHYE,
 		    hcd->regs + FSL_SOC_USB_ISIPHYCTRL);
 
+	ehci_writel(ehci, SBUSCFG_INCR8, hcd->regs + FSL_SOC_USB_SBUSCFG);
+
 	/* restore EHCI registers */
 	ehci_writel(ehci, pdata->pm_command, &ehci->regs->command);
 	ehci_writel(ehci, pdata->pm_intr_enable, &ehci->regs->intr_enable);
diff --git a/drivers/usb/host/ehci-fsl.h b/drivers/usb/host/ehci-fsl.h
index 4918062..0855be8 100644
--- a/drivers/usb/host/ehci-fsl.h
+++ b/drivers/usb/host/ehci-fsl.h
@@ -19,6 +19,8 @@
 #define _EHCI_FSL_H
 
 /* offsets for the non-ehci registers in the FSL SOC USB controller */
+#define FSL_SOC_USB_SBUSCFG	0x90
+#define SBUSCFG_INCR8		0x02	/* INCR8, specified */
 #define FSL_SOC_USB_ULPIVP	0x170
 #define FSL_SOC_USB_PORTSC1	0x184
 #define PORT_PTS_MSK		(3<<30)
-- 
1.7.1


--MP_/u2RwWdipJkF4qbgyp6tIdJ=--
