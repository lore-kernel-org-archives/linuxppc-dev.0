Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 26D1EB707F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 28 Jun 2010 19:34:19 +1000 (EST)
Message-ID: <4C286C98.8060903@redhat.com>
Date: Mon, 28 Jun 2010 12:34:16 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: Add generic hpte management functions
References: <1277507817-626-1-git-send-email-agraf@suse.de>
	<1277507817-626-2-git-send-email-agraf@suse.de>
	<4C285D1C.5060508@redhat.com>
	<20417D40-9345-485B-9201-8B3722B7457F@suse.de>
	<4C286770.6010204@redhat.com>
	<1A0E0E54-D055-4333-B5EC-DE2F71382AB7@suse.de>
In-Reply-To: <1A0E0E54-D055-4333-B5EC-DE2F71382AB7@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 06/28/2010 12:27 PM, Alexander Graf wrote:
>> Am I looking at old code?
>
>
> Apparently. Check book3s_mmu_*.c

I don't have that pattern.

>
>>
>> (another difference is using struct hlist_head instead of list_head, 
>> which I recommend since it saves space)
>
> Hrm. I thought about this quite a bit before too, but that makes 
> invalidation more complicated, no? We always need to remember the 
> previous entry in a list.

hlist_for_each_entry_safe() does that.

>>
>>>>> +int kvmppc_mmu_hpte_init(struct kvm_vcpu *vcpu)
>>>>> +{
>>>>> +    char kmem_name[128];
>>>>> +
>>>>> +    /* init hpte slab cache */
>>>>> +    snprintf(kmem_name, 128, "kvm-spt-%p", vcpu);
>>>>> +    vcpu->arch.hpte_cache = kmem_cache_create(kmem_name,
>>>>> +        sizeof(struct hpte_cache), sizeof(struct hpte_cache), 0, 
>>>>> NULL);
>>>>>
>>>>>
>>>> Why not one global cache?
>>>>
>>> You mean over all vcpus? Or over all VMs?
>>
>> Totally global.  As in 'static struct kmem_cache *kvm_hpte_cache;'.
>
> What would be the benefit?

Less and simpler code, better reporting through slabtop, less wastage of 
partially allocated slab pages.

>>> Because this way they don't interfere. An operation on one vCPU 
>>> doesn't inflict anything on another. There's also no locking 
>>> necessary this way.
>>>
>>
>> The slab writers have solved this for everyone, not just us.  
>> kmem_cache_alloc() will usually allocate from a per-cpu cache, so no 
>> interference and/or locking.  See ____cache_alloc().
>>
>> If there's a problem in kmem_cache_alloc(), solve it there, don't 
>> introduce workarounds.
>
> So you would still keep different hash arrays and everything, just 
> allocate the objects from a global pool? 

Yes.

> I still fail to see how that benefits anyone.

See above.

-- 
error compiling committee.c: too many arguments to function
