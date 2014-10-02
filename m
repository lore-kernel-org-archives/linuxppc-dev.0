Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3B99A1A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 11:52:09 +1000 (EST)
Date: Thu, 2 Oct 2014 11:52:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2 2/4] gpu/radeon: Move 64-bit MSI quirk from arch to
 driver
Message-ID: <20141002115202.796eacb1@canb.auug.org.au>
In-Reply-To: <1412210062.10667.1.camel@pasglop>
References: <1412210062.10667.1.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/e0QPA=r0nX9HPR2hvDnOa3C"; protocol="application/pgp-signature"
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 linux-pci@vger.kernel.org, Brian King <brking@linux.vnet.ibm.com>,
 Anton Blanchard <anton@au1.ibm.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Yijing Wang <wangyijing@huawei.com>, Takashi Iwai <tiwai@suse.de>,
 Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/e0QPA=r0nX9HPR2hvDnOa3C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Thu, 02 Oct 2014 10:34:22 +1000 Benjamin Herrenschmidt <benh@kernel.cras=
hing.org> wrote:
>
> --- a/drivers/gpu/drm/radeon/radeon_irq_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_irq_kms.c
> @@ -202,6 +202,16 @@ static bool radeon_msi_ok(struct radeon_device *rdev)
>  	if (rdev->flags & RADEON_IS_AGP)
>  		return false;
> =20
> +	/*
> +	 * Older chips have a HW limitation, they can only generate 40 bits
> +	 * of address for "64-bit" MSIs which breaks on some platforms, notably
> +	 * IBM POWER servers, so we limit them
> +	 */
> +	if (rdev->family < CHIP_BONAIRE) {
> +		dev_info(rdev->dev, "radeon: MSI limited to 32-bit\n");
> +		rdev->pdev->no_64bit_msi =3D true;

Again, no_64bit_msi is not a bool ...

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Sig_/e0QPA=r0nX9HPR2hvDnOa3C
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJULK/HAAoJEMDTa8Ir7ZwVtisP/i5qg6vg8Vy8ZrjYIdVruU4U
aHA7RbZ2CKtGRMFv3NC1PIi2LzQMu6PbQBa9NzsOXuH5Scehs3Ka/hS3+Gdz1WwI
gCvX7Mpw0pqWUFSvrY6v2/RlniC/lesvTCBmI5TqqgVA2/Xm3WhS8q7WIsYVHF+t
ZoVI16gZAF753NZa5OCTbwF2a4A99jN1HvqscOFw1kso+577OiXdX0+xMILOPfd+
JoHEmJiUb1B+uNQPYClNJmziAlM1mPEw9mgCxReAz/sQlV5HD/+rGOJ7NJvdiaBK
yXVqO0+yasKnS/YfKHnWO3Ocu2Tt28SVOQlDhdRM9bp6sh+RU5C7c8/grae4/4oZ
Cf+fstnCo4MPUfNb2IM8TwlU9FJ3SzcBe6XzNsgQPZCaxZnkXcg+3ZaGM2uIV9Kh
yOODLaXnILnnvuBWH6eU/PH7d2xpfdwuSEbvUAgSJiVEpGsRK0HdbvVf2gt5rjbW
O3iyvqb8+VMrp3dCpDcIh4orWLUgJRmfcoVeTGj3DZFAfgJV5shrBZcVcUdQ9Nzs
xagq5q4HA4Z5fzbxU7A9RdKU9Oz3GWYRsJ66BfHTmkOA4Ov+srmQnhJhVL6q/vNN
yRH4shSYX3OBMOVnUpxbACc4Owf65nq7RKzqfnTTZNZcsYRt+PSRw3S9pLkJgTlu
EpHtcnqejKI4FoL2egQK
=67Oq
-----END PGP SIGNATURE-----

--Sig_/e0QPA=r0nX9HPR2hvDnOa3C--
