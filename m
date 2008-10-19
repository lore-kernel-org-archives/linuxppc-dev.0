Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A23B7DDDE0
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 08:49:48 +1100 (EST)
Date: Sun, 19 Oct 2008 23:49:48 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
In-Reply-To: <9e4733910810191432o58d204adw490cb8e4fcc390ac@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0810192347250.21665@axis700.grange>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
	<20081019025323.GA7887@ime.usp.br>
	<Pine.LNX.4.64.0810192147030.21665@axis700.grange>
	<9e4733910810191432o58d204adw490cb8e4fcc390ac@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>,
	Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 19 Oct 2008, Jon Smirl wrote:

> On Sun, Oct 19, 2008 at 4:59 PM, Guennadi Liakhovetski
> <g.liakhovetski@gmx.de> wrote:
> >
> > Yes, there seems to be a problem here now. The i2c adapter does not get
> > probed, i.e., of-matching doesn't work. A quick look through other
> > device-trees, using the same i2c driver, through git-logs of the i2c
> > driver and the dts didn't bring me to a solution. Can anyone spot what's
> > wrong with kuroboxHG.dts? lsprop output looks reasonable. Last working
> > kernel was 2.6.25-rc6-ish.
> >
> >> I just saw that in the default config:
> >>
> >> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> >> # CONFIG_PPC_CLOCK is not set
> >> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> >
> > No, kurobox uses generic RTC class.
> 
> I don't see anything obviously wrong.
> 
> Is rtc-rs5c372 built into your kernel?
> 
> You may need to add some debug statements in drivers/of/of_i2c.c to
> figure out what is wrong.
> It could be something like a _ not matching a -.

Above I said:

> > Yes, there seems to be a problem here now. The i2c adapter does not get
> > probed, i.e., of-matching doesn't work. A quick look through other

i.e., i2c-mpc is not matched against its fdt-node, not the rtc.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
