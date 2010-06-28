Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 88F32B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 23:25:27 +1000 (EST)
Message-ID: <4C28A2C1.50700@suse.de>
Date: Mon, 28 Jun 2010 15:25:21 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] KVM: PPC: Add generic hpte management functions
References: <1277507817-626-1-git-send-email-agraf@suse.de>
	<1277507817-626-2-git-send-email-agraf@suse.de>
	<4C285D1C.5060508@redhat.com>
	<20417D40-9345-485B-9201-8B3722B7457F@suse.de>
	<4C286770.6010204@redhat.com>
	<1A0E0E54-D055-4333-B5EC-DE2F71382AB7@suse.de>
	<4C286C98.8060903@redhat.com> <4C2871A8.1060706@suse.de>
	<4C2872F5.20501@redhat.com>
In-Reply-To: <4C2872F5.20501@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	KVM list <kvm@vger.kernel.org>,
	"kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Avi Kivity wrote:
> On 06/28/2010 12:55 PM, Alexander Graf wrote:
>> Avi Kivity wrote:
>>   
>>> On 06/28/2010 12:27 PM, Alexander Graf wrote:
>>>     
>>>>> Am I looking at old code?
>>>>>          
>>>>
>>>> Apparently. Check book3s_mmu_*.c
>>>>        
>>> I don't have that pattern.
>>>      
>> It's in this patch.
>>    
>
> Yes.  Silly me.
>
>>> +static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache
>>> *pte)
>>> +{
>>> +    dprintk_mmu("KVM: Flushing SPT: 0x%lx (0x%llx) ->  0x%llx\n",
>>> +            pte->pte.eaddr, pte->pte.vpage, pte->host_va);
>>> +
>>> +    /* Different for 32 and 64 bit */
>>> +    kvmppc_mmu_invalidate_pte(vcpu, pte);
>>> +
>>> +    if (pte->pte.may_write)
>>> +        kvm_release_pfn_dirty(pte->pfn);
>>> +    else
>>> +        kvm_release_pfn_clean(pte->pfn);
>>> +
>>> +    list_del(&pte->list_pte);
>>> +    list_del(&pte->list_vpte);
>>> +    list_del(&pte->list_vpte_long);
>>> +    list_del(&pte->list_all);
>>> +
>>> +    kmem_cache_free(vcpu->arch.hpte_cache, pte);
>>> +}
>>> +
>>>      
>
> (that's the old one with list_all - better check what's going on here)

Yeah, I just searched my inbox for the first patch. Obviously it was the
old version :(.

>
>
>>>>> (another difference is using struct hlist_head instead of list_head,
>>>>> which I recommend since it saves space)
>>>>>          
>>>> Hrm. I thought about this quite a bit before too, but that makes
>>>> invalidation more complicated, no? We always need to remember the
>>>> previous entry in a list.
>>>>        
>>> hlist_for_each_entry_safe() does that.
>>>      
>> Oh - very nice. So all I need to do is pass the previous list entry to
>> invalide_pte too and I'm good. I guess I'll give it a shot.
>>    
>
> No, just the for_each cursor.
>
>>> Less and simpler code, better reporting through slabtop, less wastage
>>> of partially allocated slab pages.
>>>      
>> But it also means that one VM can spill the global slab cache and kill
>> another VM's mm performance, no?
>>    
>
> What do you mean by spill?
>
> btw, in the midst of the nit-picking frenzy I forgot to ask how the
> individual hash chain lengths as well as the per-vm allocation were
> limited.
>
> On x86 we have a per-vm limit and we allow the mm shrinker to reduce
> shadow mmu data structures dynamically.
>

Very simple. I keep an int with the number of allocated entries around
and if that hits a define'd threshold, I flush all shadow pages.


Alex
