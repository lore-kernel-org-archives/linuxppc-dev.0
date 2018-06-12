Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414Yys0H9xzF3VX
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 12:40:37 +1000 (AEST)
Date: Tue, 12 Jun 2018 12:40:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH kernel 5/6] powerpc/powernv: Rework TCE level allocation
Message-ID: <20180612024032.GX2737@umbus.fritz.box>
References: <20180608054633.18659-1-aik@ozlabs.ru>
 <20180608054633.18659-6-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WVf18ZLo9bznw8Mz"
In-Reply-To: <20180608054633.18659-6-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WVf18ZLo9bznw8Mz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 03:46:32PM +1000, Alexey Kardashevskiy wrote:
> This moves actual pages allocation to a separate function which is going
> to be reused later in on-demand TCE allocation.
>=20
> While we are at it, remove unnecessary level size round up as the caller
> does this already.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 30 +++++++++++++++++----=
------
>  1 file changed, 19 insertions(+), 11 deletions(-)
>=20
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/powerpc=
/platforms/powernv/pci-ioda-tce.c
> index f14b282..36c2eb0 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> @@ -31,6 +31,23 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>  	tbl->it_type =3D TCE_PCI;
>  }
> =20
> +static __be64 *pnv_alloc_tce_level(int nid, unsigned int shift)
> +{
> +	struct page *tce_mem =3D NULL;
> +	__be64 *addr;
> +
> +	tce_mem =3D alloc_pages_node(nid, GFP_KERNEL, shift - PAGE_SHIFT);
> +	if (!tce_mem) {
> +		pr_err("Failed to allocate a TCE memory, level shift=3D%d\n",
> +				shift);
> +		return NULL;
> +	}
> +	addr =3D page_address(tce_mem);
> +	memset(addr, 0, 1UL << shift);
> +
> +	return addr;
> +}
> +
>  static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx)
>  {
>  	__be64 *tmp =3D user ? tbl->it_userspace : (__be64 *) tbl->it_base;
> @@ -165,21 +182,12 @@ static __be64 *pnv_pci_ioda2_table_do_alloc_pages(i=
nt nid, unsigned int shift,
>  		unsigned int levels, unsigned long limit,
>  		unsigned long *current_offset, unsigned long *total_allocated)
>  {
> -	struct page *tce_mem =3D NULL;
>  	__be64 *addr, *tmp;
> -	unsigned int order =3D max_t(unsigned int, shift, PAGE_SHIFT) -
> -			PAGE_SHIFT;
> -	unsigned long allocated =3D 1UL << (order + PAGE_SHIFT);
> +	unsigned long allocated =3D 1UL << shift;
>  	unsigned int entries =3D 1UL << (shift - 3);
>  	long i;
> =20
> -	tce_mem =3D alloc_pages_node(nid, GFP_KERNEL, order);
> -	if (!tce_mem) {
> -		pr_err("Failed to allocate a TCE memory, order=3D%d\n", order);
> -		return NULL;
> -	}
> -	addr =3D page_address(tce_mem);
> -	memset(addr, 0, allocated);
> +	addr =3D pnv_alloc_tce_level(nid, shift);
>  	*total_allocated +=3D allocated;
> =20
>  	--levels;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WVf18ZLo9bznw8Mz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsfMqAACgkQbDjKyiDZ
s5J5YBAArTBmdPpMI9M7iy4Fx3w6XAcZLuY4ANFjO5tJTCnw+rA/kAvCMbrmFNY/
scLedYn77VH8yoM3jSRLOXLn+SusgyLL9q/ppewrx0/tbJfObWL/9PQ+5/YkvtUP
v5VGmtpuPfT2W/2ewWnRy5DWoZxcWJrmUw7UeY5c/HdgivTA9T+CxqVE7qNubRui
BMBlnnZETPzkarB/Zk1SVIyPnyC3GhRhwQtkCwmr2PJ1eI4MTlsybPSnODQebC1p
cZAEm7HC9PBm6dbbj+XwNoMPIbwMnfD5xqij4mKuwFC8VXi0sMX7oJihIL0NC5ds
MN3FQQeMBWYY4c6NpJFOrDG0yKwU5VPfEwPeuyZeY2y1RB3pPS2d0oKrP+ZdPMIr
kKjYyocJKjB4edgNQJeoCn4BzJwucn2en0jT1mjdbywoyGmqAf6AmmPGuHI1sNo7
r5bYMmdxEGDzd8ty08+iyynNxAxlV1MuRQeSnRxW4KDmoazLceooDzm3QrY7H189
HkqdKDQwTr28m7NyU+wkiYFpGVhH0AFrjvI/yoVPDP5J5sb1utpkKgrdV33HZAKs
6SKA6hqvTqZBSlMyENDA8if6c2KQeJ8Vi5Qzlrl7oo58IhsVoBJCOCU/Q9joONG3
lHwIOyhWBViYjoa7eD8w1QwHMqF60/FZyAQQTg7S2792mQw2PAs=
=2Ztk
-----END PGP SIGNATURE-----

--WVf18ZLo9bznw8Mz--
