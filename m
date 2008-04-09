Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 88B06DDF06
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 03:39:30 +1000 (EST)
Message-ID: <47FCFF64.9050109@freescale.com>
Date: Wed, 09 Apr 2008 12:39:48 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] FCC: fix confused base / offset
References: <20080409130610.GE10465@pengutronix.de>
	<20080409161110.GA5296@ld0162-tx32.am.freescale.net>
	<20080409165324.GF10465@pengutronix.de>
In-Reply-To: <20080409165324.GF10465@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sascha Hauer wrote:
> Right, so it's probably not worth the effort. I stumbled on this while
> porting my board to the new binding code. I was quite confused when
> seeing this so I made this fix to understand what's going on here.
> 
> BTW have you tested the FCC driver with the new binding code?

Yes.

> I do not
> manage to get it working. Everything seems to be fine but
> fs_enet_start_xmit does not send a packet and no interrupts are
> arriving.

What does your device tree look like?  Are all the pins and clocks set 
up properly?  Does the PHY negotiate OK?  Is any error reported in the 
descriptor?

>> Does this break arch/ppc, BTW?
> 
> Yes. arch=ppc is out of my scope, so I forget about it regularly, sorry.
> It breaks arch/ppc/platforms/mpc8272ads_setup.c which can be easily
> fixed though. But as the mpc8272ads is supported with arch=powerpc,
> shouldn't it go away anyway?

arch/ppc is going away entirely in June or so.  !CONFIG_PPC_NEW_BINDING 
in arch/powerpc is going away as soon as I can unlazy myself enough to 
send a patch. :-)

-Scott
