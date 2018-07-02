Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Jw0y0vlHzF1D8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 14:55:14 +1000 (AEST)
Date: Mon, 2 Jul 2018 14:52:43 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v2 2/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180702045243.GX3422@umbus.fritz.box>
References: <20180626055926.27703-1-aik@ozlabs.ru>
 <20180626055926.27703-3-aik@ozlabs.ru>
 <20180629041241.GC3422@umbus.fritz.box>
 <20180629145121.5d03e067@aik.ozlabs.ibm.com>
 <20180629045702.GI3422@umbus.fritz.box>
 <20180629151820.461ae112@aik.ozlabs.ibm.com>
 <20180629170747.471bea35@aik.ozlabs.ibm.com>
 <20180702040852.GW3422@umbus.fritz.box>
 <20180702143244.3a08ebe2@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Weqbz6OltVu8XOAh"
In-Reply-To: <20180702143244.3a08ebe2@aik.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Weqbz6OltVu8XOAh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 02:33:30PM +1000, Alexey Kardashevskiy wrote:
> On Mon, 2 Jul 2018 14:08:52 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Fri, Jun 29, 2018 at 05:07:47PM +1000, Alexey Kardashevskiy wrote:
> > > On Fri, 29 Jun 2018 15:18:20 +1000
> > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > >  =20
> > > > On Fri, 29 Jun 2018 14:57:02 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >  =20
> > > > > On Fri, Jun 29, 2018 at 02:51:21PM +1000, Alexey Kardashevskiy wr=
ote:   =20
> > > > > > On Fri, 29 Jun 2018 14:12:41 +1000
> > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > >      =20
> > > > > > > On Tue, Jun 26, 2018 at 03:59:26PM +1000, Alexey Kardashevski=
y wrote:     =20
> > > > > > > > We already have a check in drivers/vfio/vfio_iommu_spapr_tc=
e.c that
> > > > > > > > an IOMMU page is contained in the physical page so the PCI =
hardware won't
> > > > > > > > get access to unassigned host memory.
> > > > > > > >=20
> > > > > > > > However we do not have this check in KVM fastpath (H_PUT_TC=
E accelerated
> > > > > > > > code) so the user space can pin memory backed with 64k page=
s and create
> > > > > > > > a hardware TCE table with a bigger page size. We were lucky=
 so far and
> > > > > > > > did not hit this yet as the very first time the mapping hap=
pens
> > > > > > > > we do not have tbl::it_userspace allocated yet and fall bac=
k to
> > > > > > > > the userspace which in turn calls VFIO IOMMU driver and tha=
t fails
> > > > > > > > because of the check in vfio_iommu_spapr_tce.c which is rea=
lly
> > > > > > > > sustainable solution.
> > > > > > > >=20
> > > > > > > > This stores the smallest preregistered page size in the pre=
registered
> > > > > > > > region descriptor and changes the mm_iommu_xxx API to check=
 this against
> > > > > > > > the IOMMU page size.
> > > > > > > >=20
> > > > > > > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > > > > > ---
> > > > > > > > Changes:
> > > > > > > > v2:
> > > > > > > > * explicitly check for compound pages before calling compou=
nd_order()
> > > > > > > >=20
> > > > > > > > ---
> > > > > > > > The bug is: run QEMU _without_ hugepages (no -mempath) and =
tell it to
> > > > > > > > advertise 16MB pages to the guest; a typical pseries guest =
will use 16MB
> > > > > > > > for IOMMU pages without checking the mmu pagesize and this =
will fail
> > > > > > > > at https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/vfio/=
common.c;h=3Dfb396cf00ac40eb35967a04c9cc798ca896eed57;hb=3Drefs/heads/maste=
r#l256
> > > > > > > >=20
> > > > > > > > With the change, mapping will fail in KVM and the guest wil=
l print:
> > > > > > > >=20
> > > > > > > > mlx5_core 0000:00:00.0: ibm,create-pe-dma-window(2027) 0 80=
00000 20000000 18 1f returned 0 (liobn =3D 0x80000001 starting addr =3D 800=
0000 0)
> > > > > > > > mlx5_core 0000:00:00.0: created tce table LIOBN 0x80000001 =
for /pci@800000020000000/ethernet@0
> > > > > > > > mlx5_core 0000:00:00.0: failed to map direct window for
> > > > > > > > /pci@800000020000000/ethernet@0: -1       =20
> > > > > > >=20
> > > > > > > [snip]     =20
> > > > > > > > @@ -124,7 +125,7 @@ long mm_iommu_get(struct mm_struct *mm,=
 unsigned long ua, unsigned long entries,
> > > > > > > >  		struct mm_iommu_table_group_mem_t **pmem)
> > > > > > > >  {
> > > > > > > >  	struct mm_iommu_table_group_mem_t *mem;
> > > > > > > > -	long i, j, ret =3D 0, locked_entries =3D 0;
> > > > > > > > +	long i, j, ret =3D 0, locked_entries =3D 0, pageshift;
> > > > > > > >  	struct page *page =3D NULL;
> > > > > > > > =20
> > > > > > > >  	mutex_lock(&mem_list_mutex);
> > > > > > > > @@ -166,6 +167,8 @@ long mm_iommu_get(struct mm_struct *mm,=
 unsigned long ua, unsigned long entries,
> > > > > > > >  		goto unlock_exit;
> > > > > > > >  	}
> > > > > > > > =20
> > > > > >  > > +	mem->pageshift =3D 30; /* start from 1G pages - the bigg=
est we have */       =20
> > > > > > >=20
> > > > > > > What about 16G pages on an HPT system?     =20
> > > > > >=20
> > > > > >=20
> > > > > > Below in the loop mem->pageshift will reduce to the biggest act=
ual size
> > > > > > which will be 16mb/64k/4k. Or remain 1GB if no memory is actual=
ly
> > > > > > pinned, no loss there.     =20
> > > > >=20
> > > > > Are you saying that 16G IOMMU pages aren't supported?  Or that th=
ere's
> > > > > some reason a guest can never use them?   =20
> > > >=20
> > > >=20
> > > > ah, 16_G_, not _M_. My bad. I just never tried such huge pages, I w=
ill
> > > > lift the limit up to 64 then, easier this way. =20
> > >=20
> > >=20
> > > Ah, no, rather this as the upper limit:
> > >=20
> > > mem->pageshift =3D ilog2(entries) + PAGE_SHIFT; =20
> >=20
> > I can't make sense of this comment in context.  I see how you're
> > computing the minimum page size in the reserved region.
> >=20
> > My question is about what the "maximum minimum" is - the starting
> > value from which you calculate.  Currently it's 1G, but I can't
> > immediately see a reason that 16G is impossible here.
>=20
>=20
> 16GB is impossible if the chunk we are preregistering here is smaller
> than that, for example, the entire guest ram is 4GB.

Of course.  Just like it was for 1GiB if you had a 512MiB guest, for
example.  I'm talking about a case where you have a guest that's
>=3D16GiB and you *have* allocated 16GiB hugepages to back it.

> If that is the
> case and we try mapping a 16GB IOMMU page, this should fail as I do not
> really know what happens to the memory between 4GB..16GB.
>=20
> imho if not that, than 1<<64 would make a good upper limit.
>=20
>=20
>=20
> >=20
> > > @entries here is a number of system pages being pinned in that
> > > function.
> > >=20
> > >=20
> > >  =20
> > > >  =20
> > > > >    =20
> > > > > > > >  	for (i =3D 0; i < entries; ++i) {
> > > > > > > >  		if (1 !=3D get_user_pages_fast(ua + (i << PAGE_SHIFT),
> > > > > > > >  					1/* pages */, 1/* iswrite */, &page)) {
> > > > > > > > @@ -199,6 +202,11 @@ long mm_iommu_get(struct mm_struct *mm=
, unsigned long ua, unsigned long entries,
> > > > > > > >  			}
> > > > > > > >  		}
> > > > > > > >  populate:
> > > > > > > > +		pageshift =3D PAGE_SHIFT;
> > > > > > > > +		if (PageCompound(page))
> > > > > > > > +			pageshift +=3D compound_order(compound_head(page));
> > > > > > > > +		mem->pageshift =3D min_t(unsigned int, mem->pageshift, p=
ageshift);       =20
> > > > > > >=20
> > > > > > > Why not make mem->pageshift and pageshift local the same type=
 to avoid
> > > > > > > the min_t() ?     =20
> > > > > >=20
> > > > > > I was under impression min() is deprecated (misinterpret checkp=
atch.pl
> > > > > > may be) and therefore did not pay attention to it. I can fix th=
is and
> > > > > > repost if there is no other question.     =20
> > > > >=20
> > > > > Hm, it's possible.   =20
> > > >=20
> > > > Nah, tried min(), compiles fine. =20
> > >=20
> > >=20
> > >  =20
> >=20
> >=20
> >=20
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Weqbz6OltVu8XOAh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls5r5kACgkQbDjKyiDZ
s5I5cg/+N4hro1z18LyIkTCl+Fx++L7WB0aWhrk6fnTJidlmGVUotIq1NFKyXG5h
UwMKpEKSTnkSLZsJT2ulRsw26dYk68FKghIf7sqPt3d4i7YoGby4S6ADIu1NLAuD
fF1BsjmqhuQxuBwHP+ALIncvEE0a0p4XwBVa170kgcuUniOr/hxz1DEM7jgNiCEW
enqLKDOm6fBPaO6SPvAqo1+JVt+MuaCFEEvFPVIJz0FrrJas2de7mIX0E8DKhuCm
boBeFtcdKqQF82dDw3SA3U7qKORn0uX6xTy+UT+ZH7agBcUDeHrS3wZzE8l+qK9y
/46YjbfLJCe0CvF5NTZ1nkw2atOYSgtOCdskCIxEZOO/Yo/hAyX33VJVqyNwSrre
5Vjh30ietQmw3vvFDS1OR5i7Lh9FmsUVNyuReWnmmLWe1yZ4zmAqFY9pb96fnjmh
Mnt6RGT3WkNSX8AqtKvmDusxAv1KmRvUIPAC4AnJM/I8Y2EcG3dGS128dGQVRUiV
DEJ5nk5s0TVtGOzHwmskZSMw87Jzd8YP2k/buigFBor7jQUFivsBtujElH6mhZcI
iCIzkVZ0/FYVXzIk837+Zl2/2Q7hPihrNPwgP2kFZ/o5hguk8mtOn2fVwYldGfYC
4j89jv48R9191iRuDOkoa6PcdvzCDpXHxwJIp9m6jSnr/tIpjwk=
=ofm0
-----END PGP SIGNATURE-----

--Weqbz6OltVu8XOAh--
