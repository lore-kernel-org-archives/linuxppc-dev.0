Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sCYkq6lKqzDr3R
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 21:52:19 +1000 (AEST)
Date: Mon, 15 Aug 2016 21:07:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH kernel 14/15] vfio/spapr_tce: Export container API for
 external users
Message-ID: <20160815110708.GC27484@voom.fritz.box>
References: <1470213656-1042-1-git-send-email-aik@ozlabs.ru>
 <1470213656-1042-15-git-send-email-aik@ozlabs.ru>
 <20160808104315.77cf22ec@t450s.home>
 <f338a1d3-438a-9004-9645-87a16b9baf79@ozlabs.ru>
 <20160809061630.50ed5536@t450s.home>
 <4d1ea52b-ecb5-5f9b-6cdc-00a73677cc2f@ozlabs.ru>
 <20160810104630.21ab4bc5@t450s.home>
 <20160812054601.GS16493@voom.fritz.box>
 <a80d4f1d-ab5b-6a31-07b1-4be92d0af7bc@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
In-Reply-To: <a80d4f1d-ab5b-6a31-07b1-4be92d0af7bc@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2016 at 04:12:17PM +1000, Alexey Kardashevskiy wrote:
> On 12/08/16 15:46, David Gibson wrote:
> > On Wed, Aug 10, 2016 at 10:46:30AM -0600, Alex Williamson wrote:
> >> On Wed, 10 Aug 2016 15:37:17 +1000
> >> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>
> >>> On 09/08/16 22:16, Alex Williamson wrote:
> >>>> On Tue, 9 Aug 2016 15:19:39 +1000
> >>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>  =20
> >>>>> On 09/08/16 02:43, Alex Williamson wrote: =20
> >>>>>> On Wed,  3 Aug 2016 18:40:55 +1000
> >>>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> >>>>>>    =20
> >>>>>>> This exports helpers which are needed to keep a VFIO container in
> >>>>>>> memory while there are external users such as KVM.
> >>>>>>>
> >>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >>>>>>> ---
> >>>>>>>  drivers/vfio/vfio.c                 | 30 +++++++++++++++++++++++=
+++++++
> >>>>>>>  drivers/vfio/vfio_iommu_spapr_tce.c | 16 +++++++++++++++-
> >>>>>>>  include/linux/vfio.h                |  6 ++++++
> >>>>>>>  3 files changed, 51 insertions(+), 1 deletion(-)
> >>>>>>>
> >>>>>>> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> >>>>>>> index d1d70e0..baf6a9c 100644
> >>>>>>> --- a/drivers/vfio/vfio.c
> >>>>>>> +++ b/drivers/vfio/vfio.c
> >>>>>>> @@ -1729,6 +1729,36 @@ long vfio_external_check_extension(struct =
vfio_group *group, unsigned long arg)
> >>>>>>>  EXPORT_SYMBOL_GPL(vfio_external_check_extension);
> >>>>>>> =20
> >>>>>>>  /**
> >>>>>>> + * External user API for containers, exported by symbols to be l=
inked
> >>>>>>> + * dynamically.
> >>>>>>> + *
> >>>>>>> + */
> >>>>>>> +struct vfio_container *vfio_container_get_ext(struct file *filep)
> >>>>>>> +{
> >>>>>>> +	struct vfio_container *container =3D filep->private_data;
> >>>>>>> +
> >>>>>>> +	if (filep->f_op !=3D &vfio_fops)
> >>>>>>> +		return ERR_PTR(-EINVAL);
> >>>>>>> +
> >>>>>>> +	vfio_container_get(container);
> >>>>>>> +
> >>>>>>> +	return container;
> >>>>>>> +}
> >>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_get_ext);
> >>>>>>> +
> >>>>>>> +void vfio_container_put_ext(struct vfio_container *container)
> >>>>>>> +{
> >>>>>>> +	vfio_container_put(container);
> >>>>>>> +}
> >>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_put_ext);
> >>>>>>> +
> >>>>>>> +void *vfio_container_get_iommu_data_ext(struct vfio_container *c=
ontainer)
> >>>>>>> +{
> >>>>>>> +	return container->iommu_data;
> >>>>>>> +}
> >>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_get_iommu_data_ext);
> >>>>>>> +
> >>>>>>> +/**
> >>>>>>>   * Sub-module support
> >>>>>>>   */
> >>>>>>>  /*
> >>>>>>> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/v=
fio_iommu_spapr_tce.c
> >>>>>>> index 3594ad3..fceea3d 100644
> >>>>>>> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>>>>> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> >>>>>>> @@ -1331,6 +1331,21 @@ const struct vfio_iommu_driver_ops tce_iom=
mu_driver_ops =3D {
> >>>>>>>  	.detach_group	=3D tce_iommu_detach_group,
> >>>>>>>  };
> >>>>>>> =20
> >>>>>>> +struct iommu_table *vfio_container_spapr_tce_table_get_ext(void =
*iommu_data,
> >>>>>>> +		u64 offset)
> >>>>>>> +{
> >>>>>>> +	struct tce_container *container =3D iommu_data;
> >>>>>>> +	struct iommu_table *tbl =3D NULL;
> >>>>>>> +
> >>>>>>> +	if (tce_iommu_find_table(container, offset, &tbl) < 0)
> >>>>>>> +		return NULL;
> >>>>>>> +
> >>>>>>> +	iommu_table_get(tbl);
> >>>>>>> +
> >>>>>>> +	return tbl;
> >>>>>>> +}
> >>>>>>> +EXPORT_SYMBOL_GPL(vfio_container_spapr_tce_table_get_ext);
> >>>>>>> +
> >>>>>>>  static int __init tce_iommu_init(void)
> >>>>>>>  {
> >>>>>>>  	return vfio_register_iommu_driver(&tce_iommu_driver_ops);
> >>>>>>> @@ -1348,4 +1363,3 @@ MODULE_VERSION(DRIVER_VERSION);
> >>>>>>>  MODULE_LICENSE("GPL v2");
> >>>>>>>  MODULE_AUTHOR(DRIVER_AUTHOR);
> >>>>>>>  MODULE_DESCRIPTION(DRIVER_DESC);
> >>>>>>> -
> >>>>>>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> >>>>>>> index 0ecae0b..1c2138a 100644
> >>>>>>> --- a/include/linux/vfio.h
> >>>>>>> +++ b/include/linux/vfio.h
> >>>>>>> @@ -91,6 +91,12 @@ extern void vfio_group_put_external_user(struc=
t vfio_group *group);
> >>>>>>>  extern int vfio_external_user_iommu_id(struct vfio_group *group);
> >>>>>>>  extern long vfio_external_check_extension(struct vfio_group *gro=
up,
> >>>>>>>  					  unsigned long arg);
> >>>>>>> +extern struct vfio_container *vfio_container_get_ext(struct file=
 *filep);
> >>>>>>> +extern void vfio_container_put_ext(struct vfio_container *contai=
ner);
> >>>>>>> +extern void *vfio_container_get_iommu_data_ext(
> >>>>>>> +		struct vfio_container *container);
> >>>>>>> +extern struct iommu_table *vfio_container_spapr_tce_table_get_ex=
t(
> >>>>>>> +		void *iommu_data, u64 offset);
> >>>>>>> =20
> >>>>>>>  /*
> >>>>>>>   * Sub-module helpers   =20
> >>>>>>
> >>>>>>
> >>>>>> I think you need to take a closer look of the lifecycle of a conta=
iner,
> >>>>>> having a reference means the container itself won't go away, but o=
nly
> >>>>>> having a group set within that container holds the actual IOMMU
> >>>>>> references.  container->iommu_data is going to be NULL once the
> >>>>>> groups are lost.  Thanks,   =20
> >>>>>
> >>>>>
> >>>>> Container owns the iommu tables and this is what I care about here,=
 groups
> >>>>> attached or not - this is handled separately via IOMMU group list i=
n a
> >>>>> specific iommu_table struct, these groups get detached from iommu_t=
able
> >>>>> when they are removed from a container. =20
> >>>>
> >>>> The container doesn't own anything, the container is privileged by t=
he
> >>>> groups being attached to it.  When groups are closed, they detach fr=
om
> >>>> the container and once the container group list is empty the iommu
> >>>> backend is released and iommu_data is NULL.  A container reference
> >>>> doesn't give you what you're looking for.  It implies nothing about =
the
> >>>> iommu backend. =20
> >>>
> >>>
> >>> Well. Backend is a part of a container and since a backend owns table=
s, a
> >>> container owns them too.
> >>
> >> The IOMMU backend is accessed through the container, but that backend
> >> is privileged by the groups it contains.  Once those groups are gone,
> >> the IOMMU backend is released, regardless of whatever reference you
> >> have to the container itself such as you're attempting to do here.  In
> >> that sense, the container does not own those tables.
> >=20
> > So, the thing is that what KVM fundamentally needs is a handle on the
> > container.  KVM is essentially modelling the DMA address space of a
> > single guest bus, and the container is what's attached to that.
> >=20
> > The first part of the problem is that KVM wants to basically invoke
> > vfio_dma_map() operations without bouncing via qemu.  Because
> > vfio_dma_map() works on the container level, that's the handle that
> > KVM needs to hold.
>=20
>=20
> Well, I do not need to hold the reference to the container all the time, I
> just need it to get to the IOMMU backend, get+reference an iommu_table fr=
om
> it, referencing here helps to make sure the backend is not going away
> before we reference iommu_table.

Yes, but I don't see a compelling reason *not* to hold the container
reference either - it seems like principle of least surprise would
suggest retaining the reference.

For example, I can imagine having a container reset call which threw
away the back end iommu table and created a new one.  It seems like
what you'd expect in this case is for the guest bus to remain bound to
the same container, not to the now stale iommu table.

> After that I only keep a reference to the container to know if/when I can
> release a particular iommu_table. This is can workaround by counting how
> many groups were attached to this particular KVM-spapt-tce-table and
> looking at the IOMMU group list attached to an iommu_table - if the list =
is
> empty, decrement the iommu_table reference counter and that's it, no extra
> references to a VFIO container.
>=20
> Or I need an alternative way of getting iommu_table's, i.e. QEMU should
> somehow tell KVM that this LIOBN is this VFIO container fd (easy - can be
> done via region_add/region_del interface)

Um.. yes.. that's what I was expecting, I thought that was what you
were doing.x

> or VFIO IOMMU group fd(s) (more
> tricky as this needs to be done from more places - vfio-pci hotplug/unplu=
g,
> window add/remove).

More tricky and also wrong.  Again, having one group but not the whole
container bound to the guest LIOBN doesn't make any sense - by
definition, all the devices in the container should share the same DMA
address space.

> > The second part of the problem is that in order to reduce overhead
> > further, we want to operate in real mode, which means bypassing most
> > of the usual VFIO structure and going directly(ish) from the KVM
> > hcall emulation to the IOMMU backend behind VFIO.  This complicates
> > matters a fair bit.  Because it is, explicitly, a performance hack,
> > some degree of ugliness is probably inevitable.
> >=20
> > Alexey - actually implementing this in two stages might make this
> > clearer.  The first stage wouldn't allow real mode, and would call
> > through the same vfio_dma_map() path as qemu calls through now.  The
> > second stage would then put in place the necessary hacks to add real
> > mode support.
> >=20
> >>> The problem I am trying to solve here is when KVM may release the
> >>> iommu_table objects.
> >>>
> >>> "Set" ioctl() to KVM-spapr-tce-table (or KVM itself, does not really
> >>> matter) makes a link between KVM-spapr-tce-table and container and KV=
M can
> >>> start using tables (with referencing them).
> >>>
> >>> First I tried adding an "unset" ioctl to KVM-spapr-tce-table, called =
it
> >>> from region_del() and this works if QEMU removes a window. However if=
 QEMU
> >>> removes a vfio-pci device, region_del() is not called and KVM does no=
t get
> >>> notified that it can release the iommu_table's because the
> >>> KVM-spapr-tce-table remains alive and does not get destroyed (as it is
> >>> still used by emulated devices or other containers).
> >>>
> >>> So it was suggested that we could do such "unset" somehow later assum=
ing,
> >>> for example, on every "set" I could check if some of currently attach=
ed
> >>> containers are no more used - and this is where being able to know if=
 there
> >>> is no backend helps - KVM remembers a container pointer and can check=
 this
> >>> via vfio_container_get_iommu_data_ext().
> >>>
> >>> The other option would be changing vfio_container_get_ext() to take a
> >>> callback+opaque which container would call when it destroys iommu_dat=
a.
> >>> This looks more intrusive and not very intuitive how to make it right=
 -
> >>> container would have to keep track of all registered external users a=
nd
> >>> vfio_container_put_ext() would have to pass the same callback+opaque =
to
> >>> unregister the exact external user.
> >>
> >> I'm not in favor of anything resembling the code above or extensions
> >> beyond it, the container is the wrong place to do this.
> >>
> >>> Or I could store container file* in KVM. Then iommu_data would never =
be
> >>> released until KVM-spapr-tce-table is destroyed.
> >>
> >> See above, holding a file pointer to the container doesn't do squat.
> >> The groups that are held by the container empower the IOMMU backend,
> >> references to the container itself don't matter.  Those references will
> >> not maintain the IOMMU data.
> >> =20
> >>> Recreating KVM-spapr-tce-table on every vfio-pci hotunplug (closing i=
ts fd
> >>> would "unset" container from KVM-spapr-tce-table) is not an option as=
 there
> >>> still may be devices using this KVM-spapr-tce-table.
> >>>
> >>> What obvious and nice solution am I missing here? Thanks.
> >>
> >> The interactions with the IOMMU backend that seem relevant are
> >> vfio_iommu_drivers_ops.{detach_group,release}.  The kvm-vfio pseudo
> >> device is also used to tell kvm about groups as they come and go and
> >> has a way to check extensions, and thus properties of the IOMMU
> >> backend.  All of these are available for your {ab}use.  Thanks,
> >=20
> > So, Alexey started trying to do this via the KVM-VFIO device, but it's
> > a really bad fit.  As noted above, fundamentally it's a container we
> > need to attach to the kvm-spapr-tce-table object, since what that
> > represents is a guest bus DMA address space, and by definition all the
> > groups in a container must have the same DMA address space.
>=20
>=20
> Well, in a bad case a LIOBN/kvm-spapr-tce-table has multiple containers
> attached so it is not 1:1...

I never said it was.  It's n:1, but it's *not* n:m.  You can have
multiple containers to a LIOBN, but never multiple LIOBNs ot a
container.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXsaJcAAoJEGw4ysog2bOSslwQAIpUD1lp8ZJzB7xLQgz8q+/g
mu6sTSDdvxU3Dg9spBPuQoFrMfCWPGOa3N9ASBxKGYBBfMRWOfR00+DV9Bu86tdQ
e3PaBQVSMLTIAHeMRxQRww3ZCr2uLFvPhBzWVQn+FQg/Fe2iLintfyThzPFz7sZj
ajFtkLOzAO+0OygrpoFtX5qipJkk0buPXW1IXlRFNICSrAL6nVrsM7MU9QR0ityG
I1curLemvs1ZGupVNhNMNhvCExRvA/U8XXDP4jF9aIk7JtAgHmBqJPQkfh9IrNHL
W/G7eMFGQwdm9mCjElvtrwpgPXFoq2dEpd8wsieDqnvRNrgMMXEMJTNw/fr6XihO
HbcqXAsWvfHLrNaZBcZCdgsgC7uK4kTat6Q8xF43c3BC1PNIQcaqz0ZOX2D8nDJ2
TCcUnmmyT43Qfxu8SinbZAtPVxt+SZ0CHfh1WL4uTO3nMfUDHhNtrg2FJHcX7U+q
6ZN3h7HHlg3O2H5vLjISVWhb79/8LQdof9Ql5hHTXagQismSFlYr0NNg5sgLi7Vr
eZUFCSCacT+Qt0aqxXN5+6GGJQ9GWE2vidNPiPKmhASXoCztAlNAM3Pb9mLClO1R
+Khc1Xk3GpLjPezTEG1GREeGPOvzepliEtfqspaqQZJGBRwn/qsBjGudkdUMIiei
MYR76CWLp0fgWDk3UcbQ
=AkhP
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
