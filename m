Return-Path: <G.Chen@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1EACEDDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 23:45:13 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m4MDj42m012013
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 06:45:05 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m4MDj2w6022007
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 08:45:03 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/4] [MMC] mmc_spi: add polling support for the
	carddetectline
Date: Thu, 22 May 2008 21:44:57 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC2F176EF@zch01exm21.fsl.freescale.net>
In-Reply-To: <20080522123838.GA27149@polina.dev.rtsoft.ru>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
	<58A20A281BAF1047B4EAE68DE5C0BDC2F16E6A@zch01exm21.fsl.freescale.net>
	<20080522123838.GA27149@polina.dev.rtsoft.ru>
From: "Chen Gong" <G.Chen@freescale.com>
To: <avorontsov@ru.mvista.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net, Tabi Timur <timur@freescale.com>,
	Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=20

> -----Original Message-----
> From: Anton Vorontsov [mailto:avorontsov@ru.mvista.com]=20
> Sent: 2008?5?22? 20:39
> To: Chen Gong
> Cc: Kumar Gala; David Brownell; Pierre Ossman;=20
> linuxppc-dev@ozlabs.org;=20
> spi-devel-general@lists.sourceforge.net;=20
> linux-kernel@vger.kernel.org; Tabi Timur
> Subject: Re: [PATCH 3/4] [MMC] mmc_spi: add polling support=20
> for the carddetectline
>=20
> On Mon, May 19, 2008 at 11:02:13AM +0800, Chen Gong wrote:
> >=20
> > > -----Original Message-----
> > > From: linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org
> > > [mailto:linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org]
> > > On Behalf Of Anton Vorontsov
> > > Sent: 2008?5?17? 0:51
> > > To: Kumar Gala; David Brownell; Pierre Ossman
> > > Cc: linuxppc-dev@ozlabs.org;
> > > spi-devel-general@lists.sourceforge.net;
> > > linux-kernel@vger.kernel.org; Tabi Timur
> > > Subject: [PATCH 3/4] [MMC] mmc_spi: add polling support=20
> for the card=20
> > > detectline
> > >=20
> > > Some boards do not use interrupts on the CD line, so we=20
> want to poll=20
> > > the CD and see if there was a change. 1 second poll=20
> interval seems=20
> > > resonable.
> > >=20
> > > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > > ---
> > >  drivers/mmc/host/mmc_spi.c  |   51=20
> >=20
> > I want to know whether every card working well ? Because=20
> I'm working=20
> > For 83xx MMC-over-SPI support, the presented concrete=20
> methods I used=20
> > as you do, but only 256M card seems good, 512M or 1G/2G=20
> card all have=20
> > some problems
>=20
> So far I don't have cards larger than 256M. Will try to get=20
> one though.
>=20
Thanks, if you have any new test report pls contact me.

BTW, a fews days ago Joakim Tjernlund made a heavy fix for=20
spi_mpc83xx.c to resolve clock glitch. But it looks no any impact
for me, but maybe it has positive effect for you.
