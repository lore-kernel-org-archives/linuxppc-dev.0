Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 98BF0DDF35
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 12:04:00 +1000 (EST)
Subject: Re: [RFC][USB] powerpc: Workaround for the PPC440EPX USBH_23 errrata
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20080819021040.27ce7dbe@vitb-lp>
References: <20080819021040.27ce7dbe@vitb-lp>
Content-Type: text/plain
Date: Tue, 19 Aug 2008 12:03:42 +1000
Message-Id: <1219111423.8062.10.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Stefan Roese <sr@denx.de>, "linux-usb-devel@lists.sourceforge.net"
	<linux-usb-devel@lists.sourceforge.net>, Mark Miesfeld <mmiesfeld@amcc.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 .../...

> There is a software workaround that uses a trick to detect if full-speed interface 
> is enabled from the hi-speed driver(and vice versa), and use suspend control for ohci
> to enable/disable it appropriately.
>  
> Initial version of the software workaround was posted to linux-usb-devel:
> 
> http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg54019.html
> 
> and later were made available from amcc.com:
> http://www.amcc.com/Embedded/Downloads/download.html?cat=1&family=15&ins=2
> 
> The patch below is generally based on the latter, but reworked to
> powerpc/of_device USB drivers, and uses a few devicetree inquiries to get
> rid of (some) hardcoded defines.

Well, it seems to still call things based on #ifdef CONFIG_* instead
of testing for whatever "errata" bit or flag you can initialize.

A proper approach is to have the OF probe code detect via some
device-tree compatible testing or such, that it's indeed hitting the
broken chip, use that to set a quirk in the controller, and then
have the core ehci-hub.c code do whatever it has to do based on
the presence of that quirk.

Ben.
