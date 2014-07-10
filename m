Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 068691A017A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 23:31:05 +1000 (EST)
Message-ID: <53BE957E.2030606@suse.de>
Date: Thu, 10 Jul 2014 15:30:38 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mel Gorman <mgorman@suse.com>
Subject: Re: [PATCH v2] Use the POWER8 Micro Partition Prefetch Engine in
 KVM HV on POWER8
References: <1404437035-4336-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1404795988-9892-1-git-send-email-stewart@linux.vnet.ibm.com>
 <53BBCAC7.90904@suse.de> <m3bnszqwx1.fsf@oc8180480414.ibm.com>
 <53BE738B.1010100@suse.de> <20140710130716.GQ25275@novell.com>
 <53BE925C.2030401@suse.de> <20140710133012.GR25275@novell.com>
In-Reply-To: <20140710133012.GR25275@novell.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, paulus@samba.org,
 linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.07.14 15:30, Mel Gorman wrote:
> On Thu, Jul 10, 2014 at 03:17:16PM +0200, Alexander Graf wrote:
>> On 10.07.14 15:07, Mel Gorman wrote:
>>> On Thu, Jul 10, 2014 at 01:05:47PM +0200, Alexander Graf wrote:
>>>> On 09.07.14 00:59, Stewart Smith wrote:
>>>>> Hi!
>>>>>
>>>>> Thanks for review, much appreciated!
>>>>>
>>>>> Alexander Graf <agraf@suse.de> writes:
>>>>>> On 08.07.14 07:06, Stewart Smith wrote:
>>>>>>> @@ -1528,6 +1535,7 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
>>>>>>>    	int i, need_vpa_update;
>>>>>>>    	int srcu_idx;
>>>>>>>    	struct kvm_vcpu *vcpus_to_update[threads_per_core];
>>>>>>> +	phys_addr_t phy_addr, tmp;
>>>>>> Please put the variable declarations into the if () branch so that the
>>>>>> compiler can catch potential leaks :)
>>>>> ack. will fix.
>>>>>
>>>>>>> @@ -1590,9 +1598,48 @@ static void kvmppc_run_core(struct kvmppc_vcore *vc)
>>>>>>>    	srcu_idx = srcu_read_lock(&vc->kvm->srcu);
>>>>>>> +	/* If we have a saved list of L2/L3, restore it */
>>>>>>> +	if (cpu_has_feature(CPU_FTR_ARCH_207S) && vc->mpp_buffer) {
>>>>>>> +		phy_addr = virt_to_phys((void *)vc->mpp_buffer);
>>>>>>> +#if defined(CONFIG_PPC_4K_PAGES)
>>>>>>> +		phy_addr = (phy_addr + 8*4096) & ~(8*4096);
>>>>>> get_free_pages() is automatically aligned to the order, no?
>>>>> That's what Paul reckoned too, and then we've attempted to find anywhere
>>>>> that documents that behaviour. Happen to be able to point to docs/source
>>>>> that say this is part of API?
>>>> Phew - it's probably buried somewhere. I could only find this
>>>> document saying that we always get order-aligned allocations:
>>>>
>>>> http://www.thehackademy.net/madchat/ebooks/Mem_virtuelle/linux-mm/zonealloc.html
>>>>
>>>> Mel, do you happen to have any pointer to something that explicitly
>>>> (or even properly implicitly) says that get_free_pages() returns
>>>> order-aligned memory?
>>>>
>>> I did not read the whole thread so I lack context and will just answer
>>> this part.
>>>
>>> There is no guarantee that pages are returned in PFN order for multiple
>>> requests to the page allocator. This is the relevant comment in
>>> rmqueue_bulk
>>>
>>>                  /*
>>>                   * Split buddy pages returned by expand() are received here
>>>                   * in physical page order. The page is added to the callers and
>>>                   * list and the list head then moves forward. From the callers
>>>                   * perspective, the linked list is ordered by page number in
>>>                   * some conditions. This is useful for IO devices that can
>>>                   * merge IO requests if the physical pages are ordered
>>>                   * properly.
>>>                   */
>>>
>>> It will probably be true early in the lifetime of the system but the milage
>>> will vary on systems with a lot of uptime. If you depend on this behaviour
>>> for correctness then you will have a bad day.
>>>
>>> High-order page requests to the page allocator are guaranteed to be in physical
>>> order. However, this does not apply to vmalloc() where allocations are
>>> only guaranteed to be virtually contiguous.
>> Hrm, ok to be very concrete:
>>
>>    Does __get_free_pages(..., 4); on a 4k page size system give me a
>> 64k aligned pointer? :)
>>
> Yes.

Awesome - thanks a lot! :)


Alex
