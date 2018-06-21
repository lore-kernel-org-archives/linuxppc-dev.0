Return-Path: <aik@ozlabs.ru>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41BCgn0mbkzF0tr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 17:17:07 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id r21-v6so995036pgv.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 00:17:07 -0700 (PDT)
Date: Thu, 21 Jun 2018 17:16:46 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Russell Currey <ruscur@russell.cc>
Subject: Re: [PATCH kernel v2 6/6] powerpc/powernv/ioda: Allocate indirect
 TCE levels on demand
Message-ID: <20180621171646.60b0c31b@aik.ozlabs.ibm.com>
In-Reply-To: <20180621020321.GE32328@umbus.fritz.box>
References: <20180617111428.24349-1-aik@ozlabs.ru>
 <20180617111428.24349-7-aik@ozlabs.ru>
 <20180621020321.GE32328@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/IdsL/pK3eqP198d7s6NzOU1"; protocol="application/pgp-signature"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Sig_/IdsL/pK3eqP198d7s6NzOU1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 21 Jun 2018 12:03:21 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Sun, Jun 17, 2018 at 09:14:28PM +1000, Alexey Kardashevskiy wrote:
> > At the moment we allocate the entire TCE table, twice (hardware part and
> > userspace translation cache). This normally works as we normally have
> > contigous memory and the guest will map entire RAM for 64bit DMA.
> >=20
> > However if we have sparse RAM (one example is a memory device), then
> > we will allocate TCEs which will never be used as the guest only maps
> > actual memory for DMA. If it is a single level TCE table, there is noth=
ing
> > we can really do but if it a multilevel table, we can skip allocating
> > TCEs we know we won't need.
> >=20
> > This adds ability to allocate only first level, saving memory.
> >=20
> > This changes iommu_table::free() to avoid allocating of an extra level;
> > iommu_table::set() will do this when needed.
> >=20
> > This adds @alloc parameter to iommu_table::exchange() to tell the callb=
ack
> > if it can allocate an extra level; the flag is set to "false" for
> > the realmode KVM handlers of H_PUT_TCE hcalls and the callback returns
> > H_TOO_HARD.
> >=20
> > This still requires the entire table to be counted in mm::locked_vm.
> >=20
> > To be conservative, this only does on-demand allocation when
> > the usespace cache table is requested which is the case of VFIO.
> >=20
> > The example math for a system replicating a powernv setup with NVLink2
> > in a guest:
> > 16GB RAM mapped at 0x0
> > 128GB GPU RAM window (16GB of actual RAM) mapped at 0x244000000000
> >=20
> > the table to cover that all with 64K pages takes:
> > (((0x244000000000 + 0x2000000000) >> 16)*8)>>20 =3D 4556MB
> >=20
> > If we allocate only necessary TCE levels, we will only need:
> > (((0x400000000 + 0x400000000) >> 16)*8)>>20 =3D 4MB (plus some for indi=
rect
> > levels).
> >=20
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > Changes:
> > v2:
> > * fixed bug in cleanup path which forced the entire table to be
> > allocated right before destroying
> > * added memory allocation error handling pnv_tce()
> > ---
> >  arch/powerpc/include/asm/iommu.h              |  7 ++-
> >  arch/powerpc/platforms/powernv/pci.h          |  6 ++-
> >  arch/powerpc/kvm/book3s_64_vio_hv.c           |  4 +-
> >  arch/powerpc/platforms/powernv/pci-ioda-tce.c | 69 +++++++++++++++++++=
+-------
> >  arch/powerpc/platforms/powernv/pci-ioda.c     |  8 ++--
> >  drivers/vfio/vfio_iommu_spapr_tce.c           |  2 +-
> >  6 files changed, 69 insertions(+), 27 deletions(-)
> >=20
> > diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/as=
m/iommu.h
> > index 4bdcf22..daa3ee5 100644
> > --- a/arch/powerpc/include/asm/iommu.h
> > +++ b/arch/powerpc/include/asm/iommu.h
> > @@ -70,7 +70,7 @@ struct iommu_table_ops {
> >  			unsigned long *hpa,
> >  			enum dma_data_direction *direction);
> > =20
> > -	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index);
> > +	__be64 *(*useraddrptr)(struct iommu_table *tbl, long index, bool allo=
c);
> >  #endif
> >  	void (*clear)(struct iommu_table *tbl,
> >  			long index, long npages);
> > @@ -122,10 +122,13 @@ struct iommu_table {
> >  	__be64 *it_userspace; /* userspace view of the table */
> >  	struct iommu_table_ops *it_ops;
> >  	struct kref    it_kref;
> > +	int it_nid;
> >  };
> > =20
> > +#define IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry) \
> > +		((tbl)->it_ops->useraddrptr((tbl), (entry), false))
> >  #define IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry) \
> > -		((tbl)->it_ops->useraddrptr((tbl), (entry)))
> > +		((tbl)->it_ops->useraddrptr((tbl), (entry), true))
> > =20
> >  /* Pure 2^n version of get_order */
> >  static inline __attribute_const__
> > diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platfo=
rms/powernv/pci.h
> > index 5e02408..1fa5590 100644
> > --- a/arch/powerpc/platforms/powernv/pci.h
> > +++ b/arch/powerpc/platforms/powernv/pci.h
> > @@ -267,8 +267,10 @@ extern int pnv_tce_build(struct iommu_table *tbl, =
long index, long npages,
> >  		unsigned long attrs);
> >  extern void pnv_tce_free(struct iommu_table *tbl, long index, long npa=
ges);
> >  extern int pnv_tce_xchg(struct iommu_table *tbl, long index,
> > -		unsigned long *hpa, enum dma_data_direction *direction);
> > -extern __be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index=
);
> > +		unsigned long *hpa, enum dma_data_direction *direction,
> > +		bool alloc);
> > +extern __be64 *pnv_tce_useraddrptr(struct iommu_table *tbl, long index,
> > +		bool alloc);
> >  extern unsigned long pnv_tce_get(struct iommu_table *tbl, long index);
> > =20
> >  extern long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
> > diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/boo=
k3s_64_vio_hv.c
> > index db0490c..05b4865 100644
> > --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> > @@ -200,7 +200,7 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct k=
vm *kvm,
> >  {
> >  	struct mm_iommu_table_group_mem_t *mem =3D NULL;
> >  	const unsigned long pgsize =3D 1ULL << tbl->it_page_shift;
> > -	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> > +	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry);
> > =20
> >  	if (!pua)
> >  		/* it_userspace allocation might be delayed */
> > @@ -264,7 +264,7 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *=
kvm, struct iommu_table *tbl,
> >  {
> >  	long ret;
> >  	unsigned long hpa =3D 0;
> > -	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY(tbl, entry);
> > +	__be64 *pua =3D IOMMU_TABLE_USERSPACE_ENTRY_RM(tbl, entry);
> >  	struct mm_iommu_table_group_mem_t *mem;
> > =20
> >  	if (!pua)
> > diff --git a/arch/powerpc/platforms/powernv/pci-ioda-tce.c b/arch/power=
pc/platforms/powernv/pci-ioda-tce.c
> > index 36c2eb0..a7debfb 100644
> > --- a/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> > +++ b/arch/powerpc/platforms/powernv/pci-ioda-tce.c
> > @@ -48,7 +48,7 @@ static __be64 *pnv_alloc_tce_level(int nid, unsigned =
int shift)
> >  	return addr;
> >  }
> > =20
> > -static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx)
> > +static __be64 *pnv_tce(struct iommu_table *tbl, bool user, long idx, b=
ool alloc)
> >  {
> >  	__be64 *tmp =3D user ? tbl->it_userspace : (__be64 *) tbl->it_base;
> >  	int  level =3D tbl->it_indirect_levels;
> > @@ -57,7 +57,20 @@ static __be64 *pnv_tce(struct iommu_table *tbl, bool=
 user, long idx)
> > =20
> >  	while (level) {
> >  		int n =3D (idx & mask) >> (level * shift);
> > -		unsigned long tce =3D be64_to_cpu(tmp[n]);
> > +		unsigned long tce;
> > +
> > +		if (tmp[n] =3D=3D 0) {
> > +			__be64 *tmp2;
> > +
> > +			if (!alloc)
> > +				return NULL;
> > +
> > +			tmp2 =3D pnv_alloc_tce_level(tbl->it_nid,
> > +					ilog2(tbl->it_level_size) + 3); =20
>=20
> Can this allocation fail?  If it does you'll crash as you dereference
> NULL just below.


Oh. I fixed both comments and I lost the fix in rebase, I'll repost :(



--
Alexey

--Sig_/IdsL/pK3eqP198d7s6NzOU1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEECIb1sawlPgRl/px9ze7KtGKK020FAlsrUN4ACgkQze7KtGKK
022zhw//eH2iIzSR72SW8ZfQa7uvklyYORppc0f/tZuRVPCv2LM6e6Sa5etMOCrk
bDA9pzbzhJbDSGnfbLbPDh/M3CLb6CL2JZMmMQ3aB3mzQsSh7gsG3QZyBBLCc0ru
1LnVj6u4UmJisSKmetcERItxpi3DTcf1i446OgHKlakPbJ55Q5Tj8RixhM5jKPOM
PE7QegC0YbTfRhTAm4Sz/niBM3j5lLZbKy6MOt+NBHnAneeYSr69fkMHSuoWo/jE
HlzADJZFq6ijdMKhm3Hw9wm777n8bjkCttYJHwmI6SAUSHMhjB39G4cBOnSubjIm
i07/PkSLq/SlZTHVh5nu56ZEAdrfY4i7RBV2LPfACxiqyuvrl+Qoke/rVdrHLqNm
PIIHOP1sQCnobrJgxh9BLlEANQNPj05lJpcAu4/gx3hVFrXMZpPbhD/4oKOuz9LR
ncF2y6zIAK/8Z/3VofDInvKJ7GseUPJ0WvKtbVG7fq58vR7BESYgzxopFQmJSSvu
yNH3MHH9g68zBomUhWoPht/A/3SlUf/8DMgqz0YXT4LVFINce7EvWWMHA/EwxX/V
h0mkJm2YdQrNUS+kd+N/uVw/fNjnExhgEWifs9eCFzMEkRNP9DzXX+RpCisRJVyT
YoBn7kwGrrDXfljVtLj+XjBhmPe3hEEfe76kIv+z5dHgwjn8i/8=
=zDZE
-----END PGP SIGNATURE-----

--Sig_/IdsL/pK3eqP198d7s6NzOU1--
