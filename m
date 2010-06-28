Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BA527B707F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 19:26:50 +1000 (EST)
References: <1277507817-626-1-git-send-email-agraf@suse.de>
	<1277507817-626-2-git-send-email-agraf@suse.de>
	<4C285D1C.5060508@redhat.com>
	<20417D40-9345-485B-9201-8B3722B7457F@suse.de>
	<4C286770.6010204@redhat.com>
Message-Id: <1A0E0E54-D055-4333-B5EC-DE2F71382AB7@suse.de>
From: Alexander Graf <agraf@suse.de>
To: Avi Kivity <avi@redhat.com>
In-Reply-To: <4C286770.6010204@redhat.com>
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Mime-Version: 1.0 (iPhone Mail 7E18)
Subject: Re: [PATCH] KVM: PPC: Add generic hpte management functions
Date: Mon, 28 Jun 2010 11:27:05 +0200
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


Am 28.06.2010 um 11:12 schrieb Avi Kivity <avi@redhat.com>:

> On 06/28/2010 11:55 AM, Alexander Graf wrote:
>>
>>>> +
>>>> +static inline u64 kvmppc_mmu_hash_pte(u64 eaddr) {
>>>> +    return hash_64(eaddr>>   PTE_SIZE, HPTEG_HASH_BITS_PTE);
>>>> +}
>>>> +
>>>> +static inline u64 kvmppc_mmu_hash_vpte(u64 vpage) {
>>>> +    return hash_64(vpage&   0xfffffffffULL, HPTEG_HASH_BITS_VPTE);
>>>> +}
>>>> +
>>>> +static inline u64 kvmppc_mmu_hash_vpte_long(u64 vpage) {
>>>> +    return hash_64((vpage&   0xffffff000ULL)>>   12,
>>>> +               HPTEG_HASH_BITS_VPTE_LONG);
>>>> +}
>>>>
>>>>
>>> Still with the wierd coding style?
>>>
>> Not sure what's going on there. My editor displays it normally.  
>> Weird.
>>
>
> Try hitting 'save'.

Thanks for the hint :). No really, no idea what's going on here.

>
>>>> +static void kvmppc_mmu_pte_flush_all(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +    struct hpte_cache *pte, *tmp;
>>>> +    int i;
>>>> +
>>>> +    for (i = 0; i<   HPTEG_HASH_NUM_VPTE_LONG; i++) {
>>>> +        struct list_head *list =&vcpu->arch.hpte_hash_vpte_long 
>>>> [i];
>>>> +
>>>> +        list_for_each_entry_safe(pte, tmp, list, list_vpte_long) {
>>>> +            /* Jump over the helper entry */
>>>> +            if (&pte->list_vpte_long == list)
>>>> +                continue;
>>>>
>>>>
>>> I don't think l_f_e_e_s() will ever give you the head back.
>>>
>> Uh. Usually you have struct list_head in a struct and you point to  
>> the first entry to loop over all. So if it doesn't return the first  
>> entry, that would seem very counter-intuitive.
>>
>
> Linux list_heads aren't intuitive.  The same structure is used for  
> the container and for the nodes.  Would have been better (and more  
> typesafe) to have separate list_heads and list_nodes.

Hrm. Ok, I'll check by reading the source.

>
>>>> +
>>>> +            invalidate_pte(vcpu, pte);
>>>> +        }
>>>>
>>>>
>>> Does invalidate_pte() remove the pte?  doesn't seem so, so you can  
>>> drop the _safe iteration.
>>>
>> Yes, it does.
>>
>
> I don't see it?
>
>> static void invalidate_pte(struct hpte_cache *pte)
>> {
>>    dprintk_mmu("KVM: Flushing SPT: 0x%lx (0x%llx) -> 0x%llx\n",
>>            pte->pte.eaddr, pte->pte.vpage, pte->host_va);
>>
>>    ppc_md.hpte_invalidate(pte->slot, pte->host_va,
>>                   MMU_PAGE_4K, MMU_SEGSIZE_256M,
>>                   false);
>>    pte->host_va = 0;
>>
>>    if (pte->pte.may_write)
>>        kvm_release_pfn_dirty(pte->pfn);
>>    else
>>        kvm_release_pfn_clean(pte->pfn);
>> }
>
> Am I looking at old code?

Apparently. Check book3s_mmu_*.c

>
>>>> +
>>>> +/* Flush with mask 0xfffffffff */
>>>> +static void kvmppc_mmu_pte_vflush_short(struct kvm_vcpu *vcpu,  
>>>> u64 guest_vp)
>>>> +{
>>>> +    struct list_head *list;
>>>> +    struct hpte_cache *pte, *tmp;
>>>> +    u64 vp_mask = 0xfffffffffULL;
>>>> +
>>>> +    list =&vcpu->arch.hpte_hash_vpte[kvmppc_mmu_hash_vpte 
>>>> (guest_vp)];
>>>> +
>>>> +    /* Check the list for matching entries */
>>>> +    list_for_each_entry_safe(pte, tmp, list, list_vpte) {
>>>> +        /* Jump over the helper entry */
>>>> +        if (&pte->list_vpte == list)
>>>> +            continue;
>>>>
>>>>
>>> list cannot contain list.  Or maybe I don't understand the data  
>>> structure.  Isn't it multiple hash tables with lists holding  
>>> matching ptes?
>>>
>> It is multiple hash tables with list_heads that are one element of  
>> a list that contains the matching ptes. Usually you'd have
>>
>> struct x {
>>   struct list_head;
>>   int foo;
>>   char bar;
>> };
>>
>> and you loop through each of those elements. What we have here is
>>
>> struct list_head hash[..];
>>
>> and some loose struct x's. The hash's "next" element is a struct x.
>>
>> The "normal" way would be to have "struct x hash[..];" but I  
>> figured that eats too much space.
>>
>
> No, what you describe is quite normal.  In fact, x86 kvm mmu is  
> exactly like that, except we only have a single hash:
>
>>    struct hlist_head mmu_page_hash[KVM_NUM_MMU_PAGES];

I see.

>
> (another difference is using struct hlist_head instead of list_head,  
> which I recommend since it saves space)

Hrm. I thought about this quite a bit before too, but that makes  
invalidation more complicated, no? We always need to remember the  
previous entry in a list.

>
>>>> +
>>>> +            if ((pte->pte.raddr>= pa_start)&&
>>>> +                (pte->pte.raddr<   pa_end)) {
>>>> +                invalidate_pte(vcpu, pte);
>>>> +            }
>>>>
>>>>
>>> Extra braces.
>>>
>> Yeah, for two-lined if's I find it more readable that way. Is it  
>> forbidden?
>>
>
> It's not forbidden, but it tends to attract "cleanup" patches, which  
> are annoying.  Best to conform to the coding style if there isn't a  
> good reason not to.
>
> Personally I prefer braces for one-liners (yes they're ugly, but  
> they're safer and easier to patch).
>
>>>> +int kvmppc_mmu_hpte_init(struct kvm_vcpu *vcpu)
>>>> +{
>>>> +    char kmem_name[128];
>>>> +
>>>> +    /* init hpte slab cache */
>>>> +    snprintf(kmem_name, 128, "kvm-spt-%p", vcpu);
>>>> +    vcpu->arch.hpte_cache = kmem_cache_create(kmem_name,
>>>> +        sizeof(struct hpte_cache), sizeof(struct hpte_cache), 0,  
>>>> NULL);
>>>>
>>>>
>>> Why not one global cache?
>>>
>> You mean over all vcpus? Or over all VMs?
>
> Totally global.  As in 'static struct kmem_cache *kvm_hpte_cache;'.

What would be the benefit?

>
>> Because this way they don't interfere. An operation on one vCPU  
>> doesn't inflict anything on another. There's also no locking  
>> necessary this way.
>>
>
> The slab writers have solved this for everyone, not just us.   
> kmem_cache_alloc() will usually allocate from a per-cpu cache, so no  
> interference and/or locking.  See ____cache_alloc().
>
> If there's a problem in kmem_cache_alloc(), solve it there, don't  
> introduce workarounds.

So you would still keep different hash arrays and everything, just  
allocate the objects from a global pool? I still fail to see how that  
benefits anyone.

Alex
