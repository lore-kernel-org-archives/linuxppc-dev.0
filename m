Return-Path: <michael@ellerman.id.au>
Subject: Re: [RFC/PATCH 4/16] Abstract MSI suspend
From: Michael Ellerman <michael@ellerman.id.au>
To: "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <m1wt36kyqh.fsf@ebiederm.dsl.xmission.com>
References: <20070125083410.631EEDE277@ozlabs.org>
	<m1ac03sgi5.fsf@ebiederm.dsl.xmission.com>
	<1170055377.19887.60.camel@concordia.ozlabs.ibm.com>
	<m1wt36kyqh.fsf@ebiederm.dsl.xmission.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-1rIFzXMllK+LL9809EPl"
Date: Mon, 29 Jan 2007 20:47:38 +1100
Message-Id: <1170064058.19887.78.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: Greg Kroah-Hartman <greg@kroah.com>, Kyle McMartin <kyle@parisc-linux.org>,
	linuxppc-dev@ozlabs.org, Brice Goglin <brice@myri.com>,
	shaohua.li@intel.com, linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-1rIFzXMllK+LL9809EPl
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2007-01-29 at 01:45 -0700, Eric W. Biederman wrote:
> Michael Ellerman <michael@ellerman.id.au> writes:
>=20
> > On Sun, 2007-01-28 at 01:27 -0700, Eric W. Biederman wrote:
> >> Michael Ellerman <michael@ellerman.id.au> writes:
> >>=20
> >> > Currently pci_disable_device() disables MSI on a device by twiddling
> >> > bits in config space via disable_msi_mode().
> >> >
> >> > On some platforms that may not be appropriate, so abstract the MSI
> >> > suspend logic into pci_disable_device_msi().
> >>=20
> >> >
> >> > Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> >> > ---
> >> >
> >> >  drivers/pci/msi.c |   11 +++++++++++
> >> >  drivers/pci/pci.c |    7 +------
> >> >  drivers/pci/pci.h |    2 ++
> >> >  3 files changed, 14 insertions(+), 6 deletions(-)
> >> >
> >> > Index: msi/drivers/pci/msi.c
> >> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >> > --- msi.orig/drivers/pci/msi.c
> >> > +++ msi/drivers/pci/msi.c
> >> > @@ -271,6 +271,17 @@ void disable_msi_mode(struct pci_dev *de
> >> >  	pci_intx(dev, 1);  /* enable intx */
> >> >  }
> >> > =20
> >> > +void pci_disable_device_msi(struct pci_dev *dev)
> >> > +{
> >> > +	if (dev->msi_enabled)
> >> > +		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
> >> > +			PCI_CAP_ID_MSI);
> >> > +
> >> > +	if (dev->msix_enabled)
> >> > +		disable_msi_mode(dev, pci_find_capability(dev, PCI_CAP_ID_MSI),
> >> > +			PCI_CAP_ID_MSIX);
> >>=20
> >> Just a quick note. This is wrong.  It should be PCI_CAP_ID_MSIX.
> >> The code that is being moved is buggy.  So the patch itself doesn't
> >> make the situation any worse.
> >
> > Greg, if you want to drop that patch I'll prepare two patches to fix it
> > and then move it. I don't have any hardware to test, although I'm
> > guessing no one does given that it's been broken since its inception.
>=20
> The mthca IB driver was one of the early adopters of MSI, and it uses
> MSI-X.  So it isn't that no one is using MSI-X and the MSI-X code
> paths don't get exercised.

I meant the MSI-X suspend/resume path specifically, I'm guessing most
laptops don't come with IB cards yet ;)

> I expect what is closer to the truth is that the code authors have so
> far simply disabled msi separately instead of assuming pci_disable_device
> will do it magically for them.  So it may be the case that we can
> just kill this code path altogether.

I recall reading comments to that effect in one driver, although it
wasn't obvious exactly what the problem was - but it's probably worth
doing a thorough review while the number of MSI/MSI-X drivers is small.

> Possibly we can just reduce it to WARN_ON(dev->msi_enabled || dev->msix_e=
nabled);
>=20
> I suspect msi_remove_pci_irq_vectors may similarly not actually make a
> difference.   I think the function dates from a time when the code
> attempted to cache the irq number so if you removed and re-added a module
> or at least disabled and enabled msi you would get the same linux irq
> number.  I remember killing that caching because it made the code
> unmaintainable and wasn't really useful.

That was my suspicion as well, I was hoping someone who knew the code
better than me would pipe up and let me know why it was a special case.
Have the original MSI authors vanished without a trace?

It seems to date from the initial MSI submission, and has only ever been
called from pci_free_resources(). The rest of the pci hotunplug code
paths are not clear to me though, so I don't know whether we can rely on
pci_disable_msi() already being called for us.

cheers

--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-1rIFzXMllK+LL9809EPl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBFvcK6dSjSd0sB4dIRAm3YAJ45094h85++UmaGfPL1ItYKt6tSZACeJvA2
IazpGjmS/Ppc+TckXQDf8yY=
=9TOv
-----END PGP SIGNATURE-----

--=-1rIFzXMllK+LL9809EPl--
