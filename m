Return-Path: <dja@axtens.net>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 28A981A2757
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Sep 2015 16:46:52 +1000 (AEST)
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1BF3314076A
 for <linuxppc-dev@ozlabs.org>; Wed,  9 Sep 2015 16:46:50 +1000 (AEST)
Received: by padhk3 with SMTP id hk3so805661pad.3
 for <linuxppc-dev@ozlabs.org>; Tue, 08 Sep 2015 23:46:49 -0700 (PDT)
Message-ID: <1441781009.7943.22.camel@axtens.net>
Subject: Re: [PATCH] cxl: Fix unbalanced pci_dev_get in cxl_probe
From: Daniel Axtens <dja@axtens.net>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org, mikey@neuling.org,
 imunsie@au.ibm.com, andrew.donnellan@au1.ibm.com
Date: Wed, 09 Sep 2015 16:43:29 +1000
In-Reply-To: <1441775845-25870-1-git-send-email-dja@axtens.net>
References: <1441775845-25870-1-git-send-email-dja@axtens.net>
Content-Type: multipart/signed; micalg="pgp-sha512";
 protocol="application/pgp-signature"; boundary="=-L5gprjIfsXJ9iu/ZHAuw"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-L5gprjIfsXJ9iu/ZHAuw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

mpe asked me to clarify that this was correct. Turns out it's not.

Currently, cxl_probe(pdev):
 1) calls pci_dev_get(pdev)
 2) calls cxl_adapter_init
    a) init calls cxl_adapter_alloc, which creates a struct cxl,=20
       conventionally called adapter. This struct contains a=20
       device entry, adapter->dev.

    b) init calls cxl_configure_adapter, where we set=20
       adapter->dev.parent =3D &dev->dev (here dev is the pci dev)

So at this point, the cxl adapter's device's parent is the pci device
that I want to be refcounted.

    c) init calls cxl_register_adapter (which inexplicably is in file.c)

       *) cxl_register_adapter calls device_register(&adapter->dev)=20

So now we're in device_register, where dev is the adapter device, and we
want to know if the PCI device is safe after we return.

device_register(&adapter->dev) calls device_initialize() and then
device_add().

device_add() does a get_device(). That ends up being a kobject_get() on
the adapter device kobj, which will increment the kref on the adapter
device. The PCI device doesn't get it's kref incremented explicitly.

It looks like we're not protected against that disappearing randomly.

So thanks, mpe, that was a good catch. I'll do a v2 that keeps the get
and adds a matching put.

Regards,
Daniel

On Wed, 2015-09-09 at 15:17 +1000, Daniel Axtens wrote:
> Currently the first thing we do in cxl_probe is to grab a reference
> on the pci device. Later on, we call device_register on our adapter,
> which also holds the PCI device.
>=20
> In our remove path, we call device_unregister, but we never call
> pci_dev_put. We therefore leak the device every time we do a
> reflash.
>=20
> device_register/unregister is sufficient to hold the reference.
> Drop the call to pci_dev_get.
>=20
> Fixes: f204e0b8cedd ("cxl: Driver code for powernv PCIe based cards for u=
serspace access")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Axtens <dja@axtens.net>
>=20
> ---
>=20
> This is the cxl bug that caused me to catch this a few weeks back:
> e642d11bdbfe ("powerpc/eeh: Probe after unbalanced kref check")
>=20
> I put an printk in the unbalanced kref path and confirmed that it
> was printed with the pci_dev_get in and went away with the
> pci_dev_get out.
> ---
>  drivers/misc/cxl/pci.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/drivers/misc/cxl/pci.c b/drivers/misc/cxl/pci.c
> index 02c85160bfe9..a5e977192b61 100644
> --- a/drivers/misc/cxl/pci.c
> +++ b/drivers/misc/cxl/pci.c
> @@ -1249,8 +1249,6 @@ static int cxl_probe(struct pci_dev *dev, const str=
uct pci_device_id *id)
>  	int slice;
>  	int rc;
> =20
> -	pci_dev_get(dev);
> -
>  	if (cxl_verbose)
>  		dump_cxl_config_space(dev);
> =20

--=20
Regards,
Daniel

--=-L5gprjIfsXJ9iu/ZHAuw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: GPGTools - https://gpgtools.org

iQIcBAABCgAGBQJV79UhAAoJEPC3R3P2I92FAkgQALQ7eShz294PmsEVv/hg508v
I8Ht07QTTayHnLgAyLk7qVjSNKfkYQwHJsGYVrSswmp0PCNo12Yc16VweUjyn0Eg
k0YnCBdqXej94u0+fQD16N/J37Zfsq77rikY0d5q4W/iLF8S3lrTY94U+Tiy9dRc
y4MwiL11h8CCDm1QnSAXjiz4xAYmqhXEkfd9xUZq56PRpL9CQHcSxGIVN07WrUeF
nZrmQovR187zcwugknN/UxjYl+KcjVHKfpg0q5qGHD6OwkR0U9hdVsiH/Xn3IeJL
omwEvYS6Zrpoz8MpBtY1kFaRmwFmvGSMTWE/2NmyJxq4TxyO1vTu+si/21RLRCTo
//B6sjXfUfqrjwHQYvY55AjLaMQqfQQW/ghH5fY65WVn6v+5l097rLAP24SF5Zq9
FzY//zvJQuNLhMrJmK8YZ8NdlmhB+h03KhhwmCWXuj1q7EaA2MSkxU1tee8CukGi
9yPREIRdC4MWRvgRBBjOQxKD+Z6Hjwz2INGJoIkhW48gW04XJtfj2U+qojuATD27
93fOFarm76qkP9tUSBwpw8rpx5uT10zKKlH9V1XcMWUYVPBoJsao38sDYixMKHW8
A40nT3pcsDI85f5Ak5XtghWHiD6p4Auzzsotz7+Le4f26j6KkAeFYnnubMhiNMT7
vPMx3igkmTipnNtxTorg
=TRG4
-----END PGP SIGNATURE-----

--=-L5gprjIfsXJ9iu/ZHAuw--
