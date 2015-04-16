Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14DDB1A0021
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 16:11:09 +1000 (AEST)
Date: Thu, 16 Apr 2015 16:07:03 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 14/31] vfio: powerpc/spapr:
 powerpc/powernv/ioda2: Rework IOMMU ownership control
Message-ID: <20150416060703.GE3632@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-15-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
In-Reply-To: <1428647473-11738-15-git-send-email-aik@ozlabs.ru>
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


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:56PM +1000, Alexey Kardashevskiy wrote:
> At the moment the iommu_table struct has a set_bypass() which enables/
> disables DMA bypass on IODA2 PHB. This is exposed to POWERPC IOMMU code
> which calls this callback when external IOMMU users such as VFIO are
> about to get over a PHB.
>=20
> The set_bypass() callback is not really an iommu_table function but
> IOMMU/PE function. This introduces a iommu_table_group_ops struct and
> adds a set_ownership() callback to it which is called when an external
> user takes control over the IOMMU.

Do you really need separate ops structures at both the single table
and table group level?  The different tables in a group will all
belong to the same basic iommu won't they?

> This renames set_bypass() to set_ownership() as it is not necessarily
> just enabling bypassing, it can be something else/more so let's give it
> more generic name. The bool parameter is inverted.
>=20
> The callback is implemented for IODA2 only. Other platforms (P5IOC2,
> IODA1) will use the old iommu_take_ownership/iommu_release_ownership API.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/iommu.h          | 14 +++++++++++++-
>  arch/powerpc/platforms/powernv/pci-ioda.c | 30 ++++++++++++++++++++++---=
-----
>  drivers/vfio/vfio_iommu_spapr_tce.c       | 25 +++++++++++++++++++++----
>  3 files changed, 56 insertions(+), 13 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index b9e50d3..d1f8c6c 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -92,7 +92,6 @@ struct iommu_table {
>  	unsigned long  it_page_shift;/* table iommu page size */
>  	struct iommu_table_group *it_group;
>  	struct iommu_table_ops *it_ops;
> -	void (*set_bypass)(struct iommu_table *tbl, bool enable);
>  };
> =20
>  /* Pure 2^n version of get_order */
> @@ -127,11 +126,24 @@ extern struct iommu_table *iommu_init_table(struct =
iommu_table * tbl,
> =20
>  #define IOMMU_TABLE_GROUP_MAX_TABLES	1
> =20
> +struct iommu_table_group;
> +
> +struct iommu_table_group_ops {
> +	/*
> +	 * Switches ownership from the kernel itself to an external
> +	 * user. While onwership is enabled, the kernel cannot use IOMMU
> +	 * for itself.
> +	 */
> +	void (*set_ownership)(struct iommu_table_group *table_group,
> +			bool enable);

The meaning of "enable" in a function called "set_ownership" is
entirely obscure.

> +};
> +
>  struct iommu_table_group {
>  #ifdef CONFIG_IOMMU_API
>  	struct iommu_group *group;
>  #endif
>  	struct iommu_table tables[IOMMU_TABLE_GROUP_MAX_TABLES];
> +	struct iommu_table_group_ops *ops;
>  };
> =20
>  #ifdef CONFIG_IOMMU_API
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index a964c50..9687731 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1255,10 +1255,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_p=
hb *phb,
>  		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
>  }
> =20
> -static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enabl=
e)
> +static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
>  {
> -	struct pnv_ioda_pe *pe =3D container_of(tbl->it_group, struct pnv_ioda_=
pe,
> -					      table_group);
>  	uint16_t window_id =3D (pe->pe_number << 1 ) + 1;
>  	int64_t rc;
> =20
> @@ -1286,7 +1284,8 @@ static void pnv_pci_ioda2_set_bypass(struct iommu_t=
able *tbl, bool enable)
>  		 * host side.
>  		 */
>  		if (pe->pdev)
> -			set_iommu_table_base(&pe->pdev->dev, tbl);
> +			set_iommu_table_base(&pe->pdev->dev,
> +					&pe->table_group.tables[0]);
>  		else
>  			pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
>  	}
> @@ -1302,13 +1301,27 @@ static void pnv_pci_ioda2_setup_bypass_pe(struct =
pnv_phb *phb,
>  	/* TVE #1 is selected by PCI address bit 59 */
>  	pe->tce_bypass_base =3D 1ull << 59;
> =20
> -	/* Install set_bypass callback for VFIO */
> -	pe->table_group.tables[0].set_bypass =3D pnv_pci_ioda2_set_bypass;
> -
>  	/* Enable bypass by default */
> -	pnv_pci_ioda2_set_bypass(&pe->table_group.tables[0], true);
> +	pnv_pci_ioda2_set_bypass(pe, true);
>  }
> =20
> +static void pnv_ioda2_set_ownership(struct iommu_table_group *table_grou=
p,
> +				     bool enable)
> +{
> +	struct pnv_ioda_pe *pe =3D container_of(table_group, struct pnv_ioda_pe,
> +						table_group);
> +	if (enable)
> +		iommu_take_ownership(table_group);
> +	else
> +		iommu_release_ownership(table_group);
> +
> +	pnv_pci_ioda2_set_bypass(pe, !enable);
> +}
> +
> +static struct iommu_table_group_ops pnv_pci_ioda2_ops =3D {
> +	.set_ownership =3D pnv_ioda2_set_ownership,
> +};
> +
>  static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>  				       struct pnv_ioda_pe *pe)
>  {
> @@ -1376,6 +1389,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_p=
hb *phb,
>  	}
>  	tbl->it_ops =3D &pnv_iommu_ops;
>  	iommu_init_table(tbl, phb->hose->node);
> +	pe->table_group.ops =3D &pnv_pci_ioda2_ops;
>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
>  			pe->pe_number);
> =20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 9f38351..d5d8c50 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -535,9 +535,22 @@ static int tce_iommu_attach_group(void *iommu_data,
>  		goto unlock_exit;
>  	}
> =20
> -	ret =3D iommu_take_ownership(table_group);
> -	if (!ret)
> -		container->grp =3D iommu_group;
> +	if (!table_group->ops || !table_group->ops->set_ownership) {
> +		ret =3D iommu_take_ownership(table_group);
> +	} else {
> +		/*
> +		 * Disable iommu bypass, otherwise the user can DMA to all of
> +		 * our physical memory via the bypass window instead of just
> +		 * the pages that has been explicitly mapped into the iommu
> +		 */
> +		table_group->ops->set_ownership(table_group, true);

And here to disable bypass you call it with enable=3Dtrue, so it doesn't
even have the same meaning as it used to.

Plus, you should fold the logic to call the callback if necessary into
iommu_take_ownership().

> +		ret =3D 0;
> +	}
> +
> +	if (ret)
> +		goto unlock_exit;
> +
> +	container->grp =3D iommu_group;
> =20
>  unlock_exit:
>  	mutex_unlock(&container->lock);
> @@ -572,7 +585,11 @@ static void tce_iommu_detach_group(void *iommu_data,
>  	table_group =3D iommu_group_get_iommudata(iommu_group);
>  	BUG_ON(!table_group);
> =20
> -	iommu_release_ownership(table_group);
> +	/* Kernel owns the device now, we can restore bypass */
> +	if (!table_group->ops || !table_group->ops->set_ownership)
> +		iommu_release_ownership(table_group);
> +	else
> +		table_group->ops->set_ownership(table_group, false);

Likewise fold this if into iommu_release_ownership().

>  unlock_exit:
>  	mutex_unlock(&container->lock);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL1GGAAoJEGw4ysog2bOS0moP/3qwK1/MhRMSG1AACp36Ekx9
1UAglE1HD0xYZ/VwfMRzaZnqTDXUS1oCTmb7GZ7OkXOn86W8M+r+LEBRrTgII4Qw
KwbyqLllNDUMWqm3TdVL/LtfgtOUn6cO4q02nLM6KEHI30Mw9iJwLDk9xt9oxFxu
5Fxw2G/IGQUuF3fV0R5NQmC1jFBrN0SeopjryFpoV5JLwwXooGQtPJ3xJH2D7JtF
xIYNy0TkD9nHv+a/lX6O56uM/rjneaVtVtjPianrCT1N8eroqvwTeR6fUe30RjUK
QYC8rTgYmhk7oNQ6TVX3DCbUGQr8326t781PJV8Tr3qNrawNkaEmQzPzAmDnsd6v
QuOZp5LjRlZkzy0KKAnmpFBn3pALWWGTZyTDCeZ4VJMf7CvmQXQRkQ7cvCcIhyzv
2O/w9we/8fU9imBfdqDbD0/rE0EVXOT5Ecl0F4Qxo1Igfz299hmbl97WyRvDY+hB
aeF6yJfLU1j6+VPRHuu/nIeJMly1CP7RyBrLrA0393TVqaq9QKSUW55Tk3YEx8OX
wXD14b/Ten+znSPQfSFqrLkgiGXFdlWOak2TF95nTeukbB1ts6eHHtzvOXbIhsKI
d9FxMF2W79ZLee2r4Y/dEerPrX6lg7DMQ1QaP2m7aZE6FYlTdZvZozR6tmNx0Nho
YOLxs1Mv3EXH3K35JAPZ
=mLxd
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
