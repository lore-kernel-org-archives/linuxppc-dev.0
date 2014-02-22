Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f52.google.com (mail-pa0-f52.google.com
 [209.85.220.52])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0D1532C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Feb 2014 11:28:42 +1100 (EST)
Received: by mail-pa0-f52.google.com with SMTP id bj1so4165766pad.39
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Feb 2014 16:28:39 -0800 (PST)
Message-ID: <5307EF2F.9090100@ozlabs.ru>
Date: Sat, 22 Feb 2014 11:28:31 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>
Subject: Re: [PATCH] PPC: KVM: Introduce hypervisor call H_GET_TCE
References: <20140221153110.8190.6271.stgit@nimbus>
 <1393010638.6771.74.camel@pasglop>
In-Reply-To: <1393010638.6771.74.camel@pasglop>
Content-Type: text/plain; charset=KOI8-R
Cc: Alexey Kardashevskiy <aik@au1.ibm.com>, kvm@vger.kernel.org,
 Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/22/2014 06:23 AM, Benjamin Herrenschmidt wrote:
> On Fri, 2014-02-21 at 16:31 +0100, Laurent Dufour wrote:
>> This fix introduces the H_GET_TCE hypervisor call which is basically the
>> reverse of H_PUT_TCE, as defined in the Power Architecture Platform
>> Requirements (PAPR).
>>
>> The hcall H_GET_TCE is required by the kdump kernel which is calling it to
>> retrieve the TCE set up by the panicing kernel.
> 
> Alexey, will that work for VFIO ?

Yes.

> Or are those patches *still* not
> upstream ?

Yes.


> 
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/include/asm/kvm_ppc.h      |    2 ++
>>  arch/powerpc/kvm/book3s_64_vio_hv.c     |   28 ++++++++++++++++++++++++++++
>>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |    2 +-
>>  3 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
>> index fcd53f0..4096f16 100644
>> --- a/arch/powerpc/include/asm/kvm_ppc.h
>> +++ b/arch/powerpc/include/asm/kvm_ppc.h
>> @@ -129,6 +129,8 @@ extern long kvm_vm_ioctl_create_spapr_tce(struct kvm *kvm,
>>  				struct kvm_create_spapr_tce *args);
>>  extern long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>  			     unsigned long ioba, unsigned long tce);
>> +extern long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>> +			     unsigned long ioba);
>>  extern struct kvm_rma_info *kvm_alloc_rma(void);
>>  extern void kvm_release_rma(struct kvm_rma_info *ri);
>>  extern struct page *kvm_alloc_hpt(unsigned long nr_pages);
>> diff --git a/arch/powerpc/kvm/book3s_64_vio_hv.c b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> index 2c25f54..89e96b3 100644
>> --- a/arch/powerpc/kvm/book3s_64_vio_hv.c
>> +++ b/arch/powerpc/kvm/book3s_64_vio_hv.c
>> @@ -75,3 +75,31 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>>  	return H_TOO_HARD;
>>  }
>>  EXPORT_SYMBOL_GPL(kvmppc_h_put_tce);
>> +
>> +long kvmppc_h_get_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
>> +		      unsigned long ioba)
>> +{
>> +	struct kvm *kvm = vcpu->kvm;
>> +	struct kvmppc_spapr_tce_table *stt;
>> +
>> +	list_for_each_entry(stt, &kvm->arch.spapr_tce_tables, list) {
>> +		if (stt->liobn == liobn) {
>> +			unsigned long idx = ioba >> SPAPR_TCE_SHIFT;
>> +			struct page *page;
>> +			u64 *tbl;
>> +
>> +			if (ioba >= stt->window_size)
>> +				return H_PARAMETER;
>> +
>> +			page = stt->pages[idx / TCES_PER_PAGE];
>> +			tbl = (u64 *)page_address(page);
>> +
>> +			vcpu->arch.gpr[4] = tbl[idx % TCES_PER_PAGE];
>> +			return H_SUCCESS;
>> +		}
>> +	}
>> +
>> +	/* Didn't find the liobn, punt it to userspace */
>> +	return H_TOO_HARD;
>> +}
>> +EXPORT_SYMBOL_GPL(kvmppc_h_get_tce);
>> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> index e66d4ec..7d4fe2a 100644
>> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
>> @@ -1758,7 +1758,7 @@ hcall_real_table:
>>  	.long	0		/* 0x10 - H_CLEAR_MOD */
>>  	.long	0		/* 0x14 - H_CLEAR_REF */
>>  	.long	.kvmppc_h_protect - hcall_real_table
>> -	.long	0		/* 0x1c - H_GET_TCE */
>> +	.long	.kvmppc_h_get_tce - hcall_real_table
>>  	.long	.kvmppc_h_put_tce - hcall_real_table
>>  	.long	0		/* 0x24 - H_SET_SPRG0 */
>>  	.long	.kvmppc_h_set_dabr - hcall_real_table
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 


-- 
Alexey
