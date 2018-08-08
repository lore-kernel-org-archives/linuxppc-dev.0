Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltyy150WzDqkP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:28:10 +1000 (AEST)
In-Reply-To: <20180807114846.6198-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/64: Disable irq restore warning for now
Message-Id: <41ltyw6LLNz9s0n@ozlabs.org>
Date: Thu,  9 Aug 2018 00:28:08 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2018-08-07 at 11:48:46 UTC, Michael Ellerman wrote:
> We recently added a warning in arch_local_irq_restore() to check that
> the soft masking state matches reality.
> 
> Unfortunately it trips in a few places, which are not entirely trivial
> to fix. The key problem is if we're doing function_graph tracing of
> restore_math(), the warning pops and then seems to recurse. It's not
> entirely clear because the system continuously oopses on all CPUs,
> with the output interleaved and unreadable.
> 
> It's also been observed on a G5 coming out of idle.
> 
> Until we can fix those cases disable the warning for now.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/4da1f79227ad42550e3e70e7b4812e

cheers
