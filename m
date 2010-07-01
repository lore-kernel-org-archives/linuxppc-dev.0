Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id BC9111007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Jul 2010 23:42:18 +1000 (EST)
Message-ID: <4C2C9B36.8000002@redhat.com>
Date: Thu, 01 Jul 2010 16:42:14 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 0/2] Faster MMU lookups for Book3s v3
References: <1277903926-12786-1-git-send-email-agraf@suse.de>
	<4C2C43C0.4000400@redhat.com>
	<7F9C2F52-3E95-4A22-B973-DACEBC95E5F4@suse.de>
	<4C2C547E.7010404@redhat.com> <4C2C6745.8040001@suse.de>
	<4C2C78AC.3070605@redhat.com> <4C2C89D6.3090401@suse.de>
	<4C2C8D8A.7080103@redhat.com> <4C2C8FA8.1030702@suse.de>
In-Reply-To: <4C2C8FA8.1030702@suse.de>
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

On 07/01/2010 03:52 PM, Alexander Graf wrote:
>>
>>> Don't you use lazy spte updates?
>>>
>>>        
>> We do, but given enough time, the guest will touch its entire memory.
>>      
> Oh, so that's the major difference. On PPC we have the HTAB with a
> fraction of all the mapped pages in it. We don't have a notion of a full
> page table for a guest process. We always only have a snapshot of some
> mappings and shadow those lazily.
>
> So at worst, we have HPTEG_CACHE_NUM shadow pages mapped, which would be
> (1<<  15) * 4k which again would be at most 128MB of guest memory. We
> can't hold more mappings than that anyways, so chances are low we have a
> mapping for each hva.
>    

Doesn't that seriously impact performance?  A guest that recycles pages 
from its lru will touch pages at random from its entire address space.  
On bare metal that isn't a problem (I imagine) due to large tlbs.  But 
virtualized on 4K pages that means the htlb will be thrashed.

>>> But then again I probably do need an rmap for the mmu_notifier magic,
>>> right? But I'd rather prefer to have that code path be slow and the
>>> dirty bitmap invalidation fast than the other way around. Swapping is
>>> slow either way.
>>>
>>>        
>> It's not just swapping, it's also page ageing.  That needs to be
>> fast.  Does ppc have a hardware-set referenced bit?  If so, you need a
>> fast rmap for mmu notifiers.
>>      
> Page ageing is difficult. The HTAB has a hardware set referenced bit,
> but we don't have a guarantee that the entry is still there when we look
> for it. Something else could have overwritten it by then, but the entry
> could still be lingering around in the TLB.
>    

Whoever's dropping the HTAB needs to update the host struct page, and 
also reflect the bit into the guest's HTAB, no?

In fact, on x86 shadow, we don't have an spte for a gpte that is not 
accessed, precisely so we know the exact point in time when the accessed 
bit is set.

> So I think the only reasonable way to implement page ageing is to unmap
> pages. And that's slow, because it means we have to map them again on
> access. Bleks. Or we could look for the HTAB entry and only unmap them
> if the entry is moot.
>    

I think it works out if you update struct page when you clear out an HTAB.

-- 
error compiling committee.c: too many arguments to function
