Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408dpM3503zF1xj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 13:47:07 +1100 (AEDT)
Message-ID: <1522032426.19684.64.camel@neuling.org>
Subject: Re: [PATCH] powerpc/eeh: Fix race with driver un/bind
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc, sam.bobroff@au1.ibm.com
Date: Mon, 26 Mar 2018 13:47:06 +1100
In-Reply-To: <1521786791.16434.339.camel@kernel.crashing.org>
References: <20180323054417.3268-1-mikey@neuling.org>
 <1521786791.16434.339.camel@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2018-03-23 at 17:33 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2018-03-23 at 16:44 +1100, Michael Neuling wrote:
>=20
>  .../...
>=20
> > This fixes the problem in the same way the generic PCIe AER code (in
> > drivers/pci/pcie/aer/aerdrv_core.c) does. It makes the EEH code hold
> > the device_lock() before performing the driver EEH callbacks. This
> > ensures either the callbacks are no longer register, or if they are
> > registered the driver will not be removed from underneath us.
> >=20
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
>=20
> Generally ok, minor nits though and do we want a CC stable ?

ok, I'll cc stable.

>=20
> > ---
> >  arch/powerpc/kernel/eeh_driver.c | 67 ++++++++++++++++++++++++--------=
-----
> > ---
> >  1 file changed, 41 insertions(+), 26 deletions(-)
> >=20
> > diff --git a/arch/powerpc/kernel/eeh_driver.c
> > b/arch/powerpc/kernel/eeh_driver.c
> > index 0c0b66fc5b..7cf946ae9a 100644
> > --- a/arch/powerpc/kernel/eeh_driver.c
> > +++ b/arch/powerpc/kernel/eeh_driver.c
> > @@ -207,18 +207,18 @@ static void *eeh_report_error(void *data, void
> > *userdata)
> > =20
> >  	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
> >  		return NULL;
> > +
> > +	device_lock(&dev->dev);
> >  	dev->error_state =3D pci_channel_io_frozen;
> > =20
> >  	driver =3D eeh_pcid_get(dev);
> > -	if (!driver) return NULL;
> > +	if (!driver) goto out2;
>=20
> I don't like out1/out2, why not call them out_nodev and out_no_handler
> ? (same comment for the other ones).

OK, will change.

> > =20
> >  	eeh_disable_irq(dev);
> > =20
> >  	if (!driver->err_handler ||
> > -	    !driver->err_handler->error_detected) {
> > -		eeh_pcid_put(dev);
> > -		return NULL;
> > -	}
> > +	    !driver->err_handler->error_detected)
> > +		goto out1;
> > =20
> >  	rc =3D driver->err_handler->error_detected(dev,
> > pci_channel_io_frozen);
> > =20
> > @@ -227,8 +227,11 @@ static void *eeh_report_error(void *data, void
> > *userdata)
> >  	if (*res =3D=3D PCI_ERS_RESULT_NONE) *res =3D rc;
> > =20
> >  	edev->in_error =3D true;
> > -	eeh_pcid_put(dev);
> >  	pci_uevent_ers(dev, PCI_ERS_RESULT_NONE);
> > +out1:
> > +	eeh_pcid_put(dev);
> > +out2:
>=20
> This also changes doing the uevent while holding a reference and the
> the device lock, is that ok ? (I guess a reference is a good thing, the
> device lock, not sure... I hope so but you should at least document it
> as a chance in the cset comment).

The AER code does this, so it should be ok. See report_error_detected().

Mikey
