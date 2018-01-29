Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVGNG2Hn2zDqlb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 15:13:50 +1100 (AEDT)
In-Reply-To: <20180117135818.10241-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: powerpc/64s: Improve RFI L1-D cache flush fallback
Message-Id: <3zVGNF3ZPSz9t3k@ozlabs.org>
Date: Mon, 29 Jan 2018 15:13:49 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-01-17 at 13:58:18 UTC, Nicholas Piggin wrote:
> The fallback RFI flush is used when firmware does not provide a way
> to flush the cache. It's a "displacement flush" that evicts useful
> data by displacing it with an uninteresting buffer.
> 
> The flush has to take care to work with implementation specific cache
> replacment policies, so the recipe has been in flux. The initial
> slow but conservative approach is to touch all lines of a congruence
> class, with dependencies between each load. It has since been
> determined that a linear pattern of loads without dependencies is
> sufficient, and is significantly faster.
> 
> Measuring the speed of a null syscall with RFI fallback flush enabled
> gives the relative improvement:
> 
> P8 - 1.83x
> P9 - 1.75x
> 
> The flush also becomes simpler and more adaptable to different cache
> geometries.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/bdcb1aefc5b3f7d0f1dc8b02673602

cheers
