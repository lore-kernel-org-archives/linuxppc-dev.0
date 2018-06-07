Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 411R2H2JL5zF31s
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Jun 2018 10:17:43 +1000 (AEST)
In-Reply-To: <20180606014008.20363-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s/radix: Fix missing ptesync in flush_cache_vmap
Message-Id: <411R2H1G5Kz9s1b@ozlabs.org>
Date: Thu,  7 Jun 2018 10:17:43 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-06-06 at 01:40:08 UTC, Nicholas Piggin wrote:
> There is a typo in f1cb8f9beb ("powerpc/64s/radix: avoid ptesync after
> set_pte and ptep_set_access_flags") config ifdef, which results in the
> necessary ptesync not being issued after vmalloc.
> 
> This causes random kernel faults in module load, bpf load, anywhere
> that vmalloc mappings are used.
> 
> After correcting the code, this survives a guest kernel booting
> hundreds of times where previously there would be a crash every few
> boots (I haven't noticed the crash on host, perhaps due to different
> TLB and page table walking behaviour in hardware).
> 
> A memory clobber is also added to the flush, just to be sure it won't
> be reordered with the pte set or the subsequent mapping access.
> 
> Fixes: f1cb8f9beb ("powerpc/64s/radix: avoid ptesync after set_pte and ptep_set_access_flags")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ff5bc793e47b537bf3e904fada585e

cheers
