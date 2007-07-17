Return-Path: <LeoLi@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 12FF6DDE3C
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 22:21:27 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l6HCLCZY021311
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 05:21:12 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id l6HCLBXj013655
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 07:21:11 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] USB_DR device support for FSL MPC831x
Date: Tue, 17 Jul 2007 20:21:09 +0800
Message-ID: <989B956029373F45A0B8AF0297081890F06272@zch01exm26.fsl.freescale.net>
In-Reply-To: <20070717005849.23036.21497.stgit@localhost.localdomain>
References: <20070717005849.23036.21497.stgit@localhost.localdomain>
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

The max_ep_nr will be read from DCCPARAMS register with my patch in
2.6.23 queue:
http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.6/2.6.22/usb-
fsl_usb2_udc-get-max-ep-number-from-dccparams-register.patch

- Leo

> -----Original Message-----
> From: linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org=20
> [mailto:linuxppc-dev-bounces+leoli=3Dfreescale.com@ozlabs.org]=20
> On Behalf Of Vitaly Bordug
> Sent: Tuesday, July 17, 2007 8:59 AM
> To: Greg KH
> Cc: linuxppc-dev@ozlabs.org
> Subject: [PATCH] USB_DR device support for FSL MPC831x
>=20
>=20
> This adds support for USB device mode on mpc831x series.=20
> Devicetree node modification is required to make it work -=20
>=20
> dr_mode =3D"peripheral";
>=20
> which should be commented out if host mode is desired onboot.
>=20
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
>=20
> ---
>=20
>  arch/powerpc/sysdev/fsl_soc.c |    1 +
>  include/linux/fsl_devices.h   |    1 +
>  2 files changed, 2 insertions(+), 0 deletions(-)
>=20
> diff --git a/arch/powerpc/sysdev/fsl_soc.c=20
> b/arch/powerpc/sysdev/fsl_soc.c index c0ddc80..27a1510 100644
> --- a/arch/powerpc/sysdev/fsl_soc.c
> +++ b/arch/powerpc/sysdev/fsl_soc.c
> @@ -514,6 +514,7 @@ static int __init fsl_usb_of_init(void)
>  			}
>  		} else if (prop && !strcmp(prop, "peripheral")) {
>  			usb_data.operating_mode =3D FSL_USB2_DR_DEVICE;
> +			usb_data.max_ep_nr =3D *(unsigned=20
> int*)of_get_property(np,=20
> +"max_ep_nr",NULL);
>  			usb_dev_dr_client =3D=20
> platform_device_register_simple(
>  					"fsl-usb2-udc", i, r, 2);
>  			if (IS_ERR(usb_dev_dr_client)) {
> diff --git a/include/linux/fsl_devices.h=20
> b/include/linux/fsl_devices.h index 12e631f..a3feb34 100644
> --- a/include/linux/fsl_devices.h
> +++ b/include/linux/fsl_devices.h
> @@ -103,6 +103,7 @@ struct fsl_usb2_platform_data {
>  	enum fsl_usb2_operating_modes	operating_mode;
>  	enum fsl_usb2_phy_modes		phy_mode;
>  	unsigned int			port_enables;
> +	unsigned int			max_ep_nr;
>  };
> =20
>  /* Flags in fsl_usb2_mph_platform_data */
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>=20
