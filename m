Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x241.google.com (mail-it0-x241.google.com
 [IPv6:2607:f8b0:4001:c0b::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H75k5tZNzF1RT
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 17:08:10 +1000 (AEST)
Received: by mail-it0-x241.google.com with SMTP id a195-v6so1483761itd.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 00:08:10 -0700 (PDT)
Date: Fri, 29 Jun 2018 17:07:47 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v2 2/2] KVM: PPC: Check if IOMMU page is
 contained in the pinned physical page
Message-ID: <20180629170747.471bea35@aik.ozlabs.ibm.com>
In-Reply-To: <20180629151820.461ae112@aik.ozlabs.ibm.com>
References: <20180626055926.27703-1-aik@ozlabs.ru>
 <20180626055926.27703-3-aik@ozlabs.ru>
 <20180629041241.GC3422@umbus.fritz.box>
 <20180629145121.5d03e067@aik.ozlabs.ibm.com>
 <20180629045702.GI3422@umbus.fritz.box>
 <20180629151820.461ae112@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/hGI8wVS8s4_mjGla=aLBSJH"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/hGI8wVS8s4_mjGla=aLBSJH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Jun 2018 15:18:20 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On Fri, 29 Jun 2018 14:57:02 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Jun 29, 2018 at 02:51:21PM +1000, Alexey Kardashevskiy wrote: =
=20
> > > On Fri, 29 Jun 2018 14:12:41 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >    =20
> > > > On Tue, Jun 26, 2018 at 03:59:26PM +1000, Alexey Kardashevskiy wrot=
e:   =20
> > > > > We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c th=
at
> > > > > an IOMMU page is contained in the physical page so the PCI hardwa=
re won't
> > > > > get access to unassigned host memory.
> > > > >=20
> > > > > However we do not have this check in KVM fastpath (H_PUT_TCE acce=
lerated
> > > > > code) so the user space can pin memory backed with 64k pages and =
create
> > > > > a hardware TCE table with a bigger page size. We were lucky so fa=
r and
> > > > > did not hit this yet as the very first time the mapping happens
> > > > > we do not have tbl::it_userspace allocated yet and fall back to
> > > > > the userspace which in turn calls VFIO IOMMU driver and that fails
> > > > > because of the check in vfio_iommu_spapr_tce.c which is really
> > > > > sustainable solution.
> > > > >=20
> > > > > This stores the smallest preregistered page size in the preregist=
ered
> > > > > region descriptor and changes the mm_iommu_xxx API to check this =
against
> > > > > the IOMMU page size.
> > > > >=20
> > > > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > > ---
> > > > > Changes:
> > > > > v2:
> > > > > * explicitly check for compound pages before calling compound_ord=
er()
> > > > >=20
> > > > > ---
> > > > > The bug is: run QEMU _without_ hugepages (no -mempath) and tell i=
t to
> > > > > advertise 16MB pages to the guest; a typical pseries guest will u=
se 16MB
> > > > > for IOMMU pages without checking the mmu pagesize and this will f=
ail
> > > > > at https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/vfio/common=
.c;h=3Dfb396cf00ac40eb35967a04c9cc798ca896eed57;hb=3Drefs/heads/master#l256
> > > > >=20
> > > > > With the change, mapping will fail in KVM and the guest will prin=
t:
> > > > >=20
> > > > > mlx5_core 0000:00:00.0: ibm,create-pe-dma-window(2027) 0 8000000 =
20000000 18 1f returned 0 (liobn =3D 0x80000001 starting addr =3D 8000000 0)
> > > > > mlx5_core 0000:00:00.0: created tce table LIOBN 0x80000001 for /p=
ci@800000020000000/ethernet@0
> > > > > mlx5_core 0000:00:00.0: failed to map direct window for
> > > > > /pci@800000020000000/ethernet@0: -1     =20
> > > >=20
> > > > [snip]   =20
> > > > > @@ -124,7 +125,7 @@ long mm_iommu_get(struct mm_struct *mm, unsig=
ned long ua, unsigned long entries,
> > > > >  		struct mm_iommu_table_group_mem_t **pmem)
> > > > >  {
> > > > >  	struct mm_iommu_table_group_mem_t *mem;
> > > > > -	long i, j, ret =3D 0, locked_entries =3D 0;
> > > > > +	long i, j, ret =3D 0, locked_entries =3D 0, pageshift;
> > > > >  	struct page *page =3D NULL;
> > > > > =20
> > > > >  	mutex_lock(&mem_list_mutex);
> > > > > @@ -166,6 +167,8 @@ long mm_iommu_get(struct mm_struct *mm, unsig=
ned long ua, unsigned long entries,
> > > > >  		goto unlock_exit;
> > > > >  	}
> > > > > =20
> > >  > > +	mem->pageshift =3D 30; /* start from 1G pages - the biggest we=
 have */     =20
> > > >=20
> > > > What about 16G pages on an HPT system?   =20
> > >=20
> > >=20
> > > Below in the loop mem->pageshift will reduce to the biggest actual si=
ze
> > > which will be 16mb/64k/4k. Or remain 1GB if no memory is actually
> > > pinned, no loss there.   =20
> >=20
> > Are you saying that 16G IOMMU pages aren't supported?  Or that there's
> > some reason a guest can never use them? =20
>=20
>=20
> ah, 16_G_, not _M_. My bad. I just never tried such huge pages, I will
> lift the limit up to 64 then, easier this way.


Ah, no, rather this as the upper limit:

mem->pageshift =3D ilog2(entries) + PAGE_SHIFT;


@entries here is a number of system pages being pinned in that
function.



>=20
> >  =20
> > > > >  	for (i =3D 0; i < entries; ++i) {
> > > > >  		if (1 !=3D get_user_pages_fast(ua + (i << PAGE_SHIFT),
> > > > >  					1/* pages */, 1/* iswrite */, &page)) {
> > > > > @@ -199,6 +202,11 @@ long mm_iommu_get(struct mm_struct *mm, unsi=
gned long ua, unsigned long entries,
> > > > >  			}
> > > > >  		}
> > > > >  populate:
> > > > > +		pageshift =3D PAGE_SHIFT;
> > > > > +		if (PageCompound(page))
> > > > > +			pageshift +=3D compound_order(compound_head(page));
> > > > > +		mem->pageshift =3D min_t(unsigned int, mem->pageshift, pageshi=
ft);     =20
> > > >=20
> > > > Why not make mem->pageshift and pageshift local the same type to av=
oid
> > > > the min_t() ?   =20
> > >=20
> > > I was under impression min() is deprecated (misinterpret checkpatch.pl
> > > may be) and therefore did not pay attention to it. I can fix this and
> > > repost if there is no other question.   =20
> >=20
> > Hm, it's possible. =20
>=20
> Nah, tried min(), compiles fine.



--
Alexey

--Sig_/hGI8wVS8s4_mjGla=aLBSJH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECIb1sawlPgRl/px9ze7KtGKK020FAls12sMACgkQze7KtGKK
023tCw/6A8ouuQ8IK7MBx4OQsDSlzyTbVh8F5KEBXWonwSiA5saab4QUVb4KTx3S
s1usBhBNc9yJ3llKeGcgTZQoY1jux9pcysXKrbmKrmT7ONsZ4FlBh2rtO57A3/kn
/pjASycvd9aj7IYNjz4WE4H92nNvugirKOujopj12ao5tz81uN3pSQRKBw8jNAzh
I0rX0wlo+mpCvGYPyM+RQiHbOuFydaQkj7vP/5U7E64aXVJJ1UoPZjjvNdmY9ECd
CBP8KIlHGWwYT7z1mn13aC/WO9d7kcSRoHsOqP4hT2pDXU8fi/Hbb/fC8I/SGZIO
PDeSQ4S17u3Z+1aSgWiSm+vhdPm8DW8mT2dYdYK6KpoYuYAxXP4UAlAWdJbDHgrt
NdTxPaF4NSAexkIlFqPpOZkS6YcSaM3BMYQx3jhZn5gJ52IonnUFVR1Z8/Wy2Rge
KUaE1KL7x6dji8ZuwSpOlMYKCLUsp4VySZK97nRHudyhUHl2Wh0bXyzhehVIhWou
Sp0bkC4CNqX4XuRfeZ2wgYVvbC8QKiqkfcvjXPcx1PDe2bqs0RZeqVphrR6pZZPT
qWcFmX6dkzWSE6qADKdyHJtgVmx/K0by/vXunZtgv6zKPkchYnRzVYxh74jkPW0K
+bXT2BoroFZ8HDfyTpM8D3K/gXxBB2xkQ5nOSZUp4dhBc3kqzCM=
=Luig
-----END PGP SIGNATURE-----

--Sig_/hGI8wVS8s4_mjGla=aLBSJH--
