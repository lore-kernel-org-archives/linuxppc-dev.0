Return-Path: <michael@ellerman.id.au>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5D9BBDDF8A
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 16:43:42 +1000 (EST)
Subject: Re: [PATCH] powerpc: Add support for early tlbilx opcode
From: Michael Ellerman <michael@ellerman.id.au>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1239084821-10121-1-git-send-email-galak@kernel.crashing.org>
References: <1239084821-10121-1-git-send-email-galak@kernel.crashing.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-SLi9iTn9K+TJG/2NbuWy"
Date: Tue, 07 Apr 2009 16:43:41 +1000
Message-Id: <1239086621.6565.25.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-SLi9iTn9K+TJG/2NbuWy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-04-07 at 01:13 -0500, Kumar Gala wrote:
> During the ISA 2.06 development the opcode for tlbilx changed and some
> early implementations used to old opcode.  Add support for a MMU_FTR
> fixup to deal with this.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/mmu.h        |    6 ++++++
>  arch/powerpc/include/asm/ppc-opcode.h |   11 ++++++++++-
>  arch/powerpc/kernel/cputable.c        |    2 +-
>  arch/powerpc/mm/tlb_nohash_low.S      |   14 +++++++++++++-
>  4 files changed, 30 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mm=
u.h
> index cbf1543..86d2366 100644
> --- a/arch/powerpc/include/asm/mmu.h
> +++ b/arch/powerpc/include/asm/mmu.h
> @@ -52,6 +52,12 @@
>   */
>  #define MMU_FTR_NEED_DTLB_SW_LRU	ASM_CONST(0x00200000)
> =20
> +/* This indicates that the processor uses the wrong opcode for tlbilx
> + * instructions.  During the ISA 2.06 development the opcode for tlbilx
> + * changed and some early implementations used to old opcode
> + */
> +#define MMU_FTR_TLBILX_EARLY_OPCODE	ASM_CONST(0x00400000)

You're actually going to ship those parts? :)

It seems a pity to use up a feature bit.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-SLi9iTn9K+TJG/2NbuWy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkna9h0ACgkQdSjSd0sB4dKbUwCeNvExGP1UX513HG20tzTNI/jj
ycIAn0KfNVRz+BAmgW6Cwdo6HCQoZioa
=wsHl
-----END PGP SIGNATURE-----

--=-SLi9iTn9K+TJG/2NbuWy--
