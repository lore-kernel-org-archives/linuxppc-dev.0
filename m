Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vs4136dNXzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Mar 2017 17:31:19 +1100 (AEDT)
Date: Mon, 27 Mar 2017 15:24:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel] powerpc/powernv: Check kzalloc() return in
 pnv_pci_table_alloc
Message-ID: <20170327042430.GT19078@umbus.fritz.box>
References: <20170327032803.18775-1-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B0+HW0pjZ+2jqF7e"
In-Reply-To: <20170327032803.18775-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--B0+HW0pjZ+2jqF7e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 27, 2017 at 02:28:03PM +1100, Alexey Kardashevskiy wrote:
> pnv_pci_table_alloc() ignores posible failure from kzalloc_node(),
> this adds a check. There are 2 callers of pnv_pci_table_alloc(),
> one already checks for tbl!=3DNULL, this adds BUG_ON() to the other path
> which only happens during boot time in IODA1 and not expected to fail.
>=20
> Fixes: 0eaf4defc7c4 ("powerpc/spapr: vfio: Switch from iommu_table to new=
 iommu_table_group")
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c | 1 +
>  arch/powerpc/platforms/powernv/pci.c      | 3 +++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/pla=
tforms/powernv/pci-ioda.c
> index e36738291c32..dcda3f6b7d36 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2128,6 +2128,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_p=
hb *phb,
> =20
>  found:
>  	tbl =3D pnv_pci_table_alloc(phb->hose->node);
> +	BUG_ON(!tbl);
>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
>  			pe->pe_number);
>  	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platform=
s/powernv/pci.c
> index eb835e977e33..9acdf6889c0d 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -766,6 +766,9 @@ struct iommu_table *pnv_pci_table_alloc(int nid)
>  	struct iommu_table *tbl;
> =20
>  	tbl =3D kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL, nid);
> +	if (!tbl)
> +		return NULL;
> +
>  	INIT_LIST_HEAD_RCU(&tbl->it_group_list);
> =20
>  	return tbl;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--B0+HW0pjZ+2jqF7e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY2JP8AAoJEGw4ysog2bOSfkkQAIY9KUcCK2yigXVZhRriV3X2
lGcL6RcpZl1flGJnsSrXsZTi+GBUbTe88hEjM8bZXAyBSwU7cPwMEOaIXNnDhEEX
Kot34uEmoSIl1coEAkV9fSP6WO3DmMYVKZIypEwmfHQuaVG3PatgvL1K1Xls15Eq
u0fG2gR82UevuA9TBfCDYUOQ9H+OzMRrxQv3PXVU5QkCvilPkbgE9QLA/eLXXmzo
4uzUu/INrEuuC60q+ioBZK9A4D9MjthaJJ5NJRTCiUAP3/8sqBKtkDMHL20wo3Wq
RDNrgPqn7IZhSxOy5dq3srjzm9+mJY1YDT5Uu+dlS9mviq5A73LspgLXNA5M3HYM
SIi+JY6iqIntT8WekmafNwuB6G2JqzqVp6/6PHDtkjkVIwCDtJ/Bv0kqWMthWbRu
W7iZxGxPALJaQcxDsuqicQDkOpU12IEm/zRFgwbKbrXGzTzdiPVxnZVw3pOQjEE2
10y+NYW7aSnAOeLHR1LURj4bT9hNabbwQ4RSF1qt01LbvcoAuPeW6QLhL20H1RMI
U2N8MuHe2y9eNYOi3fOLqSXzfnYeImFHUO+blB01cxZ48Mn2r8nU6TnT7/eAgo7j
tOtwYLQBltAnpMpSqRJAj7gJ8h3NwRuxvvNEnH4M52GK2+NtOgHhc8V06bEE2bbK
ih44VIfdr8s+L9lvHI+E
=RBCG
-----END PGP SIGNATURE-----

--B0+HW0pjZ+2jqF7e--
