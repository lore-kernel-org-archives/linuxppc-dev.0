Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4C74DDF9F
	for <linuxppc-dev@ozlabs.org>; Sat, 30 May 2009 03:18:38 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4THIZ8h024106
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 10:18:35 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4THIZVs026411
	for <linuxppc-dev@ozlabs.org>; Fri, 29 May 2009 12:18:35 -0500 (CDT)
Date: Fri, 29 May 2009 12:18:35 -0500
From: Scott Wood <scottwood@freescale.com>
To: Frank =?iso-8859-1?Q?Svendsb=F8e?= <frank.svendsboe@gmail.com>
Subject: Re: MPC8272- Porting HDLC driver from 2.6.14 to 2.6.27- "no_irq_chip"
	error
Message-ID: <20090529171835.GB22066@b07421-ec1.am.freescale.net>
References: <547eba1b0905280037j3336d0av7cc5d4069622d8f4@mail.gmail.com>
	<4A1E6877.2060106@aimvalley.nl>
	<20090528123311.GA3112@pengutronix.de>
	<1ba63b520905290356l5d519e64w3bd852d8fc4032be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1ba63b520905290356l5d519e64w3bd852d8fc4032be@mail.gmail.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Daniel Ng <daniel.ng1234@gmail.com>,
	Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 29, 2009 at 12:56:13PM +0200, Frank Svendsbøe wrote:
> FYI. The same applies to mpc8xx targets: No default host interrupt controller.
> The following patch was needed for our target:
> ---
> diff --git a/arch/powerpc/sysdev/mpc8xx_pic.c b/arch/powerpc/sysdev/mpc8xx_pic.c
> index 5d2d552..92b2b66 100644
> --- a/arch/powerpc/sysdev/mpc8xx_pic.c
> +++ b/arch/powerpc/sysdev/mpc8xx_pic.c
> @@ -186,6 +186,7 @@ int mpc8xx_pic_init(void)
>                 ret = -ENOMEM;
>                 goto out;
>         }
> +        irq_set_default_host(mpc8xx_pic_host);
>         return 0;

This patch is whitespace mangled.

> 
>  out:
> ---
> Maybe setting a default host ought to be mandatory? Or is doing the
> mapping manually
> (without device tree descriptions) considered being a hack?

I consider it a hack -- not so much doing it manually (though the device
tree is better), but relying on a default interrupt controller when doing
so.  IRQ numbers only make sense in the context of a specific
controller.  It's especially misleading on 8xx, which has separate
regular and CPM PICs.

-Scott
