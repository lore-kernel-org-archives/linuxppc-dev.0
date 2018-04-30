Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZLjX4tkszDqlJ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 20:43:12 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, anton@ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, benh@kernel.crashing.org, alistair@popple.id.au,
 arbab@linux.vnet.ibm.com, Balbir Singh <bsingharora@gmail.com>,
 Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] Revert "powerpc/powernv: Increase memory block size to
 1GB on radix"
In-Reply-To: <20180430083432.21546-1-bsingharora@gmail.com>
References: <20180430083432.21546-1-bsingharora@gmail.com>
Date: Mon, 30 Apr 2018 20:43:09 +1000
Message-ID: <874ljtrn42.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:
> This reverts commit 53ecde0b9126ff140abe3aefd7f0ec64d6fa36b0.

Firstly everything here only applies to Radix, so we need to say that.

> The commit above changed the memblock size to 1GiB, which did some
> nice things like create fewer TLB entries for mapping memory at
> the time of hotplug.

You say TLB entry here and below, but I think that's misleading. We
don't create TLB entries for mappings at the time of hotplug. We create
entries in the page tables.

And is it true that changing the memory block size to 256MB necessarily
means we'll never create a 1GiB mapping? It looks like if you call
arch_add_memory() with a 1GiB block it will create 1GiB mappings.

I agree if we add 256MB blocks individually then we won't use a 1GiB
mapping.

But I'm not sure any of the above is all that relevant, because we
didn't make the change to 1GiB for any of those reasons, we did it to
prevent the kernel crashing.

If we *did* want to change the block size for 1GiB for performance
reasons then we need a commit that justifies that.

> The downside is that it changes the granularity
> at which memory can be hot-plugged and hot-unplugged. The implication
> is that if we had less than a 1GiB to hot-plug/hot-unplug that
> would not be possible.

That 2nd sentence is not strong enough, it should say something more
like: It forces hot(un)plug to operate at a 1GiB granularity.

> The reason we had this fix was to resolve an issue where we did not
> split mappings on hot-unplug, leaving a TLB entry that spanned the
> region that was unplugged. This is now fixed by 4dd5f8a99e79 which
> splits the page table, removing the MMU mappings for the hot-unplugged
> region correctly.

I'd say:

This commit was a stop-gap to prevent crashes on hotunplug, caused by
the mismatch between the 1G mappings used for the linear mapping and the
memory block size. Those issues are now resolved because we split the
linear mapping at hotunplug time if necessary, as implemented in commit
4dd5f8a99e79 ("powerpc/mm/radix: Split linear mapping on hot-unplug").

cheers
