Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bXZJ1y9fzF2S0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 19:11:03 +1000 (AEST)
Received: by mail-it0-x242.google.com with SMTP id e20-v6so16166299itc.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 02:11:03 -0700 (PDT)
Subject: Re: [PATCH kernel 2/2] KVM: PPC: Allow backing bigger guest IOMMU
 pages with smaller physical pages
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@ozlabs.org>
References: <20180502040723.20545-1-aik@ozlabs.ru>
 <20180502040723.20545-3-aik@ozlabs.ru>
 <20180502054926.GB3517@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <c7ce07d5-0800-7d0b-1bf4-ce64159fbc43@ozlabs.ru>
Date: Wed, 2 May 2018 19:10:56 +1000
MIME-Version: 1.0
In-Reply-To: <20180502054926.GB3517@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2/5/18 3:49 pm, David Gibson wrote:
> On Wed, May 02, 2018 at 02:07:23PM +1000, Alexey Kardashevskiy wrote:
>> At the moment we only support in the host the IOMMU page sizes which
>> the guest is aware of, which is 4KB/64KB/16MB. However P9 does not support
>> 16MB IOMMU pages, 2MB and 1GB pages are supported instead. We can still
>> emulate bigger guest pages (for example 16MB) with smaller host pages
>> (4KB/64KB/2MB).
>>
>> This allows the physical IOMMU pages to use a page size smaller or equal
>> than the guest visible IOMMU page size.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Except for one possible nit..
> 
>> ---
>>  arch/powerpc/kvm/book3s_64_vio.c    | 66 +++++++++++++++++++++++++++++--------
>>  arch/powerpc/kvm/book3s_64_vio_hv.c | 52 +++++++++++++++++++++++++----
>>  2 files changed, 98 insertions(+), 20 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>> index 041e54d..e10d6a3 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -176,14 +176,12 @@ extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
>>  
>>  		if (!tbltmp)
>>  			continue;
>> -		/*
>> -		 * Make sure hardware table parameters are exactly the same;
>> -		 * this is used in the TCE handlers where boundary checks
>> -		 * use only the first attached table.
>> -		 */
>> -		if ((tbltmp->it_page_shift == stt->page_shift) &&
>> -				(tbltmp->it_offset == stt->offset) &&
>> -				(tbltmp->it_size == stt->size)) {
>> +		/* Make sure hardware table parameters are compatible */
>> +		if ((tbltmp->it_page_shift <= stt->page_shift) &&
>> +				(tbltmp->it_offset << tbltmp->it_page_shift ==
>> +				 stt->offset << stt->page_shift) &&
>> +				(tbltmp->it_size << tbltmp->it_page_shift ==
>> +				 stt->size << stt->page_shift)) {
> 
> Do we need to worry about stt->offset << stt->page_shift overflowing
> with a buggy or malicious userspace?


I cannot see how it can break anything... But probably some sanity check
that the entire kvmppc_spapr_tce_table fits 64bit would not hurt, I'll make
a separate patch.


> 
>>  			/*
>>  			 * Reference the table to avoid races with
>>  			 * add/remove DMA windows.
>> @@ -396,7 +394,7 @@ static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
>>  	return H_SUCCESS;
>>  }
>>  
>> -static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
>> +static long kvmppc_tce_iommu_do_unmap(struct kvm *kvm,
>>  		struct iommu_table *tbl, unsigned long entry)
>>  {
>>  	enum dma_data_direction dir = DMA_NONE;
>> @@ -416,7 +414,25 @@ static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
>>  	return ret;
>>  }
>>  
>> -long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
>> +static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
>> +		struct kvmppc_spapr_tce_table *stt, struct iommu_table *tbl,
>> +		unsigned long entry)
>> +{
>> +	unsigned long ret = H_SUCCESS;
>> +	unsigned long subpages = 1ULL << (stt->page_shift - tbl->it_page_shift);
>> +	unsigned long io_entry = entry * subpages;
>> +	unsigned long subpg;
>> +
>> +	for (subpg = 0; subpg < subpages; ++subpg) {
>> +		ret = kvmppc_tce_iommu_do_unmap(kvm, tbl, io_entry + subpg);
>> +		if (ret != H_SUCCESS)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +long kvmppc_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
>>  		unsigned long entry, unsigned long ua,
>>  		enum dma_data_direction dir)
>>  {
>> @@ -453,6 +469,28 @@ long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
>>  	return 0;
>>  }
>>  
>> +static long kvmppc_tce_iommu_map(struct kvm *kvm,
>> +		struct kvmppc_spapr_tce_table *stt, struct iommu_table *tbl,
>> +		unsigned long entry, unsigned long ua,
>> +		enum dma_data_direction dir)
>> +{
>> +	unsigned long ret = H_SUCCESS;
>> +	unsigned long subpages = 1ULL << (stt->page_shift - tbl->it_page_shift);
>> +	unsigned long io_entry = entry * subpages;
>> +	unsigned long subpg, pgoff;
>> +
>> +	for (subpg = 0, pgoff = 0; subpg < subpages;
>> +			++subpg, pgoff += IOMMU_PAGE_SIZE(tbl)) {
>> +
>> +		ret = kvmppc_tce_iommu_do_map(kvm, tbl,
>> +				io_entry + subpg, ua + pgoff, dir);
>> +		if (ret != H_SUCCESS)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>  		      unsigned long ioba, unsigned long tce)
>>  {
>> @@ -491,10 +529,10 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>  
>>  	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>>  		if (dir == DMA_NONE)
>> -			ret = kvmppc_tce_iommu_unmap(vcpu->kvm,
>> +			ret = kvmppc_tce_iommu_unmap(vcpu->kvm, stt,
>>  					stit->tbl, entry);
>>  		else
>> -			ret = kvmppc_tce_iommu_map(vcpu->kvm, stit->tbl,
>> +			ret = kvmppc_tce_iommu_map(vcpu->kvm, stt, stit->tbl,
>>  					entry, ua, dir);
>>  
>>  		if (ret == H_SUCCESS)
>> @@ -570,7 +608,7 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>>  			return H_PARAMETER;
>>  
>>  		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>> -			ret = kvmppc_tce_iommu_map(vcpu->kvm,
>> +			ret = kvmppc_tce_iommu_map(vcpu->kvm, stt,
>>  					stit->tbl, entry + i, ua,
>>  					iommu_tce_direction(tce));
>>  
>> @@ -618,7 +656,7 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>>  		unsigned long entry = ioba >> stt->page_shift;
>>  
>>  		for (i = 0; i < npages; ++i) {
>> -			ret = kvmppc_tce_iommu_unmap(vcpu->kvm,
>> +			ret = kvmppc_tce_iommu_unmap(vcpu->kvm, stt,
>>  					stit->tbl, entry + i);
>>  
>>  			if (ret == H_SUCCESS)
>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> index e220fab..258e786 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> @@ -221,7 +221,7 @@ static long kvmppc_rm_tce_iommu_mapped_dec(struct kvm *kvm,
>>  	return H_SUCCESS;
>>  }
>>  
>> -static long kvmppc_rm_tce_iommu_unmap(struct kvm *kvm,
>> +static long kvmppc_rm_tce_iommu_do_unmap(struct kvm *kvm,
>>  		struct iommu_table *tbl, unsigned long entry)
>>  {
>>  	enum dma_data_direction dir = DMA_NONE;
>> @@ -245,7 +245,25 @@ static long kvmppc_rm_tce_iommu_unmap(struct kvm *kvm,
>>  	return ret;
>>  }
>>  
>> -static long kvmppc_rm_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
>> +static long kvmppc_rm_tce_iommu_unmap(struct kvm *kvm,
>> +		struct kvmppc_spapr_tce_table *stt, struct iommu_table *tbl,
>> +		unsigned long entry)
>> +{
>> +	unsigned long ret = H_SUCCESS;
>> +	unsigned long subpages = 1ULL << (stt->page_shift - tbl->it_page_shift);
>> +	unsigned long io_entry = entry * subpages;
>> +	unsigned long subpg;
>> +
>> +	for (subpg = 0; subpg < subpages; ++subpg) {
>> +		ret = kvmppc_rm_tce_iommu_do_unmap(kvm, tbl, io_entry + subpg);
>> +		if (ret != H_SUCCESS)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static long kvmppc_rm_tce_iommu_do_map(struct kvm *kvm, struct iommu_table *tbl,
>>  		unsigned long entry, unsigned long ua,
>>  		enum dma_data_direction dir)
>>  {
>> @@ -290,6 +308,28 @@ static long kvmppc_rm_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
>>  	return 0;
>>  }
>>  
>> +static long kvmppc_rm_tce_iommu_map(struct kvm *kvm,
>> +		struct kvmppc_spapr_tce_table *stt, struct iommu_table *tbl,
>> +		unsigned long entry, unsigned long ua,
>> +		enum dma_data_direction dir)
>> +{
>> +	unsigned long ret = H_SUCCESS;
>> +	unsigned long subpages = 1ULL << (stt->page_shift - tbl->it_page_shift);
>> +	unsigned long io_entry = entry * subpages;
>> +	unsigned long subpg, pgoff;
>> +
>> +	for (subpg = 0, pgoff = 0; subpg < subpages;
>> +			++subpg, pgoff += IOMMU_PAGE_SIZE(tbl)) {
>> +
>> +		ret = kvmppc_rm_tce_iommu_do_map(kvm, tbl,
>> +				io_entry + subpg, ua + pgoff, dir);
>> +		if (ret != H_SUCCESS)
>> +			break;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>  		unsigned long ioba, unsigned long tce)
>>  {
>> @@ -327,10 +367,10 @@ long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>  
>>  	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>>  		if (dir == DMA_NONE)
>> -			ret = kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
>> +			ret = kvmppc_rm_tce_iommu_unmap(vcpu->kvm, stt,
>>  					stit->tbl, entry);
>>  		else
>> -			ret = kvmppc_rm_tce_iommu_map(vcpu->kvm,
>> +			ret = kvmppc_rm_tce_iommu_map(vcpu->kvm, stt,
>>  					stit->tbl, entry, ua, dir);
>>  
>>  		if (ret == H_SUCCESS)
>> @@ -477,7 +517,7 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>>  			return H_PARAMETER;
>>  
>>  		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
>> -			ret = kvmppc_rm_tce_iommu_map(vcpu->kvm,
>> +			ret = kvmppc_rm_tce_iommu_map(vcpu->kvm, stt,
>>  					stit->tbl, entry + i, ua,
>>  					iommu_tce_direction(tce));
>>  
>> @@ -529,7 +569,7 @@ long kvmppc_rm_h_stuff_tce(struct kvm_vcpu *vcpu,
>>  		unsigned long entry = ioba >> stt->page_shift;
>>  
>>  		for (i = 0; i < npages; ++i) {
>> -			ret = kvmppc_rm_tce_iommu_unmap(vcpu->kvm,
>> +			ret = kvmppc_rm_tce_iommu_unmap(vcpu->kvm, stt,
>>  					stit->tbl, entry + i);
>>  
>>  			if (ret == H_SUCCESS)
> 


-- 
Alexey
