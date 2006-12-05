Return-Path: <michael@ellerman.id.au>
Subject: Re: [POWERPC] fix cell pmu initialisation
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1165349272.29784.69.camel@localhost.localdomain>
References: <20061205155414.4afdcc77.sfr@canb.auug.org.au>
	<200612051434.07917.arnd@arndb.de>
	<1165349272.29784.69.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vO3qAh+r220DRzYfDv5O"
Date: Wed, 06 Dec 2006 09:21:56 +1100
Message-Id: <1165357316.4785.0.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, paulus@samba.org,
	Arnd Bergmann <arnd@arndb.de>, ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-vO3qAh+r220DRzYfDv5O
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-12-06 at 07:07 +1100, Benjamin Herrenschmidt wrote:
> > 1. export a method from cbe_regs.c to find out whether the pmd=20
> >    regs are available and test that in cbe_init_pm_irq().
> > 2. take you patch as is, with a comment hinting to fix it up
> >    when needed.
> > 3. change cbe_init_pm_irq to be called explicitly from cbe_regs_init(),
> >    which already scans the device tree correctly.
>=20
> cbe_regs_init() is called from setup_arch(), which is _very_ early.
>=20
> cbe_init_pm_irq() must be called much later as it requests irqs.
>=20
> Right now, we should stick to the machine_is() solution. We'll look into
> doing something better eventually when the need occurs.

4. Add a FIRMWARE_FEATURE for it.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-vO3qAh+r220DRzYfDv5O
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFdfEDdSjSd0sB4dIRAk12AJ9sBLMDQEfASgwankirnVtN3esgZgCgsLDT
GxS3IIDldp22C20qTklFC70=
=HSWw
-----END PGP SIGNATURE-----

--=-vO3qAh+r220DRzYfDv5O--
