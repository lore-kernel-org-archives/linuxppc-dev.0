Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vzNMQ2drXzDqMZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 23:09:06 +1000 (AEST)
In-Reply-To: <1491392949-6879-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: oohall@gmail.com
Subject: Re: [v2] powerpc/64: Fix flush_(d|i)cache_range() called from modules
Message-Id: <3vzNMQ0Jcwz9s8S@ozlabs.org>
Date: Thu,  6 Apr 2017 23:09:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-05 at 11:49:09 UTC, Michael Ellerman wrote:
> From: Oliver O'Halloran <oohall@gmail.com>
> 
> When the kernel is compiled to use 64bit ABIv2 the _GLOBAL() macro does
> not include a global entry point. A function's global entry point is
> used when the function is called from a different TOC context and in the
> kernel this typically means a call from a module into the vmlinux (or
> vice-versa).
> 
> There are a few exported asm functions declared with _GLOBAL() and
> calling them from a module will likely crash the kernel since any TOC
> relative load will yield garbage.
> 
> flush_icache_range() and flush_dcache_range() are both exported to
> modules, and use the TOC, so must use _GLOBAL_TOC().
> 
> Fixes: 721aeaa9fdf3 ("powerpc: Build little endian ppc64 kernel with ABIv2")
> Cc: stable@vger.kernel.org # v3.16+
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/8f5f525d5b83f7d76a6baf9c4e94d4

cheers
