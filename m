Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B75591A2BF9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Sep 2015 16:04:38 +1000 (AEST)
Message-ID: <1442210677.8149.1.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: msi: mark bitmap with kmemleak_not_leak()
From: Michael Ellerman <mpe@ellerman.id.au>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org, Catalin Marinas <catalin.marinas@arm.com>
Date: Mon, 14 Sep 2015 16:04:37 +1000
In-Reply-To: <1442169397-4271-1-git-send-email-kda@linux-powerpc.org>
References: <1442169397-4271-1-git-send-email-kda@linux-powerpc.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-09-13 at 21:36 +0300, Denis Kirjanov wrote:
> During the MSI bitmap test on boot kmemleak spews the following trace:
> 
> unreferenced object 0xc00000016e86c900 (size 64):
>     comm "swapper/0", pid 1, jiffies 4294893173 (age 518.024s)
>     hex dump (first 32 bytes):
> 	00 00 01 ff 7f ff 7f 37 00 00 00 00 00 00 00 00
> 	.......7........
> 	ff ff ff ff ff ff ff ff 01 ff ff ff ff ff ff ff
> 	................
> 	backtrace:
> 	[<c00000000003eebc>] .zalloc_maybe_bootmem+0x3c/0x380
> 	[<c000000000042d6c>] .msi_bitmap_alloc+0x3c/0xb0
> 	[<c000000000a9aff8>]
> 	.msi_bitmap_selftest+0x30/0x2b4
> 	[<c0000000000090f4>]
> 	.do_one_initcall+0xd4/0x270
> 	[<c000000000a8e250>]
> 	.kernel_init_freeable+0x1a0/0x280
> 	[<c000000000009b5c>]
> 	.kernel_init+0x1c/0x120
> 	[<c000000000007fbc>]
> 	.ret_from_kernel_thread+0x58/0x9c
> 
> The comment in msi_bitmap_free() states that we can't free
> the bitmap so mark it with the kmemleak_not_leak().

Yeah, and I've always hated that comment :)

I assume it's still true now that we don't use bootmem?

cheers
