Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 784191A11B7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 18:24:24 +1100 (AEDT)
Received: by mail-pf0-x236.google.com with SMTP id o64so101933431pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 23:24:24 -0800 (PST)
Subject: Re: [PATCH kernel 7/9] KVM: PPC: Move reusable bits of H_PUT_TCE
 handler to helpers
To: David Gibson <david@gibson.dropbear.id.au>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
 <1442314179-9706-8-git-send-email-aik@ozlabs.ru>
 <20151208052740.GS20139@voom.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5678FAA0.90404@ozlabs.ru>
Date: Tue, 22 Dec 2015 18:24:16 +1100
MIME-Version: 1.0
In-Reply-To: <20151208052740.GS20139@voom.fritz.box>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/08/2015 04:27 PM, David Gibson wrote:
> On Tue, Sep 15, 2015 at 08:49:37PM +1000, Alexey Kardashevskiy wrote:
>> Upcoming multi-tce support (H_PUT_TCE_INDIRECT/H_STUFF_TCE hypercalls)
>> will validate TCE (not to have unexpected bits) and IO address
>> (to be within the DMA window boundaries).
>>
>> This introduces helpers to validate TCE and IO address.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>   arch/powerpc/include/asm/kvm_ppc.h  |  4 ++
>>   arch/powerpc/kvm/book3s_64_vio_hv.c | 89 ++++++++++++++++++++++++++++++++-----
>>   2 files changed, 83 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index c6ef05b..fcde896 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -166,6 +166,10 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
>>
>>   extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>>   				struct kvm_create_spapr_tce *args);
>> +extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>> +		unsigned long ioba, unsigned long npages);
>> +extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
>> +		unsigned long tce);
>>   extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>   			     unsigned long ioba, unsigned long tce);
>>   extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> index 6cf1ab3..f0fd84c 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> @@ -36,6 +36,7 @@
>>   #include <asm/kvm_host.h>
>>   #include <asm/udbg.h>
>>   #include <asm/iommu.h>
>> +#include <asm/tce.h>
>>
>>   #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
>>
>> @@ -64,7 +65,7 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
>>    * WARNING: This will be called in real-mode on HV KVM and virtual
>>    *          mode on PR KVM
>>    */
>> -static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>> +long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>>   		unsigned long ioba, unsigned long npages)
>>   {
>>   	unsigned long mask = (1ULL << IOMMU_PAGE_SHIFT_4K) - 1;
>> @@ -76,6 +77,79 @@ static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>>
>>   	return H_SUCCESS;
>>   }
>> +EXPORT_SYMBOL_GPL(kvmppc_ioba_validate);
>
> Why does it need to be exported - the new users will still be in the
> KVM module, won't they?


book3s_64_vio_hv.c contains realmode code and is always compiled into 
vmlinux and the helper is meant to be called from book3s_64_vio.c which may 
compile as a module.


>
>> +
>> +/*
>> + * Validates TCE address.
>> + * At the moment flags and page mask are validated.
>> + * As the host kernel does not access those addresses (just puts them
>> + * to the table and user space is supposed to process them), we can skip
>> + * checking other things (such as TCE is a guest RAM address or the page
>> + * was actually allocated).
>
> Hmm.  These comments apply given that the only current user of this is
> the kvm acceleration of userspace TCE tables, but the name suggests it
> would validate any TCE, including in kernel ones for which this would
> be unsafe.


The function has the "kvmppc_" prefix and the file besides in 
arch/powerpc/kvm, so to my taste it is self-explanatory that it only 
handles TCEs from KVM guests (not even from a random user-space tool), no?



>> + * WARNING: This will be called in real-mode on HV KVM and virtual
>> + *          mode on PR KVM
>> + */
>> +long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *stt, unsigned long tce)
>> +{
>> +	unsigned long mask = ((1ULL << IOMMU_PAGE_SHIFT_4K) - 1) &
>> +			~(TCE_PCI_WRITE | TCE_PCI_READ);
>> +
>> +	if (tce & mask)
>> +		return H_PARAMETER;
>> +
>> +	return H_SUCCESS;
>> +}
>> +EXPORT_SYMBOL_GPL(kvmppc_tce_validate);
>> +
>> +/* Note on the use of page_address() in real mode,
>> + *
>> + * It is safe to use page_address() in real mode on ppc64 because
>> + * page_address() is always defined as lowmem_page_address()
>> + * which returns __va(PFN_PHYS(page_to_pfn(page))) which is arithmetial
>> + * operation and does not access page struct.
>> + *
>> + * Theoretically page_address() could be defined different
>> + * but either WANT_PAGE_VIRTUAL or HASHED_PAGE_VIRTUAL
>> + * should be enabled.
>> + * WANT_PAGE_VIRTUAL is never enabled on ppc32/ppc64,
>> + * HASHED_PAGE_VIRTUAL could be enabled for ppc32 only and only
>> + * if CONFIG_HIGHMEM is defined. As CONFIG_SPARSEMEM_VMEMMAP
>> + * is not expected to be enabled on ppc32, page_address()
>> + * is safe for ppc32 as well.
>> + *
>> + * WARNING: This will be called in real-mode on HV KVM and virtual
>> + *          mode on PR KVM
>> + */
>> +static u64 *kvmppc_page_address(struct page *page)
>> +{
>> +#if defined(HASHED_PAGE_VIRTUAL) || defined(WANT_PAGE_VIRTUAL)
>> +#error TODO: fix to avoid page_address() here
>> +#endif
>> +	return (u64 *) page_address(page);
>> +}
>> +
>> +/*
>> + * Handles TCE requests for emulated devices.
>> + * Puts guest TCE values to the table and expects user space to convert them.
>> + * Called in both real and virtual modes.
>> + * Cannot fail so kvmppc_tce_validate must be called before it.
>> + *
>> + * WARNING: This will be called in real-mode on HV KVM and virtual
>> + *          mode on PR KVM
>> + */
>> +void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
>> +		unsigned long idx, unsigned long tce)
>> +{
>> +	struct page *page;
>> +	u64 *tbl;
>> +
>> +	page = stt->pages[idx / TCES_PER_PAGE];
>> +	tbl = kvmppc_page_address(page);
>> +
>> +	tbl[idx % TCES_PER_PAGE] = tce;
>> +}
>> +EXPORT_SYMBOL_GPL(kvmppc_tce_put);
>>
>>   /* WARNING: This will be called in real-mode on HV KVM and virtual
>>    *          mode on PR KVM
>> @@ -85,9 +159,6 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>   {
>>   	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
>>   	long ret = H_TOO_HARD;
>> -	unsigned long idx;
>> -	struct page *page;
>> -	u64 *tbl;
>>
>>   	/* udbg_printf("H_PUT_TCE(): liobn=0x%lx ioba=0x%lx, tce=0x%lx\n", */
>>   	/* 	    liobn, ioba, tce); */
>> @@ -99,13 +170,11 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>   	if (ret)
>>   		return ret;
>>
>> -	idx = ioba >> IOMMU_PAGE_SHIFT_4K;
>> -	page = stt->pages[idx / TCES_PER_PAGE];
>> -	tbl = (u64 *)page_address(page);
>> +	ret = kvmppc_tce_validate(stt, tce);
>> +	if (ret)
>> +		return ret;
>>
>> -	/* FIXME: Need to validate the TCE itself */
>> -	/* udbg_printf("tce @ %p\n", &tbl[idx % TCES_PER_PAGE]); */
>> -	tbl[idx % TCES_PER_PAGE] = tce;
>> +	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
>>
>>   	return ret;
>>   }
>


-- 
Alexey
