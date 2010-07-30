Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Replace hardcoded offset by BREAK_INSTR_SIZE
From: Michael Ellerman <michael@ellerman.id.au>
To: Michal Simek <monstr@monstr.eu>
In-Reply-To: <1280308724-8402-1-git-send-email-monstr@monstr.eu>
References: <1280308724-8402-1-git-send-email-monstr@monstr.eu>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-4cnyZgGdmWyjlKcSwnjt"
Date: Fri, 30 Jul 2010 22:26:24 +1000
Message-ID: <1280492784.25731.35.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jason Wessel <jason.wessel@windriver.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-4cnyZgGdmWyjlKcSwnjt
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-07-28 at 11:18 +0200, Michal Simek wrote:
> kgdb_handle_breakpoint checks the first arch_kgdb_breakpoint
> which is not known by gdb that's why is necessary jump over
> it. The jump lenght is equal to BREAK_INSTR_SIZE that's
> why is cleaner to use defined macro instead of hardcoded
> non-described offset.
>=20
> Signed-off-by: Michal Simek <monstr@monstr.eu>
> CC: Jason Wessel <jason.wessel@windriver.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev@ozlabs.org
> ---
>  arch/powerpc/kernel/kgdb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/kgdb.c b/arch/powerpc/kernel/kgdb.c
> index 82a7b22..7f61a3a 100644
> --- a/arch/powerpc/kernel/kgdb.c
> +++ b/arch/powerpc/kernel/kgdb.c
> @@ -129,7 +129,7 @@ static int kgdb_handle_breakpoint(struct pt_regs *reg=
s)
>  		return 0;
> =20
>  	if (*(u32 *) (regs->nip) =3D=3D *(u32 *) (&arch_kgdb_ops.gdb_bpt_instr)=
)
> -		regs->nip +=3D 4;
> +		regs->nip +=3D BREAK_INSTR_SIZE;

Except to powerpc fokls, who intuitively know what nip + 4 means, but
will have to lookup what BREAK_INSTR_SIZE is to be sure. But I'm being
nit-picky :)

cheers


--=-4cnyZgGdmWyjlKcSwnjt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkxSxPAACgkQdSjSd0sB4dIaJQCfRnPwisJ9ioDnChvQJd2NfIjn
XO8Anj69G6Tdw2540HoHJJcjfogNdpTO
=2sQQ
-----END PGP SIGNATURE-----

--=-4cnyZgGdmWyjlKcSwnjt--
