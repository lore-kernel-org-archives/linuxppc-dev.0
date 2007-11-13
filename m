Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id D0A36DDE2F
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 12:15:28 +1100 (EST)
Date: Tue, 13 Nov 2007 12:15:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Marian Balakowicz <m8@semihalf.com>
Subject: Re: [PATCH v4 04/13] [POWERPC] Add generic support for simple
	MPC5200 based boards
Message-Id: <20071113121529.8ed9c88b.sfr@canb.auug.org.au>
In-Reply-To: <4738D218.9060503@semihalf.com>
References: <20071109171137.16289.39575.stgit@hekate.izotz.org>
	<20071109171202.16289.2618.stgit@hekate.izotz.org>
	<20071110113133.86aa3de2.sfr@canb.auug.org.au>
	<4738D218.9060503@semihalf.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
	micalg="PGP-SHA1";
	boundary="Signature=_Tue__13_Nov_2007_12_15_29_+1100_f2Nb.U5OiojkIYZg"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Signature=_Tue__13_Nov_2007_12_15_29_+1100_f2Nb.U5OiojkIYZg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Nov 2007 23:22:16 +0100 Marian Balakowicz <m8@semihalf.com> wrot=
e:
>
> Stephen Rothwell wrote:
> > On Fri, 09 Nov 2007 18:12:02 +0100 Marian Balakowicz <m8@semihalf.com> =
wrote:
> >> +++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
> >>
> >> +static int __init mpc5200_simple_probe(void)
> >> +{
> >> +	unsigned long node =3D of_get_flat_dt_root();
> >=20
> > You need to include asm/prom.h to use the flattened device tree accesso=
rs.
>=20
> Right, but this one is already included in mpc52xx.h.

But you should directly include it since you are using stuff declared in
there.  Depending on indirect includes is fragile (someone might take it
out of mpc52xx.h one day).

> >> +	/* list of the supported boards */
> >> +	const char *board[] =3D {=09
> >> +		"tqc,tqm5200",
> >> +		"promess,motionpro",
> >> +		"schindler,cm5200",
> >> +		NULL
> >> +	};
> >=20
> > Make that static.
>=20
> Board table is no longer needed after kernel is initialized, it would
> be nice to declare it static and __initdata, but that would be quite
> ugly as it's a table of pointers and each string would require
> separate statement too. If we don't do it then what's the benefit of
> making it static?

Except the way it currently is, the data stays in the kernel image.  If
you declared it static and __initdata then at least the table would
actually go away at run time.  True, to make the strings go away is
harder.

Doesn't actually matter much.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__13_Nov_2007_12_15_29_+1100_f2Nb.U5OiojkIYZg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHOPq1TgG2atn1QN8RAoG/AJ4qGU+Ne32qETbNukEvkGYiEW3PwACfUlR5
byGqY9q6Hl6mJ32APibLHUM=
=WZao
-----END PGP SIGNATURE-----

--Signature=_Tue__13_Nov_2007_12_15_29_+1100_f2Nb.U5OiojkIYZg--
