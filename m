Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZLsh5YHCzDqlJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 20:50:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, Balbir Singh <bsingharora@gmail.com>
Cc: anton@ozlabs.org, linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 alistair@popple.id.au, arbab@linux.vnet.ibm.com,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Revert "powerpc/powernv: Increase memory block size to
 1GB on radix"
In-Reply-To: <20180430195356.0f44123b@roar.ozlabs.ibm.com>
References: <20180430083432.21546-1-bsingharora@gmail.com>
 <20180430195356.0f44123b@roar.ozlabs.ibm.com>
Date: Mon, 30 Apr 2018 20:50:15 +1000
Message-ID: <871sexrms8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Mon, 30 Apr 2018 18:34:32 +1000
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> This reverts commit 53ecde0b9126ff140abe3aefd7f0ec64d6fa36b0.
>> 
>> The commit above changed the memblock size to 1GiB, which did some
>> nice things like create fewer TLB entries for mapping memory at
>> the time of hotplug. The downside is that it changes the granularity
>> at which memory can be hot-plugged and hot-unplugged. The implication
>> is that if we had less than a 1GiB to hot-plug/hot-unplug that
>> would not be possible.
>> 
>> The reason we had this fix was to resolve an issue where we did not
>> split mappings on hot-unplug, leaving a TLB entry that spanned the
>> region that was unplugged. This is now fixed by 4dd5f8a99e79 which
>> splits the page table, removing the MMU mappings for the hot-unplugged
>> region correctly.
>> 
>> This trade-offs performance as we increase the number of TLB's to
>> map 1GiB of memory, mapped in via hot-plug, but gives us the ability
>> to handle smaller memory sizes.
>
> Why does powernv have any memory block size override at all now?

I dunno, history says:

    powerpc/powernv: Set memory_block_size_bytes to 256MB
    
    powerpc sets a low SECTION_SIZE_BITS to accomodate small pseries
    boxes. We default to 16MB memory blocks, and boxes with a lot
    of memory end up with enormous numbers of sysfs memory nodes.
    
    Set a more reasonable default for powernv of 256MB.
    
    Signed-off-by: Anton Blanchard <anton@samba.org>


It might make more sense to go back to a single definition for powerpc
and have it return a sensible size based on the total available memory -
though I guess memory hotplugged after boot might make that difficult.

Because we definitely have pseries machines with a lot of memory these
days too.

cheers
