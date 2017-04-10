Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w253C09vCzDqFy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 08:49:26 +1000 (AEST)
In-Reply-To: <1491185155-27876-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: scottwood@freescale.com
Subject: Re: powerpc/nohash: Fix use of mmu_has_feature() in
 setup_initial_memory_limit()
Message-Id: <3w253B5mN3z9sNJ@ozlabs.org>
Date: Tue, 11 Apr 2017 08:49:26 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-04-03 at 02:05:55 UTC, Michael Ellerman wrote:
> setup_initial_memory_limit() is called from early_init_devtree(), which
> runs prior to feature patching. If the kernel is built with CONFIG_JUMP_LABEL=y
> and CONFIG_JUMP_LABEL_FEATURE_CHECKS=y then we will potentially get the
> wrong value.
> 
> If we also have CONFIG_JUMP_LABEL_FEATURE_CHECK_DEBUG=y we get a warning
> and backtrace:
> 
>   Warning! mmu_has_feature() used prior to jump label init!
>   CPU: 0 PID: 0 Comm: swapper Not tainted 4.11.0-rc4-gccN-next-20170331-g6af2434 #1
>   Call Trace:
>   [c000000000fc3d50] [c000000000a26c30] .dump_stack+0xa8/0xe8 (unreliable)
>   [c000000000fc3de0] [c00000000002e6b8] .setup_initial_memory_limit+0xa4/0x104
>   [c000000000fc3e60] [c000000000d5c23c] .early_init_devtree+0xd0/0x2f8
>   [c000000000fc3f00] [c000000000d5d3b0] .early_setup+0x90/0x11c
>   [c000000000fc3f90] [c000000000000520] start_here_multiplatform+0x68/0x80
> 
> Fix it by using early_mmu_has_feature().
> 
> Fixes: c12e6f24d413 ("powerpc: Add option to use jump label for mmu_has_feature()")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/4868e3508d1934d28961f940ed6b9f

cheers
