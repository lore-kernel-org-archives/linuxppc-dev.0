Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <E5D01D01-55B0-4F1E-A32E-BCADD097F077@kernel.crashing.org>
References: <20070125083417.69895DE3C5@ozlabs.org>
	<E5D01D01-55B0-4F1E-A32E-BCADD097F077@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1JLxw9xdUm3eQK3QrFC3"
Date: Sat, 27 Jan 2007 17:33:14 +1100
Message-Id: <1169879594.2294.27.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-1JLxw9xdUm3eQK3QrFC3
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-01-26 at 10:11 +0100, Segher Boessenkool wrote:
> > MPIC MSI backend. Based on code from Segher, heavily hacked by me.
> > Renamed to mpic_htmsi, as it only deals with MSI over Hypertransport.
>=20
> More exactly: it only deals with MSIs that are translated
> by some whatever-to-HT bridge into a normal HT interrupt.
>=20
> > We properly discover the HT magic address by reading the config space.
>=20
> ...config space of that bridge.
>=20
> > Now we have an irq allocator we can support > 1 MSI, and we don't =20
> > reuse
> > the LSI.
>=20
> Right, that's what I asked about in the other thread, so
> the FIXME in htmsi_alloc() can indeed go.

No we don't reuse the LSI irq, so the FIXME can go.

> Why is MSI-X still unsupported?  Simply because of lack
> of testing?  (See htmsi_check()).

Yeah. There's four drivers in mainline that call pci_enable_msix(), and
I don't have hardware for any of them.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-1JLxw9xdUm3eQK3QrFC3
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFuvIqdSjSd0sB4dIRAivHAKCL7v8IskvL0YW0n5jyiXm8DRSxHQCghiW2
LhI4CvcS5lwFGhAtxaHpPTg=
=QfCK
-----END PGP SIGNATURE-----

--=-1JLxw9xdUm3eQK3QrFC3--
