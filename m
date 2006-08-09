Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][0/2] RTAS MSI
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <F5E5EF18-6452-4E9D-8A43-6D1CE9C3E43E@kernel.crashing.org>
References: <1154024154.29826.229.camel@goblue>
	<1154062599.21801.40.camel@localhost.localdomain>
	<802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
	<1155090210.7087.4.camel@localhost.localdomain>
	<F5E5EF18-6452-4E9D-8A43-6D1CE9C3E43E@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-4m1h9O1V/Y0ueA4jjkT0"
Date: Wed, 09 Aug 2006 20:27:08 +1000
Message-Id: <1155119228.6949.24.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-4m1h9O1V/Y0ueA4jjkT0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-09 at 11:52 +0200, Segher Boessenkool wrote:
> > I was just re-reading this thread and this got me thinking. I think =20
> > the
> > current code does violate this rule if firmware has allocated more =20
> > than
> > one MSI to the device.
> >
> > In rtas_enable_msi() we ask firmware how many MSIs the device has been
> > given (by firmware), we then return one to the driver, but leave any
> > extras configured.
> >
> > So this might lead to the state where the card has been configured to
> > use x MSIs, but we only tell the driver about 1 of them. I don't know
> > enough PCI to grok if that's going to be a problem.
>=20
> A device could in principle happily start using all MSIs it has been
> assigned as soon as its global interrupt enable bit is set.  So lying
> to the driver about what MSIs are enabled can in principle cause nasty
> problems.
>=20
> In reality however, on any (recent) device, every interrupt cause also
> has its own enable bits that the driver needs to set.  So we're sort-of
> safe here.

Yeah ok, I thought that was probably the answer - it's possible, but
probably not a problem IRL.

> Eventually, we should change the API for pci_enable_msi() so that it
> can enable multiple MSIs as well; an arch implementation can always
> choose to do just one.  This lets us roll the APIs for MSI and MSI-X
> into one as well btw -- always a good thing!

Yeah. Looking at the way drivers use the current API (and there's only a
few), they generally seem to try to enable n MSI-X vectors, then
fallback to a single MSI then LSI. And then there's some that just want
a single MSI as a drop-in replacement for LSI.

So I think we could have pci_enable_msi(dev), which would enable a
single MSI _or_ MSI-X vector, depending on what's available. That'd be
used by drivers that just want a simple replacement for LSI. And then
pci_enable_multi_msi(dev, num_irqs) which would give the driver num_irqs
MSI or MSI-X vectors.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-4m1h9O1V/Y0ueA4jjkT0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE2bh8dSjSd0sB4dIRAu8pAJ0ayspMA5xISXb7SsAzhcxGtEet+QCeL5mq
9NXybbN9XwD5gdjCsVj4uWM=
=7eT1
-----END PGP SIGNATURE-----

--=-4m1h9O1V/Y0ueA4jjkT0--
