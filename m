Return-Path: <sebastian@breakpoint.cc>
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc
	[85.10.199.196])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E3D65DE15C
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 01:36:05 +1000 (EST)
Date: Thu, 22 May 2008 17:35:55 +0200
From: Sebastian Siewior <sebastian@breakpoint.cc>
To: Nate Case <ncase@xes-inc.com>
Subject: Re: [PATCH 2/2] USB: isp1760: Support board-specific hardware
	configurations
Message-ID: <20080522153555.GB26410@Chamillionaire.breakpoint.cc>
References: <1211405331.13845.628.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <1211405331.13845.628.camel@localhost.localdomain>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Greg Kroah-Hartman <gregkh@suse.de>, linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Nate Case | 2008-05-21 16:28:51 [-0500]:

>This adds support for hardware configurations that don't match the
>chip default register settings (e.g., 16-bit data bus, DACK and
>DREQ pulled down instead of up, analog overcurrent mode).
Nice patch. A few comments inline.

>These settings are passed in via the OF device tree.  The PCI
>interface still assumes the same default values.
The default values should be okay for PCI . It should only be required
for the eval kit from NXP. There was an ISP1761 behind a PLB bridge. I
had all three ports functional there (no OTG) in my first shot after
enabling or disabling some resistors (don't remember the details
anymore). Than I moved to my powerpc and returned the eval kit.

>Signed-off-by: Nate Case <ncase@xes-inc.com>
>---
> drivers/usb/host/isp1760-hcd.c |   68 +++++++++++++++++++++++++++++++--------
> drivers/usb/host/isp1760-hcd.h |   19 ++++++++++-
> drivers/usb/host/isp1760-if.c  |   34 +++++++++++++++++++-
> 3 files changed, 103 insertions(+), 18 deletions(-)
>
>diff --git a/drivers/usb/host/isp1760-hcd.c b/drivers/usb/host/isp1760-hcd.c
>index 65aa5ec..679b8df 100644
>--- a/drivers/usb/host/isp1760-hcd.c
>+++ b/drivers/usb/host/isp1760-hcd.c
>@@ -38,6 +38,7 @@ struct isp1760_hcd {
> 	unsigned		i_thresh;
> 	unsigned long		reset_done;
> 	unsigned long		next_statechange;
>+	unsigned int		devflags;
> };
> 
> static inline struct isp1760_hcd *hcd_to_priv(struct usb_hcd *hcd)
>@@ -378,9 +379,31 @@ static int isp1760_hc_setup(struct usb_hcd *hcd)
> {
> 	struct isp1760_hcd *priv = hcd_to_priv(hcd);
> 	int result;
>-	u32 scratch;
>+	u32 scratch, hwmode;
>+
>+	/* Setup HW Mode Control: This assumes a level active-low interrupt */
>+	hwmode = HW_DATA_BUS_32BIT;
>+
>+	if (priv->devflags & ISP1760_FLAG_BUS_WIDTH_16)
>+		hwmode &= ~HW_DATA_BUS_32BIT;

If you don't mind, I would prefer having ISP1760_FLAG_BUS_WIDTH_32 and
or conditionally HW_DATA_BUS_32BIT.

>+	if (priv->devflags & ISP1760_FLAG_ANALOG_OC)
>+		hwmode |= HW_ANA_DIGI_OC;
>+	if (priv->devflags & ISP1760_FLAG_DACK_POL_HIGH)
>+		hwmode |= HW_DACK_POL_HIGH;
>+	if (priv->devflags & ISP1760_FLAG_DREQ_POL_HIGH)
>+		hwmode |= HW_DREQ_POL_HIGH;
>+
>+	/*
>+	 * We have to set this first in case we're in 16-bit mode.
>+	 * Write it twice to ensure correct upper bits if switching
>+	 * to 16-bit mode.
>+	 */
>+	isp1760_writel(hwmode, hcd->regs + HC_HW_MODE_CTRL);
>+	isp1760_writel(hwmode, hcd->regs + HC_HW_MODE_CTRL);
> 
> 	isp1760_writel(0xdeadbabe, hcd->regs + HC_SCRATCH_REG);
>+	/* Change bus pattern */
>+	scratch = isp1760_readl(hcd->regs + HC_CHIP_ID_REG);
> 	scratch = isp1760_readl(hcd->regs + HC_SCRATCH_REG);
Why do you have to read the chip id here? Is this a dummy read to ensure
something?

> 	if (scratch != 0xdeadbabe) {
> 		printk(KERN_ERR "ISP1760: Scratch test failed.\n");
>@@ -403,17 +426,30 @@ static int isp1760_hc_setup(struct usb_hcd *hcd)
> 
> 	/* Step 11 passed */
> 
>-	isp1760_writel(INTERRUPT_ENABLE_MASK, hcd->regs + HC_INTERRUPT_REG);
>-	isp1760_writel(INTERRUPT_ENABLE_MASK, hcd->regs + HC_INTERRUPT_ENABLE);
>+	isp1760_info(priv, "bus width: %d, oc: %s\n",
>+			   (priv->devflags & ISP1760_FLAG_BUS_WIDTH_16) ?
>+			   16 : 32, (priv->devflags & ISP1760_FLAG_ANALOG_OC) ?
>+			   "analog" : "digital");
> 
> 	/* ATL reset */
>-	scratch = isp1760_readl(hcd->regs + HC_HW_MODE_CTRL);
>-	isp1760_writel(scratch | ALL_ATX_RESET, hcd->regs + HC_HW_MODE_CTRL);
>+	isp1760_writel(hwmode | ALL_ATX_RESET, hcd->regs + HC_HW_MODE_CTRL);
> 	mdelay(10);
>-	isp1760_writel(scratch, hcd->regs + HC_HW_MODE_CTRL);
>+	isp1760_writel(hwmode, hcd->regs + HC_HW_MODE_CTRL);
> 
>-	isp1760_writel(PORT1_POWER | PORT1_INIT2, hcd->regs + HC_PORT1_CTRL);
>-	mdelay(10);
>+	isp1760_writel(INTERRUPT_ENABLE_MASK, hcd->regs + HC_INTERRUPT_REG);
>+	isp1760_writel(INTERRUPT_ENABLE_MASK, hcd->regs + HC_INTERRUPT_ENABLE);
>+
>+	/*
>+	 * PORT 1 Control register of the ISP1760 is the OTG control
>+	 * register on ISP1761.
>+	 */
>+	scratch = isp1760_readl(hcd->regs + HC_CHIP_ID_REG);
>+	if (((scratch & 0xffff) == 0x1760) &&
>+	    !(priv->devflags & ISP1760_FLAG_PORT1_DIS)) {
>+		isp1760_writel(PORT1_POWER | PORT1_INIT2,
>+			       hcd->regs + HC_PORT1_CTRL);
>+		mdelay(10);
>+	}
I'm sorry, you can't solve this way. My ISP1760 claims to be an ISP1761
this way :) So I end up with one functional port... The only way to
distinguish between 1760 & 1761 would be at the probing level.

Sebastian
