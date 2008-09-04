Return-Path: <stern+48c922fa@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 364FCDDFB9
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Sep 2008 07:40:54 +1000 (EST)
Date: Thu, 4 Sep 2008 17:40:49 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errata
In-Reply-To: <20080905004807.1c1d5513@vitb-lp>
Message-ID: <Pine.LNX.4.44L0.0809041737160.23455-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: USB list <linux-usb@vger.kernel.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Mark Miesfeld <mmiesfeld@amcc.com>, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 5 Sep 2008, Vitaly Bordug wrote:

> I've started looking this way. Sorry, but this approach is a little bit
> fragile, and unreliable.
> 
> First, it just did not work out in case of usb2 hub with memory stick
> and keybord plugged - OHCI did not suspend, ehci is hosed and we're
> happily using hi-speed device on full-speed:

> Secondly, we may *not* rely on the fact, that OHCI will always have the
> same suspend policy. Even kicking the code up to the shape when it will
> automagically suspend in proper timing to get the HW issue around, we
> cannot be sure that it will persist along kernel lifecycle, and won't
> require concerned people to kick suspend timings back to the working
> state subsequently each rc release.
> 
> Thirdly, PM is disabled by Kconfig explicitly in case of 44x. Reasoning
> is not clear at the moment, but I believe that isn't there just in case.

I assume that's the reason the suggested approach failed.

> > What to do when CONFIG_PM is off is a separate matter.  Let's not
> > worry about it for now -- especially since, as Matthias suggested,
> > you can use a USB 2.0 hub.
> 
> Not every hub will work (none of available did so far), and it is often
> not an option for embedded device without rewiring.

It's odd that your hubs don't work.  What's wrong with them?

> As this touches powerpc stuff only, are there any objections to let
> powerpc peolple consider if approach suggested earlier is applicable or
> not?

I don't mind doing that, provided the changes are cleaned up so that 
they don't affect people who aren't building kernels for 44x systems.

Alan Stern
