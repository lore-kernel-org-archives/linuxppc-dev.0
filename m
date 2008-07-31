Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 5FF88DDF0E
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 15:21:39 +1000 (EST)
Date: Thu, 31 Jul 2008 15:21:25 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 5/8] Silence warning in arch/powerpc/mm/ppc_mmu_32.c
Message-Id: <20080731152125.2bfec5b7.sfr@canb.auug.org.au>
In-Reply-To: <6827a84e83495f49c991a33b2cef07614273fa0a.1217476198.git.tony@bakeyournoodle.com>
References: <cac86e24e42bd05087b43663b687f04df91326ba.1217476198.git.tony@bakeyournoodle.com>
	<6827a84e83495f49c991a33b2cef07614273fa0a.1217476198.git.tony@bakeyournoodle.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Thu__31_Jul_2008_15_21_25_+1000_LCLOTG9vlJ9j=WKt"
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Thu__31_Jul_2008_15_21_25_+1000_LCLOTG9vlJ9j=WKt
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On Thu, 31 Jul 2008 13:51:43 +1000 (EST) Tony Breeds <tony@bakeyournoodle.c=
om> wrote:
>
> total_memory is a 'phys_addr_t', cast to unsigned long to silence
> warning.
>=20
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> ---
>  arch/powerpc/mm/ppc_mmu_32.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/mm/ppc_mmu_32.c b/arch/powerpc/mm/ppc_mmu_32.c
> index c53145f..9c19655 100644
> --- a/arch/powerpc/mm/ppc_mmu_32.c
> +++ b/arch/powerpc/mm/ppc_mmu_32.c
> @@ -237,7 +237,7 @@ void __init MMU_init_hw(void)
>  	Hash_end =3D (struct hash_pte *) ((unsigned long)Hash + Hash_size);
> =20
>  	printk("Total memory =3D %ldMB; using %ldkB for hash table (at %p)\n",
> -	       total_memory >> 20, Hash_size >> 10, Hash);
> +	       (unsigned long)total_memory >> 20, Hash_size >> 10, Hash);

Will this ever be built with CONFIG_PHYS_64BIT?

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Thu__31_Jul_2008_15_21_25_+1000_LCLOTG9vlJ9j=WKt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiRS9UACgkQjjKRsyhoI8x5NQCglwIPKNAoSJPGx/mVmeRjCRme
rT0AnjbvxnsjT5oVt5iLcsKoggwl2mSe
=Xkgm
-----END PGP SIGNATURE-----

--Signature=_Thu__31_Jul_2008_15_21_25_+1000_LCLOTG9vlJ9j=WKt--
