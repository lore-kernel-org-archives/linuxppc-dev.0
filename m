Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkF1t5ctlzDqYb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 14:53:22 +1100 (AEDT)
Date: Thu, 16 Mar 2017 14:42:40 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v8 10/10] KVM: PPC: VFIO: Add in-kernel
 acceleration for VFIO
Message-ID: <20170316034240.GA12402@umbus.fritz.box>
References: <20170310035337.22091-1-aik@ozlabs.ru>
 <20170310035337.22091-11-aik@ozlabs.ru>
 <20170314150527.1c46c3c8@t450s.home>
 <20170315044014.GA12603@umbus.fritz.box>
 <20170315101812.38946ca9@t450s.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
In-Reply-To: <20170315101812.38946ca9@t450s.home>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2017 at 10:18:18AM -0600, Alex Williamson wrote:
> On Wed, 15 Mar 2017 15:40:14 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/bo=
ok3s_64_vio.c
> > > > index e96a4590464c..be18cda01e1b 100644
> > > > --- a/arch/powerpc/kvm/book3s_64_vio.c
> > > > +++ b/arch/powerpc/kvm/book3s_64_vio.c
> > > > @@ -28,6 +28,10 @@
> > > >  #include <linux/hugetlb.h>
> > > >  #include <linux/list.h>
> > > >  #include <linux/anon_inodes.h>
> > > > +#include <linux/iommu.h>
> > > > +#include <linux/file.h>
> > > > +#include <linux/vfio.h>
> > > > +#include <linux/module.h>
> > > > =20
> > > >  #include <asm/tlbflush.h>
> > > >  #include <asm/kvm_ppc.h>
> > > > @@ -40,6 +44,36 @@
> > > >  #include <asm/udbg.h>
> > > >  #include <asm/iommu.h>
> > > >  #include <asm/tce.h>
> > > > +#include <asm/mmu_context.h>
> > > > +
> > > > +static void kvm_vfio_group_put_external_user(struct vfio_group *vf=
io_group)
> > > > +{
> > > > +	void (*fn)(struct vfio_group *);
> > > > +
> > > > +	fn =3D symbol_get(vfio_group_put_external_user);
> > > > +	if (WARN_ON(!fn))
> > > > +		return;
> > > > +
> > > > +	fn(vfio_group);
> > > > +
> > > > +	symbol_put(vfio_group_put_external_user);
> > > > +}
> > > > +
> > > > +static int kvm_vfio_external_user_iommu_id(struct vfio_group *vfio=
_group)
> > > > +{
> > > > +	int (*fn)(struct vfio_group *);
> > > > +	int ret =3D -1;
> > > > +
> > > > +	fn =3D symbol_get(vfio_external_user_iommu_id);
> > > > +	if (!fn)
> > > > +		return ret;
> > > > +
> > > > +	ret =3D fn(vfio_group);
> > > > +
> > > > +	symbol_put(vfio_external_user_iommu_id);
> > > > +
> > > > +	return ret;
> > > > +} =20
> > >=20
> > >=20
> > > Ugh.  This feels so wrong.  Why can't you have kvm-vfio pass the
> > > iommu_group?  Why do you need to hold this additional vfio_group
> > > reference? =20
> >=20
> > Keeping the vfio_group reference makes sense to me, since we don't
> > want the vfio context for the group to go away while it's attached to
> > the LIOBN.
>=20
> But there's already a reference for that, it's taken by
> KVM_DEV_VFIO_GROUP_ADD and held until KVM_DEV_VFIO_GROUP_DEL.  Both the
> DEL path and the cleanup path call kvm_spapr_tce_release_iommu_group()
> before releasing that reference, so it seems entirely redundant.

Oh, good point.  And we already verify that the group has been ADDed
before setting the LIOBN association.

> > However, going via the iommu_id rather than just having an interface
> > to directly grab the iommu group from the vfio_group seems bizarre to
> > me.  I'm ok with cleaning that up later, however.
>=20
> We have kvm_spapr_tce_attach_iommu_group() and
> kvm_spapr_tce_release_iommu_group(), but both take a vfio_group, not an
> iommu_group as a parameter.  I don't particularly have a problem with
> the vfio_group -> iommu ID -> iommu_group, but if we drop the extra
> vfio_group reference and pass the iommu_group itself to these functions
> then we can keep all the symbol reference stuff in the kvm-vfio glue
> layer.  Thanks,

Makes sense.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYygmwAAoJEGw4ysog2bOSPMUP/jfL7ANN3QoNZLiSVV2stxm6
wSOrEhxr2iYNMBZYBV980dZJ9n/9F95uReNjiR8JfS6P+X24Fwh5ZCJGn1SW3P+H
8ZP5kpnJQRt60OMKdXVTR1wh5MLIgFkgT9jsIX4tFrOgz5lfk16F0dZlWJ9LtNgl
M3M9Ee8NjPIE+479HwtWjjMpML3n6wNJhPKKAjmz5fxXSHJcZZ/wTJvOY7R3ML3q
xBlv45c7rQpTNncXXo0m/Vhl0yCOCyjFqkpHX8dZQwSS37fYM+tYAmu8SPg6is+x
nD2nX4/n9Dpv1d4zbxeC2zOnEvYFxu56KG/EYZMs6yOsUOjNbJbJtXiUzJC+CUJe
695q/uveVWPmmdrrFUzF8ecMoG2MkC9171jcI1DkrNQZbfVgaYDyZuLwcj8+WRKn
p24SiNJsi8Mjo3o4EMaW/c7VtGk/5CQ+xOBJgIcMreC0YUEfkBo62euz++v2CcXy
lC4dZGLS9ly0T6qZPyxVtB1qSoZ0nmpWknM4OQlwA6wkSFidzlmy5u1+88B0YvPR
qIZsPpK+gQ+zapgW/AD1AxpUgjWEpEJ19hp5nlnVvOMFXFKdU4FHWKFPLLhG6asL
Z/6AhG6kcOxB0NqUhDZgdGF6ePOvyT/wmvZHmZmpxmaN6qUb/bG3mlyJU4jsMWRZ
q2xOzQdfoaRy7MYXkRJK
=2edT
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
