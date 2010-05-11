Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 2/3] powerpc: kdump: CPUs assume the context of the
	oopsing CPU
From: Michael Ellerman <michael@ellerman.id.au>
To: Anton Blanchard <anton@samba.org>
In-Reply-To: <20100511022551.GF12203@kryten>
References: <20100511022329.GE12203@kryten>  <20100511022551.GF12203@kryten>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-1QL28XRoePewfZQR9dq4"
Date: Tue, 11 May 2010 14:14:31 +1000
Message-ID: <1273551271.9209.135.camel@concordia>
Mime-Version: 1.0
Cc: mikey@neuling.org, paulus@samba.org, miltonm@bga.com,
	linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--=-1QL28XRoePewfZQR9dq4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2010-05-11 at 12:25 +1000, Anton Blanchard wrote:
> We wrap the crash_shutdown_handles[] calls with longjmp/setjmp, so if any
> of them fault we can recover. The problem is we add a hook to the debugge=
r
> fault handler hook which calls longjmp unconditionally.
>=20
> This first part of kdump is run before we marshall the other CPUs, so the=
re
> is a very good chance some CPU on the box is going to page fault. And whe=
n
> it does it hits the longjmp code and assumes the context of the oopsing C=
PU.
> The machine gets very confused when it has 10 CPUs all with the same stac=
k,
> all thinking they have the same CPU id. I get even more confused trying
> to debug it.

Lol, guess that one didn't get tested that well :)

Fix looks good.

cheers



--=-1QL28XRoePewfZQR9dq4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkvo2acACgkQdSjSd0sB4dLJ1gCdGpeqbMbx9wk9H4UxTzIRitms
9pwAn1M4XoiwjuXOM+iUskoHjW0XRwuu
=OU02
-----END PGP SIGNATURE-----

--=-1QL28XRoePewfZQR9dq4--
