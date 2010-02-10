Return-Path: <paulus@ozlabs.org>
Date: Thu, 11 Feb 2010 09:29:32 +1100
From: Paul Mackerras <paulus@samba.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] perf_event: e500 support
Message-ID: <20100210222932.GA9844@brick.ozlabs.ibm.com>
References: <20100115214351.GA2869@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100115214351.GA2869@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 15, 2010 at 03:43:51PM -0600, Scott Wood wrote:

> This implements perf_event support for the Freescale embedded performance
> monitor, based on the existing perf_event.c that supports server/classic
> chips.  Eventually we may want to factor out some of the common bits.

Cool!  I agree we will want to factor out some things, such as
collect_events() for instance.  We could create a perf_helper.c for
those bits.

> Some limitations:
> - No threshold support -- need to figure out how to represent it in
>   the event struct from userspace.

What does "threshold support" mean in this context?  Does it mean
something different from getting an interrupt after N events have been
counted?  Or does it mean counting instances where something takes
longer than a specific number of cycles?

> - When trying to schedule multiple event groups at once, and using
>   restricted events, situations could arise where scheduling fails even
>   though it would be possible.  Consider three groups, each with two events.
>   One group has restricted events, the others don't.  The two non-restricted
>   groups are scheduled, then one is removed, which happens to occupy the two
>   counters that can't do restricted events.  The remaining non-restricted
>   group will not be moved to the non-restricted-capable counters to make
>   room if the restricted group tries to be scheduled.  Since thresholds are
>   not yet supported (though you can use the events with a threshold of
>   zero), and threshold events are the only restricted events, this seems
>   like a low priority issue.

Which way around are the restrictions?  That some events can only be
counted on certain counters, or that some counters can only count a
subset of the available events?

Did you look at the constraint satisfaction code in the existing
perf_event.c and p*-pmu.c?  That lets you express both sorts of
restrictions and automatically find the best solution (including
moving events from one counter to another like you describe).

Some specific comments:

> diff --git a/arch/powerpc/include/asm/perf_event.h b/arch/powerpc/include/asm/perf_event.h
> index 3288ce3..2fd2781 100644
> --- a/arch/powerpc/include/asm/perf_event.h
> +++ b/arch/powerpc/include/asm/perf_event.h
> @@ -2,6 +2,7 @@
>   * Performance event support - PowerPC-specific definitions.
>   *
>   * Copyright 2008-2009 Paul Mackerras, IBM Corporation.
> + * Copyright 2010 Freescale Semiconductor, Inc.
>   *
>   * This program is free software; you can redistribute it and/or
>   * modify it under the terms of the GNU General Public License
> @@ -12,6 +13,36 @@
>  
>  #include <asm/hw_irq.h>
>  
> +#ifdef CONFIG_FSL_EMB_PERFMON
> +#define MAX_HWEVENTS 4
> +
> +/* event flags */
> +#define FSL_EMB_EVENT_VALID 1
> +#define FSL_EMB_EVENT_RESTRICTED 2
> +
> +struct power_pmu {

I wonder if we should have just the stuff exported to the core in
asm/perf_event.h and move MAX_HWEVENTS, struct power_pmu etc. to
separate headers for fsl_embedded, classic, etc.?

> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -98,7 +98,10 @@ obj64-$(CONFIG_AUDIT)		+= compat_audit.o
>  
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
>  obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
> -obj-$(CONFIG_PPC_PERF_CTRS)	+= perf_event.o perf_callchain.o
> +obj-$(CONFIG_PPC_PERF_CTRS)	+= perf_event.o
> +obj-$(CONFIG_FSL_EMB_PERF_EVENT) += perf_event_fsl_emb.o
> +obj-$(CONFIG_FSL_EMB_PERF_EVENT_E500) += e500-pmu.o
> +obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o

This is because we want perf_callchain.o even if we don't have
hardware PMU support, is it?  If so this is a separate fix that
deserves its own patch.

Paul.
