Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yWlyz5L18zDrCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Nov 2017 10:30:19 +1100 (AEDT)
In-Reply-To: <20171024130654.1223-4-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v2,
 3/3] powerpc/64s/radix: Fix process table entry cache invalidation
Message-Id: <3yWlyz3fDyz9t2Z@ozlabs.org>
Date: Wed,  8 Nov 2017 10:30:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-10-24 at 13:06:54 UTC, Nicholas Piggin wrote:
> According to the architecture, the process table entry cache must be
> flushed with tlbie RIC=2.
> 
> Currently the process table entry is set to invalid right before the
> PID is returned to the allocator, with no invalidation. This works on
> existing implementations that are known to not cache the process table
> entry for any except the current PIDR.
> 
> It is architecturally correct and cleaner to invalidate with RIC=2
> after clearing the process table entry and before the PID is returned
> to the allocator. This can be done in arch_exit_mmap that runs before
> the final flush, and to ensure the final flush (fullmm) is always a
> RIC=2 variant.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/30b49ec798f0984b905fd94d1957d6

cheers
