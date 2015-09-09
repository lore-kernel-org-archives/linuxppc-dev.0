Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6B06F1A2758
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 16:59:20 +1000 (AEST)
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D7224140663
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2015 16:59:19 +1000 (AEST)
Received: by padhk3 with SMTP id hk3so1140613pad.3
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Sep 2015 23:59:18 -0700 (PDT)
Message-ID: <1441781775.7943.27.camel@axtens.net>
Subject: Re: [PATCH] cxl: Fix unbalanced pci_dev_get in cxl_probe
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, andrew.donnellan@au1.ibm.com
Date: Wed, 09 Sep 2015 16:56:15 +1000
In-Reply-To: <1441781009.7943.22.camel@axtens.net>
References: <1441775845-25870-1-git-send-email-dja@axtens.net>
 <1441781009.7943.22.camel@axtens.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-wV9dn3d9y66T3pxTO2pP"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-wV9dn3d9y66T3pxTO2pP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ahaha so I was wrong, device_add does grab a reference.=20

> Currently, cxl_probe(pdev):
>  1) calls pci_dev_get(pdev)
>  2) calls cxl_adapter_init
>     a) init calls cxl_adapter_alloc, which creates a struct cxl,=20
>        conventionally called adapter. This struct contains a=20
>        device entry, adapter->dev.
>=20
>     b) init calls cxl_configure_adapter, where we set=20
>        adapter->dev.parent =3D &dev->dev (here dev is the pci dev)
>=20
> So at this point, the cxl adapter's device's parent is the pci device
> that I want to be refcounted.
>=20
>     c) init calls cxl_register_adapter (which inexplicably is in file.c)
>=20
>        *) cxl_register_adapter calls device_register(&adapter->dev)=20
>=20
> So now we're in device_register, where dev is the adapter device, and we
> want to know if the PCI device is safe after we return.
>=20
> device_register(&adapter->dev) calls device_initialize() and then
> device_add().
>=20
> device_add() does a get_device(). That ends up being a kobject_get() on
> the adapter device kobj, which will increment the kref on the adapter
> device.=20

I was right up to this point, but I didn't read enough of device_add.

device_add explicitly grabs the device's parent, and calls get_device on
it:

         parent =3D get_device(dev->parent);

So it turns out we *are* protected against the device disappearing, my
patch is correct and I don't need a v2.

Thanks to Ian for making me recheck device_add :)

Regards,
Daniel

> The PCI device doesn't get it's kref incremented explicitly.
>=20
> It looks like we're not protected against that disappearing randomly.
>=20
> So thanks, mpe, that was a good catch. I'll do a v2 that keeps the get
> and adds a matching put.
>=20
> Regards,
> Daniel
>=20
> On Wed, 2015-09-09 at 15:17 +1000, Daniel Axtens wrote:
> > Currently the first thing we do in cxl_probe is to grab a reference
> > on the pci device. Later on, we call device_register on our adapter,
> > which also holds the PCI device.
> >=20
> > In our remove path, we call device_unregister, but we never call
> > pci_dev_put. We therefore leak the device every time we do a
> > reflash.
> >=20
> > device_register/unregister is sufficient to hold the reference.
> > Drop the call to pci_dev_get.
> >=20
> > Fixes: f204e0b8cedd ("cxl: Driver code for powernv PCIe based cards for=
 userspace access")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Daniel Axtens <dja@axtens.net>
> >=20
> > ---
> >=20
> > This is the cxl bug that caused me to catch this a few weeks back:
> > e642d11bdbfe ("powerpc/eeh: Probe after unbalanced kref check")
> >=20
> > I put an printk in the unbalanced kref path and confirmed that it
> > was printed with the pci_dev_get in and went away with the
> > pci_dev_get out.
> > ---
> >  drivers/misc/cxl/pci.c | 2 --
> >  1 file changed, 2 deletions(-)
> >=20
> > diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> > index 02c85160bfe9..a5e977192b61 100644
> > --- a/drivers/misc/cxl/pci.c
> > +++ b/drivers/misc/cxl/pci.c
> > @@ -1249,8 +1249,6 @@ static int cxl_probe(struct pci_dev *dev, const s=
truct pci_device_id *id)
> >  	int slice;
> >  	int rc;
> > =20
> > -	pci_dev_get(dev);
> > -
> >  	if (cxl_verbose)
> >  		dump_cxl_config_space(dev);
> > =20
>=20

--=20
Regards,
Daniel

--=-wV9dn3d9y66T3pxTO2pP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJV79gPAAoJEPC3R3P2I92F26UQAJd0+FqeqDnHCnpxWsgUrmSG
swdxVGmX4Xa788jhk+D350S6EVMN0VXr8DCcRqS/Jg4ugp25f9x//WK9t70Z+3Lr
VjaxNke3XkJ/gpvNVCoGOBE8xJH+2RtjcczhsYtmBVaDTIJV2iUVFtCasEdTkAtq
0Y5GqX+Ty4ELTN/rTOc++K5ZtHcRjsPY1b6NA4dGeoMHKl6C9z0PRM+N99zNAiQk
zvaZWMwNXyjUFNVcj+sWWms8JbEzZQk1MjvCGQ4Yk/4K0Kya20PCgu3pm3nZ929s
XWoSHF9hvg1UDEn9syG8ufKoDnkEaGzRRbMEBLf6y/k9UFo530Lsweq8y7GK+89+
dXAzjXuUn2LR97RkKi1BDqZ3c9S4/BXI76hchYAVUbkP9Ntq54/kKHY5d1cv2QTv
oqjNI0PZKmLdR13WoA2cm4eBwlqtgHsXCG0w/qKl9HC6+Qk0A5W5zhXT1eyaAGzx
oq7T0QCx6CVYQao6CtzDuhuAHmonVaHQvGw2070d5dYGwnULksa1rHzcfrVRwpKF
zqTEDFd8BI1iQyLSXYze2vDTwSrNBXGqKuTTeTjzNMf7Ierp3iQg5XFPJtE+fZYh
JTMedqUF15vAHz6R/Ggw+6TpOsGWbnq+oN6MievVv+9DKl3lBvKrlEHx/+Q5HVWB
BiOq7N0AUu4v9yxXQANw
=Qtew
-----END PGP SIGNATURE-----

--=-wV9dn3d9y66T3pxTO2pP--
