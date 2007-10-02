Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 3/4] Simplify rtas_change_msi() error semantics
From: Michael Ellerman <michael@ellerman.id.au>
To: benh@kernel.crashing.org
In-Reply-To: <1191306253.6310.106.camel@pasglop>
References: <3034ec8fd939bd5cfcdb7ac65206ae2771dc9b2c.1190270165.git.michael@ellerman.id.au>
	<fbd88f287ba9d9ca41b5c8da734afd595ae25922.1190270165.git.michael@ellerman.id.au>
	<1191302603.6310.88.camel@pasglop> <1191304690.6593.8.camel@concordia>
	<1191306253.6310.106.camel@pasglop>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-RrHGZ/dXoCvUHkNZwxlE"
Date: Tue, 02 Oct 2007 17:40:25 +1000
Message-Id: <1191310825.6593.21.camel@concordia>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-RrHGZ/dXoCvUHkNZwxlE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-10-02 at 16:24 +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2007-10-02 at 15:58 +1000, Michael Ellerman wrote:
> > > Looks allright, just a question tho... what do we do if it fails ?
> > Do we
> > > try to fallback to a lower number of MSIs ? Or what ? Dead device ?
> >=20
> > That's all up to the device driver. In theory the driver could try agai=
n
> > with a lower count - but that might require extra logic in the driver t=
o
> > handle shared irq handlers etc. In practice I think the current drivers
> > will just fail.
>=20
> Question is badly phrased.. I meant something more like... what do we do
> if RTAS returns a lower count ?
>=20
> That is, we end up with that device with that lower count of MSIs
> enabled, we fail at the driver level, do we still somewhat keep track ?
> Drivers might assume that means it can use LSIs no ? which may not be
> the case... Shouldn't we try to switch back to LSI mode (or does the
> RTAS interface doesnt allow it ?)

OK I get you. So:

rtas_setup_msi_irqs() detects that it got fewer MSIs than it asked for
and returns an error.

The generic code (drivers/pci/msi.c) notices the error and calls
msi_free_irqs().

That calls back into rtas_teardown_msi_irqs() which disposes of the virq
mappings and calls rtas_disable_msi().

rtas_disable_msi() asks firmware to configure 0 MSIs on the device, that
hopefully succeeds. AFAIK configuring 0 MSIs is as close as we can get
to disabling MSI via RTAS.

Perhaps that should also (re)enable INTX?

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-RrHGZ/dXoCvUHkNZwxlE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHAfXpdSjSd0sB4dIRAqoeAKChxYF+IxNN1ZWQZpW840DXffYlFACcDQ8u
PYRSUyVmpe6IknXEGQuRy3A=
=Etvc
-----END PGP SIGNATURE-----

--=-RrHGZ/dXoCvUHkNZwxlE--
