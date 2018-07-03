Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41KRYK0qfgzF1PD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 11:36:37 +1000 (AEST)
Date: Tue, 3 Jul 2018 11:36:32 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v2 2/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180703013632.GJ3422@umbus.fritz.box>
References: <20180626055926.27703-3-aik@ozlabs.ru>
 <20180629041241.GC3422@umbus.fritz.box>
 <20180629145121.5d03e067@aik.ozlabs.ibm.com>
 <20180629045702.GI3422@umbus.fritz.box>
 <20180629151820.461ae112@aik.ozlabs.ibm.com>
 <20180629170747.471bea35@aik.ozlabs.ibm.com>
 <20180702040852.GW3422@umbus.fritz.box>
 <20180702143244.3a08ebe2@aik.ozlabs.ibm.com>
 <20180702045243.GX3422@umbus.fritz.box>
 <20180702163227.0a4f0ea8@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WdPYQQQ4lIWZ4ZWi"
In-Reply-To: <20180702163227.0a4f0ea8@aik.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WdPYQQQ4lIWZ4ZWi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 04:32:27PM +1000, Alexey Kardashevskiy wrote:
> On Mon, 2 Jul 2018 14:52:43 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Mon, Jul 02, 2018 at 02:33:30PM +1000, Alexey Kardashevskiy wrote:
> > > On Mon, 2 Jul 2018 14:08:52 +1000
> > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > >  =20
> > > > On Fri, Jun 29, 2018 at 05:07:47PM +1000, Alexey Kardashevskiy wrot=
e: =20
> > > > > On Fri, 29 Jun 2018 15:18:20 +1000
> > > > > Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > > > >    =20
> > > > > > On Fri, 29 Jun 2018 14:57:02 +1000
> > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > >    =20
> > > > > > > On Fri, Jun 29, 2018 at 02:51:21PM +1000, Alexey Kardashevski=
y wrote:     =20
> > > > > > > > On Fri, 29 Jun 2018 14:12:41 +1000
> > > > > > > > David Gibson <david@gibson.dropbear.id.au> wrote:
> > > > > > > >        =20
> > > > > > > > > On Tue, Jun 26, 2018 at 03:59:26PM +1000, Alexey Kardashe=
vskiy wrote:       =20
> > > > > > > > > > We already have a check in drivers/vfio/vfio_iommu_spap=
r_tce.c that
> > > > > > > > > > an IOMMU page is contained in the physical page so the =
PCI hardware won't
> > > > > > > > > > get access to unassigned host memory.
> > > > > > > > > >=20
> > > > > > > > > > However we do not have this check in KVM fastpath (H_PU=
T_TCE accelerated
> > > > > > > > > > code) so the user space can pin memory backed with 64k =
pages and create
> > > > > > > > > > a hardware TCE table with a bigger page size. We were l=
ucky so far and
> > > > > > > > > > did not hit this yet as the very first time the mapping=
 happens
> > > > > > > > > > we do not have tbl::it_userspace allocated yet and fall=
 back to
> > > > > > > > > > the userspace which in turn calls VFIO IOMMU driver and=
 that fails
> > > > > > > > > > because of the check in vfio_iommu_spapr_tce.c which is=
 really
> > > > > > > > > > sustainable solution.
> > > > > > > > > >=20
> > > > > > > > > > This stores the smallest preregistered page size in the=
 preregistered
> > > > > > > > > > region descriptor and changes the mm_iommu_xxx API to c=
heck this against
> > > > > > > > > > the IOMMU page size.
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > > > > > > > > ---
> > > > > > > > > > Changes:
> > > > > > > > > > v2:
> > > > > > > > > > * explicitly check for compound pages before calling co=
mpound_order()
> > > > > > > > > >=20
> > > > > > > > > > ---
> > > > > > > > > > The bug is: run QEMU _without_ hugepages (no -mempath) =
and tell it to
> > > > > > > > > > advertise 16MB pages to the guest; a typical pseries gu=
est will use 16MB
> > > > > > > > > > for IOMMU pages without checking the mmu pagesize and t=
his will fail
> > > > > > > > > > at https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/v=
fio/common.c;h=3Dfb396cf00ac40eb35967a04c9cc798ca896eed57;hb=3Drefs/heads/m=
aster#l256
> > > > > > > > > >=20
> > > > > > > > > > With the change, mapping will fail in KVM and the guest=
 will print:
> > > > > > > > > >=20
> > > > > > > > > > mlx5_core 0000:00:00.0: ibm,create-pe-dma-window(2027) =
0 8000000 20000000 18 1f returned 0 (liobn =3D 0x80000001 starting addr =3D=
 8000000 0)
> > > > > > > > > > mlx5_core 0000:00:00.0: created tce table LIOBN 0x80000=
001 for /pci@800000020000000/ethernet@0
> > > > > > > > > > mlx5_core 0000:00:00.0: failed to map direct window for
> > > > > > > > > > /pci@800000020000000/ethernet@0: -1         =20
> > > > > > > > >=20
> > > > > > > > > [snip]       =20
> > > > > > > > > > @@ -124,7 +125,7 @@ long mm_iommu_get(struct mm_struct =
*mm, unsigned long ua, unsigned long entries,
> > > > > > > > > >  		struct mm_iommu_table_group_mem_t **pmem)
> > > > > > > > > >  {
> > > > > > > > > >  	struct mm_iommu_table_group_mem_t *mem;
> > > > > > > > > > -	long i, j, ret =3D 0, locked_entries =3D 0;
> > > > > > > > > > +	long i, j, ret =3D 0, locked_entries =3D 0, pageshift;
> > > > > > > > > >  	struct page *page =3D NULL;
> > > > > > > > > > =20
> > > > > > > > > >  	mutex_lock(&mem_list_mutex);
> > > > > > > > > > @@ -166,6 +167,8 @@ long mm_iommu_get(struct mm_struct =
*mm, unsigned long ua, unsigned long entries,
> > > > > > > > > >  		goto unlock_exit;
> > > > > > > > > >  	}
> > > > > > > > > > =20
> > > > > > > >  > > +	mem->pageshift =3D 30; /* start from 1G pages - the =
biggest we have */         =20
> > > > > > > > >=20
> > > > > > > > > What about 16G pages on an HPT system?       =20
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > Below in the loop mem->pageshift will reduce to the biggest=
 actual size
> > > > > > > > which will be 16mb/64k/4k. Or remain 1GB if no memory is ac=
tually
> > > > > > > > pinned, no loss there.       =20
> > > > > > >=20
> > > > > > > Are you saying that 16G IOMMU pages aren't supported?  Or tha=
t there's
> > > > > > > some reason a guest can never use them?     =20
> > > > > >=20
> > > > > >=20
> > > > > > ah, 16_G_, not _M_. My bad. I just never tried such huge pages,=
 I will
> > > > > > lift the limit up to 64 then, easier this way.   =20
> > > > >=20
> > > > >=20
> > > > > Ah, no, rather this as the upper limit:
> > > > >=20
> > > > > mem->pageshift =3D ilog2(entries) + PAGE_SHIFT;   =20
> > > >=20
> > > > I can't make sense of this comment in context.  I see how you're
> > > > computing the minimum page size in the reserved region.
> > > >=20
> > > > My question is about what the  is - the starting
> > > > value from which you calculate.  Currently it's 1G, but I can't
> > > > immediately see a reason that 16G is impossible here. =20
> > >=20
> > >=20
> > > 16GB is impossible if the chunk we are preregistering here is smaller
> > > than that, for example, the entire guest ram is 4GB. =20
> >=20
> > Of course.  Just like it was for 1GiB if you had a 512MiB guest, for
> > example.  I'm talking about a case where you have a guest that's
> > >=3D16GiB and you *have* allocated 16GiB hugepages to back it. =20
>=20
>=20
> Then, assuming we are preregistering entire RAM as a single chunk, the
> "maximum minimum" will be initialized as ">=3D16GiB" (but floor-aligned
> to power of two) before the pinning loop and then reduce to the actual
> page size, inside the loop. I feel like I am missing something in the
> question, what is that?

I wish I knew...

By the "maximum minimum" I'm talking about the shift value you start
with before you start looking at the actual pages.  Currently that is
exactly 30 (1 GiB).  AFAICT that prevents using 16GiB pages, and I
can't see a good reason for that.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WdPYQQQ4lIWZ4ZWi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls60yAACgkQbDjKyiDZ
s5KxrBAAwMIZH2HgSUt0SYyrQE+UZ24KNO96FQ2kwq0hXwKw/pZfnAhjg+E4MtCb
6Jj/mnM/Eb2CI4aKqWHKctiHBRGNHWKSla29P9YLG1A6wkasEGJtl7Ljfk3xOI4y
QN3kfrGZxyk641nrOStZXcQ+yPR6yFk8+IqdZAmvVcNGa4+GpgLz4rLrj90JfLWB
w4zcoK78UkLoV4Mb8TeYtgfVErpX1979duQCKpi1X8IIOb2KKx+MLPzx6hqrRdAx
tJT9MUzmsXoNP0Zz9ehErHSgy11SDwhZqbNZy6hpTWt+kFq6I//Qj5GFI3Xlh0/l
eQBiryTo2eiYGhXj+f1Dz2WFHbXoAKg/nrbW4FLs9kCiMlxKF2ZBieTx9xHGe/Lm
mMWwF1iGpJdTMY7pq8EMxgcl3MHuG+21YuDCJJRldMcahB3oTpfwFXDFReMmwmAQ
qxyKOUmyEmM1X3KXnkV2d5xQ4Cqgm6iUcH4U6tbzoL4jGHPocOrh7WJZgPYj7tG6
NnDuyyen48Wf8O7v3hwGZVMM76brqALapIZ1/bDvHe9C/lOJqVDPGSf4B3EgAEXb
BXoCZ8+dBzp796GSbQq0zOZUTmT3TNtIGgLtb3t43qXlVipBZMO/rIFy0tguVr0f
gQpOxU87GG2oPTIPWDQtrD7CSvuyGRcnJuWcJdliKRiKtgZn3+s=
=9+vb
-----END PGP SIGNATURE-----

--WdPYQQQ4lIWZ4ZWi--
