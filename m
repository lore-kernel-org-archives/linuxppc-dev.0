Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4122R24znWzF346
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 09:52:46 +1000 (AEST)
Date: Fri, 8 Jun 2018 09:52:20 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: linux-next: manual merge of the powerpc tree with the kbuild tree
Message-ID: <20180608095220.20b85912@canb.auug.org.au>
In-Reply-To: <20180531093216.5c91aa2b@canb.auug.org.au>
References: <20180531093216.5c91aa2b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/yJu_K3LFBM2YxfOxmOM6LA+"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/yJu_K3LFBM2YxfOxmOM6LA+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 31 May 2018 09:32:16 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the powerpc tree got a conflict in:
>=20
>   arch/powerpc/kernel/module_64.c
>=20
> between commit:
>=20
>   06aeb9e3f2bc ("powerpc/kbuild: move -mprofile-kernel check to Kconfig")
>=20
> from the kbuild tree and commit:
>=20
>   250122baed29 ("powerpc64/module: Tighten detection of mcount call sites=
 with -mprofile-kernel")
>=20
> from the powerpc tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc arch/powerpc/kernel/module_64.c
> index 55bccc315e1a,f7667e2ebfcb..000000000000
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@@ -462,9 -466,12 +466,12 @@@ static unsigned long stub_for_addr(cons
>   	return (unsigned long)&stubs[i];
>   }
>  =20
>  -#ifdef CC_USING_MPROFILE_KERNEL
>  +#ifdef CONFIG_MPROFILE_KERNEL
> - static bool is_early_mcount_callsite(u32 *instruction)
> + static bool is_mprofile_mcount_callsite(const char *name, u32 *instruct=
ion)
>   {
> + 	if (strcmp("_mcount", name))
> + 		return false;
> +=20
>   	/*
>   	 * Check if this is one of the -mprofile-kernel sequences.
>   	 */

This is now a conflict between the kbuild tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/yJu_K3LFBM2YxfOxmOM6LA+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAlsZxTQACgkQAVBC80lX
0GzdkQgAo7Py6BrGkGFA/KxklVAutZ/Izxa4Iv0l2mGK1SjNX1xU8+WIfjF+bmy2
kTdudvPJj5HbWxWisYKiChTSzQrXsH8abckx/s5vq9hvWPF1IbQ5WK2iaTehzfvw
um7Dvkm9sTeDmTPZzEZ3nhsFOeyYp2ukkBP2TUseZQ95/Nvr4d0pvF0ZWl/dMm6T
cQqmP2/ZYZaTk6N9XRvowaPdy5HuWy+nGr9Y8tuNukGmpfF6GciDvwR+RifSSZq0
pw6GfbgcvolFOUxezRhJsWzaXQyPMlnAgdzPSF5x/g15PvUwjZ8XNhvvwL8D9n4I
PxqALtRLOqWW34uTmDmmUeufcAGzEQ==
=ZRqp
-----END PGP SIGNATURE-----

--Sig_/yJu_K3LFBM2YxfOxmOM6LA+--
