Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1148DDDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 23:02:10 +1000 (EST)
Date: Fri, 5 Sep 2008 17:01:35 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
Message-ID: <20080905170135.07ccbc46@vitb-lp>
In-Reply-To: <Pine.LNX.4.44L0.0809041737160.23455-100000@iolanthe.rowland.org>
References: <20080905004807.1c1d5513@vitb-lp>
	<Pine.LNX.4.44L0.0809041737160.23455-100000@iolanthe.rowland.org>
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

В Thu, 4 Sep 2008 17:40:49 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> пишет:

> On Fri, 5 Sep 2008, Vitaly Bordug wrote:
> 
> > I've started looking this way. Sorry, but this approach is a little
> > bit fragile, and unreliable.
> > 
> > First, it just did not work out in case of usb2 hub with memory
> > stick and keybord plugged - OHCI did not suspend, ehci is hosed and
> > we're happily using hi-speed device on full-speed:
> 
> > Secondly, we may *not* rely on the fact, that OHCI will always have
> > the same suspend policy. Even kicking the code up to the shape when
> > it will automagically suspend in proper timing to get the HW issue
> > around, we cannot be sure that it will persist along kernel
> > lifecycle, and won't require concerned people to kick suspend
> > timings back to the working state subsequently each rc release.
> > 
> > Thirdly, PM is disabled by Kconfig explicitly in case of 44x.
> > Reasoning is not clear at the moment, but I believe that isn't
> > there just in case.
> 
> I assume that's the reason the suggested approach failed.

Oh geez. I may miss some small point, but dunno what made me appear
*that* dense. The kernel was properly rebuilt with Kconfig fixed and
_PM set.
> 
> > > What to do when CONFIG_PM is off is a separate matter.  Let's not
> > > worry about it for now -- especially since, as Matthias suggested,
> > > you can use a USB 2.0 hub.
> > 
> > Not every hub will work (none of available did so far), and it is
> > often not an option for embedded device without rewiring.
> 
> It's odd that your hubs don't work.  What's wrong with them?
> 

well, they do not have transaction translators then. Nothing really
wrong
> > As this touches powerpc stuff only, are there any objections to let
> > powerpc peolple consider if approach suggested earlier is
> > applicable or not?
> 
> I don't mind doing that, provided the changes are cleaned up so that 
> they don't affect people who aren't building kernels for 44x systems.
OK, thanks for review and comments...

--
Sincerely,

Vitaly
