Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wd1GK59LCzDq5j
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 31 May 2017 16:46:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Hugh Dickins <hughd@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mm@kvack.org
Subject: Re: 4.12-rc ppc64 4k-page needs costly allocations
In-Reply-To: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
References: <alpine.LSU.2.11.1705301151090.2133@eggly.anvils>
Date: Wed, 31 May 2017 16:46:14 +1000
Message-ID: <87h9014j7t.fsf@concordia.ellerman.id.au>
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

Hugh Dickins <hughd@google.com> writes:

> Since f6eedbba7a26 ("powerpc/mm/hash: Increase VA range to 128TB")
> I find that swapping loads on ppc64 on G5 with 4k pages are failing:
>
> SLUB: Unable to allocate memory on node -1, gfp=0x14000c0(GFP_KERNEL)
>   cache: pgtable-2^12, object size: 32768, buffer size: 65536, default order: 4, min order: 4
>   pgtable-2^12 debugging increased min order, use slub_debug=O to disable.
>   node 0: slabs: 209, objs: 209, free: 8
> gcc: page allocation failure: order:4, mode:0x16040c0(GFP_KERNEL|__GFP_COMP|__GFP_NOTRACK), nodemask=(null)
> CPU: 1 PID: 6225 Comm: gcc Not tainted 4.12.0-rc2 #1
> Call Trace:
> [c00000000090b5c0] [c0000000004f8478] .dump_stack+0xa0/0xcc (unreliable)
> [c00000000090b650] [c0000000000eb194] .warn_alloc+0xf0/0x178
> [c00000000090b710] [c0000000000ebc9c] .__alloc_pages_nodemask+0xa04/0xb00
> [c00000000090b8b0] [c00000000013921c] .new_slab+0x234/0x608
> [c00000000090b980] [c00000000013b59c] .___slab_alloc.constprop.64+0x3dc/0x564
> [c00000000090bad0] [c0000000004f5a84] .__slab_alloc.isra.61.constprop.63+0x54/0x70
> [c00000000090bb70] [c00000000013b864] .kmem_cache_alloc+0x140/0x288
> [c00000000090bc30] [c00000000004d934] .mm_init.isra.65+0x128/0x1c0
> [c00000000090bcc0] [c000000000157810] .do_execveat_common.isra.39+0x294/0x690
> [c00000000090bdb0] [c000000000157e70] .SyS_execve+0x28/0x38
> [c00000000090be30] [c00000000000a118] system_call+0x38/0xfc
>
> I did try booting with slub_debug=O as the message suggested, but that
> made no difference: it still hoped for but failed on order:4 allocations.
>
> I wanted to try removing CONFIG_SLUB_DEBUG, but didn't succeed in that:
> it seemed to be a hard requirement for something, but I didn't find what.
>
> I did try CONFIG_SLAB=y instead of SLUB: that lowers these allocations to
> the expected order:3, which then results in OOM-killing rather than direct
> allocation failure, because of the PAGE_ALLOC_COSTLY_ORDER 3 cutoff.  But
> makes no real difference to the outcome: swapping loads still abort early.
>
> Relying on order:3 or order:4 allocations is just too optimistic: ppc64
> with 4k pages would do better not to expect to support a 128TB userspace.
>
> I tried the obvious partial revert below, but it's not good enough:
> the system did not boot beyond
>
> Starting init: /sbin/init exists but couldn't execute it (error -7)
> Starting init: /bin/sh exists but couldn't execute it (error -7)
> Kernel panic - not syncing: No working init found. ...

Ouch, sorry.

I boot test a G5 with 4K pages, but I don't stress test it much so I
didn't notice this.

I think making 128TB depend on 64K pages makes sense, Aneesh is going to
try and do a patch for that.

cheers
