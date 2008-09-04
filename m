Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5227DDE02
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 06:48:52 +1000 (EST)
Date: Fri, 5 Sep 2008 00:48:07 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
Message-ID: <20080905004807.1c1d5513@vitb-lp>
In-Reply-To: <Pine.LNX.4.44L0.0808291722590.13185-100000@netrider.rowland.org>
References: <20080829222044.53c56bca@vitb-lp>
	<Pine.LNX.4.44L0.0808291722590.13185-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Cc: USB list <linux-usb@vger.kernel.org>, Mark,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Miesfeld <mmiesfeld@amcc.com>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

В Fri, 29 Aug 2008 17:30:57 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> пишет:

> On Fri, 29 Aug 2008, Vitaly Bordug wrote:
> 
> > But even assuming PM set, common use-case of
> > embedded systems to have stuff on USB bus that is never plugged off;
> > and in case of compiled-in ehci and ohci there is just 
> > 
> > Initializing USB Mass Storage driver...
> > usb 1-1: new high speed USB device using ppc-of-ehci and address 2
> > usb 1-1: device descriptor read/all, error -110
> > hub 1-0:1.0: unable to enumerate USB device on port 1
> > 
> > (not touching PM here to be clear)
> > 
> > even 1-second delay would be enough for root hub to be hosed... So,
> > is the patch (with all the issues addressed) acceptable for
> > mainline?
> 
> Try doing this instead.  First, make sure CONFIG_PM is set!  :-)
> Then replace your patch with something that adds a 2-second delay to 
> the end of ehci_start() when running on a 440EPx system.  That should 
> give the OHCI controller time to suspend before the EHCI root hub is 
> registered.
> 
I've started looking this way. Sorry, but this approach is a little bit
fragile, and unreliable.

First, it just did not work out in case of usb2 hub with memory stick
and keybord plugged - OHCI did not suspend, ehci is hosed and we're
happily using hi-speed device on full-speed:

ppc-of-ehci e0000300.ehci: OF EHCI
ppc-of-ehci e0000300.ehci: new USB bus registered, assigned bus number 1
ppc-of-ehci e0000300.ehci: irq 32, io mem 0xe0000300
ppc-of-ehci e0000300.ehci: USB 2.0 started, EHCI 1.00, driver 10 Dec
2004 usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: OF EHCI
usb usb1: Manufacturer: Linux 2.6.26-00016-g8914f6a-dirty ehci_hcd
usb usb1: SerialNumber: PPC-OF USB
ppc-of-ohci e0000400.usb: OF OHCI
ppc-of-ohci e0000400.usb: new USB bus registered, assigned bus number 2
ppc-of-ohci e0000400.usb: irq 33, io mem 0xe0000400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 1 port detected
usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: Product: OF OHCI
usb usb2: Manufacturer: Linux 2.6.26-00016-g8914f6a-dirty ohci_hcd
usb usb2: SerialNumber: PPC-OF USB
Initializing USB Mass Storage driver...
usb 1-1: new high speed USB device using ppc-of-ehci and address 2
usb 1-1: device not accepting address 2, error -110
usb 1-1: new high speed USB device using ppc-of-ehci and address 3
usb 1-1: device not accepting address 3, error -110
usb 1-1: new high speed USB device using ppc-of-ehci and address 4
usb 1-1: device not accepting address 4, error -110
usb 1-1: new high speed USB device using ppc-of-ehci and address 5
usb 1-1: device not accepting address 5, error -110
hub 1-0:1.0: unable to enumerate USB device on port 1
usb 2-1: new full speed USB device using ppc-of-ohci and address 2

Secondly, we may *not* rely on the fact, that OHCI will always have the
same suspend policy. Even kicking the code up to the shape when it will
automagically suspend in proper timing to get the HW issue around, we
cannot be sure that it will persist along kernel lifecycle, and won't
require concerned people to kick suspend timings back to the working
state subsequently each rc release.

Thirdly, PM is disabled by Kconfig explicitly in case of 44x. Reasoning
is not clear at the moment, but I believe that isn't there just in case.


> A little more tweaking will be needed to handle system sleeps.  But 
> this should be a good start.

Getting 44x into proper PM land is good direction, but right now there
is a situation for certain platform when USB trimmed down to full-speed
mode in evaluation design and many inheritances. The only way to have
all the benefits, was maintaining internally some version of AMCC
workaorund
> 
> What to do when CONFIG_PM is off is a separate matter.  Let's not
> worry about it for now -- especially since, as Matthias suggested,
> you can use a USB 2.0 hub.

Not every hub will work (none of available did so far), and it is often
not an option for embedded device without rewiring.

As this touches powerpc stuff only, are there any objections to let
powerpc peolple consider if approach suggested earlier is applicable or
not?

Thanks,

-Vitaly
