Return-Path: <robin.murphy@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vxZpX6YwTzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 00:52:52 +1000 (AEST)
Subject: Re: [RFC PATCH 2/5] soc/fsl/qbman: Use shared-dma-pool for QMan
 private memory allocations
To: Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>,
 roy.pledge@nxp.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <1490822037-6752-1-git-send-email-roy.pledge@nxp.com>
 <1490822037-6752-3-git-send-email-roy.pledge@nxp.com>
 <b1cd8d44-8c74-ab50-5dc9-1f978cae5bdf@arm.com>
 <871ste5dmw.fsf@concordia.ellerman.id.au>
 <dfaa1a28-66d8-15fb-7d2d-75e206161770@arm.com>
 <1491031518.2944.62.camel@buserror.net>
Cc: Mark Rutland <mark.rutland@arm.com>, madalin.bucur@nxp.com
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <df00c0ab-22b8-1086-def1-69baf648df72@arm.com>
Date: Mon, 3 Apr 2017 15:52:46 +0100
MIME-Version: 1.0
In-Reply-To: <1491031518.2944.62.camel@buserror.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/04/17 08:25, Scott Wood wrote:
> On Fri, 2017-03-31 at 18:55 +0100, Robin Murphy wrote:
>> On 31/03/17 04:27, Michael Ellerman wrote:
>>>
>>> Robin Murphy <robin.murphy@arm.com> writes:
>>>
>>>>
>>>> Hi Roy,
>>>>
>>>> On 29/03/17 22:13, Roy Pledge wrote:
>>>>>
>>>>> Use the shared-memory-pool mechanism for frame queue descriptor and
>>>>> packed frame descriptor record area allocations.
>>>> Thanks for persevering with this - in my opinion it's now looking like
>>>> it was worth the effort :)
>>>>
>>>> AFAICS the ioremap_wc() that this leads to does appear to give back
>>>> something non-cacheable on PPC (assuming "pgprot_noncached_wc" isn't
>>>> horrendously misnamed), and "no-map" should rule out any cacheable
>>>> linear map alias existing, so it would seem that this approach should
>>>> avert Scott's concerns about attribute mismatches.
>>> How does 'no-map' translate into something being excluded from the
>>> linear mapping?
>> Reserved regions marked with "no-map" get memblock_remove()d by
>> early_init_dt_alloc_reserved_memory_arch(). As I understand things, the
>> linear map should only cover memblock areas, and it would be explicitly
>> violating the semantics of "no-map" to still cover such a region.
> 
> Discontiguous memory isn't supported on these PPC chips.  Everything up to
> memblock_end_of_DRAM() gets mapped -- and if that were to change, the
> fragmentation would waste TLB1 entries.

Ah, so the "PPC-specific angles I'm not aware of" category is indeed
non-empty - I guess the lack of HAVE_GENERIC_DMA_COHERENT might be
related, then.

That said, though, AFAICS only certain x86 and s390 configurations ever
call memblock_set_bottom_up(true), so we should be able to assume that
the reserved region allocations always fall through to
__memblock_find_range_top_down(). Thus if your DRAM is contiguous, then
"no-map"-ing the reserved regions will simply end up pushing
memblock_end_of_DRAM() down in a manner that would appear to still avoid
overlaps. I can only see that going wrong if the end of DRAM wasn't at
least 32MB aligned to begin with - is that ever likely to happen in
practice?

Robin.

> This also breaks compatibility with existing device trees.  I suggest putting
> an ifdef in the qbman driver to add the new scheme for non-PPC arches only.
> 
> -Scott
> 
