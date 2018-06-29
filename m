Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41H4Fc251TzF1LR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jun 2018 14:59:48 +1000 (AEST)
Date: Fri, 29 Jun 2018 14:57:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH kernel v2 2/2] KVM: PPC: Check if IOMMU page is contained
 in the pinned physical page
Message-ID: <20180629045702.GI3422@umbus.fritz.box>
References: <20180626055926.27703-1-aik@ozlabs.ru>
 <20180626055926.27703-3-aik@ozlabs.ru>
 <20180629041241.GC3422@umbus.fritz.box>
 <20180629145121.5d03e067@aik.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xQR6quUbZ63TTuTU"
In-Reply-To: <20180629145121.5d03e067@aik.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--xQR6quUbZ63TTuTU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 29, 2018 at 02:51:21PM +1000, Alexey Kardashevskiy wrote:
> On Fri, 29 Jun 2018 14:12:41 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Tue, Jun 26, 2018 at 03:59:26PM +1000, Alexey Kardashevskiy wrote:
> > > We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c that
> > > an IOMMU page is contained in the physical page so the PCI hardware w=
on't
> > > get access to unassigned host memory.
> > >=20
> > > However we do not have this check in KVM fastpath (H_PUT_TCE accelera=
ted
> > > code) so the user space can pin memory backed with 64k pages and crea=
te
> > > a hardware TCE table with a bigger page size. We were lucky so far and
> > > did not hit this yet as the very first time the mapping happens
> > > we do not have tbl::it_userspace allocated yet and fall back to
> > > the userspace which in turn calls VFIO IOMMU driver and that fails
> > > because of the check in vfio_iommu_spapr_tce.c which is really
> > > sustainable solution.
> > >=20
> > > This stores the smallest preregistered page size in the preregistered
> > > region descriptor and changes the mm_iommu_xxx API to check this agai=
nst
> > > the IOMMU page size.
> > >=20
> > > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > > ---
> > > Changes:
> > > v2:
> > > * explicitly check for compound pages before calling compound_order()
> > >=20
> > > ---
> > > The bug is: run QEMU _without_ hugepages (no -mempath) and tell it to
> > > advertise 16MB pages to the guest; a typical pseries guest will use 1=
6MB
> > > for IOMMU pages without checking the mmu pagesize and this will fail
> > > at https://git.qemu.org/?p=3Dqemu.git;a=3Dblob;f=3Dhw/vfio/common.c;h=
=3Dfb396cf00ac40eb35967a04c9cc798ca896eed57;hb=3Drefs/heads/master#l256
> > >=20
> > > With the change, mapping will fail in KVM and the guest will print:
> > >=20
> > > mlx5_core 0000:00:00.0: ibm,create-pe-dma-window(2027) 0 8000000 2000=
0000 18 1f returned 0 (liobn =3D 0x80000001 starting addr =3D 8000000 0)
> > > mlx5_core 0000:00:00.0: created tce table LIOBN 0x80000001 for /pci@8=
00000020000000/ethernet@0
> > > mlx5_core 0000:00:00.0: failed to map direct window for
> > > /pci@800000020000000/ethernet@0: -1 =20
> >=20
> > [snip]
> > > @@ -124,7 +125,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned =
long ua, unsigned long entries,
> > >  		struct mm_iommu_table_group_mem_t **pmem)
> > >  {
> > >  	struct mm_iommu_table_group_mem_t *mem;
> > > -	long i, j, ret =3D 0, locked_entries =3D 0;
> > > +	long i, j, ret =3D 0, locked_entries =3D 0, pageshift;
> > >  	struct page *page =3D NULL;
> > > =20
> > >  	mutex_lock(&mem_list_mutex);
> > > @@ -166,6 +167,8 @@ long mm_iommu_get(struct mm_struct *mm, unsigned =
long ua, unsigned long entries,
> > >  		goto unlock_exit;
> > >  	}
> > > =20
>  > > +	mem->pageshift =3D 30; /* start from 1G pages - the biggest we hav=
e */ =20
> >=20
> > What about 16G pages on an HPT system?
>=20
>=20
> Below in the loop mem->pageshift will reduce to the biggest actual size
> which will be 16mb/64k/4k. Or remain 1GB if no memory is actually
> pinned, no loss there.

Are you saying that 16G IOMMU pages aren't supported?  Or that there's
some reason a guest can never use them?

> > >  	for (i =3D 0; i < entries; ++i) {
> > >  		if (1 !=3D get_user_pages_fast(ua + (i << PAGE_SHIFT),
> > >  					1/* pages */, 1/* iswrite */, &page)) {
> > > @@ -199,6 +202,11 @@ long mm_iommu_get(struct mm_struct *mm, unsigned=
 long ua, unsigned long entries,
> > >  			}
> > >  		}
> > >  populate:
> > > +		pageshift =3D PAGE_SHIFT;
> > > +		if (PageCompound(page))
> > > +			pageshift +=3D compound_order(compound_head(page));
> > > +		mem->pageshift =3D min_t(unsigned int, mem->pageshift, pageshift);=
 =20
> >=20
> > Why not make mem->pageshift and pageshift local the same type to avoid
> > the min_t() ?
>=20
> I was under impression min() is deprecated (misinterpret checkpatch.pl
> may be) and therefore did not pay attention to it. I can fix this and
> repost if there is no other question.

Hm, it's possible.


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xQR6quUbZ63TTuTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAls1vB4ACgkQbDjKyiDZ
s5K/fA//bSTAg/wU+s8H0Q7s45ricNtXW4ghIp4Ceweuqxg1TXUyPqBIP6dSyrZ4
4lHHHJKD0BuRl0uGeyqdTeAsVCGWd3p4oBE7TLrrFvPZVuCiNz//UB/0L4MFjNKS
4vvOrtD1BSYMJB+SBOxjOi0fQRql2v2W0S7DEoJRw9Hv+gjq0OCyQHxxgfFThJSt
amjPCrTs98xoBDYBT6WZYF4fypuXwbyQ1mXTNVlHMwuneU2R8IuT60PTQS0e+r9l
iTqeYMlSCEA9NJi61ZMaGe+a76hf8b3AzbrhMaBKDac3p62YiqUG/OJfg5PJLzWV
hOqMYDgIKOsIEM2246t6ZvIVcZDFs0NUNCd1MtD+HMnedCtzz9pMYFtfpcLIyryV
j1jeIUcCfErRnSuHPSbSncD5l4xDuTzWmxRvsp+SZGuPy94CQN6ldiNRNSLWNk/4
Gh/QmiNAIveSue7C01hDNZ2rVcHWCIySerIfBZChL04FvuvbPtqM7ZslzhhxPzzE
XDAFp79abjOE2uwmGwezdl0FoHGbaEPv8JH2WO5x2036imCgQPG5hg0ejs/Y+D7z
j3YGGF0CHSveb06YF+PtU+UGtmV39ufK1hF6mF40PUEfuf0AYydCun1gxt9NVCfg
mwKr9s8OtZ+CvpIsbQUdCmEjLrGLHOE+IFtAIOGLqfIUYblruk8=
=H4lY
-----END PGP SIGNATURE-----

--xQR6quUbZ63TTuTU--
