Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49D031A038D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 22:21:23 +1100 (AEDT)
In-Reply-To: <1442431574-4575-1-git-send-email-kda@linux-powerpc.org>
To: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Denis Kirjanov <kda@linux-powerpc.org>,
 Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [v3] powerpc: msi: mark bitmap with kmemleak_not_leak()
Message-Id: <20151012112123.3028A140D8F@ozlabs.org>
Date: Mon, 12 Oct 2015 22:21:22 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-16-09 at 19:26:14 UTC, Denis Kirjanov wrote:
> During the MSI bitmap test on boot kmemleak spews the following trace:
> 
> unreferenced object 0xc00000016e86c900 (size 64):
>     comm "swapper/0", pid 1, jiffies 4294893173 (age 518.024s)
>     hex dump (first 32 bytes):
> 	00 00 01 ff 7f ff 7f 37 00 00 00 00 00 00 00 00
> 	.......7........
> 	ff ff ff ff ff ff ff ff 01 ff ff ff ff
> 	ff ff ff
> 	................
> 	backtrace:
> 	[<c00000000003eebc>] .zalloc_maybe_bootmem+0x3c/0x380
> 	[<c000000000042d6c>] .msi_bitmap_alloc+0x3c/0xb0
> 	[<c000000000a9aff8>] .msi_bitmap_selftest+0x30/0x2b4
> 	[<c0000000000090f4>] .do_one_initcall+0xd4/0x270
> 	[<c000000000a8e250>] .kernel_init_freeable+0x1a0/0x280
> 	[<c000000000009b5c>] .kernel_init+0x1c/0x120
> 	[<c000000000007fbc>] .ret_from_kernel_thread+0x58/0x9c
> 
> Added a flag to msi_bitmap for tracking allocations
> from slab and memblock so we can properly free/handle
> memory in msi_bitmap_free().
> 
> Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/cb2d3883c6033831e2a93b39

cheers
