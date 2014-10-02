Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D31A21A09AE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 16:44:58 +1000 (EST)
Message-ID: <1412232297.6143.18.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 10/17] powerpc/mm: Merge vsid calculation in
 hash_page() and copro_data_segment()
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 02 Oct 2014 16:44:57 +1000
In-Reply-To: <87wq8km7w0.fsf@linux.vnet.ibm.com>
References: <1412073306-13812-1-git-send-email-mikey@neuling.org>
 <1412073306-13812-11-git-send-email-mikey@neuling.org>
 <87wq8km7w0.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, arnd@arndb.de, greg@kroah.com,
 linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, anton@samba.org,
 imunsie@au1.ibm.com, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 15:25 +0530, Aneesh Kumar K.V wrote:
> Michael Neuling <mikey@neuling.org> writes:
>=20
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >
> > The vsid calculation between hash_page() and copro_data_segment() are v=
ery
> > similar.  This merges these two different versions.
> >
> > Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >  arch/powerpc/include/asm/mmu-hash64.h |  2 ++
> >  arch/powerpc/mm/copro_fault.c         | 45 ++++++--------------------
> >  arch/powerpc/mm/hash_utils_64.c       | 61 ++++++++++++++++++++++-----=
--------
> >  3 files changed, 50 insertions(+), 58 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/inclu=
de/asm/mmu-hash64.h
> > index f84e5a5..bf43fb0 100644
> > --- a/arch/powerpc/include/asm/mmu-hash64.h
> > +++ b/arch/powerpc/include/asm/mmu-hash64.h
> > @@ -322,6 +322,8 @@ extern int __hash_page_64K(unsigned long ea, unsign=
ed long access,
> >  			   unsigned int local, int ssize);
> >  struct mm_struct;
> >  unsigned int hash_page_do_lazy_icache(unsigned int pp, pte_t pte, int =
trap);
> > +int calculate_vsid(struct mm_struct *mm, u64 ea,
> > +		   u64 *vsid, int *psize, int *ssize);
> >  extern int hash_page_mm(struct mm_struct *mm, unsigned long ea, unsign=
ed long access, unsigned long trap);
> >  extern int hash_page(unsigned long ea, unsigned long access, unsigned =
long trap);
> >  int __hash_page_huge(unsigned long ea, unsigned long access, unsigned =
long vsid,
> > diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_faul=
t.c
> > index 939abdf..ba8bf8e 100644
> > --- a/arch/powerpc/mm/copro_fault.c
> > +++ b/arch/powerpc/mm/copro_fault.c
> > @@ -94,45 +94,18 @@ EXPORT_SYMBOL_GPL(copro_handle_mm_fault);
> > =20
> >  int copro_data_segment(struct mm_struct *mm, u64 ea, u64 *esid, u64 *v=
sid)
> >  {
> > -	int psize, ssize;
> > +	int psize, ssize, rc;
> > =20
> >  	*esid =3D (ea & ESID_MASK) | SLB_ESID_V;
> > =20
> > -	switch (REGION_ID(ea)) {
> > -	case USER_REGION_ID:
> > -		pr_devel("copro_data_segment: 0x%llx -- USER_REGION_ID\n", ea);
> > -#ifdef CONFIG_PPC_MM_SLICES
> > -		psize =3D get_slice_psize(mm, ea);
> > -#else
> > -		psize =3D mm->context.user_psize;
> > -#endif
> > -		ssize =3D user_segment_size(ea);
> > -		*vsid =3D (get_vsid(mm->context.id, ea, ssize)
> > -			 << slb_vsid_shift(ssize)) | SLB_VSID_USER;
> > -		break;
> > -	case VMALLOC_REGION_ID:
> > -		pr_devel("copro_data_segment: 0x%llx -- VMALLOC_REGION_ID\n", ea);
> > -		if (ea < VMALLOC_END)
> > -			psize =3D mmu_vmalloc_psize;
> > -		else
> > -			psize =3D mmu_io_psize;
> > -		ssize =3D mmu_kernel_ssize;
> > -		*vsid =3D (get_kernel_vsid(ea, mmu_kernel_ssize)
> > -			 << SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
> > -		break;
> > -	case KERNEL_REGION_ID:
> > -		pr_devel("copro_data_segment: 0x%llx -- KERNEL_REGION_ID\n", ea);
> > -		psize =3D mmu_linear_psize;
> > -		ssize =3D mmu_kernel_ssize;
> > -		*vsid =3D (get_kernel_vsid(ea, mmu_kernel_ssize)
> > -			 << SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
> > -		break;
> > -	default:
> > -		/* Future: support kernel segments so that drivers can use the
> > -		 * CoProcessors */
> > -		pr_debug("invalid region access at %016llx\n", ea);
> > -		return 1;
> > -	}
> > +	rc =3D calculate_vsid(mm, ea, vsid, &psize, &ssize);
> > +	if (rc)
> > +		return rc;
> > +	if (REGION_ID(ea) =3D=3D USER_REGION_ID)
> > +		*vsid =3D (*vsid << slb_vsid_shift(ssize)) | SLB_VSID_USER;
> > +	else
> > +		*vsid =3D (*vsid << SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
> > +
> >  	*vsid |=3D mmu_psize_defs[psize].sllp |
> >  		((ssize =3D=3D MMU_SEGSIZE_1T) ? SLB_VSID_B_1T : 0);
> > =20
> > diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_uti=
ls_64.c
> > index 0a5c8c0..3fa81ca 100644
> > --- a/arch/powerpc/mm/hash_utils_64.c
> > +++ b/arch/powerpc/mm/hash_utils_64.c
> > @@ -983,6 +983,38 @@ static void check_paca_psize(unsigned long ea, str=
uct mm_struct *mm,
> >  	}
> >  }
> > =20
> > +int calculate_vsid(struct mm_struct *mm, u64 ea,
> > +		   u64 *vsid, int *psize, int *ssize)
> > +{
> > +	switch (REGION_ID(ea)) {
> > +	case USER_REGION_ID:
> > +		pr_devel("%s: 0x%llx -- USER_REGION_ID\n", __func__, ea);
> > +		*psize =3D get_slice_psize(mm, ea);
> > +		*ssize =3D user_segment_size(ea);
> > +		*vsid =3D get_vsid(mm->context.id, ea, *ssize);
> > +		return 0;
> > +	case VMALLOC_REGION_ID:
> > +		pr_devel("%s: 0x%llx -- VMALLOC_REGION_ID\n", __func__, ea);
> > +		if (ea < VMALLOC_END)
> > +			*psize =3D mmu_vmalloc_psize;
> > +		else
> > +			*psize =3D mmu_io_psize;
> > +		*ssize =3D mmu_kernel_ssize;
> > +		*vsid =3D get_kernel_vsid(ea, mmu_kernel_ssize);
> > +		return 0;
> > +	case KERNEL_REGION_ID:
> > +		pr_devel("%s: 0x%llx -- KERNEL_REGION_ID\n", __func__, ea);
> > +		*psize =3D mmu_linear_psize;
> > +		*ssize =3D mmu_kernel_ssize;
> > +		*vsid =3D get_kernel_vsid(ea, mmu_kernel_ssize);
> > +		return 0;
> > +	default:
> > +		pr_debug("%s: invalid region access at %016llx\n", __func__, ea);
> > +		return 1;
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(calculate_vsid);
> > +
> >  /* Result code is:
> >   *  0 - handled
> >   *  1 - normal page fault
> > @@ -993,7 +1025,7 @@ int hash_page_mm(struct mm_struct *mm, unsigned lo=
ng ea, unsigned long access, u
> >  {
> >  	enum ctx_state prev_state =3D exception_enter();
> >  	pgd_t *pgdir;
> > -	unsigned long vsid;
> > +	u64 vsid;
> >  	pte_t *ptep;
> >  	unsigned hugeshift;
> >  	const struct cpumask *tmp;
> > @@ -1003,35 +1035,20 @@ int hash_page_mm(struct mm_struct *mm, unsigned=
 long ea, unsigned long access, u
> >  	DBG_LOW("%s(ea=3D%016lx, access=3D%lx, trap=3D%lx\n",
> >  		__func__, ea, access, trap);
> > =20
> > -	/* Get region & vsid */
> > - 	switch (REGION_ID(ea)) {
> > -	case USER_REGION_ID:
> > +	/* Get region */
> > +	if (REGION_ID(ea) =3D=3D USER_REGION_ID) {
> >  		user_region =3D 1;
> >  		if (! mm) {
> >  			DBG_LOW(" user region with no mm !\n");
> >  			rc =3D 1;
> >  			goto bail;
> >  		}
> > -		psize =3D get_slice_psize(mm, ea);
> > -		ssize =3D user_segment_size(ea);
> > -		vsid =3D get_vsid(mm->context.id, ea, ssize);
> > -		break;
> > -	case VMALLOC_REGION_ID:
> > +	} else
> >  		mm =3D &init_mm;
> > -		vsid =3D get_kernel_vsid(ea, mmu_kernel_ssize);
> > -		if (ea < VMALLOC_END)
> > -			psize =3D mmu_vmalloc_psize;
> > -		else
> > -			psize =3D mmu_io_psize;
> > -		ssize =3D mmu_kernel_ssize;
> > -		break;
> > -	default:
> > -		/* Not a valid range
> > -		 * Send the problem up to do_page_fault=20
> > -		 */
> > -		rc =3D 1;
>=20
>=20
> That part is different now. We now handle kernel_region_id in case of
> hash_page. Earlier we used consider it a problem.=20

Yeah, that's going to be the kernel linear mapping.  We should probably
continue to barf as we shouldn't fault on that.  Thanks.

I'll fix.

Mikey

>=20
> > +	rc =3D calculate_vsid(mm, ea, &vsid, &psize, &ssize);
> > +	if (rc)
> >  		goto bail;
> > -	}
> > +
> >  	DBG_LOW(" mm=3D%p, mm->pgdir=3D%p, vsid=3D%016lx\n", mm, mm->pgd, vsi=
d);
> > =20
> >  	/* Bad address. */
> > --=20
> > 1.9.1
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>=20
