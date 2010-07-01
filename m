Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id C1AFA1007F1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 22:43:57 +1000 (EST)
Message-ID: <4C2C8D8A.7080103@redhat.com>
Date: Thu, 01 Jul 2010 15:43:54 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/2] Faster MMU lookups for Book3s v3
References: <1277903926-12786-1-git-send-email-agraf@suse.de>
	<4C2C43C0.4000400@redhat.com>
	<7F9C2F52-3E95-4A22-B973-DACEBC95E5F4@suse.de>
	<4C2C547E.7010404@redhat.com> <4C2C6745.8040001@suse.de>
	<4C2C78AC.3070605@redhat.com> <4C2C89D6.3090401@suse.de>
In-Reply-To: <4C2C89D6.3090401@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

On 07/01/2010 03:28 PM, Alexander Graf wrote:
>
>>
>>>    Wouldn't it speed up dirty bitmap flushing
>>> a lot if we'd just have a simple linked list of all sPTEs belonging to
>>> that memslot?
>>>
>>>        
>> The complexity is O(pages_in_slot) + O(sptes_for_slot).
>>
>> Usually, every page is mapped at least once, so sptes_for_slot
>> dominates.  Even when it isn't so, iterating the rmap base pointers is
>> very fast since they are linear in memory, while sptes are scattered
>> around, causing cache misses.
>>      
> Why would pages be mapped often?

It's not a question of how often they are mapped (shadow: very often; 
tdp: very rarely) but what percentage of pages are mapped.  It's usually 
100%.

> Don't you use lazy spte updates?
>    

We do, but given enough time, the guest will touch its entire memory.


>> Another consideration is that on x86, an spte occupies just 64 bits
>> (for the hardware pte); if there are multiple sptes per page (rare on
>> modern hardware), there is also extra memory for rmap chains;
>> sometimes we also allocate 64 bits for the gfn.  Having an extra
>> linked list would require more memory to be allocated and maintained.
>>      
> Hrm. I was thinking of not having an rmap but only using the chain. The
> only slots that would require such a chain would be the ones with dirty
> bitmapping enabled, so no penalty for normal RAM (unless you use kemari
> or live migration of course).
>    

You could also only chain writeable ptes.

> But then again I probably do need an rmap for the mmu_notifier magic,
> right? But I'd rather prefer to have that code path be slow and the
> dirty bitmap invalidation fast than the other way around. Swapping is
> slow either way.
>    

It's not just swapping, it's also page ageing.  That needs to be fast.  
Does ppc have a hardware-set referenced bit?  If so, you need a fast 
rmap for mmu notifiers.

-- 
error compiling committee.c: too many arguments to function
