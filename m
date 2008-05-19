Return-Path: <G.Chen@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 48741DDE06
	for <linuxppc-dev@ozlabs.org>; Mon, 19 May 2008 13:02:25 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m4J32IY1015667
	for <linuxppc-dev@ozlabs.org>; Sun, 18 May 2008 20:02:19 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m4J32G5R000223
	for <linuxppc-dev@ozlabs.org>; Sun, 18 May 2008 22:02:17 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 3/4] [MMC] mmc_spi: add polling support for the card
	detectline
Date: Mon, 19 May 2008 11:02:13 +0800
Message-ID: <58A20A281BAF1047B4EAE68DE5C0BDC2F16E6A@zch01exm21.fsl.freescale.net>
In-Reply-To: <20080516165057.GC24196@polina.dev.rtsoft.ru>
References: <20080516165057.GC24196@polina.dev.rtsoft.ru>
From: "Chen Gong" <G.Chen@freescale.com>
To: "Anton Vorontsov" <avorontsov@ru.mvista.com>,
	"Kumar Gala" <galak@kernel.crashing.org>,
	"David Brownell" <dbrownell@users.sourceforge.net>,
	"Pierre Ossman" <drzeus-mmc@drzeus.cx>
Cc: linuxppc-dev@ozlabs.org, Tabi Timur <timur@freescale.com>,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+b11801=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Anton Vorontsov
> Sent: 2008?5?17? 0:51
> To: Kumar Gala; David Brownell; Pierre Ossman
> Cc: linuxppc-dev@ozlabs.org;=20
> spi-devel-general@lists.sourceforge.net;=20
> linux-kernel@vger.kernel.org; Tabi Timur
> Subject: [PATCH 3/4] [MMC] mmc_spi: add polling support for=20
> the card detectline
>=20
> Some boards do not use interrupts on the CD line, so we want=20
> to poll the CD and see if there was a change. 1 second poll=20
> interval seems resonable.
>=20
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  drivers/mmc/host/mmc_spi.c  |   51=20

I want to know whether every card working well ? Because I'm working
For 83xx MMC-over-SPI support, the presented concrete methods I used as
you do,
but only 256M card seems good, 512M or 1G/2G card all have some problems
