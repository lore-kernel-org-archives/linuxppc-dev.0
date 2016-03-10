Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409C21A006F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:44:10 +1100 (AEDT)
Date: Thu, 10 Mar 2016 16:35:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel 02/10] powerpc/powernv: Rename
 pnv_pci_ioda2_tce_invalidate_entire
Message-ID: <20160310053544.GY22546@voom.fritz.box>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-3-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="We3kTPdwkBGsLLkt"
In-Reply-To: <1457504946-40649-3-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--We3kTPdwkBGsLLkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 05:28:58PM +1100, Alexey Kardashevskiy wrote:
> As in fact pnv_pci_ioda2_tce_invalidate_entire() invalidates TCEs for
> the specific PE rather than the entire cache, rename it to
> pnv_pci_ioda2_tce_invalidate_pe(). In later patches we will add
> a proper pnv_pci_ioda2_tce_invalidate_entire().
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 57dc2dc..889eca3 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1824,7 +1824,7 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops =
=3D {
>  	.get =3D pnv_tce_get,
>  };
> =20
> -static inline void pnv_pci_ioda2_tce_invalidate_entire(struct pnv_ioda_p=
e *pe)
> +static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *p=
e)
>  {
>  	/* 01xb - invalidate TCEs that match the specified PE# */
>  	unsigned long val =3D (0x4ull << 60) | (pe->pe_number & 0xFF);
> @@ -2101,7 +2101,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_t=
able_group *table_group,
> =20
>  	pnv_pci_link_table_and_group(phb->hose->node, num,
>  			tbl, &pe->table_group);
> -	pnv_pci_ioda2_tce_invalidate_entire(pe);
> +	pnv_pci_ioda2_tce_invalidate_pe(pe);
> =20
>  	return 0;
>  }
> @@ -2245,7 +2245,7 @@ static long pnv_pci_ioda2_unset_window(struct iommu=
_table_group *table_group,
>  	if (ret)
>  		pe_warn(pe, "Unmapping failed, ret =3D %ld\n", ret);
>  	else
> -		pnv_pci_ioda2_tce_invalidate_entire(pe);
> +		pnv_pci_ioda2_tce_invalidate_pe(pe);
> =20
>  	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--We3kTPdwkBGsLLkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW4QewAAoJEGw4ysog2bOSqRIQAOAbWtBk8pOgKvkBzIxxKNQ5
PybWs4331Re/11jDQfAyQcdovcDdpI3BVd5ioi1Pr1U9v/hOwQ5SK324ss/cB53a
u4UbEA61YjuI5xgd7g1r4PXZ7qWAsMxazfzT1Xtl8WObk/Rqai9qpFrl7ncXqPLp
fCdqk0NdyZw/R9W6+sWIHxHy47FJwzjedlcOjDGGfJlgj+8R7mRECiFA+VoTyUeq
kjlMAmROb9xgMRDAybbhn+7bptnuc2xZlWe+BnpfB4+AmQlsDg17N6vD6syf6sB5
V1d/T//dyuTkFjj+w68oifkVUyBFV8o7eQ7Y9eLzu8qpnoIm2uhyz0gNSA40WJzh
EGUn+yw+GnOQQFWVjfM1Rvu7Y88zqy2RW4r0vbrkM6ant5o3B81aKUooetdDIEPS
46wm6xHYxls+gR2dbdZi0N9YSsDzJpaK1yxTtudmxJ9pBvN6npqxdAMAmHYlCysD
ffm/j4C6w7qgdVHX7kG80lcf9iGYKGUaxzj0lNiLYeBWp0Z2TcZ6cYZIeodWvGZ7
Keu+gCzFyKo0HTjoyRm/dVIqxukl5iNaIt1I7DhNpiJX2mhFTjm+X0rfccGmU0F6
MRsIDDpkfAGLbJDmvjtOXEMIVYc4Vo5ayqObj6GKljztTqgsMLPaLRJPWUN6EtsB
YlbQh5f0NQMUGqivZ3tW
=xCut
-----END PGP SIGNATURE-----

--We3kTPdwkBGsLLkt--
