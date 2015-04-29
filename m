Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2F84B1A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:50:04 +1000 (AEST)
Date: Wed, 29 Apr 2015 14:45:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 21/32] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_set_window
Message-ID: <20150429044510.GR32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-22-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="CPn8Wy5ME997YUMW"
In-Reply-To: <1429964096-11524-22-git-send-email-aik@ozlabs.ru>
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


--CPn8Wy5ME997YUMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:45PM +1000, Alexey Kardashevskiy wrote:
> This is a part of moving DMA window programming to an iommu_ops
> callback. pnv_pci_ioda2_set_window() takes an iommu_table_group as
> a first parameter (not pnv_ioda_pe) as it is going to be used as
> a callback for VFIO DDW code.
>=20
> This adds pnv_pci_ioda2_tvt_invalidate() to invalidate TVT as it is
> a good thing to do.

What's the TVT and why is invalidating it a good thing?

Also, it looks like it didn't add it, just move it.

> It does not have immediate effect now as the table
> is never recreated after reboot but it will in the following patches.
>=20
> This should cause no behavioural change.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

Really?  I don't remember this one.

> ---
> Changes:
> v9:
> * initialize pe->table_group.tables[0] at the very end when
> tbl is fully initialized
> * moved pnv_pci_ioda2_tvt_invalidate() from earlier patch
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 67 +++++++++++++++++++++++--=
------
>  1 file changed, 51 insertions(+), 16 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index b9b3773..59baa15 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1960,6 +1960,52 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_p=
hb *phb,
>  		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
>  }
> =20
> +static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_gro=
up,
> +		struct iommu_table *tbl)
> +{
> +	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
> +			table_group);
> +	struct pnv_phb *phb =3D pe->phb;
> +	int64_t rc;
> +	const __u64 start_addr =3D tbl->it_offset << tbl->it_page_shift;
> +	const __u64 win_size =3D tbl->it_size << tbl->it_page_shift;
> +
> +	pe_info(pe, "Setting up window at %llx..%llx "
> +			"pgsize=3D0x%x tablesize=3D0x%lx\n",
> +			start_addr, start_addr + win_size - 1,
> +			1UL << tbl->it_page_shift, tbl->it_size << 3);
> +
> +	tbl->it_table_group =3D &pe->table_group;
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
> +			1ULL << tbl->it_page_shift);
> +	if (rc) {
> +		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
> +		goto fail;
> +	}
> +
> +	pnv_pci_ioda2_tvt_invalidate(pe);
> +
> +	/* Store fully initialized *tbl (may be external) in PE */
> +	pe->table_group.tables[0] =3D *tbl;

Hrm, a non-atomic copy of a whole structure into the array.  Is that
really what you want?

> +	return 0;
> +fail:
> +	if (pe->tce32_seg >=3D 0)
> +		pe->tce32_seg =3D -1;
> +
> +	return rc;
> +}
> +
>  static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
>  {
>  	uint16_t window_id =3D (pe->pe_number << 1 ) + 1;
> @@ -2068,21 +2114,16 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv=
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
> +	rc =3D pnv_pci_ioda2_set_window(&pe->table_group, tbl);
>  	if (rc) {
>  		pe_err(pe, "Failed to configure 32-bit TCE table,"
>  		       " err %ld\n", rc);
> -		goto fail;
> +		pnv_pci_free_table(tbl);
> +		if (pe->tce32_seg >=3D 0)
> +			pe->tce32_seg =3D -1;
> +		return;
>  	}
> =20
> -	pnv_pci_ioda2_tvt_invalidate(pe);
> -
>  	/* OPAL variant of PHB3 invalidated TCEs */
>  	if (pe->tce_inval_reg)
>  		tbl->it_type |=3D (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
> @@ -2103,12 +2144,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_=
phb *phb,
>  	/* Also create a bypass window */
>  	if (!pnv_iommu_bypass_disabled)
>  		pnv_pci_ioda2_setup_bypass_pe(phb, pe);
> -
> -	return;
> -fail:
> -	if (pe->tce32_seg >=3D 0)
> -		pe->tce32_seg =3D -1;
> -	pnv_pci_free_table(tbl);
>  }
> =20
>  static void pnv_ioda_setup_dma(struct pnv_phb *phb)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--CPn8Wy5ME997YUMW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQGHWAAoJEGw4ysog2bOSNBgQANXKm5cBH3gt+wrd8GTyoJGd
395TiAJRXqOvXKxj7oOZW/wUGPCrIRsMPwrH28h1LGAA1Cax7KaRafMcK220FeXF
0cLJfjW89hcUCZKMdQKDuJv0B4EXhCf6RYEiFpcveexnz2F3BovPqgTq99FcVYUh
1fEaZNy+kaJpq58krDQqohrs3W88Wzbc4YkLOnr2oD934WQr1kbC+CROQ1UQWduH
O7+Wk4p0SI+opJJ2fVuAWdZeQl3IrL5LTnYPNFBMOo+5VtWxvvGPT4HC/JjW6BfM
klJIy6GPWEp0uqqfkLjjGzyfD5qyLXVBmt0iIYeyNS095Y+XHAYP+1LNnxOO2sbk
oPEb072zVIe3bXizNIFzBX4Rj5H/Sjrzz+HNvJnkqne154o+5s3fL9tC0ncXjD/G
eOaWIcB2MJdupH+BPY3etRsmMBxSLXNkIkl33jU/86fED0u+irSogtzhkZK/k9x0
6Ckd2CHEol1G2xFsiyd3R6FROVJbBMz3QCljkl3zucvMqXr7OBtCYn0fazeZp0kV
hP2gx4dfsKkNMjQVeT610RFbD4H9dpF0XzKZrrUL4Swm9ycXVRMSreniFj+q2rm2
U1wMEBn50bgtYvebICeNmayelAnYqbmmst6iUCjMXt9rHhxEE6IzY/hU+RYjOvO6
KpwRK9zjpmotbdgSl4Op
=cs/8
-----END PGP SIGNATURE-----

--CPn8Wy5ME997YUMW--
