Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc, ftrace: use create_branch lib function
From: Michael Ellerman <michael@ellerman.id.au>
To: Steven Rostedt <rostedt@goodmis.org>
In-Reply-To: <20090213150147.180922180@goodmis.org>
References: <20090213150055.947823726@goodmis.org>
	<20090213150147.180922180@goodmis.org>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-G1nWbe2ySdfv7FZxWp6Y"
Date: Sun, 15 Feb 2009 00:49:26 +1100
Message-Id: <1234619366.10265.3.camel@localhost>
Mime-Version: 1.0
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Steven Rostedt <srostedt@redhat.com>, Paul Mackerras <paulus@samba.org>,
	Frederic Weisbecker <fweisbec@gmail.com>, Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-G1nWbe2ySdfv7FZxWp6Y
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2009-02-13 at 10:00 -0500, Steven Rostedt wrote:
> plain text document attachment
> (0002-powerpc-ftrace-use-create_branch-lib-function.patch)
> From: Steven Rostedt <srostedt@redhat.com>
>=20
> Impact: clean up, remove duplicate code
>=20
> When ftrace was first ported to PowerPC, there existed a
> create_function_call that would create the instruction to make a call
> to a given address. Unfortunately, this call expected to write to
> the address it was given, and since it used the address to calculate
> the offset, it could not be faked.
>=20
> ftrace needed a way to create the instruction without actually writing
> that instruction to the text section. So ftrace had to implement its
> own code.
>=20
> Now we have create_branch in the code patching library, which does
> exactly what ftrace needs. This patch replaces ftrace's implementation
> with the library function.

Thanks for doing this, I was going to once the ftrace code had settled a
little but you beat me to it.

> @@ -46,17 +41,10 @@ ftrace_call_replace(unsigned long ip, unsigned long a=
ddr, int link)
>  {
>  	unsigned int op;
> =20
> -	/*
> -	 * It would be nice to just use create_function_call, but that will
> -	 * update the code itself. Here we need to just return the
> -	 * instruction that is going to be modified, without modifying the
> -	 * code.
> -	 */
>  	addr =3D GET_ADDR(addr);
> =20
>  	/* if (link) set op to 'bl' else 'b' */
> -	op =3D 0x48000000 | (link ? 1 : 0);
> -	op |=3D (ftrace_calc_offset(ip, addr) & 0x03fffffc);
> +	op =3D create_branch((unsigned int *)ip, addr, link ? 1 : 0);

If I was feeling nit-picky I'd say you should use:

op =3D create_branch((unsigned int *)ip, addr, link ? BRANCH_SET_LINK : 0);


But admittedly we're unlikely to ever change the flag handling, so it's
probably not worth the effort of a respin (or this email :).

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-G1nWbe2ySdfv7FZxWp6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmWy+YACgkQdSjSd0sB4dKl5QCgmwvZqmSNwYmn6qFsDorpWDjS
W+8An373Cjdrg+qIPXFloGs/M1qr6SBJ
=ocCK
-----END PGP SIGNATURE-----

--=-G1nWbe2ySdfv7FZxWp6Y--
