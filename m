Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 02/11] Add udbg_console_anytime() which sets udbg
	console to CON_ANYTIME
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1208506858.6958.404.camel@pasglop>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
	<bdf32a463da3cf9603c0b0bd257ac5deedcbbfe0.1208505275.git.michael@ellerman.id.au>
	<1208506858.6958.404.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-NPwDs9tpdV9FAwpne0He"
Date: Wed, 23 Apr 2008 05:43:23 +0000
Message-Id: <1208929403.9212.7.camel@concordia.ozlabs.ibm.com>
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


--=-NPwDs9tpdV9FAwpne0He
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-04-18 at 18:20 +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2008-04-18 at 17:54 +1000, Michael Ellerman wrote:
> > In theory the udbg console should be safe to call basically at any time
> > after boot. It does not need any per-cpu resources or for the cpu to be
> > online, as long as there is a udbg_putc routine hooked up it should
> > work. So it should be able to be marked as CON_ANYTIME.
> >=20
> > Verifying this will take a bit of time and testing though, so instead o=
f
> > marking udbg console as CON_ANYTIME for all platforms, add a routine so
> > that a platform can opt-in to having udbg console called early.
> >=20
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
>=20
> Nah, just stick it always.

Meh, OK. I'm still going to require the platform code to call
register_early_udbg_console() if it wants to register earlier than
setup_system() - so the behaviour will essentially be the same.

NB that if it breaks anything I can now say BenH told me to do it ;)

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-NPwDs9tpdV9FAwpne0He
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIDsx7dSjSd0sB4dIRAqTWAJ0VpUoJesVLTO8ax0LvPuXnGL5OXQCcCK6r
j4XpVi5r6xzGd8QFbIzUyYY=
=G54R
-----END PGP SIGNATURE-----

--=-NPwDs9tpdV9FAwpne0He--
