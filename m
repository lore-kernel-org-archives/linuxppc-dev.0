Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A46FF1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 16:29:25 +1000 (AEST)
Date: Thu, 16 Apr 2015 16:29:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 18/31] powerpc/powernv/ioda2: Rework
 iommu_table creation
Message-ID: <20150416062910.GI3632@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-19-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yzvKDKJiLNESc64M"
In-Reply-To: <1428647473-11738-19-git-send-email-aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--yzvKDKJiLNESc64M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:31:00PM +1000, Alexey Kardashevskiy wrote:
> This moves iommu_table creation to the beginning. This is a mechanical
> patch.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 34 ++++++++++++++++---------=
------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 4d80502..a1e0df9 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1437,27 +1437,33 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
>  	addr =3D page_address(tce_mem);
>  	memset(addr, 0, tce_table_size);
> =20
> +	/* Setup iommu */
> +	pe->table_group.tables[0].it_group =3D &pe->table_group;
> +
> +	/* Setup linux iommu table */
> +	tbl =3D &pe->table_group.tables[0];
> +	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
> +			IOMMU_PAGE_SHIFT_4K);
> +
> +	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
> +	iommu_init_table(tbl, phb->hose->node);
> +#ifdef CONFIG_IOMMU_API
> +	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
> +#endif
> +
>  	/*
>  	 * Map TCE table through TVT. The TVE index is the PE number
>  	 * shifted by 1 bit for 32-bits DMA space.
>  	 */
>  	rc =3D opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
> -					pe->pe_number << 1, 1, __pa(addr),
> -					tce_table_size, 0x1000);
> +			pe->pe_number << 1, 1, __pa(tbl->it_base),
> +			tbl->it_size << 3, 1ULL << tbl->it_page_shift);

This looks like a real change, not just mechanical code movement.

>  	if (rc) {
>  		pe_err(pe, "Failed to configure 32-bit TCE table,"
>  		       " err %ld\n", rc);
>  		goto fail;
>  	}
> =20
> -	/* Setup iommu */
> -	pe->table_group.tables[0].it_group =3D &pe->table_group;
> -
> -	/* Setup linux iommu table */
> -	tbl =3D &pe->table_group.tables[0];
> -	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
> -			IOMMU_PAGE_SHIFT_4K);
> -
>  	/* OPAL variant of PHB3 invalidated TCEs */
>  	swinvp =3D of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
>  	if (swinvp) {
> @@ -1471,16 +1477,12 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
>  				8);
>  		tbl->it_type |=3D (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
>  	}
> -	tbl->it_ops =3D &pnv_ioda2_iommu_ops;
> -	iommu_init_table(tbl, phb->hose->node);
> -#ifdef CONFIG_IOMMU_API
> -	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
> -#endif
>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
>  			pe->pe_number);
> =20
>  	if (pe->pdev)
> -		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
> +		set_iommu_table_base_and_group(&pe->pdev->dev,
> +				&pe->table_group.tables[0]);

And it's not obvious why this change happens either.

>  	else
>  		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yzvKDKJiLNESc64M
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL1a2AAoJEGw4ysog2bOSlFMQAKcWJYXFjH0Chzwg784i2HO7
SVCsHnohqofbQTVKQNGblN1zzKqQP/GZLTI2dhvqEpOkZMcI/yhPoybnJbO4oIxe
dC5JuPG4V41yYYAZaEHIE+UdDiTNmH+kkw3HFgJE9jy52WFwbdnrApyAEpJxTCbf
g6Ik7ihSj96Gx8TcJwOyLd7yZzc2Qv6LGa4u0QRBIojtupsRCRkOoHhQ+NpDdx5O
5IwxrFZH9K+3MuFHcbrTWguYVPkbJQNsJ5uWQ1MmgBPAJXU8HSlJ7cHCW5jqIOOG
zpryLQ1C6q+Z8ZRjBFZL35b7unwxbXZAx9seeNOfjFPC2Q72hbbKl5WplJrsTWWE
2eggGpuL2b1JRVU3oFLc86qkET8trZ7YtM2atNe1qla6whuWbs84LDDY+etPqqFA
L8VgRi9AT4k180yapvGoZrkZdXKTWhom5mWtvsQHB/1VfQIaEbwlLsUoU9vtpHAz
41Zdun/7qPRfU4uKJSsT+wGgaMXzmigTkMz7C1BaHzkvS8ezaKJ7O1AfK1CvC5pe
pcIzSloEFVxYj3BjwVJFM5OrwXjDN2ZrHJ3bR9LNDKRtZtxWpBHW0qivVwNlByuE
Ea61/TA56hjZXoxAwTEsmQw5R8UahjzWvJD4B88YF64fk9BZQXj4BHPVO7QBeeq2
QGW6gRkMK9K4irfI8Bkd
=e/T3
-----END PGP SIGNATURE-----

--yzvKDKJiLNESc64M--
