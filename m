Return-Path: <thellstrom@vmware.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 88FDE1A0074
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Sep 2014 18:47:20 +1000 (EST)
Received: from smtp-outbound-2.vmware.com (smtp-outbound-2.vmware.com
 [208.91.2.13])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1183714017E
 for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2014 18:47:19 +1000 (EST)
Message-ID: <540826F6.9060505@vmware.com>
Date: Thu, 4 Sep 2014 10:46:46 +0200
From: Thomas Hellstrom <thellstrom@vmware.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: TTM placement & caching issue/questions
References: <1409789547.30640.136.camel@pasglop> <54081844.7000604@vmware.com>
 <1409817962.4246.51.camel@pasglop>
In-Reply-To: <1409817962.4246.51.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Jerome Glisse <j.glisse@gmail.com>, linuxppc-dev@ozlabs.org,
 Michel Danzer <daenzer@vmware.com>, dri-devel@lists.freedesktop.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/04/2014 10:06 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2014-09-04 at 09:44 +0200, Thomas Hellstrom wrote:
>
>>> This will, from what I can tell, try to use the same caching mode as the
>>> original object:
>>>
>>> 	if ((cur_placement & caching) != 0)
>>> 		result |= (cur_placement & caching);
>>>
>>> And cur_placement comes from bo->mem.placement which as far as I can
>>> tell is based on the placement array which the drivers set up.
>> This originates from the fact that when evicting GTT memory, on x86 it's
>> unnecessary and undesirable to switch caching mode when going to system.
> But that's what I don't quite understand. We have two different mappings
> here. The VRAM and the memory object. We wouldn't be "switching"... we
> are creating a temporary mapping for the memory object in order to do
> the memcpy, but we seem to be doing it by using the caching attributes
> of the VRAM object.... or am I missing something ? I don't see how that
> makes sense so I suppose I'm missing something here :-)

Well, the intention when TTM was written was that the driver writer
should be smart enough that when he wanted a move from unached VRAM to
system, he'd request cached system in the placement flags in the first
place.  If TTM somehow overrides such a request, that's a bug in TTM.

If the move, for example, is a result of an eviction, then the driver
evict_flags() function should ideally look at the current placement and
decide about a suitable placement based on that: vram-to-system moves
should generally request cacheable memory if the next access is expected
by the CPU. Probably write-combined otherwise.
If the move is the result of a TTM swapout, TTM will automatically
select cachable system, and for most other moves, I think the driver
writer is in full control.

>
>> Last time I tested, (and it seems like Michel is on the same track),
>> writing with the CPU to write-combined memory was substantially faster
>> than writing to cached memory, with the additional side-effect that CPU
>> caches are left unpolluted.
> That's very strange indeed. It's certainly an x86 specific artifact,
> even if we were allowed by our hypervisor to map memory non-cachable
> (the HW somewhat can), we tend to have a higher throughput by going
> cachable, but that could be due to the way the PowerBus works (it's
> basically very biased toward cachable transactions).
>
>> I dislike the approach of rewriting placements. In some cases I think it
>> won't even work, because placements are declared 'static const'
>>
>> What I'd suggest is instead to intercept the driver response from
>> init_mem_type() and filter out undesired caching modes from
>> available_caching and default_caching, 
> This was my original intent but Jerome seems to have different ideas
> (see his proposed patches). I'm happy to revive mine as well and post it
> as an alternative after I've tested it a bit more (tomorrow).
>
>> perhaps also looking at whether
>> the memory type is mappable or not. This should have the additional
>> benefit of working everywhere, and if a caching mode is selected that's
>> not available on the platform, you'll simply get an error. (I guess?)
> You mean that if not mappable we don't bother filtering ?
>
> The rule is really for me pretty simple:
>
>    - If it's system memory (PL_SYSTEM/PL_TT), it MUST be cachable
>
>    - If it's PCIe memory space (VRAM, registers, ...) it MUST be
> non-cachable.

Yes, something along these lines. I guess checking for VRAM or
TTM_MEMTYPE_FLAG_FIXED would perhaps do the trick

/Thomas

>
> Cheers,
> Ben.
>
>> /Thomas
>>
>>
>>> Cheers,
>>> Ben.
>>>
>>>
>>> _______________________________________________
>>> dri-devel mailing list
>>> dri-devel@lists.freedesktop.org
>>> https://urldefense.proofpoint.com/v1/url?u=http://lists.freedesktop.org/mailman/listinfo/dri-devel&k=oIvRg1%2BdGAgOoM1BIlLLqw%3D%3D%0A&r=l5Ago9ekmVFZ3c4M6eauqrJWGwjf6fTb%2BP3CxbBFkVM%3D%0A&m=C9AHL1VngKBOxe2UrNP2eCZo6FLqdlr6Y90rpfE5rUs%3D%0A&s=73da0633bafc5d54bf116bc861d48d13c39cf8f41832adfb739709e98ec05553
>
