Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3C1251A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:44:11 +1100 (AEDT)
Date: Thu, 10 Mar 2016 16:43:14 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel 05/10] powerpc/powernv/npu: Use the correct IOMMU
 page size
Message-ID: <20160310054314.GB22546@voom.fritz.box>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-6-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="upHqgONuYbTeMWr5"
In-Reply-To: <1457504946-40649-6-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--upHqgONuYbTeMWr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 05:29:01PM +1100, Alexey Kardashevskiy wrote:
> This uses the page size from iommu_table instead of hard-coded 4K.
> This should cause no change in behavior.
>=20
> While we are here, move bits around to prepare for further rework
> which will define and use iommu_table_group_ops.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/plat=
forms/powernv/npu-dma.c
> index 778570c..5bd5fee 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -204,8 +204,7 @@ static void pnv_npu_disable_bypass(struct pnv_ioda_pe=
 *npe)
>  	struct pnv_phb *phb =3D npe->phb;
>  	struct pci_dev *gpdev;
>  	struct pnv_ioda_pe *gpe;
> -	void *addr;
> -	unsigned int size;
> +	struct iommu_table *tbl;
>  	int64_t rc;
> =20
>  	/*
> @@ -219,11 +218,11 @@ static void pnv_npu_disable_bypass(struct pnv_ioda_=
pe *npe)
>  	if (!gpe)
>  		return;
> =20
> -	addr =3D (void *)gpe->table_group.tables[0]->it_base;
> -	size =3D gpe->table_group.tables[0]->it_size << 3;
> +	tbl =3D gpe->table_group.tables[0];
>  	rc =3D opal_pci_map_pe_dma_window(phb->opal_id, npe->pe_number,
> -					npe->pe_number, 1, __pa(addr),
> -					size, 0x1000);
> +					npe->pe_number, 1, __pa(tbl->it_base),
> +					tbl->it_size << 3,
> +					IOMMU_PAGE_SIZE(tbl));
>  	if (rc !=3D OPAL_SUCCESS)
>  		pr_warn("%s: Error %lld setting DMA window on PHB#%d-PE#%d\n",
>  			__func__, rc, phb->hose->global_number, npe->pe_number);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--upHqgONuYbTeMWr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW4QlyAAoJEGw4ysog2bOSyBUQANFZD7y+84giqzLByeqvnxXo
Gh9Z6vxqvAqDmxhhqHgmpxrorDLFY+kL8eZIb45GChu6TlvPMuv3mktguFnA9BTu
Vkm5yNPSiW6h2snsq7bc8hgl3L4Yv4hvS0tMbkRrLJDvlz9sBhDyCcZKj8WDXUDM
E3iIXh3KpAvsQqdAOvmllrhuAGP89Ew5y60LfgtWGn7YCohykpzJ5WIl7hSV4zl1
2JC/LNx+zIagHwQUKEEAr9FtV3cVHaVdq0CzVse3iFuFCLZDkfvTF6//deE2Auyu
w5tN+Yn9dqxrLhvItb+pH7JVy65yT3LWRuSx+7T/7z7laO66id17CcPribKK0ERe
YY7RfhzS9t+NOODRBfW/ag0YH+6F6EGIHH1MGhwQOnDOBhCatX8qtBRX7OYGKopy
aFF1zOuP8UbdDrzKbm+5AwiHh6VFkD7esr8GMa/0NiWoo8nfR8frYkI+G1ni1CPl
I097xrzNJ2LbRbKLLucS3NBLauYcqeMzG5TJI7gqDcebl/OdsekfGnajy9GlTRjS
RRJzLuINY4hpSplpyKg3RrsAxifAxy6/xdYcmK4K6HIlqofw/feWv5ke/+KAWrA1
A38t8CHCb98TKLNz0paIc9hlZsZKrd0f3fUW3opjfPCHB0cgSZHYWCgvLgQrM3xy
3ua8w/VIHvmlr67NSZud
=PmB9
-----END PGP SIGNATURE-----

--upHqgONuYbTeMWr5--
