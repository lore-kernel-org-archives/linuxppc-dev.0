Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5DAF1A0026
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 11:42:19 +1000 (AEST)
Date: Mon, 21 Sep 2015 11:42:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 0/2] VFIO: Accept IOMMU group (PE) ID
Message-ID: <20150921014228.GG20331@voom.fritz.box>
References: <1442557469-22185-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1442591252.23936.254.camel@redhat.com>
 <20150919062247.GC29031@voom.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5UGlQXeG3ziZS81+"
In-Reply-To: <20150919062247.GC29031@voom.redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--5UGlQXeG3ziZS81+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2015 at 04:22:47PM +1000, David Gibson wrote:
> On Fri, Sep 18, 2015 at 09:47:32AM -0600, Alex Williamson wrote:
> > On Fri, 2015-09-18 at 16:24 +1000, Gavin Shan wrote:
> > > This allows to accept IOMMU group (PE) ID from the parameter from use=
rland
> > > when handling EEH operation so that the operation only affects the ta=
rget
> > > IOMMU group (PE). If the IOMMU group (PE) ID in the parameter from us=
erland
> > > is invalid, all IOMMU groups (PEs) attached to the specified containe=
r are
> > > affected as before.
> > >=20
> > > Gavin Shan (2):
> > >   drivers/vfio: Support EEH API revision
> > >   drivers/vfio: Support IOMMU group for EEH operations
> > >=20
> > >  drivers/vfio/vfio_iommu_spapr_tce.c | 50 +++++++++++++++++++++++++++=
+++++++---
> > >  drivers/vfio/vfio_spapr_eeh.c       | 46 ++++++++++++++++++++++-----=
-------
> > >  include/linux/vfio.h                | 13 +++++++---
> > >  include/uapi/linux/vfio.h           |  6 +++++
> > >  4 files changed, 93 insertions(+), 22 deletions(-)
> >=20
> > This interface is terrible.  A function named foo_enabled() should
> > return a bool, yes or no, don't try to overload it to also return a
> > version.
>=20
> Sorry, that one's my fault.  I suggested that approach to Gavin
> without really thinking it through.
>=20
>=20
> > AFAICT, patch 2/2 breaks current users by changing the offset
> > of the union in struct vfio_eeh_pe_err.
>=20
> Yeah, this one's ugly.  We have to preserve the offset, but that means
> putting the group in a very awkward place.  Especially since I'm not
> sure if there even are any existing users of the single extant union
> branch.
>=20
> Sigh.
>=20
> > Also, we generally pass group
> > file descriptors rather than a group ID because we can prove the
> > ownership of the group through the file descriptor and we don't need to
> > worry about races with the group because we can hold a reference to it.

Duh.  I finally realised the better, simpler, obvious solution.

Rather than changing the parameter structure, we should move the
ioctl()s so they're on the group fd instead of the container fd.

Obviously we need to keep it on the container fd for backwards compat,
but I think we should just error out if there is more than one group
in the container there.

We will need a new capability too, obviously.  VFIO_EEH_GROUPFD maybe?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5UGlQXeG3ziZS81+
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV/2CEAAoJEGw4ysog2bOSsZQQANt/aYGjmn+H5kyLAuh8TY7Z
Wd1QzpLynhB12Ut83/TLtghEf9MRg+IIhCTPlN14BfhbhMlxreFGgqHYW/Ydq9Xt
gok7TtRDso3cmvZV5gsIgKlXHWqG9IBveK/1szVR1cIsGpk5thNkVkKrye4IyP+g
K57eW/2LhAZvQcV9YUTmHCyezQrPDy5CrxV/NrF5b40DVTeenSepEcUaVPntv0Dz
Z5meKCOHicbQt+gqsr/iQZ/l6c9R3A6KUgW4+MGoiJcmjvjTVZ23CnonNbOMinQ7
+J6N2E0FKBYwlaV1It7TLaBYfwLuWi7G/GBp4QFGa9QLTJx/tq5PG8Iu8U7IQ8EV
NWCfvtP3UJbYQmwk20EYgZKLpcgTM1QWPJvTxenODpBVIZijfGm5DcmDBjDdwy9F
tXWWlr4rIcivqzxsX/n/aBmfi1oC0/h2GEJTG3zWgdCmvEyXqSmxsg9ekMkXOUut
7te2pP5n8ZnVADv991RX412I2D/dghTUwdwkibHy+sLVFPegHTZNIikgHeHfFK0x
53in0/CptFVDTiqGLYSyREuSIRLdd0KVMmO6Ei4lUGE8NR+T5qMIkvTPAoddcsMt
ZcMpDozWmsjxxm1P5vPDCNcnRDri9O2Phx5u8vsVrLcPhKmEuOPJOMAnz4tk2J+2
271iiGZuNI7dTc26bmsg
=BWTp
-----END PGP SIGNATURE-----

--5UGlQXeG3ziZS81+--
