Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id F0C66DDE47
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Mar 2007 14:33:03 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l293X0DW008018
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 20:33:00 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l293WwDB006374
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Mar 2007 21:32:59 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] Move 8641 PCI-Express to arch/powerpc/sysdev/fsl_pcie.c.
Date: Fri, 9 Mar 2007 11:32:57 +0800
Message-ID: <7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A11@zch01exm23.fsl.freescale.net>
In-Reply-To: <1173300525.23776.136.camel@ld0161-tx32>
References: <1173300525.23776.136.camel@ld0161-tx32>
From: "Zang Roy-r61911" <tie-fei.zang@freescale.com>
To: "Loeliger Jon-LOELIGER" <jdl@freescale.com>, <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This move sets the stage for the use of generic PCI Express=20
> code in 85xx and 86xx parts from FSL.  Subsequent patches for=20
> 8548 and 8544 will be able to use this shared code.
>=20
> Signed-off-by: Jon Loeliger <jdl@freescale.com>
> Acked-by: Andy Fleming <afleming@freescale.com>
> ---
>  arch/powerpc/Kconfig                               |    5 +++++
>  arch/powerpc/platforms/86xx/Makefile               |    2 +-
>  arch/powerpc/sysdev/Makefile                       |    1 +
>  .../86xx/mpc86xx_pcie.c =3D> sysdev/fsl_pcie.c}      |    2 --
>  4 files changed, 7 insertions(+), 3 deletions(-)  rename=20
> arch/powerpc/{platforms/86xx/mpc86xx_pcie.c =3D>=20
> sysdev/fsl_pcie.c} (100%)
>=20
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig=20
> index 6dfbd52..f68de20 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -168,6 +168,7 @@ config PPC_86xx
>  	bool "Freescale 86xx"
>  	select 6xx
>  	select FSL_SOC
> +	select FSL_PCIE
>  	select PPC_FPU
>  	select ALTIVEC
>  	help
> @@ -1022,6 +1023,10 @@ config SBUS
>  config FSL_SOC
>  	bool
> =20
> +config FSL_PCIE
> +	bool
> +	depends on PPC_86xx
> +
How about 8548 with pcie?
Roy
