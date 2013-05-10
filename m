Return-Path: <aik@ozlabs.ru>
Received: from mail-ia0-x22f.google.com (mail-ia0-x22f.google.com
 [IPv6:2607:f8b0:4001:c02::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7AC522C00F6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 17:54:09 +1000 (EST)
Received: by mail-ia0-f175.google.com with SMTP id m10so1193205iam.34
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 00:54:07 -0700 (PDT)
Message-ID: <518CA797.3020400@ozlabs.ru>
Date: Fri, 10 May 2013 17:53:59 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/6] KVM: PPC: Add support for multiple-TCE hcalls
References: <1367825157-27231-1-git-send-email-aik@ozlabs.ru>
 <1367825157-27231-3-git-send-email-aik@ozlabs.ru>
 <20130510065101.GF23358@truffula.fritz.box>
In-Reply-To: <20130510065101.GF23358@truffula.fritz.box>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Joerg Roedel <joerg.roedel@amd.com>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/10/2013 04:51 PM, David Gibson wrote:
> On Mon, May 06, 2013 at 05:25:53PM +1000, Alexey Kardashevskiy wrote:
>> This adds real mode handlers for the H_PUT_TCE_INDIRECT and
>> H_STUFF_TCE hypercalls for QEMU emulated devices such as virtio
>> devices or emulated PCI.  These calls allow adding multiple entries
>> (up to 512) into the TCE table in one call which saves time on
>> transition to/from real mode.
>>
>> This adds a guest physical to host real address converter
>> and calls the existing H_PUT_TCE handler. The converting function
>> is going to be fully utilized by upcoming VFIO supporting patches.
>>
>> This also implements the KVM_CAP_PPC_MULTITCE capability,
>> so in order to support the functionality of this patch, QEMU
>> needs to query for this capability and set the "hcall-multi-tce"
>> hypertas property only if the capability is present, otherwise
>> there will be serious performance degradation.
> 
> 
> Hrm.  Clearly I didn't read this carefully enough before.  There are
> some problems here.

?


> [snip]
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>> index 72ffc89..643ac1e 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -14,6 +14,7 @@
>>   *
>>   * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>>   * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
>> + * Copyright 2013 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
>>   */
>>  
>>  #include <linux/types.h>
>> @@ -36,9 +37,14 @@
>>  #include <asm/ppc-opcode.h>
>>  #include <asm/kvm_host.h>
>>  #include <asm/udbg.h>
>> +#include <asm/iommu.h>
>>  
>>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
>> +#define ERROR_ADDR      (~(unsigned long)0x0)
>>  
>> +/*
>> + * TCE tables handlers.
>> + */
>>  static long kvmppc_stt_npages(unsigned long window_size)
>>  {
>>  	return ALIGN((window_size >> SPAPR_TCE_SHIFT)
>> @@ -148,3 +154,111 @@ fail:
>>  	}
>>  	return ret;
>>  }
>> +
>> +/*
>> + * Virtual mode handling of IOMMU map/unmap.
>> + */
>> +/* Converts guest physical address into host virtual */
>> +static unsigned long get_virt_address(struct kvm_vcpu *vcpu,
>> +		unsigned long gpa)
> 
> This should probably return a void * rather than an unsigned long.
> Well, actually a void __user *.
> 
>> +{
>> +	unsigned long hva, gfn = gpa >> PAGE_SHIFT;
>> +	struct kvm_memory_slot *memslot;
>> +
>> +	memslot = search_memslots(kvm_memslots(vcpu->kvm), gfn);
>> +	if (!memslot)
>> +		return ERROR_ADDR;
>> +
>> +	/*
>> +	 * Convert gfn to hva preserving flags and an offset
>> +	 * within a system page
>> +	 */
>> +	hva = __gfn_to_hva_memslot(memslot, gfn) + (gpa & ~PAGE_MASK);
>> +	return hva;
>> +}
>> +
>> +long kvmppc_virtmode_h_put_tce(struct kvm_vcpu *vcpu,
>> +		unsigned long liobn, unsigned long ioba,
>> +		unsigned long tce)
>> +{
>> +	struct kvmppc_spapr_tce_table *tt;
>> +
>> +	tt = kvmppc_find_tce_table(vcpu, liobn);
>> +	/* Didn't find the liobn, put it to userspace */
>> +	if (!tt)
>> +		return H_TOO_HARD;
>> +
>> +	/* Emulated IO */
>> +	return kvmppc_emulated_h_put_tce(tt, ioba, tce);
>> +}
>> +
>> +long kvmppc_virtmode_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>> +		unsigned long liobn, unsigned long ioba,
>> +		unsigned long tce_list, unsigned long npages)
>> +{
>> +	struct kvmppc_spapr_tce_table *tt;
>> +	long i;
>> +	unsigned long tces;
>> +
>> +	/* The whole table addressed by tce_list resides in 4K page */
>> +	if (npages > 512)
>> +		return H_PARAMETER;
> 
> So, that doesn't actually verify what the comment says it does - only
> that the list is < 4K in total.  You need to check the alignment of
> tce_list as well.



The spec says to return H_PARAMETER if >512. I.e. it takes just 1 page and
I do not need to bother if pages may not lay continuously in RAM (matters
for real mode).

/*
 * As the spec is saying that maximum possible number of TCEs is 512,
 * the whole TCE page is no more than 4K. Therefore we do not have to
 * worry if pages do not lie continuously in the RAM
 */
Any better?...


>> +
>> +	tt = kvmppc_find_tce_table(vcpu, liobn);
>> +	/* Didn't find the liobn, put it to userspace */
>> +	if (!tt)
>> +		return H_TOO_HARD;
>> +
>> +	tces = get_virt_address(vcpu, tce_list);
>> +	if (tces == ERROR_ADDR)
>> +		return H_TOO_HARD;
>> +
>> +	/* Emulated IO */
> 
> This comment doesn't seem to have any bearing on the test which
> follows it.
> 
>> +	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
>> +		return H_PARAMETER;
>> +
>> +	for (i = 0; i < npages; ++i) {
>> +		unsigned long tce;
>> +		unsigned long ptce = tces + i * sizeof(unsigned long);
>> +
>> +		if (get_user(tce, (unsigned long __user *)ptce))
>> +			break;
>> +
>> +		if (kvmppc_emulated_h_put_tce(tt,
>> +				ioba + (i << IOMMU_PAGE_SHIFT),	tce))
>> +			break;
>> +	}
>> +	if (i == npages)
>> +		return H_SUCCESS;
>> +
>> +	/* Failed, do cleanup */
>> +	do {
>> +		--i;
>> +		kvmppc_emulated_h_put_tce(tt, ioba + (i << IOMMU_PAGE_SHIFT),
>> +				0);
>> +	} while (i);
> 
> Hrm, so, actually PAPR specifies that this hcall is supposed to first
> copy the given tces to hypervisor memory, then translate (and
> validate) them all, and only then touch the actual TCE table.  Rather
> more complicated to do, but I guess we should - that would get rid of
> the need for this partial cleanup in the failure case.


So we have to kmalloc(4K) on every PUT_INDIRECT. Or we can put tces on the
stack (4K is quire a lot for the kernel, no)?



>> +
>> +	return H_PARAMETER;
>> +}
>> +
>> +long kvmppc_virtmode_h_stuff_tce(struct kvm_vcpu *vcpu,
>> +		unsigned long liobn, unsigned long ioba,
>> +		unsigned long tce_value, unsigned long npages)
>> +{
>> +	struct kvmppc_spapr_tce_table *tt;
>> +	long i;
>> +
>> +	tt = kvmppc_find_tce_table(vcpu, liobn);
>> +	/* Didn't find the liobn, put it to userspace */
>> +	if (!tt)
>> +		return H_TOO_HARD;
>> +
>> +	/* Emulated IO */
>> +	if ((ioba + (npages << IOMMU_PAGE_SHIFT)) > tt->window_size)
>> +		return H_PARAMETER;
>> +
>> +	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE)
>> +		kvmppc_emulated_h_put_tce(tt, ioba, tce_value);
>> +
>> +	return H_SUCCESS;
>> +}
>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> index 30c2f3b..55fdf7a 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> @@ -14,6 +14,7 @@
>>   *
>>   * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>>   * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
>> + * Copyright 2013 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
>>   */
>>  
>>  #include <linux/types.h>
>> @@ -35,42 +36,214 @@
>>  #include <asm/ppc-opcode.h>
>>  #include <asm/kvm_host.h>
>>  #include <asm/udbg.h>
>> +#include <asm/iommu.h>
>> +#include <asm/tce.h>
>>  
>>  #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
>> +#define ERROR_ADDR      (~(unsigned long)0x0)
>>  
>> -/* WARNING: This will be called in real-mode on HV KVM and virtual
>> - *          mode on PR KVM
>> +/*
>> + * Finds a TCE table descriptor by LIOBN.
>>   */
>> +struct kvmppc_spapr_tce_table *kvmppc_find_tce_table(struct kvm_vcpu *vcpu,
>> +		unsigned long liobn)
>> +{
>> +	struct kvmppc_spapr_tce_table *tt;
>> +
>> +	list_for_each_entry(tt, &vcpu->kvm->arch.spapr_tce_tables, list) {
>> +		if (tt->liobn == liobn)
>> +			return tt;
>> +	}
>> +
>> +	return NULL;
>> +}
>> +EXPORT_SYMBOL_GPL(kvmppc_find_tce_table);
>> +
>> +/*
>> + * kvmppc_emulated_h_put_tce() handles TCE requests for devices emulated
>> + * by QEMU. It puts guest TCE values into the table and expects
>> + * the QEMU to convert them later in the QEMU device implementation.
>> + * Works in both real and virtual modes.
>> + */
>> +long kvmppc_emulated_h_put_tce(struct kvmppc_spapr_tce_table *tt,
>> +		unsigned long ioba, unsigned long tce)
>> +{
>> +	unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
>> +	struct page *page;
>> +	u64 *tbl;
>> +
>> +	/* udbg_printf("H_PUT_TCE: liobn 0x%lx => tt=%p  window_size=0x%x\n", */
>> +	/*	    liobn, tt, tt->window_size); */
>> +	if (ioba >= tt->window_size) {
>> +		/* pr_err("%s failed on ioba=%lx\n", __func__, ioba); */
>> +		return H_PARAMETER;
>> +	}
>> +	/*
>> +	 * Note on the use of page_address() in real mode,
>> +	 *
>> +	 * It is safe to use page_address() in real mode on ppc64 because
>> +	 * page_address() is always defined as lowmem_page_address()
>> +	 * which returns __va(PFN_PHYS(page_to_pfn(page))) which is arithmetial
>> +	 * operation and does not access page struct.
>> +	 *
>> +	 * Theoretically page_address() could be defined different
>> +	 * but either WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL
>> +	 * should be enabled.
>> +	 * WANT_PAGE_VIRTUAL is never enabled on ppc32/ppc64,
>> +	 * HASHED_PAGE_VIRTUAL could be enabled for ppc32 only and only
>> +	 * if CONFIG_HIGHMEM is defined. As CONFIG_SPARSEMEM_VMEMMAP
>> +	 * is not expected to be enabled on ppc32, page_address()
>> +	 * is safe for ppc32 as well.
>> +	 */
>> +#if defined(HASHED_PAGE_VIRTUAL) || defined(WANT_PAGE_VIRTUAL)
>> +#error TODO: fix to avoid page_address() here
>> +#endif
>> +	page = tt->pages[idx / TCES_PER_PAGE];
>> +	tbl = (u64 *)page_address(page);
>> +
>> +	/*
>> +	 * Validate TCE address.
>> +	 * At the moment only flags are validated
>> +	 * as other check will significantly slow down
>> +	 * or can make it even impossible to handle TCE requests
>> +	 * in real mode.
>> +	 */
>> +	if (tce & ~(IOMMU_PAGE_MASK | TCE_PCI_WRITE | TCE_PCI_READ))
>> +		return H_PARAMETER;
>> +
>> +	/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
>> +	tbl[idx % TCES_PER_PAGE] = tce;
>> +
>> +	return H_SUCCESS;
>> +}
>> +EXPORT_SYMBOL_GPL(kvmppc_emulated_h_put_tce);
>> +
>> +#ifdef CONFIG_KVM_BOOK3S_64_HV
>> +/*
>> + * Converts guest physical address into host real address.
>> + * Also returns pte and page size if the page is present in page table.
>> + */
>> +static unsigned long get_real_address(struct kvm_vcpu *vcpu,
>> +		unsigned long gpa, bool writing,
>> +		pte_t *ptep, unsigned long *pg_sizep)
> 
> The only caller doesn't use the ptep and pg_sizep pointers, so there's
> no point implementing them.


"KVM: PPC: Add support for IOMMU in-kernel handling" will. Is there much
sense in splitting this quite small function between patches?




-- 
Alexey
