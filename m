Return-Path: <LeoLi@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id AE408DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 14:23:57 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l163NuZQ013698
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 20:23:56 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l163NioX010424
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 21:23:49 -0600 (CST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH 2/3] add soc setup code for USB DR OTG mode
Date: Tue, 6 Feb 2007 11:25:01 +0800
Message-ID: <989B956029373F45A0B8AF02970818900D41C4@zch01exm26.fsl.freescale.net>
In-Reply-To: <297BF1F9-551F-43AD-9E76-00C79EC8BF31@kernel.crashing.org>
From: "Li Yang-r58472" <LeoLi@freescale.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Monday, February 05, 2007 11:16 PM
> To: Li Yang-r58472
> Cc: Paul; linuxppc-dev@ozlabs.org
> Subject: Re: [PATCH 2/3] add soc setup code for USB DR OTG mode
>=20
>=20
> On Feb 5, 2007, at 3:10 AM, Li Yang wrote:
>=20
> You have no description about what this patch does and why its needed.
>=20

Add platform_device setup code for OTG/client mode of 834x DR.  It is
needed for USB client driver to work.

> Nack.  See comments inline.
>=20
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > ---
> > arch/powerpc/sysdev/fsl_soc.c |   76 +++++++++++++++++++++++++++++
> > +----------
> > 1 files changed, 57 insertions(+), 19 deletions(-)
> >
> > diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/
> > fsl_soc.c
> > index ad31e56..d9541aa 100644
> > --- a/arch/powerpc/sysdev/fsl_soc.c
> > +++ b/arch/powerpc/sysdev/fsl_soc.c
> > @@ -440,7 +440,8 @@ static int __init fsl_usb_of_init(void)
> > {
> > 	struct device_node *np;
> > 	unsigned int i;
> > -	struct platform_device *usb_dev_mph =3D NULL, *usb_dev_dr =3D =
NULL;
> > +	struct platform_device *usb_dev_mph =3D NULL, *usb_dev_dr_host =3D
NULL,
> > +		*usb_dev_dr_client =3D NULL;
> > 	int ret;
> > 	for (np =3D NULL, i =3D 0;
> > @@ -506,33 +507,70 @@ static int __init fsl_usb_of_init(void)
> > 		of_irq_to_resource(np, 0, &r[1]);
> > -		usb_dev_dr =3D
> > -		    platform_device_register_simple("fsl-ehci", i, r,
2);
> > -		if (IS_ERR(usb_dev_dr)) {
> > -			ret =3D PTR_ERR(usb_dev_dr);
> > -			goto err;
> > -		}
> > -
> > -		usb_dev_dr->dev.coherent_dma_mask =3D 0xffffffffUL;
> > -		usb_dev_dr->dev.dma_mask =3D
&usb_dev_dr->dev.coherent_dma_mask;
> > +		prop =3D get_property(np, "dr_mode", NULL);
> > -		usb_data.operating_mode =3D FSL_USB2_DR_HOST;
> > +		if (prop && !strcmp(prop, "host")) {
> > +			usb_data.operating_mode =3D FSL_USB2_DR_HOST;
> > +			usb_dev_dr_host =3D
platform_device_register_simple(
> > +					"fsl-ehci", i, r, 2);
> > +			if (IS_ERR(usb_dev_dr_host)) {
> > +				ret =3D PTR_ERR(usb_dev_dr_host);
> > +				goto err;
> > +			}
> > +
> > +		} else if (prop && !strcmp(prop, "peripheral")) {
> > +			usb_data.operating_mode =3D FSL_USB2_DR_DEVICE;
> > +			usb_dev_dr_client =3D
platform_device_register_simple(
> > +					"fsl-usb2-udc", i, r, 2);
> > +			if (IS_ERR(usb_dev_dr_client)) {
> > +				ret =3D PTR_ERR(usb_dev_dr_client);
> > +				goto err;
> > +			}
> > +		} else if (!prop || (prop && !strcmp(prop, "otg"))) {
>=20
> Why do we assume if the prop is not defined we are OTG?  This will
> break existing users and is not acceptable.  If the prop doesn't
> exist we have to assume 'host' support to maintain compatibility.

No, it doesn't break existing users.  In otg mode, it supports both host
and client feature.  The specific mode to use can be easily selected by
loading the needed driver.

- Leo
