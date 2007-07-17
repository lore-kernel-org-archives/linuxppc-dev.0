Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9DC1DDE11
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 22:18:44 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l6HCIcBJ020220
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 05:18:39 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6HCIbSU014998
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 07:18:38 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] USB_DR host support for FSL MPC831x
Date: Tue, 17 Jul 2007 20:18:35 +0800
Message-ID: <989B956029373F45A0B8AF0297081890F06271@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070717005832.23019.99739.stgit@localhost.localdomain>
References: <20070717005832.23019.99739.stgit@localhost.localdomain>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Vitaly Bordug" <vitb@kernel.crashing.org>, "Greg KH" <greg@kroah.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Vitaly,

I believe that your patch is addresses by my patch in 2.6.23 queue:
http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.6/2.6.22/usb-
ehci_fsl-update-for-mpc831x-support.patch

- Leo

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Vitaly Bordug
> Sent: Tuesday, July 17, 2007 8:59 AM
> To: Greg KH
> Cc: linuxppc-dev@ozlabs.org
> Subject: [PATCH] USB_DR host support for FSL MPC831x
>=20
>=20
> Modifies fsl_ehci code so that to get USB host working on=20
> mpc831x platform. Verified with MPC8313RDB reference board.
>=20
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
>=20
> ---
>=20
>  arch/powerpc/boot/dts/mpc8313erdb.dts |    1 +
>  drivers/usb/host/ehci-fsl.c           |    4 +++-
>  drivers/usb/host/ehci-hcd.c           |    2 +-
>  3 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/boot/dts/mpc8313erdb.dts=20
> b/arch/powerpc/boot/dts/mpc8313erdb.dts
> index 1b351dc..c330e79 100644
> --- a/arch/powerpc/boot/dts/mpc8313erdb.dts
> +++ b/arch/powerpc/boot/dts/mpc8313erdb.dts
> @@ -90,6 +90,7 @@
>  			interrupt-parent =3D < &ipic >;
>  			interrupts =3D <26 8>;
>  			phy_type =3D "utmi_wide";
> +			control_init  =3D <00000280>; // UTMI ext=20
> 48 MHz clk
>  		};
> =20
>  		mdio@24520 {
> diff --git a/drivers/usb/host/ehci-fsl.c=20
> b/drivers/usb/host/ehci-fsl.c index c7a7c59..3e3187b 100644
> --- a/drivers/usb/host/ehci-fsl.c
> +++ b/drivers/usb/host/ehci-fsl.c
> @@ -185,12 +185,14 @@ static void mpc83xx_usb_setup(struct=20
> usb_hcd *hcd)
>  	struct ehci_hcd *ehci =3D hcd_to_ehci(hcd);
>  	struct fsl_usb2_platform_data *pdata;
>  	void __iomem *non_ehci =3D hcd->regs;
> +	u32 temp;
> =20
>  	pdata =3D
>  	    (struct fsl_usb2_platform_data *)hcd->self.controller->
>  	    platform_data;
>  	/* Enable PHY interface in the control reg. */
> -	out_be32(non_ehci + FSL_SOC_USB_CTRL, 0x00000004);
> +	temp =3D in_be32(non_ehci + FSL_SOC_USB_CTRL);
> +	out_be32(non_ehci + FSL_SOC_USB_CTRL, temp | 0x00000004);
>  	out_be32(non_ehci + FSL_SOC_USB_SNOOP1, 0x0000001b);
> =20
>  #if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)
> diff --git a/drivers/usb/host/ehci-hcd.c=20
> b/drivers/usb/host/ehci-hcd.c index 099aff6..994a127 100644
> --- a/drivers/usb/host/ehci-hcd.c
> +++ b/drivers/usb/host/ehci-hcd.c
> @@ -925,7 +925,7 @@ MODULE_LICENSE ("GPL");
>  #define	PCI_DRIVER		ehci_pci_driver
>  #endif
> =20
> -#ifdef CONFIG_MPC834x
> +#if defined(CONFIG_MPC834x) || defined(CONFIG_PPC_MPC831x)
>  #include "ehci-fsl.c"
>  #define	PLATFORM_DRIVER		ehci_fsl_driver
>  #endif
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
