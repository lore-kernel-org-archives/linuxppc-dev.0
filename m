Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C70D1A17A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 10:58:03 +1000 (EST)
Message-ID: <1412211482.19209.83.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH v2 02/17] powerpc/cell: Move data segment faulting code
 out of cell platform
From: Michael Neuling <mikey@neuling.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Thu, 02 Oct 2014 10:58:02 +1000
In-Reply-To: <87zjdgm7zn.fsf@linux.vnet.ibm.com>
References: <1412073306-13812-1-git-send-email-mikey@neuling.org>
 <1412073306-13812-3-git-send-email-mikey@neuling.org>
 <87zjdgm7zn.fsf@linux.vnet.ibm.com>
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

On Wed, 2014-10-01 at 15:23 +0530, Aneesh Kumar K.V wrote:
> Michael Neuling <mikey@neuling.org> writes:
>=20
> > From: Ian Munsie <imunsie@au1.ibm.com>
> >
> > __spu_trap_data_seg() currently contains code to determine the VSID and=
 ESID
> > required for a particular EA and mm struct.
> >
> > This code is generically useful for other co-processors.  This moves th=
e code
> > of the cell platform so it can be used by other powerpc code.  It also =
adds 1TB
> > segment handling which Cell didn't have.
> >
> > Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >  arch/powerpc/include/asm/mmu-hash64.h  |  7 ++++-
> >  arch/powerpc/mm/copro_fault.c          | 48 ++++++++++++++++++++++++++=
++++++++
> >  arch/powerpc/mm/slb.c                  |  3 ---
> >  arch/powerpc/platforms/cell/spu_base.c | 41 +++-----------------------=
---
> >  4 files changed, 58 insertions(+), 41 deletions(-)
> >
> > diff --git a/arch/powerpc/include/asm/mmu-hash64.h b/arch/powerpc/inclu=
de/asm/mmu-hash64.h
> > index d765144..6d0b7a2 100644
> > --- a/arch/powerpc/include/asm/mmu-hash64.h
> > +++ b/arch/powerpc/include/asm/mmu-hash64.h
> > @@ -189,7 +189,12 @@ static inline unsigned int mmu_psize_to_shift(unsi=
gned int mmu_psize)
> >  #define LP_MASK(i)	((0xFF >> (i)) << LP_SHIFT)
> > =20
> >  #ifndef __ASSEMBLY__
> > -
> > +static inline int slb_vsid_shift(int ssize)
> > +{
> > +	if (ssize =3D=3D MMU_SEGSIZE_256M)
> > +		return SLB_VSID_SHIFT;
> > +	return SLB_VSID_SHIFT_1T;
> > +}
> >  static inline int segment_shift(int ssize)
> >  {
> >  	if (ssize =3D=3D MMU_SEGSIZE_256M)
> > diff --git a/arch/powerpc/mm/copro_fault.c b/arch/powerpc/mm/copro_faul=
t.c
> > index ba7df14..b865697 100644
> > --- a/arch/powerpc/mm/copro_fault.c
> > +++ b/arch/powerpc/mm/copro_fault.c
> > @@ -90,3 +90,51 @@ out_unlock:
> >  	return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(copro_handle_mm_fault);
> > +
> > +int copro_data_segment(struct mm_struct *mm, u64 ea, u64 *esid, u64 *v=
sid)
> > +{
> > +	int psize, ssize;
> > +
> > +	*esid =3D (ea & ESID_MASK) | SLB_ESID_V;
> > +
> > +	switch (REGION_ID(ea)) {
> > +	case USER_REGION_ID:
> > +		pr_devel("copro_data_segment: 0x%llx -- USER_REGION_ID\n", ea);
> > +#ifdef CONFIG_PPC_MM_SLICES
> > +		psize =3D get_slice_psize(mm, ea);
> > +#else
> > +		psize =3D mm->context.user_psize;
> > +#endif
> > +		ssize =3D user_segment_size(ea);
> > +		*vsid =3D (get_vsid(mm->context.id, ea, ssize)
> > +			 << slb_vsid_shift(ssize)) | SLB_VSID_USER;
> > +		break;
> > +	case VMALLOC_REGION_ID:
> > +		pr_devel("copro_data_segment: 0x%llx -- VMALLOC_REGION_ID\n", ea);
> > +		if (ea < VMALLOC_END)
> > +			psize =3D mmu_vmalloc_psize;
> > +		else
> > +			psize =3D mmu_io_psize;
> > +		ssize =3D mmu_kernel_ssize;
> > +		*vsid =3D (get_kernel_vsid(ea, mmu_kernel_ssize)
> > +			 << SLB_VSID_SHIFT) | SLB_VSID_KERNEL;
>=20
> why not
> 		*vsid =3D (get_kernel_vsid(ea, mmu_kernel_ssize)
> 			 << slb_vsid_shift(ssize)) | SLB_VSID_KERNEL;
>=20
> for vmalloc and kernel region ? We could end up using 1T segments for ker=
nel mapping too.

Yep, but I'm going to do this in patch 10 where the other optimisations
are for this.

Mikey
