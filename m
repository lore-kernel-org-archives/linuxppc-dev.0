Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id A8C5BDDDE1
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Oct 2008 07:59:14 +1100 (EST)
Date: Sun, 19 Oct 2008 22:59:12 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Subject: Re: [PATCH] powerpc: enable heap randomization for linkstations
In-Reply-To: <20081019025323.GA7887@ime.usp.br>
Message-ID: <Pine.LNX.4.64.0810192147030.21665@axis700.grange>
References: <20081013040703.GA11059@ime.usp.br>
	<20081013045116.GA11637@ime.usp.br>
	<Pine.LNX.4.64.0810132003350.9041@axis700.grange>
	<20081013184443.GA20612@ld0162-tx32.am.freescale.net>
	<20081019025323.GA7887@ime.usp.br>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(modified the cc-list somewhat)

On Sat, 18 Oct 2008, Rog=E9rio Brito wrote:

> systems. Here is something that I get with a vanilla linkstation_defconfi=
g:
>=20
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
>=20
> This gets me (with bootlogd enabled):
>=20
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> Wed Dec 31 21:00:15 1969: Cannot access the Hardware Clock via any known =
method.
> Wed Dec 31 21:00:15 1969: Use the --debug option to see the details of ou=
r search for an access method.
> Wed Dec 31 21:00:15 1969: Unable to set System Clock to: Thu Jan 1 00:00:=
15 UTC 1970 ^[[33m(warning).^[[39;49m
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

Yes, there seems to be a problem here now. The i2c adapter does not get=20
probed, i.e., of-matching doesn't work. A quick look through other=20
device-trees, using the same i2c driver, through git-logs of the i2c=20
driver and the dts didn't bring me to a solution. Can anyone spot what's=20
wrong with kuroboxHG.dts? lsprop output looks reasonable. Last working=20
kernel was 2.6.25-rc6-ish.

> I just saw that in the default config:
>=20
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
> # CONFIG_PPC_CLOCK is not set
> - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

No, kurobox uses generic RTC class.

Thanks for the report
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
