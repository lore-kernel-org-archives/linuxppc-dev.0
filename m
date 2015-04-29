Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCB691A0CBE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 13:26:04 +1000 (AEST)
Date: Wed, 29 Apr 2015 13:08:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v9 14/32] powerpc/iommu: Fix IOMMU ownership
 control functions
Message-ID: <20150429030841.GK32589@voom.redhat.com>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-15-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OOq1TgGhe8eTwFBO"
In-Reply-To: <1429964096-11524-15-git-send-email-aik@ozlabs.ru>
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


--OOq1TgGhe8eTwFBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 25, 2015 at 10:14:38PM +1000, Alexey Kardashevskiy wrote:
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
> In order to use bitmap_empty(), the existing code clears bit#0 which
> is set even in an empty table if it is bus-mapped at 0 as
> iommu_init_table() reserves page#0 to prevent buggy drivers
> from crashing when allocated page is bus-mapped at zero
> (which is correct). This restores the bit in the case of failure
> to bring the it_map to the state it was in when we called
> iommu_take_ownership().

Ah! I finally understand what all this bit#0 stuff is about.  Thanks
for the explanation.

>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

With one small comment..


> ---
> Changes:
> v9:
> * iommu_table_take_ownership() did not return @ret (and ignored EBUSY),
> now it does return correct error.
> * updated commit log about setting bit#0 in the case of failure
>=20
> v5:
> * do not store bit#0 value, it has to be set for zero-based table
> anyway
> * removed test_and_clear_bit
> ---
>  arch/powerpc/kernel/iommu.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 2856d27..ea2c8ba 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -1045,32 +1045,51 @@ EXPORT_SYMBOL_GPL(iommu_tce_build);
> =20
>  int iommu_take_ownership(struct iommu_table *tbl)
>  {
> -	unsigned long sz =3D (tbl->it_size + 7) >> 3;
> +	unsigned long flags, i, sz =3D (tbl->it_size + 7) >> 3;
> +	int ret =3D 0;
> +
> +	spin_lock_irqsave(&tbl->large_pool.lock, flags);
> +	for (i =3D 0; i < tbl->nr_pools; i++)
> +		spin_lock(&tbl->pools[i].lock);

>  	if (tbl->it_offset =3D=3D 0)
>  		clear_bit(0, tbl->it_map);
> =20
>  	if (!bitmap_empty(tbl->it_map, tbl->it_size)) {
>  		pr_err("iommu_tce: it_map is not empty");
> -		return -EBUSY;
> +		ret =3D -EBUSY;
> +		/* Restore bit#0 set by iommu_init_table() */
> +		if (tbl->it_offset =3D=3D 0)
> +			set_bit(0, tbl->it_map);
> +	} else {
> +		memset(tbl->it_map, 0xff, sz);
>  	}
> =20
> -	memset(tbl->it_map, 0xff, sz);
> +	for (i =3D 0; i < tbl->nr_pools; i++)
> +		spin_unlock(&tbl->pools[i].lock);

I *think* it's safe in this case, but releasing locks not in the
reverse order you acquired them makes me a bit nervous.

> +	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
> =20
> -
> -	return 0;
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(iommu_take_ownership);
> =20
>  void iommu_release_ownership(struct iommu_table *tbl)
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
>  	/* Restore bit#0 set by iommu_init_table() */
>  	if (tbl->it_offset =3D=3D 0)
>  		set_bit(0, tbl->it_map);
> +
> +	for (i =3D 0; i < tbl->nr_pools; i++)
> +		spin_unlock(&tbl->pools[i].lock);
> +	spin_unlock_irqrestore(&tbl->large_pool.lock, flags);
>  }
>  EXPORT_SYMBOL_GPL(iommu_release_ownership);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--OOq1TgGhe8eTwFBO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVQEs5AAoJEGw4ysog2bOSOcsQANs146/xIBKlUnLpfTJxDzjh
nK/4uMRPdD7nyERyf0food0YCJBSrQjosasxBPRwNsS79i5BAIhp1z8rLEXzYaQS
c7Swn8jlU3Bvpwa3HdE2TdqKUGqxAxwK/jl1Tyj1CaC6Zkn5g7ZRUaFlq1FJIyLi
JaBGtQphE6P8GnO+BLAu5oJr4G84EVjbKNfKMfcJYngMo81UGCOid973P8dhcX8C
0r80eRnLyIDlYlObXvcN+SCckKS4w+kPVwGwm0lX00f35Q8E02xL9JZfEmwejaKY
Z28ouMia1jile5eYYf9LGpJ9QqEdEBtrr6oIhcBAy23BAEiKUcElfH5T7jEo4zJ4
SLrFDvrcIp5zWe+l/y3exyR5o3yUQN1ZwJPx+OKqcu9UgZnvS89nNxh1hBjFtYol
ABIvMjH4cg/UFymT9XSrheDei9wdT32VzCtzi8LOpSxB9eCdxYSOnm0htlf8BlWj
VchxnvtI0qzYlc6ldDGJb45lqKDkOyJ45w+P2w+sWyFJy2llT2CCI8FRxHjZeuW1
YAo79GLv4PnRjz7hE+MONYIT0/3QFB8AuBODpXEo9EXxn6/0x55sjkzusOH30nZG
r4cvuVyQ/j0DtY3CcD2AEgi22sn9CPwBEakR1Z/8OX4MV0hhy6/fEkGG25u4XzWe
lmU3UTtL6WgCH2rjOWBO
=95ol
-----END PGP SIGNATURE-----

--OOq1TgGhe8eTwFBO--
