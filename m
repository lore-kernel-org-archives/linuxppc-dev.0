Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xTPG03FyYzDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2017 22:19:52 +1000 (AEST)
In-Reply-To: <1501488161-27033-1-git-send-email-maddy@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/perf: Factor out PPMU_ONLY_COUNT_RUN check code from
 power8
Message-Id: <3xTPG00nQPz9t3m@ozlabs.org>
Date: Fri, 11 Aug 2017 22:19:51 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-07-31 at 08:02:41 UTC, Madhavan Srinivasan wrote:
> There are some hardware events on Power systems which only
> count when the processor is not idle, and there are some
> fixed-function counters which count such events. For example,
> the "run cycles" event counts cycles when the processor is
> not idle. If the user asks to count cycles, we can use
> "run cycles" if this is a per-task event, since the processor
> is running when the task is running, by definition. We can't
> use "run cycles" if the user asks for "cycles" on a system-wide
> counter.
> 
> Currently in power8 this check is done using PPMU_ONLY_COUNT_RUN
> flag in power8_get_alternatives() function. Based on the
> flag, events are switched if needed. This function should
> also be enabled in power9, so factor out the code to
> isa207_get_alternatives().
> 
> Fixes: efe881afdd999 ('powerpc/perf: Factor out event_alternative function')
> Reported-by: Anton Blanchard <anton@samba.org>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/70a7e720998d5beaf0c8abd945234e

cheers
