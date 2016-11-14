Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHTzm00HlzDvmj
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Nov 2016 23:17:24 +1100 (AEDT)
In-Reply-To: <20161013034352.9410-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>, Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: reduce exception alignment
Message-Id: <3tHTzl660gz9t2b@ozlabs.org>
Date: Mon, 14 Nov 2016 23:17:23 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-13-10 at 03:43:52 UTC, Nicholas Piggin wrote:
> Exception handlers are aligned to 128 bytes (L1 cache) on 64s, which is
> overkill. It can reduce the icache footprint of any individual exception
> path. However taken as a whole, the expansion in icache footprint seems
> likely to be counter-productive and cause more total misses.
> 
> Create IFETCH_ALIGN_SHIFT/BYTES, which should give optimal ifetch
> alignment with much more reasonable alignment. This saves 1792 bytes
> from head_64.o text with an allmodconfig build.
> 
> Other subarchitectures should define appropriate IFETCH_ALIGN_SHIFT
> values if this becomes more widely used.
> 
> Cc: Anton Blanchard <anton@samba.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/f4329f2ecb149282fdfdd8830a936a

cheers
