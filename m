Return-Path: <rjw@sisk.pl>
Received: from anf141.internetdsl.tpnet.pl (anf141.internetdsl.tpnet.pl
	[83.17.87.141]) by ozlabs.org (Postfix) with ESMTP id D74BE68826
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2005 08:13:19 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 24 Nov 2005 22:14:15 +0100
References: <1132715288.26560.262.camel@gaston>
	<200511242150.23205.rjw@sisk.pl>
	<1132866088.26560.455.camel@gaston>
In-Reply-To: <1132866088.26560.455.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200511242214.16365.rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday, 24 of November 2005 22:01, Benjamin Herrenschmidt wrote:
> 
> > 
> > Well, it's there (actually the problem occurs in vanilla 2.6.15-rc2-mm1 that
> > contains the patch).  Do you mean it should go before the
> > 
> > if (readl(&ehci->regs->configured_flag) != FLAG_CF)
> > 		goto restart;
> > 
> > thing?
> 
> Yes.
> 
> > > It may be worth following it with a memory barrier actually... just in case
> > > (due to the absence of locks in that area).
> > 
> > wmb()?
> 
> Yup.
> 
> I wrote that patch against a tree that had different things in that
> function, Greg merged it by hand but he got that little bit wrong
> unfortunately. I'll send a new patch later today.

Thanks.

FWIW, does the appended change look reasonable to you?  (It apparently
helps. ;-))

Rafael


Index: linux-2.6.15-rc2-mm1/drivers/usb/host/ehci-pci.c
===================================================================
--- linux-2.6.15-rc2-mm1.orig/drivers/usb/host/ehci-pci.c	2005-11-24 21:42:34.000000000 +0100
+++ linux-2.6.15-rc2-mm1/drivers/usb/host/ehci-pci.c	2005-11-24 21:50:38.000000000 +0100
@@ -281,12 +281,13 @@
 	if (time_before(jiffies, ehci->next_statechange))
 		msleep(100);
 
+	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+	wmb();
+
 	/* If CF is clear, we lost PCI Vaux power and need to restart.  */
 	if (readl(&ehci->regs->configured_flag) != FLAG_CF)
 		goto restart;
 
-	set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
-
 	/* If any port is suspended (or owned by the companion),
 	 * we know we can/must resume the HC (and mustn't reset it).
 	 * We just defer that to the root hub code.
