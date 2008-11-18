Return-Path: <michael@ellerman.id.au>
Subject: Re: Some udbg questions
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1226986664.7178.282.camel@pasglop>
References: <ed82fe3e0811171656g5b214c5eqe64b26b8310524f7@mail.gmail.com>
	<1226986664.7178.282.camel@pasglop>
Content-Type: multipart/signed; micalg="pgp-sha1";
	protocol="application/pgp-signature";
	boundary="=-V/iJ7xEEa3u+hfU1xh2x"
Date: Tue, 18 Nov 2008 17:41:26 +1100
Message-Id: <1226990486.16325.19.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-V/iJ7xEEa3u+hfU1xh2x
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2008-11-18 at 16:37 +1100, Benjamin Herrenschmidt wrote:
> On Mon, 2008-11-17 at 18:56 -0600, Timur Tabi wrote:
> > I'm adding udbg support to my console driver, and I've noticed that
> > there is not much consistency on how the various platforms implement
> > udbg support.  So I have a few questions:
> >=20
> > 1. What is the point of implementing udbg_getc?  What does the console
> > do with any characters it receives this early?
>=20
> It's for xmon (and possibly kgdb if we ever hook that up again).
>=20
> > 2. In my driver's udbg initialization function, should I be able to
> > parse the device tree to get parameters?
>=20
> You can. It depends how late. In many cases, we have 2 stage of udbg,
> one very very early that depends on CONFIG_EARLY_DBG_*, and is hard
> wired for a given board and config (ie, when enabled, the kernel will
> probably not even boot on anything else) and is useful for debugging
> very early boot code.
>=20
> Some stuff also initializes udbg slightly later using the device-tree
> etc... to provide a level of console output before the tty drivers are
> loaded. This can be left enabled and doesn't conflict with anything.
>=20
> > 3. What about command-line parameters?
>=20
> No point. As I said, either hard wire for early debugging or use the
> device-tree.
>=20
> > 4. The LPAR and PMAC platforms call register_early_udbg_console (in
> > the udbg_init_debug_lpar and pmac_init_early functions, respectively),
> > but none of the other platforms do.  It appears that the other
> > platforms rely on setup_32.c and setup_64.c to call this function.
> > What's so special about LPAR and PMAC?
>=20
> That's probably some mess left over from history, we should probably
> clean that up. We could probably even make it a console_initcall (that's
> currently commented out).

The pseries code does it because it knows that at that early stage it's
safe to call the udbg routines and have them hooked up to printk, and
they'll actually produce output on the console.

If you register the console before the udbg routines actually work, then
you'll loose any printks that happen before you udbg routine starts
working. On the other hand if you hook up udbg_putc() but don't register
the console, then when you do register the udbg console you'll get all
the printks spat out at you. Which is good.

So it's up to each platform, or udbg implementation, to decide if it
should register the console at the same time it registers the udbg
hooks, or if it's better to do it later.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-V/iJ7xEEa3u+hfU1xh2x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkiY5YACgkQdSjSd0sB4dJYHACgxlpz7dvo6Di7SNrLjQs6/Acv
cDYAoKC1v2klrPN2GdRBy+JbvanFHbxQ
=tYre
-----END PGP SIGNATURE-----

--=-V/iJ7xEEa3u+hfU1xh2x--
