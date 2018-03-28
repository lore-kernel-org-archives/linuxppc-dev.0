Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409xsf11X6zF2G3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 16:54:30 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Matt Evans <matt@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Clear branch trap (MSR.BE) before delivering
 SIGTRAP
In-Reply-To: <74EBF461-0D94-4C2D-ABA7-0B9BE010F173@ozlabs.org>
References: <74EBF461-0D94-4C2D-ABA7-0B9BE010F173@ozlabs.org>
Date: Wed, 28 Mar 2018 16:54:29 +1100
Message-ID: <877epw3fu2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matt Evans <matt@ozlabs.org> writes:

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

Hi Matt!

It seems we might not be regularly testing this code :}

How did you hit/find the bug? And do you have a test case by any chance?

I found the test code at the bottom of:
  https://lwn.net/Articles/114587/

But it didn't immediately work.

cheers
