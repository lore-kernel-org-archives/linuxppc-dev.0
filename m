Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41634g1hcrzDrnp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2018 22:35:47 +1000 (AEST)
Date: Thu, 14 Jun 2018 22:35:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH kernel 6/6] powerpc/powernv/ioda: Allocate indirect TCE
 levels on demand
Message-ID: <20180614123525.GB19339@umbus.fritz.box>
References: <20180608054633.18659-1-aik@ozlabs.ru>
 <20180608054633.18659-7-aik@ozlabs.ru>
 <20180612041700.GZ2737@umbus.fritz.box>
 <360896bd-f3a9-530c-8144-c10502dc965b@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="WYTEVAkct0FjGQmd"
In-Reply-To: <360896bd-f3a9-530c-8144-c10502dc965b@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--WYTEVAkct0FjGQmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 04:35:18PM +1000, Alexey Kardashevskiy wrote:
> On 12/6/18 2:17 pm, David Gibson wrote:
> > On Fri, Jun 08, 2018 at 03:46:33PM +1000, Alexey Kardashevskiy wrote:
> >> At the moment we allocate the entire TCE table, twice (hardware part a=
nd
> >> userspace translation cache). This normally works as we normally have
> >> contigous memory and the guest will map entire RAM for 64bit DMA.
> >>
> >> However if we have sparse RAM (one example is a memory device), then
> >> we will allocate TCEs which will never be used as the guest only maps
> >> actual memory for DMA. If it is a single level TCE table, there is not=
hing
> >> we can really do but if it a multilevel table, we can skip allocating
> >> TCEs we know we won't need.
> >>
> >> This adds ability to allocate only first level, saving memory.
> >>
> >> This changes iommu_table::free() to avoid allocating of an extra level;
> >> iommu_table::set() will do this when needed.
> >>
> >> This adds @alloc parameter to iommu_table::exchange() to tell the call=
back
> >> if it can allocate an extra level; the flag is set to "false" for
> >> the realmode KVM handlers of H_PUT_TCE hcalls and the callback returns
> >> H_TOO_HARD.
> >>
> >> This still requires the entire table to be counted in mm::locked_vm.
> >>
> >> To be conservative, this only does on-demand allocation when
> >> the usespace cache table is requested which is the case of VFIO.
> >>
> >> The example math for a system replicating a powernv setup with NVLink2
> >> in a guest:
> >> 16GB RAM mapped at 0x0
> >> 128GB GPU RAM window (16GB of actual RAM) mapped at 0x244000000000
> >>
> >> the table to cover that all with 64K pages takes:
> >> (((0x244000000000 + 0x2000000000) >> 16)*8)>>20 =3D 4556MB
> >>
> >> If we allocate only necessary TCE levels, we will only need:
> >> (((0x400000000 + 0x400000000) >> 16)*8)>>20 =3D 4MB (plus some for ind=
irect
> >> levels).
> >>
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>  arch/powerpc/include/asm/iommu.h              |  7 ++-
> >>  arch/powerpc/platforms/powernv/pci.h          |  6 ++-
> >>  arch/powerpc/kvm/book3s_64_vio_hv.c           |  4 +-
> >>  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 69 ++++++++++++++++++=
++-------
> >>  arch/powerpc/platforms/powernv/pci-ioda.c     |  8 ++--
> >>  drivers/vfio/vfio_iommu_spapr_tce.c           |  2 +-
> >>  6 files changed, 69 insertions(+), 27 deletions(-)
> >>
> >> diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/a=
sm/iommu.h
> >> index 4bdcf22..daa3ee5 100644
> >> --- a/arch/powerpc/include/asm/iommu.h
> >> +++ b/arch/powerpc/include/asm/iommu.h
> >> @@ -70,7 +70,7 @@ struct iommu_table_ops {
> >>  			unsigned long *hpa,
> >>  			enum dma_data_direction *direction);
> >> =20
> >> -	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index);
> >> +	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index, bool all=
oc);
> >>  #endif
> >>  	void (*clear)(struct iommu_table *tbl,
> >>  			long index, long npages);
> >> @@ -122,10 +122,13 @@ struct iommu_table {
> >>  	__be64 *it_userspace; /* userspace view of the table */
> >>  	struct iommu_table_ops *it_ops;
> >>  	struct kref    it_kref;
> >> +	int it_nid;
> >>  };
> >> =20
> >> +#define IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry) \
> >> +		((tbl)->it_ops->useraddrptr((tbl), (entry), false))
> >=20
> > Is real mode really the only case where you want to inhibit new
> > allocations?  I would have thought some paths would be read-only and
> > you wouldn't want to allocate, even in virtual mode.
>=20
> There are paths when I do not want allocation but I can figure out that
> from dma direction flag, for example, I am cleaning up the table and I do
> not want any extra  allocation to happen there and they do happen because=
 I
> made a mistake so I'll repost. Other than that, this @alloc flag is for
> real mode only.

Hm, ok.

Something just occurred to me: IIRC, going from the vmalloc() to the
explicit table structure was to avoid allocating pages for memory
regions that aren't there due to sparseness.  But.. won't you get that
with vmalloc() anyway, if the pages for the gaps never get
instantiated?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WYTEVAkct0FjGQmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsiYQkACgkQbDjKyiDZ
s5KZlw/+M44shd5ya5QaS0TdsdVgPt+vLn+NGuZEcR/qLiuLdoCWB+FPHUP1/3dD
ceEad+aAyQ60coUC8ygtLqmbzswgmi2a/DjkMOewgKJIFMU8IIXdAcnvFGq3rCfE
Wt3/E3eQ/ZbK0leZdbzJgO2bqBiPtdWz+lSj+fZH4QkRT0hplACaWPtWO7hq/HSj
3LQoxfa0TGG6N/7dHcP6HqFssi3YCj7BrGO03n/y0JUk2n/mlpW2XokFYuQbQ+02
1dVlGdbN8Yz6ggzily1CyICFbGP7U7l0lymEpi2LZVddEXeTqj5xmDVcXFP7J0u1
4juLbWMdDAH6K7+LdeL+F6T60pysUBROUmGV1eioy+uSu5r459H97WJptX18z7QX
D8GDhiZrY9n/6Gu5DGv3/o5irEE35W74tBdvhCrNxD0XCyehiZ40Rbqw6LQsD9l0
R7jUnOWPDFVZF2j2h+Jts1uJD/C9c09O9zWFqhl3csHa4WMFIS/L8J2ISgk/doES
k0vMvhKCUi4UYKDdtVeR6eFtZxLHG1swbsRFDpLIQw3W2sa4sSAfgV34qhswzrER
pxeT/DljPvGVk6bfAbn1eONsNIc6UXizrxgozR8FWsBhokfnKdQ/JPB/2Chbv/+/
L7gWmoy1OvFSRj1WpHkiEVdbJKBgr4iBsZOOEVKP0WS8M0L9OGs=
=aetT
-----END PGP SIGNATURE-----

--WYTEVAkct0FjGQmd--
