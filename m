Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 64BBD1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 10:05:06 +1000 (AEST)
Date: Tue, 2 Jun 2015 09:30:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 26/34] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_set_window
Message-ID: <20150601233039.GP22789@voom.redhat.com>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-27-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tzZdJ4yHDV5r1Akt"
In-Reply-To: <1432889098-22924-27-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tzZdJ4yHDV5r1Akt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2015 at 06:44:50PM +1000, Alexey Kardashevskiy wrote:
> This is a part of moving DMA window programming to an iommu_ops
> callback. pnv_pci_ioda2_set_window() takes an iommu_table_group as
> a first parameter (not pnv_ioda_pe) as it is going to be used as
> a callback for VFIO DDW code.
>=20
> This adds pnv_pci_ioda2_tvt_invalidate() to invalidate TVT as it is

I'm assuming that's what's now called pnv_pci_ioda2_invalidate_entire()?

> a good thing to do. It does not have immediate effect now as the table
> is never recreated after reboot but it will in the following patches.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
> Changes:
> v11:
> * replaced some 1<<it_page_shift with IOMMU_PAGE_SIZE() macro
>=20
> v9:
> * initialize pe->table_group.tables[0] at the very end when
> tbl is fully initialized
> * moved pnv_pci_ioda2_tvt_invalidate() from earlier patch
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 47 +++++++++++++++++++++++++=
------
>  1 file changed, 38 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index 3d29fe3..fda01c1 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1968,6 +1968,43 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_p=
hb *phb,
>  	}
>  }
> =20
> +static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_gro=
up,
> +		int num, struct iommu_table *tbl)
> +{
> +	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
> +			table_group);
> +	struct pnv_phb *phb =3D pe->phb;
> +	int64_t rc;
> +	const __u64 start_addr =3D tbl->it_offset << tbl->it_page_shift;
> +	const __u64 win_size =3D tbl->it_size << tbl->it_page_shift;
> +
> +	pe_info(pe, "Setting up window %llx..%llx pg=3D%x\n",
> +			start_addr, start_addr + win_size - 1,
> +			IOMMU_PAGE_SIZE(tbl));
> +
> +	/*
> +	 * Map TCE table through TVT. The TVE index is the PE number
> +	 * shifted by 1 bit for 32-bits DMA space.
> +	 */
> +	rc =3D opal_pci_map_pe_dma_window(phb->opal_id,
> +			pe->pe_number,
> +			pe->pe_number << 1,
> +			1,
> +			__pa(tbl->it_base),
> +			tbl->it_size << 3,
> +			IOMMU_PAGE_SIZE(tbl));
> +	if (rc) {
> +		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
> +		return rc;
> +	}
> +
> +	pnv_pci_link_table_and_group(phb->hose->node, num,
> +			tbl, &pe->table_group);
> +	pnv_pci_ioda2_tce_invalidate_entire(pe);
> +
> +	return 0;
> +}
> +
>  static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
>  {
>  	uint16_t window_id =3D (pe->pe_number << 1 ) + 1;
> @@ -2123,21 +2160,13 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
_phb *phb,
>  	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
>  #endif
> =20
> -	/*
> -	 * Map TCE table through TVT. The TVE index is the PE number
> -	 * shifted by 1 bit for 32-bits DMA space.
> -	 */
> -	rc =3D opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
> -			pe->pe_number << 1, 1, __pa(tbl->it_base),
> -			tbl->it_size << 3, 1ULL << tbl->it_page_shift);
> +	rc =3D pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
>  	if (rc) {
>  		pe_err(pe, "Failed to configure 32-bit TCE table,"
>  		       " err %ld\n", rc);
>  		goto fail;
>  	}
> =20
> -	pnv_pci_ioda2_tce_invalidate_entire(pe);
> -
>  	/* OPAL variant of PHB3 invalidated TCEs */
>  	if (phb->ioda.tce_inval_reg)
>  		tbl->it_type |=3D (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tzZdJ4yHDV5r1Akt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVbOsfAAoJEGw4ysog2bOS24wP/0bbQbjK/AykOpe/e5EE3v9z
t0T5cMAhFRBB4LErOJ+NjCJ0adlhP5L59K3yfvQR4r00L9HYlk3Q1lbmkKh4gyL3
QU83rIhQMpn4WOHpeu48mwZJ7GEdsl8Af1vxDqbPQK0X5OzNFDNIwQdmcnwQXbRb
YL7aDBxMv21AHJxFw5f+sJ3JVLBqPwhGlsEUOwpD4Q07Z6MLn7LQdLsrg4UVqKlk
D8UIBGY2jPJg1e2KFY92+R65JusDDyY8ntc5nEqQpC74eb9UiZZmqoF6DYKz2uKI
fXP7EmOtiCT9/0t+aXFqjC7X9U+5kwir5f7AEDhKdbgFu+LABYi5uDFOZKXYjxoc
mvPjQ0iI0o1wOxOj6HObuCY2NnY6l2lA9f9oG7mZrcEK++qQneQnggBDz+3BmOID
HDCku2/CxudqIOlwAqs6BsZIxQvfcRfhyNj2MIXnfem/QHbp4OdH+FRSUU0rhm1g
MFq56PnEOlXo6hXbvpA+Jc95aglZSjBkeoB237PSMEX/vxkIdB5/+4n29dAgbbsP
x7WnwQHtJpOEKOy0dcGN59KGHp+J22eMjI/fPVdmMLucrkFBy2vkNgkXlsitylOq
lIzD7pN5FHuxhSlOqLC0B1THp1amN1tjQUN/vAxn/NHJMjE7YXRxAmMUtRoxbjT2
H9U3T23luGGJc4I8Tl2e
=9d74
-----END PGP SIGNATURE-----

--tzZdJ4yHDV5r1Akt--
