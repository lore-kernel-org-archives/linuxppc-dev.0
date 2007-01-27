Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 14/16] MPIC MSI backend
From: Michael Ellerman <michael@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1169849295.24996.172.camel@localhost.localdomain>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083417.69895DE3C5@ozlabs.org>
	<20070126064352.GA328@colo.lackof.org>
	<m1ejpiw9s8.fsf@ebiederm.dsl.xmission.com>
	<5A6F70E0-A8AB-4636-8F41-2EC82A3B13B7@kernel.crashing.org>
	<m1r6thvjdq.fsf@ebiederm.dsl.xmission.com>
	<1169849295.24996.172.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-eL6juBhAcvItZcB6LKhj"
Date: Sat, 27 Jan 2007 17:54:11 +1100
Message-Id: <1169880851.2294.38.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Grant Grundler <grundler@parisc-linux.org>,
	Greg Kroah-Hartman <greg@kroah.com>,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S.Miller" <davem@davemloft.net>, Brice Goglin <brice@myri.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-eL6juBhAcvItZcB6LKhj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2007-01-27 at 09:08 +1100, Benjamin Herrenschmidt wrote:
> > >From that comes our need for a data structure to map from an irq to a
> > msi data structure in a generic fashion, because we don't just program
> > the pci card and forget about it.  From those requirements comes our
> > need for a little bit more complete support of the features of the
> > hardware that Michaels implementation.
>=20
> Well, we need to go from pci_dev -> MSI and from linux irq_desc ->
> MSI... for now, we can get away without the later on powerpc, but I
> understand that intel needs that. The initial intel code used an array
> of NR_IRQs, but that sucks. What I remember of your patch is that they
> were using chip_data in irq_desc.

There's still an array of NR_IRQs msi_desc*, which are also attached to
the irq_desc.

The msi_desc is allocated and immediately attached to the irq_desc. Then
later it gets hooked into the array (attach_msi_entry) - I don't
understand why both methods are necessary - they both require the irq.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-eL6juBhAcvItZcB6LKhj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFuvcTdSjSd0sB4dIRAm99AKCimIGFLWJDk5QK6twht5f9k/2QBQCeP/5z
l1IFFeUzrXA6+8mfvObbi+Y=
=cn16
-----END PGP SIGNATURE-----

--=-eL6juBhAcvItZcB6LKhj--
