Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 91455B6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 27 Nov 2009 08:03:02 +1100 (EST)
Subject: Re: [RFC PATCH 09/19] powerpc: gamecube/wii: udbg support for usbgecko
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Herranz <albert_herranz@yahoo.es>
In-Reply-To: <4B0E9E84.4060400@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<1259212354.16367.265.camel@pasglop>  <4B0E9E84.4060400@yahoo.es>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Nov 2009 08:02:56 +1100
Message-ID: <1259269376.18084.16.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-11-26 at 16:28 +0100, Albert Herranz wrote:
> Benjamin Herrenschmidt wrote:
> > On Sun, 2009-11-22 at 23:01 +0100, Albert Herranz wrote:
> >> Add support for using the USB Gecko adapter via the udbg facility on
> >> the Nintendo GameCube and Wii video game consoles.
> >> The USB Gecko is a 3rd party memory card interface adapter that provides
> >> a EXI (External Interface) to USB serial converter.
> > 
> > The main issue here is that the gecko is supposed to be something you
> > can plug or unplug no ? Is it hotswap or only at boot ? In the later
> > case, maybe the node should be created by the boot wrapper when
> > detecting the presence of the device. If it's hotplug, then we need
> > something smarter...
> > 
> 
> The usbgecko is hotplugable and hotswappable.
> But as this is mostly a developer feature, not normaly used by end users,
> I think that we can just let it be as it is: autodetect it on boot (now probing
> for it instead of using information from the device tree).
> If you unplug it later it causes no errors, you just miss whatever data is sent to it.

Ack. We may still went ultimately to have some kind of nice hotplug
driver for that connector and we may even have a usbgecko driver for
that things "after boot" that creates areal tty etc... but for now, just
a hard probe will do just fine.

Of course a real OF implemention is welcome to create a device node for
it if it was indeed present at boot time.

Cheers,
Ben.

> > Cheers,
> > Ben.
> > 
> 
> Thanks,
> Albert
> 
