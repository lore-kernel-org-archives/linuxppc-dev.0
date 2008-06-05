Return-Path: <michael@ellerman.id.au>
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by ozlabs.org (Postfix) with ESMTP id 75B36DDE2A
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 13:48:02 +1000 (EST)
Subject: Re: [PATCH 2/6] Allow create_branch() to return errors
From: Michael Ellerman <michael@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <b5d665dc398cc0822783593ce3a2fc6b62990759.1212042061.git.michael@ellerman.id.au>
References: <33bba4965d9907a8a93e9f92fd5c3874a6e21f90.1212042061.git.michael@ellerman.id.au>
	<b5d665dc398cc0822783593ce3a2fc6b62990759.1212042061.git.michael@ellerman.id.au>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-0spGNEvzzBdJso6pBDg/"
Date: Thu, 05 Jun 2008 13:48:02 +1000
Message-Id: <1212637682.8176.10.camel@localhost>
Mime-Version: 1.0
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-0spGNEvzzBdJso6pBDg/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2008-05-29 at 16:20 +1000, Michael Ellerman wrote:
> Currently create_branch() creates a branch instruction for you, and patch=
es
> it into the call site. In some circumstances it would be nice to be able =
to
> create the instruction and patch it later, and also some code might want
> to check for errors in the branch creation before doing the patching. A
> future patch will change create_branch() to check for errors.
>=20
> For callers that don't care, replace create_branch() with patch_branch(),
> which just creates the branch and patches it directly.
>=20
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/kernel/crash_dump.c          |    4 ++--
>  arch/powerpc/lib/code-patching.c          |   11 ++++++++---
>  arch/powerpc/platforms/86xx/mpc86xx_smp.c |    2 +-
>  arch/powerpc/platforms/powermac/smp.c     |    2 +-
>  include/asm-powerpc/code-patching.h       |    5 +++--
>  5 files changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash=
_dump.c
> index 35b9a66..ee2dac5 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -42,8 +42,8 @@ static void __init create_trampoline(unsigned long addr=
)
>  	 * branch to "addr" we jump to ("addr" + 32 MB). Although it requires
>  	 * two instructions it doesn't require any registers.
>  	 */
> -	create_instruction(addr, 0x60000000); /* nop */
> -	create_branch(addr + 4, addr + PHYSICAL_START, 0);
> +	patch_instruction(addr, 0x60000000); /* nop */
> +	patch_branch(addr + 4, addr + PHYSICAL_START, 0);
>  }
> =20
>  void __init setup_kdump_trampoline(void)
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-pat=
ching.c
> index 7afae88..1391981 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -11,7 +11,7 @@
>  #include <asm/code-patching.h>
> =20
>=20
> -void create_instruction(unsigned long addr, unsigned int instr)
> +void patch_instruction(unsigned long addr, unsigned int instr)
>  {
>  	unsigned int *p;
>  	p  =3D (unsigned int *)addr;

Reviewing my own patches again .. this should take an unsigned int *
instead of an unsigned long.

I'll repost sometime.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-0spGNEvzzBdJso6pBDg/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIR2HydSjSd0sB4dIRAv7KAJ9iHQTpBNOksh65gJ9gFiJqrAulPACfTkPC
biN0IWx3K5IYEoVjAmSH5sk=
=Durf
-----END PGP SIGNATURE-----

--=-0spGNEvzzBdJso6pBDg/--
