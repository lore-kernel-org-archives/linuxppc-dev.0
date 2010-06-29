Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 8F18AB6EEA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Jun 2010 19:54:45 +1000 (EST)
Message-ID: <4C29C2E1.4000706@suse.de>
Date: Tue, 29 Jun 2010 11:54:41 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 01/26] KVM: PPC: Introduce shared page
References: <1277508314-915-1-git-send-email-agraf@suse.de>
	<1277508314-915-2-git-send-email-agraf@suse.de>
	<4C274028.7020105@redhat.com>
In-Reply-To: <4C274028.7020105@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avi Kivity wrote:
> On 06/26/2010 02:24 AM, Alexander Graf wrote:
>> For transparent variable sharing between the hypervisor and guest, I
>> introduce
>> a shared page. This shared page will contain all the registers the
>> guest can
>> read and write safely without exiting guest context.
>>
>> This patch only implements the stubs required for the basic structure
>> of the
>> shared page. The actual register moving follows.
>>
>>
>> @@ -123,8 +123,14 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct
>> kvm *kvm, unsigned int id)
>>       if (err)
>>           goto free_vcpu;
>>
>> +    vcpu->arch.shared = (void*)__get_free_page(GFP_KERNEL|__GFP_ZERO);
>> +    if (!vcpu->arch.shared)
>> +        goto uninit_vcpu;
>> +
>>       return vcpu;
>>
>> +uninit_vcpu:
>> +    kvm_vcpu_uninit(vcpu);
>>   free_vcpu:
>>       kmem_cache_free(kvm_vcpu_cache, vcpu_44x);
>>   out:
>> @@ -135,6 +141,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
>>   {
>>       struct kvmppc_vcpu_44x *vcpu_44x = to_44x(vcpu);
>>
>> +    free_page((unsigned long)vcpu->arch.shared);
>>       kvm_vcpu_uninit(vcpu);
>>       kmem_cache_free(kvm_vcpu_cache, vcpu_44x);
>>   }
>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>> index 884d4a5..ba79b35 100644
>> --- a/arch/powerpc/kvm/book3s.c
>> +++ b/arch/powerpc/kvm/book3s.c
>> @@ -1247,6 +1247,10 @@ struct kvm_vcpu
>> *kvmppc_core_vcpu_create(struct kvm *kvm, unsigned int id)
>>       if (err)
>>           goto free_shadow_vcpu;
>>
>> +    vcpu->arch.shared = (void*)__get_free_page(GFP_KERNEL|__GFP_ZERO);
>> +    if (!vcpu->arch.shared)
>> +        goto uninit_vcpu;
>> +
>>       vcpu->arch.host_retip = kvm_return_point;
>>       vcpu->arch.host_msr = mfmsr();
>>   #ifdef CONFIG_PPC_BOOK3S_64
>> @@ -1277,6 +1281,8 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct
>> kvm *kvm, unsigned int id)
>>
>>       return vcpu;
>>
>> +uninit_vcpu:
>> +    kvm_vcpu_uninit(vcpu);
>>   free_shadow_vcpu:
>>       kfree(vcpu_book3s->shadow_vcpu);
>>   free_vcpu:
>> @@ -1289,6 +1295,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
>>   {
>>       struct kvmppc_vcpu_book3s *vcpu_book3s = to_book3s(vcpu);
>>
>> +    free_page((unsigned long)vcpu->arch.shared);
>>       kvm_vcpu_uninit(vcpu);
>>       kfree(vcpu_book3s->shadow_vcpu);
>>       vfree(vcpu_book3s);
>> diff --git a/arch/powerpc/kvm/e500.c b/arch/powerpc/kvm/e500.c
>> index e8a00b0..71750f2 100644
>> --- a/arch/powerpc/kvm/e500.c
>> +++ b/arch/powerpc/kvm/e500.c
>> @@ -117,8 +117,14 @@ struct kvm_vcpu *kvmppc_core_vcpu_create(struct
>> kvm *kvm, unsigned int id)
>>       if (err)
>>           goto uninit_vcpu;
>>
>> +    vcpu->arch.shared = (void*)__get_free_page(GFP_KERNEL|__GFP_ZERO);
>> +    if (!vcpu->arch.shared)
>> +        goto uninit_tlb;
>> +
>>       return vcpu;
>>
>> +uninit_tlb:
>> +    kvmppc_e500_tlb_uninit(vcpu_e500);
>>   uninit_vcpu:
>>       kvm_vcpu_uninit(vcpu);
>>   free_vcpu:
>> @@ -131,6 +137,7 @@ void kvmppc_core_vcpu_free(struct kvm_vcpu *vcpu)
>>   {
>>       struct kvmppc_vcpu_e500 *vcpu_e500 = to_e500(vcpu);
>>
>> +    free_page((unsigned long)vcpu->arch.shared);
>>       kvmppc_e500_tlb_uninit(vcpu_e500);
>>       kvm_vcpu_uninit(vcpu);
>>       kmem_cache_free(kvm_vcpu_cache, vcpu_e500);
>>    
>
> Code repeats 3x.  Share please.

Looking at this again, I could combine the 3 lines of init code into 3
lines of code that do a generic function call and then error checking.
And I could convert the one free_page line with one function call that
would free the page. Is there a real gain behind this?

Alex
