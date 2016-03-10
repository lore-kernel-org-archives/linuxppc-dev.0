Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7C501A005D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:44:10 +1100 (AEDT)
Date: Thu, 10 Mar 2016 16:36:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel 03/10] powerpc/powernv: Define TCE Kill flags
Message-ID: <20160310053657.GZ22546@voom.fritz.box>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-4-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AVsU0XxfC6ed1aQ6"
In-Reply-To: <1457504946-40649-4-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--AVsU0XxfC6ed1aQ6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 05:28:59PM +1100, Alexey Kardashevskiy wrote:
> This replaces magic constants for TCE Kill IODA2 register with macros.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 889eca3..33e9489 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1824,10 +1824,13 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops=
 =3D {
>  	.get =3D pnv_tce_get,
>  };
> =20
> +#define TCE_KILL_INVAL_PE   PPC_BIT(1)
> +#define TCE_KILL_INVAL_TCE  PPC_BIT(2)
> +
>  static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *p=
e)
>  {
>  	/* 01xb - invalidate TCEs that match the specified PE# */
> -	unsigned long val =3D (0x4ull << 60) | (pe->pe_number & 0xFF);
> +	unsigned long val =3D TCE_KILL_INVAL_PE | (pe->pe_number & 0xFF);
>  	struct pnv_phb *phb =3D pe->phb;
>  	struct pnv_ioda_pe *npe;
>  	int i;
> @@ -1855,7 +1858,7 @@ static void pnv_pci_ioda2_do_tce_invalidate(unsigne=
d pe_number, bool rm,
>  	unsigned long start, end, inc;
> =20
>  	/* We'll invalidate DMA address in PE scope */
> -	start =3D 0x2ull << 60;
> +	start =3D TCE_KILL_INVAL_TCE;
>  	start |=3D (pe_number & 0xFF);
>  	end =3D start;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--AVsU0XxfC6ed1aQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW4Qf5AAoJEGw4ysog2bOS9IAQAOCdys+92LL60HpFLP9+mI4/
kVzMKkW5URHoElbHrjP6B4seLmI8ijwxzTzfElkMu9MKCHTzkj3zPh0tL9/OC+wN
YHwRJDmEMy+ZwUYaTyqaYaA1dlbeOOo6CIENIcsbf8ssbJuA+k97sS/6vZM37uND
L8BgsmlY/ibrecK3df/Qtb4Wsor7LdEN5fSA6oZf2cIa1Z6oxyqa9izIcSu372b5
trM+WmYbiU0TW4w180wKk2cIsQOfLjbbyYTZJcVyzyammeUUscRf6pVH38WlKLoE
a9hMwNi8zXjDvblyuF6yfcHYaBq7njJ39dopMI+dCsUeDFQkCMxNa2JupIyxKa3K
ZOGCy4qqDkdLhrGYugRF8/zIZDh2trI3xNj4wDZl8VDtFn3AfI4yluJVRYBRBVcs
zwdB/QOGA3fTYBf767XYLbEddPyNN7mfyZmQV9XyDqDUaVySyUgSbMQlL5hZOoLW
iUIfqdRuWmFb563w2hlVe7dPvbmTahdVYdQ1y/0Do6HT1hm7pW2I41P3UadfHVau
WA436KTnGcVVsdF1Ru1acMH4uo9SNcj4iLcCOcvOLb6CqeEDxEnt1p4GDVZHgAc7
MPLpDwgriPrIARKsl0zaKM+jm0tIZoHJXZpe9+Q+Zx/ro3IIZm03fj/OQ38Nryu+
fpTssd7frtiIwrNtzsda
=Abos
-----END PGP SIGNATURE-----

--AVsU0XxfC6ed1aQ6--
