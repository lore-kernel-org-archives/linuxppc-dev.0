Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 6/9] MPIC MSI allocator
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1166056373.11914.246.camel@localhost.localdomain>
References: <1166006370.90082.476088563252.qpush@cradle>
	<20061213104007.4B8F967DA9@ozlabs.org> <20061213122353.7498a25e@pb15>
	<1166052344.11914.233.camel@localhost.localdomain>
	<20061213180921.487b1cea@pb15>
	<1166056373.11914.246.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-yEPnn0CmuYuBWvT4gQus"
Date: Thu, 14 Dec 2006 11:59:00 +1100
Message-Id: <1166057940.6838.25.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	linux-pci@atrey.karlin.mff.cuni.cz, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-yEPnn0CmuYuBWvT4gQus
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-12-14 at 11:32 +1100, Benjamin Herrenschmidt wrote:
> > So make the platform register the range of (possibly) usable MSI
> > addresses instead of adding a nasty hack like that to the mpic driver.
>=20
> The hack is not that nasty... it's only ever run on U3/U4 on which it's
> actually correct, at least if Michael did what I told him to do which is
> to test the MPIC_BROKEN_U3 bit :-)

Nah I didn't make it U3/U4 specific, although I could. If we do that,
then I think the logic needs to be:

if get_property("msi_available")
	mpic_msi_reserve_dt_irqs()
elif is_u3_or_u4()
	mpic_msi_reserve_u3u4_irqs()
else
	return error

Because if we don't have a firmware property, and we don't make an
educated guess at what's reserved, then there's a very good chance our
first MSI will get hwirq 0 and that it won't work.

As far as putting hacks in the MPIC driver .. have you read it
lately? ;)  But seriously, I think if there's anyway these magic numbers
should be, it is in this code, not the platform code.
 =20
cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-yEPnn0CmuYuBWvT4gQus
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFgKHUdSjSd0sB4dIRAoHKAJ4wGCTIupu2DJ8I+ad7EB4x6lKXIgCggaf9
+9Utcb5eEk9YHsb2n8PQaPI=
=Kvvt
-----END PGP SIGNATURE-----

--=-yEPnn0CmuYuBWvT4gQus--
