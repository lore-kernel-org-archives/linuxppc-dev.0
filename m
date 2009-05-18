Return-Path: <Emilian.Medve@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E9696DE072
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 03:49:03 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n4IHmx76000698
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 10:49:00 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net
	[10.64.32.14])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n4IHmxtY025744
	for <linuxppc-dev@ozlabs.org>; Mon, 18 May 2009 12:48:59 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH] Allow selecting mv643xx_eth on Pegasos again
Date: Mon, 18 May 2009 10:48:58 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2702C2D323@az33exm24.fsl.freescale.net>
In-Reply-To: <20090518173756.GA11805@iram.es>
References: <20090518173756.GA11805@iram.es>
From: "Medve Emilian-EMMEDVE1" <Emilian.Medve@freescale.com>
To: "Gabriel Paubert" <paubert@iram.es>,
	"Lennert Buytenhek" <buytenh@wantstofly.org>
Cc: LinuxPPC <linuxppc-dev@ozlabs.org>, David Miller <davem@davemloft.net>,
	pacman@kosh.dhis.org, tbm@cyrius.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: linuxppc-dev-bounces+emilian.medve=3Dfreescale.com@ozlabs.org
[mailto:linuxppc-dev-
> bounces+emilian.medve=3Dfreescale.com@ozlabs.org] On Behalf Of Gabriel
Paubert
> Sent: Monday, May 18, 2009 12:38 PM
> To: Lennert Buytenhek
> Cc: tbm@cyrius.com; LinuxPPC; pacman@kosh.dhis.org;
netdev@vger.kernel.org; David Miller
> Subject: [PATCH] Allow selecting mv643xx_eth on Pegasos again
>=20
> Since PPC_MUTIPLATFORM was removed, it was impossible to select the
> driver for mv643xx_eth on the Pegasos. Fix by allowing to select
> the driver on CHRP platforms; Pegasos is a CHRP platform and the
driver
> will not work without arch/powerpc/platforms/chrp/pegasos_eth.
>=20
> Signed-off-by: Gabriel Paubert <paubert@iram.es>
>=20
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index 214a92d..6fc0ff4 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -2351,7 +2351,7 @@ config UGETH_TX_ON_DEMAND
>=20
>  config MV643XX_ETH
>  	tristate "Marvell Discovery (643XX) and Orion ethernet support"
> -	depends on MV64360 || MV64X60 || (PPC_MULTIPLATFORM && PPC32) ||
PLAT_ORION
> +	depends on MV64X60 || PPC_CHRP || PLAT_ORION
>  	select INET_LRO
>  	select PHYLIB
>  	help

This got fixed here:
http://git.kernel.org/?p=3Dlinux/kernel/git/davem/net-next-2.6.git;a=3Dco=
mmi
tdiff;h=3D952ee9df26c487f2d73b2dced58ec904f19ea0f8


Cheers,
Emil.
