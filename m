Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 0/7] Powerpc MSI Implementation
From: Michael Ellerman <michael@ellerman.id.au>
To: Greg KH <greg@kroah.com>
In-Reply-To: <20061107080257.GA5874@kroah.com>
References: <1162884080.585336.70559261997.qpush@cradle>
	<1162885276.28571.444.camel@localhost.localdomain>
	<20061107080257.GA5874@kroah.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-EZpxugeXh8yOqQp4j5Xk"
Date: Wed, 08 Nov 2006 16:18:21 +1100
Message-Id: <1162963101.20271.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, "Eric W. Biederman" <ebiederm@xmission.com>,
	linux-pci@atrey.karlin.mff.cuni.cz, "David S. Miller" <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-EZpxugeXh8yOqQp4j5Xk
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2006-11-07 at 17:02 +0900, Greg KH wrote:
> On Tue, Nov 07, 2006 at 06:41:16PM +1100, Benjamin Herrenschmidt wrote:
> >=20
> > >  * Moved msi_info into the pci_dev. This is ugly, but not sure where =
else
> > >    we can put it, pci_dn is no longer an option.
> >=20
> > It's only ugly because it's currently powerpc specific (and thus needs
> > an ifdef). It's the right way to go in the long run for the generic
> > code.=20
> >=20
> > Now the question is wether Eric is interested in our work and thus
> > wether it's worth trying to port the intel & altix MSI stuff to our
> > infrastructure, in which case there is no more reason not to add the
> > msi_info to pci_dev without any ifdef (just define it as an empty struc=
t
> > if CONFIG_PCI_MSI is not set).
>=20
> I have no objection to taking this core change, and I do think the intel
> and altix stuff should be moved over to this new model.

Cool.

> Oh, and I think your first two patches can be applied now to the tree
> (header file changes).  Any objection to me doing this?

There's a trivial bug in 1/7 (HT #defines), so hold back on that one
until I resend. The movement of MSI-X #defines is good to go. I also
sent you the patch to add HT_SUBCAP_OFFSET yesterday that I think is
ready to merge.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-EZpxugeXh8yOqQp4j5Xk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFUWiddSjSd0sB4dIRAvEgAKDMrSHow5Uessqv8ayXzvUCWZovuACgjA29
3Ra8tgol7Nq5sRdu6pSUTlA=
=BSPy
-----END PGP SIGNATURE-----

--=-EZpxugeXh8yOqQp4j5Xk--
