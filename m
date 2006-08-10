Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH][0/2] RTAS MSI
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1155138084.17187.53.camel@localhost.localdomain>
References: <1154024154.29826.229.camel@goblue>
	<1154062599.21801.40.camel@localhost.localdomain>
	<802085A1-AA37-4787-A2D6-B619C6BE7AB4@kernel.crashing.org>
	<1155090210.7087.4.camel@localhost.localdomain>
	<F5E5EF18-6452-4E9D-8A43-6D1CE9C3E43E@kernel.crashing.org>
	<1155119228.6949.24.camel@localhost.localdomain>
	<1155138084.17187.53.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-cJs7SXfbs8K5tUj+PQNw"
Date: Thu, 10 Aug 2006 18:22:08 +1000
Message-Id: <1155198129.9801.92.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-cJs7SXfbs8K5tUj+PQNw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2006-08-09 at 17:41 +0200, Benjamin Herrenschmidt wrote:
> > So I think we could have pci_enable_msi(dev), which would enable a
> > single MSI _or_ MSI-X vector, depending on what's available. That'd be
> > used by drivers that just want a simple replacement for LSI. And then
> > pci_enable_multi_msi(dev, num_irqs) which would give the driver num_irq=
s
> > MSI or MSI-X vectors.
>=20
> You cannot lie and have pci_enable_msi() enable an MSI-X vector. Some
> cards need additional tweaking when enabling MSI or MSI-X and if the
> system enables MSI-X while the driver thinks it's MSI, bad things might
> happen.

Hmm. As I read the PAPR the firmware calls may do just that (pp 122).
ie. it doesn't differentiate between MSIs and MSI-Xs as far as I can
tell. So if we implement pci_enable_msi() via the RTAS calls we might be
violating that constraint.

> pci_enable_msi() should call the firmware to reconfigure for only one
> MSI and enable just that. MSI-X is the only really sexy thing anyway
> (that and a way to spread MSI-X accross CPUs from the kernel but that's
> another topic)

And the current implementation doesn't do that either, so we should fix
it to only allocate 1 MSI, regardless of what firmware has set.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-cJs7SXfbs8K5tUj+PQNw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBE2uywdSjSd0sB4dIRAtNfAKCCfZodSJh9/TjMv8HBVtIOfSVo1QCgvw2p
T026ATdl7oRtvqbuY5x48rw=
=NAXm
-----END PGP SIGNATURE-----

--=-cJs7SXfbs8K5tUj+PQNw--
