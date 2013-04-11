Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 30F3F2C00D6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 13:42:05 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dwg@au1.ibm.com>;
 Thu, 11 Apr 2013 13:35:07 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E9CFA2CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 13:41:55 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3B3fnvB11010400
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 13:41:50 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3B3frZR030863
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 13:41:54 +1000
Date: Thu, 11 Apr 2013 13:30:10 +1000
From: David Gibson <dwg@au1.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 13/25] powerpc: Update tlbie/tlbiel as per ISA doc
Message-ID: <20130411033010.GV8165@truffula.fritz.box>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aXNiKu4lnbRqA5kZ"
In-Reply-To: <1365055083-31956-14-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--aXNiKu4lnbRqA5kZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2013 at 11:27:51AM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>=20
> This make sure we handle multiple page size segment correctly.

This needs a much more detailed message.  In what way was the existing
code not matching the ISA documentation?  What consequences did that
have?

>=20
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/hash_native_64.c |   30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_nati=
ve_64.c
> index b461b2d..ac84fa6 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -61,7 +61,10 @@ static inline void __tlbie(unsigned long vpn, int psiz=
e, int apsize, int ssize)
> =20
>  	switch (psize) {
>  	case MMU_PAGE_4K:
> +		/* clear out bits after (52) [0....52.....63] */
> +		va &=3D ~((1ul << (64 - 52)) - 1);
>  		va |=3D ssize << 8;
> +		va |=3D mmu_psize_defs[apsize].sllp << 6;

sllp is the per-segment encoding, so it sure must be looked up via
psize, not apsize.

>  		asm volatile(ASM_FTR_IFCLR("tlbie %0,0", PPC_TLBIE(%1,%0), %2)
>  			     : : "r" (va), "r"(0), "i" (CPU_FTR_ARCH_206)
>  			     : "memory");
> @@ -69,9 +72,19 @@ static inline void __tlbie(unsigned long vpn, int psiz=
e, int apsize, int ssize)
>  	default:
>  		/* We need 14 to 14 + i bits of va */
>  		penc =3D mmu_psize_defs[psize].penc[apsize];
> -		va &=3D ~((1ul << mmu_psize_defs[psize].shift) - 1);
> +		va &=3D ~((1ul << mmu_psize_defs[apsize].shift) - 1);
>  		va |=3D penc << 12;
>  		va |=3D ssize << 8;
> +		/* Add AVAL part */
> +		if (psize !=3D apsize) {
> +			/*
> +			 * MPSS, 64K base page size and 16MB parge page size
> +			 * We don't need all the bits, but this seems to work.
> +			 * vpn cover upto 65 bits of va. (0...65) and we need
> +			 * 58..64 bits of va.

"seems to work" is not a comment I like to see in core MMU code...

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--aXNiKu4lnbRqA5kZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlFmLkIACgkQaILKxv3ab8YDngCeJ28mHMgcTuCl6r5FeDxGtimY
D0EAoII+tyctVaGRSIr5TRU+g6yl7Ya3
=LjXC
-----END PGP SIGNATURE-----

--aXNiKu4lnbRqA5kZ--
