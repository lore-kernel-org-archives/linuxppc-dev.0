Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41WNpc0fSCzDqCH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 16:07:36 +1000 (AEST)
In-Reply-To: <20180613132414.32207-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: npiggin@gmail.com
Subject: Re: powerpc/64s: Report SLB multi-hit rather than parity error
Message-Id: <41WNpb45dJz9s4r@ozlabs.org>
Date: Thu, 19 Jul 2018 16:07:35 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-06-13 at 13:24:14 UTC, Michael Ellerman wrote:
> When we take an SLB multi-hit on bare metal, we see both the multi-hit
> and parity error bits set in DSISR. The user manuals indicates this is
> expected to always happen on Power8, whereas on Power9 it says a
> multi-hit will "usually" also cause a parity error.
> 
> We decide what to do based on the various error tables in mce_power.c,
> and because we process them in order and only report the first, we
> currently always report a parity error but not the multi-hit, eg:
> 
>   Severe Machine check interrupt [Recovered]
>     Initiator: CPU
>     Error type: SLB [Parity]
>       Effective address: c000000ffffd4300
> 
> Although this is correct, it leaves the user wondering why they got a
> parity error. It would be clearer instead if we reported the
> multi-hit because that is more likely to be simply a software bug,
> whereas a true parity error is possibly an indication of a bad core.
> 
> We can do that simply by reordering the error tables so that multi-hit
> appears before parity. That doesn't affect the error recovery at all,
> because we flush the SLB either way.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/54dbcfc211f15586c57d27492f938e

cheers
