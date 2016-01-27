Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 526FC1A198D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 14:31:25 +1100 (AEDT)
Received: by mail-pa0-x243.google.com with SMTP id a20so8675210pag.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jan 2016 19:31:25 -0800 (PST)
Subject: Re: [PATCH kernel 3/4] KVM: PPC: Add @offset to kvmppc_spapr_tce_table
To: David Gibson <david@gibson.dropbear.id.au>
References: <1453364126-22527-1-git-send-email-aik@ozlabs.ru>
 <1453364126-22527-4-git-send-email-aik@ozlabs.ru>
 <20160125053309.GD32205@voom.redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56A83A06.6010104@ozlabs.ru>
Date: Wed, 27 Jan 2016 14:31:18 +1100
MIME-Version: 1.0
In-Reply-To: <20160125053309.GD32205@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/25/2016 04:33 PM, David Gibson wrote:
> On Thu, Jan 21, 2016 at 07:15:25PM +1100, Alexey Kardashevskiy wrote:
>> This enables userspace view of TCE tables to start from non-zero offset
>> on a bus. This will be used for huge DMA windows.
>
> Again I'd like the commit message adjusted to clarify the fact that
> this has internal changes only which will need interface changes to
> actually use.

May be this or I could just merge all four into one patch as it may make it 
easier to review but does not make much sense from bisectability prospective?


>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
>> ---
>>   arch/powerpc/include/asm/kvm_host.h | 1 +
>>   arch/powerpc/kvm/book3s_64_vio_hv.c | 6 ++++--
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
>> index a4ed9f5..8769f91 100644
>> --- a/arch/powerpc/include/asm/kvm_host.h
>> +++ b/arch/powerpc/include/asm/kvm_host.h
>> @@ -185,6 +185,7 @@ struct kvmppc_spapr_tce_table {
>>   	u64 liobn;
>>   	struct rcu_head rcu;
>>   	u32 page_shift;
>> +	u64 offset;		/* in pages */
>>   	u64 size;		/* in pages */
>>   	struct page *pages[0];
>>   };
>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> index 01ef9f9..0e66459 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> @@ -75,7 +75,8 @@ long kvmppc_ioba_validate(struct kvmppc_spapr_tce_table *stt,
>>   	unsigned long mask = ~((1ULL << stt->page_shift) - 1);
>>   	unsigned long idx = ioba >> stt->page_shift;
>>
>> -	if ((ioba & ~mask) || (idx + npages > stt->size))
>> +	if ((ioba & ~mask) || (idx < stt->offset) ||
>> +			(idx - stt->offset + npages > stt->size))
>>   		return H_PARAMETER;
>>
>>   	return H_SUCCESS;
>> @@ -147,6 +148,7 @@ void kvmppc_tce_put(struct kvmppc_spapr_tce_table *stt,
>>   	struct page *page;
>>   	u64 *tbl;
>>
>> +	idx -= stt->offset;
>>   	page = stt->pages[idx / TCES_PER_PAGE];
>>   	tbl = kvmppc_page_address(page);
>>
>> @@ -324,7 +326,7 @@ long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>   	if (ret != H_SUCCESS)
>>   		return ret;
>>
>> -	idx = ioba >> stt->page_shift;
>> +	idx = (ioba >> stt->page_shift) - stt->offset;
>>   	page = stt->pages[idx / TCES_PER_PAGE];
>>   	tbl = (u64 *)page_address(page);
>>
>


-- 
Alexey
