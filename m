Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0B6E1A016B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 21:05:51 +1000 (EST)
Message-ID: <53BE738B.1010100@suse.de>
Date: Thu, 10 Jul 2014 13:05:47 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Stewart Smith <stewart@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 kvm-ppc@vger.kernel.org, Mel Gorman <mgorman@suse.com>
Subject: Re: [PATCH v2] Use the POWER8 Micro Partition Prefetch Engine in
 KVM HV on POWER8
References: <1404437035-4336-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1404795988-9892-1-git-send-email-stewart@linux.vnet.ibm.com>
 <53BBCAC7.90904@suse.de> <m3bnszqwx1.fsf@oc8180480414.ibm.com>
In-Reply-To: <m3bnszqwx1.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 09.07.14 00:59, Stewart Smith wrote:
> Hi!
>
> Thanks for review, much appreciated!
>
> Alexander Graf <agraf@suse.de> writes:
>> On 08.07.14 07:06, Stewart Smith wrote:
>>> @@ -1528,6 +1535,7 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
>>>    	int i, need_vpa_update;
>>>    	int srcu_idx;
>>>    	struct kvm_vcpu *vcpus_to_update[threads_per_core];
>>> +	phys_addr_t phy_addr, tmp;
>> Please put the variable declarations into the if () branch so that the
>> compiler can catch potential leaks :)
> ack. will fix.
>
>>> @@ -1590,9 +1598,48 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
>>>    
>>>    	srcu_idx = srcu_read_lock(&vc->kvm->srcu);
>>>    
>>> +	/* If we have a saved list of L2/L3, restore it */
>>> +	if (cpu_has_feature(CPU_FTR_ARCH_207S) && vc->mpp_buffer) {
>>> +		phy_addr = virt_to_phys((void *)vc->mpp_buffer);
>>> +#if defined(CONFIG_PPC_4K_PAGES)
>>> +		phy_addr = (phy_addr + 8*4096) & ~(8*4096);
>> get_free_pages() is automatically aligned to the order, no?
> That's what Paul reckoned too, and then we've attempted to find anywhere
> that documents that behaviour. Happen to be able to point to docs/source
> that say this is part of API?

Phew - it's probably buried somewhere. I could only find this document 
saying that we always get order-aligned allocations:

http://www.thehackademy.net/madchat/ebooks/Mem_virtuelle/linux-mm/zonealloc.html

Mel, do you happen to have any pointer to something that explicitly (or 
even properly implicitly) says that get_free_pages() returns 
order-aligned memory?

>
>>> +#endif
>>> +		tmp = phy_addr & PPC_MPPE_ADDRESS_MASK;
>>> +		tmp = tmp | PPC_MPPE_WHOLE_TABLE;
>>> +
>>> +		/* For sanity, abort any 'save' requests in progress */
>>> +		asm volatile(PPC_LOGMPP(R1) : : "r" (tmp));
>>> +
>>> +		/* Inititate a cache-load request */
>>> +		mtspr(SPRN_MPPR, tmp);
>>> +	}
>> In fact, this whole block up here could be a function, no?
> It could, perfectly happy for it to be one. Will fix.
>
>>> +
>>> +	/* Allocate memory before switching out of guest so we don't
>>> +	   trash L2/L3 with memory allocation stuff */
>>> +	if (cpu_has_feature(CPU_FTR_ARCH_207S) && !vc->mpp_buffer) {
>>> +		vc->mpp_buffer = __get_free_pages(GFP_KERNEL|__GFP_ZERO,
>>> +						  MPP_BUFFER_ORDER);
>> get_order(64 * 1024)?
>>
>> Also, why allocate it here and not on vcore creation?
> There's also the possibility of saving/restorting part of the L3 cache
> as well, and I was envisioning a future patch to this which checks a
> flag in vcore (maybe exposed via sysfs or whatever mechanism is
> applicable) if it should save/restore L2 or L2/L3, so thus it makes a
> bit more sense allocating it there rather than elsewhere.
>
> There's also no real reason to fail to create a vcore if we can't
> allocate a buffer for L2/L3 cache contents - retrying later is perfectly
> harmless.

If we failed during core creation just don't save/restore L2 cache 
contents at all. I really prefer to have allocation and dealloction all 
at init time - and such low order allocations will most likely succeed.

Let's leave the L3 cache bits for later when we know whether it actually 
has an impact. I personally doubt it :).


Alex
