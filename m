Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id B488BB6EF3
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 21:59:08 +1000 (EST)
Date: Wed, 28 Jul 2010 13:58:58 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] USB: add of_platform glue driver for FSL USB DR
	controller
Message-ID: <20100728135858.5dc14484@wker>
In-Reply-To: <AANLkTinSeFWM4bQK+o8nwStd6C-OcxMagC7TjwCBNn1v@mail.gmail.com>
References: <1279815922-27198-1-git-send-email-agust@denx.de>
	<1279815922-27198-3-git-send-email-agust@denx.de>
	<AANLkTinSeFWM4bQK+o8nwStd6C-OcxMagC7TjwCBNn1v@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Greg Kroah-Hartman <gregkh@suse.de>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linux-usb@vger.kernel.org,
	linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On Wed, 28 Jul 2010 02:16:08 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Thu, Jul 22, 2010 at 10:25 AM, Anatolij Gustschin <agust@denx.de> wrot=
e:
> > The driver creates platform devices based on the information
> > from USB nodes in the flat device tree. This is the replacement
> > for old arch fsl_soc usb code removed by the previous patch.
> > It uses usual of-style binding, available EHCI-HCD and UDC
> > drivers can be bound to the created devices. The new of-style
> > driver additionaly instantiates USB OTG platform device, as the
> > appropriate USB OTG driver will be added soon.
> >
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> > Cc: Kumar Gala <galak@kernel.crashing.org>
> > Cc: Grant Likely <grant.likely@secretlab.ca>
>=20
> Hi Anatolij,
>=20
> Looks pretty good, but some comments below.

Thanks for review and comments! Greg already merged this series and
therefore I'll submit an incremental cleanup patch to address
outstanding issues. My reply is below.

...
> > --- a/drivers/usb/host/Kconfig
> > +++ b/drivers/usb/host/Kconfig
> > @@ -112,10 +112,15 @@ config XPS_USB_HCD_XILINX
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0support both hig=
h speed and full speed devices, or high speed
> > =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0devices only.
> >
> > +config USB_FSL_MPH_DR_OF
> > + =C2=A0 =C2=A0 =C2=A0 bool
> > + =C2=A0 =C2=A0 =C2=A0 depends on PPC_OF
>=20
> Drop the depends.  This is selected by USB_EHCI_FSL and
> USB_GADGET_FSL_USB2, which are already PPC only.

Okay, will remove it.

...
> > +struct fsl_usb2_dev_data dr_mode_data[] __devinitdata =3D {
> > + =C2=A0 =C2=A0 =C2=A0 {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "host",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { "fsl-ehci", NULL, =
NULL, },
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSL_USB2_DR_HOST,
> > + =C2=A0 =C2=A0 =C2=A0 },
> > + =C2=A0 =C2=A0 =C2=A0 {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "otg",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { "fsl-ehci", "fsl-u=
sb2-udc", "fsl-usb2-otg", },
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSL_USB2_DR_OTG,
> > + =C2=A0 =C2=A0 =C2=A0 },
> > + =C2=A0 =C2=A0 =C2=A0 {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "periferal",
>=20
> spelling.  "peripheral"

Right, thanks for catching! Will fix it.

>=20
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 { "fsl-usb2-udc", NU=
LL, NULL, },
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 FSL_USB2_DR_DEVICE,
> > + =C2=A0 =C2=A0 =C2=A0 },
> > +};
>=20
> Program defensively.  Use the following form:
> + =C2=A0 =C2=A0 =C2=A0 {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .dr_mode =3D "host",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .drivers =3D { "fsl-eh=
ci", NULL, NULL, },
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .op_mode =3D FSL_USB2_=
DR_HOST,
> + =C2=A0 =C2=A0 =C2=A0 },

I'll change it too as suggested.

...
> > +struct fsl_usb2_dev_data * __devinit get_dr_mode_data(struct device_no=
de *np)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 const unsigned char *prop;
> > + =C2=A0 =C2=A0 =C2=A0 int i;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 prop =3D of_get_property(np, "dr_mode", NULL);
> > + =C2=A0 =C2=A0 =C2=A0 if (prop) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < AR=
RAY_SIZE(dr_mode_data); i++) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (!strcmp(prop, dr_mode_data[i].dr_mode))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return &dr_mode_data[i];
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>=20
> Print a warning if you get through the loop, but don't match anything.
>  That means that dr_mode has a bad value.

I'll add a warning here.

...
> > +struct platform_device * __devinit
> > +fsl_usb2_device_register(struct of_device *ofdev,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0struct fsl_usb2_platform_data *pdata,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0const char *name, int id)
>=20
> In general, it is better to have the function name on the same line as
> the return arguements so that grep shows the relevant info.  Move the
> arguments to subsequent lines.

It will be fixed in a clean-up patch.

...
> > +static int __devinit fsl_usb2_mph_dr_of_probe(struct of_device *ofdev,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0const struct of_device_id *match)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 struct device_node *np =3D ofdev->dev.of_node;
> > + =C2=A0 =C2=A0 =C2=A0 struct platform_device *usb_dev;
> > + =C2=A0 =C2=A0 =C2=A0 struct fsl_usb2_platform_data data, *pdata;
> > + =C2=A0 =C2=A0 =C2=A0 struct fsl_usb2_dev_data *dev_data;
> > + =C2=A0 =C2=A0 =C2=A0 const unsigned char *prop;
> > + =C2=A0 =C2=A0 =C2=A0 static unsigned int idx;
> > + =C2=A0 =C2=A0 =C2=A0 int i;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (!of_device_is_available(np))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
>=20
> What is this for?

Anton already answered this question better than I could do.

> > +
> > + =C2=A0 =C2=A0 =C2=A0 pdata =3D match->data;
> > + =C2=A0 =C2=A0 =C2=A0 if (!pdata) {
>=20
> The match table doesn't have any data, so this is a no-op.

The next patch [PATCH 3/3] of the series adds the data to the
match table.

...
> > + =C2=A0 =C2=A0 =C2=A0 if (of_device_is_compatible(np, "fsl-usb2-mph"))=
 {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prop =3D of_get_prop=
erty(np, "port0", NULL);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prop)
>=20
> if (of_get_property())
>=20
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pdata->port_enables |=3D FSL_USB2_PORT0_ENABLED;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prop =3D of_get_prop=
erty(np, "port1", NULL);
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (prop)
>=20
> Ditto

Okay, I'll clean this up.

...
> > +static struct of_platform_driver fsl_usb2_mph_dr_driver =3D {
> > + =C2=A0 =C2=A0 =C2=A0 .driver =3D {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .name =3D "fsl-usb2-=
mph-dr",
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_MODU=
LE,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .of_match_table =3D =
fsl_usb2_mph_dr_of_match,
> > + =C2=A0 =C2=A0 =C2=A0 },
> > + =C2=A0 =C2=A0 =C2=A0 .probe =C2=A0=3D fsl_usb2_mph_dr_of_probe,
> > +};
>=20
> No remove hook?

Since the purpose of the driver is only creation of platform devices
according to the selected dual role controller mode described in
the device tree, I do not see much sense of making the driver a module
and provide a remove hook for destruction of created devices.

...
> > +static int __init fsl_usb2_mph_dr_init(void)
> > +{
> > + =C2=A0 =C2=A0 =C2=A0 return of_register_platform_driver(&fsl_usb2_mph=
_dr_driver);
> > +}
> > +fs_initcall(fsl_usb2_mph_dr_init);
>=20
> Why fs_initcall?  Is module_init() not sufficient?

No. Using module_init() here results in initializing the driver after
loading FLS USB OTG and EHCI-FSL drivers and reverted probing: probe()
in EHCI-FSL driver is called before probe() in OTG driver and doesn't
find OTG transceiver resource which is set and exported by probe() in
OTG driver. This breaks both USB host and device controller support
if dual role controller is configured to operate in OTG mode.

Thanks,
Anatolij
