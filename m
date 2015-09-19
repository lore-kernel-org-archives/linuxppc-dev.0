Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9F531A0484
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 16:28:11 +1000 (AEST)
Date: Sat, 19 Sep 2015 16:22:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 0/2] VFIO: Accept IOMMU group (PE) ID
Message-ID: <20150919062247.GC29031@voom.redhat.com>
References: <1442557469-22185-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1442591252.23936.254.camel@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="H8ygTp4AXg6deix2"
In-Reply-To: <1442591252.23936.254.camel@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--H8ygTp4AXg6deix2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2015 at 09:47:32AM -0600, Alex Williamson wrote:
> On Fri, 2015-09-18 at 16:24 +1000, Gavin Shan wrote:
> > This allows to accept IOMMU group (PE) ID from the parameter from userl=
and
> > when handling EEH operation so that the operation only affects the targ=
et
> > IOMMU group (PE). If the IOMMU group (PE) ID in the parameter from user=
land
> > is invalid, all IOMMU groups (PEs) attached to the specified container =
are
> > affected as before.
> >=20
> > Gavin Shan (2):
> >   drivers/vfio: Support EEH API revision
> >   drivers/vfio: Support IOMMU group for EEH operations
> >=20
> >  drivers/vfio/vfio_iommu_spapr_tce.c | 50 +++++++++++++++++++++++++++++=
+++++---
> >  drivers/vfio/vfio_spapr_eeh.c       | 46 ++++++++++++++++++++++-------=
-----
> >  include/linux/vfio.h                | 13 +++++++---
> >  include/uapi/linux/vfio.h           |  6 +++++
> >  4 files changed, 93 insertions(+), 22 deletions(-)
>=20
> This interface is terrible.  A function named foo_enabled() should
> return a bool, yes or no, don't try to overload it to also return a
> version.

Sorry, that one's my fault.  I suggested that approach to Gavin
without really thinking it through.


> AFAICT, patch 2/2 breaks current users by changing the offset
> of the union in struct vfio_eeh_pe_err.

Yeah, this one's ugly.  We have to preserve the offset, but that means
putting the group in a very awkward place.  Especially since I'm not
sure if there even are any existing users of the single extant union
branch.

Sigh.

> Also, we generally pass group
> file descriptors rather than a group ID because we can prove the
> ownership of the group through the file descriptor and we don't need to
> worry about races with the group because we can hold a reference to it.
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--H8ygTp4AXg6deix2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJV/P83AAoJEGw4ysog2bOSoPsP/RPFMD+dHEabFGLTUisAVC3y
aH+nwEkiCIyNr1JIcDetmWoykA9h7GP8OYbEv2JGH4sp9x1jMnzh5emKzaDF44Kb
YHNY48GtOhGzw9JZ2+hNcRM59U315f3hiiQp4xocPd5/0/56VZ8Eq6C/MY4XCzW2
yTCG1OIlW6rED9mlak+WYPDAZnxf6POSGVZKmP7umJTleqFeHVOd1wuUbPCern4X
APOs410y0ramSfvb+dKX+Diw/jzu0qkVD5dU9VW7Im57pa/1qjARKt9w+HIGXKA3
SvSCJ+peHhailW9idam/ZGs1TpvaOV4/zQpMoBelK9RJPjf5sfFDSprMM/uxT3Fh
kv9L/e/hHAtt7um/y01aLOJHdsSitScEhpQDyw4aKoCSFHtVRX/9oevtlN3RIGWy
WXDXmxLLFRd3ZO3S9wTa+HlcN/xaS2+tPdUgsFSWE8vu8ktJ8aEIfe85Y6D/X6+e
2PIwd54Ll4RjGQfAr2fuJKYRqNzelfKfefp82PEPxrrKXImaZEiwENrW7cFYafVT
Aj4GoBwpvaBRLieHtArGC9GYqSkKf0476+1WrR/nnWPW4CVlUJt04uI4J45/3s4/
vbvU75xsSu+kKxCSXPfhXZPyCZd5WLxnM+Eg1KwLnjraRcZhj8T9Fl56AI10y5Xp
E5sozpFDS5SCHoAdE0UK
=lCgd
-----END PGP SIGNATURE-----

--H8ygTp4AXg6deix2--
