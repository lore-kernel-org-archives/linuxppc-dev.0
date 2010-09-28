Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 3BC2EB70D6
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Sep 2010 21:35:27 +1000 (EST)
Date: Tue, 28 Sep 2010 13:35:24 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 2/3] USB: add of_platform glue driver for FSL USB DR
	controller
Message-ID: <20100928133524.6262c35c@wker>
In-Reply-To: <AANLkTinnodk8wA2aHXBjmZRhv_OFS+zQdb5Tc6of36jQ@mail.gmail.com>
References: <1285666594-21150-1-git-send-email-agust@denx.de>
	<1285666594-21150-3-git-send-email-agust@denx.de>
	<AANLkTinnodk8wA2aHXBjmZRhv_OFS+zQdb5Tc6of36jQ@mail.gmail.com>
Mime-Version: 1.0
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

Hi Grant,

On Tue, 28 Sep 2010 19:01:28 +0900
Grant Likely <grant.likely@secretlab.ca> wrote:
...
> Looks pretty good.  Comments below.  Main comment is that with the
> recent changes in mainline, this no longer needs to be an
> of_platform_driver.  It can be a plain old platform_driver instead.
> It gets registered as a platform_driver anyway, but of_platform_driver
> is a shim that adds a bit of overhead, so it is best to avoid it.
> I'll detail the changes you need to make in my comments below.

Thanks. I'll change to platform_driver. My reply below.

...
> > +{
> > + =A0 =A0 =A0 struct device_node *np =3D ofdev->dev.of_node;
> > + =A0 =A0 =A0 struct platform_device *usb_dev;
> > + =A0 =A0 =A0 struct fsl_usb2_platform_data data, *pdata;
> > + =A0 =A0 =A0 struct fsl_usb2_dev_data *dev_data;
> > + =A0 =A0 =A0 const unsigned char *prop;
> > + =A0 =A0 =A0 static unsigned int idx;
> > + =A0 =A0 =A0 int i;
> > +
> > + =A0 =A0 =A0 if (!of_device_is_available(np))
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;
> > +
> > + =A0 =A0 =A0 pdata =3D match->data;
> > + =A0 =A0 =A0 if (!pdata) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memset(&data, 0, sizeof(data));
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata =3D &data;
> > + =A0 =A0 =A0 }
>=20
> This is bad behaviour.  *match->data must not be modified in probe
> because multiple instances of the device can exist.  The target of
> pdata is modified later in the probe routine.
>=20
> However, the above 4 lines can be removed entirely since none of the
> fsl_usb2_mph_dr_of_match entries actually set the data pointer.  The
> local 'data' structure can be used directly.

A match entry for mpc5121 is added by the third patch. I'll fix
this so that only local 'data' structure is modified later in the
probe routine.

Thanks,
Anatolij
