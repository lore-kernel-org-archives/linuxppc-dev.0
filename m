Return-Path: <dgibson@ozlabs.org>
Date: Mon, 24 Jun 2013 13:52:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
Message-ID: <20130624035249.GD25265@voom.fritz.box>
References: <E63966E3-336F-4CB8-96EC-24D2C1644E62@suse.de>
 <1371653443.21896.291.camel@pasglop>
 <1371656989.22659.98.camel@ul30vt.home>
 <51C28BEA.8050501@ozlabs.ru>
 <20130620052822.GB3140@voom.redhat.com>
 <1371714449.3944.14.camel@pasglop> <51C2C1CC.9000003@ozlabs.ru>
 <1371740113.32709.22.camel@ul30vt.home>
 <20130622120304.GB25265@voom.fritz.box>
 <1371911286.30572.155.camel@ul30vt.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
In-Reply-To: <1371911286.30572.155.camel@ul30vt.home>
Cc: "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Joerg Roedel <joro@8bytes.org>,
 Rusty Russell <rusty@rustcorp.com.au>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, open list <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 22, 2013 at 08:28:06AM -0600, Alex Williamson wrote:
> On Sat, 2013-06-22 at 22:03 +1000, David Gibson wrote:
> > On Thu, Jun 20, 2013 at 08:55:13AM -0600, Alex Williamson wrote:
> > > On Thu, 2013-06-20 at 18:48 +1000, Alexey Kardashevskiy wrote:
> > > > On 06/20/2013 05:47 PM, Benjamin Herrenschmidt wrote:
> > > > > On Thu, 2013-06-20 at 15:28 +1000, David Gibson wrote:
> > > > >>> Just out of curiosity - would not get_file() and fput_atomic() =
on a
> > > > >> group's
> > > > >>> file* do the right job instead of vfio_group_add_external_user(=
) and
> > > > >>> vfio_group_del_external_user()?
> > > > >>
> > > > >> I was thinking that too.  Grabbing a file reference would certai=
nly be
> > > > >> the usual way of handling this sort of thing.
> > > > >=20
> > > > > But that wouldn't prevent the group ownership to be returned to
> > > > > the kernel or another user would it ?
> > > >=20
> > > >=20
> > > > Holding the file pointer does not let the group->container_users co=
unter go
> > > > to zero
> > >=20
> > > How so?  Holding the file pointer means the file won't go away, which
> > > means the group release function won't be called.  That means the gro=
up
> > > won't go away, but that doesn't mean it's attached to an IOMMU.  A us=
er
> > > could call UNSET_CONTAINER.
> >=20
> > Uhh... *thinks*.  Ah, I see.
> >=20
> > I think the interface should not take the group fd, but the container
> > fd.  Holding a reference to *that* would keep the necessary things
> > around.  But more to the point, it's the right thing semantically:
> >=20
> > The container is essentially the handle on a host iommu address space,
> > and so that's what should be bound by the KVM call to a particular
> > guest iommu address space.  e.g. it would make no sense to bind two
> > different groups to different guest iommu address spaces, if they were
> > in the same container - the guest thinks they are different spaces,
> > but if they're in the same container they must be the same space.
>=20
> While the container is the gateway to the iommu, what empowers the
> container to maintain an iommu is the group.  What happens to a
> container when all the groups are disconnected or closed?  Groups are
> the unit that indicates hardware access, not containers.  Thanks,

Uh... huh?  I'm really not sure what you're getting at.

The operation we're doing for KVM here is binding a guest iommu
address space to a particular host iommu address space.  Why would we
not want to use the obvious handle on the host iommu address space,
which is the container fd?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iEYEARECAAYFAlHHwpEACgkQaILKxv3ab8ZAwgCggywnKG0cWdU1mGMrdiJET+bR
lMIAnRkUHnjt+LBuM7e9uG37A20iGmNt
=1XwX
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
