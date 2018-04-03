Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Fv5q1dYMzF28s
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 02:03:43 +1000 (AEST)
In-Reply-To: <74EBF461-0D94-4C2D-ABA7-0B9BE010F173@ozlabs.org>
To: Matt Evans <matt@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc: Clear branch trap (MSR.BE) before delivering SIGTRAP
Message-Id: <40Fv5p4GXqz9s0y@ozlabs.org>
Date: Wed,  4 Apr 2018 02:03:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-03-26 at 16:55:21 UTC, Matt Evans wrote:
> When using SIG_DBG_BRANCH_TRACING, MSR.BE is left enabled in the
> user context when single_step_exception() prepares the SIGTRAP
> delivery.  The resulting branch-trap-within-the-SIGTRAP-handler
> isn't healthy.
> 
> Commit 2538c2d08f46141550a1e68819efa8fe31c6e3dc broke this, by
> replacing an MSR mask operation of ~(MSR_SE | MSR_BE) with a call
> to clear_single_step() which only clears MSR_SE.
> 
> This patch adds a new helper, clear_br_trace(), which clears the
> debug trap before invoking the signal handler.  This helper is a
> NOP for BookE as SIG_DBG_BRANCH_TRACING isn't supported on BookE.
> 
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/0e524e761fc2157f1037e0f5d616cd

cheers
