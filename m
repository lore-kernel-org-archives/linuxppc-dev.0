Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x231.google.com (mail-pa0-x231.google.com
 [IPv6:2607:f8b0:400e:c03::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 124191A11B6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Dec 2015 18:42:08 +1100 (AEDT)
Received: by mail-pa0-x231.google.com with SMTP id jx14so85259911pad.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Dec 2015 23:42:08 -0800 (PST)
Subject: Re: [PATCH kernel 9/9] KVM: PPC: Add support for multiple-TCE hcalls
To: David Gibson <david@gibson.dropbear.id.au>
References: <1442314179-9706-1-git-send-email-aik@ozlabs.ru>
 <1442314179-9706-10-git-send-email-aik@ozlabs.ru>
 <20151208054805.GU20139@voom.fritz.box>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5678FEC9.5030404@ozlabs.ru>
Date: Tue, 22 Dec 2015 18:42:01 +1100
MIME-Version: 1.0
In-Reply-To: <20151208054805.GU20139@voom.fritz.box>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/08/2015 04:48 PM, David Gibson wrote:
> On Tue, Sep 15, 2015 at 08:49:39PM +1000, Alexey Kardashevskiy wrote:
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
>> ---
>>   Documentation/virtual/kvm/api.txt       |  25 ++++++
>>   arch/powerpc/include/asm/kvm_ppc.h      |  12 +++
>>   arch/powerpc/kvm/book3s_64_vio.c        | 111 +++++++++++++++++++++++-
>>   arch/powerpc/kvm/book3s_64_vio_hv.c     | 145 ++++++++++++++++++++++++++++++--
>>   arch/powerpc/kvm/book3s_hv.c            |  26 +++++-
>>   arch/powerpc/kvm/book3s_hv_rmhandlers.S |   6 +-
>>   arch/powerpc/kvm/book3s_pr_papr.c       |  35 ++++++++
>>   arch/powerpc/kvm/powerpc.c              |   3 +
>>   8 files changed, 350 insertions(+), 13 deletions(-)
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index d86d831..593c62a 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -3019,6 +3019,31 @@ Returns: 0 on success, -1 on error
>>
>>   Queues an SMI on the thread's vcpu.
>>
>> +4.97 KVM_CAP_PPC_MULTITCE
>> +
>> +Capability: KVM_CAP_PPC_MULTITCE
>> +Architectures: ppc
>> +Type: vm
>> +
>> +This capability means the kernel is capable of handling hypercalls
>> +H_PUT_TCE_INDIRECT and H_STUFF_TCE without passing those into the user
>> +space. This significantly accelerates DMA operations for PPC KVM guests.
>> +User space should expect that its handlers for these hypercalls
>> +are not going to be called if user space previously registered LIOBN
>> +in KVM (via KVM_CREATE_SPAPR_TCE or similar calls).
>> +
>> +In order to enable H_PUT_TCE_INDIRECT and H_STUFF_TCE use in the guest,
>> +user space might have to advertise it for the guest. For example,
>> +IBM pSeries (sPAPR) guest starts using them if "hcall-multi-tce" is
>> +present in the "ibm,hypertas-functions" device-tree property.
>> +
>> +The hypercalls mentioned above may or may not be processed successfully
>> +in the kernel based fast path. If they can not be handled by the kernel,
>> +they will get passed on to user space. So user space still has to have
>> +an implementation for these despite the in kernel acceleration.
>> +
>> +This capability is always enabled.
>> +
>>   5. The kvm_run structure
>>   ------------------------
>>
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index fcde896..e5b968e 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -166,12 +166,24 @@ extern int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu);
>>
>>   extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>>   				struct kvm_create_spapr_tce *args);
>> +extern struct kvmppc_spapr_tce_table *kvmppc_find_table(
>> +		struct kvm_vcpu *vcpu, unsigned long liobn);
>>   extern long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>>   		unsigned long ioba, unsigned long npages);
>>   extern long kvmppc_tce_validate(struct kvmppc_spapr_tce_table *tt,
>>   		unsigned long tce);
>> +extern long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
>> +		unsigned long *ua, unsigned long **prmap);
>> +extern void kvmppc_tce_put(struct kvmppc_spapr_tce_table *tt,
>> +		unsigned long idx, unsigned long tce);
>>   extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>   			     unsigned long ioba, unsigned long tce);
>> +extern long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>> +		unsigned long liobn, unsigned long ioba,
>> +		unsigned long tce_list, unsigned long npages);
>> +extern long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
>> +		unsigned long liobn, unsigned long ioba,
>> +		unsigned long tce_value, unsigned long npages);
>>   extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>   			     unsigned long ioba);
>>   extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>> index e347856..d3fc732 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>> @@ -14,6 +14,7 @@
>>    *
>>    * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>>    * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
>> + * Copyright 2013 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
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
>>   static long kvmppc_stt_npages(unsigned long window_size)
>>   {
>> @@ -200,3 +200,110 @@ fail:
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
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = kvmppc_tce_validate(stt, tce);
>> +	if (ret)
>> +		return ret;
>> +
>> +	kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce);
>> +
>> +	return H_SUCCESS;
>> +}
>> +EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
>> +
>> +long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
>> +		unsigned long liobn, unsigned long ioba,
>> +		unsigned long tce_list, unsigned long npages)
>> +{
>> +	struct kvmppc_spapr_tce_table *stt;
>> +	long i, ret = H_SUCCESS, idx;
>> +	unsigned long entry, ua = 0;
>> +	u64 __user *tces, tce;
>> +
>> +	stt = kvmppc_find_table(vcpu, liobn);
>> +	if (!stt)
>> +		return H_TOO_HARD;
>> +
>> +	entry = ioba >> IOMMU_PAGE_SHIFT_4K;
>> +	/*
>> +	 * SPAPR spec says that the maximum size of the list is 512 TCEs
>> +	 * so the whole table fits in 4K page
>> +	 */
>> +	if (npages > 512)
>> +		return H_PARAMETER;
>> +
>> +	if (tce_list & ~IOMMU_PAGE_MASK_4K)
>
> IOMMU_PAGE_MASK_4K doesn't seem like the right thing here.  It is 4k,
> but that restriction is derived from the smallest possible main memory
> page size, rather than from anything to do with the IOMMU page size.


Ok, I'll make it SZ_4K then.


>
>> +		return H_PARAMETER;
>> +
>> +	ret = kvmppc_ioba_validate(stt, ioba, npages);
>> +	if (ret)
>> +		return ret;
>> +
>> +	idx = srcu_read_lock(&vcpu->kvm->srcu);
>> +	if (kvmppc_gpa_to_ua(vcpu->kvm, tce_list, &ua, NULL)) {
>> +		ret = H_TOO_HARD;
>> +		goto unlock_exit;
>> +	}
>> +	tces = (u64 *) ua;
>
> The u64 * should have a usermem sparse annotation, no?


Like this?

tces = (u64 __user *) ua;


>
>> +	for (i = 0; i < npages; ++i) {
>> +		if (get_user(tce, tces + i)) {
>> +			ret = H_PARAMETER;
>> +			goto unlock_exit;
>> +		}
>> +		tce = be64_to_cpu(tce);
>> +		ret = kvmppc_tce_validate(stt, tce);
>> +		if (ret)
>> +			goto unlock_exit;
>> +
>> +		kvmppc_tce_put(stt, entry + i, tce);
>> +	}
>> +
>> +unlock_exit:
>> +	srcu_read_unlock(&vcpu->kvm->srcu, idx);
>> +
>> +	return ret;
>> +}
>> +EXPORT_SYMBOL_GPL(kvmppc_h_put_tce_indirect);
>> +
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
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = kvmppc_tce_validate(stt, tce_value);
>> +	if (ret || (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ)))
>> +		return H_PARAMETER;
>> +
>> +	for (i = 0; i < npages; ++i, ioba += IOMMU_PAGE_SIZE_4K)
>> +		kvmppc_tce_put(stt, ioba >> IOMMU_PAGE_SHIFT_4K, tce_value);
>> +
>> +	return H_SUCCESS;
>> +}
>> +EXPORT_SYMBOL_GPL(kvmppc_h_stuff_tce);
>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> index f0fd84c..bca7b12 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> @@ -14,6 +14,7 @@
>>    *
>>    * Copyright 2010 Paul Mackerras, IBM Corp. <paulus@au1.ibm.com>
>>    * Copyright 2011 David Gibson, IBM Corporation <dwg@au1.ibm.com>
>> + * Copyright 2013 Alexey Kardashevskiy, IBM Corporation <aik@au1.ibm.com>
>>    */
>>
>>   #include <linux/types.h>
>> @@ -30,6 +31,7 @@
>>   #include <asm/kvm_ppc.h>
>>   #include <asm/kvm_book3s.h>
>>   #include <asm/mmu-hash64.h>
>> +#include <asm/mmu_context.h>
>>   #include <asm/hvcall.h>
>>   #include <asm/synch.h>
>>   #include <asm/ppc-opcode.h>
>> @@ -37,6 +39,7 @@
>>   #include <asm/udbg.h>
>>   #include <asm/iommu.h>
>>   #include <asm/tce.h>
>> +#include <asm/iommu.h>
>>
>>   #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
>>
>> @@ -46,7 +49,7 @@
>>    * WARNING: This will be called in real or virtual mode on HV KVM and virtual
>>    *          mode on PR KVM
>>    */
>> -static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
>> +struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
>>   		unsigned long liobn)
>>   {
>>   	struct kvm *kvm = vcpu->kvm;
>> @@ -58,6 +61,7 @@ static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
>>
>>   	return NULL;
>>   }
>> +EXPORT_SYMBOL_GPL(kvmppc_find_table);
>>
>>   /*
>>    * Validates IO address.
>> @@ -151,11 +155,32 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
>>   }
>>   EXPORT_SYMBOL_GPL(kvmppc_tce_put);
>>
>> -/* WARNING: This will be called in real-mode on HV KVM and virtual
>> - *          mode on PR KVM
>> - */
>> -long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>> -		      unsigned long ioba, unsigned long tce)
>> +long kvmppc_gpa_to_ua(struct kvm *kvm, unsigned long gpa,
>> +		unsigned long *ua, unsigned long **prmap)
>
> I'm kind of surprised there isn't already a function to do this somewhere.
>
>> +{
>> +	unsigned long gfn = gpa >> PAGE_SHIFT;
>> +	struct kvm_memory_slot *memslot;
>> +
>> +	memslot = search_memslots(kvm_memslots(kvm), gfn);
>> +	if (!memslot)
>> +		return -EINVAL;
>> +
>> +	*ua = __gfn_to_hva_memslot(memslot, gfn) |
>> +		(gpa & ~(PAGE_MASK | TCE_PCI_READ | TCE_PCI_WRITE));
>> +
>> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>> +	if (prmap)
>> +		*prmap = real_vmalloc_addr(&memslot->arch.rmap[
>> +				gfn - memslot->base_gfn]);
>> +#endif
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(kvmppc_gpa_to_ua);
>> +
>> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>> +long kvmppc_rm_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>> +		unsigned long ioba, unsigned long tce)
>>   {
>>   	struct kvmppc_spapr_tce_table *stt = kvmppc_find_table(vcpu, liobn);
>>   	long ret = H_TOO_HARD;
>> @@ -178,7 +203,111 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>
>>   	return ret;
>>   }
>> -EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
>> +
>> +static long kvmppc_rm_ua_to_hpa(struct kvm_vcpu *vcpu,
>> +		unsigned long ua, unsigned long *phpa)
>> +{
>> +	pte_t *ptep, pte;
>> +	unsigned shift = 0;
>> +
>> +	ptep = __find_linux_pte_or_hugepte(vcpu->arch.pgdir, ua, &shift);
>> +	if (!ptep || !pte_present(*ptep))
>> +		return -ENXIO;
>> +	pte = *ptep;
>> +
>> +	if (!shift)
>> +		shift = PAGE_SHIFT;
>> +
>> +	/* Avoid handling anything potentially complicated in realmode */
>> +	if (shift > PAGE_SHIFT)
>> +		return -EAGAIN;
>> +
>> +	if (!pte_young(pte))
>> +		return -EAGAIN;
>
> Does it also need to be dirty, since you might be writing to this page?

This particular helper is used to get the address of the TCE list page (the 
actual TCEs for VFIO will be translated using memory pre-registration 
mechanism) so no, we should not be writing to this page. And setting the 
dirty bit is done by iommu_tce_xchg/iommu_tce_xchg_rm anyway, when needed.



-- 
Alexey
