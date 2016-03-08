Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E99521A011E
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 16:47:28 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id 63so555295pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Mar 2016 21:47:28 -0800 (PST)
Subject: Re: [PATCH kernel 3/9] KVM: PPC: Use preregistered memory API to
 access TCE list
To: David Gibson <david@gibson.dropbear.id.au>
References: <1457322077-26640-1-git-send-email-aik@ozlabs.ru>
 <1457322077-26640-4-git-send-email-aik@ozlabs.ru>
 <20160307060014.GL22546@voom.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alex Williamson <alex.williamson@redhat.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56DE6768.4030202@ozlabs.ru>
Date: Tue, 8 Mar 2016 16:47:20 +1100
MIME-Version: 1.0
In-Reply-To: <20160307060014.GL22546@voom.fritz.box>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/07/2016 05:00 PM, David Gibson wrote:
> On Mon, Mar 07, 2016 at 02:41:11PM +1100, Alexey Kardashevskiy wrote:
>> VFIO on sPAPR already implements guest memory pre-registration
>> when the entire guest RAM gets pinned. This can be used to translate
>> the physical address of a guest page containing the TCE list
>> from H_PUT_TCE_INDIRECT.
>>
>> This makes use of the pre-registrered memory API to access TCE list
>> pages in order to avoid unnecessary locking on the KVM memory
>> reverse map.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Ok.. so, what's the benefit of not having to lock the rmap?

Less locking -> less racing == good, no?


>
>> ---
>>   arch/powerpc/kvm/book3s_64_vio_hv.c | 86 ++++++++++++++++++++++++++++++-------
>>   1 file changed, 70 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> index 44be73e..af155f6 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> @@ -180,6 +180,38 @@ long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
>>   EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
>>
>>   #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>> +static mm_context_t *kvmppc_mm_context(struct kvm_vcpu *vcpu)
>> +{
>> +	struct task_struct *task;
>> +
>> +	task = vcpu->arch.run_task;
>> +	if (unlikely(!task || !task->mm))
>> +		return NULL;
>> +
>> +	return &task->mm->context;
>> +}
>> +
>> +static inline bool kvmppc_preregistered(struct kvm_vcpu *vcpu)
>> +{
>> +	mm_context_t *mm = kvmppc_mm_context(vcpu);
>> +
>> +	if (unlikely(!mm))
>> +		return false;
>> +
>> +	return mm_iommu_preregistered(mm);
>> +}
>> +
>> +static struct mm_iommu_table_group_mem_t *kvmppc_rm_iommu_lookup(
>> +		struct kvm_vcpu *vcpu, unsigned long ua, unsigned long size)
>> +{
>> +	mm_context_t *mm = kvmppc_mm_context(vcpu);
>> +
>> +	if (unlikely(!mm))
>> +		return NULL;
>> +
>> +	return mm_iommu_lookup_rm(mm, ua, size);
>> +}
>> +
>>   long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>   		      unsigned long ioba, unsigned long tce)
>>   {
>> @@ -261,23 +293,44 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>>   	if (ret != H_SUCCESS)
>>   		return ret;
>>
>> -	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
>> -		return H_TOO_HARD;
>> +	if (kvmppc_preregistered(vcpu)) {
>> +		/*
>> +		 * We get here if guest memory was pre-registered which
>> +		 * is normally VFIO case and gpa->hpa translation does not
>> +		 * depend on hpt.
>> +		 */
>> +		struct mm_iommu_table_group_mem_t *mem;
>>
>> -	rmap = (void *) vmalloc_to_phys(rmap);
>> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL))
>> +			return H_TOO_HARD;
>>
>> -	/*
>> -	 * Synchronize with the MMU notifier callbacks in
>> -	 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
>> -	 * While we have the rmap lock, code running on other CPUs
>> -	 * cannot finish unmapping the host real page that backs
>> -	 * this guest real page, so we are OK to access the host
>> -	 * real page.
>> -	 */
>> -	lock_rmap(rmap);
>> -	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
>> -		ret = H_TOO_HARD;
>> -		goto unlock_exit;
>> +		mem = kvmppc_rm_iommu_lookup(vcpu, ua, IOMMU_PAGE_SIZE_4K);
>> +		if (!mem || mm_iommu_rm_ua_to_hpa(mem, ua, &tces))
>> +			return H_TOO_HARD;
>> +	} else {
>> +		/*
>> +		 * This is emulated devices case.
>> +		 * We do not require memory to be preregistered in this case
>> +		 * so lock rmap and do __find_linux_pte_or_hugepte().
>> +		 */
>> +		if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
>> +			return H_TOO_HARD;
>> +
>> +		rmap = (void *) vmalloc_to_phys(rmap);
>> +
>> +		/*
>> +		 * Synchronize with the MMU notifier callbacks in
>> +		 * book3s_64_mmu_hv.c (kvm_unmap_hva_hv etc.).
>> +		 * While we have the rmap lock, code running on other CPUs
>> +		 * cannot finish unmapping the host real page that backs
>> +		 * this guest real page, so we are OK to access the host
>> +		 * real page.
>> +		 */
>> +		lock_rmap(rmap);
>> +		if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
>> +			ret = H_TOO_HARD;
>> +			goto unlock_exit;
>> +		}
>>   	}
>>
>>   	for (i = 0; i < npages; ++i) {
>> @@ -291,7 +344,8 @@ long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>>   	}
>>
>>   unlock_exit:
>> -	unlock_rmap(rmap);
>> +	if (rmap)
>
> I don't see where rmap is initialized to NULL in the case where it's
> not being used.

@rmap is not new to this function, and it has always been initialized to 
NULL as it was returned via a pointer from kvmppc_gpa_to_ua().


>
>> +		unlock_rmap(rmap);
>>
>>   	return ret;
>>   }
>


-- 
Alexey
