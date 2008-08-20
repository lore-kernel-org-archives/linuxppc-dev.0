Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 51D74DE7B9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 07:03:36 +1000 (EST)
Date: Thu, 21 Aug 2008 01:03:15 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: benh@kernel.crashing.org
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errrata
Message-ID: <20080821010315.1f0a443d@vitb-lp>
In-Reply-To: <1219111423.8062.10.camel@pasglop>
References: <20080819021040.27ce7dbe@vitb-lp>
	<1219111423.8062.10.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>, "linux-usb-devel@lists.sourceforge.net"
	<linux-usb-devel@lists.sourceforge.net>, Mark Miesfeld <mmiesfeld@amcc.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

В Tue, 19 Aug 2008 12:03:42 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> пишет:

> 
>  .../...
> 
> > There is a software workaround that uses a trick to detect if
> > full-speed interface is enabled from the hi-speed driver(and vice
> > versa), and use suspend control for ohci to enable/disable it
> > appropriately. 
> > Initial version of the software workaround was posted to
> > linux-usb-devel:
> > 
> > http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg54019.html
> > 
> > and later were made available from amcc.com:
> > http://www.amcc.com/Embedded/Downloads/download.html?cat=1&family=15&ins=2
> > 
> > The patch below is generally based on the latter, but reworked to
> > powerpc/of_device USB drivers, and uses a few devicetree inquiries
> > to get rid of (some) hardcoded defines.
> 
> Well, it seems to still call things based on #ifdef CONFIG_* instead
> of testing for whatever "errata" bit or flag you can initialize.
> 
> A proper approach is to have the OF probe code detect via some
> device-tree compatible testing or such, that it's indeed hitting the
> broken chip, use that to set a quirk in the controller, and then
> have the core ehci-hub.c code do whatever it has to do based on
> the presence of that quirk.
Makes sense, thanks. I'll look into rearranging stuff appropriately
over this weekend.

Thanks,
-Vitaly
