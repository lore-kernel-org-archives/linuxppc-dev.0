Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x244.google.com (mail-it0-x244.google.com
 [IPv6:2607:f8b0:4001:c0b::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Jy9P1jrjzF1BP
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 16:32:40 +1000 (AEST)
Received: by mail-it0-x244.google.com with SMTP id 16-v6so10599423itl.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 Jul 2018 23:32:40 -0700 (PDT)
Date: Mon, 2 Jul 2018 16:32:27 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v2 2/2] KVM: PPC: Check if IOMMU page is
 contained in the pinned physical page
Message-ID: <20180702163227.0a4f0ea8@aik.ozlabs.ibm.com>
In-Reply-To: <20180702045243.GX3422@umbus.fritz.box>
References: <20180626055926.27703-1-aik@ozlabs.ru>
 <20180626055926.27703-3-aik@ozlabs.ru>
 <20180629041241.GC3422@umbus.fritz.box>
 <20180629145121.5d03e067@aik.ozlabs.ibm.com>
 <20180629045702.GI3422@umbus.fritz.box>
 <20180629151820.461ae112@aik.ozlabs.ibm.com>
 <20180629170747.471bea35@aik.ozlabs.ibm.com>
 <20180702040852.GW3422@umbus.fritz.box>
 <20180702143244.3a08ebe2@aik.ozlabs.ibm.com>
 <20180702045243.GX3422@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/ochY/qdZg6TbFbV6FV1Paaj"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/ochY/qdZg6TbFbV6FV1Paaj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Jul 2018 14:52:43 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Mon, Jul 02, 2018 at 02:33:30PM +1000, Alexey Kardashevskiy wrote:
> > On Mon, 2 Jul 2018 14:08:52 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >  =20
> > > On Fri, Jun 29, 2018 at 05:07:47PM +1000, Alexey Kardashevskiy wrote:=
 =20
> > > > On Fri, 29 Jun 2018 15:18:20 +1000
> > > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > > >    =20
> > > > > On Fri, 29 Jun 2018 14:57:02 +1000
> > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > >    =20
> > > > > > On Fri, Jun 29, 2018 at 02:51:21PM +1000, Alexey Kardashevskiy =
wrote:     =20
> > > > > > > On Fri, 29 Jun 2018 14:12:41 +1000
> > > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > > >        =20
> > > > > > > > On Tue, Jun 26, 2018 at 03:59:26PM +1000, Alexey Kardashevs=
kiy wrote:       =20
> > > > > > > > > We already have a check in drivers/vfio/vfio_iommu_spapr_=
tce.c that
> > > > > > > > > an IOMMU page is contained in the physical page so the PC=
I hardware won't
> > > > > > > > > get access to unassigned host memory.
> > > > > > > > >=20
> > > > > > > > > However we do not have this check in KVM fastpath (H_PUT_=
TCE accelerated
> > > > > > > > > code) so the user space can pin memory backed with 64k pa=
ges and create
> > > > > > > > > a hardware TCE table with a bigger page size. We were luc=
ky so far and
> > > > > > > > > did not hit this yet as the very first time the mapping h=
appens
> > > > > > > > > we do not have tbl::it_userspace allocated yet and fall b=
ack to
> > > > > > > > > the userspace which in turn calls VFIO IOMMU driver and t=
hat fails
> > > > > > > > > because of the check in vfio_iommu_spapr_tce.c which is r=
eally
> > > > > > > > > sustainable solution.
> > > > > > > > >=20
> > > > > > > > > This stores the smallest preregistered page size in the p=
reregistered
> > > > > > > > > region descriptor and changes the mm_iommu_xxx API to che=
ck this against
> > > > > > > > > the IOMMU page size.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > > > > > > ---
> > > > > > > > > Changes:
> > > > > > > > > v2:
> > > > > > > > > * explicitly check for compound pages before calling comp=
ound_order()
> > > > > > > > >=20
> > > > > > > > > ---
> > > > > > > > > The bug is: run QEMU _without_ hugepages (no -mempath) an=
d tell it to
> > > > > > > > > advertise 16MB pages to the guest; a typical pseries gues=
t will use 16MB
> > > > > > > > > for IOMMU pages without checking the mmu pagesize and thi=
s will fail
> > > > > > > > > at https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/vfi=
o/common.c;h=3Dfb396cf00ac40eb35967a04c9cc798ca896eed57;hb=3Drefs/heads/mas=
ter#l256
> > > > > > > > >=20
> > > > > > > > > With the change, mapping will fail in KVM and the guest w=
ill print:
> > > > > > > > >=20
> > > > > > > > > mlx5_core 0000:00:00.0: ibm,create-pe-dma-window(2027) 0 =
8000000 20000000 18 1f returned 0 (liobn =3D 0x80000001 starting addr =3D 8=
000000 0)
> > > > > > > > > mlx5_core 0000:00:00.0: created tce table LIOBN 0x8000000=
1 for /pci@800000020000000/ethernet@0
> > > > > > > > > mlx5_core 0000:00:00.0: failed to map direct window for
> > > > > > > > > /pci@800000020000000/ethernet@0: -1         =20
> > > > > > > >=20
> > > > > > > > [snip]       =20
> > > > > > > > > @@ -124,7 +125,7 @@ long mm_iommu_get(struct mm_struct *m=
m, unsigned long ua, unsigned long entries,
> > > > > > > > >  		struct mm_iommu_table_group_mem_t **pmem)
> > > > > > > > >  {
> > > > > > > > >  	struct mm_iommu_table_group_mem_t *mem;
> > > > > > > > > -	long i, j, ret =3D 0, locked_entries =3D 0;
> > > > > > > > > +	long i, j, ret =3D 0, locked_entries =3D 0, pageshift;
> > > > > > > > >  	struct page *page =3D NULL;
> > > > > > > > > =20
> > > > > > > > >  	mutex_lock(&mem_list_mutex);
> > > > > > > > > @@ -166,6 +167,8 @@ long mm_iommu_get(struct mm_struct *m=
m, unsigned long ua, unsigned long entries,
> > > > > > > > >  		goto unlock_exit;
> > > > > > > > >  	}
> > > > > > > > > =20
> > > > > > >  > > +	mem->pageshift =3D 30; /* start from 1G pages - the bi=
ggest we have */         =20
> > > > > > > >=20
> > > > > > > > What about 16G pages on an HPT system?       =20
> > > > > > >=20
> > > > > > >=20
> > > > > > > Below in the loop mem->pageshift will reduce to the biggest a=
ctual size
> > > > > > > which will be 16mb/64k/4k. Or remain 1GB if no memory is actu=
ally
> > > > > > > pinned, no loss there.       =20
> > > > > >=20
> > > > > > Are you saying that 16G IOMMU pages aren't supported?  Or that =
there's
> > > > > > some reason a guest can never use them?     =20
> > > > >=20
> > > > >=20
> > > > > ah, 16_G_, not _M_. My bad. I just never tried such huge pages, I=
 will
> > > > > lift the limit up to 64 then, easier this way.   =20
> > > >=20
> > > >=20
> > > > Ah, no, rather this as the upper limit:
> > > >=20
> > > > mem->pageshift =3D ilog2(entries) + PAGE_SHIFT;   =20
> > >=20
> > > I can't make sense of this comment in context.  I see how you're
> > > computing the minimum page size in the reserved region.
> > >=20
> > > My question is about what the  is - the starting
> > > value from which you calculate.  Currently it's 1G, but I can't
> > > immediately see a reason that 16G is impossible here. =20
> >=20
> >=20
> > 16GB is impossible if the chunk we are preregistering here is smaller
> > than that, for example, the entire guest ram is 4GB. =20
>=20
> Of course.  Just like it was for 1GiB if you had a 512MiB guest, for
> example.  I'm talking about a case where you have a guest that's
> >=3D16GiB and you *have* allocated 16GiB hugepages to back it. =20


Then, assuming we are preregistering entire RAM as a single chunk, the
"maximum minimum" will be initialized as ">=3D16GiB" (but floor-aligned
to power of two) before the pinning loop and then reduce to the actual
page size, inside the loop. I feel like I am missing something in the
question, what is that?




--
Alexey

--Sig_/ochY/qdZg6TbFbV6FV1Paaj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECIb1sawlPgRl/px9ze7KtGKK020FAls5xvsACgkQze7KtGKK
021rUxAAnFAV+MIHXAxCUxd6Hu2fSUkIwQNgl2XuKeabpm8+LZsPUWf874OV2nF+
yBNMZJtt1B9u99C0cAcwbG0z3dWBBq4/KpR90ezQ19CTfwewtKVuPnZ5/ZcOHJPg
pgWlTjDd412sYojW9/NA/TIFOljpDiCpB2lQ+3lYjgrC2Zg33aICgraGsKWRT00R
2MAaseAcEWYMtsq+rcYdMSc9SWvXNt3FPoa1reWA9N5w56C/yMBOFogL018mpF//
Oc+oQkpR0/xFS57m/zClXZep0gj5C/yjR2yXJ1gYFup5scHOivjGeNEnlxe15mOY
A/u6ZgaQnzORWo/owzDWoHuVymfJwbpRewi2uoFAnOqdP/3xLczOHHHzRmYRpHqC
iZ/XffQh8rBpSwqeMLLkqJybaLyM6S50CUkaFl9doGe4ORn5Kehx+PO57i1PZxsy
/6w8Fc3Ud5VXtBv8rH+GkCJuu6kTixaB6qy37lY7/PshglVAz8+fShr6FfZ22ADb
g1Ywx4bh9v5OCfJpSJ91+hFtGHrJh+lgRI/Mv5Zk/KF+8azvUEyL+3xRN4vj9lkJ
wxsfBA5Du3ORQCgDhtCzhe25A62rFK6+2/4WO6gih055jddpbqUSqwHYEdyiOyBl
aGJrcKKFuc4Sj3h0D0/3sGDhAVUU4/2bxNQDfBvsottlpaVvXwI=
=ucqg
-----END PGP SIGNATURE-----

--Sig_/ochY/qdZg6TbFbV6FV1Paaj--
