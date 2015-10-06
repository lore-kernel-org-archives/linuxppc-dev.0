Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 93FBA1A0034
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 14:23:18 +1100 (AEDT)
Date: Tue, 6 Oct 2015 14:19:43 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Matthew Wilcox <willy@linux.intel.com>,
 Keith Busch <keith.busch@intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] powerpc/iommu: expose IOMMU page shift
Message-ID: <20151006031943.GC3861@voom.fritz.box>
References: <20151002171606.GA41011@linux.vnet.ibm.com>
 <20151002171800.GB41011@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="yLVHuoLXiP9kZBkt"
In-Reply-To: <20151002171800.GB41011@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2015 at 10:18:00AM -0700, Nishanth Aravamudan wrote:
> We will leverage this macro in the NVMe driver, which needs to know the
> configured IOMMU page shift to properly configure its device's page
> size.
>=20
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
>=20
> ---
> Given this is available, it seems reasonable to expose -- and it doesn't
> really make sense to make the driver do a log2 call on the existing
> IOMMU_PAGE_SIZE() value.
>=20
> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/=
iommu.h
> index ca18cff..6fdf857 100644
> --- a/arch/powerpc/include/asm/iommu.h
> +++ b/arch/powerpc/include/asm/iommu.h
> @@ -36,6 +36,7 @@
>  #define IOMMU_PAGE_MASK_4K       (~((1 << IOMMU_PAGE_SHIFT_4K) - 1))
>  #define IOMMU_PAGE_ALIGN_4K(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE_4K)
> =20
> +#define IOMMU_PAGE_SHIFT(tblptr) (tblptr)->it_page_shift
>  #define IOMMU_PAGE_SIZE(tblptr) (ASM_CONST(1) << (tblptr)->it_page_shift)

Seems like it would be a touch safer to alter IOMMU_PAGE_SIZE so it
uses the new IOMMU_PAGE_SHIFT macro.

>  #define IOMMU_PAGE_MASK(tblptr) (~((1 << (tblptr)->it_page_shift) - 1))
>  #define IOMMU_PAGE_ALIGN(addr, tblptr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE(t=
blptr))
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWEz3OAAoJEGw4ysog2bOSMkEP/3z5B81aJ2P4h6CGYgkFBW3C
x5laS6nhWXrrD7ErsKFI9EBGLrzEXN5HxDQUbJ9feo2yLoK1oDeAq2iHwhTO9gWa
CZzblQM8Qdu1IEyM3QNhqcF13x48MMzWqbFOTFVwFGBL5kjVaaQWvhEPlAxFK+PE
gzSuWNxCdVLeez4ZceTWJfGmyut23rN/Kmq9NqGPQ81u6BQFOlOw0hNynNznmnrN
X6NMrXAWpLw6ZydNeDZduVbZ5X1fb86HLj1AJmLRSDA9WMIIxJxb90Py+kVLPBei
CsRAkFRrndZaOPt/FlaPgf1692rwFjqhvsfNnwkkwPzBj8VfwbnnXAM3ZUopT+9F
Zpf7NnsdSUjk8txjODE7ib2gGLK3O+nMw8mZz/pXAWE8H1dQ9v2Yhi7YzrGagHjK
hysgaKYlM7eWiZZppN1FgAquWwCF/SJVho3cq0CUU1N0LX/o9s3a+w/rV/r9bSw1
lqM7in5kw/Xqk9Iff4giZ8tHx14inHBf9vryy0/PdxY72wi17cNl0BWxmphEgeai
OJhigCXoZhEIJQqk2X1w90oj0MDEen4tlhuH+A36JBkLOB+cBdtLUvw+pBkSxV0/
7pBl2KxNWSUI6uYO3mWMY4PgAqxG4z/Qh4I3cfFasuXjLPEf/NVVczkH7NzE5Jzo
7h+0qXiQvx7UivNoO5OH
=E/DB
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
