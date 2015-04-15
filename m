Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D85A91A0BB5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2015 18:32:39 +1000 (AEST)
Date: Wed, 15 Apr 2015 17:10:31 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v8 07/31] vfio: powerpc/spapr: Moving
 pinning/unpinning to helpers
Message-ID: <20150415071031.GI25040@voom.redhat.com>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
 <1428647473-11738-8-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VaKJWhUROU/xPxjb"
In-Reply-To: <1428647473-11738-8-git-send-email-aik@ozlabs.ru>
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


--VaKJWhUROU/xPxjb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 10, 2015 at 04:30:49PM +1000, Alexey Kardashevskiy wrote:
> This is a pretty mechanical patch to make next patches simpler.
>=20
> New tce_iommu_unuse_page() helper does put_page() now but it might skip
> that after the memory registering patch applied.
>=20
> As we are here, this removes unnecessary checks for a value returned
> by pfn_to_page() as it cannot possibly return NULL.
>=20
> This moves tce_iommu_disable() later to let tce_iommu_clear() know if
> the container has been enabled because if it has not been, then
> put_page() must not be called on TCEs from the TCE table. This situation
> is not yet possible but it will after KVM acceleration patchset is
> applied.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v6:
> * tce_get_hva() returns hva via a pointer
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 68 +++++++++++++++++++++++++++----=
------
>  1 file changed, 50 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index c137bb3..ec5ee83 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -196,7 +196,6 @@ static void tce_iommu_release(void *iommu_data)
>  	struct iommu_table *tbl =3D container->tbl;
> =20
>  	WARN_ON(tbl && !tbl->it_group);
> -	tce_iommu_disable(container);
> =20
>  	if (tbl) {
>  		tce_iommu_clear(container, tbl,	tbl->it_offset, tbl->it_size);
> @@ -204,63 +203,96 @@ static void tce_iommu_release(void *iommu_data)
>  		if (tbl->it_group)
>  			tce_iommu_detach_group(iommu_data, tbl->it_group);
>  	}
> +
> +	tce_iommu_disable(container);
> +
>  	mutex_destroy(&container->lock);
> =20
>  	kfree(container);
>  }
> =20
> +static void tce_iommu_unuse_page(struct tce_container *container,
> +		unsigned long oldtce)
> +{
> +	struct page *page;
> +
> +	if (!(oldtce & (TCE_PCI_READ | TCE_PCI_WRITE)))
> +		return;
> +
> +	/*
> +	 * VFIO cannot map/unmap when a container is not enabled so
> +	 * we would not need this check but KVM could map/unmap and if
> +	 * this happened, we must not put pages as KVM does not get them as
> +	 * it expects memory pre-registation to do this part.
> +	 */
> +	if (!container->enabled)
> +		return;

This worries me a bit.  How can whether the contained is enabled now
safely tell you whether get_page() at some earlier point in time?

> +
> +	page =3D pfn_to_page(__pa(oldtce) >> PAGE_SHIFT);
> +
> +	if (oldtce & TCE_PCI_WRITE)
> +		SetPageDirty(page);
> +
> +	put_page(page);
> +}
> +
>  static int tce_iommu_clear(struct tce_container *container,
>  		struct iommu_table *tbl,
>  		unsigned long entry, unsigned long pages)
>  {
>  	unsigned long oldtce;
> -	struct page *page;
> =20
>  	for ( ; pages; --pages, ++entry) {
>  		oldtce =3D iommu_clear_tce(tbl, entry);
>  		if (!oldtce)
>  			continue;
> =20
> -		page =3D pfn_to_page(oldtce >> PAGE_SHIFT);
> -		WARN_ON(!page);
> -		if (page) {
> -			if (oldtce & TCE_PCI_WRITE)
> -				SetPageDirty(page);
> -			put_page(page);
> -		}
> +		tce_iommu_unuse_page(container, (unsigned long) __va(oldtce));
>  	}
> =20
>  	return 0;
>  }
> =20
> +static int tce_get_hva(unsigned long tce, unsigned long *hva)
> +{
> +	struct page *page =3D NULL;
> +	enum dma_data_direction direction =3D iommu_tce_direction(tce);
> +
> +	if (get_user_pages_fast(tce & PAGE_MASK, 1,
> +			direction !=3D DMA_TO_DEVICE, &page) !=3D 1)
> +		return -EFAULT;
> +
> +	*hva =3D (unsigned long) page_address(page);
> +
> +	return 0;
> +}

I'd prefer to see this called tce_iommu_use_page() for symmetry.

> +
>  static long tce_iommu_build(struct tce_container *container,
>  		struct iommu_table *tbl,
>  		unsigned long entry, unsigned long tce, unsigned long pages)
>  {
>  	long i, ret =3D 0;
> -	struct page *page =3D NULL;
> +	struct page *page;
>  	unsigned long hva;
>  	enum dma_data_direction direction =3D iommu_tce_direction(tce);
> =20
>  	for (i =3D 0; i < pages; ++i) {
> -		ret =3D get_user_pages_fast(tce & PAGE_MASK, 1,
> -				direction !=3D DMA_TO_DEVICE, &page);
> -		if (unlikely(ret !=3D 1)) {
> -			ret =3D -EFAULT;
> +		ret =3D tce_get_hva(tce, &hva);
> +		if (ret)
>  			break;
> -		}
> =20
> +		page =3D pfn_to_page(__pa(hva) >> PAGE_SHIFT);
>  		if (!tce_page_is_contained(page, tbl->it_page_shift)) {
>  			ret =3D -EPERM;
>  			break;
>  		}
> =20
> -		hva =3D (unsigned long) page_address(page) +
> -			(tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK);
> +		/* Preserve offset within IOMMU page */
> +		hva |=3D tce & IOMMU_PAGE_MASK(tbl) & ~PAGE_MASK;
> =20
>  		ret =3D iommu_tce_build(tbl, entry + i, hva, direction);
>  		if (ret) {
> -			put_page(page);
> +			tce_iommu_unuse_page(container, hva);
>  			pr_err("iommu_tce: %s failed ioba=3D%lx, tce=3D%lx, ret=3D%ld\n",
>  					__func__, entry << tbl->it_page_shift,
>  					tce, ret);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VaKJWhUROU/xPxjb
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVLg7nAAoJEGw4ysog2bOSH70QALbV7v6bUAomwCtQeEvWwYPp
7STEVdpS0Tpi6aBO5zBZ1SPHxRG44ND0g+liZL6V9vvdx3Xlcbxf7EfgCl63+Tky
+Y4WUnBwc0dDyd4aOg1n535bqOcKP+2BsBZADdKP6UD1NwhoS6SA6QOQym3bv2iT
+WrhYF8XhLFfCX/g5nc3Bq91FhHwTgiKTzzexRTbH75cOeqkPPhYo+QPqYc6zrMD
yD2E1oiJ/V1PYMupCFgmnSpUAhuDvdOOznsNBvzPj9JMUgQhb+fSv5lNjggo/43/
nkp18vwMTDZM29Ap8PKV0TDaRyr7+LS/qzzcutdy/RqpBOv4//K+PQB+6/5jB5O0
9TCqPTEuL9+/8e0OerrlntISL3TivpN6XSje4G67lzBkuvm8fUe4pkbyAm+jhPx+
XHM1t2o7VwapzNHfvojx0AieoTWarUFPsMe4GW8HdODFnahZQhcYY7axGQSD6dum
41rKrhFOOSgnHFX+h927vz1nAz3VnBV3oUSmal6tX4NsXQKHvMnwLGg4wqHJuSrR
rs5toJt/vcH49FiSGbFe/U0ArbIc+hJRk9gY7TzfP2YuuBItv6al8LKxLvO6aU8y
0hEunBrtxkMCktthnhEus5qbx8BElobhCzXsYDTxHMy2LKUbFeD+jVA8meo6LkFh
NEKLbQsxiL0IPElcCfM9
=/F8T
-----END PGP SIGNATURE-----

--VaKJWhUROU/xPxjb--
