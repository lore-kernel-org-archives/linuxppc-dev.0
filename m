Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id D775C2C0088
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jul 2012 09:06:22 +1000 (EST)
Date: Tue, 10 Jul 2012 09:06:05 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V3 03/11] arch/powerpc: Convert virtual address to vpn
Message-Id: <20120710090605.03b5887c0dabdf61eb70b68a@canb.auug.org.au>
In-Reply-To: <1341839621-28332-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1341839621-28332-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1341839621-28332-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Tue__10_Jul_2012_09_06_05_+1000_AY7hy+._LL75Pbhe"
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Tue__10_Jul_2012_09_06_05_+1000_AY7hy+._LL75Pbhe
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Aneesh,

On Mon,  9 Jul 2012 18:43:33 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.v=
net.ibm.com> wrote:
>
> diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_nati=
ve_64.c
> index 660b8bb..308e29d 100644
> --- a/arch/powerpc/mm/hash_native_64.c
> +++ b/arch/powerpc/mm/hash_native_64.c
> @@ -39,22 +39,33 @@
> =20
>  DEFINE_RAW_SPINLOCK(native_tlbie_lock);
> =20
> -static inline void __tlbie(unsigned long va, int psize, int ssize)
> +static inline void __tlbie(unsigned long vpn, int psize, int ssize)
>  {
> +	unsigned long va;
>  	unsigned int penc;
> =20
> +	/*
> +	 * We need 14 to 65 bits of va for a tlibe of 4K page
> +	 * With vpn we ignore the lower VPN_SHIFT bits already.
> +	 * And top two bits are already ignored because we can
> +	 * only accomadate 76 bits in a 64 bit vpn with a VPN_SHIFT
> +	 * of 12.
> +	 */
> +	BUG_ON((77 - 65) > VPN_SHIFT);

BUILD_BUG_ON() ?

> -static inline void __tlbiel(unsigned long va, int psize, int ssize)
> +static inline void __tlbiel(unsigned long vpn, int psize, int ssize)
>  {
> +	unsigned long va;
>  	unsigned int penc;
> =20
> +	BUG_ON((77 - 65) > VPN_SHIFT);

BUILD_BUG_ON() ?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__10_Jul_2012_09_06_05_+1000_AY7hy+._LL75Pbhe
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJP+2PdAAoJEECxmPOUX5FEhecP/RDOE46+LlBZV4ric6QCX4DJ
cPde18w6UYjLpWML2KwQh4q4sigoIENJR0lMv0rF7aqOcfFEj8O6UowuSdlODnAO
BiuJX/ELB3m2SAREIkYGVcWymZbcVeRU3iN4YvSjiiAVd0nrpXbW3aZehqE3x6O1
qbKT6od+s8mom7TrDKM+9Rg5WdhsniygQVJ+DJlGurb9nUJ3nPF5CMmm5l/+VcgH
hhqsYe5EnyAjDER4ul+4uw7fnRIwO2fkgjxVBM9pzrEZrxkI5KoCC6Q5qGYmixNg
nZz8xoqPz+NWvhRbNy9hMzF8Lci3ECmPfx7h28d2hMPnUliYEp45yVbe06DcbfKY
BCfz8fES8UzhYdmhF3QkhrnYErEuz3gCf39JpW4W8HlG41T51HXjjWxNBGG404k7
dU+ycbC/pR/hwRAnJxbw0VSeMdshsLm9vdt/gQTTnq4hMTlTvFctwwWd19mKPQZL
fRNp1xjJikFpqCfCJLVnajWsVyQl/aV9RQahYc+SclgEg5kLaTbFIUM9Aq4p+ggn
55N5/BM3FC9Ujp4kI1m0EZekB132JPBLiMljDxalwO2H1ZzUBfJkaZuJA6ohHwUB
vdsbDPyxiV/sbhhCZUtZDRCTU9D9tlS1FP7VMNlHVLtXBISN6wCD3HLOUZzEInfd
Wjqt+IBUIywG8Bqq5/m9
=wD2J
-----END PGP SIGNATURE-----

--Signature=_Tue__10_Jul_2012_09_06_05_+1000_AY7hy+._LL75Pbhe--
