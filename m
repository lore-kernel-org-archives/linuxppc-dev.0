Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE3361A002B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Feb 2016 15:54:25 +1100 (AEDT)
Received: by mail-pa0-x231.google.com with SMTP id ho8so40687356pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 20:54:25 -0800 (PST)
Subject: Re: [PATCH kernel v2 6/6] KVM: PPC: Add support for multiple-TCE
 hcalls
To: Paul Mackerras <paulus@ozlabs.org>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-7-git-send-email-aik@ozlabs.ru>
 <20160211053206.GD9757@oak.ozlabs.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56BD657A.1020203@ozlabs.ru>
Date: Fri, 12 Feb 2016 15:54:18 +1100
MIME-Version: 1.0
In-Reply-To: <20160211053206.GD9757@oak.ozlabs.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/11/2016 04:32 PM, Paul Mackerras wrote:
> On Thu, Jan 21, 2016 at 06:39:37PM +1100, Alexey Kardashevskiy wrote:
>> This adds real and virtual mode handlers for the H_PUT_TCE_INDIRECT and
>> H_STUFF_TCE hypercalls for user space emulated devices such as IBMVIO
>> devices or emulated PCI.  These calls allow adding multiple entries
>> (up to 512) into the TCE table in one call which saves time on
>> transition between kernel and user space.
>>
>> This implements the KVM_CAP_PPC_MULTITCE capability. When present,
>> the kernel will try handling H_PUT_TCE_INDIRECT and H_STUFF_TCE.
>> If they can not be handled by the kernel, they are passed on to
>> the user space. The user space still has to have an implementation
>> for these.
>>
>> Both HV and PR-syle KVM are supported.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> [snip]
>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>> index 975f0ab..987f406 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -14,6 +14,7 @@
>>    *
>>    * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>>    * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
>> + * Copyright 2016 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
>>    */
>>
>>   #include <linux/types.h>
>> @@ -37,8 +38,7 @@
>>   #include <asm/kvm_host.h>
>>   #include <asm/udbg.h>
>>   #include <asm/iommu.h>
>> -
>> -#define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
>> +#include <asm/tce.h>
>>
>>   static unsigned long kvmppc_stt_npages(unsigned long window_size)
>>   {
>> @@ -200,3 +200,109 @@ fail:
>>   	}
>>   	return ret;
>>   }
>> +
>> +long kvmppc_h_put_tce(struct kvm_vcpu *vcpu,
>> +		unsigned long liobn, unsigned long ioba,
>> +		unsigned long tce)
>> +{
>> +	long ret;
>> +	struct kvmppc_spapr_tce_table *stt;
>> +
>> +	stt = kvmppc_find_table(vcpu, liobn);
>> +	if (!stt)
>> +		return H_TOO_HARD;
>> +
>> +	ret = kvmppc_ioba_validate(stt, ioba, 1);
>> +	if (ret != H_SUCCESS)
>> +		return ret;
>> +
>> +	ret = kvmppc_tce_validate(stt, tce);
>> +	if (ret != H_SUCCESS)
>> +		return ret;
>> +
>> +	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
>> +
>> +	return H_SUCCESS;
>> +}
>> +EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
>
> As far as I can see, this is functionally identical to the
> kvmppc_h_put_tce that we have in book3s_64_vio_hv.c, that gets renamed
> later on in this patch.  It would be good to have an explanation in
> the commit message why we want two almost-identical functions (and
> similarly for kvmppc_h_stuff_tce).  Is it because a future patch is
> going to make them different, for instance?
>
>> +long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>> +		unsigned long liobn, unsigned long ioba,
>> +		unsigned long tce_value, unsigned long npages)
>> +{
>> +	struct kvmppc_spapr_tce_table *stt;
>> +	long i, ret;
>> +
>> +	stt = kvmppc_find_table(vcpu, liobn);
>> +	if (!stt)
>> +		return H_TOO_HARD;
>> +
>> +	ret = kvmppc_ioba_validate(stt, ioba, npages);
>> +	if (ret != H_SUCCESS)
>> +		return ret;
>> +
>> +	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
>> +		return H_PARAMETER;
>> +
>> +	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE_4K)
>
> Looks like we need a bounds check on npages, presumably in
> kvmppc_ioba_validate().
>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> index 8cd3a95..58c63ed 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
> [...]
>> +long kvmppc_rm_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>> +		unsigned long liobn, unsigned long ioba,
>> +		unsigned long tce_list,	unsigned long npages)
>> +{
>> +	struct kvmppc_spapr_tce_table *stt;
>> +	long i, ret = H_SUCCESS;
>> +	unsigned long tces, entry, ua = 0;
>> +	unsigned long *rmap = NULL;
>> +
>> +	stt = kvmppc_find_table(vcpu, liobn);
>> +	if (!stt)
>> +		return H_TOO_HARD;
>> +
>> +	entry = ioba >> IOMMU_PAGE_SHIFT_4K;
>> +	/*
>> +	 * The spec says that the maximum size of the list is 512 TCEs
>> +	 * so the whole table addressed resides in 4K page
>> +	 */
>> +	if (npages > 512)
>> +		return H_PARAMETER;
>> +
>> +	if (tce_list & (SZ_4K - 1))
>> +		return H_PARAMETER;
>> +
>> +	ret = kvmppc_ioba_validate(stt, ioba, npages);
>> +	if (ret != H_SUCCESS)
>> +		return ret;
>> +
>> +	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, &rmap))
>> +		return H_TOO_HARD;
>> +
>> +	rmap = (void *) vmalloc_to_phys(rmap);
>> +
>> +	lock_rmap(rmap);
>
> A comment here explaining why we lock the rmap and what that achieves
> would be useful for future generations.


/* This protects the guest page with the TCE list from going away while we 
are reading TCE list */

?

By "going away" I mean H_ENTER/H_REMOVE executed on parallel CPUs, is this 
roughly correct? as I did grep for "lock_rmap()" and did not find a single 
comment next to it...



>
>> +	if (kvmppc_rm_ua_to_hpa(vcpu, ua, &tces)) {
>> +		ret = H_TOO_HARD;
>> +		goto unlock_exit;
>> +	}
>> +
>> +	for (i = 0; i < npages; ++i) {
>> +		unsigned long tce = be64_to_cpu(((u64 *)tces)[i]);
>> +
>> +		ret = kvmppc_tce_validate(stt, tce);
>> +		if (ret != H_SUCCESS)
>> +			goto unlock_exit;
>> +
>> +		kvmppc_tce_put(stt, entry + i, tce);
>> +	}
>> +
>> +unlock_exit:
>> +	unlock_rmap(rmap);
>> +
>> +	return ret;
>> +}
>
> Paul.
>


-- 
Alexey
