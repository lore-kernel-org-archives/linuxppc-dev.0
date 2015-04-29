Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C270C1A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:50:03 +1000 (AEST)
Date: Wed, 29 Apr 2015 14:04:36 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 17/32] powerpc/powernv: Implement accessor to
 TCE entry
Message-ID: <20150429040436.GN32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-18-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="i6vqABX3nJKXLk01"
In-Reply-To: <1429964096-11524-18-git-send-email-aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--i6vqABX3nJKXLk01
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:41PM +1000, Alexey Kardashevskiy wrote:
> This replaces direct accesses to TCE table with a helper which
> returns an TCE entry address. This does not make difference now but will
> when multi-level TCE tables get introduces.
>=20
> No change in behavior is expected.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>


> ---
> Changes:
> v9:
> * new patch in the series to separate this mechanical change from
> functional changes; this is not right before
> "powerpc/powernv: Implement multilevel TCE tables" but here in order
> to let the next patch - "powerpc/iommu/powernv: Release replaced TCE" -
> use pnv_tce() and avoid changing the same code twice
> ---
>  arch/powerpc/platforms/powernv/pci.c | 34 +++++++++++++++++++++---------=
----
>  1 file changed, 21 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index 84b4ea4..ba75aa5 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -572,38 +572,46 @@ struct pci_ops pnv_pci_ops =3D {
>  	.write =3D pnv_pci_write_config,
>  };
> =20
> +static __be64 *pnv_tce(struct iommu_table *tbl, long idx)
> +{
> +	__be64 *tmp =3D ((__be64 *)tbl->it_base);
> +
> +	return tmp + idx;
> +}
> +
>  int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
>  		unsigned long uaddr, enum dma_data_direction direction,
>  		struct dma_attrs *attrs)
>  {
>  	u64 proto_tce =3D iommu_direction_to_tce_perm(direction);
> -	__be64 *tcep;
> -	u64 rpn;
> +	u64 rpn =3D __pa(uaddr) >> tbl->it_page_shift;

I guess this was a problem in the existing code, not this patch.  But
"uaddr" is a really bad name (and unsigned long is a bad type) for
what must actually be a kernel linear mapping address.

> +	long i;
> =20
> -	tcep =3D ((__be64 *)tbl->it_base) + index - tbl->it_offset;
> -	rpn =3D __pa(uaddr) >> tbl->it_page_shift;
> -
> -	while (npages--)
> -		*(tcep++) =3D cpu_to_be64(proto_tce |
> -				(rpn++ << tbl->it_page_shift));
> +	for (i =3D 0; i < npages; i++) {
> +		unsigned long newtce =3D proto_tce |
> +			((rpn + i) << tbl->it_page_shift);
> +		unsigned long idx =3D index - tbl->it_offset + i;
> =20
> +		*(pnv_tce(tbl, idx)) =3D cpu_to_be64(newtce);
> +	}
> =20
>  	return 0;
>  }
> =20
>  void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
>  {
> -	__be64 *tcep;
> +	long i;
> =20
> -	tcep =3D ((__be64 *)tbl->it_base) + index - tbl->it_offset;
> +	for (i =3D 0; i < npages; i++) {
> +		unsigned long idx =3D index - tbl->it_offset + i;
> =20
> -	while (npages--)
> -		*(tcep++) =3D cpu_to_be64(0);
> +		*(pnv_tce(tbl, idx)) =3D cpu_to_be64(0);
> +	}
>  }
> =20
>  unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
>  {
> -	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
> +	return *(pnv_tce(tbl, index - tbl->it_offset));
>  }
> =20
>  void pnv_pci_setup_iommu_table(struct iommu_table *tbl,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i6vqABX3nJKXLk01
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQFhUAAoJEGw4ysog2bOSJCEP/iKDdnimSBMX1rvO9njQSKE3
qNgrR1KRWWHX9bTr32pnvfhqpXxI/KJ3hnVXRDB+2qANpXyrp8vuKeNIRDqRBgR6
o46V9o2D0i2Q+ILfoYUKs5xHgXJJ69P/RcCML+nU/48zOe7kx0JWXr9iEXOJ0e93
fzXmdYsRNnTfCUefBkzI6ixL8jxEDWLcCxpZMuDATo32APu3dngllCBQrSc9fcr4
v1y4rmVfkIsec9AvoEb2TwD9PdG7Tr2+K0fF46t7IB1mPUqKNn8LVpBg3qR16xfe
uoBzjj5YflBmYzP1/urHJxFZuCThx1wm/0qkDUh8gWn4BPlyS3mr66afGIOwTFLK
u91pd2y1sH/N2gx57tf8X4sLktaEbmluhPBeymIBml9KR3yEoz1lDlWWlLUUeH/S
U3IS3lmo7hr5r962m4RoVeDmFNrQbBHHg2ZqpGg88sPt2bHguPABMny9ZUqHs5VG
k9DOFGwRVecc2zJI3d5oio/WjyUlYc63fjdRUmJeYqiS/jimZpZ5xi1k/JrWoEHV
XydLd5vgijsQjHA1VdAsop6kBCcYhLtmTaXy0Z/wt2NnCZshR1k4V8lUIK3MmPGd
kp3GDN8iZMmaXp8SNenn2Yk74eUIP3+zx8jpOxAB/WJkxCTYp5FRrmSi6PwfRQ9E
1QpQUEr8/892n/D3/Bvh
=cF+g
-----END PGP SIGNATURE-----

--i6vqABX3nJKXLk01--
