Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RcxV6nchzF35T
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 13:00:30 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id s21-v6so21769343pfm.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2018 20:00:30 -0700 (PDT)
Date: Fri, 13 Jul 2018 13:00:19 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>, Alex Williamson
 <alex.williamson@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Paul
 Mackerras <paulus@ozlabs.org>, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH kernel v6 2/2] KVM: PPC: Check if IOMMU page is
 contained in the pinned physical page
Message-ID: <20180713130019.44e0966b@roar.ozlabs.ibm.com>
In-Reply-To: <20180711110044.15939-3-aik@ozlabs.ru>
References: <20180711110044.15939-1-aik@ozlabs.ru>
 <20180711110044.15939-3-aik@ozlabs.ru>
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

On Wed, 11 Jul 2018 21:00:44 +1000
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> A VM which has:
>  - a DMA capable device passed through to it (eg. network card);
>  - running a malicious kernel that ignores H_PUT_TCE failure;
>  - capability of using IOMMU pages bigger that physical pages
> can create an IOMMU mapping that exposes (for example) 16MB of
> the host physical memory to the device when only 64K was allocated to the VM.
> 
> The remaining 16MB - 64K will be some other content of host memory, possibly
> including pages of the VM, but also pages of host kernel memory, host
> programs or other VMs.
> 
> The attacking VM does not control the location of the page it can map,
> and is only allowed to map as many pages as it has pages of RAM.
> 
> We already have a check in drivers/vfio/vfio_iommu_spapr_tce.c that
> an IOMMU page is contained in the physical page so the PCI hardware won't
> get access to unassigned host memory; however this check is missing in
> the KVM fastpath (H_PUT_TCE accelerated code). We were lucky so far and
> did not hit this yet as the very first time when the mapping happens
> we do not have tbl::it_userspace allocated yet and fall back to
> the userspace which in turn calls VFIO IOMMU driver, this fails and
> the guest does not retry,
> 
> This stores the smallest preregistered page size in the preregistered
> region descriptor and changes the mm_iommu_xxx API to check this against
> the IOMMU page size.
> 
> This calculates maximum page size as a minimum of the natural region
> alignment and compound page size. For the page shift this uses the shift
> returned by find_linux_pte() which indicates how the page is mapped to
> the current userspace - if the page is huge and this is not a zero, then
> it is a leaf pte and the page is mapped within the range.
> 
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
> Changes:
> v6:
> * replaced hugetlbfs with pageshift from find_linux_pte()
> 
> v5:
> * only consider compound pages from hugetlbfs
> 
> v4:
> * reimplemented max pageshift calculation
> 
> v3:
> * fixed upper limit for the page size
> * added checks that we don't register parts of a huge page
> 
> v2:
> * explicitely check for compound pages before calling compound_order()
> 
> ---
> The bug is: run QEMU _without_ hugepages (no -mempath) and tell it to
> advertise 16MB pages to the guest; a typical pseries guest will use 16MB
> for IOMMU pages without checking the mmu pagesize and this will fail
> at https://git.qemu.org/?p=qemu.git;a=blob;f=hw/vfio/common.c;h=fb396cf00ac40eb35967a04c9cc798ca896eed57;hb=refs/heads/master#l256
> 
> With the change, mapping will fail in KVM and the guest will print:
> 
> mlx5_core 0000:00:00.0: ibm,create-pe-dma-window(2027) 0 8000000 20000000 18 1f returned 0 (liobn = 0x80000001 starting addr = 8000000 0)
> mlx5_core 0000:00:00.0: created tce table LIOBN 0x80000001 for /pci@800000020000000/ethernet@0
> mlx5_core 0000:00:00.0: failed to map direct window for /pci@800000020000000/ethernet@0: -1
> ---
>  arch/powerpc/include/asm/mmu_context.h |  4 ++--
>  arch/powerpc/kvm/book3s_64_vio.c       |  2 +-
>  arch/powerpc/kvm/book3s_64_vio_hv.c    |  6 ++++--
>  arch/powerpc/mm/mmu_context_iommu.c    | 39 ++++++++++++++++++++++++++++++++--
>  drivers/vfio/vfio_iommu_spapr_tce.c    |  2 +-
>  5 files changed, 45 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
> index 896efa5..79d570c 100644
> --- a/arch/powerpc/include/asm/mmu_context.h
> +++ b/arch/powerpc/include/asm/mmu_context.h
> @@ -35,9 +35,9 @@ extern struct mm_iommu_table_group_mem_t *mm_iommu_lookup_rm(
>  extern struct mm_iommu_table_group_mem_t *mm_iommu_find(struct mm_struct *mm,
>  		unsigned long ua, unsigned long entries);
>  extern long mm_iommu_ua_to_hpa(struct mm_iommu_table_group_mem_t *mem,
> -		unsigned long ua, unsigned long *hpa);
> +		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
>  extern long mm_iommu_ua_to_hpa_rm(struct mm_iommu_table_group_mem_t *mem,
> -		unsigned long ua, unsigned long *hpa);
> +		unsigned long ua, unsigned int pageshift, unsigned long *hpa);
>  extern long mm_iommu_mapped_inc(struct mm_iommu_table_group_mem_t *mem);
>  extern void mm_iommu_mapped_dec(struct mm_iommu_table_group_mem_t *mem);
>  #endif
> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
> index d066e37..8c456fa 100644
> --- a/arch/powerpc/kvm/book3s_64_vio.c
> +++ b/arch/powerpc/kvm/book3s_64_vio.c
> @@ -449,7 +449,7 @@ long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
>  		/* This only handles v2 IOMMU type, v1 is handled via ioctl() */
>  		return H_TOO_HARD;
>  
> -	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, &hpa)))
> +	if (WARN_ON_ONCE(mm_iommu_ua_to_hpa(mem, ua, tbl->it_page_shift, &hpa)))
>  		return H_HARDWARE;
>  
>  	if (mm_iommu_mapped_inc(mem))
> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
> index 925fc31..5b298f5 100644
> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> @@ -279,7 +279,8 @@ static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
>  	if (!mem)
>  		return H_TOO_HARD;
>  
> -	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, &hpa)))
> +	if (WARN_ON_ONCE_RM(mm_iommu_ua_to_hpa_rm(mem, ua, tbl->it_page_shift,
> +			&hpa)))
>  		return H_HARDWARE;
>  
>  	pua = (void *) vmalloc_to_phys(pua);
> @@ -469,7 +470,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>  
>  		mem = mm_iommu_lookup_rm(vcpu->kvm->mm, ua, IOMMU_PAGE_SIZE_4K);
>  		if (mem)
> -			prereg = mm_iommu_ua_to_hpa_rm(mem, ua, &tces) == 0;
> +			prereg = mm_iommu_ua_to_hpa_rm(mem, ua,
> +					IOMMU_PAGE_SHIFT_4K, &tces) == 0;
>  	}
>  
>  	if (!prereg) {
> diff --git a/arch/powerpc/mm/mmu_context_iommu.c b/arch/powerpc/mm/mmu_context_iommu.c
> index abb4364..0bb53a7 100644
> --- a/arch/powerpc/mm/mmu_context_iommu.c
> +++ b/arch/powerpc/mm/mmu_context_iommu.c
> @@ -19,6 +19,7 @@
>  #include <linux/hugetlb.h>
>  #include <linux/swap.h>
>  #include <asm/mmu_context.h>
> +#include <asm/pte-walk.h>
>  
>  static DEFINE_MUTEX(mem_list_mutex);
>  
> @@ -27,6 +28,7 @@ struct mm_iommu_table_group_mem_t {
>  	struct rcu_head rcu;
>  	unsigned long used;
>  	atomic64_t mapped;
> +	unsigned int pageshift;
>  	u64 ua;			/* userspace address */
>  	u64 entries;		/* number of entries in hpas[] */
>  	u64 *hpas;		/* vmalloc'ed */
> @@ -125,6 +127,8 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
>  {
>  	struct mm_iommu_table_group_mem_t *mem;
>  	long i, j, ret = 0, locked_entries = 0;
> +	unsigned int pageshift;
> +	unsigned long flags;
>  	struct page *page = NULL;
>  
>  	mutex_lock(&mem_list_mutex);
> @@ -159,6 +163,12 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
>  		goto unlock_exit;
>  	}
>  
> +	/*
> +	 * For a starting point for a maximum page size calculation
> +	 * we use @ua and @entries natural alignment to allow IOMMU pages
> +	 * smaller than huge pages but still bigger than PAGE_SIZE.
> +	 */
> +	mem->pageshift = __ffs(ua | (entries << PAGE_SHIFT));
>  	mem->hpas = vzalloc(array_size(entries, sizeof(mem->hpas[0])));
>  	if (!mem->hpas) {
>  		kfree(mem);
> @@ -199,6 +209,25 @@ long mm_iommu_get(struct mm_struct *mm, unsigned long ua, unsigned long entries,
>  			}
>  		}
>  populate:
> +		pageshift = PAGE_SHIFT;
> +		if (PageCompound(page)) {
> +			pte_t *pte;
> +			struct page *head = compound_head(page);
> +			unsigned int compshift = compound_order(head);
> +
> +			local_irq_save(flags); /* disables as well */
> +			pte = find_linux_pte(mm->pgd, ua, NULL, &pageshift);
> +			local_irq_restore(flags);
> +			if (!pte) {
> +				ret = -EFAULT;
> +				goto unlock_exit;
> +			}
> +			/* Double check it is still the same pinned page */
> +			if (pte_page(*pte) == head && pageshift == compshift)
> +				pageshift = max_t(unsigned int, pageshift,
> +						PAGE_SHIFT);
> +		}

Okay, I missed that you're setting pageshift to minimum first, so if
the page doesn't match then it falls back. In that case the patch seems
fine.

Nothing is pinning the virtual mapping (truncate or munmap can get rid
of it), but page you got a refcount on will not be freed or split, I
think that's all you care about?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
