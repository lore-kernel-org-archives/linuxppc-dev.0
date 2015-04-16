Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 23DF31A0058
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 16:11:09 +1000 (AEST)
Date: Thu, 16 Apr 2015 16:10:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 15/31] powerpc/iommu: Fix IOMMU ownership
 control functions
Message-ID: <20150416061049.GF3632@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-16-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="m1UC1K4AOz1Ywdkx"
In-Reply-To: <1428647473-11738-16-git-send-email-aik@ozlabs.ru>
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


--m1UC1K4AOz1Ywdkx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:57PM +1000, Alexey Kardashevskiy wrote:
> This adds missing locks in iommu_take_ownership()/
> iommu_release_ownership().
>=20
> This marks all pages busy in iommu_table::it_map in order to catch
> errors if there is an attempt to use this table while ownership over it
> is taken.
>=20
> This only clears TCE content if there is no page marked busy in it_map.
> Clearing must be done outside of the table locks as iommu_clear_tce()
> called from iommu_clear_tces_and_put_pages() does this.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v5:
> * do not store bit#0 value, it has to be set for zero-based table
> anyway
> * removed test_and_clear_bit
> ---
>  arch/powerpc/kernel/iommu.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 7d6089b..068fe4ff 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1052,17 +1052,28 @@ EXPORT_SYMBOL_GPL(iommu_tce_build);
> =20
>  static int iommu_table_take_ownership(struct iommu_table *tbl)
>  {
> -	unsigned long sz =3D (tbl->it_size + 7) >> 3;
> +	unsigned long flags, i, sz =3D (tbl->it_size + 7) >> 3;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&tbl->large_pool.lock, flags);
> +	for (i =3D 0; i < tbl->nr_pools; i++)
> +		spin_lock(&tbl->pools[i].lock);
> =20
>  	if (tbl->it_offset =3D=3D 0)
>  		clear_bit(0, tbl->it_map);
> =20
>  	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
>  		pr_err("iommu_tce: it_map is not empty");
> -		return -EBUSY;
> +		ret =3D -EBUSY;
> +		if (tbl->it_offset =3D=3D 0)
> +			set_bit(0, tbl->it_map);

This really needs a comment.  Why on earth are you changing the it_map
on a failure case?

> +	} else {
> +		memset(tbl->it_map, 0xff, sz);
>  	}
> =20
> -	memset(tbl->it_map, 0xff, sz);
> +	for (i =3D 0; i < tbl->nr_pools; i++)
> +		spin_unlock(&tbl->pools[i].lock);
> +	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
> =20
>  	return 0;
>  }
> @@ -1095,7 +1106,11 @@ EXPORT_SYMBOL_GPL(iommu_take_ownership);
> =20
>  static void iommu_table_release_ownership(struct iommu_table *tbl)
>  {
> -	unsigned long sz =3D (tbl->it_size + 7) >> 3;
> +	unsigned long flags, i, sz =3D (tbl->it_size + 7) >> 3;
> +
> +	spin_lock_irqsave(&tbl->large_pool.lock, flags);
> +	for (i =3D 0; i < tbl->nr_pools; i++)
> +		spin_lock(&tbl->pools[i].lock);
> =20
>  	memset(tbl->it_map, 0, sz);
> =20
> @@ -1103,6 +1118,9 @@ static void iommu_table_release_ownership(struct io=
mmu_table *tbl)
>  	if (tbl->it_offset =3D=3D 0)
>  		set_bit(0, tbl->it_map);
> =20
> +	for (i =3D 0; i < tbl->nr_pools; i++)
> +		spin_unlock(&tbl->pools[i].lock);
> +	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
>  }
> =20
>  extern void iommu_release_ownership(struct iommu_table_group *table_grou=
p)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--m1UC1K4AOz1Ywdkx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL1JpAAoJEGw4ysog2bOSqa4P/0b+69waGMjpJoyyBzDmQj4S
krhYlnE0a6ymqufwqFFtxCekvmdoCW0kXYE+l2I8Q94BE5Zl/FX2bqfda6Jg1rUU
7kO6zmj+7/6G7lxaRbxJdLi39Z1ZtCcm2aXQUcYbREyjfsUhCsMiwqRGtyWIsm6L
G41dQjODaQ9WyK5+flbFv6KMJ3GwhudGDoh8GOXOmCyaFdH6dHy2LWGIgBFEZa0O
fIJHth4HY9jFS/abQXehoOJjmEeIl8TPzqtdpYjuxCtiaSLExvPNw2UxFZDrE+5m
0WJPPMGIOaoYNGrMspeLAasyxQ2o8NimhZLL9Nk7B2iq7veFQN9h9DqyaOVVHmdb
M3cxfrQ636IGKyAHmc34JjGUkPEnIgs+wMxHhV7hDovyqZu4vP8pX/DOn8cRxqZw
WcYShElUGKalgi6R5kLL2ewT0itPDBdkfRWWOEHwjYbC6v17oa5nY6oUY14IwUfY
vBr2p5EnW/ysblfOaR+LARDk4ltSBADXS8Ay2+6VatbykifvbPqye/gn6+e9Kvki
Wf8/yU36kZINIBHMAbBDaAYFqr6w3OBt9Ce/CLL+W8wDFbLdmG9Jylhqr7aPymUf
dVhINlDMHl65hYxVovBM8UsMeP+vjMWq49523gh+Wr003O5qoeWLK4RRTv74ZIVi
yOBelN2yzqwB6Zu3WZee
=SsZl
-----END PGP SIGNATURE-----

--m1UC1K4AOz1Ywdkx--
