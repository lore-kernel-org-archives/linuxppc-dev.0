Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 8/8] powerpc: last bits to support kdump on ppc32
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080801141435.GH1161@polina.dev.rtsoft.ru>
References: <20080801141306.GA29127@polina.dev.rtsoft.ru>
	<20080801141435.GH1161@polina.dev.rtsoft.ru>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-8aqR82PtE99b7vImT2Uy"
Date: Mon, 04 Aug 2008 00:40:43 +1000
Message-Id: <1217774443.7153.10.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-8aqR82PtE99b7vImT2Uy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-08-01 at 18:14 +0400, Anton Vorontsov wrote:
> From: Dale Farnsworth <dale@farnsworth.org>
>=20
> Wire up the trampoline code for ppc32 to relay exceptions from the
> vectors at address 0 to vectors at address 32MB, and modify Kconfig
> to enable Kdump support for all powerpcs (except BookE, for now).
>=20
> Signed-off-by: Dale Farnsworth <dale@farnsworth.org>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

> diff --git a/arch/powerpc/kernel/crash_dump.c b/arch/powerpc/kernel/crash=
_dump.c
> index e0debcc..96cd521 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -34,7 +34,11 @@ void __init reserve_kdump_trampoline(void)
> =20
>  static void __init create_trampoline(unsigned long addr)
>  {
> -	unsigned int *p =3D (unsigned int *)addr;
> +	unsigned int *p;
> +
> +	/* XXX: why this code is working without +=3D PAGE_OFFSET on PPC64? */
> +	addr +=3D PAGE_OFFSET;
> +	p =3D (unsigned int *)addr;

Because we're still in real mode when we call it.

It's kind of funny that it works on 32-bit as well. You're creating a
branch from 0xc0000000 to 0xc2000000, and then expecting it to work when
you're in real mode and you actually want to jump from 0x0 to 0x2000000
- luckily it's a relative branch :)

To clean this up you should just be able to change the definitions for
KDUMP_TRAMPOLINE_START/END to include PAGE_OFFSET and that should work
for 32 & 64-bit.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-8aqR82PtE99b7vImT2Uy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIlcNrdSjSd0sB4dIRAvGVAKDCLDESo0RPNGLILND9JLXgsOr12ACfXzjl
zDXsJ9ApmbrvEe5uHNOwU9Y=
=JMJ9
-----END PGP SIGNATURE-----

--=-8aqR82PtE99b7vImT2Uy--
