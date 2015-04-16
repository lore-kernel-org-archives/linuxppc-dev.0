Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 331691A0CBD
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Apr 2015 16:50:02 +1000 (AEST)
Date: Thu, 16 Apr 2015 16:46:37 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 21/31] powerpc/iommu: Split iommu_free_table
 into 2 helpers
Message-ID: <20150416064637.GL3632@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-22-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pFej7zHSL6C5fFIz"
In-Reply-To: <1428647473-11738-22-git-send-email-aik@ozlabs.ru>
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


--pFej7zHSL6C5fFIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:31:03PM +1000, Alexey Kardashevskiy wrote:
> The iommu_free_table helper release memory it is using (the TCE table and
> @it_map) and release the iommu_table struct as well. We might not want
> the very last step as we store iommu_table in parent structures.

Yeah, as I commented on the earlier patch, freeing the surrounding
group from a function taking just the individual table is wrong.

>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/include/asm/iommu.h |  1 +
>  arch/powerpc/kernel/iommu.c      | 57 ++++++++++++++++++++++++----------=
------
>  2 files changed, 35 insertions(+), 23 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index bde7ee7..8ed4648 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -127,6 +127,7 @@ static inline void *get_iommu_table_base(struct devic=
e *dev)
> =20
>  extern struct iommu_table *iommu_table_alloc(int node);
>  /* Frees table for an individual device node */
> +extern void iommu_reset_table(struct iommu_table *tbl, const char *node_=
name);
>  extern void iommu_free_table(struct iommu_table *tbl, const char *node_n=
ame);
> =20
>  /* Initializes an iommu_table based in values set in the passed-in
> diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
> index 501e8ee..0bcd988 100644
> --- a/arch/powerpc/kernel/iommu.c
> +++ b/arch/powerpc/kernel/iommu.c
> @@ -721,24 +721,46 @@ struct iommu_table *iommu_table_alloc(int node)
>  	return &table_group->tables[0];
>  }
> =20
> +void iommu_reset_table(struct iommu_table *tbl, const char *node_name)
> +{
> +	if (!tbl)
> +		return;
> +
> +	if (tbl->it_map) {
> +		unsigned long bitmap_sz;
> +		unsigned int order;
> +
> +		/*
> +		 * In case we have reserved the first bit, we should not emit
> +		 * the warning below.
> +		 */
> +		if (tbl->it_offset =3D=3D 0)
> +			clear_bit(0, tbl->it_map);
> +
> +		/* verify that table contains no entries */
> +		if (!bitmap_empty(tbl->it_map, tbl->it_size))
> +			pr_warn("%s: Unexpected TCEs for %s\n", __func__,
> +					node_name);
> +
> +		/* calculate bitmap size in bytes */
> +		bitmap_sz =3D BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
> +
> +		/* free bitmap */
> +		order =3D get_order(bitmap_sz);
> +		free_pages((unsigned long) tbl->it_map, order);
> +	}
> +
> +	memset(tbl, 0, sizeof(*tbl));
> +}
> +
>  void iommu_free_table(struct iommu_table *tbl, const char *node_name)
>  {
> -	unsigned long bitmap_sz;
> -	unsigned int order;
>  	struct iommu_table_group *table_group =3D tbl->it_group;
> =20
> -	if (!tbl || !tbl->it_map) {
> -		printk(KERN_ERR "%s: expected TCE map for %s\n", __func__,
> -				node_name);
> +	if (!tbl)
>  		return;
> -	}
> =20
> -	/*
> -	 * In case we have reserved the first bit, we should not emit
> -	 * the warning below.
> -	 */
> -	if (tbl->it_offset =3D=3D 0)
> -		clear_bit(0, tbl->it_map);
> +	iommu_reset_table(tbl, node_name);
> =20
>  #ifdef CONFIG_IOMMU_API
>  	if (table_group->group) {
> @@ -747,17 +769,6 @@ void iommu_free_table(struct iommu_table *tbl, const=
 char *node_name)
>  	}
>  #endif
> =20
> -	/* verify that table contains no entries */
> -	if (!bitmap_empty(tbl->it_map, tbl->it_size))
> -		pr_warn("%s: Unexpected TCEs for %s\n", __func__, node_name);
> -
> -	/* calculate bitmap size in bytes */
> -	bitmap_sz =3D BITS_TO_LONGS(tbl->it_size) * sizeof(unsigned long);
> -
> -	/* free bitmap */
> -	order =3D get_order(bitmap_sz);
> -	free_pages((unsigned long) tbl->it_map, order);
> -
>  	/* free table */
>  	kfree(table_group);
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pFej7zHSL6C5fFIz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVL1rNAAoJEGw4ysog2bOSzbgP/iA+PktcLnw1LoCUoRxb/+G5
Vf7u4YVQ71DKDgV4OgePge1Z0/c4gr4TwO0AbZfdDh9oBbJU5yaFZY5sIVjGeCmg
rerFOaXv/KXD6yhl38QsQCskGwYpWLbavrd24bhbyrftdRAY16/++nSU0OPIVJZF
Wr13AzlPoMMiH1DVB0qJZTuzPzNzUNbv6QRbcHsMx5S3KL4HkA3hz927vP7vluve
BjrSj56qBQdkp9bOg/ixqlQjIKba8ZQQXxuP4WsrdfmZws2DKbVtE8/E6mZQLBbo
B+IWNK1rVlWet3TnjWlaP/BnP5FGPBszP0GVW/Oy4dLin5BWKVkVMFHxU5F4WxBk
0Dv2HcHtJRzKkdaZHIFb52wziHY2u8V2DmtsjY4xKV9EQiJKjjyjLjaXJOFbEh3v
wSZ5tb+1cUBzQktHadq58Y9mxfX0oBZpH4NcOItHe/zdqcqDaBAekfHNcz5cahO0
RK3qd7/9JiJUM949RKrsx8dO0uE0JcBbdoMr4NEZP7KVFk0uWJdmpuokRmT5OqAg
QZZDjh4GHJE79+R7vRxxWELYoNS+R8EQ5HEmcP95fkSJUnNhdB6ypBohftCDZ+K3
Qhw3pLuDeOwrC+7d6KWcI0ZvKD8uJ/c93zN6ljmtjoF2+Wcigsy69vwhFu1uDX/l
LBoTfkU146DMww9IDApa
=9TE4
-----END PGP SIGNATURE-----

--pFej7zHSL6C5fFIz--
