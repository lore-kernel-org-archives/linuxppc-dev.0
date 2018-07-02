Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Jv052btDzF1D8
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Jul 2018 14:09:25 +1000 (AEST)
Date: Mon, 2 Jul 2018 14:08:52 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v2 2/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180702040852.GW3422@umbus.fritz.box>
References: <20180626055926.27703-1-aik@ozlabs.ru>
 <20180626055926.27703-3-aik@ozlabs.ru>
 <20180629041241.GC3422@umbus.fritz.box>
 <20180629145121.5d03e067@aik.ozlabs.ibm.com>
 <20180629045702.GI3422@umbus.fritz.box>
 <20180629151820.461ae112@aik.ozlabs.ibm.com>
 <20180629170747.471bea35@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7kW37LRKoI6fR2de"
In-Reply-To: <20180629170747.471bea35@aik.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--7kW37LRKoI6fR2de
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 05:07:47PM +1000, Alexey Kardashevskiy wrote:
> On Fri, 29 Jun 2018 15:18:20 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>=20
> > On Fri, 29 Jun 2018 14:57:02 +1000
> > David Gibson <david@gibson.dropbear.id.au> wrote:
> >=20
> > > On Fri, Jun 29, 2018 at 02:51:21PM +1000, Alexey Kardashevskiy wrote:=
 =20
> > > > On Fri, 29 Jun 2018 14:12:41 +1000
> > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > >    =20
> > > > > On Tue, Jun 26, 2018 at 03:59:26PM +1000, Alexey Kardashevskiy wr=
ote:   =20
> > > > > > We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c =
that
> > > > > > an IOMMU page is contained in the physical page so the PCI hard=
ware won't
> > > > > > get access to unassigned host memory.
> > > > > >=20
> > > > > > However we do not have this check in KVM fastpath (H_PUT_TCE ac=
celerated
> > > > > > code) so the user space can pin memory backed with 64k pages an=
d create
> > > > > > a hardware TCE table with a bigger page size. We were lucky so =
far and
> > > > > > did not hit this yet as the very first time the mapping happens
> > > > > > we do not have tbl::it_userspace allocated yet and fall back to
> > > > > > the userspace which in turn calls VFIO IOMMU driver and that fa=
ils
> > > > > > because of the check in vfio_iommu_spapr_tce.c which is really
> > > > > > sustainable solution.
> > > > > >=20
> > > > > > This stores the smallest preregistered page size in the preregi=
stered
> > > > > > region descriptor and changes the mm_iommu_xxx API to check thi=
s against
> > > > > > the IOMMU page size.
> > > > > >=20
> > > > > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > > > ---
> > > > > > Changes:
> > > > > > v2:
> > > > > > * explicitly check for compound pages before calling compound_o=
rder()
> > > > > >=20
> > > > > > ---
> > > > > > The bug is: run QEMU _without_ hugepages (no -mempath) and tell=
 it to
> > > > > > advertise 16MB pages to the guest; a typical pseries guest will=
 use 16MB
> > > > > > for IOMMU pages without checking the mmu pagesize and this will=
 fail
> > > > > > at https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/vfio/comm=
on.c;h=3Dfb396cf00ac40eb35967a04c9cc798ca896eed57;hb=3Drefs/heads/master#l2=
56
> > > > > >=20
> > > > > > With the change, mapping will fail in KVM and the guest will pr=
int:
> > > > > >=20
> > > > > > mlx5_core 0000:00:00.0: ibm,create-pe-dma-window(2027) 0 800000=
0 20000000 18 1f returned 0 (liobn =3D 0x80000001 starting addr =3D 8000000=
 0)
> > > > > > mlx5_core 0000:00:00.0: created tce table LIOBN 0x80000001 for =
/pci@800000020000000/ethernet@0
> > > > > > mlx5_core 0000:00:00.0: failed to map direct window for
> > > > > > /pci@800000020000000/ethernet@0: -1     =20
> > > > >=20
> > > > > [snip]   =20
> > > > > > @@ -124,7 +125,7 @@ long mm_iommu_get(struct mm_struct *mm, uns=
igned long ua, unsigned long entries,
> > > > > >  		struct mm_iommu_table_group_mem_t **pmem)
> > > > > >  {
> > > > > >  	struct mm_iommu_table_group_mem_t *mem;
> > > > > > -	long i, j, ret =3D 0, locked_entries =3D 0;
> > > > > > +	long i, j, ret =3D 0, locked_entries =3D 0, pageshift;
> > > > > >  	struct page *page =3D NULL;
> > > > > > =20
> > > > > >  	mutex_lock(&mem_list_mutex);
> > > > > > @@ -166,6 +167,8 @@ long mm_iommu_get(struct mm_struct *mm, uns=
igned long ua, unsigned long entries,
> > > > > >  		goto unlock_exit;
> > > > > >  	}
> > > > > > =20
> > > >  > > +	mem->pageshift =3D 30; /* start from 1G pages - the biggest =
we have */     =20
> > > > >=20
> > > > > What about 16G pages on an HPT system?   =20
> > > >=20
> > > >=20
> > > > Below in the loop mem->pageshift will reduce to the biggest actual =
size
> > > > which will be 16mb/64k/4k. Or remain 1GB if no memory is actually
> > > > pinned, no loss there.   =20
> > >=20
> > > Are you saying that 16G IOMMU pages aren't supported?  Or that there's
> > > some reason a guest can never use them? =20
> >=20
> >=20
> > ah, 16_G_, not _M_. My bad. I just never tried such huge pages, I will
> > lift the limit up to 64 then, easier this way.
>=20
>=20
> Ah, no, rather this as the upper limit:
>=20
> mem->pageshift =3D ilog2(entries) + PAGE_SHIFT;

I can't make sense of this comment in context.  I see how you're
computing the minimum page size in the reserved region.

My question is about what the "maximum minimum" is - the starting
value from which you calculate.  Currently it's 1G, but I can't
immediately see a reason that 16G is impossible here.

> @entries here is a number of system pages being pinned in that
> function.
>=20
>=20
>=20
> >=20
> > >  =20
> > > > > >  	for (i =3D 0; i < entries; ++i) {
> > > > > >  		if (1 !=3D get_user_pages_fast(ua + (i << PAGE_SHIFT),
> > > > > >  					1/* pages */, 1/* iswrite */, &page)) {
> > > > > > @@ -199,6 +202,11 @@ long mm_iommu_get(struct mm_struct *mm, un=
signed long ua, unsigned long entries,
> > > > > >  			}
> > > > > >  		}
> > > > > >  populate:
> > > > > > +		pageshift =3D PAGE_SHIFT;
> > > > > > +		if (PageCompound(page))
> > > > > > +			pageshift +=3D compound_order(compound_head(page));
> > > > > > +		mem->pageshift =3D min_t(unsigned int, mem->pageshift, pages=
hift);     =20
> > > > >=20
> > > > > Why not make mem->pageshift and pageshift local the same type to =
avoid
> > > > > the min_t() ?   =20
> > > >=20
> > > > I was under impression min() is deprecated (misinterpret checkpatch=
=2Epl
> > > > may be) and therefore did not pay attention to it. I can fix this a=
nd
> > > > repost if there is no other question.   =20
> > >=20
> > > Hm, it's possible. =20
> >=20
> > Nah, tried min(), compiles fine.
>=20
>=20
>=20



--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7kW37LRKoI6fR2de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls5pVQACgkQbDjKyiDZ
s5I+dxAAtmCXTE/4GPxLhciNpXNoA6f8m/VRYWXzPquQd7dwCkl11g+TXH5SA2xN
fYWtqChu4Lns1hKYs05p6fkxmzx2NveFmQU21eSoU7nWXEMrDUZZha7XdUR9E58b
WwW3ZNFMvZ4jRxyjObfVB1A2R/+p+IabrTVoievw+2DX4prinBmS9bIo4SoZVQHv
4W4u1A0IeehFnftlTy7IT4zeXQ4aBOfUUf6QCaATIHe80EkXdzmUqH0puGaN1E9Z
sGaRmKfzuU7l/owutE5dgqZJ9QpOy9oxBWSxwntBrBQkoZ2jhSIEZD7pjZZeaaSP
GO09josLVBUC+KJ9FeHbFlA4niUlpkJjxiBcELacjtKwY5j5AwM7uK7V8HE/W1OL
RHLIEjMYlzYWujcMkpHdriSdoMgK6pf7jjUZUw/gKSJ1pCbb+3q/2ykKOSbBZvfX
dY8YjmA+A+7DK1qC10N+t12ReUUAiZG9/vrFsR0s7Ak/SXIsqE4X2wz+lbFbr5uo
pZpYS8Y9kZv5RrRUqhmN1/KO7XeEv055teSLn4RjG1oi+P9kxbfgTSKSV2PtUv8F
LWvMR7votpBOp+V+dWlHgjraLMmjApLwSlvPazAJIj4M0xo+0OtpxA9JzfqFy2zq
H/AxdQCrvJgBAgbY7bvSI1unZ0bGwQBR/4WTO+Mxeqee9n9p6dM=
=y+q/
-----END PGP SIGNATURE-----

--7kW37LRKoI6fR2de--
