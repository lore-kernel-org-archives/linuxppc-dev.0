Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 4/16] Abstract MSI suspend
From: Michael Ellerman <michael@ellerman.id.au>
To: Greg Kroah-Hartman <greg@kroah.com>
In-Reply-To: <m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
References: <20070125083410.631EEDE277@ozlabs.org>
	<m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-vWCCqvALZbmsHH6UibJf"
Date: Mon, 29 Jan 2007 18:22:57 +1100
Message-Id: <1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"EricW.Biederman" <ebiederm@xmission.com>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-vWCCqvALZbmsHH6UibJf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2007-01-28 at 01:27 -0700, Eric W. Biederman wrote:
> Michael Ellerman <michael@ellerman.id.au> writes:
>=20
> > Currently pci_disable_device() disables MSI on a device by twiddling
> > bits in config space via disable_msi_mode().
> >
> > On some platforms that may not be appropriate, so abstract the MSI
> > suspend logic into pci_disable_device_msi().
>=20
> >
> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> > ---
> >
> >  drivers/pci/msi.c |   11 +++++++++++
> >  drivers/pci/pci.c |    7 +------
> >  drivers/pci/pci.h |    2 ++
> >  3 files changed, 14 insertions(+), 6 deletions(-)
> >
> > Index: msi/drivers/pci/msi.c
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > --- msi.orig/drivers/pci/msi.c
> > +++ msi/drivers/pci/msi.c
> > @@ -271,6 +271,17 @@ void disable_msi_mode(struct pci_dev *de
> >  	pci_intx(dev, 1);  /* enable intx */
> >  }
> > =20
> > +void pci_disable_device_msi(struct pci_dev *dev)
> > +{
> > +	if (dev->msi_enabled)
> > +		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
> > +			PCI_CAP_ID_MSI);
> > +
> > +	if (dev->msix_enabled)
> > +		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
> > +			PCI_CAP_ID_MSIX);
>=20
> Just a quick note. This is wrong.  It should be PCI_CAP_ID_MSIX.
> The code that is being moved is buggy.  So the patch itself doesn't
> make the situation any worse.

Greg, if you want to drop that patch I'll prepare two patches to fix it
and then move it. I don't have any hardware to test, although I'm
guessing no one does given that it's been broken since its inception.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-vWCCqvALZbmsHH6UibJf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFvaDRdSjSd0sB4dIRAu5QAJ4j5Z3qUNaefgWbFpCslKW3USWhFQCfZ/Ke
sYer+YdUNnds4BGfhtB/KvM=
=6pBd
-----END PGP SIGNATURE-----

--=-vWCCqvALZbmsHH6UibJf--
