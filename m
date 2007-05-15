Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 7489BDDEDB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 May 2007 17:27:33 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: USB support for Bamboo/440EP (Yosemite/440EPx)
Date: Tue, 15 May 2007 09:27:29 +0200
References: <OFC56C5EA1.CC32B615-ON872572DB.0063BF4F-852572DB.00653577@us.ibm.com>
In-Reply-To: <OFC56C5EA1.CC32B615-ON872572DB.0063BF4F-852572DB.00653577@us.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_hDWSGQQ59+G9sS9"
Message-Id: <200705150927.29798.g.jaeger@sysgo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--Boundary-00=_hDWSGQQ59+G9sS9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Montag, 14. Mai 2007, Stephen Winiecki wrote:
> Gerhard Jaeger <g.jaeger@sysgo.com> wrote on 05/14/2007 10:31:04 AM:
> > Hi Stephen, 
> > 
> > I also played with Bamboo and Yosemite USB and found out, that the OHCI
> > ISR contains an assumption that makes the 440 OHCI implementation sometimes 
> > stop when having a timeout condition. Find the following sequence @function
> > ohci_irq() (in file ohci-hcd.c) and disable the following code:
> > 
> >         if ((ohci->hcca->done_head != 0)
> >                         && ! (hc32_to_cpup (ohci, &ohci->hcca->done_head)
> >                                 & 0x01)) {
> >                 ints =  OHCI_INTR_WDH;
> >    }
> > 
> > This should make the USB host work reliably on the 440s.
> > 
> Thanks Gerhard.  This definitely makes things work better - I have had 
> 100% success in both the kernel and X recognizing the devices and having X 
> boot with this update.
> 
> However, I am occasionally still having an issue after X comes up with the 
> keyboard not working (mouse working fine).  Just to be clear - I only want 
> to comment out the code you indicated above - not also any/either of the 
> else/if clauses, correct?

Yes - the lines mentioned didn't care about irq-status register
and try to figure out from some context, how the irq-status register
should look like - but this in fact does not work correctly for the
440 OHCI implementation... 

> So has this never been formally reported/patched?  

Not that I'm aware of, I discovered that a few days ago.

> Do you know also why  
> the USB support has not been configured in the mainline kernel for these 
> platforms - is it due to known existing issues? 

I don't know why this is not part of the mainline kernel. On the PPC
side there is currently a lot of restructure work going on, so I guess
this is only a question of time, when the necessary patches will go
into the mainline.

Please find the patch for the ohc-hcd.c in the attachment.

Ciao,
Gerhard

-- 
Gerhard Jaeger <gjaeger@sysgo.com>            
SYSGO AG                      Embedded and Real-Time Software
www.sysgo.com | www.elinos.com | www.pikeos.com | www.osek.de 

--Boundary-00=_hDWSGQQ59+G9sS9
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="ppc440-ohci.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="ppc440-ohci.patch"

This patch makes the OHCI code work correctly on AMCC PPC440
cpus with internal USB-host controller. It seems that the
optimization is not allowed for this OHCI implementation.

Signed-off-by: Gerhard Jaeger <gjaeger@sysgo.com>
---


--- linux/drivers/usb/host/ohci-hcd.c.orig	2007-03-09 11:33:39.000000000 +0100
+++ linux/drivers/usb/host/ohci-hcd.c	2007-05-15 09:03:50.000000000 +0200
@@ -646,13 +646,16 @@ static irqreturn_t ohci_irq (struct usb_
 
 	/* we can eliminate a (slow) ohci_readl()
 	   if _only_ WDH caused this irq */
+#if !(defined(CONFIG_USB_OHCI_HCD_PPC_SOC) && (defined(CONFIG_440EP) || defined(CONFIG_440EPX)))
 	if ((ohci->hcca->done_head != 0)
 			&& ! (hc32_to_cpup (ohci, &ohci->hcca->done_head)
 				& 0x01)) {
 		ints =  OHCI_INTR_WDH;
 
 	/* cardbus/... hardware gone before remove() */
-	} else if ((ints = ohci_readl (ohci, &regs->intrstatus)) == ~(u32)0) {
+	} else 
+#endif
+	if ((ints = ohci_readl (ohci, &regs->intrstatus)) == ~(u32)0) {
 		disable (ohci);
 		ohci_dbg (ohci, "device removed!\n");
 		return IRQ_HANDLED;

--Boundary-00=_hDWSGQQ59+G9sS9--
