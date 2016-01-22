Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A93771A0562
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jan 2016 12:59:55 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id n128so2561050pfn.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 17:59:55 -0800 (PST)
Subject: Re: [PATCH kernel v2 1/6] KVM: PPC: Rework H_PUT_TCE/H_GET_TCE
 handlers
To: David Gibson <david@gibson.dropbear.id.au>
References: <1453361977-19589-1-git-send-email-aik@ozlabs.ru>
 <1453361977-19589-2-git-send-email-aik@ozlabs.ru>
 <20160122004245.GL27454@voom.redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56A18D13.9050908@ozlabs.ru>
Date: Fri, 22 Jan 2016 12:59:47 +1100
MIME-Version: 1.0
In-Reply-To: <20160122004245.GL27454@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/22/2016 11:42 AM, David Gibson wrote:
> On Thu, Jan 21, 2016 at 06:39:32PM +1100, Alexey Kardashevskiy wrote:
>> This reworks the existing H_PUT_TCE/H_GET_TCE handlers to have following
>> patches applied nicer.
>>
>> This moves the ioba boundaries check to a helper and adds a check for
>> least bits which have to be zeros.
>>
>> The patch is pretty mechanical (only check for least ioba bits is added)
>> so no change in behaviour is expected.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Concept looks good, but there are a couple of nits.
>
>> ---
>> Changelog:
>> v2:
>> * compare @ret with H_SUCCESS instead of assuming H_SUCCESS is zero
>> * made error reporting cleaner
>> ---
>>   arch/powerpc/kvm/book3s_64_vio_hv.c | 111 +++++++++++++++++++++++-------------
>>   1 file changed, 72 insertions(+), 39 deletions(-)
>>
>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> index 89e96b3..862f9a2 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> @@ -35,71 +35,104 @@
>>   #include <asm/ppc-opcode.h>
>>   #include <asm/kvm_host.h>
>>   #include <asm/udbg.h>
>> +#include <asm/iommu.h>
>>
>>   #define TCES_PER_PAGE	(PAGE_SIZE / sizeof(u64))
>>
>> +/*
>> + * Finds a TCE table descriptor by LIOBN.
>> + *
>> + * WARNING: This will be called in real or virtual mode on HV KVM and virtual
>> + *          mode on PR KVM
>> + */
>> +static struct kvmppc_spapr_tce_table *kvmppc_find_table(struct kvm_vcpu *vcpu,
>> +		unsigned long liobn)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvmppc_spapr_tce_table *stt;
>> +
>> +	list_for_each_entry_lockless(stt, &kvm->arch.spapr_tce_tables, list)
>
> list_for_each_entry_lockless?  According to the comments in the
> header, that's for RCU protected lists, whereas this one is just
> protected by the lock in the kvm structure.  This is replacing a plain
> list_for_each_entry().

My bad, the next patch should have done this
s/list_for_each_entry/list_for_each_entry_lockless/


>
>
>> +		if (stt->liobn == liobn)
>> +			return stt;
>> +
>> +	return NULL;
>> +}
>> +
>> +/*
>> + * Validates IO address.
>> + *
>> + * WARNING: This will be called in real-mode on HV KVM and virtual
>> + *          mode on PR KVM
>> + */
>> +static long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>> +		unsigned long ioba, unsigned long npages)
>> +{
>> +	unsigned long mask = (1ULL << IOMMU_PAGE_SHIFT_4K) - 1;
>> +	unsigned long idx = ioba >> IOMMU_PAGE_SHIFT_4K;
>> +	unsigned long size = stt->window_size >> IOMMU_PAGE_SHIFT_4K;
>> +
>> +	if ((ioba & mask) || (idx + npages > size))
>
> It doesn't matter for the current callers, but you should check for
> overflow in idx + npages as well.


npages can be only 1..512 and this is checked in H_PUT_TCE/etc handlers.
idx is 52bit long max.
And this is not going to change because H_PUT_TCE_INDIRECT will always be 
limited by 512 (or one 4K page).

Do I still need the overflow check here?


-- 
Alexey
