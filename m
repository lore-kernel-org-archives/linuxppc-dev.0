Return-Path: <aik@ozlabs.ru>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41NBBg5B9czDqv6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2018 22:44:59 +1000 (AEST)
Received: by mail-pl0-x244.google.com with SMTP id m16-v6so4052891pls.11
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 07 Jul 2018 05:44:59 -0700 (PDT)
Date: Sat, 7 Jul 2018 22:44:45 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, Alex Williamson
 <alex.williamson@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@ozlabs.org>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH kernel v5 2/2] KVM: PPC: Check if IOMMU page is
 contained in the pinned physical page
Message-ID: <20180707224445.24664324@aikyoga2>
In-Reply-To: <20180707214303.1daafccc@roar.ozlabs.ibm.com>
References: <20180707104410.46589-1-aik@ozlabs.ru>
 <20180707104410.46589-3-aik@ozlabs.ru>
 <20180707214303.1daafccc@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 7 Jul 2018 21:43:03 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> On Sat,  7 Jul 2018 20:44:10 +1000
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
> > A VM which has:
> >  - a DMA capable device passed through to it (eg. network card);
> >  - running a malicious kernel that ignores H_PUT_TCE failure;
> >  - capability of using IOMMU pages bigger that physical pages
> > can create an IOMMU mapping that exposes (for example) 16MB of
> > the host physical memory to the device when only 64K was allocated to the VM.
> > 
> > The remaining 16MB - 64K will be some other content of host memory, possibly
> > including pages of the VM, but also pages of host kernel memory, host
> > programs or other VMs.
> > 
> > The attacking VM does not control the location of the page it can map,
> > and is only allowed to map as many pages as it has pages of RAM.
> > 
> > We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c that
> > an IOMMU page is contained in the physical page so the PCI hardware won't
> > get access to unassigned host memory; however this check is missing in
> > the KVM fastpath (H_PUT_TCE accelerated code). We were lucky so far and
> > did not hit this yet as the very first time when the mapping happens
> > we do not have tbl::it_userspace allocated yet and fall back to
> > the userspace which in turn calls VFIO IOMMU driver, this fails and
> > the guest does not retry,
> > 
> > This stores the smallest preregistered page size in the preregistered
> > region descriptor and changes the mm_iommu_xxx API to check this against
> > the IOMMU page size. This calculates maximum page size as a minimum of
> > the natural region alignment and hugepagetlb's compound page size.
> > 
> > Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> > Changes:
> > v5:
> > * only consider compound pages from hugetlbfs
> > 
> > v4:
> > * reimplemented max pageshift calculation
> > 
> > v3:
> > * fixed upper limit for the page size
> > * added checks that we don't register parts of a huge page
> > 
> > v2:
> > * explicitely check for compound pages before calling compound_order()
> > 
> > ---
> > The bug is: run QEMU _without_ hugepages (no -mempath) and tell it to
> > advertise 16MB pages to the guest; a typical pseries guest will use 16MB
> > for IOMMU pages without checking the mmu pagesize and this will fail
> > at https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/common.c;h=fb396cf00ac40eb35967a04c9cc798ca896eed57;hb=refs/heads/master#l256
> > 
> > With the change, mapping will fail in KVM and the guest will print:
> > 
> > mlx5_core 0000:00:00.0: ibm,create-pe-dma-window(2027) 0 8000000 20000000 18 1f returned 0 (liobn = 0x80000001 starting addr = 8000000 0)
> > mlx5_core 0000:00:00.0: created tce table LIOBN 0x80000001 for /pci@800000020000000/ethernet@0
> > mlx5_core 0000:00:00.0: failed to map direct window for /pci@800000020000000/ethernet@0: -1
> > ---
> >  arch/powerpc/include/asm/mmu_context.h |  4 ++--
> >  arch/powerpc/kvm/book3s_64_vio.c       |  2 +-
> >  arch/powerpc/kvm/book3s_64_vio_hv.c    |  6 ++++--
> >  arch/powerpc/mm/mmu_context_iommu.c    | 33 +++++++++++++++++++++++++++------
> >  drivers/vfio/vfio_iommu_spapr_tce.c    |  2 +-
> >  5 files changed, 35 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> > index 896efa5..79d570c 100644
> > --- a/arch/powerpc/include/asm/mmu_context.h
> > +++ b/arch/powerpc/include/asm/mmu_context.h
> > @@ -35,9 +35,9 @@ extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(
> >  extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
> >  		unsigned long ua, unsigned long entries);
> >  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> > -		unsigned long ua, unsigned long *hpa);
> > +		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
> >  extern long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
> > -		unsigned long ua, unsigned long *hpa);
> > +		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
> >  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
> >  extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
> >  #endif
> > diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> > index d066e37..8c456fa 100644
> > --- a/arch/powerpc/kvm/book3s_64_vio.c
> > +++ b/arch/powerpc/kvm/book3s_64_vio.c
> > @@ -449,7 +449,7 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
> >  		/* This only handles v2 IOMMU type, v1 is handled via ioctl() */
> >  		return H_TOO_HARD;
> >  
> > -	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, &hpa)))
> > +	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, tbl->it_page_shift, &hpa)))
> >  		return H_HARDWARE;
> >  
> >  	if (mm_iommu_mapped_inc(mem))
> > diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
> > index 925fc31..5b298f5 100644
> > --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> > +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> > @@ -279,7 +279,8 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
> >  	if (!mem)
> >  		return H_TOO_HARD;
> >  
> > -	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, &hpa)))
> > +	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, tbl->it_page_shift,
> > +			&hpa)))
> >  		return H_HARDWARE;
> >  
> >  	pua = (void *) vmalloc_to_phys(pua);
> > @@ -469,7 +470,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
> >  
> >  		mem = mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
> >  		if (mem)
> > -			prereg = mm_iommu_ua_to_hpa_rm(mem, ua, &tces) == 0;
> > +			prereg = mm_iommu_ua_to_hpa_rm(mem, ua,
> > +					IOMMU_PAGE_SHIFT_4K, &tces) == 0;
> >  	}
> >  
> >  	if (!prereg) {
> > diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> > index abb4364..0aebed6 100644
> > --- a/arch/powerpc/mm/mmu_context_iommu.c
> > +++ b/arch/powerpc/mm/mmu_context_iommu.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/migrate.h>
> >  #include <linux/hugetlb.h>
> >  #include <linux/swap.h>
> > +#include <linux/hugetlb.h>
> >  #include <asm/mmu_context.h>
> >  
> >  static DEFINE_MUTEX(mem_list_mutex);
> > @@ -27,6 +28,7 @@ struct mm_iommu_table_group_mem_t {
> >  	struct rcu_head rcu;
> >  	unsigned long used;
> >  	atomic64_t mapped;
> > +	unsigned int pageshift;
> >  	u64 ua;			/* userspace address */
> >  	u64 entries;		/* number of entries in hpas[] */
> >  	u64 *hpas;		/* vmalloc'ed */
> > @@ -125,6 +127,7 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
> >  {
> >  	struct mm_iommu_table_group_mem_t *mem;
> >  	long i, j, ret = 0, locked_entries = 0;
> > +	unsigned int pageshift;
> >  	struct page *page = NULL;
> >  
> >  	mutex_lock(&mem_list_mutex);
> > @@ -159,6 +162,11 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
> >  		goto unlock_exit;
> >  	}
> >  
> > +	/*
> > +	 * Use @ua and @entries alignment as a starting point for a maximum
> > +	 * page size calculation below.
> > +	 */
> > +	mem->pageshift = __ffs(ua | (entries << PAGE_SHIFT));
> >  	mem->hpas = vzalloc(array_size(entries, sizeof(mem->hpas[0])));
> >  	if (!mem->hpas) {
> >  		kfree(mem);  
> 
> I think it would be better to start with UINT_MAX or something to make
> it clear that it's not a valid "guess" but rather just a starting point
> for the min().

This is to handle unaligned @ua/@entries backed by a huge page. For
example, 1GB page and we are preregistering only a second half of it -
the maximum pageshift should be 29 instead of 30 which it will be if we
start from 64.


> 
> > @@ -167,8 +175,11 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
> >  	}
> >  
> >  	for (i = 0; i < entries; ++i) {
> > -		if (1 != get_user_pages_fast(ua + (i << PAGE_SHIFT),
> > -					1/* pages */, 1/* iswrite */, &page)) {
> > +		struct vm_area_struct *vma = NULL;
> > +
> > +		if (1 != get_user_pages(ua + (i << PAGE_SHIFT),
> > +					1/* pages */, 1/* iswrite */, &page,
> > +					&vma)) {
> >  			ret = -EFAULT;
> >  			for (j = 0; j < i; ++j)
> >  				put_page(pfn_to_page(mem->hpas[j] >>  
> 
> You need mmap_sem for read here, and held while you inspect the vma.
> I would say don't hold it over the error handling and the
> mm_iommu_move_page_from_cma() call though.


Ah, this is why it deadlocked when I tried this.

But do I really need mmap_sem here? get_user_pages_longterm() inspects
vma with no mmap_sem held in case of VFIO IOMMU Type1:

vfio_fops_unl_ioctl
  vfio_iommu_type1_ioctl
    vfio_dma_do_map
      vfio_pin_map_dma
        vfio_pin_pages_remote
          vaddr_get_pfn
            get_user_pages_longterm

Is that a bug? Other cases seem to hold it though.

> 
> > @@ -186,9 +197,9 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
> >  		if (is_migrate_cma_page(page)) {
> >  			if (mm_iommu_move_page_from_cma(page))
> >  				goto populate;
> > -			if (1 != get_user_pages_fast(ua + (i << PAGE_SHIFT),
> > +			if (1 != get_user_pages(ua + (i << PAGE_SHIFT),
> >  						1/* pages */, 1/* iswrite */,
> > -						&page)) {
> > +						&page, &vma)) {
> >  				ret = -EFAULT;
> >  				for (j = 0; j < i; ++j)
> >  					put_page(pfn_to_page(mem->hpas[j] >>
> > @@ -199,6 +210,10 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
> >  			}
> >  		}
> >  populate:
> > +		pageshift = PAGE_SHIFT;
> > +		if (vma && vma->vm_file && is_file_hugepages(vma->vm_file))
> > +			pageshift += hstate_vma(vma)->order;  
> 
> I would just set to huge_page_shift() here so you don't expose this
> hstate quirk that adds order to PAGE_SIZE.

Ah, right, there is a million helpers for this :)

 
> > +		mem->pageshift = min(mem->pageshift, pageshift);
> >  		mem->hpas[i] = page_to_pfn(page) << PAGE_SHIFT;
> >  	}
> >    
> 
> Otherwise the mm side of things looks okay, I think.

Thanks for the review.

--
Alexey
