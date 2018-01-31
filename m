Return-Path: <James.Hogan@mips.com>
Received: from 9pmail.ess.barracuda.com (9pmail.ess.barracuda.com
 [64.235.150.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zWfNz1rmMzDrHM
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 Jan 2018 21:19:14 +1100 (AEDT)
Date: Wed, 31 Jan 2018 10:03:46 +0000
From: James Hogan <james.hogan@mips.com>
To: Gabriel Paubert <paubert@iram.es>
CC: <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Wifi (B43) broken on G4 PowerBooks with kernel v4.15
Message-ID: <20180131100345.GD21356@jhogan-linux.mipstec.com>
References: <20180131093730.ikmoawgh3mh2pxoy@lt-gp.iram.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
In-Reply-To: <20180131093730.ikmoawgh3mh2pxoy@lt-gp.iram.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2018 at 10:37:30AM +0100, Gabriel Paubert wrote:
> 	Hi,
>=20
> yesterday I recompiled the kernel on my late 2005 G4 PowerBook, and the
> Wifi stopped working. After comparing the configuration is turns out
> that a change to a Kconfig condition disabled SSB support which is
> necessary for these chips.
>=20
> The graph of configuration options is quite messy, and I'm not sure that
> I fully understand it.
>=20
> Nevertheless the following patch fixes the regression, but there might
> be a better way to solve the problem.
>=20
> If you pick up this trivial patch as is, you may add:
>=20
> Signed-off-by: Gabriel Paubert <paubert@iram.es>
>=20
> diff --git a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
> index 71c7376..d189db6 100644
> --- a/drivers/ssb/Kconfig
> +++ b/drivers/ssb/Kconfig
> @@ -32,7 +32,7 @@ config SSB_BLOCKIO
> =20
>  config SSB_PCIHOST_POSSIBLE
>  	bool
> -	depends on SSB && (PCI =3D y || PCI =3D SSB) && PCI_DRIVERS_LEGACY
> +	depends on SSB && (PCI =3D y || PCI =3D SSB) && (PCI_DRIVERS_LEGACY || =
B43_SSB)
>  	default y
> =20
>  config SSB_PCIHOST
>=20

Yes, really sorry about that. There is a patch here:
https://patchwork.kernel.org/patch/10185397/

which is applied to linux-next as commit
a9e6d44ddeccd3522670e641f1ed9b068e746ff7.

Cheers
James

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpxlHMACgkQbAtpk944
dnr7rg/+L+TcymiaLhyMO+WhmnjBPBKiRj6tkrHBQOcFJOZcxuJluHeFvlyqDcUO
elTC0ahfpJA1vOutRKEW1UfYE/PYLd510ECLpRYgtg+to7gzEETMxNUlq3akYfH9
StHGvci/patcPZ3+Dirpjpsj8foAXpvIwmEwNZAckhuI7uCyZb1N6+Oy4jXTbuo/
1FKSydVNvK5MMoTuGUfLsu3guDB1LZm/3UpAGTKdorKAgEGvBb9iRiJ8V+rwzhTT
LAgEKraSjlnlpvhx1xWCqvzH5EBfUdUZy5uz/v/EHQrCl9AK8MQ3K5v8UbhKjZgW
OniM7tOAL2mjsn8dy4gINCuWBNj15wWnmLITS+r857auV4kYb6QXdMyV7ClhNEEG
Nla+BH8JhpoJoaDJnd7S+jOxXIMNHg95QzARapzLBu8ZrIEioUPDijQjPu7eAyZi
o2XQ2mJsf9RDgayXeXPV77Jtlm+caq+9ukJR6OCnA5iLaWj37WUaycYiiN60FEso
u6210RIGAK5w5mMvpxje1BcHrBdxJ2DLePdndXTrsplnmm9ySRqT1vIAAVKbU/dj
rBCHofkjpdv1kqhdrMLPYWsIisDCwIPshZrLoDEGxTsJszHJqJbvYINv8rdooN+5
AzoCUQlFRYCe8jg0V17zip+ul98443Y4SjzlJNbjkexc0xRGzJY=
=ss8/
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
