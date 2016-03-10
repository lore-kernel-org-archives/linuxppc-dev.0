Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2C7B1A0060
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Mar 2016 16:44:09 +1100 (AEDT)
Date: Thu, 10 Mar 2016 16:35:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, Alistair Popple <alistair@popple.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Russell Currey <ruscur@russell.cc>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH kernel 01/10] vfio/spapr: Relax the IOMMU compatibility
 check
Message-ID: <20160310053528.GX22546@voom.fritz.box>
References: <1457504946-40649-1-git-send-email-aik@ozlabs.ru>
 <1457504946-40649-2-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="MikxO53xlyBvwArL"
In-Reply-To: <1457504946-40649-2-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--MikxO53xlyBvwArL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 05:28:57PM +1100, Alexey Kardashevskiy wrote:
> We are going to have multiple different types of PHB on the same system
> with POWER8 + NVLink and PHBs will have different IOMMU ops. However
> we only really care about one callback - create_table - so we can
> relax the compatibility check here.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index 0582b72..3054e3f 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -1188,7 +1188,8 @@ static int tce_iommu_attach_group(void *iommu_data,
>  			goto unlock_exit;
>  		}
>  		table_group_tmp =3D iommu_group_get_iommudata(tcegrp->grp);
> -		if (table_group_tmp->ops !=3D table_group->ops) {
> +		if (table_group_tmp->ops->create_table !=3D
> +				table_group->ops->create_table) {
>  			pr_warn("tce_vfio: Group %d is incompatible with group %d\n",
>  					iommu_group_id(iommu_group),
>  					iommu_group_id(tcegrp->grp));

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--MikxO53xlyBvwArL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJW4QegAAoJEGw4ysog2bOSOA0QAIvmDVke1TfUDMB3le9m3iob
YqiwuIuTqXZ8SzGrYcRPuEFIoXkWE6y0hQPxFpsivHBweIyA5lcuLelbo9ssSWas
xPKpycltpFDBa77/TXp8RDY7/a720cjoyF/SkxfrQMxeZg5oRRVpd6oqci7757N6
CkdvIojmVrsWRstlP9HaOtQC2haylfhRd9Wg+uEwrUqQ20G1nvmwTJxu4IM4mvqY
hp4ussXgvn1Wdr5adgOYiAoPDlwKrE9Kma+KKAmpxi7O4lShahvr1s+vcK6gC10O
SzcpyjiHtP35AbdobKUFpKiVOtgYfEyD39jP8pi1TNWI63KK+tOpqOWMfXDknKXd
vjIiwkKwCd7q/V64Ybm0vsZYeraRExi2iV+gb+bCJmRXjub5fuKqSYtyqAcRSTX2
kiwXYssORFJNM6lLxN8k4XeVVre/bYR9g5A8AftQa905Jj6gLMAqu6zQhUFmZPOq
POR0nzeUwshPESPN9Qz7c0N5WeCX3L6/kDdrRmr0EWEZOthieksfgJyw/MEevOOA
lZtH7tlhnf2npsP991rPkQ1tSb2I5JSlR3rjLDV+Tf0At8v83uFCdQxaLBSEfEPu
xMjs+H9p9A1y1ZiBaFGXCXJ0eDcMRf+iET2uhz7ckkNHK8TmIyY2nVkCqsUAPgSR
7U93i1kuRHnjbYGdJzxm
=SRAy
-----END PGP SIGNATURE-----

--MikxO53xlyBvwArL--
