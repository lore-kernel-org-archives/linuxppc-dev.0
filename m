Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][0/2] RTAS MSI
From: Michael Ellerman <michael@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
References: <1154024154.29826.229.camel@goblue>
	<1154062599.21801.40.camel@localhost.localdomain>
	<802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-z5EguXknhtAI47ABPy9N"
Date: Wed, 09 Aug 2006 12:23:30 +1000
Message-Id: <1155090210.7087.4.camel@localhost.localdomain>
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


--=-z5EguXknhtAI47ABPy9N
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2006-07-28 at 20:43 +0200, Segher Boessenkool wrote:
> >> The RTAS patch skips the intel-centric MSI layer and uses
> >> pci_enable/disable_msi() calls directly.  It does not correctly =20
> >> handle
> >> multi-vector MSI either.
> >
> > Multi-vector MSIs aren't handled by the linux API anyway it seems (the
> > doc says pci_enable_msi() only ever enables one MSI) so that's fine if
> > you don't handle them :) The word on the street is that multivector =20
> > MSIs
> > aren't useful, MSI-X are.
>=20
> pci_enable_msi() should always enable exactly one or zero MSIs.  Maybe
> Jake's patch doesn't follow this rule, and that is what he alluded to?

I was just re-reading this thread and this got me thinking. I think the
current code does violate this rule if firmware has allocated more than
one MSI to the device.

In rtas_enable_msi() we ask firmware how many MSIs the device has been
given (by firmware), we then return one to the driver, but leave any
extras configured.

So this might lead to the state where the card has been configured to
use x MSIs, but we only tell the driver about 1 of them. I don't know
enough PCI to grok if that's going to be a problem.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-z5EguXknhtAI47ABPy9N
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE2UchdSjSd0sB4dIRApVqAJ476v54IIao9hXH/1Z3KAgDcoRalwCeJgSU
oJGbqy0VXuQ9oIjsBQH66dQ=
=SSps
-----END PGP SIGNATURE-----

--=-z5EguXknhtAI47ABPy9N--
