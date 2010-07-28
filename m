Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f170.google.com (mail-yx0-f170.google.com
	[209.85.213.170]) by ozlabs.org (Postfix) with ESMTP id 203F3B6F10
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jul 2010 04:14:36 +1000 (EST)
Received: by yxi11 with SMTP id 11so1632538yxi.15
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jul 2010 11:14:34 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100728135858.5dc14484@wker>
References: <1279815922-27198-1-git-send-email-agust@denx.de>
	<1279815922-27198-3-git-send-email-agust@denx.de>
	<AANLkTinSeFWM4bQK+o8nwStd6C-OcxMagC7TjwCBNn1v@mail.gmail.com>
	<20100728135858.5dc14484@wker>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 28 Jul 2010 12:14:14 -0600
Message-ID: <AANLkTimrtR4yi0czotS_6K_njxiA4orj6SznpqWDGBpy@mail.gmail.com>
Subject: Re: [PATCH 2/3] USB: add of_platform glue driver for FSL USB DR
	controller
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
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

On Wed, Jul 28, 2010 at 5:58 AM, Anatolij Gustschin <agust@denx.de> wrote:
> Hi Grant,
>
> On Wed, 28 Jul 2010 02:16:08 -0600
> Grant Likely <grant.likely@secretlab.ca> wrote:
>
>> On Thu, Jul 22, 2010 at 10:25 AM, Anatolij Gustschin <agust@denx.de> wro=
te:
>> > The driver creates platform devices based on the information
>> > from USB nodes in the flat device tree. This is the replacement
>> > for old arch fsl_soc usb code removed by the previous patch.
>> > It uses usual of-style binding, available EHCI-HCD and UDC
>> > drivers can be bound to the created devices. The new of-style
>> > driver additionaly instantiates USB OTG platform device, as the
>> > appropriate USB OTG driver will be added soon.
>> >
>> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
>> > Cc: Kumar Gala <galak@kernel.crashing.org>
>> > Cc: Grant Likely <grant.likely@secretlab.ca>
>>
>> Hi Anatolij,
>>
>> Looks pretty good, but some comments below.
>
> Thanks for review and comments! Greg already merged this series and
> therefore I'll submit an incremental cleanup patch to address
> outstanding issues. My reply is below.

Greg maintains a patchwork tree IIRC.  I believe he drops patches from
his linux-next branch if they need to be reworked.  Greg, do I have
this right?

Also, my preference would be to see some 3rd party testing before
committing to having this merged.

>
> ...
>> > --- a/drivers/usb/host/Kconfig
>> > +++ b/drivers/usb/host/Kconfig
>> > @@ -112,10 +112,15 @@ config XPS_USB_HCD_XILINX
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0support both high speed and full speed =
devices, or high speed
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0devices only.
>> >
>> > +config USB_FSL_MPH_DR_OF
>> > + =A0 =A0 =A0 bool
>> > + =A0 =A0 =A0 depends on PPC_OF
>>
>> Drop the depends. =A0This is selected by USB_EHCI_FSL and
>> USB_GADGET_FSL_USB2, which are already PPC only.
>
> Okay, will remove it.
>
> ...
>> > +struct fsl_usb2_dev_data dr_mode_data[] __devinitdata =3D {
>> > + =A0 =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "host",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "fsl-ehci", NULL, NULL, },
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 FSL_USB2_DR_HOST,
>> > + =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "otg",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "fsl-ehci", "fsl-usb2-udc", "fsl-usb2-=
otg", },
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 FSL_USB2_DR_OTG,
>> > + =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "periferal",
>>
>> spelling. =A0"peripheral"
>
> Right, thanks for catching! Will fix it.
>
>>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 { "fsl-usb2-udc", NULL, NULL, },
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 FSL_USB2_DR_DEVICE,
>> > + =A0 =A0 =A0 },
>> > +};
>>
>> Program defensively. =A0Use the following form:
>> + =A0 =A0 =A0 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .dr_mode =3D "host",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .drivers =3D { "fsl-ehci", NULL, NULL, },
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .op_mode =3D FSL_USB2_DR_HOST,
>> + =A0 =A0 =A0 },
>
> I'll change it too as suggested.
>
> ...
>> > +struct fsl_usb2_dev_data * __devinit get_dr_mode_data(struct device_n=
ode *np)
>> > +{
>> > + =A0 =A0 =A0 const unsigned char *prop;
>> > + =A0 =A0 =A0 int i;
>> > +
>> > + =A0 =A0 =A0 prop =3D of_get_property(np, "dr_mode", NULL);
>> > + =A0 =A0 =A0 if (prop) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (i =3D 0; i < ARRAY_SIZE(dr_mode_dat=
a); i++) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!strcmp(prop, dr_mod=
e_data[i].dr_mode))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return &=
dr_mode_data[i];
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>
>> Print a warning if you get through the loop, but don't match anything.
>> =A0That means that dr_mode has a bad value.
>
> I'll add a warning here.
>
> ...
>> > +struct platform_device * __devinit
>> > +fsl_usb2_device_register(struct of_device *ofdev,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct fsl_usb2_platf=
orm_data *pdata,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const char *name, int=
 id)
>>
>> In general, it is better to have the function name on the same line as
>> the return arguements so that grep shows the relevant info. =A0Move the
>> arguments to subsequent lines.
>
> It will be fixed in a clean-up patch.
>
> ...
>> > +static int __devinit fsl_usb2_mph_dr_of_probe(struct of_device *ofdev=
,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0const struct of_device_id *match)
>> > +{
>> > + =A0 =A0 =A0 struct device_node *np =3D ofdev->dev.of_node;
>> > + =A0 =A0 =A0 struct platform_device *usb_dev;
>> > + =A0 =A0 =A0 struct fsl_usb2_platform_data data, *pdata;
>> > + =A0 =A0 =A0 struct fsl_usb2_dev_data *dev_data;
>> > + =A0 =A0 =A0 const unsigned char *prop;
>> > + =A0 =A0 =A0 static unsigned int idx;
>> > + =A0 =A0 =A0 int i;
>> > +
>> > + =A0 =A0 =A0 if (!of_device_is_available(np))
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
>>
>> What is this for?
>
> Anton already answered this question better than I could do.
>
>> > +
>> > + =A0 =A0 =A0 pdata =3D match->data;
>> > + =A0 =A0 =A0 if (!pdata) {
>>
>> The match table doesn't have any data, so this is a no-op.
>
> The next patch [PATCH 3/3] of the series adds the data to the
> match table.
>
> ...
>> > + =A0 =A0 =A0 if (of_device_is_compatible(np, "fsl-usb2-mph")) {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D of_get_property(np, "port0", NU=
LL);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop)
>>
>> if (of_get_property())
>>
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata->port_enables |=3D=
 FSL_USB2_PORT0_ENABLED;
>> > +
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 prop =3D of_get_property(np, "port1", NU=
LL);
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (prop)
>>
>> Ditto
>
> Okay, I'll clean this up.
>
> ...
>> > +static struct of_platform_driver fsl_usb2_mph_dr_driver =3D {
>> > + =A0 =A0 =A0 .driver =3D {
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "fsl-usb2-mph-dr",
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .of_match_table =3D fsl_usb2_mph_dr_of_m=
atch,
>> > + =A0 =A0 =A0 },
>> > + =A0 =A0 =A0 .probe =A0=3D fsl_usb2_mph_dr_of_probe,
>> > +};
>>
>> No remove hook?
>
> Since the purpose of the driver is only creation of platform devices
> according to the selected dual role controller mode described in
> the device tree, I do not see much sense of making the driver a module
> and provide a remove hook for destruction of created devices.

It is still appropriate to have a remove function so the driver can be
unbound.  The remove function should unregister the platform devices
it created in .probe().

>
> ...
>> > +static int __init fsl_usb2_mph_dr_init(void)
>> > +{
>> > + =A0 =A0 =A0 return of_register_platform_driver(&fsl_usb2_mph_dr_driv=
er);
>> > +}
>> > +fs_initcall(fsl_usb2_mph_dr_init);
>>
>> Why fs_initcall? =A0Is module_init() not sufficient?
>
> No. Using module_init() here results in initializing the driver after
> loading FLS USB OTG and EHCI-FSL drivers and reverted probing: probe()
> in EHCI-FSL driver is called before probe() in OTG driver and doesn't
> find OTG transceiver resource which is set and exported by probe() in
> OTG driver. This breaks both USB host and device controller support
> if dual role controller is configured to operate in OTG mode.

This is still broken then, and it is just luck that it is even working
now.  The three sub-devices are registered in sequence which should
handle your ordering issues if you put the OTG driver at the start of
the list; but even that is rather hacky.  You need to make the
EHCI-FSL drivers defer initialization if it has to wait for the OTG
driver.  One option might be to use a bus notifier for this.

I won't nack this patch because of this problem because the problem
already exists in the current code, but it really does need to be
fixed.

g.
