Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r6RvP66LQzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 May 2016 23:11:44 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id r12so8847764wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 14 May 2016 06:11:44 -0700 (PDT)
From: Christian Lamparter <chunkeey@googlemail.com>
To: John Youn <John.Youn@synopsys.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "a.seppala@gmail.com" <a.seppala@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
Date: Sat, 14 May 2016 15:11:34 +0200
Message-ID: <2920638.peXreEnG6d@debian64>
In-Reply-To: <5734CE1C.8070208@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <2856271.3aAGK3LarU@debian64>
 <5734CE1C.8070208@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday, May 12, 2016 11:40:28 AM John Youn wrote:
> On 5/12/2016 6:30 AM, Christian Lamparter wrote:
> > On Thursday, May 12, 2016 01:55:44 PM Arnd Bergmann wrote:
> >> On Thursday 12 May 2016 11:58:18 Christian Lamparter wrote:
> >>>>>> Detecting the endianess of the
> >>>>>> device is probably the best future-proof solution, but it's also
> >>>>>> considerably more work to do in the driver, and comes with a
> >>>>>> tiny runtime overhead.
> >>>>>
> >>>>> The runtime overhead is probably non-measurable compared with the cost
> >>>>> of the actual MMIOs.
> >>>>
> >>>> Right. The code size increase is probably measurable (but still small),
> >>>> the runtime overhead is not.
> >>>
> >>> Ok, so no rebuts or complains have been posted.
> >>>
> >>> I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
> >>> and it works: 
> >>>
> >>> Tested-by: Christian Lamparter <chunkeey@googlemail.com>
> >>>
> >>> So, how do we go from here? There is are two small issues with the
> >>> original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
> >>> #ifdef dwc2_log_writes) and I guess a proper subject would be nice.  
> >>>
> >>> Arnd, can you please respin and post it (cc'd stable as well)?
> >>> So this is can be picked up? Or what's your plan?
> >>
> >> (I just realized my reply was stuck in my outbox, so the patch
> >> went out first)
> >>
> >> If I recall correctly, the rough consensus was to go with your longer
> >> patch in the future (fixed up for the comments that BenH and
> >> I sent), and I'd suggest basing it on top of a fixed version of
> >> my patch.
> > Well, but it comes with the "overhead"! So this was just as I said:
> > "Let's look at it and see if it's any good"... And I think it isn't
> > since the usb/host/ehci people also opted for #ifdef CONFIG_BIG_ENDIAN
> > archs etc...
> 
> I slightly prefer the more general patch for future kernel versions.
> The overhead will probably be negligible, but we can perform some
> testing to make sure.
> 
> Can you resubmit with all gathered feedback?

Yes, here are the changes.

I've tested it on my MyBook Live Duo. The usbotg comes right up:
[12610.540004] dwc2 4bff80000.usbotg: USB bus 1 deregistered
[12612.513934] dwc2 4bff80000.usbotg: Specified GNPTXFDEP=1024 > 256
[12612.518756] dwc2 4bff80000.usbotg: EPs: 3, shared fifos, 2042 entries in SPRAM
[12612.530112] dwc2 4bff80000.usbotg: DWC OTG Controller
[12612.533948] dwc2 4bff80000.usbotg: new USB bus registered, assigned bus number 1
[12612.540083] dwc2 4bff80000.usbotg: irq 33, io mem 0x00000000

John: Can you run some perf test with it?

I've based this on:

commit 6ea2fffc9057a67df1994d85a7c085d899eaa25a
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Fri May 13 15:52:27 2016 +0200

    usb: dwc2: fix regression on big-endian PowerPC/ARM systems

so naturally, it needs to be applied first.
Most of the conversion work was done by the attached
coccinelle semantic patches. 

I had to edit the __bic32 and __orr32 helpers by hand.
As well as some debugfs code and stuff in gadget.c.

here's the diffstat for everything. It's quite a lot:
 core.c      |  221 ++++++++++++++++++---------------
 core.h      |  134 +++++++++++---------
 core_intr.c |   70 +++++-----
 debugfs.c   |   55 +++-----
 gadget.c    |  396 +++++++++++++++++++++++++++++-------------------------------
 hcd.c       |  382 ++++++++++++++++++++++++++++-----------------------------
 hcd.h       |   10 -
 hcd_ddma.c  |   10 -
 hcd_intr.c  |   93 ++++++--------
 hcd_queue.c |   10 -
 platform.c  |    4 
 11 files changed, 709 insertions(+), 676 deletions(-)

So, Felipe: what's your plan?

---
@@ 
struct dwc2_hsotg *hsotg;
expression addr; 
@@

-dwc2_readl(hsotg->regs + addr)
+dwc2_readl(hsotg, addr)

@@
struct dwc2_hsotg *hsotg;
expression addr, value; 
@@

-dwc2_writel(value, hsotg->regs + addr)
+dwc2_writel(hsotg, value, addr)

@@
struct dwc2_hsotg *hsotg;
expression addr, port;
@@
addr = hsotg->regs + port;
...
-dwc2_readl(addr)
+dwc2_readl(hsotg, port)

@@
struct dwc2_hsotg *hsotg;
expression addr, val; 
@@

-__orr32(hsotg->regs + addr, val)
+__orr32(hsotg, addr, val)

@@
struct dwc2_hsotg *hsotg;
expression addr, val; 
@@

-__bic32(hsotg->regs + addr, val)
+__bic32(hsotg, addr, val)

@@
expression port;
identifier regs;
@@
-dwc2_readl(regs + port)
+dwc2_readl(hsotg, port)
---
diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index 4135a5f..f773146 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -71,16 +71,16 @@ static int dwc2_backup_global_registers(struct dwc2_hsotg *hsotg)
 	/* Backup global regs */
 	gr = &hsotg->gr_backup;
 
-	gr->gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
-	gr->gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
-	gr->gahbcfg = dwc2_readl(hsotg->regs + GAHBCFG);
-	gr->gusbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
-	gr->grxfsiz = dwc2_readl(hsotg->regs + GRXFSIZ);
-	gr->gnptxfsiz = dwc2_readl(hsotg->regs + GNPTXFSIZ);
-	gr->hptxfsiz = dwc2_readl(hsotg->regs + HPTXFSIZ);
-	gr->gdfifocfg = dwc2_readl(hsotg->regs + GDFIFOCFG);
+	gr->gotgctl = dwc2_readl(hsotg, GOTGCTL);
+	gr->gintmsk = dwc2_readl(hsotg, GINTMSK);
+	gr->gahbcfg = dwc2_readl(hsotg, GAHBCFG);
+	gr->gusbcfg = dwc2_readl(hsotg, GUSBCFG);
+	gr->grxfsiz = dwc2_readl(hsotg, GRXFSIZ);
+	gr->gnptxfsiz = dwc2_readl(hsotg, GNPTXFSIZ);
+	gr->hptxfsiz = dwc2_readl(hsotg, HPTXFSIZ);
+	gr->gdfifocfg = dwc2_readl(hsotg, GDFIFOCFG);
 	for (i = 0; i < MAX_EPS_CHANNELS; i++)
-		gr->dtxfsiz[i] = dwc2_readl(hsotg->regs + DPTXFSIZN(i));
+		gr->dtxfsiz[i] = dwc2_readl(hsotg, DPTXFSIZN(i));
 
 	gr->valid = true;
 	return 0;
@@ -109,17 +109,17 @@ static int dwc2_restore_global_registers(struct dwc2_hsotg *hsotg)
 	}
 	gr->valid = false;
 
-	dwc2_writel(0xffffffff, hsotg->regs + GINTSTS);
-	dwc2_writel(gr->gotgctl, hsotg->regs + GOTGCTL);
-	dwc2_writel(gr->gintmsk, hsotg->regs + GINTMSK);
-	dwc2_writel(gr->gusbcfg, hsotg->regs + GUSBCFG);
-	dwc2_writel(gr->gahbcfg, hsotg->regs + GAHBCFG);
-	dwc2_writel(gr->grxfsiz, hsotg->regs + GRXFSIZ);
-	dwc2_writel(gr->gnptxfsiz, hsotg->regs + GNPTXFSIZ);
-	dwc2_writel(gr->hptxfsiz, hsotg->regs + HPTXFSIZ);
-	dwc2_writel(gr->gdfifocfg, hsotg->regs + GDFIFOCFG);
+	dwc2_writel(hsotg, 0xffffffff, GINTSTS);
+	dwc2_writel(hsotg, gr->gotgctl, GOTGCTL);
+	dwc2_writel(hsotg, gr->gintmsk, GINTMSK);
+	dwc2_writel(hsotg, gr->gusbcfg, GUSBCFG);
+	dwc2_writel(hsotg, gr->gahbcfg, GAHBCFG);
+	dwc2_writel(hsotg, gr->grxfsiz, GRXFSIZ);
+	dwc2_writel(hsotg, gr->gnptxfsiz, GNPTXFSIZ);
+	dwc2_writel(hsotg, gr->hptxfsiz, HPTXFSIZ);
+	dwc2_writel(hsotg, gr->gdfifocfg, GDFIFOCFG);
 	for (i = 0; i < MAX_EPS_CHANNELS; i++)
-		dwc2_writel(gr->dtxfsiz[i], hsotg->regs + DPTXFSIZN(i));
+		dwc2_writel(hsotg, gr->dtxfsiz[i], DPTXFSIZN(i));
 
 	return 0;
 }
@@ -138,17 +138,17 @@ int dwc2_exit_hibernation(struct dwc2_hsotg *hsotg, bool restore)
 	if (!hsotg->core_params->hibernation)
 		return -ENOTSUPP;
 
-	pcgcctl = dwc2_readl(hsotg->regs + PCGCTL);
+	pcgcctl = dwc2_readl(hsotg, PCGCTL);
 	pcgcctl &= ~PCGCTL_STOPPCLK;
-	dwc2_writel(pcgcctl, hsotg->regs + PCGCTL);
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
 
-	pcgcctl = dwc2_readl(hsotg->regs + PCGCTL);
+	pcgcctl = dwc2_readl(hsotg, PCGCTL);
 	pcgcctl &= ~PCGCTL_PWRCLMP;
-	dwc2_writel(pcgcctl, hsotg->regs + PCGCTL);
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
 
-	pcgcctl = dwc2_readl(hsotg->regs + PCGCTL);
+	pcgcctl = dwc2_readl(hsotg, PCGCTL);
 	pcgcctl &= ~PCGCTL_RSTPDWNMODULE;
-	dwc2_writel(pcgcctl, hsotg->regs + PCGCTL);
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
 
 	udelay(100);
 	if (restore) {
@@ -219,21 +219,21 @@ int dwc2_enter_hibernation(struct dwc2_hsotg *hsotg)
 	 * Clear any pending interrupts since dwc2 will not be able to
 	 * clear them after entering hibernation.
 	 */
-	dwc2_writel(0xffffffff, hsotg->regs + GINTSTS);
+	dwc2_writel(hsotg, 0xffffffff, GINTSTS);
 
 	/* Put the controller in low power state */
-	pcgcctl = dwc2_readl(hsotg->regs + PCGCTL);
+	pcgcctl = dwc2_readl(hsotg, PCGCTL);
 
 	pcgcctl |= PCGCTL_PWRCLMP;
-	dwc2_writel(pcgcctl, hsotg->regs + PCGCTL);
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
 	ndelay(20);
 
 	pcgcctl |= PCGCTL_RSTPDWNMODULE;
-	dwc2_writel(pcgcctl, hsotg->regs + PCGCTL);
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
 	ndelay(20);
 
 	pcgcctl |= PCGCTL_STOPPCLK;
-	dwc2_writel(pcgcctl, hsotg->regs + PCGCTL);
+	dwc2_writel(hsotg, pcgcctl, PCGCTL);
 
 	return ret;
 }
@@ -250,12 +250,12 @@ int dwc2_core_reset(struct dwc2_hsotg *hsotg)
 	dev_vdbg(hsotg->dev, "%s()\n", __func__);
 
 	/* Core Soft Reset */
-	greset = dwc2_readl(hsotg->regs + GRSTCTL);
+	greset = dwc2_readl(hsotg, GRSTCTL);
 	greset |= GRSTCTL_CSFTRST;
-	dwc2_writel(greset, hsotg->regs + GRSTCTL);
+	dwc2_writel(hsotg, greset, GRSTCTL);
 	do {
 		udelay(1);
-		greset = dwc2_readl(hsotg->regs + GRSTCTL);
+		greset = dwc2_readl(hsotg, GRSTCTL);
 		if (++count > 50) {
 			dev_warn(hsotg->dev,
 				 "%s() HANG! Soft Reset GRSTCTL=%0x\n",
@@ -268,7 +268,7 @@ int dwc2_core_reset(struct dwc2_hsotg *hsotg)
 	count = 0;
 	do {
 		udelay(1);
-		greset = dwc2_readl(hsotg->regs + GRSTCTL);
+		greset = dwc2_readl(hsotg, GRSTCTL);
 		if (++count > 50) {
 			dev_warn(hsotg->dev,
 				 "%s() HANG! AHB Idle GRSTCTL=%0x\n",
@@ -328,14 +328,14 @@ static bool dwc2_force_mode(struct dwc2_hsotg *hsotg, bool host)
 	if (WARN_ON(!host && hsotg->dr_mode == USB_DR_MODE_HOST))
 		return false;
 
-	gusbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+	gusbcfg = dwc2_readl(hsotg, GUSBCFG);
 
 	set = host ? GUSBCFG_FORCEHOSTMODE : GUSBCFG_FORCEDEVMODE;
 	clear = host ? GUSBCFG_FORCEDEVMODE : GUSBCFG_FORCEHOSTMODE;
 
 	gusbcfg &= ~clear;
 	gusbcfg |= set;
-	dwc2_writel(gusbcfg, hsotg->regs + GUSBCFG);
+	dwc2_writel(hsotg, gusbcfg, GUSBCFG);
 
 	msleep(25);
 	return true;
@@ -348,10 +348,10 @@ static void dwc2_clear_force_mode(struct dwc2_hsotg *hsotg)
 {
 	u32 gusbcfg;
 
-	gusbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+	gusbcfg = dwc2_readl(hsotg, GUSBCFG);
 	gusbcfg &= ~GUSBCFG_FORCEHOSTMODE;
 	gusbcfg &= ~GUSBCFG_FORCEDEVMODE;
-	dwc2_writel(gusbcfg, hsotg->regs + GUSBCFG);
+	dwc2_writel(hsotg, gusbcfg, GUSBCFG);
 
 	/*
 	 * NOTE: This long sleep is _very_ important, otherwise the core will
@@ -424,56 +424,57 @@ void dwc2_dump_host_registers(struct dwc2_hsotg *hsotg)
 	dev_dbg(hsotg->dev, "Host Global Registers\n");
 	addr = hsotg->regs + HCFG;
 	dev_dbg(hsotg->dev, "HCFG	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, HCFG));
 	addr = hsotg->regs + HFIR;
 	dev_dbg(hsotg->dev, "HFIR	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, HFIR));
 	addr = hsotg->regs + HFNUM;
 	dev_dbg(hsotg->dev, "HFNUM	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, HFNUM));
 	addr = hsotg->regs + HPTXSTS;
 	dev_dbg(hsotg->dev, "HPTXSTS	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, HPTXSTS));
 	addr = hsotg->regs + HAINT;
 	dev_dbg(hsotg->dev, "HAINT	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, HAINT));
 	addr = hsotg->regs + HAINTMSK;
 	dev_dbg(hsotg->dev, "HAINTMSK	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, HAINTMSK));
 	if (hsotg->core_params->dma_desc_enable > 0) {
 		addr = hsotg->regs + HFLBADDR;
 		dev_dbg(hsotg->dev, "HFLBADDR @0x%08lX : 0x%08X\n",
-			(unsigned long)addr, dwc2_readl(addr));
+			(unsigned long)addr, dwc2_readl(hsotg, HFLBADDR));
 	}
 
 	addr = hsotg->regs + HPRT0;
 	dev_dbg(hsotg->dev, "HPRT0	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, HPRT0));
 
 	for (i = 0; i < hsotg->core_params->host_channels; i++) {
 		dev_dbg(hsotg->dev, "Host Channel %d Specific Registers\n", i);
 		addr = hsotg->regs + HCCHAR(i);
 		dev_dbg(hsotg->dev, "HCCHAR	 @0x%08lX : 0x%08X\n",
-			(unsigned long)addr, dwc2_readl(addr));
+			(unsigned long)addr, dwc2_readl(hsotg, HCCHAR(i)));
 		addr = hsotg->regs + HCSPLT(i);
 		dev_dbg(hsotg->dev, "HCSPLT	 @0x%08lX : 0x%08X\n",
-			(unsigned long)addr, dwc2_readl(addr));
+			(unsigned long)addr, dwc2_readl(hsotg, HCSPLT(i)));
 		addr = hsotg->regs + HCINT(i);
 		dev_dbg(hsotg->dev, "HCINT	 @0x%08lX : 0x%08X\n",
-			(unsigned long)addr, dwc2_readl(addr));
+			(unsigned long)addr, dwc2_readl(hsotg, HCINT(i)));
 		addr = hsotg->regs + HCINTMSK(i);
 		dev_dbg(hsotg->dev, "HCINTMSK	 @0x%08lX : 0x%08X\n",
-			(unsigned long)addr, dwc2_readl(addr));
+			(unsigned long)addr, dwc2_readl(hsotg, HCINTMSK(i)));
 		addr = hsotg->regs + HCTSIZ(i);
 		dev_dbg(hsotg->dev, "HCTSIZ	 @0x%08lX : 0x%08X\n",
-			(unsigned long)addr, dwc2_readl(addr));
+			(unsigned long)addr, dwc2_readl(hsotg, HCTSIZ(i)));
 		addr = hsotg->regs + HCDMA(i);
 		dev_dbg(hsotg->dev, "HCDMA	 @0x%08lX : 0x%08X\n",
-			(unsigned long)addr, dwc2_readl(addr));
+			(unsigned long)addr, dwc2_readl(hsotg, HCDMA(i)));
 		if (hsotg->core_params->dma_desc_enable > 0) {
 			addr = hsotg->regs + HCDMAB(i);
 			dev_dbg(hsotg->dev, "HCDMAB	 @0x%08lX : 0x%08X\n",
-				(unsigned long)addr, dwc2_readl(addr));
+				(unsigned long)addr,
+				dwc2_readl(hsotg, HCDMAB(i)));
 		}
 	}
 #endif
@@ -495,80 +496,80 @@ void dwc2_dump_global_registers(struct dwc2_hsotg *hsotg)
 	dev_dbg(hsotg->dev, "Core Global Registers\n");
 	addr = hsotg->regs + GOTGCTL;
 	dev_dbg(hsotg->dev, "GOTGCTL	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GOTGCTL));
 	addr = hsotg->regs + GOTGINT;
 	dev_dbg(hsotg->dev, "GOTGINT	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GOTGINT));
 	addr = hsotg->regs + GAHBCFG;
 	dev_dbg(hsotg->dev, "GAHBCFG	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GAHBCFG));
 	addr = hsotg->regs + GUSBCFG;
 	dev_dbg(hsotg->dev, "GUSBCFG	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GUSBCFG));
 	addr = hsotg->regs + GRSTCTL;
 	dev_dbg(hsotg->dev, "GRSTCTL	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GRSTCTL));
 	addr = hsotg->regs + GINTSTS;
 	dev_dbg(hsotg->dev, "GINTSTS	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GINTSTS));
 	addr = hsotg->regs + GINTMSK;
 	dev_dbg(hsotg->dev, "GINTMSK	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GINTMSK));
 	addr = hsotg->regs + GRXSTSR;
 	dev_dbg(hsotg->dev, "GRXSTSR	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GRXSTSR));
 	addr = hsotg->regs + GRXFSIZ;
 	dev_dbg(hsotg->dev, "GRXFSIZ	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GRXFSIZ));
 	addr = hsotg->regs + GNPTXFSIZ;
 	dev_dbg(hsotg->dev, "GNPTXFSIZ	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GNPTXFSIZ));
 	addr = hsotg->regs + GNPTXSTS;
 	dev_dbg(hsotg->dev, "GNPTXSTS	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GNPTXSTS));
 	addr = hsotg->regs + GI2CCTL;
 	dev_dbg(hsotg->dev, "GI2CCTL	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GI2CCTL));
 	addr = hsotg->regs + GPVNDCTL;
 	dev_dbg(hsotg->dev, "GPVNDCTL	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GPVNDCTL));
 	addr = hsotg->regs + GGPIO;
 	dev_dbg(hsotg->dev, "GGPIO	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GGPIO));
 	addr = hsotg->regs + GUID;
 	dev_dbg(hsotg->dev, "GUID	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GUID));
 	addr = hsotg->regs + GSNPSID;
 	dev_dbg(hsotg->dev, "GSNPSID	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GSNPSID));
 	addr = hsotg->regs + GHWCFG1;
 	dev_dbg(hsotg->dev, "GHWCFG1	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GHWCFG1));
 	addr = hsotg->regs + GHWCFG2;
 	dev_dbg(hsotg->dev, "GHWCFG2	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GHWCFG2));
 	addr = hsotg->regs + GHWCFG3;
 	dev_dbg(hsotg->dev, "GHWCFG3	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GHWCFG3));
 	addr = hsotg->regs + GHWCFG4;
 	dev_dbg(hsotg->dev, "GHWCFG4	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GHWCFG4));
 	addr = hsotg->regs + GLPMCFG;
 	dev_dbg(hsotg->dev, "GLPMCFG	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GLPMCFG));
 	addr = hsotg->regs + GPWRDN;
 	dev_dbg(hsotg->dev, "GPWRDN	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GPWRDN));
 	addr = hsotg->regs + GDFIFOCFG;
 	dev_dbg(hsotg->dev, "GDFIFOCFG	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, GDFIFOCFG));
 	addr = hsotg->regs + HPTXFSIZ;
 	dev_dbg(hsotg->dev, "HPTXFSIZ	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, HPTXFSIZ));
 
 	addr = hsotg->regs + PCGCTL;
 	dev_dbg(hsotg->dev, "PCGCTL	 @0x%08lX : 0x%08X\n",
-		(unsigned long)addr, dwc2_readl(addr));
+		(unsigned long)addr, dwc2_readl(hsotg, PCGCTL));
 #endif
 }
 
@@ -587,15 +588,15 @@ void dwc2_flush_tx_fifo(struct dwc2_hsotg *hsotg, const int num)
 
 	greset = GRSTCTL_TXFFLSH;
 	greset |= num << GRSTCTL_TXFNUM_SHIFT & GRSTCTL_TXFNUM_MASK;
-	dwc2_writel(greset, hsotg->regs + GRSTCTL);
+	dwc2_writel(hsotg, greset, GRSTCTL);
 
 	do {
-		greset = dwc2_readl(hsotg->regs + GRSTCTL);
+		greset = dwc2_readl(hsotg, GRSTCTL);
 		if (++count > 10000) {
 			dev_warn(hsotg->dev,
 				 "%s() HANG! GRSTCTL=%0x GNPTXSTS=0x%08x\n",
 				 __func__, greset,
-				 dwc2_readl(hsotg->regs + GNPTXSTS));
+				 dwc2_readl(hsotg, GNPTXSTS));
 			break;
 		}
 		udelay(1);
@@ -618,10 +619,10 @@ void dwc2_flush_rx_fifo(struct dwc2_hsotg *hsotg)
 	dev_vdbg(hsotg->dev, "%s()\n", __func__);
 
 	greset = GRSTCTL_RXFFLSH;
-	dwc2_writel(greset, hsotg->regs + GRSTCTL);
+	dwc2_writel(hsotg, greset, GRSTCTL);
 
 	do {
-		greset = dwc2_readl(hsotg->regs + GRSTCTL);
+		greset = dwc2_readl(hsotg, GRSTCTL);
 		if (++count > 10000) {
 			dev_warn(hsotg->dev, "%s() HANG! GRSTCTL=%0x\n",
 				 __func__, greset);
@@ -1358,8 +1359,8 @@ static void dwc2_get_host_hwparams(struct dwc2_hsotg *hsotg)
 
 	forced = dwc2_force_mode_if_needed(hsotg, true);
 
-	gnptxfsiz = dwc2_readl(hsotg->regs + GNPTXFSIZ);
-	hptxfsiz = dwc2_readl(hsotg->regs + HPTXFSIZ);
+	gnptxfsiz = dwc2_readl(hsotg, GNPTXFSIZ);
+	hptxfsiz = dwc2_readl(hsotg, HPTXFSIZ);
 	dev_dbg(hsotg->dev, "gnptxfsiz=%08x\n", gnptxfsiz);
 	dev_dbg(hsotg->dev, "hptxfsiz=%08x\n", hptxfsiz);
 
@@ -1388,7 +1389,7 @@ static void dwc2_get_dev_hwparams(struct dwc2_hsotg *hsotg)
 
 	forced = dwc2_force_mode_if_needed(hsotg, false);
 
-	gnptxfsiz = dwc2_readl(hsotg->regs + GNPTXFSIZ);
+	gnptxfsiz = dwc2_readl(hsotg, GNPTXFSIZ);
 	dev_dbg(hsotg->dev, "gnptxfsiz=%08x\n", gnptxfsiz);
 
 	if (forced)
@@ -1398,6 +1399,28 @@ static void dwc2_get_dev_hwparams(struct dwc2_hsotg *hsotg)
 				       FIFOSIZE_DEPTH_SHIFT;
 }
 
+int dwc2_detect_endiannes(struct dwc2_hsotg *hsotg)
+{
+	u32 sid;
+
+	/*
+	 * try little endian first, as this is the default on most
+	 * platforms.
+	 */
+	hsotg->is_big_endian = 0;
+	sid = dwc2_readl(hsotg, GSNPSID);
+	if ((sid & 0xffff0000) == 0x4f540000)
+		return 0;
+
+	hsotg->is_big_endian = 1;
+	sid = dwc2_readl(hsotg, GSNPSID);
+	if ((sid & 0xffff0000) == 0x4f540000)
+		return 0;
+
+	dev_err(hsotg->dev, "Automatic endian detection failed");
+	return -EINVAL;
+}
+
 /**
  * During device initialization, read various hardware configuration
  * registers and interpret the contents.
@@ -1412,10 +1435,10 @@ int dwc2_get_hwparams(struct dwc2_hsotg *hsotg)
 	/*
 	 * Attempt to ensure this device is really a DWC_otg Controller.
 	 * Read and verify the GSNPSID register contents. The value should be
-	 * 0x45f42xxx or 0x45f43xxx, which corresponds to either "OT2" or "OT3",
+	 * 0x4f542xxx or 0x4f543xxx, which corresponds to either "OT2" or "OT3",
 	 * as in "OTG version 2.xx" or "OTG version 3.xx".
 	 */
-	hw->snpsid = dwc2_readl(hsotg->regs + GSNPSID);
+	hw->snpsid = dwc2_readl(hsotg, GSNPSID);
 	if ((hw->snpsid & 0xfffff000) != 0x4f542000 &&
 	    (hw->snpsid & 0xfffff000) != 0x4f543000) {
 		dev_err(hsotg->dev, "Bad value for GSNPSID: 0x%08x\n",
@@ -1427,11 +1450,11 @@ int dwc2_get_hwparams(struct dwc2_hsotg *hsotg)
 		hw->snpsid >> 12 & 0xf, hw->snpsid >> 8 & 0xf,
 		hw->snpsid >> 4 & 0xf, hw->snpsid & 0xf, hw->snpsid);
 
-	hwcfg1 = dwc2_readl(hsotg->regs + GHWCFG1);
-	hwcfg2 = dwc2_readl(hsotg->regs + GHWCFG2);
-	hwcfg3 = dwc2_readl(hsotg->regs + GHWCFG3);
-	hwcfg4 = dwc2_readl(hsotg->regs + GHWCFG4);
-	grxfsiz = dwc2_readl(hsotg->regs + GRXFSIZ);
+	hwcfg1 = dwc2_readl(hsotg, GHWCFG1);
+	hwcfg2 = dwc2_readl(hsotg, GHWCFG2);
+	hwcfg3 = dwc2_readl(hsotg, GHWCFG3);
+	hwcfg4 = dwc2_readl(hsotg, GHWCFG4);
+	grxfsiz = dwc2_readl(hsotg, GRXFSIZ);
 
 	dev_dbg(hsotg->dev, "hwcfg1=%08x\n", hwcfg1);
 	dev_dbg(hsotg->dev, "hwcfg2=%08x\n", hwcfg2);
@@ -1571,7 +1594,7 @@ u16 dwc2_get_otg_version(struct dwc2_hsotg *hsotg)
 
 bool dwc2_is_controller_alive(struct dwc2_hsotg *hsotg)
 {
-	if (dwc2_readl(hsotg->regs + GSNPSID) == 0xffffffff)
+	if (dwc2_readl(hsotg, GSNPSID) == 0xffffffff)
 		return false;
 	else
 		return true;
@@ -1585,10 +1608,10 @@ bool dwc2_is_controller_alive(struct dwc2_hsotg *hsotg)
  */
 void dwc2_enable_global_interrupts(struct dwc2_hsotg *hsotg)
 {
-	u32 ahbcfg = dwc2_readl(hsotg->regs + GAHBCFG);
+	u32 ahbcfg = dwc2_readl(hsotg, GAHBCFG);
 
 	ahbcfg |= GAHBCFG_GLBL_INTR_EN;
-	dwc2_writel(ahbcfg, hsotg->regs + GAHBCFG);
+	dwc2_writel(hsotg, ahbcfg, GAHBCFG);
 }
 
 /**
@@ -1599,16 +1622,16 @@ void dwc2_enable_global_interrupts(struct dwc2_hsotg *hsotg)
  */
 void dwc2_disable_global_interrupts(struct dwc2_hsotg *hsotg)
 {
-	u32 ahbcfg = dwc2_readl(hsotg->regs + GAHBCFG);
+	u32 ahbcfg = dwc2_readl(hsotg, GAHBCFG);
 
 	ahbcfg &= ~GAHBCFG_GLBL_INTR_EN;
-	dwc2_writel(ahbcfg, hsotg->regs + GAHBCFG);
+	dwc2_writel(hsotg, ahbcfg, GAHBCFG);
 }
 
 /* Returns the controller's GHWCFG2.OTG_MODE. */
 unsigned dwc2_op_mode(struct dwc2_hsotg *hsotg)
 {
-	u32 ghwcfg2 = dwc2_readl(hsotg->regs + GHWCFG2);
+	u32 ghwcfg2 = dwc2_readl(hsotg, GHWCFG2);
 
 	return (ghwcfg2 & GHWCFG2_OP_MODE_MASK) >>
 		GHWCFG2_OP_MODE_SHIFT;
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index dec0b21..2fa57cd 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -64,60 +64,6 @@
 	DWC2_TRACE_SCHEDULER_VB(pr_fmt("%s: SCH: " fmt),		\
 				dev_name(hsotg->dev), ##__VA_ARGS__)
 
-#ifdef CONFIG_MIPS
-/*
- * There are some MIPS machines that can run in either big-endian
- * or little-endian mode and that use the dwc2 register without
- * a byteswap in both ways.
- * Unlike other architectures, MIPS apparently does not require a
- * barrier before the __raw_writel() to synchronize with DMA but does
- * require the barrier after the __raw_writel() to serialize a set of
- * writes. This set of operations was added specifically for MIPS and
- * should only be used there.
- */
-static inline u32 dwc2_readl(const void __iomem *addr)
-{
-	u32 value = __raw_readl(addr);
-
-	/* In order to preserve endianness __raw_* operation is used. Therefore
-	 * a barrier is needed to ensure IO access is not re-ordered across
-	 * reads or writes
-	 */
-	mb();
-	return value;
-}
-
-static inline void dwc2_writel(u32 value, void __iomem *addr)
-{
-	__raw_writel(value, addr);
-
-	/*
-	 * In order to preserve endianness __raw_* operation is used. Therefore
-	 * a barrier is needed to ensure IO access is not re-ordered across
-	 * reads or writes
-	 */
-	mb();
-#ifdef DWC2_LOG_WRITES
-	pr_info("INFO:: wrote %08x to %p\n", value, addr);
-#endif
-}
-#else
-/* Normal architectures just use readl/write */
-static inline u32 dwc2_readl(const void __iomem *addr)
-{
-	return readl(addr);
-}
-
-static inline void dwc2_writel(u32 value, void __iomem *addr)
-{
-	writel(value, addr);
-
-#ifdef DWC2_LOG_WRITES
-	pr_info("info:: wrote %08x to %p\n", value, addr);
-#endif
-}
-#endif
-
 /* Maximum number of Endpoints/HostChannels */
 #define MAX_EPS_CHANNELS	16
 
@@ -719,6 +665,7 @@ struct dwc2_hregs_backup {
  * @hcd_enabled		Host mode sub-driver initialization indicator.
  * @gadget_enabled	Peripheral mode sub-driver initialization indicator.
  * @ll_hw_enabled	Status of low-level hardware resources.
+ * @is_big_endian	force big endian register access.
  * @phy:                The otg phy transceiver structure for phy control.
  * @uphy:               The otg phy transceiver structure for old USB phy control.
  * @plat:               The platform specific configuration data. This can be removed once
@@ -853,6 +800,7 @@ struct dwc2_hsotg {
 	unsigned int hcd_enabled:1;
 	unsigned int gadget_enabled:1;
 	unsigned int ll_hw_enabled:1;
+	unsigned int is_big_endian:1;
 
 	struct phy *phy;
 	struct usb_phy *uphy;
@@ -1010,6 +958,80 @@ enum dwc2_halt_status {
 	DWC2_HC_XFER_URB_DEQUEUE,
 };
 
+#ifdef CONFIG_MIPS
+/*
+ * There are some MIPS machines that can run in either big-endian
+ * or little-endian mode and that use the dwc2 register without
+ * a byteswap in both ways.
+ * Unlike other architectures, MIPS apparently does not require a
+ * barrier before the __raw_writel() to synchronize with DMA but does
+ * require the barrier after the __raw_writel() to serialize a set of
+ * writes. This set of operations was added specifically for MIPS and
+ * should only be used there.
+ */
+static inline u32 dwc2_readl(struct dwc2_hsotg *hsotg,
+			     ptrdiff_t reg)
+{
+	const void __iomem *addr = hsotg->regs + reg;
+	u32 value = __raw_readl(addr);
+
+	/*
+	 * In order to preserve endianness __raw_* operation is used. Therefore
+	 * a barrier is needed to ensure IO access is not re-ordered across
+	 * reads or writes
+	 */
+	mb();
+	return value;
+}
+
+static inline void dwc2_writel(struct dwc2_hsotg *hsotg, u32 value,
+			       ptrdiff_t reg)
+{
+	const void __iomem *addr = hsotg->regs + reg;
+	__raw_writel(value, addr);
+
+	/*
+	 * In order to preserve endianness __raw_* operation is used. Therefore
+	 * a barrier is needed to ensure IO access is not re-ordered across
+	 * reads or writes
+	 */
+	mb();
+#ifdef DWC2_LOG_WRITES
+	pr_info("INFO:: wrote %08x to %p\n", value, addr);
+#endif
+}
+#else
+/* Normal architectures just use readl/write_be */
+static inline u32 dwc2_readl(struct dwc2_hsotg *hsotg,
+			     ptrdiff_t reg)
+{
+	void __iomem *addr = hsotg->regs + reg;
+
+	if (hsotg->is_big_endian)
+		return ioread32be(addr);
+	else
+		return ioread32(addr);
+}
+
+
+static inline void dwc2_writel(struct dwc2_hsotg *hsotg, u32 value,
+			       ptrdiff_t reg)
+{
+	void __iomem *addr = hsotg->regs + reg;
+
+	if (hsotg->is_big_endian)
+		iowrite32be(value, addr);
+	else
+		iowrite32(value, addr);
+
+#ifdef DWC2_LOG_WRITES
+	pr_info("info:: wrote %08x to %p\n", value, addr);
+#endif
+}
+#endif
+
+extern int dwc2_detect_endiannes(struct dwc2_hsotg *hsotg);
+
 /*
  * The following functions support initialization of the core driver component
  * and the DWC_otg controller
@@ -1267,11 +1289,11 @@ bool dwc2_hw_is_device(struct dwc2_hsotg *hsotg);
  */
 static inline int dwc2_is_host_mode(struct dwc2_hsotg *hsotg)
 {
-	return (dwc2_readl(hsotg->regs + GINTSTS) & GINTSTS_CURMODE_HOST) != 0;
+	return (dwc2_readl(hsotg, GINTSTS) & GINTSTS_CURMODE_HOST) != 0;
 }
 static inline int dwc2_is_device_mode(struct dwc2_hsotg *hsotg)
 {
-	return (dwc2_readl(hsotg->regs + GINTSTS) & GINTSTS_CURMODE_HOST) == 0;
+	return (dwc2_readl(hsotg, GINTSTS) & GINTSTS_CURMODE_HOST) == 0;
 }
 
 /*
diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index d85c5c9..7e3542a 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -80,11 +80,11 @@ static const char *dwc2_op_state_str(struct dwc2_hsotg *hsotg)
  */
 static void dwc2_handle_usb_port_intr(struct dwc2_hsotg *hsotg)
 {
-	u32 hprt0 = dwc2_readl(hsotg->regs + HPRT0);
+	u32 hprt0 = dwc2_readl(hsotg, HPRT0);
 
 	if (hprt0 & HPRT0_ENACHG) {
 		hprt0 &= ~HPRT0_ENA;
-		dwc2_writel(hprt0, hsotg->regs + HPRT0);
+		dwc2_writel(hsotg, hprt0, HPRT0);
 	}
 }
 
@@ -96,7 +96,7 @@ static void dwc2_handle_usb_port_intr(struct dwc2_hsotg *hsotg)
 static void dwc2_handle_mode_mismatch_intr(struct dwc2_hsotg *hsotg)
 {
 	/* Clear interrupt */
-	dwc2_writel(GINTSTS_MODEMIS, hsotg->regs + GINTSTS);
+	dwc2_writel(hsotg, GINTSTS_MODEMIS, GINTSTS);
 
 	dev_warn(hsotg->dev, "Mode Mismatch Interrupt: currently in %s mode\n",
 		 dwc2_is_host_mode(hsotg) ? "Host" : "Device");
@@ -114,8 +114,8 @@ static void dwc2_handle_otg_intr(struct dwc2_hsotg *hsotg)
 	u32 gotgctl;
 	u32 gintmsk;
 
-	gotgint = dwc2_readl(hsotg->regs + GOTGINT);
-	gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+	gotgint = dwc2_readl(hsotg, GOTGINT);
+	gotgctl = dwc2_readl(hsotg, GOTGCTL);
 	dev_dbg(hsotg->dev, "++OTG Interrupt gotgint=%0x [%s]\n", gotgint,
 		dwc2_op_state_str(hsotg));
 
@@ -123,7 +123,7 @@ static void dwc2_handle_otg_intr(struct dwc2_hsotg *hsotg)
 		dev_dbg(hsotg->dev,
 			" ++OTG Interrupt: Session End Detected++ (%s)\n",
 			dwc2_op_state_str(hsotg));
-		gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+		gotgctl = dwc2_readl(hsotg, GOTGCTL);
 
 		if (dwc2_is_device_mode(hsotg))
 			dwc2_hsotg_disconnect(hsotg);
@@ -149,15 +149,15 @@ static void dwc2_handle_otg_intr(struct dwc2_hsotg *hsotg)
 			hsotg->lx_state = DWC2_L0;
 		}
 
-		gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+		gotgctl = dwc2_readl(hsotg, GOTGCTL);
 		gotgctl &= ~GOTGCTL_DEVHNPEN;
-		dwc2_writel(gotgctl, hsotg->regs + GOTGCTL);
+		dwc2_writel(hsotg, gotgctl, GOTGCTL);
 	}
 
 	if (gotgint & GOTGINT_SES_REQ_SUC_STS_CHNG) {
 		dev_dbg(hsotg->dev,
 			" ++OTG Interrupt: Session Request Success Status Change++\n");
-		gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+		gotgctl = dwc2_readl(hsotg, GOTGCTL);
 		if (gotgctl & GOTGCTL_SESREQSCS) {
 			if (hsotg->core_params->phy_type ==
 					DWC2_PHY_TYPE_PARAM_FS
@@ -165,9 +165,9 @@ static void dwc2_handle_otg_intr(struct dwc2_hsotg *hsotg)
 				hsotg->srp_success = 1;
 			} else {
 				/* Clear Session Request */
-				gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+				gotgctl = dwc2_readl(hsotg, GOTGCTL);
 				gotgctl &= ~GOTGCTL_SESREQ;
-				dwc2_writel(gotgctl, hsotg->regs + GOTGCTL);
+				dwc2_writel(hsotg, gotgctl, GOTGCTL);
 			}
 		}
 	}
@@ -177,7 +177,7 @@ static void dwc2_handle_otg_intr(struct dwc2_hsotg *hsotg)
 		 * Print statements during the HNP interrupt handling
 		 * can cause it to fail
 		 */
-		gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+		gotgctl = dwc2_readl(hsotg, GOTGCTL);
 		/*
 		 * WA for 3.00a- HW is not setting cur_mode, even sometimes
 		 * this does not help
@@ -197,9 +197,9 @@ static void dwc2_handle_otg_intr(struct dwc2_hsotg *hsotg)
 				 * interrupt does not get handled and Linux
 				 * complains loudly.
 				 */
-				gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+				gintmsk = dwc2_readl(hsotg, GINTMSK);
 				gintmsk &= ~GINTSTS_SOF;
-				dwc2_writel(gintmsk, hsotg->regs + GINTMSK);
+				dwc2_writel(hsotg, gintmsk, GINTMSK);
 
 				/*
 				 * Call callback function with spin lock
@@ -213,9 +213,9 @@ static void dwc2_handle_otg_intr(struct dwc2_hsotg *hsotg)
 				hsotg->op_state = OTG_STATE_B_HOST;
 			}
 		} else {
-			gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+			gotgctl = dwc2_readl(hsotg, GOTGCTL);
 			gotgctl &= ~(GOTGCTL_HNPREQ | GOTGCTL_DEVHNPEN);
-			dwc2_writel(gotgctl, hsotg->regs + GOTGCTL);
+			dwc2_writel(hsotg, gotgctl, GOTGCTL);
 			dev_dbg(hsotg->dev, "HNP Failed\n");
 			dev_err(hsotg->dev,
 				"Device Not Connected/Responding\n");
@@ -241,9 +241,9 @@ static void dwc2_handle_otg_intr(struct dwc2_hsotg *hsotg)
 			hsotg->op_state = OTG_STATE_A_PERIPHERAL;
 		} else {
 			/* Need to disable SOF interrupt immediately */
-			gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+			gintmsk = dwc2_readl(hsotg, GINTMSK);
 			gintmsk &= ~GINTSTS_SOF;
-			dwc2_writel(gintmsk, hsotg->regs + GINTMSK);
+			dwc2_writel(hsotg, gintmsk, GINTMSK);
 			spin_unlock(&hsotg->lock);
 			dwc2_hcd_start(hsotg);
 			spin_lock(&hsotg->lock);
@@ -258,7 +258,7 @@ static void dwc2_handle_otg_intr(struct dwc2_hsotg *hsotg)
 		dev_dbg(hsotg->dev, " ++OTG Interrupt: Debounce Done++\n");
 
 	/* Clear GOTGINT */
-	dwc2_writel(gotgint, hsotg->regs + GOTGINT);
+	dwc2_writel(hsotg, gotgint, GOTGINT);
 }
 
 /**
@@ -276,12 +276,12 @@ static void dwc2_handle_conn_id_status_change_intr(struct dwc2_hsotg *hsotg)
 	u32 gintmsk;
 
 	/* Clear interrupt */
-	dwc2_writel(GINTSTS_CONIDSTSCHNG, hsotg->regs + GINTSTS);
+	dwc2_writel(hsotg, GINTSTS_CONIDSTSCHNG, GINTSTS);
 
 	/* Need to disable SOF interrupt immediately */
-	gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+	gintmsk = dwc2_readl(hsotg, GINTMSK);
 	gintmsk &= ~GINTSTS_SOF;
-	dwc2_writel(gintmsk, hsotg->regs + GINTMSK);
+	dwc2_writel(hsotg, gintmsk, GINTMSK);
 
 	dev_dbg(hsotg->dev, " ++Connector ID Status Change Interrupt++  (%s)\n",
 		dwc2_is_host_mode(hsotg) ? "Host" : "Device");
@@ -314,7 +314,7 @@ static void dwc2_handle_session_req_intr(struct dwc2_hsotg *hsotg)
 	int ret;
 
 	/* Clear interrupt */
-	dwc2_writel(GINTSTS_SESSREQINT, hsotg->regs + GINTSTS);
+	dwc2_writel(hsotg, GINTSTS_SESSREQINT, GINTSTS);
 
 	dev_dbg(hsotg->dev, "Session request interrupt - lx_state=%d\n",
 							hsotg->lx_state);
@@ -347,20 +347,20 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 	int ret;
 
 	/* Clear interrupt */
-	dwc2_writel(GINTSTS_WKUPINT, hsotg->regs + GINTSTS);
+	dwc2_writel(hsotg, GINTSTS_WKUPINT, GINTSTS);
 
 	dev_dbg(hsotg->dev, "++Resume or Remote Wakeup Detected Interrupt++\n");
 	dev_dbg(hsotg->dev, "%s lxstate = %d\n", __func__, hsotg->lx_state);
 
 	if (dwc2_is_device_mode(hsotg)) {
 		dev_dbg(hsotg->dev, "DSTS=0x%0x\n",
-			dwc2_readl(hsotg->regs + DSTS));
+			dwc2_readl(hsotg, DSTS));
 		if (hsotg->lx_state == DWC2_L2) {
-			u32 dctl = dwc2_readl(hsotg->regs + DCTL);
+			u32 dctl = dwc2_readl(hsotg, DCTL);
 
 			/* Clear Remote Wakeup Signaling */
 			dctl &= ~DCTL_RMTWKUPSIG;
-			dwc2_writel(dctl, hsotg->regs + DCTL);
+			dwc2_writel(hsotg, dctl, DCTL);
 			ret = dwc2_exit_hibernation(hsotg, true);
 			if (ret && (ret != -ENOTSUPP))
 				dev_err(hsotg->dev, "exit hibernation failed\n");
@@ -374,11 +374,11 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 			return;
 
 		if (hsotg->lx_state != DWC2_L1) {
-			u32 pcgcctl = dwc2_readl(hsotg->regs + PCGCTL);
+			u32 pcgcctl = dwc2_readl(hsotg, PCGCTL);
 
 			/* Restart the Phy Clock */
 			pcgcctl &= ~PCGCTL_STOPPCLK;
-			dwc2_writel(pcgcctl, hsotg->regs + PCGCTL);
+			dwc2_writel(hsotg, pcgcctl, PCGCTL);
 			mod_timer(&hsotg->wkp_timer,
 				  jiffies + msecs_to_jiffies(71));
 		} else {
@@ -394,7 +394,7 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
  */
 static void dwc2_handle_disconnect_intr(struct dwc2_hsotg *hsotg)
 {
-	dwc2_writel(GINTSTS_DISCONNINT, hsotg->regs + GINTSTS);
+	dwc2_writel(hsotg, GINTSTS_DISCONNINT, GINTSTS);
 
 	dev_dbg(hsotg->dev, "++Disconnect Detected Interrupt++ (%s) %s\n",
 		dwc2_is_host_mode(hsotg) ? "Host" : "Device",
@@ -418,7 +418,7 @@ static void dwc2_handle_usb_suspend_intr(struct dwc2_hsotg *hsotg)
 	int ret;
 
 	/* Clear interrupt */
-	dwc2_writel(GINTSTS_USBSUSP, hsotg->regs + GINTSTS);
+	dwc2_writel(hsotg, GINTSTS_USBSUSP, GINTSTS);
 
 	dev_dbg(hsotg->dev, "USB SUSPEND\n");
 
@@ -427,7 +427,7 @@ static void dwc2_handle_usb_suspend_intr(struct dwc2_hsotg *hsotg)
 		 * Check the Device status register to determine if the Suspend
 		 * state is active
 		 */
-		dsts = dwc2_readl(hsotg->regs + DSTS);
+		dsts = dwc2_readl(hsotg, DSTS);
 		dev_dbg(hsotg->dev, "DSTS=0x%0x\n", dsts);
 		dev_dbg(hsotg->dev,
 			"DSTS.Suspend Status=%d HWCFG4.Power Optimize=%d\n",
@@ -494,9 +494,9 @@ static u32 dwc2_read_common_intr(struct dwc2_hsotg *hsotg)
 	u32 gahbcfg;
 	u32 gintmsk_common = GINTMSK_COMMON;
 
-	gintsts = dwc2_readl(hsotg->regs + GINTSTS);
-	gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
-	gahbcfg = dwc2_readl(hsotg->regs + GAHBCFG);
+	gintsts = dwc2_readl(hsotg, GINTSTS);
+	gintmsk = dwc2_readl(hsotg, GINTMSK);
+	gahbcfg = dwc2_readl(hsotg, GAHBCFG);
 
 	/* If any common interrupts set */
 	if (gintsts & gintmsk_common)
diff --git a/drivers/usb/dwc2/debugfs.c b/drivers/usb/dwc2/debugfs.c
index 55d91f2..20f5eea 100644
--- a/drivers/usb/dwc2/debugfs.c
+++ b/drivers/usb/dwc2/debugfs.c
@@ -76,7 +76,7 @@ static int testmode_show(struct seq_file *s, void *unused)
 	int dctl;
 
 	spin_lock_irqsave(&hsotg->lock, flags);
-	dctl = dwc2_readl(hsotg->regs + DCTL);
+	dctl = dwc2_readl(hsotg, DCTL);
 	dctl &= DCTL_TSTCTL_MASK;
 	dctl >>= DCTL_TSTCTL_SHIFT;
 	spin_unlock_irqrestore(&hsotg->lock, flags);
@@ -133,42 +133,41 @@ static const struct file_operations testmode_fops = {
 static int state_show(struct seq_file *seq, void *v)
 {
 	struct dwc2_hsotg *hsotg = seq->private;
-	void __iomem *regs = hsotg->regs;
 	int idx;
 
 	seq_printf(seq, "DCFG=0x%08x, DCTL=0x%08x, DSTS=0x%08x\n",
-		 dwc2_readl(regs + DCFG),
-		 dwc2_readl(regs + DCTL),
-		 dwc2_readl(regs + DSTS));
+		 dwc2_readl(hsotg, DCFG),
+		 dwc2_readl(hsotg, DCTL),
+		 dwc2_readl(hsotg, DSTS));
 
 	seq_printf(seq, "DIEPMSK=0x%08x, DOEPMASK=0x%08x\n",
-		   dwc2_readl(regs + DIEPMSK), dwc2_readl(regs + DOEPMSK));
+		   dwc2_readl(hsotg, DIEPMSK), dwc2_readl(hsotg, DOEPMSK));
 
 	seq_printf(seq, "GINTMSK=0x%08x, GINTSTS=0x%08x\n",
-		   dwc2_readl(regs + GINTMSK),
-		   dwc2_readl(regs + GINTSTS));
+		   dwc2_readl(hsotg, GINTMSK),
+		   dwc2_readl(hsotg, GINTSTS));
 
 	seq_printf(seq, "DAINTMSK=0x%08x, DAINT=0x%08x\n",
-		   dwc2_readl(regs + DAINTMSK),
-		   dwc2_readl(regs + DAINT));
+		   dwc2_readl(hsotg, DAINTMSK),
+		   dwc2_readl(hsotg, DAINT));
 
 	seq_printf(seq, "GNPTXSTS=0x%08x, GRXSTSR=%08x\n",
-		   dwc2_readl(regs + GNPTXSTS),
-		   dwc2_readl(regs + GRXSTSR));
+		   dwc2_readl(hsotg, GNPTXSTS),
+		   dwc2_readl(hsotg, GRXSTSR));
 
 	seq_puts(seq, "\nEndpoint status:\n");
 
 	for (idx = 0; idx < hsotg->num_of_eps; idx++) {
 		u32 in, out;
 
-		in = dwc2_readl(regs + DIEPCTL(idx));
-		out = dwc2_readl(regs + DOEPCTL(idx));
+		in = dwc2_readl(hsotg, DIEPCTL(idx));
+		out = dwc2_readl(hsotg, DOEPCTL(idx));
 
 		seq_printf(seq, "ep%d: DIEPCTL=0x%08x, DOEPCTL=0x%08x",
 			   idx, in, out);
 
-		in = dwc2_readl(regs + DIEPTSIZ(idx));
-		out = dwc2_readl(regs + DOEPTSIZ(idx));
+		in = dwc2_readl(hsotg, DIEPTSIZ(idx));
+		out = dwc2_readl(hsotg, DOEPTSIZ(idx));
 
 		seq_printf(seq, ", DIEPTSIZ=0x%08x, DOEPTSIZ=0x%08x",
 			   in, out);
@@ -203,14 +202,13 @@ static const struct file_operations state_fops = {
 static int fifo_show(struct seq_file *seq, void *v)
 {
 	struct dwc2_hsotg *hsotg = seq->private;
-	void __iomem *regs = hsotg->regs;
 	u32 val;
 	int idx;
 
 	seq_puts(seq, "Non-periodic FIFOs:\n");
-	seq_printf(seq, "RXFIFO: Size %d\n", dwc2_readl(regs + GRXFSIZ));
+	seq_printf(seq, "RXFIFO: Size %d\n", dwc2_readl(hsotg, GRXFSIZ));
 
-	val = dwc2_readl(regs + GNPTXFSIZ);
+	val = dwc2_readl(hsotg, GNPTXFSIZ);
 	seq_printf(seq, "NPTXFIFO: Size %d, Start 0x%08x\n",
 		   val >> FIFOSIZE_DEPTH_SHIFT,
 		   val & FIFOSIZE_DEPTH_MASK);
@@ -218,7 +216,7 @@ static int fifo_show(struct seq_file *seq, void *v)
 	seq_puts(seq, "\nPeriodic TXFIFOs:\n");
 
 	for (idx = 1; idx < hsotg->num_of_eps; idx++) {
-		val = dwc2_readl(regs + DPTXFSIZN(idx));
+		val = dwc2_readl(hsotg, DPTXFSIZN(idx));
 
 		seq_printf(seq, "\tDPTXFIFO%2d: Size %d, Start 0x%08x\n", idx,
 			   val >> FIFOSIZE_DEPTH_SHIFT,
@@ -259,7 +257,6 @@ static int ep_show(struct seq_file *seq, void *v)
 	struct dwc2_hsotg_ep *ep = seq->private;
 	struct dwc2_hsotg *hsotg = ep->parent;
 	struct dwc2_hsotg_req *req;
-	void __iomem *regs = hsotg->regs;
 	int index = ep->index;
 	int show_limit = 15;
 	unsigned long flags;
@@ -270,20 +267,20 @@ static int ep_show(struct seq_file *seq, void *v)
 	/* first show the register state */
 
 	seq_printf(seq, "\tDIEPCTL=0x%08x, DOEPCTL=0x%08x\n",
-		   dwc2_readl(regs + DIEPCTL(index)),
-		   dwc2_readl(regs + DOEPCTL(index)));
+		   dwc2_readl(hsotg, DIEPCTL(index)),
+		   dwc2_readl(hsotg, DOEPCTL(index)));
 
 	seq_printf(seq, "\tDIEPDMA=0x%08x, DOEPDMA=0x%08x\n",
-		   dwc2_readl(regs + DIEPDMA(index)),
-		   dwc2_readl(regs + DOEPDMA(index)));
+		   dwc2_readl(hsotg, DIEPDMA(index)),
+		   dwc2_readl(hsotg, DOEPDMA(index)));
 
 	seq_printf(seq, "\tDIEPINT=0x%08x, DOEPINT=0x%08x\n",
-		   dwc2_readl(regs + DIEPINT(index)),
-		   dwc2_readl(regs + DOEPINT(index)));
+		   dwc2_readl(hsotg, DIEPINT(index)),
+		   dwc2_readl(hsotg, DOEPINT(index)));
 
 	seq_printf(seq, "\tDIEPTSIZ=0x%08x, DOEPTSIZ=0x%08x\n",
-		   dwc2_readl(regs + DIEPTSIZ(index)),
-		   dwc2_readl(regs + DOEPTSIZ(index)));
+		   dwc2_readl(hsotg, DIEPTSIZ(index)),
+		   dwc2_readl(hsotg, DOEPTSIZ(index)));
 
 	seq_puts(seq, "\n");
 	seq_printf(seq, "mps %d\n", ep->ep.maxpacket);
diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 4c5e300..b1fafff 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -50,14 +50,14 @@ static inline struct dwc2_hsotg *to_hsotg(struct usb_gadget *gadget)
 	return container_of(gadget, struct dwc2_hsotg, gadget);
 }
 
-static inline void __orr32(void __iomem *ptr, u32 val)
+static inline void __orr32(struct dwc2_hsotg *hsotg, ptrdiff_t ptr, u32 val)
 {
-	dwc2_writel(dwc2_readl(ptr) | val, ptr);
+	dwc2_writel(hsotg, dwc2_readl(hsotg, ptr) | val, ptr);
 }
 
-static inline void __bic32(void __iomem *ptr, u32 val)
+static inline void __bic32(struct dwc2_hsotg *hsotg, ptrdiff_t ptr, u32 val)
 {
-	dwc2_writel(dwc2_readl(ptr) & ~val, ptr);
+	dwc2_writel(hsotg, dwc2_readl(hsotg, ptr) & ~val, ptr);
 }
 
 static inline struct dwc2_hsotg_ep *index_to_ep(struct dwc2_hsotg *hsotg,
@@ -103,14 +103,14 @@ static inline bool using_dma(struct dwc2_hsotg *hsotg)
  */
 static void dwc2_hsotg_en_gsint(struct dwc2_hsotg *hsotg, u32 ints)
 {
-	u32 gsintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+	u32 gsintmsk = dwc2_readl(hsotg, GINTMSK);
 	u32 new_gsintmsk;
 
 	new_gsintmsk = gsintmsk | ints;
 
 	if (new_gsintmsk != gsintmsk) {
 		dev_dbg(hsotg->dev, "gsintmsk now 0x%08x\n", new_gsintmsk);
-		dwc2_writel(new_gsintmsk, hsotg->regs + GINTMSK);
+		dwc2_writel(hsotg, new_gsintmsk, GINTMSK);
 	}
 }
 
@@ -121,13 +121,13 @@ static void dwc2_hsotg_en_gsint(struct dwc2_hsotg *hsotg, u32 ints)
  */
 static void dwc2_hsotg_disable_gsint(struct dwc2_hsotg *hsotg, u32 ints)
 {
-	u32 gsintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+	u32 gsintmsk = dwc2_readl(hsotg, GINTMSK);
 	u32 new_gsintmsk;
 
 	new_gsintmsk = gsintmsk & ~ints;
 
 	if (new_gsintmsk != gsintmsk)
-		dwc2_writel(new_gsintmsk, hsotg->regs + GINTMSK);
+		dwc2_writel(hsotg, new_gsintmsk, GINTMSK);
 }
 
 /**
@@ -152,12 +152,12 @@ static void dwc2_hsotg_ctrl_epint(struct dwc2_hsotg *hsotg,
 		bit <<= 16;
 
 	local_irq_save(flags);
-	daint = dwc2_readl(hsotg->regs + DAINTMSK);
+	daint = dwc2_readl(hsotg, DAINTMSK);
 	if (en)
 		daint |= bit;
 	else
 		daint &= ~bit;
-	dwc2_writel(daint, hsotg->regs + DAINTMSK);
+	dwc2_writel(hsotg, daint, DAINTMSK);
 	local_irq_restore(flags);
 }
 
@@ -177,10 +177,10 @@ static void dwc2_hsotg_init_fifo(struct dwc2_hsotg *hsotg)
 	hsotg->fifo_map = 0;
 
 	/* set RX/NPTX FIFO sizes */
-	dwc2_writel(hsotg->g_rx_fifo_sz, hsotg->regs + GRXFSIZ);
-	dwc2_writel((hsotg->g_rx_fifo_sz << FIFOSIZE_STARTADDR_SHIFT) |
-		(hsotg->g_np_g_tx_fifo_sz << FIFOSIZE_DEPTH_SHIFT),
-		hsotg->regs + GNPTXFSIZ);
+	dwc2_writel(hsotg, hsotg->g_rx_fifo_sz, GRXFSIZ);
+	dwc2_writel(hsotg,
+		    (hsotg->g_rx_fifo_sz << FIFOSIZE_STARTADDR_SHIFT) | (hsotg->g_np_g_tx_fifo_sz << FIFOSIZE_DEPTH_SHIFT),
+		    GNPTXFSIZ);
 
 	/*
 	 * arange all the rest of the TX FIFOs, as some versions of this
@@ -206,7 +206,7 @@ static void dwc2_hsotg_init_fifo(struct dwc2_hsotg *hsotg)
 			  "insufficient fifo memory");
 		addr += hsotg->g_tx_fifo_sz[ep];
 
-		dwc2_writel(val, hsotg->regs + DPTXFSIZN(ep));
+		dwc2_writel(hsotg, val, DPTXFSIZN(ep));
 	}
 
 	/*
@@ -214,13 +214,14 @@ static void dwc2_hsotg_init_fifo(struct dwc2_hsotg *hsotg)
 	 * all fifos are flushed before continuing
 	 */
 
-	dwc2_writel(GRSTCTL_TXFNUM(0x10) | GRSTCTL_TXFFLSH |
-	       GRSTCTL_RXFFLSH, hsotg->regs + GRSTCTL);
+	dwc2_writel(hsotg,
+		    GRSTCTL_TXFNUM(0x10) | GRSTCTL_TXFFLSH | GRSTCTL_RXFFLSH,
+		    GRSTCTL);
 
 	/* wait until the fifos are both flushed */
 	timeout = 100;
 	while (1) {
-		val = dwc2_readl(hsotg->regs + GRSTCTL);
+		val = dwc2_readl(hsotg, GRSTCTL);
 
 		if ((val & (GRSTCTL_TXFFLSH | GRSTCTL_RXFFLSH)) == 0)
 			break;
@@ -313,7 +314,7 @@ static int dwc2_hsotg_write_fifo(struct dwc2_hsotg *hsotg,
 				struct dwc2_hsotg_req *hs_req)
 {
 	bool periodic = is_ep_periodic(hs_ep);
-	u32 gnptxsts = dwc2_readl(hsotg->regs + GNPTXSTS);
+	u32 gnptxsts = dwc2_readl(hsotg, GNPTXSTS);
 	int buf_pos = hs_req->req.actual;
 	int to_write = hs_ep->size_loaded;
 	void *data;
@@ -328,7 +329,7 @@ static int dwc2_hsotg_write_fifo(struct dwc2_hsotg *hsotg,
 		return 0;
 
 	if (periodic && !hsotg->dedicated_fifos) {
-		u32 epsize = dwc2_readl(hsotg->regs + DIEPTSIZ(hs_ep->index));
+		u32 epsize = dwc2_readl(hsotg, DIEPTSIZ(hs_ep->index));
 		int size_left;
 		int size_done;
 
@@ -369,7 +370,7 @@ static int dwc2_hsotg_write_fifo(struct dwc2_hsotg *hsotg,
 			return -ENOSPC;
 		}
 	} else if (hsotg->dedicated_fifos && hs_ep->index != 0) {
-		can_write = dwc2_readl(hsotg->regs + DTXFSTS(hs_ep->index));
+		can_write = dwc2_readl(hsotg, DTXFSTS(hs_ep->index));
 
 		can_write &= 0xffff;
 		can_write *= 4;
@@ -546,11 +547,11 @@ static void dwc2_hsotg_start_req(struct dwc2_hsotg *hsotg,
 	epsize_reg = dir_in ? DIEPTSIZ(index) : DOEPTSIZ(index);
 
 	dev_dbg(hsotg->dev, "%s: DxEPCTL=0x%08x, ep %d, dir %s\n",
-		__func__, dwc2_readl(hsotg->regs + epctrl_reg), index,
+		__func__, dwc2_readl(hsotg, epctrl_reg), index,
 		hs_ep->dir_in ? "in" : "out");
 
 	/* If endpoint is stalled, we will restart request later */
-	ctrl = dwc2_readl(hsotg->regs + epctrl_reg);
+	ctrl = dwc2_readl(hsotg, epctrl_reg);
 
 	if (index && ctrl & DXEPCTL_STALL) {
 		dev_warn(hsotg->dev, "%s: ep%d is stalled\n", __func__, index);
@@ -614,7 +615,7 @@ static void dwc2_hsotg_start_req(struct dwc2_hsotg *hsotg,
 	hs_ep->req = hs_req;
 
 	/* write size / packets */
-	dwc2_writel(epsize, hsotg->regs + epsize_reg);
+	dwc2_writel(hsotg, epsize, epsize_reg);
 
 	if (using_dma(hsotg) && !continuing) {
 		unsigned int dma_reg;
@@ -625,7 +626,7 @@ static void dwc2_hsotg_start_req(struct dwc2_hsotg *hsotg,
 		 */
 
 		dma_reg = dir_in ? DIEPDMA(index) : DOEPDMA(index);
-		dwc2_writel(ureq->dma, hsotg->regs + dma_reg);
+		dwc2_writel(hsotg, ureq->dma, dma_reg);
 
 		dev_dbg(hsotg->dev, "%s: %pad => 0x%08x\n",
 			__func__, &ureq->dma, dma_reg);
@@ -641,7 +642,7 @@ static void dwc2_hsotg_start_req(struct dwc2_hsotg *hsotg,
 		ctrl |= DXEPCTL_CNAK;	/* clear NAK set by core */
 
 	dev_dbg(hsotg->dev, "%s: DxEPCTL=0x%08x\n", __func__, ctrl);
-	dwc2_writel(ctrl, hsotg->regs + epctrl_reg);
+	dwc2_writel(hsotg, ctrl, epctrl_reg);
 
 	/*
 	 * set these, it seems that DMA support increments past the end
@@ -663,8 +664,7 @@ static void dwc2_hsotg_start_req(struct dwc2_hsotg *hsotg,
 	 * to debugging to see what is going on.
 	 */
 	if (dir_in)
-		dwc2_writel(DIEPMSK_INTKNTXFEMPMSK,
-		       hsotg->regs + DIEPINT(index));
+		dwc2_writel(hsotg, DIEPMSK_INTKNTXFEMPMSK, DIEPINT(index));
 
 	/*
 	 * Note, trying to clear the NAK here causes problems with transmit
@@ -672,13 +672,13 @@ static void dwc2_hsotg_start_req(struct dwc2_hsotg *hsotg,
 	 */
 
 	/* check ep is enabled */
-	if (!(dwc2_readl(hsotg->regs + epctrl_reg) & DXEPCTL_EPENA))
+	if (!(dwc2_readl(hsotg, epctrl_reg) & DXEPCTL_EPENA))
 		dev_dbg(hsotg->dev,
 			 "ep%d: failed to become enabled (DXEPCTL=0x%08x)?\n",
-			 index, dwc2_readl(hsotg->regs + epctrl_reg));
+			 index, dwc2_readl(hsotg, epctrl_reg));
 
 	dev_dbg(hsotg->dev, "%s: DXEPCTL=0x%08x\n",
-		__func__, dwc2_readl(hsotg->regs + epctrl_reg));
+		__func__, dwc2_readl(hsotg, epctrl_reg));
 
 	/* enable ep interrupts */
 	dwc2_hsotg_ctrl_epint(hsotg, hs_ep->index, hs_ep->dir_in, 1);
@@ -897,7 +897,7 @@ static struct dwc2_hsotg_ep *ep_from_windex(struct dwc2_hsotg *hsotg,
  */
 int dwc2_hsotg_set_test_mode(struct dwc2_hsotg *hsotg, int testmode)
 {
-	int dctl = dwc2_readl(hsotg->regs + DCTL);
+	int dctl = dwc2_readl(hsotg, DCTL);
 
 	dctl &= ~DCTL_TSTCTL_MASK;
 	switch (testmode) {
@@ -911,7 +911,7 @@ int dwc2_hsotg_set_test_mode(struct dwc2_hsotg *hsotg, int testmode)
 	default:
 		return -EINVAL;
 	}
-	dwc2_writel(dctl, hsotg->regs + DCTL);
+	dwc2_writel(hsotg, dctl, DCTL);
 	return 0;
 }
 
@@ -1170,14 +1170,14 @@ static void dwc2_hsotg_stall_ep0(struct dwc2_hsotg *hsotg)
 	 * taken effect, so no need to clear later.
 	 */
 
-	ctrl = dwc2_readl(hsotg->regs + reg);
+	ctrl = dwc2_readl(hsotg, reg);
 	ctrl |= DXEPCTL_STALL;
 	ctrl |= DXEPCTL_CNAK;
-	dwc2_writel(ctrl, hsotg->regs + reg);
+	dwc2_writel(hsotg, ctrl, reg);
 
 	dev_dbg(hsotg->dev,
 		"written DXEPCTL=0x%08x to %08x (DXEPCTL=0x%08x)\n",
-		ctrl, reg, dwc2_readl(hsotg->regs + reg));
+		ctrl, reg, dwc2_readl(hsotg, reg));
 
 	 /*
 	  * complete won't be called, so we enqueue
@@ -1222,11 +1222,11 @@ static void dwc2_hsotg_process_control(struct dwc2_hsotg *hsotg,
 		switch (ctrl->bRequest) {
 		case USB_REQ_SET_ADDRESS:
 			hsotg->connected = 1;
-			dcfg = dwc2_readl(hsotg->regs + DCFG);
+			dcfg = dwc2_readl(hsotg, DCFG);
 			dcfg &= ~DCFG_DEVADDR_MASK;
 			dcfg |= (le16_to_cpu(ctrl->wValue) <<
 				 DCFG_DEVADDR_SHIFT) & DCFG_DEVADDR_MASK;
-			dwc2_writel(dcfg, hsotg->regs + DCFG);
+			dwc2_writel(hsotg, dcfg, DCFG);
 
 			dev_info(hsotg->dev, "new address %d\n", ctrl->wValue);
 
@@ -1344,15 +1344,15 @@ static void dwc2_hsotg_program_zlp(struct dwc2_hsotg *hsotg,
 		dev_dbg(hsotg->dev, "Receiving zero-length packet on ep%d\n",
 									index);
 
-	dwc2_writel(DXEPTSIZ_MC(1) | DXEPTSIZ_PKTCNT(1) |
-		    DXEPTSIZ_XFERSIZE(0), hsotg->regs +
+	dwc2_writel(hsotg,
+		    DXEPTSIZ_MC(1) | DXEPTSIZ_PKTCNT(1) | DXEPTSIZ_XFERSIZE(0),
 		    epsiz_reg);
 
-	ctrl = dwc2_readl(hsotg->regs + epctl_reg);
+	ctrl = dwc2_readl(hsotg, epctl_reg);
 	ctrl |= DXEPCTL_CNAK;  /* clear NAK set by core */
 	ctrl |= DXEPCTL_EPENA; /* ensure ep enabled */
 	ctrl |= DXEPCTL_USBACTEP;
-	dwc2_writel(ctrl, hsotg->regs + epctl_reg);
+	dwc2_writel(hsotg, ctrl, epctl_reg);
 }
 
 /**
@@ -1446,7 +1446,7 @@ static void dwc2_hsotg_rx_data(struct dwc2_hsotg *hsotg, int ep_idx, int size)
 
 
 	if (!hs_req) {
-		u32 epctl = dwc2_readl(hsotg->regs + DOEPCTL(ep_idx));
+		u32 epctl = dwc2_readl(hsotg, DOEPCTL(ep_idx));
 		int ptr;
 
 		dev_dbg(hsotg->dev,
@@ -1455,7 +1455,7 @@ static void dwc2_hsotg_rx_data(struct dwc2_hsotg *hsotg, int ep_idx, int size)
 
 		/* dump the data from the FIFO, we've nothing we can do */
 		for (ptr = 0; ptr < size; ptr += 4)
-			(void)dwc2_readl(fifo);
+			(void)dwc2_readl(hsotg, EPFIFO(ep_idx));
 
 		return;
 	}
@@ -1514,12 +1514,12 @@ static void dwc2_hsotg_change_ep_iso_parity(struct dwc2_hsotg *hsotg,
 {
 	u32 ctrl;
 
-	ctrl = dwc2_readl(hsotg->regs + epctl_reg);
+	ctrl = dwc2_readl(hsotg, epctl_reg);
 	if (ctrl & DXEPCTL_EOFRNUM)
 		ctrl |= DXEPCTL_SETEVENFR;
 	else
 		ctrl |= DXEPCTL_SETODDFR;
-	dwc2_writel(ctrl, hsotg->regs + epctl_reg);
+	dwc2_writel(hsotg, ctrl, epctl_reg);
 }
 
 /**
@@ -1533,7 +1533,7 @@ static void dwc2_hsotg_change_ep_iso_parity(struct dwc2_hsotg *hsotg,
  */
 static void dwc2_hsotg_handle_outdone(struct dwc2_hsotg *hsotg, int epnum)
 {
-	u32 epsize = dwc2_readl(hsotg->regs + DOEPTSIZ(epnum));
+	u32 epsize = dwc2_readl(hsotg, DOEPTSIZ(epnum));
 	struct dwc2_hsotg_ep *hs_ep = hsotg->eps_out[epnum];
 	struct dwc2_hsotg_req *hs_req = hs_ep->req;
 	struct usb_request *req = &hs_req->req;
@@ -1615,7 +1615,7 @@ static u32 dwc2_hsotg_read_frameno(struct dwc2_hsotg *hsotg)
 {
 	u32 dsts;
 
-	dsts = dwc2_readl(hsotg->regs + DSTS);
+	dsts = dwc2_readl(hsotg, DSTS);
 	dsts &= DSTS_SOFFN_MASK;
 	dsts >>= DSTS_SOFFN_SHIFT;
 
@@ -1640,7 +1640,7 @@ static u32 dwc2_hsotg_read_frameno(struct dwc2_hsotg *hsotg)
  */
 static void dwc2_hsotg_handle_rx(struct dwc2_hsotg *hsotg)
 {
-	u32 grxstsr = dwc2_readl(hsotg->regs + GRXSTSP);
+	u32 grxstsr = dwc2_readl(hsotg, GRXSTSP);
 	u32 epnum, status, size;
 
 	WARN_ON(using_dma(hsotg));
@@ -1671,7 +1671,7 @@ static void dwc2_hsotg_handle_rx(struct dwc2_hsotg *hsotg)
 		dev_dbg(hsotg->dev,
 			"SetupDone (Frame=0x%08x, DOPEPCTL=0x%08x)\n",
 			dwc2_hsotg_read_frameno(hsotg),
-			dwc2_readl(hsotg->regs + DOEPCTL(0)));
+			dwc2_readl(hsotg, DOEPCTL(0)));
 		/*
 		 * Call dwc2_hsotg_handle_outdone here if it was not called from
 		 * GRXSTS_PKTSTS_OUTDONE. That is, if the core didn't
@@ -1689,7 +1689,7 @@ static void dwc2_hsotg_handle_rx(struct dwc2_hsotg *hsotg)
 		dev_dbg(hsotg->dev,
 			"SetupRX (Frame=0x%08x, DOPEPCTL=0x%08x)\n",
 			dwc2_hsotg_read_frameno(hsotg),
-			dwc2_readl(hsotg->regs + DOEPCTL(0)));
+			dwc2_readl(hsotg, DOEPCTL(0)));
 
 		WARN_ON(hsotg->ep0_state != DWC2_EP0_SETUP);
 
@@ -1740,7 +1740,6 @@ static void dwc2_hsotg_set_ep_maxpacket(struct dwc2_hsotg *hsotg,
 			unsigned int ep, unsigned int mps, unsigned int dir_in)
 {
 	struct dwc2_hsotg_ep *hs_ep;
-	void __iomem *regs = hsotg->regs;
 	u32 mpsval;
 	u32 mcval;
 	u32 reg;
@@ -1768,15 +1767,15 @@ static void dwc2_hsotg_set_ep_maxpacket(struct dwc2_hsotg *hsotg,
 	}
 
 	if (dir_in) {
-		reg = dwc2_readl(regs + DIEPCTL(ep));
+		reg = dwc2_readl(hsotg, DIEPCTL(ep));
 		reg &= ~DXEPCTL_MPS_MASK;
 		reg |= mpsval;
-		dwc2_writel(reg, regs + DIEPCTL(ep));
+		dwc2_writel(hsotg, reg, DIEPCTL(ep));
 	} else {
-		reg = dwc2_readl(regs + DOEPCTL(ep));
+		reg = dwc2_readl(hsotg, DOEPCTL(ep));
 		reg &= ~DXEPCTL_MPS_MASK;
 		reg |= mpsval;
-		dwc2_writel(reg, regs + DOEPCTL(ep));
+		dwc2_writel(hsotg, reg, DOEPCTL(ep));
 	}
 
 	return;
@@ -1795,14 +1794,13 @@ static void dwc2_hsotg_txfifo_flush(struct dwc2_hsotg *hsotg, unsigned int idx)
 	int timeout;
 	int val;
 
-	dwc2_writel(GRSTCTL_TXFNUM(idx) | GRSTCTL_TXFFLSH,
-		    hsotg->regs + GRSTCTL);
+	dwc2_writel(hsotg, GRSTCTL_TXFNUM(idx) | GRSTCTL_TXFFLSH, GRSTCTL);
 
 	/* wait until the fifo is flushed */
 	timeout = 100;
 
 	while (1) {
-		val = dwc2_readl(hsotg->regs + GRSTCTL);
+		val = dwc2_readl(hsotg, GRSTCTL);
 
 		if ((val & (GRSTCTL_TXFFLSH)) == 0)
 			break;
@@ -1863,7 +1861,7 @@ static void dwc2_hsotg_complete_in(struct dwc2_hsotg *hsotg,
 				  struct dwc2_hsotg_ep *hs_ep)
 {
 	struct dwc2_hsotg_req *hs_req = hs_ep->req;
-	u32 epsize = dwc2_readl(hsotg->regs + DIEPTSIZ(hs_ep->index));
+	u32 epsize = dwc2_readl(hsotg, DIEPTSIZ(hs_ep->index));
 	int size_left, size_done;
 
 	if (!hs_req) {
@@ -1954,11 +1952,11 @@ static void dwc2_hsotg_epint(struct dwc2_hsotg *hsotg, unsigned int idx,
 	u32 ints;
 	u32 ctrl;
 
-	ints = dwc2_readl(hsotg->regs + epint_reg);
-	ctrl = dwc2_readl(hsotg->regs + epctl_reg);
+	ints = dwc2_readl(hsotg, epint_reg);
+	ctrl = dwc2_readl(hsotg, epctl_reg);
 
 	/* Clear endpoint interrupts */
-	dwc2_writel(ints, hsotg->regs + epint_reg);
+	dwc2_writel(hsotg, ints, epint_reg);
 
 	if (!hs_ep) {
 		dev_err(hsotg->dev, "%s:Interrupt for unconfigured ep%d(%s)\n",
@@ -1980,8 +1978,8 @@ static void dwc2_hsotg_epint(struct dwc2_hsotg *hsotg, unsigned int idx,
 
 		dev_dbg(hsotg->dev,
 			"%s: XferCompl: DxEPCTL=0x%08x, DXEPTSIZ=%08x\n",
-			__func__, dwc2_readl(hsotg->regs + epctl_reg),
-			dwc2_readl(hsotg->regs + epsiz_reg));
+			__func__, dwc2_readl(hsotg, epctl_reg),
+			dwc2_readl(hsotg, epsiz_reg));
 
 		/*
 		 * we get OutDone from the FIFO, so we only need to look
@@ -2006,16 +2004,16 @@ static void dwc2_hsotg_epint(struct dwc2_hsotg *hsotg, unsigned int idx,
 		dev_dbg(hsotg->dev, "%s: EPDisbld\n", __func__);
 
 		if (dir_in) {
-			int epctl = dwc2_readl(hsotg->regs + epctl_reg);
+			int epctl = dwc2_readl(hsotg, epctl_reg);
 
 			dwc2_hsotg_txfifo_flush(hsotg, hs_ep->fifo_index);
 
 			if ((epctl & DXEPCTL_STALL) &&
 				(epctl & DXEPCTL_EPTYPE_BULK)) {
-				int dctl = dwc2_readl(hsotg->regs + DCTL);
+				int dctl = dwc2_readl(hsotg, DCTL);
 
 				dctl |= DCTL_CGNPINNAK;
-				dwc2_writel(dctl, hsotg->regs + DCTL);
+				dwc2_writel(hsotg, dctl, DCTL);
 			}
 		}
 	}
@@ -2077,7 +2075,7 @@ static void dwc2_hsotg_epint(struct dwc2_hsotg *hsotg, unsigned int idx,
  */
 static void dwc2_hsotg_irq_enumdone(struct dwc2_hsotg *hsotg)
 {
-	u32 dsts = dwc2_readl(hsotg->regs + DSTS);
+	u32 dsts = dwc2_readl(hsotg, DSTS);
 	int ep0_mps = 0, ep_mps = 8;
 
 	/*
@@ -2144,8 +2142,8 @@ static void dwc2_hsotg_irq_enumdone(struct dwc2_hsotg *hsotg)
 	dwc2_hsotg_enqueue_setup(hsotg);
 
 	dev_dbg(hsotg->dev, "EP0: DIEPCTL0=0x%08x, DOEPCTL0=0x%08x\n",
-		dwc2_readl(hsotg->regs + DIEPCTL0),
-		dwc2_readl(hsotg->regs + DOEPCTL0));
+		dwc2_readl(hsotg, DIEPCTL0),
+		dwc2_readl(hsotg, DOEPCTL0));
 }
 
 /**
@@ -2172,7 +2170,7 @@ static void kill_all_requests(struct dwc2_hsotg *hsotg,
 
 	if (!hsotg->dedicated_fifos)
 		return;
-	size = (dwc2_readl(hsotg->regs + DTXFSTS(ep->index)) & 0xffff) * 4;
+	size = (dwc2_readl(hsotg, DTXFSTS(ep->index)) & 0xffff) * 4;
 	if (size < ep->fifo_size)
 		dwc2_hsotg_txfifo_flush(hsotg, ep->fifo_index);
 }
@@ -2269,7 +2267,7 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 	 */
 
 	/* keep other bits untouched (so e.g. forced modes are not lost) */
-	usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+	usbcfg = dwc2_readl(hsotg, GUSBCFG);
 	usbcfg &= ~(GUSBCFG_TOUTCAL_MASK | GUSBCFG_PHYIF16 | GUSBCFG_SRPCAP |
 		GUSBCFG_HNPCAP);
 
@@ -2277,20 +2275,20 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 	val = (hsotg->phyif == GUSBCFG_PHYIF8) ? 9 : 5;
 	usbcfg |= hsotg->phyif | GUSBCFG_TOUTCAL(7) |
 		(val << GUSBCFG_USBTRDTIM_SHIFT);
-	dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+	dwc2_writel(hsotg, usbcfg, GUSBCFG);
 
 	dwc2_hsotg_init_fifo(hsotg);
 
 	if (!is_usb_reset)
-		__orr32(hsotg->regs + DCTL, DCTL_SFTDISCON);
+		__orr32(hsotg, DCTL, DCTL_SFTDISCON);
 
-	dwc2_writel(DCFG_EPMISCNT(1) | DCFG_DEVSPD_HS,  hsotg->regs + DCFG);
+	dwc2_writel(hsotg, DCFG_EPMISCNT(1) | DCFG_DEVSPD_HS, DCFG);
 
 	/* Clear any pending OTG interrupts */
-	dwc2_writel(0xffffffff, hsotg->regs + GOTGINT);
+	dwc2_writel(hsotg, 0xffffffff, GOTGINT);
 
 	/* Clear any pending interrupts */
-	dwc2_writel(0xffffffff, hsotg->regs + GINTSTS);
+	dwc2_writel(hsotg, 0xffffffff, GINTSTS);
 	intmsk = GINTSTS_ERLYSUSP | GINTSTS_SESSREQINT |
 		GINTSTS_GOUTNAKEFF | GINTSTS_GINNAKEFF |
 		GINTSTS_USBRST | GINTSTS_RESETDET |
@@ -2301,17 +2299,16 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 	if (hsotg->core_params->external_id_pin_ctl <= 0)
 		intmsk |= GINTSTS_CONIDSTSCHNG;
 
-	dwc2_writel(intmsk, hsotg->regs + GINTMSK);
+	dwc2_writel(hsotg, intmsk, GINTMSK);
 
 	if (using_dma(hsotg))
-		dwc2_writel(GAHBCFG_GLBL_INTR_EN | GAHBCFG_DMA_EN |
-			    (GAHBCFG_HBSTLEN_INCR4 << GAHBCFG_HBSTLEN_SHIFT),
-			    hsotg->regs + GAHBCFG);
+		dwc2_writel(hsotg,
+			    GAHBCFG_GLBL_INTR_EN | GAHBCFG_DMA_EN | (GAHBCFG_HBSTLEN_INCR4 << GAHBCFG_HBSTLEN_SHIFT),
+			    GAHBCFG);
 	else
-		dwc2_writel(((hsotg->dedicated_fifos) ?
-						(GAHBCFG_NP_TXF_EMP_LVL |
-						 GAHBCFG_P_TXF_EMP_LVL) : 0) |
-			    GAHBCFG_GLBL_INTR_EN, hsotg->regs + GAHBCFG);
+		dwc2_writel(hsotg,
+			    ((hsotg->dedicated_fifos) ? (GAHBCFG_NP_TXF_EMP_LVL | GAHBCFG_P_TXF_EMP_LVL) : 0) | GAHBCFG_GLBL_INTR_EN,
+			    GAHBCFG);
 
 	/*
 	 * If INTknTXFEmpMsk is enabled, it's important to disable ep interrupts
@@ -2319,28 +2316,23 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 	 * interrupts.
 	 */
 
-	dwc2_writel(((hsotg->dedicated_fifos && !using_dma(hsotg)) ?
-		DIEPMSK_TXFIFOEMPTY | DIEPMSK_INTKNTXFEMPMSK : 0) |
-		DIEPMSK_EPDISBLDMSK | DIEPMSK_XFERCOMPLMSK |
-		DIEPMSK_TIMEOUTMSK | DIEPMSK_AHBERRMSK |
-		DIEPMSK_INTKNEPMISMSK,
-		hsotg->regs + DIEPMSK);
+	dwc2_writel(hsotg,
+		    ((hsotg->dedicated_fifos && !using_dma(hsotg)) ? DIEPMSK_TXFIFOEMPTY | DIEPMSK_INTKNTXFEMPMSK : 0) | DIEPMSK_EPDISBLDMSK | DIEPMSK_XFERCOMPLMSK | DIEPMSK_TIMEOUTMSK | DIEPMSK_AHBERRMSK | DIEPMSK_INTKNEPMISMSK,
+		    DIEPMSK);
 
 	/*
 	 * don't need XferCompl, we get that from RXFIFO in slave mode. In
 	 * DMA mode we may need this.
 	 */
-	dwc2_writel((using_dma(hsotg) ? (DIEPMSK_XFERCOMPLMSK |
-				    DIEPMSK_TIMEOUTMSK) : 0) |
-		DOEPMSK_EPDISBLDMSK | DOEPMSK_AHBERRMSK |
-		DOEPMSK_SETUPMSK,
-		hsotg->regs + DOEPMSK);
+	dwc2_writel(hsotg,
+		    (using_dma(hsotg) ? (DIEPMSK_XFERCOMPLMSK | DIEPMSK_TIMEOUTMSK) : 0) | DOEPMSK_EPDISBLDMSK | DOEPMSK_AHBERRMSK | DOEPMSK_SETUPMSK,
+		    DOEPMSK);
 
-	dwc2_writel(0, hsotg->regs + DAINTMSK);
+	dwc2_writel(hsotg, 0, DAINTMSK);
 
 	dev_dbg(hsotg->dev, "EP0: DIEPCTL0=0x%08x, DOEPCTL0=0x%08x\n",
-		dwc2_readl(hsotg->regs + DIEPCTL0),
-		dwc2_readl(hsotg->regs + DOEPCTL0));
+		dwc2_readl(hsotg, DIEPCTL0),
+		dwc2_readl(hsotg, DOEPCTL0));
 
 	/* enable in and out endpoint interrupts */
 	dwc2_hsotg_en_gsint(hsotg, GINTSTS_OEPINT | GINTSTS_IEPINT);
@@ -2358,12 +2350,12 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 	dwc2_hsotg_ctrl_epint(hsotg, 0, 1, 1);
 
 	if (!is_usb_reset) {
-		__orr32(hsotg->regs + DCTL, DCTL_PWRONPRGDONE);
+		__orr32(hsotg, DCTL, DCTL_PWRONPRGDONE);
 		udelay(10);  /* see openiboot */
-		__bic32(hsotg->regs + DCTL, DCTL_PWRONPRGDONE);
+		__bic32(hsotg, DCTL, DCTL_PWRONPRGDONE);
 	}
 
-	dev_dbg(hsotg->dev, "DCTL=0x%08x\n", dwc2_readl(hsotg->regs + DCTL));
+	dev_dbg(hsotg->dev, "DCTL=0x%08x\n", dwc2_readl(hsotg, DCTL));
 
 	/*
 	 * DxEPCTL_USBActEp says RO in manual, but seems to be set by
@@ -2371,29 +2363,30 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 	 */
 
 	/* set to read 1 8byte packet */
-	dwc2_writel(DXEPTSIZ_MC(1) | DXEPTSIZ_PKTCNT(1) |
-	       DXEPTSIZ_XFERSIZE(8), hsotg->regs + DOEPTSIZ0);
+	dwc2_writel(hsotg,
+		    DXEPTSIZ_MC(1) | DXEPTSIZ_PKTCNT(1) | DXEPTSIZ_XFERSIZE(8),
+		    DOEPTSIZ0);
 
-	dwc2_writel(dwc2_hsotg_ep0_mps(hsotg->eps_out[0]->ep.maxpacket) |
-	       DXEPCTL_CNAK | DXEPCTL_EPENA |
-	       DXEPCTL_USBACTEP,
-	       hsotg->regs + DOEPCTL0);
+	dwc2_writel(hsotg,
+		    dwc2_hsotg_ep0_mps(hsotg->eps_out[0]->ep.maxpacket) | DXEPCTL_CNAK | DXEPCTL_EPENA | DXEPCTL_USBACTEP,
+		    DOEPCTL0);
 
 	/* enable, but don't activate EP0in */
-	dwc2_writel(dwc2_hsotg_ep0_mps(hsotg->eps_out[0]->ep.maxpacket) |
-	       DXEPCTL_USBACTEP, hsotg->regs + DIEPCTL0);
+	dwc2_writel(hsotg,
+		    dwc2_hsotg_ep0_mps(hsotg->eps_out[0]->ep.maxpacket) | DXEPCTL_USBACTEP,
+		    DIEPCTL0);
 
 	dwc2_hsotg_enqueue_setup(hsotg);
 
 	dev_dbg(hsotg->dev, "EP0: DIEPCTL0=0x%08x, DOEPCTL0=0x%08x\n",
-		dwc2_readl(hsotg->regs + DIEPCTL0),
-		dwc2_readl(hsotg->regs + DOEPCTL0));
+		dwc2_readl(hsotg, DIEPCTL0),
+		dwc2_readl(hsotg, DOEPCTL0));
 
 	/* clear global NAKs */
 	val = DCTL_CGOUTNAK | DCTL_CGNPINNAK;
 	if (!is_usb_reset)
 		val |= DCTL_SFTDISCON;
-	__orr32(hsotg->regs + DCTL, val);
+	__orr32(hsotg, DCTL, val);
 
 	/* must be at-least 3ms to allow bus to see disconnect */
 	mdelay(3);
@@ -2404,13 +2397,13 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 static void dwc2_hsotg_core_disconnect(struct dwc2_hsotg *hsotg)
 {
 	/* set the soft-disconnect bit */
-	__orr32(hsotg->regs + DCTL, DCTL_SFTDISCON);
+	__orr32(hsotg, DCTL, DCTL_SFTDISCON);
 }
 
 void dwc2_hsotg_core_connect(struct dwc2_hsotg *hsotg)
 {
 	/* remove the soft-disconnect and let's go */
-	__bic32(hsotg->regs + DCTL, DCTL_SFTDISCON);
+	__bic32(hsotg, DCTL, DCTL_SFTDISCON);
 }
 
 /**
@@ -2430,8 +2423,8 @@ static irqreturn_t dwc2_hsotg_irq(int irq, void *pw)
 
 	spin_lock(&hsotg->lock);
 irq_retry:
-	gintsts = dwc2_readl(hsotg->regs + GINTSTS);
-	gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+	gintsts = dwc2_readl(hsotg, GINTSTS);
+	gintmsk = dwc2_readl(hsotg, GINTMSK);
 
 	dev_dbg(hsotg->dev, "%s: %08x %08x (%08x) retry %d\n",
 		__func__, gintsts, gintsts & gintmsk, gintmsk, retry_count);
@@ -2441,7 +2434,7 @@ irq_retry:
 	if (gintsts & GINTSTS_RESETDET) {
 		dev_dbg(hsotg->dev, "%s: USBRstDet\n", __func__);
 
-		dwc2_writel(GINTSTS_RESETDET, hsotg->regs + GINTSTS);
+		dwc2_writel(hsotg, GINTSTS_RESETDET, GINTSTS);
 
 		/* This event must be used only if controller is suspended */
 		if (hsotg->lx_state == DWC2_L2) {
@@ -2452,14 +2445,14 @@ irq_retry:
 
 	if (gintsts & (GINTSTS_USBRST | GINTSTS_RESETDET)) {
 
-		u32 usb_status = dwc2_readl(hsotg->regs + GOTGCTL);
+		u32 usb_status = dwc2_readl(hsotg, GOTGCTL);
 		u32 connected = hsotg->connected;
 
 		dev_dbg(hsotg->dev, "%s: USBRst\n", __func__);
 		dev_dbg(hsotg->dev, "GNPTXSTS=%08x\n",
-			dwc2_readl(hsotg->regs + GNPTXSTS));
+			dwc2_readl(hsotg, GNPTXSTS));
 
-		dwc2_writel(GINTSTS_USBRST, hsotg->regs + GINTSTS);
+		dwc2_writel(hsotg, GINTSTS_USBRST, GINTSTS);
 
 		/* Report disconnection if it is not already done. */
 		dwc2_hsotg_disconnect(hsotg);
@@ -2469,14 +2462,14 @@ irq_retry:
 	}
 
 	if (gintsts & GINTSTS_ENUMDONE) {
-		dwc2_writel(GINTSTS_ENUMDONE, hsotg->regs + GINTSTS);
+		dwc2_writel(hsotg, GINTSTS_ENUMDONE, GINTSTS);
 
 		dwc2_hsotg_irq_enumdone(hsotg);
 	}
 
 	if (gintsts & (GINTSTS_OEPINT | GINTSTS_IEPINT)) {
-		u32 daint = dwc2_readl(hsotg->regs + DAINT);
-		u32 daintmsk = dwc2_readl(hsotg->regs + DAINTMSK);
+		u32 daint = dwc2_readl(hsotg, DAINT);
+		u32 daintmsk = dwc2_readl(hsotg, DAINTMSK);
 		u32 daint_out, daint_in;
 		int ep;
 
@@ -2535,7 +2528,7 @@ irq_retry:
 
 	if (gintsts & GINTSTS_ERLYSUSP) {
 		dev_dbg(hsotg->dev, "GINTSTS_ErlySusp\n");
-		dwc2_writel(GINTSTS_ERLYSUSP, hsotg->regs + GINTSTS);
+		dwc2_writel(hsotg, GINTSTS_ERLYSUSP, GINTSTS);
 	}
 
 	/*
@@ -2547,7 +2540,7 @@ irq_retry:
 	if (gintsts & GINTSTS_GOUTNAKEFF) {
 		dev_info(hsotg->dev, "GOUTNakEff triggered\n");
 
-		__orr32(hsotg->regs + DCTL, DCTL_CGOUTNAK);
+		__orr32(hsotg, DCTL, DCTL_CGOUTNAK);
 
 		dwc2_hsotg_dump(hsotg);
 	}
@@ -2555,7 +2548,7 @@ irq_retry:
 	if (gintsts & GINTSTS_GINNAKEFF) {
 		dev_info(hsotg->dev, "GINNakEff triggered\n");
 
-		__orr32(hsotg->regs + DCTL, DCTL_CGNPINNAK);
+		__orr32(hsotg, DCTL, DCTL_CGNPINNAK);
 
 		dwc2_hsotg_dump(hsotg);
 	}
@@ -2574,7 +2567,7 @@ irq_retry:
 			epctl_reg = DIEPCTL(idx);
 			dwc2_hsotg_change_ep_iso_parity(hsotg, epctl_reg);
 		}
-		dwc2_writel(GINTSTS_INCOMPL_SOIN, hsotg->regs + GINTSTS);
+		dwc2_writel(hsotg, GINTSTS_INCOMPL_SOIN, GINTSTS);
 	}
 
 	if (gintsts & GINTSTS_INCOMPL_SOOUT) {
@@ -2591,7 +2584,7 @@ irq_retry:
 			epctl_reg = DOEPCTL(idx);
 			dwc2_hsotg_change_ep_iso_parity(hsotg, epctl_reg);
 		}
-		dwc2_writel(GINTSTS_INCOMPL_SOOUT, hsotg->regs + GINTSTS);
+		dwc2_writel(hsotg, GINTSTS_INCOMPL_SOOUT, GINTSTS);
 	}
 
 	/*
@@ -2650,7 +2643,7 @@ static int dwc2_hsotg_ep_enable(struct usb_ep *ep,
 	/* note, we handle this here instead of dwc2_hsotg_set_ep_maxpacket */
 
 	epctrl_reg = dir_in ? DIEPCTL(index) : DOEPCTL(index);
-	epctrl = dwc2_readl(hsotg->regs + epctrl_reg);
+	epctrl = dwc2_readl(hsotg, epctrl_reg);
 
 	dev_dbg(hsotg->dev, "%s: read DxEPCTL=0x%08x from 0x%08x\n",
 		__func__, epctrl, epctrl_reg);
@@ -2735,7 +2728,7 @@ static int dwc2_hsotg_ep_enable(struct usb_ep *ep,
 		for (i = 1; i < hsotg->num_of_eps; ++i) {
 			if (hsotg->fifo_map & (1<<i))
 				continue;
-			val = dwc2_readl(hsotg->regs + DPTXFSIZN(i));
+			val = dwc2_readl(hsotg, DPTXFSIZN(i));
 			val = (val >> FIFOSIZE_DEPTH_SHIFT)*4;
 			if (val < size)
 				continue;
@@ -2764,9 +2757,9 @@ static int dwc2_hsotg_ep_enable(struct usb_ep *ep,
 	dev_dbg(hsotg->dev, "%s: write DxEPCTL=0x%08x\n",
 		__func__, epctrl);
 
-	dwc2_writel(epctrl, hsotg->regs + epctrl_reg);
+	dwc2_writel(hsotg, epctrl, epctrl_reg);
 	dev_dbg(hsotg->dev, "%s: read DxEPCTL=0x%08x\n",
-		__func__, dwc2_readl(hsotg->regs + epctrl_reg));
+		__func__, dwc2_readl(hsotg, epctrl_reg));
 
 	/* enable the endpoint interrupt */
 	dwc2_hsotg_ctrl_epint(hsotg, index, dir_in, 1);
@@ -2805,13 +2798,13 @@ static int dwc2_hsotg_ep_disable(struct usb_ep *ep)
 	hs_ep->fifo_index = 0;
 	hs_ep->fifo_size = 0;
 
-	ctrl = dwc2_readl(hsotg->regs + epctrl_reg);
+	ctrl = dwc2_readl(hsotg, epctrl_reg);
 	ctrl &= ~DXEPCTL_EPENA;
 	ctrl &= ~DXEPCTL_USBACTEP;
 	ctrl |= DXEPCTL_SNAK;
 
 	dev_dbg(hsotg->dev, "%s: DxEPCTL=0x%08x\n", __func__, ctrl);
-	dwc2_writel(ctrl, hsotg->regs + epctrl_reg);
+	dwc2_writel(hsotg, ctrl, epctrl_reg);
 
 	/* disable endpoint interrupts */
 	dwc2_hsotg_ctrl_epint(hsotg, hs_ep->index, hs_ep->dir_in, 0);
@@ -2840,13 +2833,13 @@ static bool on_list(struct dwc2_hsotg_ep *ep, struct dwc2_hsotg_req *test)
 	return false;
 }
 
-static int dwc2_hsotg_wait_bit_set(struct dwc2_hsotg *hs_otg, u32 reg,
+static int dwc2_hsotg_wait_bit_set(struct dwc2_hsotg *hsotg, u32 reg,
 							u32 bit, u32 timeout)
 {
 	u32 i;
 
 	for (i = 0; i < timeout; i++) {
-		if (dwc2_readl(hs_otg->regs + reg) & bit)
+		if (dwc2_readl(hsotg, reg) & bit)
 			return 0;
 		udelay(1);
 	}
@@ -2868,7 +2861,7 @@ static void dwc2_hsotg_ep_stop_xfr(struct dwc2_hsotg *hsotg,
 	dev_dbg(hsotg->dev, "%s: stopping transfer on %s\n", __func__,
 			hs_ep->name);
 	if (hs_ep->dir_in) {
-		__orr32(hsotg->regs + epctrl_reg, DXEPCTL_SNAK);
+		__orr32(hsotg, epctrl_reg, DXEPCTL_SNAK);
 		/* Wait for Nak effect */
 		if (dwc2_hsotg_wait_bit_set(hsotg, epint_reg,
 						DXEPINT_INEPNAKEFF, 100))
@@ -2876,9 +2869,9 @@ static void dwc2_hsotg_ep_stop_xfr(struct dwc2_hsotg *hsotg,
 				"%s: timeout DIEPINT.NAKEFF\n", __func__);
 	} else {
 		/* Clear any pending nak effect interrupt */
-		dwc2_writel(GINTSTS_GOUTNAKEFF, hsotg->regs + GINTSTS);
+		dwc2_writel(hsotg, GINTSTS_GOUTNAKEFF, GINTSTS);
 
-		__orr32(hsotg->regs + DCTL, DCTL_SGOUTNAK);
+		__orr32(hsotg, DCTL, DCTL_SGOUTNAK);
 
 		/* Wait for global nak to take effect */
 		if (dwc2_hsotg_wait_bit_set(hsotg, GINTSTS,
@@ -2888,7 +2881,7 @@ static void dwc2_hsotg_ep_stop_xfr(struct dwc2_hsotg *hsotg,
 	}
 
 	/* Disable ep */
-	__orr32(hsotg->regs + epctrl_reg, DXEPCTL_EPDIS | DXEPCTL_SNAK);
+	__orr32(hsotg, epctrl_reg, DXEPCTL_EPDIS | DXEPCTL_SNAK);
 
 	/* Wait for ep to be disabled */
 	if (dwc2_hsotg_wait_bit_set(hsotg, epint_reg, DXEPINT_EPDISBLD, 100))
@@ -2897,8 +2890,9 @@ static void dwc2_hsotg_ep_stop_xfr(struct dwc2_hsotg *hsotg,
 
 	if (hs_ep->dir_in) {
 		if (hsotg->dedicated_fifos) {
-			dwc2_writel(GRSTCTL_TXFNUM(hs_ep->fifo_index) |
-				GRSTCTL_TXFFLSH, hsotg->regs + GRSTCTL);
+			dwc2_writel(hsotg,
+				    GRSTCTL_TXFNUM(hs_ep->fifo_index) | GRSTCTL_TXFFLSH,
+				    GRSTCTL);
 			/* Wait for fifo flush */
 			if (dwc2_hsotg_wait_bit_set(hsotg, GRSTCTL,
 							GRSTCTL_TXFFLSH, 100))
@@ -2909,7 +2903,7 @@ static void dwc2_hsotg_ep_stop_xfr(struct dwc2_hsotg *hsotg,
 		/* TODO: Flush shared tx fifo */
 	} else {
 		/* Remove global NAKs */
-		__bic32(hsotg->regs + DCTL, DCTL_SGOUTNAK);
+		__bic32(hsotg, DCTL, DCTL_SGOUTNAK);
 	}
 }
 
@@ -2971,7 +2965,7 @@ static int dwc2_hsotg_ep_sethalt(struct usb_ep *ep, int value)
 
 	if (hs_ep->dir_in) {
 		epreg = DIEPCTL(index);
-		epctl = dwc2_readl(hs->regs + epreg);
+		epctl = dwc2_readl(hs, epreg);
 
 		if (value) {
 			epctl |= DXEPCTL_STALL | DXEPCTL_SNAK;
@@ -2984,11 +2978,11 @@ static int dwc2_hsotg_ep_sethalt(struct usb_ep *ep, int value)
 				xfertype == DXEPCTL_EPTYPE_INTERRUPT)
 					epctl |= DXEPCTL_SETD0PID;
 		}
-		dwc2_writel(epctl, hs->regs + epreg);
+		dwc2_writel(hs, epctl, epreg);
 	} else {
 
 		epreg = DOEPCTL(index);
-		epctl = dwc2_readl(hs->regs + epreg);
+		epctl = dwc2_readl(hs, epreg);
 
 		if (value)
 			epctl |= DXEPCTL_STALL;
@@ -2999,7 +2993,7 @@ static int dwc2_hsotg_ep_sethalt(struct usb_ep *ep, int value)
 				xfertype == DXEPCTL_EPTYPE_INTERRUPT)
 					epctl |= DXEPCTL_SETD0PID;
 		}
-		dwc2_writel(epctl, hs->regs + epreg);
+		dwc2_writel(hs, epctl, epreg);
 	}
 
 	hs_ep->halted = value;
@@ -3047,29 +3041,29 @@ static void dwc2_hsotg_init(struct dwc2_hsotg *hsotg)
 	u32 usbcfg;
 	/* unmask subset of endpoint interrupts */
 
-	dwc2_writel(DIEPMSK_TIMEOUTMSK | DIEPMSK_AHBERRMSK |
-		    DIEPMSK_EPDISBLDMSK | DIEPMSK_XFERCOMPLMSK,
-		    hsotg->regs + DIEPMSK);
+	dwc2_writel(hsotg,
+		    DIEPMSK_TIMEOUTMSK | DIEPMSK_AHBERRMSK | DIEPMSK_EPDISBLDMSK | DIEPMSK_XFERCOMPLMSK,
+		    DIEPMSK);
 
-	dwc2_writel(DOEPMSK_SETUPMSK | DOEPMSK_AHBERRMSK |
-		    DOEPMSK_EPDISBLDMSK | DOEPMSK_XFERCOMPLMSK,
-		    hsotg->regs + DOEPMSK);
+	dwc2_writel(hsotg,
+		    DOEPMSK_SETUPMSK | DOEPMSK_AHBERRMSK | DOEPMSK_EPDISBLDMSK | DOEPMSK_XFERCOMPLMSK,
+		    DOEPMSK);
 
-	dwc2_writel(0, hsotg->regs + DAINTMSK);
+	dwc2_writel(hsotg, 0, DAINTMSK);
 
 	/* Be in disconnected state until gadget is registered */
-	__orr32(hsotg->regs + DCTL, DCTL_SFTDISCON);
+	__orr32(hsotg, DCTL, DCTL_SFTDISCON);
 
 	/* setup fifos */
 
 	dev_dbg(hsotg->dev, "GRXFSIZ=0x%08x, GNPTXFSIZ=0x%08x\n",
-		dwc2_readl(hsotg->regs + GRXFSIZ),
-		dwc2_readl(hsotg->regs + GNPTXFSIZ));
+		dwc2_readl(hsotg, GRXFSIZ),
+		dwc2_readl(hsotg, GNPTXFSIZ));
 
 	dwc2_hsotg_init_fifo(hsotg);
 
 	/* keep other bits untouched (so e.g. forced modes are not lost) */
-	usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+	usbcfg = dwc2_readl(hsotg, GUSBCFG);
 	usbcfg &= ~(GUSBCFG_TOUTCAL_MASK | GUSBCFG_PHYIF16 | GUSBCFG_SRPCAP |
 		GUSBCFG_HNPCAP);
 
@@ -3077,10 +3071,10 @@ static void dwc2_hsotg_init(struct dwc2_hsotg *hsotg)
 	trdtim = (hsotg->phyif == GUSBCFG_PHYIF8) ? 9 : 5;
 	usbcfg |= hsotg->phyif | GUSBCFG_TOUTCAL(7) |
 		(trdtim << GUSBCFG_USBTRDTIM_SHIFT);
-	dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+	dwc2_writel(hsotg, usbcfg, GUSBCFG);
 
 	if (using_dma(hsotg))
-		__orr32(hsotg->regs + GAHBCFG, GAHBCFG_DMA_EN);
+		__orr32(hsotg, GAHBCFG, GAHBCFG_DMA_EN);
 }
 
 /**
@@ -3354,9 +3348,9 @@ static void dwc2_hsotg_initep(struct dwc2_hsotg *hsotg,
 	if (using_dma(hsotg)) {
 		u32 next = DXEPCTL_NEXTEP((epnum + 1) % 15);
 		if (dir_in)
-			dwc2_writel(next, hsotg->regs + DIEPCTL(epnum));
+			dwc2_writel(hsotg, next, DIEPCTL(epnum));
 		else
-			dwc2_writel(next, hsotg->regs + DOEPCTL(epnum));
+			dwc2_writel(hsotg, next, DOEPCTL(epnum));
 	}
 }
 
@@ -3428,19 +3422,19 @@ static void dwc2_hsotg_dump(struct dwc2_hsotg *hsotg)
 	int idx;
 
 	dev_info(dev, "DCFG=0x%08x, DCTL=0x%08x, DIEPMSK=%08x\n",
-		 dwc2_readl(regs + DCFG), dwc2_readl(regs + DCTL),
-		 dwc2_readl(regs + DIEPMSK));
+		 dwc2_readl(hsotg, DCFG), dwc2_readl(hsotg, DCTL),
+		 dwc2_readl(hsotg, DIEPMSK));
 
 	dev_info(dev, "GAHBCFG=0x%08x, GHWCFG1=0x%08x\n",
-		 dwc2_readl(regs + GAHBCFG), dwc2_readl(regs + GHWCFG1));
+		 dwc2_readl(hsotg, GAHBCFG), dwc2_readl(hsotg, GHWCFG1));
 
 	dev_info(dev, "GRXFSIZ=0x%08x, GNPTXFSIZ=0x%08x\n",
-		 dwc2_readl(regs + GRXFSIZ), dwc2_readl(regs + GNPTXFSIZ));
+		 dwc2_readl(hsotg, GRXFSIZ), dwc2_readl(hsotg, GNPTXFSIZ));
 
 	/* show periodic fifo settings */
 
 	for (idx = 1; idx < hsotg->num_of_eps; idx++) {
-		val = dwc2_readl(regs + DPTXFSIZN(idx));
+		val = dwc2_readl(hsotg, DPTXFSIZN(idx));
 		dev_info(dev, "DPTx[%d] FSize=%d, StAddr=0x%08x\n", idx,
 			 val >> FIFOSIZE_DEPTH_SHIFT,
 			 val & FIFOSIZE_STARTADDR_MASK);
@@ -3449,21 +3443,21 @@ static void dwc2_hsotg_dump(struct dwc2_hsotg *hsotg)
 	for (idx = 0; idx < hsotg->num_of_eps; idx++) {
 		dev_info(dev,
 			 "ep%d-in: EPCTL=0x%08x, SIZ=0x%08x, DMA=0x%08x\n", idx,
-			 dwc2_readl(regs + DIEPCTL(idx)),
-			 dwc2_readl(regs + DIEPTSIZ(idx)),
-			 dwc2_readl(regs + DIEPDMA(idx)));
+			 dwc2_readl(hsotg, DIEPCTL(idx)),
+			 dwc2_readl(hsotg, DIEPTSIZ(idx)),
+			 dwc2_readl(hsotg, DIEPDMA(idx)));
 
-		val = dwc2_readl(regs + DOEPCTL(idx));
+		val = dwc2_readl(hsotg, DOEPCTL(idx));
 		dev_info(dev,
 			 "ep%d-out: EPCTL=0x%08x, SIZ=0x%08x, DMA=0x%08x\n",
-			 idx, dwc2_readl(regs + DOEPCTL(idx)),
-			 dwc2_readl(regs + DOEPTSIZ(idx)),
-			 dwc2_readl(regs + DOEPDMA(idx)));
+			 idx, dwc2_readl(hsotg, DOEPCTL(idx)),
+			 dwc2_readl(hsotg, DOEPTSIZ(idx)),
+			 dwc2_readl(hsotg, DOEPDMA(idx)));
 
 	}
 
 	dev_info(dev, "DVBUSDIS=0x%08x, DVBUSPULSE=%08x\n",
-		 dwc2_readl(regs + DVBUSDIS), dwc2_readl(regs + DVBUSPULSE));
+		 dwc2_readl(hsotg, DVBUSDIS), dwc2_readl(hsotg, DVBUSPULSE));
 #endif
 }
 
@@ -3705,15 +3699,15 @@ int dwc2_backup_device_registers(struct dwc2_hsotg *hsotg)
 	/* Backup dev regs */
 	dr = &hsotg->dr_backup;
 
-	dr->dcfg = dwc2_readl(hsotg->regs + DCFG);
-	dr->dctl = dwc2_readl(hsotg->regs + DCTL);
-	dr->daintmsk = dwc2_readl(hsotg->regs + DAINTMSK);
-	dr->diepmsk = dwc2_readl(hsotg->regs + DIEPMSK);
-	dr->doepmsk = dwc2_readl(hsotg->regs + DOEPMSK);
+	dr->dcfg = dwc2_readl(hsotg, DCFG);
+	dr->dctl = dwc2_readl(hsotg, DCTL);
+	dr->daintmsk = dwc2_readl(hsotg, DAINTMSK);
+	dr->diepmsk = dwc2_readl(hsotg, DIEPMSK);
+	dr->doepmsk = dwc2_readl(hsotg, DOEPMSK);
 
 	for (i = 0; i < hsotg->num_of_eps; i++) {
 		/* Backup IN EPs */
-		dr->diepctl[i] = dwc2_readl(hsotg->regs + DIEPCTL(i));
+		dr->diepctl[i] = dwc2_readl(hsotg, DIEPCTL(i));
 
 		/* Ensure DATA PID is correctly configured */
 		if (dr->diepctl[i] & DXEPCTL_DPID)
@@ -3721,11 +3715,11 @@ int dwc2_backup_device_registers(struct dwc2_hsotg *hsotg)
 		else
 			dr->diepctl[i] |= DXEPCTL_SETD0PID;
 
-		dr->dieptsiz[i] = dwc2_readl(hsotg->regs + DIEPTSIZ(i));
-		dr->diepdma[i] = dwc2_readl(hsotg->regs + DIEPDMA(i));
+		dr->dieptsiz[i] = dwc2_readl(hsotg, DIEPTSIZ(i));
+		dr->diepdma[i] = dwc2_readl(hsotg, DIEPDMA(i));
 
 		/* Backup OUT EPs */
-		dr->doepctl[i] = dwc2_readl(hsotg->regs + DOEPCTL(i));
+		dr->doepctl[i] = dwc2_readl(hsotg, DOEPCTL(i));
 
 		/* Ensure DATA PID is correctly configured */
 		if (dr->doepctl[i] & DXEPCTL_DPID)
@@ -3733,8 +3727,8 @@ int dwc2_backup_device_registers(struct dwc2_hsotg *hsotg)
 		else
 			dr->doepctl[i] |= DXEPCTL_SETD0PID;
 
-		dr->doeptsiz[i] = dwc2_readl(hsotg->regs + DOEPTSIZ(i));
-		dr->doepdma[i] = dwc2_readl(hsotg->regs + DOEPDMA(i));
+		dr->doeptsiz[i] = dwc2_readl(hsotg, DOEPTSIZ(i));
+		dr->doepdma[i] = dwc2_readl(hsotg, DOEPDMA(i));
 	}
 	dr->valid = true;
 	return 0;
@@ -3764,28 +3758,28 @@ int dwc2_restore_device_registers(struct dwc2_hsotg *hsotg)
 	}
 	dr->valid = false;
 
-	dwc2_writel(dr->dcfg, hsotg->regs + DCFG);
-	dwc2_writel(dr->dctl, hsotg->regs + DCTL);
-	dwc2_writel(dr->daintmsk, hsotg->regs + DAINTMSK);
-	dwc2_writel(dr->diepmsk, hsotg->regs + DIEPMSK);
-	dwc2_writel(dr->doepmsk, hsotg->regs + DOEPMSK);
+	dwc2_writel(hsotg, dr->dcfg, DCFG);
+	dwc2_writel(hsotg, dr->dctl, DCTL);
+	dwc2_writel(hsotg, dr->daintmsk, DAINTMSK);
+	dwc2_writel(hsotg, dr->diepmsk, DIEPMSK);
+	dwc2_writel(hsotg, dr->doepmsk, DOEPMSK);
 
 	for (i = 0; i < hsotg->num_of_eps; i++) {
 		/* Restore IN EPs */
-		dwc2_writel(dr->diepctl[i], hsotg->regs + DIEPCTL(i));
-		dwc2_writel(dr->dieptsiz[i], hsotg->regs + DIEPTSIZ(i));
-		dwc2_writel(dr->diepdma[i], hsotg->regs + DIEPDMA(i));
+		dwc2_writel(hsotg, dr->diepctl[i], DIEPCTL(i));
+		dwc2_writel(hsotg, dr->dieptsiz[i], DIEPTSIZ(i));
+		dwc2_writel(hsotg, dr->diepdma[i], DIEPDMA(i));
 
 		/* Restore OUT EPs */
-		dwc2_writel(dr->doepctl[i], hsotg->regs + DOEPCTL(i));
-		dwc2_writel(dr->doeptsiz[i], hsotg->regs + DOEPTSIZ(i));
-		dwc2_writel(dr->doepdma[i], hsotg->regs + DOEPDMA(i));
+		dwc2_writel(hsotg, dr->doepctl[i], DOEPCTL(i));
+		dwc2_writel(hsotg, dr->doeptsiz[i], DOEPTSIZ(i));
+		dwc2_writel(hsotg, dr->doepdma[i], DOEPDMA(i));
 	}
 
 	/* Set the Power-On Programming done bit */
-	dctl = dwc2_readl(hsotg->regs + DCTL);
+	dctl = dwc2_readl(hsotg, DCTL);
 	dctl |= DCTL_PWRONPRGDONE;
-	dwc2_writel(dctl, hsotg->regs + DCTL);
+	dwc2_writel(hsotg, dctl, DCTL);
 
 	return 0;
 }
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 2df3d04..0271d3c 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -71,10 +71,10 @@ static void dwc2_enable_common_interrupts(struct dwc2_hsotg *hsotg)
 	u32 intmsk;
 
 	/* Clear any pending OTG Interrupts */
-	dwc2_writel(0xffffffff, hsotg->regs + GOTGINT);
+	dwc2_writel(hsotg, 0xffffffff, GOTGINT);
 
 	/* Clear any pending interrupts */
-	dwc2_writel(0xffffffff, hsotg->regs + GINTSTS);
+	dwc2_writel(hsotg, 0xffffffff, GINTSTS);
 
 	/* Enable the interrupts in the GINTMSK */
 	intmsk = GINTSTS_MODEMIS | GINTSTS_OTGINT;
@@ -87,7 +87,7 @@ static void dwc2_enable_common_interrupts(struct dwc2_hsotg *hsotg)
 	intmsk |= GINTSTS_WKUPINT | GINTSTS_USBSUSP |
 		  GINTSTS_SESSREQINT;
 
-	dwc2_writel(intmsk, hsotg->regs + GINTMSK);
+	dwc2_writel(hsotg, intmsk, GINTMSK);
 }
 
 /*
@@ -110,10 +110,10 @@ static void dwc2_init_fs_ls_pclk_sel(struct dwc2_hsotg *hsotg)
 	}
 
 	dev_dbg(hsotg->dev, "Initializing HCFG.FSLSPClkSel to %08x\n", val);
-	hcfg = dwc2_readl(hsotg->regs + HCFG);
+	hcfg = dwc2_readl(hsotg, HCFG);
 	hcfg &= ~HCFG_FSLSPCLKSEL_MASK;
 	hcfg |= val << HCFG_FSLSPCLKSEL_SHIFT;
-	dwc2_writel(hcfg, hsotg->regs + HCFG);
+	dwc2_writel(hsotg, hcfg, HCFG);
 }
 
 static int dwc2_fs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
@@ -128,10 +128,10 @@ static int dwc2_fs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 	if (select_phy) {
 		dev_dbg(hsotg->dev, "FS PHY selected\n");
 
-		usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+		usbcfg = dwc2_readl(hsotg, GUSBCFG);
 		if (!(usbcfg & GUSBCFG_PHYSEL)) {
 			usbcfg |= GUSBCFG_PHYSEL;
-			dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+			dwc2_writel(hsotg, usbcfg, GUSBCFG);
 
 			/* Reset after a PHY select */
 			retval = dwc2_core_reset_and_force_dr_mode(hsotg);
@@ -156,18 +156,18 @@ static int dwc2_fs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 		dev_dbg(hsotg->dev, "FS PHY enabling I2C\n");
 
 		/* Program GUSBCFG.OtgUtmiFsSel to I2C */
-		usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+		usbcfg = dwc2_readl(hsotg, GUSBCFG);
 		usbcfg |= GUSBCFG_OTG_UTMI_FS_SEL;
-		dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+		dwc2_writel(hsotg, usbcfg, GUSBCFG);
 
 		/* Program GI2CCTL.I2CEn */
-		i2cctl = dwc2_readl(hsotg->regs + GI2CCTL);
+		i2cctl = dwc2_readl(hsotg, GI2CCTL);
 		i2cctl &= ~GI2CCTL_I2CDEVADDR_MASK;
 		i2cctl |= 1 << GI2CCTL_I2CDEVADDR_SHIFT;
 		i2cctl &= ~GI2CCTL_I2CEN;
-		dwc2_writel(i2cctl, hsotg->regs + GI2CCTL);
+		dwc2_writel(hsotg, i2cctl, GI2CCTL);
 		i2cctl |= GI2CCTL_I2CEN;
-		dwc2_writel(i2cctl, hsotg->regs + GI2CCTL);
+		dwc2_writel(hsotg, i2cctl, GI2CCTL);
 	}
 
 	return retval;
@@ -181,7 +181,7 @@ static int dwc2_hs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 	if (!select_phy)
 		return 0;
 
-	usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+	usbcfg = dwc2_readl(hsotg, GUSBCFG);
 	usbcfg_old = usbcfg;
 
 	/*
@@ -211,7 +211,7 @@ static int dwc2_hs_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 	}
 
 	if (usbcfg != usbcfg_old) {
-		dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+		dwc2_writel(hsotg, usbcfg, GUSBCFG);
 
 		/* Reset after setting the PHY parameters */
 		retval = dwc2_core_reset_and_force_dr_mode(hsotg);
@@ -247,15 +247,15 @@ static int dwc2_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 	    hsotg->hw_params.fs_phy_type == GHWCFG2_FS_PHY_TYPE_DEDICATED &&
 	    hsotg->core_params->ulpi_fs_ls > 0) {
 		dev_dbg(hsotg->dev, "Setting ULPI FSLS\n");
-		usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+		usbcfg = dwc2_readl(hsotg, GUSBCFG);
 		usbcfg |= GUSBCFG_ULPI_FS_LS;
 		usbcfg |= GUSBCFG_ULPI_CLK_SUSP_M;
-		dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+		dwc2_writel(hsotg, usbcfg, GUSBCFG);
 	} else {
-		usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+		usbcfg = dwc2_readl(hsotg, GUSBCFG);
 		usbcfg &= ~GUSBCFG_ULPI_FS_LS;
 		usbcfg &= ~GUSBCFG_ULPI_CLK_SUSP_M;
-		dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+		dwc2_writel(hsotg, usbcfg, GUSBCFG);
 	}
 
 	return retval;
@@ -263,7 +263,7 @@ static int dwc2_phy_init(struct dwc2_hsotg *hsotg, bool select_phy)
 
 static int dwc2_gahbcfg_init(struct dwc2_hsotg *hsotg)
 {
-	u32 ahbcfg = dwc2_readl(hsotg->regs + GAHBCFG);
+	u32 ahbcfg = dwc2_readl(hsotg, GAHBCFG);
 
 	switch (hsotg->hw_params.arch) {
 	case GHWCFG2_EXT_DMA_ARCH:
@@ -302,7 +302,7 @@ static int dwc2_gahbcfg_init(struct dwc2_hsotg *hsotg)
 	if (hsotg->core_params->dma_enable > 0)
 		ahbcfg |= GAHBCFG_DMA_EN;
 
-	dwc2_writel(ahbcfg, hsotg->regs + GAHBCFG);
+	dwc2_writel(hsotg, ahbcfg, GAHBCFG);
 
 	return 0;
 }
@@ -311,7 +311,7 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 {
 	u32 usbcfg;
 
-	usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+	usbcfg = dwc2_readl(hsotg, GUSBCFG);
 	usbcfg &= ~(GUSBCFG_HNPCAP | GUSBCFG_SRPCAP);
 
 	switch (hsotg->hw_params.op_mode) {
@@ -339,7 +339,7 @@ static void dwc2_gusbcfg_init(struct dwc2_hsotg *hsotg)
 		break;
 	}
 
-	dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+	dwc2_writel(hsotg, usbcfg, GUSBCFG);
 }
 
 /**
@@ -354,16 +354,16 @@ static void dwc2_enable_host_interrupts(struct dwc2_hsotg *hsotg)
 	dev_dbg(hsotg->dev, "%s()\n", __func__);
 
 	/* Disable all interrupts */
-	dwc2_writel(0, hsotg->regs + GINTMSK);
-	dwc2_writel(0, hsotg->regs + HAINTMSK);
+	dwc2_writel(hsotg, 0, GINTMSK);
+	dwc2_writel(hsotg, 0, HAINTMSK);
 
 	/* Enable the common interrupts */
 	dwc2_enable_common_interrupts(hsotg);
 
 	/* Enable host mode interrupts without disturbing common interrupts */
-	intmsk = dwc2_readl(hsotg->regs + GINTMSK);
+	intmsk = dwc2_readl(hsotg, GINTMSK);
 	intmsk |= GINTSTS_DISCONNINT | GINTSTS_PRTINT | GINTSTS_HCHINT;
-	dwc2_writel(intmsk, hsotg->regs + GINTMSK);
+	dwc2_writel(hsotg, intmsk, GINTMSK);
 }
 
 /**
@@ -373,12 +373,12 @@ static void dwc2_enable_host_interrupts(struct dwc2_hsotg *hsotg)
  */
 static void dwc2_disable_host_interrupts(struct dwc2_hsotg *hsotg)
 {
-	u32 intmsk = dwc2_readl(hsotg->regs + GINTMSK);
+	u32 intmsk = dwc2_readl(hsotg, GINTMSK);
 
 	/* Disable host mode interrupts without disturbing common interrupts */
 	intmsk &= ~(GINTSTS_SOF | GINTSTS_PRTINT | GINTSTS_HCHINT |
 		    GINTSTS_PTXFEMP | GINTSTS_NPTXFEMP | GINTSTS_DISCONNINT);
-	dwc2_writel(intmsk, hsotg->regs + GINTMSK);
+	dwc2_writel(hsotg, intmsk, GINTMSK);
 }
 
 /*
@@ -458,37 +458,37 @@ static void dwc2_config_fifos(struct dwc2_hsotg *hsotg)
 	dwc2_calculate_dynamic_fifo(hsotg);
 
 	/* Rx FIFO */
-	grxfsiz = dwc2_readl(hsotg->regs + GRXFSIZ);
+	grxfsiz = dwc2_readl(hsotg, GRXFSIZ);
 	dev_dbg(hsotg->dev, "initial grxfsiz=%08x\n", grxfsiz);
 	grxfsiz &= ~GRXFSIZ_DEPTH_MASK;
 	grxfsiz |= params->host_rx_fifo_size <<
 		   GRXFSIZ_DEPTH_SHIFT & GRXFSIZ_DEPTH_MASK;
-	dwc2_writel(grxfsiz, hsotg->regs + GRXFSIZ);
+	dwc2_writel(hsotg, grxfsiz, GRXFSIZ);
 	dev_dbg(hsotg->dev, "new grxfsiz=%08x\n",
-		dwc2_readl(hsotg->regs + GRXFSIZ));
+		dwc2_readl(hsotg, GRXFSIZ));
 
 	/* Non-periodic Tx FIFO */
 	dev_dbg(hsotg->dev, "initial gnptxfsiz=%08x\n",
-		dwc2_readl(hsotg->regs + GNPTXFSIZ));
+		dwc2_readl(hsotg, GNPTXFSIZ));
 	nptxfsiz = params->host_nperio_tx_fifo_size <<
 		   FIFOSIZE_DEPTH_SHIFT & FIFOSIZE_DEPTH_MASK;
 	nptxfsiz |= params->host_rx_fifo_size <<
 		    FIFOSIZE_STARTADDR_SHIFT & FIFOSIZE_STARTADDR_MASK;
-	dwc2_writel(nptxfsiz, hsotg->regs + GNPTXFSIZ);
+	dwc2_writel(hsotg, nptxfsiz, GNPTXFSIZ);
 	dev_dbg(hsotg->dev, "new gnptxfsiz=%08x\n",
-		dwc2_readl(hsotg->regs + GNPTXFSIZ));
+		dwc2_readl(hsotg, GNPTXFSIZ));
 
 	/* Periodic Tx FIFO */
 	dev_dbg(hsotg->dev, "initial hptxfsiz=%08x\n",
-		dwc2_readl(hsotg->regs + HPTXFSIZ));
+		dwc2_readl(hsotg, HPTXFSIZ));
 	hptxfsiz = params->host_perio_tx_fifo_size <<
 		   FIFOSIZE_DEPTH_SHIFT & FIFOSIZE_DEPTH_MASK;
 	hptxfsiz |= (params->host_rx_fifo_size +
 		     params->host_nperio_tx_fifo_size) <<
 		    FIFOSIZE_STARTADDR_SHIFT & FIFOSIZE_STARTADDR_MASK;
-	dwc2_writel(hptxfsiz, hsotg->regs + HPTXFSIZ);
+	dwc2_writel(hsotg, hptxfsiz, HPTXFSIZ);
 	dev_dbg(hsotg->dev, "new hptxfsiz=%08x\n",
-		dwc2_readl(hsotg->regs + HPTXFSIZ));
+		dwc2_readl(hsotg, HPTXFSIZ));
 
 	if (hsotg->core_params->en_multiple_tx_fifo > 0 &&
 	    hsotg->hw_params.snpsid <= DWC2_CORE_REV_2_94a) {
@@ -496,14 +496,14 @@ static void dwc2_config_fifos(struct dwc2_hsotg *hsotg)
 		 * Global DFIFOCFG calculation for Host mode -
 		 * include RxFIFO, NPTXFIFO and HPTXFIFO
 		 */
-		dfifocfg = dwc2_readl(hsotg->regs + GDFIFOCFG);
+		dfifocfg = dwc2_readl(hsotg, GDFIFOCFG);
 		dfifocfg &= ~GDFIFOCFG_EPINFOBASE_MASK;
 		dfifocfg |= (params->host_rx_fifo_size +
 			     params->host_nperio_tx_fifo_size +
 			     params->host_perio_tx_fifo_size) <<
 			    GDFIFOCFG_EPINFOBASE_SHIFT &
 			    GDFIFOCFG_EPINFOBASE_MASK;
-		dwc2_writel(dfifocfg, hsotg->regs + GDFIFOCFG);
+		dwc2_writel(hsotg, dfifocfg, GDFIFOCFG);
 	}
 }
 
@@ -523,8 +523,8 @@ u32 dwc2_calc_frame_interval(struct dwc2_hsotg *hsotg)
 	u32 hprt0;
 	int clock = 60;	/* default value */
 
-	usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
-	hprt0 = dwc2_readl(hsotg->regs + HPRT0);
+	usbcfg = dwc2_readl(hsotg, GUSBCFG);
+	hprt0 = dwc2_readl(hsotg, HPRT0);
 
 	if (!(usbcfg & GUSBCFG_PHYSEL) && (usbcfg & GUSBCFG_ULPI_UTMI_SEL) &&
 	    !(usbcfg & GUSBCFG_PHYIF16))
@@ -566,7 +566,6 @@ u32 dwc2_calc_frame_interval(struct dwc2_hsotg *hsotg)
  */
 void dwc2_read_packet(struct dwc2_hsotg *hsotg, u8 *dest, u16 bytes)
 {
-	u32 __iomem *fifo = hsotg->regs + HCFIFO(0);
 	u32 *data_buf = (u32 *)dest;
 	int word_count = (bytes + 3) / 4;
 	int i;
@@ -580,7 +579,7 @@ void dwc2_read_packet(struct dwc2_hsotg *hsotg, u8 *dest, u16 bytes)
 	dev_vdbg(hsotg->dev, "%s(%p,%p,%d)\n", __func__, hsotg, dest, bytes);
 
 	for (i = 0; i < word_count; i++, data_buf++)
-		*data_buf = dwc2_readl(fifo);
+		*data_buf = dwc2_readl(hsotg, HCFIFO(0));
 }
 
 /**
@@ -609,10 +608,10 @@ static void dwc2_dump_channel_info(struct dwc2_hsotg *hsotg,
 	if (!chan)
 		return;
 
-	hcchar = dwc2_readl(hsotg->regs + HCCHAR(chan->hc_num));
-	hcsplt = dwc2_readl(hsotg->regs + HCSPLT(chan->hc_num));
-	hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(chan->hc_num));
-	hc_dma = dwc2_readl(hsotg->regs + HCDMA(chan->hc_num));
+	hcchar = dwc2_readl(hsotg, HCCHAR(chan->hc_num));
+	hcsplt = dwc2_readl(hsotg, HCSPLT(chan->hc_num));
+	hctsiz = dwc2_readl(hsotg, HCTSIZ(chan->hc_num));
+	hc_dma = dwc2_readl(hsotg, HCDMA(chan->hc_num));
 
 	dev_dbg(hsotg->dev, "  Assigned to channel %p:\n", chan);
 	dev_dbg(hsotg->dev, "    hcchar 0x%08x, hcsplt 0x%08x\n",
@@ -727,7 +726,7 @@ static void dwc2_hc_enable_slave_ints(struct dwc2_hsotg *hsotg,
 		break;
 	}
 
-	dwc2_writel(hcintmsk, hsotg->regs + HCINTMSK(chan->hc_num));
+	dwc2_writel(hsotg, hcintmsk, HCINTMSK(chan->hc_num));
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "set HCINTMSK to %08x\n", hcintmsk);
 }
@@ -764,7 +763,7 @@ static void dwc2_hc_enable_dma_ints(struct dwc2_hsotg *hsotg,
 		}
 	}
 
-	dwc2_writel(hcintmsk, hsotg->regs + HCINTMSK(chan->hc_num));
+	dwc2_writel(hsotg, hcintmsk, HCINTMSK(chan->hc_num));
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "set HCINTMSK to %08x\n", hcintmsk);
 }
@@ -785,16 +784,16 @@ static void dwc2_hc_enable_ints(struct dwc2_hsotg *hsotg,
 	}
 
 	/* Enable the top level host channel interrupt */
-	intmsk = dwc2_readl(hsotg->regs + HAINTMSK);
+	intmsk = dwc2_readl(hsotg, HAINTMSK);
 	intmsk |= 1 << chan->hc_num;
-	dwc2_writel(intmsk, hsotg->regs + HAINTMSK);
+	dwc2_writel(hsotg, intmsk, HAINTMSK);
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "set HAINTMSK to %08x\n", intmsk);
 
 	/* Make sure host channel interrupts are enabled */
-	intmsk = dwc2_readl(hsotg->regs + GINTMSK);
+	intmsk = dwc2_readl(hsotg, GINTMSK);
 	intmsk |= GINTSTS_HCHINT;
-	dwc2_writel(intmsk, hsotg->regs + GINTMSK);
+	dwc2_writel(hsotg, intmsk, GINTMSK);
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "set GINTMSK to %08x\n", intmsk);
 }
@@ -823,7 +822,7 @@ static void dwc2_hc_init(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan)
 	/* Clear old interrupt conditions for this host channel */
 	hcintmsk = 0xffffffff;
 	hcintmsk &= ~HCINTMSK_RESERVED14_31;
-	dwc2_writel(hcintmsk, hsotg->regs + HCINT(hc_num));
+	dwc2_writel(hsotg, hcintmsk, HCINT(hc_num));
 
 	/* Enable channel interrupts required for this transfer */
 	dwc2_hc_enable_ints(hsotg, chan);
@@ -840,7 +839,7 @@ static void dwc2_hc_init(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan)
 		hcchar |= HCCHAR_LSPDDEV;
 	hcchar |= chan->ep_type << HCCHAR_EPTYPE_SHIFT & HCCHAR_EPTYPE_MASK;
 	hcchar |= chan->max_packet << HCCHAR_MPS_SHIFT & HCCHAR_MPS_MASK;
-	dwc2_writel(hcchar, hsotg->regs + HCCHAR(hc_num));
+	dwc2_writel(hsotg, hcchar, HCCHAR(hc_num));
 	if (dbg_hc(chan)) {
 		dev_vdbg(hsotg->dev, "set HCCHAR(%d) to %08x\n",
 			 hc_num, hcchar);
@@ -894,7 +893,7 @@ static void dwc2_hc_init(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan)
 		}
 	}
 
-	dwc2_writel(hcsplt, hsotg->regs + HCSPLT(hc_num));
+	dwc2_writel(hsotg, hcsplt, HCSPLT(hc_num));
 }
 
 /**
@@ -946,14 +945,14 @@ void dwc2_hc_halt(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan,
 		u32 hcintmsk = HCINTMSK_CHHLTD;
 
 		dev_vdbg(hsotg->dev, "dequeue/error\n");
-		dwc2_writel(hcintmsk, hsotg->regs + HCINTMSK(chan->hc_num));
+		dwc2_writel(hsotg, hcintmsk, HCINTMSK(chan->hc_num));
 
 		/*
 		 * Make sure no other interrupts besides halt are currently
 		 * pending. Handling another interrupt could cause a crash due
 		 * to the QTD and QH state.
 		 */
-		dwc2_writel(~hcintmsk, hsotg->regs + HCINT(chan->hc_num));
+		dwc2_writel(hsotg, ~hcintmsk, HCINT(chan->hc_num));
 
 		/*
 		 * Make sure the halt status is set to URB_DEQUEUE or AHB_ERR
@@ -962,7 +961,7 @@ void dwc2_hc_halt(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan,
 		 */
 		chan->halt_status = halt_status;
 
-		hcchar = dwc2_readl(hsotg->regs + HCCHAR(chan->hc_num));
+		hcchar = dwc2_readl(hsotg, HCCHAR(chan->hc_num));
 		if (!(hcchar & HCCHAR_CHENA)) {
 			/*
 			 * The channel is either already halted or it hasn't
@@ -990,7 +989,7 @@ void dwc2_hc_halt(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan,
 		return;
 	}
 
-	hcchar = dwc2_readl(hsotg->regs + HCCHAR(chan->hc_num));
+	hcchar = dwc2_readl(hsotg, HCCHAR(chan->hc_num));
 
 	/* No need to set the bit in DDMA for disabling the channel */
 	/* TODO check it everywhere channel is disabled */
@@ -1013,7 +1012,7 @@ void dwc2_hc_halt(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan,
 		if (chan->ep_type == USB_ENDPOINT_XFER_CONTROL ||
 		    chan->ep_type == USB_ENDPOINT_XFER_BULK) {
 			dev_vdbg(hsotg->dev, "control/bulk\n");
-			nptxsts = dwc2_readl(hsotg->regs + GNPTXSTS);
+			nptxsts = dwc2_readl(hsotg, GNPTXSTS);
 			if ((nptxsts & TXSTS_QSPCAVAIL_MASK) == 0) {
 				dev_vdbg(hsotg->dev, "Disabling channel\n");
 				hcchar &= ~HCCHAR_CHENA;
@@ -1021,7 +1020,7 @@ void dwc2_hc_halt(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan,
 		} else {
 			if (dbg_perio())
 				dev_vdbg(hsotg->dev, "isoc/intr\n");
-			hptxsts = dwc2_readl(hsotg->regs + HPTXSTS);
+			hptxsts = dwc2_readl(hsotg, HPTXSTS);
 			if ((hptxsts & TXSTS_QSPCAVAIL_MASK) == 0 ||
 			    hsotg->queuing_high_bandwidth) {
 				if (dbg_perio())
@@ -1034,7 +1033,7 @@ void dwc2_hc_halt(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan,
 			dev_vdbg(hsotg->dev, "DMA enabled\n");
 	}
 
-	dwc2_writel(hcchar, hsotg->regs + HCCHAR(chan->hc_num));
+	dwc2_writel(hsotg, hcchar, HCCHAR(chan->hc_num));
 	chan->halt_status = halt_status;
 
 	if (hcchar & HCCHAR_CHENA) {
@@ -1083,10 +1082,10 @@ void dwc2_hc_cleanup(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan)
 	 * Clear channel interrupt enables and any unhandled channel interrupt
 	 * conditions
 	 */
-	dwc2_writel(0, hsotg->regs + HCINTMSK(chan->hc_num));
+	dwc2_writel(hsotg, 0, HCINTMSK(chan->hc_num));
 	hcintmsk = 0xffffffff;
 	hcintmsk &= ~HCINTMSK_RESERVED14_31;
-	dwc2_writel(hcintmsk, hsotg->regs + HCINT(chan->hc_num));
+	dwc2_writel(hsotg, hcintmsk, HCINT(chan->hc_num));
 }
 
 /**
@@ -1140,7 +1139,7 @@ static void dwc2_hc_set_even_odd_frame(struct dwc2_hsotg *hsotg,
 			      !chan->do_split) ? chan->speed : USB_SPEED_HIGH;
 
 		/* See how many bytes are in the periodic FIFO right now */
-		fifo_space = (dwc2_readl(hsotg->regs + HPTXSTS) &
+		fifo_space = (dwc2_readl(hsotg, HPTXSTS) &
 			      TXSTS_FSPCAVAIL_MASK) >> TXSTS_FSPCAVAIL_SHIFT;
 		bytes_in_fifo = sizeof(u32) *
 				(hsotg->core_params->host_perio_tx_fifo_size -
@@ -1241,14 +1240,11 @@ static void dwc2_hc_write_packet(struct dwc2_hsotg *hsotg,
 	u32 remaining_count;
 	u32 byte_count;
 	u32 dword_count;
-	u32 __iomem *data_fifo;
 	u32 *data_buf = (u32 *)chan->xfer_buf;
 
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "%s()\n", __func__);
 
-	data_fifo = (u32 __iomem *)(hsotg->regs + HCFIFO(chan->hc_num));
-
 	remaining_count = chan->xfer_len - chan->xfer_count;
 	if (remaining_count > chan->max_packet)
 		byte_count = chan->max_packet;
@@ -1260,13 +1256,13 @@ static void dwc2_hc_write_packet(struct dwc2_hsotg *hsotg,
 	if (((unsigned long)data_buf & 0x3) == 0) {
 		/* xfer_buf is DWORD aligned */
 		for (i = 0; i < dword_count; i++, data_buf++)
-			dwc2_writel(*data_buf, data_fifo);
+			dwc2_writel(hsotg, *data_buf, HCFIFO(chan->hc_num));
 	} else {
 		/* xfer_buf is not DWORD aligned */
 		for (i = 0; i < dword_count; i++, data_buf++) {
 			u32 data = data_buf[0] | data_buf[1] << 8 |
 				   data_buf[2] << 16 | data_buf[3] << 24;
-			dwc2_writel(data, data_fifo);
+			dwc2_writel(hsotg, data, HCFIFO(chan->hc_num));
 		}
 	}
 
@@ -1295,12 +1291,12 @@ static void dwc2_hc_do_ping(struct dwc2_hsotg *hsotg,
 
 	hctsiz = TSIZ_DOPNG;
 	hctsiz |= 1 << TSIZ_PKTCNT_SHIFT;
-	dwc2_writel(hctsiz, hsotg->regs + HCTSIZ(chan->hc_num));
+	dwc2_writel(hsotg, hctsiz, HCTSIZ(chan->hc_num));
 
-	hcchar = dwc2_readl(hsotg->regs + HCCHAR(chan->hc_num));
+	hcchar = dwc2_readl(hsotg, HCCHAR(chan->hc_num));
 	hcchar |= HCCHAR_CHENA;
 	hcchar &= ~HCCHAR_CHDIS;
-	dwc2_writel(hcchar, hsotg->regs + HCCHAR(chan->hc_num));
+	dwc2_writel(hsotg, hcchar, HCCHAR(chan->hc_num));
 }
 
 /**
@@ -1460,7 +1456,7 @@ static void dwc2_hc_start_transfer(struct dwc2_hsotg *hsotg,
 	hctsiz |= num_packets << TSIZ_PKTCNT_SHIFT & TSIZ_PKTCNT_MASK;
 	hctsiz |= chan->data_pid_start << TSIZ_SC_MC_PID_SHIFT &
 		  TSIZ_SC_MC_PID_MASK;
-	dwc2_writel(hctsiz, hsotg->regs + HCTSIZ(chan->hc_num));
+	dwc2_writel(hsotg, hctsiz, HCTSIZ(chan->hc_num));
 	if (dbg_hc(chan)) {
 		dev_vdbg(hsotg->dev, "Wrote %08x to HCTSIZ(%d)\n",
 			 hctsiz, chan->hc_num);
@@ -1479,8 +1475,7 @@ static void dwc2_hc_start_transfer(struct dwc2_hsotg *hsotg,
 	}
 
 	if (hsotg->core_params->dma_enable > 0) {
-		dwc2_writel((u32)chan->xfer_dma,
-			    hsotg->regs + HCDMA(chan->hc_num));
+		dwc2_writel(hsotg, (u32)chan->xfer_dma, HCDMA(chan->hc_num));
 		if (dbg_hc(chan))
 			dev_vdbg(hsotg->dev, "Wrote %08lx to HCDMA(%d)\n",
 				 (unsigned long)chan->xfer_dma, chan->hc_num);
@@ -1488,13 +1483,13 @@ static void dwc2_hc_start_transfer(struct dwc2_hsotg *hsotg,
 
 	/* Start the split */
 	if (chan->do_split) {
-		u32 hcsplt = dwc2_readl(hsotg->regs + HCSPLT(chan->hc_num));
+		u32 hcsplt = dwc2_readl(hsotg, HCSPLT(chan->hc_num));
 
 		hcsplt |= HCSPLT_SPLTENA;
-		dwc2_writel(hcsplt, hsotg->regs + HCSPLT(chan->hc_num));
+		dwc2_writel(hsotg, hcsplt, HCSPLT(chan->hc_num));
 	}
 
-	hcchar = dwc2_readl(hsotg->regs + HCCHAR(chan->hc_num));
+	hcchar = dwc2_readl(hsotg, HCCHAR(chan->hc_num));
 	hcchar &= ~HCCHAR_MULTICNT_MASK;
 	hcchar |= (ec_mc << HCCHAR_MULTICNT_SHIFT) & HCCHAR_MULTICNT_MASK;
 	dwc2_hc_set_even_odd_frame(hsotg, chan, &hcchar);
@@ -1513,7 +1508,7 @@ static void dwc2_hc_start_transfer(struct dwc2_hsotg *hsotg,
 			 (hcchar & HCCHAR_MULTICNT_MASK) >>
 			 HCCHAR_MULTICNT_SHIFT);
 
-	dwc2_writel(hcchar, hsotg->regs + HCCHAR(chan->hc_num));
+	dwc2_writel(hsotg, hcchar, HCCHAR(chan->hc_num));
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "Wrote %08x to HCCHAR(%d)\n", hcchar,
 			 chan->hc_num);
@@ -1571,18 +1566,18 @@ void dwc2_hc_start_transfer_ddma(struct dwc2_hsotg *hsotg,
 		dev_vdbg(hsotg->dev, "	 NTD: %d\n", chan->ntd - 1);
 	}
 
-	dwc2_writel(hctsiz, hsotg->regs + HCTSIZ(chan->hc_num));
+	dwc2_writel(hsotg, hctsiz, HCTSIZ(chan->hc_num));
 
 	dma_sync_single_for_device(hsotg->dev, chan->desc_list_addr,
 				   chan->desc_list_sz, DMA_TO_DEVICE);
 
-	dwc2_writel(chan->desc_list_addr, hsotg->regs + HCDMA(chan->hc_num));
+	dwc2_writel(hsotg, chan->desc_list_addr, HCDMA(chan->hc_num));
 
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "Wrote %pad to HCDMA(%d)\n",
 			 &chan->desc_list_addr, chan->hc_num);
 
-	hcchar = dwc2_readl(hsotg->regs + HCCHAR(chan->hc_num));
+	hcchar = dwc2_readl(hsotg, HCCHAR(chan->hc_num));
 	hcchar &= ~HCCHAR_MULTICNT_MASK;
 	hcchar |= chan->multi_count << HCCHAR_MULTICNT_SHIFT &
 		  HCCHAR_MULTICNT_MASK;
@@ -1601,7 +1596,7 @@ void dwc2_hc_start_transfer_ddma(struct dwc2_hsotg *hsotg,
 			 (hcchar & HCCHAR_MULTICNT_MASK) >>
 			 HCCHAR_MULTICNT_SHIFT);
 
-	dwc2_writel(hcchar, hsotg->regs + HCCHAR(chan->hc_num));
+	dwc2_writel(hsotg, hcchar, HCCHAR(chan->hc_num));
 	if (dbg_hc(chan))
 		dev_vdbg(hsotg->dev, "Wrote %08x to HCCHAR(%d)\n", hcchar,
 			 chan->hc_num);
@@ -1658,7 +1653,7 @@ static int dwc2_hc_continue_transfer(struct dwc2_hsotg *hsotg,
 		 * transfer completes, the extra requests for the channel will
 		 * be flushed.
 		 */
-		u32 hcchar = dwc2_readl(hsotg->regs + HCCHAR(chan->hc_num));
+		u32 hcchar = dwc2_readl(hsotg, HCCHAR(chan->hc_num));
 
 		dwc2_hc_set_even_odd_frame(hsotg, chan, &hcchar);
 		hcchar |= HCCHAR_CHENA;
@@ -1666,7 +1661,7 @@ static int dwc2_hc_continue_transfer(struct dwc2_hsotg *hsotg,
 		if (dbg_hc(chan))
 			dev_vdbg(hsotg->dev, "	 IN xfer: hcchar = 0x%08x\n",
 				 hcchar);
-		dwc2_writel(hcchar, hsotg->regs + HCCHAR(chan->hc_num));
+		dwc2_writel(hsotg, hcchar, HCCHAR(chan->hc_num));
 		chan->requests++;
 		return 1;
 	}
@@ -1676,8 +1671,7 @@ static int dwc2_hc_continue_transfer(struct dwc2_hsotg *hsotg,
 	if (chan->xfer_count < chan->xfer_len) {
 		if (chan->ep_type == USB_ENDPOINT_XFER_INT ||
 		    chan->ep_type == USB_ENDPOINT_XFER_ISOC) {
-			u32 hcchar = dwc2_readl(hsotg->regs +
-						HCCHAR(chan->hc_num));
+			u32 hcchar = dwc2_readl(hsotg, HCCHAR(chan->hc_num));
 
 			dwc2_hc_set_even_odd_frame(hsotg, chan,
 						   &hcchar);
@@ -1789,7 +1783,7 @@ void dwc2_hcd_start(struct dwc2_hsotg *hsotg)
 		 */
 		hprt0 = dwc2_read_hprt0(hsotg);
 		hprt0 |= HPRT0_RST;
-		dwc2_writel(hprt0, hsotg->regs + HPRT0);
+		dwc2_writel(hsotg, hprt0, HPRT0);
 	}
 
 	queue_delayed_work(hsotg->wq_otg, &hsotg->start_work,
@@ -1810,11 +1804,11 @@ static void dwc2_hcd_cleanup_channels(struct dwc2_hsotg *hsotg)
 			channel = hsotg->hc_ptr_array[i];
 			if (!list_empty(&channel->hc_list_entry))
 				continue;
-			hcchar = dwc2_readl(hsotg->regs + HCCHAR(i));
+			hcchar = dwc2_readl(hsotg, HCCHAR(i));
 			if (hcchar & HCCHAR_CHENA) {
 				hcchar &= ~(HCCHAR_CHENA | HCCHAR_EPDIR);
 				hcchar |= HCCHAR_CHDIS;
-				dwc2_writel(hcchar, hsotg->regs + HCCHAR(i));
+				dwc2_writel(hsotg, hcchar, HCCHAR(i));
 			}
 		}
 	}
@@ -1823,11 +1817,11 @@ static void dwc2_hcd_cleanup_channels(struct dwc2_hsotg *hsotg)
 		channel = hsotg->hc_ptr_array[i];
 		if (!list_empty(&channel->hc_list_entry))
 			continue;
-		hcchar = dwc2_readl(hsotg->regs + HCCHAR(i));
+		hcchar = dwc2_readl(hsotg, HCCHAR(i));
 		if (hcchar & HCCHAR_CHENA) {
 			/* Halt the channel */
 			hcchar |= HCCHAR_CHDIS;
-			dwc2_writel(hcchar, hsotg->regs + HCCHAR(i));
+			dwc2_writel(hsotg, hcchar, HCCHAR(i));
 		}
 
 		dwc2_hc_cleanup(hsotg, channel);
@@ -1887,11 +1881,11 @@ void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force)
 	 * interrupt mask and status bits and disabling subsequent host
 	 * channel interrupts.
 	 */
-	intr = dwc2_readl(hsotg->regs + GINTMSK);
+	intr = dwc2_readl(hsotg, GINTMSK);
 	intr &= ~(GINTSTS_NPTXFEMP | GINTSTS_PTXFEMP | GINTSTS_HCHINT);
-	dwc2_writel(intr, hsotg->regs + GINTMSK);
+	dwc2_writel(hsotg, intr, GINTMSK);
 	intr = GINTSTS_NPTXFEMP | GINTSTS_PTXFEMP | GINTSTS_HCHINT;
-	dwc2_writel(intr, hsotg->regs + GINTSTS);
+	dwc2_writel(hsotg, intr, GINTSTS);
 
 	/*
 	 * Turn off the vbus power only if the core has transitioned to device
@@ -1901,7 +1895,7 @@ void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force)
 	if (dwc2_is_device_mode(hsotg)) {
 		if (hsotg->op_state != OTG_STATE_A_SUSPEND) {
 			dev_dbg(hsotg->dev, "Disconnect: PortPower off\n");
-			dwc2_writel(0, hsotg->regs + HPRT0);
+			dwc2_writel(hsotg, 0, HPRT0);
 		}
 
 		dwc2_disable_host_interrupts(hsotg);
@@ -1929,7 +1923,7 @@ void dwc2_hcd_disconnect(struct dwc2_hsotg *hsotg, bool force)
 	 * and won't get any future interrupts to handle the connect.
 	 */
 	if (!force) {
-		hprt0 = dwc2_readl(hsotg->regs + HPRT0);
+		hprt0 = dwc2_readl(hsotg, HPRT0);
 		if (!(hprt0 & HPRT0_CONNDET) && (hprt0 & HPRT0_CONNSTS))
 			dwc2_hcd_connect(hsotg);
 	}
@@ -1973,7 +1967,7 @@ void dwc2_hcd_stop(struct dwc2_hsotg *hsotg)
 
 	/* Turn off the vbus power */
 	dev_dbg(hsotg->dev, "PortPower off\n");
-	dwc2_writel(0, hsotg->regs + HPRT0);
+	dwc2_writel(hsotg, 0, HPRT0);
 }
 
 /* Caller must hold driver lock */
@@ -1997,7 +1991,7 @@ static int dwc2_hcd_urb_enqueue(struct dwc2_hsotg *hsotg,
 	if ((dev_speed == USB_SPEED_LOW) &&
 	    (hsotg->hw_params.fs_phy_type == GHWCFG2_FS_PHY_TYPE_DEDICATED) &&
 	    (hsotg->hw_params.hs_phy_type == GHWCFG2_HS_PHY_TYPE_UTMI)) {
-		u32 hprt0 = dwc2_readl(hsotg->regs + HPRT0);
+		u32 hprt0 = dwc2_readl(hsotg, HPRT0);
 		u32 prtspd = (hprt0 & HPRT0_SPD_MASK) >> HPRT0_SPD_SHIFT;
 
 		if (prtspd == HPRT0_SPD_FULL_SPEED)
@@ -2016,7 +2010,7 @@ static int dwc2_hcd_urb_enqueue(struct dwc2_hsotg *hsotg,
 		return retval;
 	}
 
-	intr_mask = dwc2_readl(hsotg->regs + GINTMSK);
+	intr_mask = dwc2_readl(hsotg, GINTMSK);
 	if (!(intr_mask & GINTSTS_SOF)) {
 		enum dwc2_transaction_type tr_type;
 
@@ -2181,7 +2175,7 @@ static int dwc2_core_init(struct dwc2_hsotg *hsotg, bool initial_setup)
 
 	dev_dbg(hsotg->dev, "%s(%p)\n", __func__, hsotg);
 
-	usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+	usbcfg = dwc2_readl(hsotg, GUSBCFG);
 
 	/* Set ULPI External VBUS bit if needed */
 	usbcfg &= ~GUSBCFG_ULPI_EXT_VBUS_DRV;
@@ -2194,7 +2188,7 @@ static int dwc2_core_init(struct dwc2_hsotg *hsotg, bool initial_setup)
 	if (hsotg->core_params->ts_dline > 0)
 		usbcfg |= GUSBCFG_TERMSELDLPULSE;
 
-	dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+	dwc2_writel(hsotg, usbcfg, GUSBCFG);
 
 	/*
 	 * Reset the Controller
@@ -2228,11 +2222,11 @@ static int dwc2_core_init(struct dwc2_hsotg *hsotg, bool initial_setup)
 	dwc2_gusbcfg_init(hsotg);
 
 	/* Program the GOTGCTL register */
-	otgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+	otgctl = dwc2_readl(hsotg, GOTGCTL);
 	otgctl &= ~GOTGCTL_OTGVER;
 	if (hsotg->core_params->otg_ver > 0)
 		otgctl |= GOTGCTL_OTGVER;
-	dwc2_writel(otgctl, hsotg->regs + GOTGCTL);
+	dwc2_writel(hsotg, otgctl, GOTGCTL);
 	dev_dbg(hsotg->dev, "OTG VER PARAM: %d\n", hsotg->core_params->otg_ver);
 
 	/* Clear the SRP success bit for FS-I2c */
@@ -2273,14 +2267,14 @@ static void dwc2_core_host_init(struct dwc2_hsotg *hsotg)
 	dev_dbg(hsotg->dev, "%s(%p)\n", __func__, hsotg);
 
 	/* Restart the Phy Clock */
-	dwc2_writel(0, hsotg->regs + PCGCTL);
+	dwc2_writel(hsotg, 0, PCGCTL);
 
 	/* Initialize Host Configuration Register */
 	dwc2_init_fs_ls_pclk_sel(hsotg);
 	if (hsotg->core_params->speed == DWC2_SPEED_PARAM_FULL) {
-		hcfg = dwc2_readl(hsotg->regs + HCFG);
+		hcfg = dwc2_readl(hsotg, HCFG);
 		hcfg |= HCFG_FSLSSUPP;
-		dwc2_writel(hcfg, hsotg->regs + HCFG);
+		dwc2_writel(hsotg, hcfg, HCFG);
 	}
 
 	/*
@@ -2289,9 +2283,9 @@ static void dwc2_core_host_init(struct dwc2_hsotg *hsotg)
 	 * and its value must not be changed during runtime.
 	 */
 	if (hsotg->core_params->reload_ctl > 0) {
-		hfir = dwc2_readl(hsotg->regs + HFIR);
+		hfir = dwc2_readl(hsotg, HFIR);
 		hfir |= HFIR_RLDCTRL;
-		dwc2_writel(hfir, hsotg->regs + HFIR);
+		dwc2_writel(hsotg, hfir, HFIR);
 	}
 
 	if (hsotg->core_params->dma_desc_enable > 0) {
@@ -2308,9 +2302,9 @@ static void dwc2_core_host_init(struct dwc2_hsotg *hsotg)
 				"falling back to buffer DMA mode.\n");
 			hsotg->core_params->dma_desc_enable = 0;
 		} else {
-			hcfg = dwc2_readl(hsotg->regs + HCFG);
+			hcfg = dwc2_readl(hsotg, HCFG);
 			hcfg |= HCFG_DESCDMA;
-			dwc2_writel(hcfg, hsotg->regs + HCFG);
+			dwc2_writel(hsotg, hcfg, HCFG);
 		}
 	}
 
@@ -2319,18 +2313,18 @@ static void dwc2_core_host_init(struct dwc2_hsotg *hsotg)
 
 	/* TODO - check this */
 	/* Clear Host Set HNP Enable in the OTG Control Register */
-	otgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+	otgctl = dwc2_readl(hsotg, GOTGCTL);
 	otgctl &= ~GOTGCTL_HSTSETHNPEN;
-	dwc2_writel(otgctl, hsotg->regs + GOTGCTL);
+	dwc2_writel(hsotg, otgctl, GOTGCTL);
 
 	/* Make sure the FIFOs are flushed */
 	dwc2_flush_tx_fifo(hsotg, 0x10 /* all TX FIFOs */);
 	dwc2_flush_rx_fifo(hsotg);
 
 	/* Clear Host Set HNP Enable in the OTG Control Register */
-	otgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+	otgctl = dwc2_readl(hsotg, GOTGCTL);
 	otgctl &= ~GOTGCTL_HSTSETHNPEN;
-	dwc2_writel(otgctl, hsotg->regs + GOTGCTL);
+	dwc2_writel(hsotg, otgctl, GOTGCTL);
 
 	if (hsotg->core_params->dma_desc_enable <= 0) {
 		int num_channels, i;
@@ -2339,25 +2333,25 @@ static void dwc2_core_host_init(struct dwc2_hsotg *hsotg)
 		/* Flush out any leftover queued requests */
 		num_channels = hsotg->core_params->host_channels;
 		for (i = 0; i < num_channels; i++) {
-			hcchar = dwc2_readl(hsotg->regs + HCCHAR(i));
+			hcchar = dwc2_readl(hsotg, HCCHAR(i));
 			hcchar &= ~HCCHAR_CHENA;
 			hcchar |= HCCHAR_CHDIS;
 			hcchar &= ~HCCHAR_EPDIR;
-			dwc2_writel(hcchar, hsotg->regs + HCCHAR(i));
+			dwc2_writel(hsotg, hcchar, HCCHAR(i));
 		}
 
 		/* Halt all channels to put them into a known state */
 		for (i = 0; i < num_channels; i++) {
 			int count = 0;
 
-			hcchar = dwc2_readl(hsotg->regs + HCCHAR(i));
+			hcchar = dwc2_readl(hsotg, HCCHAR(i));
 			hcchar |= HCCHAR_CHENA | HCCHAR_CHDIS;
 			hcchar &= ~HCCHAR_EPDIR;
-			dwc2_writel(hcchar, hsotg->regs + HCCHAR(i));
+			dwc2_writel(hsotg, hcchar, HCCHAR(i));
 			dev_dbg(hsotg->dev, "%s: Halt channel %d\n",
 				__func__, i);
 			do {
-				hcchar = dwc2_readl(hsotg->regs + HCCHAR(i));
+				hcchar = dwc2_readl(hsotg, HCCHAR(i));
 				if (++count > 1000) {
 					dev_err(hsotg->dev,
 						"Unable to clear enable on channel %d\n",
@@ -2378,7 +2372,7 @@ static void dwc2_core_host_init(struct dwc2_hsotg *hsotg)
 			!!(hprt0 & HPRT0_PWR));
 		if (!(hprt0 & HPRT0_PWR)) {
 			hprt0 |= HPRT0_PWR;
-			dwc2_writel(hprt0, hsotg->regs + HPRT0);
+			dwc2_writel(hsotg, hprt0, HPRT0);
 		}
 	}
 
@@ -2917,7 +2911,7 @@ static void dwc2_process_periodic_channels(struct dwc2_hsotg *hsotg)
 	if (dbg_perio())
 		dev_vdbg(hsotg->dev, "Queue periodic transactions\n");
 
-	tx_status = dwc2_readl(hsotg->regs + HPTXSTS);
+	tx_status = dwc2_readl(hsotg, HPTXSTS);
 	qspcavail = (tx_status & TXSTS_QSPCAVAIL_MASK) >>
 		    TXSTS_QSPCAVAIL_SHIFT;
 	fspcavail = (tx_status & TXSTS_FSPCAVAIL_MASK) >>
@@ -2932,7 +2926,7 @@ static void dwc2_process_periodic_channels(struct dwc2_hsotg *hsotg)
 
 	qh_ptr = hsotg->periodic_sched_assigned.next;
 	while (qh_ptr != &hsotg->periodic_sched_assigned) {
-		tx_status = dwc2_readl(hsotg->regs + HPTXSTS);
+		tx_status = dwc2_readl(hsotg, HPTXSTS);
 		qspcavail = (tx_status & TXSTS_QSPCAVAIL_MASK) >>
 			    TXSTS_QSPCAVAIL_SHIFT;
 		if (qspcavail == 0) {
@@ -3002,10 +2996,10 @@ exit:
 		 * level to ensure that new requests are loaded as
 		 * soon as possible.)
 		 */
-		gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+		gintmsk = dwc2_readl(hsotg, GINTMSK);
 		if (!(gintmsk & GINTSTS_PTXFEMP)) {
 			gintmsk |= GINTSTS_PTXFEMP;
-			dwc2_writel(gintmsk, hsotg->regs + GINTMSK);
+			dwc2_writel(hsotg, gintmsk, GINTMSK);
 		}
 	} else {
 		/*
@@ -3015,10 +3009,10 @@ exit:
 		 * handlers to queue more transactions as transfer
 		 * states change.
 		*/
-		gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+		gintmsk = dwc2_readl(hsotg, GINTMSK);
 		if (gintmsk & GINTSTS_PTXFEMP) {
 			gintmsk &= ~GINTSTS_PTXFEMP;
-			dwc2_writel(gintmsk, hsotg->regs + GINTMSK);
+			dwc2_writel(hsotg, gintmsk, GINTMSK);
 		}
 	}
 }
@@ -3047,7 +3041,7 @@ static void dwc2_process_non_periodic_channels(struct dwc2_hsotg *hsotg)
 
 	dev_vdbg(hsotg->dev, "Queue non-periodic transactions\n");
 
-	tx_status = dwc2_readl(hsotg->regs + GNPTXSTS);
+	tx_status = dwc2_readl(hsotg, GNPTXSTS);
 	qspcavail = (tx_status & TXSTS_QSPCAVAIL_MASK) >>
 		    TXSTS_QSPCAVAIL_SHIFT;
 	fspcavail = (tx_status & TXSTS_FSPCAVAIL_MASK) >>
@@ -3070,7 +3064,7 @@ static void dwc2_process_non_periodic_channels(struct dwc2_hsotg *hsotg)
 	 * available in the request queue or the Tx FIFO
 	 */
 	do {
-		tx_status = dwc2_readl(hsotg->regs + GNPTXSTS);
+		tx_status = dwc2_readl(hsotg, GNPTXSTS);
 		qspcavail = (tx_status & TXSTS_QSPCAVAIL_MASK) >>
 			    TXSTS_QSPCAVAIL_SHIFT;
 		if (hsotg->core_params->dma_enable <= 0 && qspcavail == 0) {
@@ -3107,7 +3101,7 @@ next:
 	} while (hsotg->non_periodic_qh_ptr != orig_qh_ptr);
 
 	if (hsotg->core_params->dma_enable <= 0) {
-		tx_status = dwc2_readl(hsotg->regs + GNPTXSTS);
+		tx_status = dwc2_readl(hsotg, GNPTXSTS);
 		qspcavail = (tx_status & TXSTS_QSPCAVAIL_MASK) >>
 			    TXSTS_QSPCAVAIL_SHIFT;
 		fspcavail = (tx_status & TXSTS_FSPCAVAIL_MASK) >>
@@ -3127,9 +3121,9 @@ next:
 			 * level to ensure that new requests are loaded as
 			 * soon as possible.)
 			 */
-			gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+			gintmsk = dwc2_readl(hsotg, GINTMSK);
 			gintmsk |= GINTSTS_NPTXFEMP;
-			dwc2_writel(gintmsk, hsotg->regs + GINTMSK);
+			dwc2_writel(hsotg, gintmsk, GINTMSK);
 		} else {
 			/*
 			 * Disable the Tx FIFO empty interrupt since there are
@@ -3138,9 +3132,9 @@ next:
 			 * handlers to queue more transactions as transfer
 			 * states change.
 			 */
-			gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+			gintmsk = dwc2_readl(hsotg, GINTMSK);
 			gintmsk &= ~GINTSTS_NPTXFEMP;
-			dwc2_writel(gintmsk, hsotg->regs + GINTMSK);
+			dwc2_writel(hsotg, gintmsk, GINTMSK);
 		}
 	}
 }
@@ -3177,10 +3171,10 @@ void dwc2_hcd_queue_transactions(struct dwc2_hsotg *hsotg,
 			 * Ensure NP Tx FIFO empty interrupt is disabled when
 			 * there are no non-periodic transfers to process
 			 */
-			u32 gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+			u32 gintmsk = dwc2_readl(hsotg, GINTMSK);
 
 			gintmsk &= ~GINTSTS_NPTXFEMP;
-			dwc2_writel(gintmsk, hsotg->regs + GINTMSK);
+			dwc2_writel(hsotg, gintmsk, GINTMSK);
 		}
 	}
 }
@@ -3195,7 +3189,7 @@ static void dwc2_conn_id_status_change(struct work_struct *work)
 
 	dev_dbg(hsotg->dev, "%s()\n", __func__);
 
-	gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+	gotgctl = dwc2_readl(hsotg, GOTGCTL);
 	dev_dbg(hsotg->dev, "gotgctl=%0x\n", gotgctl);
 	dev_dbg(hsotg->dev, "gotgctl.b.conidsts=%d\n",
 		!!(gotgctl & GOTGCTL_CONID_B));
@@ -3260,9 +3254,9 @@ static void dwc2_wakeup_detected(unsigned long data)
 	hprt0 = dwc2_read_hprt0(hsotg);
 	dev_dbg(hsotg->dev, "Resume: HPRT0=%0x\n", hprt0);
 	hprt0 &= ~HPRT0_RES;
-	dwc2_writel(hprt0, hsotg->regs + HPRT0);
+	dwc2_writel(hsotg, hprt0, HPRT0);
 	dev_dbg(hsotg->dev, "Clear Resume: HPRT0=%0x\n",
-		dwc2_readl(hsotg->regs + HPRT0));
+		dwc2_readl(hsotg, HPRT0));
 
 	dwc2_hcd_rem_wakeup(hsotg);
 	hsotg->bus_suspended = 0;
@@ -3291,15 +3285,15 @@ static void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 	spin_lock_irqsave(&hsotg->lock, flags);
 
 	if (windex == hsotg->otg_port && dwc2_host_is_b_hnp_enabled(hsotg)) {
-		gotgctl = dwc2_readl(hsotg->regs + GOTGCTL);
+		gotgctl = dwc2_readl(hsotg, GOTGCTL);
 		gotgctl |= GOTGCTL_HSTSETHNPEN;
-		dwc2_writel(gotgctl, hsotg->regs + GOTGCTL);
+		dwc2_writel(hsotg, gotgctl, GOTGCTL);
 		hsotg->op_state = OTG_STATE_A_SUSPEND;
 	}
 
 	hprt0 = dwc2_read_hprt0(hsotg);
 	hprt0 |= HPRT0_SUSP;
-	dwc2_writel(hprt0, hsotg->regs + HPRT0);
+	dwc2_writel(hsotg, hprt0, HPRT0);
 
 	hsotg->bus_suspended = 1;
 
@@ -3309,17 +3303,17 @@ static void dwc2_port_suspend(struct dwc2_hsotg *hsotg, u16 windex)
 	 */
 	if (!hsotg->core_params->hibernation) {
 		/* Suspend the Phy Clock */
-		pcgctl = dwc2_readl(hsotg->regs + PCGCTL);
+		pcgctl = dwc2_readl(hsotg, PCGCTL);
 		pcgctl |= PCGCTL_STOPPCLK;
-		dwc2_writel(pcgctl, hsotg->regs + PCGCTL);
+		dwc2_writel(hsotg, pcgctl, PCGCTL);
 		udelay(10);
 	}
 
 	/* For HNP the bus must be suspended for at least 200ms */
 	if (dwc2_host_is_b_hnp_enabled(hsotg)) {
-		pcgctl = dwc2_readl(hsotg->regs + PCGCTL);
+		pcgctl = dwc2_readl(hsotg, PCGCTL);
 		pcgctl &= ~PCGCTL_STOPPCLK;
-		dwc2_writel(pcgctl, hsotg->regs + PCGCTL);
+		dwc2_writel(hsotg, pcgctl, PCGCTL);
 
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 
@@ -3343,9 +3337,9 @@ static void dwc2_port_resume(struct dwc2_hsotg *hsotg)
 	 * after registers restore.
 	 */
 	if (!hsotg->core_params->hibernation) {
-		pcgctl = dwc2_readl(hsotg->regs + PCGCTL);
+		pcgctl = dwc2_readl(hsotg, PCGCTL);
 		pcgctl &= ~PCGCTL_STOPPCLK;
-		dwc2_writel(pcgctl, hsotg->regs + PCGCTL);
+		dwc2_writel(hsotg, pcgctl, PCGCTL);
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 		usleep_range(20000, 40000);
 		spin_lock_irqsave(&hsotg->lock, flags);
@@ -3354,7 +3348,7 @@ static void dwc2_port_resume(struct dwc2_hsotg *hsotg)
 	hprt0 = dwc2_read_hprt0(hsotg);
 	hprt0 |= HPRT0_RES;
 	hprt0 &= ~HPRT0_SUSP;
-	dwc2_writel(hprt0, hsotg->regs + HPRT0);
+	dwc2_writel(hsotg, hprt0, HPRT0);
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
 	msleep(USB_RESUME_TIMEOUT);
@@ -3362,7 +3356,7 @@ static void dwc2_port_resume(struct dwc2_hsotg *hsotg)
 	spin_lock_irqsave(&hsotg->lock, flags);
 	hprt0 = dwc2_read_hprt0(hsotg);
 	hprt0 &= ~(HPRT0_RES | HPRT0_SUSP);
-	dwc2_writel(hprt0, hsotg->regs + HPRT0);
+	dwc2_writel(hsotg, hprt0, HPRT0);
 	hsotg->bus_suspended = 0;
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 }
@@ -3406,7 +3400,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 				"ClearPortFeature USB_PORT_FEAT_ENABLE\n");
 			hprt0 = dwc2_read_hprt0(hsotg);
 			hprt0 |= HPRT0_ENA;
-			dwc2_writel(hprt0, hsotg->regs + HPRT0);
+			dwc2_writel(hsotg, hprt0, HPRT0);
 			break;
 
 		case USB_PORT_FEAT_SUSPEND:
@@ -3422,7 +3416,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 				"ClearPortFeature USB_PORT_FEAT_POWER\n");
 			hprt0 = dwc2_read_hprt0(hsotg);
 			hprt0 &= ~HPRT0_PWR;
-			dwc2_writel(hprt0, hsotg->regs + HPRT0);
+			dwc2_writel(hsotg, hprt0, HPRT0);
 			break;
 
 		case USB_PORT_FEAT_INDICATOR:
@@ -3543,7 +3537,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 			break;
 		}
 
-		hprt0 = dwc2_readl(hsotg->regs + HPRT0);
+		hprt0 = dwc2_readl(hsotg, HPRT0);
 		dev_vdbg(hsotg->dev, "  HPRT0: 0x%08x\n", hprt0);
 
 		if (hprt0 & HPRT0_CONNSTS)
@@ -3584,9 +3578,9 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 
 				dev_info(hsotg->dev, "Enabling descriptor DMA mode\n");
 				hsotg->core_params->dma_desc_enable = 1;
-				hcfg = dwc2_readl(hsotg->regs + HCFG);
+				hcfg = dwc2_readl(hsotg, HCFG);
 				hcfg |= HCFG_DESCDMA;
-				dwc2_writel(hcfg, hsotg->regs + HCFG);
+				dwc2_writel(hsotg, hcfg, HCFG);
 				hsotg->new_connection = false;
 			}
 		}
@@ -3630,18 +3624,18 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 				"SetPortFeature - USB_PORT_FEAT_POWER\n");
 			hprt0 = dwc2_read_hprt0(hsotg);
 			hprt0 |= HPRT0_PWR;
-			dwc2_writel(hprt0, hsotg->regs + HPRT0);
+			dwc2_writel(hsotg, hprt0, HPRT0);
 			break;
 
 		case USB_PORT_FEAT_RESET:
 			hprt0 = dwc2_read_hprt0(hsotg);
 			dev_dbg(hsotg->dev,
 				"SetPortFeature - USB_PORT_FEAT_RESET\n");
-			pcgctl = dwc2_readl(hsotg->regs + PCGCTL);
+			pcgctl = dwc2_readl(hsotg, PCGCTL);
 			pcgctl &= ~(PCGCTL_ENBL_SLEEP_GATING | PCGCTL_STOPPCLK);
-			dwc2_writel(pcgctl, hsotg->regs + PCGCTL);
+			dwc2_writel(hsotg, pcgctl, PCGCTL);
 			/* ??? Original driver does this */
-			dwc2_writel(0, hsotg->regs + PCGCTL);
+			dwc2_writel(hsotg, 0, PCGCTL);
 
 			hprt0 = dwc2_read_hprt0(hsotg);
 			/* Clear suspend bit if resetting from suspend state */
@@ -3656,13 +3650,13 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 				hprt0 |= HPRT0_PWR | HPRT0_RST;
 				dev_dbg(hsotg->dev,
 					"In host mode, hprt0=%08x\n", hprt0);
-				dwc2_writel(hprt0, hsotg->regs + HPRT0);
+				dwc2_writel(hsotg, hprt0, HPRT0);
 			}
 
 			/* Clear reset bit in 10ms (FS/LS) or 50ms (HS) */
 			usleep_range(50000, 70000);
 			hprt0 &= ~HPRT0_RST;
-			dwc2_writel(hprt0, hsotg->regs + HPRT0);
+			dwc2_writel(hsotg, hprt0, HPRT0);
 			hsotg->lx_state = DWC2_L0; /* Now back to On state */
 			break;
 
@@ -3678,7 +3672,7 @@ static int dwc2_hcd_hub_control(struct dwc2_hsotg *hsotg, u16 typereq,
 				"SetPortFeature - USB_PORT_FEAT_TEST\n");
 			hprt0 &= ~HPRT0_TSTCTL_MASK;
 			hprt0 |= (windex >> 8) << HPRT0_TSTCTL_SHIFT;
-			dwc2_writel(hprt0, hsotg->regs + HPRT0);
+			dwc2_writel(hsotg, hprt0, HPRT0);
 			break;
 
 		default:
@@ -3735,7 +3729,7 @@ static int dwc2_hcd_is_status_changed(struct dwc2_hsotg *hsotg, int port)
 
 int dwc2_hcd_get_frame_number(struct dwc2_hsotg *hsotg)
 {
-	u32 hfnum = dwc2_readl(hsotg->regs + HFNUM);
+	u32 hfnum = dwc2_readl(hsotg, HFNUM);
 
 #ifdef DWC2_DEBUG_SOF
 	dev_vdbg(hsotg->dev, "DWC OTG HCD GET FRAME NUMBER %d\n",
@@ -3746,9 +3740,9 @@ int dwc2_hcd_get_frame_number(struct dwc2_hsotg *hsotg)
 
 int dwc2_hcd_get_future_frame_number(struct dwc2_hsotg *hsotg, int us)
 {
-	u32 hprt = dwc2_readl(hsotg->regs + HPRT0);
-	u32 hfir = dwc2_readl(hsotg->regs + HFIR);
-	u32 hfnum = dwc2_readl(hsotg->regs + HFNUM);
+	u32 hprt = dwc2_readl(hsotg, HPRT0);
+	u32 hfir = dwc2_readl(hsotg, HFIR);
+	u32 hfnum = dwc2_readl(hsotg, HFNUM);
 	unsigned int us_per_frame;
 	unsigned int frame_number;
 	unsigned int remaining;
@@ -3867,11 +3861,11 @@ void dwc2_hcd_dump_state(struct dwc2_hsotg *hsotg)
 		if (chan->xfer_started) {
 			u32 hfnum, hcchar, hctsiz, hcint, hcintmsk;
 
-			hfnum = dwc2_readl(hsotg->regs + HFNUM);
-			hcchar = dwc2_readl(hsotg->regs + HCCHAR(i));
-			hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(i));
-			hcint = dwc2_readl(hsotg->regs + HCINT(i));
-			hcintmsk = dwc2_readl(hsotg->regs + HCINTMSK(i));
+			hfnum = dwc2_readl(hsotg, HFNUM);
+			hcchar = dwc2_readl(hsotg, HCCHAR(i));
+			hctsiz = dwc2_readl(hsotg, HCTSIZ(i));
+			hcint = dwc2_readl(hsotg, HCINT(i));
+			hcintmsk = dwc2_readl(hsotg, HCINTMSK(i));
 			dev_dbg(hsotg->dev, "    hfnum: 0x%08x\n", hfnum);
 			dev_dbg(hsotg->dev, "    hcchar: 0x%08x\n", hcchar);
 			dev_dbg(hsotg->dev, "    hctsiz: 0x%08x\n", hctsiz);
@@ -3919,12 +3913,12 @@ void dwc2_hcd_dump_state(struct dwc2_hsotg *hsotg)
 	dev_dbg(hsotg->dev, "  periodic_channels: %d\n",
 		hsotg->periodic_channels);
 	dev_dbg(hsotg->dev, "  periodic_usecs: %d\n", hsotg->periodic_usecs);
-	np_tx_status = dwc2_readl(hsotg->regs + GNPTXSTS);
+	np_tx_status = dwc2_readl(hsotg, GNPTXSTS);
 	dev_dbg(hsotg->dev, "  NP Tx Req Queue Space Avail: %d\n",
 		(np_tx_status & TXSTS_QSPCAVAIL_MASK) >> TXSTS_QSPCAVAIL_SHIFT);
 	dev_dbg(hsotg->dev, "  NP Tx FIFO Space Avail: %d\n",
 		(np_tx_status & TXSTS_FSPCAVAIL_MASK) >> TXSTS_FSPCAVAIL_SHIFT);
-	p_tx_status = dwc2_readl(hsotg->regs + HPTXSTS);
+	p_tx_status = dwc2_readl(hsotg, HPTXSTS);
 	dev_dbg(hsotg->dev, "  P Tx Req Queue Space Avail: %d\n",
 		(p_tx_status & TXSTS_QSPCAVAIL_MASK) >> TXSTS_QSPCAVAIL_SHIFT);
 	dev_dbg(hsotg->dev, "  P Tx FIFO Space Avail: %d\n",
@@ -4275,7 +4269,7 @@ static void dwc2_hcd_reset_func(struct work_struct *work)
 
 	hprt0 = dwc2_read_hprt0(hsotg);
 	hprt0 &= ~HPRT0_RST;
-	dwc2_writel(hprt0, hsotg->regs + HPRT0);
+	dwc2_writel(hsotg, hprt0, HPRT0);
 	hsotg->flags.b.port_reset_change = 1;
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
@@ -4376,7 +4370,7 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 		hprt0 = dwc2_read_hprt0(hsotg);
 		hprt0 |= HPRT0_SUSP;
 		hprt0 &= ~HPRT0_PWR;
-		dwc2_writel(hprt0, hsotg->regs + HPRT0);
+		dwc2_writel(hsotg, hprt0, HPRT0);
 	}
 
 	/* Enter hibernation */
@@ -4461,8 +4455,8 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 		 * Clear Port Enable and Port Status changes.
 		 * Enable Port Power.
 		 */
-		dwc2_writel(HPRT0_PWR | HPRT0_CONNDET |
-				HPRT0_ENACHG, hsotg->regs + HPRT0);
+		dwc2_writel(hsotg, HPRT0_PWR | HPRT0_CONNDET | HPRT0_ENACHG,
+			    HPRT0);
 		/* Wait for controller to detect Port Connect */
 		usleep_range(5000, 7000);
 	}
@@ -4931,17 +4925,17 @@ static void dwc2_hcd_free(struct dwc2_hsotg *hsotg)
 		hsotg->status_buf = NULL;
 	}
 
-	ahbcfg = dwc2_readl(hsotg->regs + GAHBCFG);
+	ahbcfg = dwc2_readl(hsotg, GAHBCFG);
 
 	/* Disable all interrupts */
 	ahbcfg &= ~GAHBCFG_GLBL_INTR_EN;
-	dwc2_writel(ahbcfg, hsotg->regs + GAHBCFG);
-	dwc2_writel(0, hsotg->regs + GINTMSK);
+	dwc2_writel(hsotg, ahbcfg, GAHBCFG);
+	dwc2_writel(hsotg, 0, GINTMSK);
 
 	if (hsotg->hw_params.snpsid >= DWC2_CORE_REV_3_00a) {
-		dctl = dwc2_readl(hsotg->regs + DCTL);
+		dctl = dwc2_readl(hsotg, DCTL);
 		dctl |= DCTL_SFTDISCON;
-		dwc2_writel(dctl, hsotg->regs + DCTL);
+		dwc2_writel(hsotg, dctl, DCTL);
 	}
 
 	if (hsotg->wq_otg) {
@@ -4982,7 +4976,7 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg, int irq)
 
 	retval = -ENOMEM;
 
-	hcfg = dwc2_readl(hsotg->regs + HCFG);
+	hcfg = dwc2_readl(hsotg, HCFG);
 	dev_dbg(hsotg->dev, "hcfg=%08x\n", hcfg);
 
 #ifdef CONFIG_USB_DWC2_TRACK_MISSED_SOFS
@@ -5248,13 +5242,13 @@ int dwc2_backup_host_registers(struct dwc2_hsotg *hsotg)
 
 	/* Backup Host regs */
 	hr = &hsotg->hr_backup;
-	hr->hcfg = dwc2_readl(hsotg->regs + HCFG);
-	hr->haintmsk = dwc2_readl(hsotg->regs + HAINTMSK);
+	hr->hcfg = dwc2_readl(hsotg, HCFG);
+	hr->haintmsk = dwc2_readl(hsotg, HAINTMSK);
 	for (i = 0; i < hsotg->core_params->host_channels; ++i)
-		hr->hcintmsk[i] = dwc2_readl(hsotg->regs + HCINTMSK(i));
+		hr->hcintmsk[i] = dwc2_readl(hsotg, HCINTMSK(i));
 
 	hr->hprt0 = dwc2_read_hprt0(hsotg);
-	hr->hfir = dwc2_readl(hsotg->regs + HFIR);
+	hr->hfir = dwc2_readl(hsotg, HFIR);
 	hr->valid = true;
 
 	return 0;
@@ -5283,14 +5277,14 @@ int dwc2_restore_host_registers(struct dwc2_hsotg *hsotg)
 	}
 	hr->valid = false;
 
-	dwc2_writel(hr->hcfg, hsotg->regs + HCFG);
-	dwc2_writel(hr->haintmsk, hsotg->regs + HAINTMSK);
+	dwc2_writel(hsotg, hr->hcfg, HCFG);
+	dwc2_writel(hsotg, hr->haintmsk, HAINTMSK);
 
 	for (i = 0; i < hsotg->core_params->host_channels; ++i)
-		dwc2_writel(hr->hcintmsk[i], hsotg->regs + HCINTMSK(i));
+		dwc2_writel(hsotg, hr->hcintmsk[i], HCINTMSK(i));
 
-	dwc2_writel(hr->hprt0, hsotg->regs + HPRT0);
-	dwc2_writel(hr->hfir, hsotg->regs + HFIR);
+	dwc2_writel(hsotg, hr->hprt0, HPRT0);
+	dwc2_writel(hsotg, hr->hfir, HFIR);
 	hsotg->frame_number = 0;
 
 	return 0;
diff --git a/drivers/usb/dwc2/hcd.h b/drivers/usb/dwc2/hcd.h
index 7758bfb..880549e 100644
--- a/drivers/usb/dwc2/hcd.h
+++ b/drivers/usb/dwc2/hcd.h
@@ -447,10 +447,10 @@ static inline struct usb_hcd *dwc2_hsotg_to_hcd(struct dwc2_hsotg *hsotg)
  */
 static inline void disable_hc_int(struct dwc2_hsotg *hsotg, int chnum, u32 intr)
 {
-	u32 mask = dwc2_readl(hsotg->regs + HCINTMSK(chnum));
+	u32 mask = dwc2_readl(hsotg, HCINTMSK(chnum));
 
 	mask &= ~intr;
-	dwc2_writel(mask, hsotg->regs + HCINTMSK(chnum));
+	dwc2_writel(hsotg, mask, HCINTMSK(chnum));
 }
 
 void dwc2_hc_cleanup(struct dwc2_hsotg *hsotg, struct dwc2_host_chan *chan);
@@ -465,7 +465,7 @@ void dwc2_hc_start_transfer_ddma(struct dwc2_hsotg *hsotg,
  */
 static inline u32 dwc2_read_hprt0(struct dwc2_hsotg *hsotg)
 {
-	u32 hprt0 = dwc2_readl(hsotg->regs + HPRT0);
+	u32 hprt0 = dwc2_readl(hsotg, HPRT0);
 
 	hprt0 &= ~(HPRT0_ENA | HPRT0_CONNDET | HPRT0_ENACHG | HPRT0_OVRCURRCHG);
 	return hprt0;
@@ -668,8 +668,8 @@ static inline u16 dwc2_micro_frame_num(u16 frame)
  */
 static inline u32 dwc2_read_core_intr(struct dwc2_hsotg *hsotg)
 {
-	return dwc2_readl(hsotg->regs + GINTSTS) &
-	       dwc2_readl(hsotg->regs + GINTMSK);
+	return dwc2_readl(hsotg, GINTSTS) &
+	       dwc2_readl(hsotg, GINTMSK);
 }
 
 static inline u32 dwc2_hcd_urb_get_status(struct dwc2_hcd_urb *dwc2_urb)
diff --git a/drivers/usb/dwc2/hcd_ddma.c b/drivers/usb/dwc2/hcd_ddma.c
index 0e1d42b..8c329e7 100644
--- a/drivers/usb/dwc2/hcd_ddma.c
+++ b/drivers/usb/dwc2/hcd_ddma.c
@@ -185,19 +185,19 @@ static void dwc2_per_sched_enable(struct dwc2_hsotg *hsotg, u32 fr_list_en)
 
 	spin_lock_irqsave(&hsotg->lock, flags);
 
-	hcfg = dwc2_readl(hsotg->regs + HCFG);
+	hcfg = dwc2_readl(hsotg, HCFG);
 	if (hcfg & HCFG_PERSCHEDENA) {
 		/* already enabled */
 		spin_unlock_irqrestore(&hsotg->lock, flags);
 		return;
 	}
 
-	dwc2_writel(hsotg->frame_list_dma, hsotg->regs + HFLBADDR);
+	dwc2_writel(hsotg, hsotg->frame_list_dma, HFLBADDR);
 
 	hcfg &= ~HCFG_FRLISTEN_MASK;
 	hcfg |= fr_list_en | HCFG_PERSCHEDENA;
 	dev_vdbg(hsotg->dev, "Enabling Periodic schedule\n");
-	dwc2_writel(hcfg, hsotg->regs + HCFG);
+	dwc2_writel(hsotg, hcfg, HCFG);
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 }
@@ -209,7 +209,7 @@ static void dwc2_per_sched_disable(struct dwc2_hsotg *hsotg)
 
 	spin_lock_irqsave(&hsotg->lock, flags);
 
-	hcfg = dwc2_readl(hsotg->regs + HCFG);
+	hcfg = dwc2_readl(hsotg, HCFG);
 	if (!(hcfg & HCFG_PERSCHEDENA)) {
 		/* already disabled */
 		spin_unlock_irqrestore(&hsotg->lock, flags);
@@ -218,7 +218,7 @@ static void dwc2_per_sched_disable(struct dwc2_hsotg *hsotg)
 
 	hcfg &= ~HCFG_PERSCHEDENA;
 	dev_vdbg(hsotg->dev, "Disabling Periodic schedule\n");
-	dwc2_writel(hcfg, hsotg->regs + HCFG);
+	dwc2_writel(hsotg, hcfg, HCFG);
 
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 }
diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index 906f223..1faf0430 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -137,7 +137,7 @@ static void dwc2_sof_intr(struct dwc2_hsotg *hsotg)
 	enum dwc2_transaction_type tr_type;
 
 	/* Clear interrupt */
-	dwc2_writel(GINTSTS_SOF, hsotg->regs + GINTSTS);
+	dwc2_writel(hsotg, GINTSTS_SOF, GINTSTS);
 
 #ifdef DEBUG_SOF
 	dev_vdbg(hsotg->dev, "--Start of Frame Interrupt--\n");
@@ -184,7 +184,7 @@ static void dwc2_rx_fifo_level_intr(struct dwc2_hsotg *hsotg)
 	if (dbg_perio())
 		dev_vdbg(hsotg->dev, "--RxFIFO Level Interrupt--\n");
 
-	grxsts = dwc2_readl(hsotg->regs + GRXSTSP);
+	grxsts = dwc2_readl(hsotg, GRXSTSP);
 	chnum = (grxsts & GRXSTS_HCHNUM_MASK) >> GRXSTS_HCHNUM_SHIFT;
 	chan = hsotg->hc_ptr_array[chnum];
 	if (!chan) {
@@ -267,11 +267,11 @@ static void dwc2_hprt0_enable(struct dwc2_hsotg *hsotg, u32 hprt0,
 	dev_vdbg(hsotg->dev, "%s(%p)\n", __func__, hsotg);
 
 	/* Every time when port enables calculate HFIR.FrInterval */
-	hfir = dwc2_readl(hsotg->regs + HFIR);
+	hfir = dwc2_readl(hsotg, HFIR);
 	hfir &= ~HFIR_FRINT_MASK;
 	hfir |= dwc2_calc_frame_interval(hsotg) << HFIR_FRINT_SHIFT &
 		HFIR_FRINT_MASK;
-	dwc2_writel(hfir, hsotg->regs + HFIR);
+	dwc2_writel(hsotg, hfir, HFIR);
 
 	/* Check if we need to adjust the PHY clock speed for low power */
 	if (!params->host_support_fs_ls_low_power) {
@@ -280,7 +280,7 @@ static void dwc2_hprt0_enable(struct dwc2_hsotg *hsotg, u32 hprt0,
 		return;
 	}
 
-	usbcfg = dwc2_readl(hsotg->regs + GUSBCFG);
+	usbcfg = dwc2_readl(hsotg, GUSBCFG);
 	prtspd = (hprt0 & HPRT0_SPD_MASK) >> HPRT0_SPD_SHIFT;
 
 	if (prtspd == HPRT0_SPD_LOW_SPEED || prtspd == HPRT0_SPD_FULL_SPEED) {
@@ -288,11 +288,11 @@ static void dwc2_hprt0_enable(struct dwc2_hsotg *hsotg, u32 hprt0,
 		if (!(usbcfg & GUSBCFG_PHY_LP_CLK_SEL)) {
 			/* Set PHY low power clock select for FS/LS devices */
 			usbcfg |= GUSBCFG_PHY_LP_CLK_SEL;
-			dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+			dwc2_writel(hsotg, usbcfg, GUSBCFG);
 			do_reset = 1;
 		}
 
-		hcfg = dwc2_readl(hsotg->regs + HCFG);
+		hcfg = dwc2_readl(hsotg, HCFG);
 		fslspclksel = (hcfg & HCFG_FSLSPCLKSEL_MASK) >>
 			      HCFG_FSLSPCLKSEL_SHIFT;
 
@@ -306,7 +306,7 @@ static void dwc2_hprt0_enable(struct dwc2_hsotg *hsotg, u32 hprt0,
 				fslspclksel = HCFG_FSLSPCLKSEL_6_MHZ;
 				hcfg &= ~HCFG_FSLSPCLKSEL_MASK;
 				hcfg |= fslspclksel << HCFG_FSLSPCLKSEL_SHIFT;
-				dwc2_writel(hcfg, hsotg->regs + HCFG);
+				dwc2_writel(hsotg, hcfg, HCFG);
 				do_reset = 1;
 			}
 		} else {
@@ -317,7 +317,7 @@ static void dwc2_hprt0_enable(struct dwc2_hsotg *hsotg, u32 hprt0,
 				fslspclksel = HCFG_FSLSPCLKSEL_48_MHZ;
 				hcfg &= ~HCFG_FSLSPCLKSEL_MASK;
 				hcfg |= fslspclksel << HCFG_FSLSPCLKSEL_SHIFT;
-				dwc2_writel(hcfg, hsotg->regs + HCFG);
+				dwc2_writel(hsotg, hcfg, HCFG);
 				do_reset = 1;
 			}
 		}
@@ -325,14 +325,14 @@ static void dwc2_hprt0_enable(struct dwc2_hsotg *hsotg, u32 hprt0,
 		/* Not low power */
 		if (usbcfg & GUSBCFG_PHY_LP_CLK_SEL) {
 			usbcfg &= ~GUSBCFG_PHY_LP_CLK_SEL;
-			dwc2_writel(usbcfg, hsotg->regs + GUSBCFG);
+			dwc2_writel(hsotg, usbcfg, GUSBCFG);
 			do_reset = 1;
 		}
 	}
 
 	if (do_reset) {
 		*hprt0_modify |= HPRT0_RST;
-		dwc2_writel(*hprt0_modify, hsotg->regs + HPRT0);
+		dwc2_writel(hsotg, *hprt0_modify, HPRT0);
 		queue_delayed_work(hsotg->wq_otg, &hsotg->reset_work,
 				   msecs_to_jiffies(60));
 	} else {
@@ -353,7 +353,7 @@ static void dwc2_port_intr(struct dwc2_hsotg *hsotg)
 
 	dev_vdbg(hsotg->dev, "--Port Interrupt--\n");
 
-	hprt0 = dwc2_readl(hsotg->regs + HPRT0);
+	hprt0 = dwc2_readl(hsotg, HPRT0);
 	hprt0_modify = hprt0;
 
 	/*
@@ -368,7 +368,7 @@ static void dwc2_port_intr(struct dwc2_hsotg *hsotg)
 	 * Set flag and clear if detected
 	 */
 	if (hprt0 & HPRT0_CONNDET) {
-		dwc2_writel(hprt0_modify | HPRT0_CONNDET, hsotg->regs + HPRT0);
+		dwc2_writel(hsotg, hprt0_modify | HPRT0_CONNDET, HPRT0);
 
 		dev_vdbg(hsotg->dev,
 			 "--Port Interrupt HPRT0=0x%08x Port Connect Detected--\n",
@@ -386,7 +386,7 @@ static void dwc2_port_intr(struct dwc2_hsotg *hsotg)
 	 * Clear if detected - Set internal flag if disabled
 	 */
 	if (hprt0 & HPRT0_ENACHG) {
-		dwc2_writel(hprt0_modify | HPRT0_ENACHG, hsotg->regs + HPRT0);
+		dwc2_writel(hsotg, hprt0_modify | HPRT0_ENACHG, HPRT0);
 		dev_vdbg(hsotg->dev,
 			 "  --Port Interrupt HPRT0=0x%08x Port Enable Changed (now %d)--\n",
 			 hprt0, !!(hprt0 & HPRT0_ENA));
@@ -400,17 +400,16 @@ static void dwc2_port_intr(struct dwc2_hsotg *hsotg)
 
 				hsotg->core_params->dma_desc_enable = 0;
 				hsotg->new_connection = false;
-				hcfg = dwc2_readl(hsotg->regs + HCFG);
+				hcfg = dwc2_readl(hsotg, HCFG);
 				hcfg &= ~HCFG_DESCDMA;
-				dwc2_writel(hcfg, hsotg->regs + HCFG);
+				dwc2_writel(hsotg, hcfg, HCFG);
 			}
 		}
 	}
 
 	/* Overcurrent Change Interrupt */
 	if (hprt0 & HPRT0_OVRCURRCHG) {
-		dwc2_writel(hprt0_modify | HPRT0_OVRCURRCHG,
-			    hsotg->regs + HPRT0);
+		dwc2_writel(hsotg, hprt0_modify | HPRT0_OVRCURRCHG, HPRT0);
 		dev_vdbg(hsotg->dev,
 			 "  --Port Interrupt HPRT0=0x%08x Port Overcurrent Changed--\n",
 			 hprt0);
@@ -435,7 +434,7 @@ static u32 dwc2_get_actual_xfer_length(struct dwc2_hsotg *hsotg,
 {
 	u32 hctsiz, count, length;
 
-	hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(chnum));
+	hctsiz = dwc2_readl(hsotg, HCTSIZ(chnum));
 
 	if (halt_status == DWC2_HC_XFER_COMPLETE) {
 		if (chan->ep_is_in) {
@@ -506,7 +505,7 @@ static int dwc2_update_urb_state(struct dwc2_hsotg *hsotg,
 		urb->status = 0;
 	}
 
-	hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(chnum));
+	hctsiz = dwc2_readl(hsotg, HCTSIZ(chnum));
 	dev_vdbg(hsotg->dev, "DWC_otg: %s: %s, channel %d\n",
 		 __func__, (chan->ep_is_in ? "IN" : "OUT"), chnum);
 	dev_vdbg(hsotg->dev, "  chan->xfer_len %d\n", chan->xfer_len);
@@ -529,7 +528,7 @@ void dwc2_hcd_save_data_toggle(struct dwc2_hsotg *hsotg,
 			       struct dwc2_host_chan *chan, int chnum,
 			       struct dwc2_qtd *qtd)
 {
-	u32 hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(chnum));
+	u32 hctsiz = dwc2_readl(hsotg, HCTSIZ(chnum));
 	u32 pid = (hctsiz & TSIZ_SC_MC_PID_MASK) >> TSIZ_SC_MC_PID_SHIFT;
 
 	if (chan->ep_type != USB_ENDPOINT_XFER_CONTROL) {
@@ -762,9 +761,9 @@ cleanup:
 		}
 	}
 
-	haintmsk = dwc2_readl(hsotg->regs + HAINTMSK);
+	haintmsk = dwc2_readl(hsotg, HAINTMSK);
 	haintmsk &= ~(1 << chan->hc_num);
-	dwc2_writel(haintmsk, hsotg->regs + HAINTMSK);
+	dwc2_writel(hsotg, haintmsk, HAINTMSK);
 
 	/* Try to queue more transfers now that there's a free channel */
 	tr_type = dwc2_hcd_select_transactions(hsotg);
@@ -811,9 +810,9 @@ static void dwc2_halt_channel(struct dwc2_hsotg *hsotg,
 			 * is enabled so that the non-periodic schedule will
 			 * be processed
 			 */
-			gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+			gintmsk = dwc2_readl(hsotg, GINTMSK);
 			gintmsk |= GINTSTS_NPTXFEMP;
-			dwc2_writel(gintmsk, hsotg->regs + GINTMSK);
+			dwc2_writel(hsotg, gintmsk, GINTMSK);
 		} else {
 			dev_vdbg(hsotg->dev, "isoc/intr\n");
 			/*
@@ -830,9 +829,9 @@ static void dwc2_halt_channel(struct dwc2_hsotg *hsotg,
 			 * enabled so that the periodic schedule will be
 			 * processed
 			 */
-			gintmsk = dwc2_readl(hsotg->regs + GINTMSK);
+			gintmsk = dwc2_readl(hsotg, GINTMSK);
 			gintmsk |= GINTSTS_PTXFEMP;
-			dwc2_writel(gintmsk, hsotg->regs + GINTMSK);
+			dwc2_writel(hsotg, gintmsk, GINTMSK);
 		}
 	}
 }
@@ -897,7 +896,7 @@ static void dwc2_complete_periodic_xfer(struct dwc2_hsotg *hsotg,
 					struct dwc2_qtd *qtd,
 					enum dwc2_halt_status halt_status)
 {
-	u32 hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(chnum));
+	u32 hctsiz = dwc2_readl(hsotg, HCTSIZ(chnum));
 
 	qtd->error_count = 0;
 
@@ -1154,7 +1153,7 @@ static void dwc2_update_urb_state_abn(struct dwc2_hsotg *hsotg,
 
 	urb->actual_length += xfer_length;
 
-	hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(chnum));
+	hctsiz = dwc2_readl(hsotg, HCTSIZ(chnum));
 	dev_vdbg(hsotg->dev, "DWC_otg: %s: %s, channel %d\n",
 		 __func__, (chan->ep_is_in ? "IN" : "OUT"), chnum);
 	dev_vdbg(hsotg->dev, "  chan->start_pkt_count %d\n",
@@ -1511,10 +1510,10 @@ static void dwc2_hc_ahberr_intr(struct dwc2_hsotg *hsotg,
 
 	dwc2_hc_handle_tt_clear(hsotg, chan, qtd);
 
-	hcchar = dwc2_readl(hsotg->regs + HCCHAR(chnum));
-	hcsplt = dwc2_readl(hsotg->regs + HCSPLT(chnum));
-	hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(chnum));
-	hc_dma = dwc2_readl(hsotg->regs + HCDMA(chnum));
+	hcchar = dwc2_readl(hsotg, HCCHAR(chnum));
+	hcsplt = dwc2_readl(hsotg, HCSPLT(chnum));
+	hctsiz = dwc2_readl(hsotg, HCTSIZ(chnum));
+	hc_dma = dwc2_readl(hsotg, HCDMA(chnum));
 
 	dev_err(hsotg->dev, "AHB ERROR, Channel %d\n", chnum);
 	dev_err(hsotg->dev, "  hcchar 0x%08x, hcsplt 0x%08x\n", hcchar, hcsplt);
@@ -1727,10 +1726,10 @@ static bool dwc2_halt_status_ok(struct dwc2_hsotg *hsotg,
 		 * This code is here only as a check. This condition should
 		 * never happen. Ignore the halt if it does occur.
 		 */
-		hcchar = dwc2_readl(hsotg->regs + HCCHAR(chnum));
-		hctsiz = dwc2_readl(hsotg->regs + HCTSIZ(chnum));
-		hcintmsk = dwc2_readl(hsotg->regs + HCINTMSK(chnum));
-		hcsplt = dwc2_readl(hsotg->regs + HCSPLT(chnum));
+		hcchar = dwc2_readl(hsotg, HCCHAR(chnum));
+		hctsiz = dwc2_readl(hsotg, HCTSIZ(chnum));
+		hcintmsk = dwc2_readl(hsotg, HCINTMSK(chnum));
+		hcsplt = dwc2_readl(hsotg, HCSPLT(chnum));
 		dev_dbg(hsotg->dev,
 			"%s: chan->halt_status DWC2_HC_XFER_NO_HALT_STATUS,\n",
 			 __func__);
@@ -1754,7 +1753,7 @@ static bool dwc2_halt_status_ok(struct dwc2_hsotg *hsotg,
 	 * when the halt interrupt occurs. Halt the channel again if it does
 	 * occur.
 	 */
-	hcchar = dwc2_readl(hsotg->regs + HCCHAR(chnum));
+	hcchar = dwc2_readl(hsotg, HCCHAR(chnum));
 	if (hcchar & HCCHAR_CHDIS) {
 		dev_warn(hsotg->dev,
 			 "%s: hcchar.chdis set unexpectedly, hcchar 0x%08x, trying to halt again\n",
@@ -1814,7 +1813,7 @@ static void dwc2_hc_chhltd_intr_dma(struct dwc2_hsotg *hsotg,
 		return;
 	}
 
-	hcintmsk = dwc2_readl(hsotg->regs + HCINTMSK(chnum));
+	hcintmsk = dwc2_readl(hsotg, HCINTMSK(chnum));
 
 	if (chan->hcint & HCINTMSK_XFERCOMPL) {
 		/*
@@ -1909,7 +1908,7 @@ static void dwc2_hc_chhltd_intr_dma(struct dwc2_hsotg *hsotg,
 				dev_err(hsotg->dev,
 					"hcint 0x%08x, intsts 0x%08x\n",
 					chan->hcint,
-					dwc2_readl(hsotg->regs + GINTSTS));
+					dwc2_readl(hsotg, GINTSTS));
 				goto error;
 			}
 		}
@@ -1982,11 +1981,11 @@ static void dwc2_hc_n_intr(struct dwc2_hsotg *hsotg, int chnum)
 
 	chan = hsotg->hc_ptr_array[chnum];
 
-	hcint = dwc2_readl(hsotg->regs + HCINT(chnum));
-	hcintmsk = dwc2_readl(hsotg->regs + HCINTMSK(chnum));
+	hcint = dwc2_readl(hsotg, HCINT(chnum));
+	hcintmsk = dwc2_readl(hsotg, HCINTMSK(chnum));
 	if (!chan) {
 		dev_err(hsotg->dev, "## hc_ptr_array for channel is NULL ##\n");
-		dwc2_writel(hcint, hsotg->regs + HCINT(chnum));
+		dwc2_writel(hsotg, hcint, HCINT(chnum));
 		return;
 	}
 
@@ -1998,7 +1997,7 @@ static void dwc2_hc_n_intr(struct dwc2_hsotg *hsotg, int chnum)
 			 hcint, hcintmsk, hcint & hcintmsk);
 	}
 
-	dwc2_writel(hcint, hsotg->regs + HCINT(chnum));
+	dwc2_writel(hsotg, hcint, HCINT(chnum));
 
 	/*
 	 * If we got an interrupt after someone called
@@ -2133,7 +2132,7 @@ static void dwc2_hc_intr(struct dwc2_hsotg *hsotg)
 	int i;
 	struct dwc2_host_chan *chan, *chan_tmp;
 
-	haint = dwc2_readl(hsotg->regs + HAINT);
+	haint = dwc2_readl(hsotg, HAINT);
 	if (dbg_perio()) {
 		dev_vdbg(hsotg->dev, "%s()\n", __func__);
 
@@ -2217,8 +2216,8 @@ irqreturn_t dwc2_handle_hcd_intr(struct dwc2_hsotg *hsotg)
 				 "DWC OTG HCD Finished Servicing Interrupts\n");
 			dev_vdbg(hsotg->dev,
 				 "DWC OTG HCD gintsts=0x%08x gintmsk=0x%08x\n",
-				 dwc2_readl(hsotg->regs + GINTSTS),
-				 dwc2_readl(hsotg->regs + GINTMSK));
+				 dwc2_readl(hsotg, GINTSTS),
+				 dwc2_readl(hsotg, GINTMSK));
 		}
 	}
 
diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
index b5c7793..e6e0185 100644
--- a/drivers/usb/dwc2/hcd_queue.c
+++ b/drivers/usb/dwc2/hcd_queue.c
@@ -1455,7 +1455,7 @@ static void dwc2_qh_init(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh,
 	bool ep_is_in = !!dwc2_hcd_is_pipe_in(&urb->pipe_info);
 	bool ep_is_isoc = (ep_type == USB_ENDPOINT_XFER_ISOC);
 	bool ep_is_int = (ep_type == USB_ENDPOINT_XFER_INT);
-	u32 hprt = dwc2_readl(hsotg->regs + HPRT0);
+	u32 hprt = dwc2_readl(hsotg, HPRT0);
 	u32 prtspd = (hprt & HPRT0_SPD_MASK) >> HPRT0_SPD_SHIFT;
 	bool do_split = (prtspd == HPRT0_SPD_HIGH_SPEED &&
 			 dev_speed != USB_SPEED_HIGH);
@@ -1673,9 +1673,9 @@ int dwc2_hcd_qh_add(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 	if (status)
 		return status;
 	if (!hsotg->periodic_qh_count) {
-		intr_mask = dwc2_readl(hsotg->regs + GINTMSK);
+		intr_mask = dwc2_readl(hsotg, GINTMSK);
 		intr_mask |= GINTSTS_SOF;
-		dwc2_writel(intr_mask, hsotg->regs + GINTMSK);
+		dwc2_writel(hsotg, intr_mask, GINTMSK);
 	}
 	hsotg->periodic_qh_count++;
 
@@ -1711,9 +1711,9 @@ void dwc2_hcd_qh_unlink(struct dwc2_hsotg *hsotg, struct dwc2_qh *qh)
 	hsotg->periodic_qh_count--;
 	if (!hsotg->periodic_qh_count &&
 	    hsotg->core_params->dma_desc_enable <= 0) {
-		intr_mask = dwc2_readl(hsotg->regs + GINTMSK);
+		intr_mask = dwc2_readl(hsotg, GINTMSK);
 		intr_mask &= ~GINTSTS_SOF;
-		dwc2_writel(intr_mask, hsotg->regs + GINTMSK);
+		dwc2_writel(hsotg, intr_mask, GINTMSK);
 	}
 }
 
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index fc6f525..0ad6155 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -564,6 +564,10 @@ static int dwc2_driver_probe(struct platform_device *dev)
 	if (retval)
 		goto error;
 
+	retval = dwc2_detect_endiannes(hsotg);
+	if (retval)
+		goto error;
+
 	/*
 	 * Reset before dwc2_get_hwparams() then it could get power-on real
 	 * reset value form registers.
