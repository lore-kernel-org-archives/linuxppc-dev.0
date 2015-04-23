Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0097.hostedemail.com
 [216.40.44.97])
 by lists.ozlabs.org (Postfix) with ESMTP id 8ECFB1A0BEB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 23:10:11 +1000 (AEST)
Date: Thu, 23 Apr 2015 09:10:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/ftrace: add powerpc timebase as a trace clock
 source
Message-ID: <20150423091003.168efa55@gandalf.local.home>
In-Reply-To: <1429771504-32688-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
References: <1429771504-32688-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 23 Apr 2015 12:15:04 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> diff --git a/arch/powerpc/include/asm/trace_clock.h b/arch/powerpc/include/asm/trace_clock.h
> new file mode 100644
> index 0000000..0b0d094
> --- /dev/null
> +++ b/arch/powerpc/include/asm/trace_clock.h
> @@ -0,0 +1,27 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
> + */
> +
> +#ifndef _ASM_PPC_TRACE_CLOCK_H
> +#define _ASM_PPC_TRACE_CLOCK_H
> +
> +#include <linux/compiler.h>
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_TRACE_CLOCK

You don't need this #if statement. What else is using this besides
kernel/trace/trace.c, which selects TRACE_CLOCK if it is compiled.

If you were trying to match x86, where it has:

#ifdef CONFIG_X86_TSC

where you have CONFIG_TRACE_CLOCK. We needed the #ifdef because you
can compile the x86 kernel without TSC support, and we did not want to
export a tsc tracing clock if one did not exist.

And the only place that I see that even includes this header in ppc, is
also only compiled if CONFIG_TRACE_CLOCK is selected.

I'm fine with the change, just nuke the unnecessary #ifdef.

-- Steve



> +
> +extern u64 notrace trace_clock_ppc_tb(void);
> +
> +#define ARCH_TRACE_CLOCKS { trace_clock_ppc_tb, "ppc-tb", 0 },
> +
> +#else
> +
> +#define ARCH_TRACE_CLOCKS
> +
> +#endif /* CONFIG_TRACE_CLOCK */
> +
> +#endif  /* _ASM_PPC_TRACE_CLOCK_H */
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 502cf69..f9936f3 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -118,6 +118,7 @@ obj-$(CONFIG_PPC_IO_WORKAROUNDS)	+= io-workarounds.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= ftrace.o
>  obj-$(CONFIG_FUNCTION_GRAPH_TRACER)	+= ftrace.o
>  obj-$(CONFIG_FTRACE_SYSCALLS)	+= ftrace.o
> +obj-$(CONFIG_TRACE_CLOCK)	+= trace_clock.o
>  
>  ifneq ($(CONFIG_PPC_INDIRECT_PIO),y)
>  obj-y				+= iomap.o
> diff --git a/arch/powerpc/kernel/trace_clock.c b/arch/powerpc/kernel/trace_clock.c
> new file mode 100644
> index 0000000..4917069
> --- /dev/null
> +++ b/arch/powerpc/kernel/trace_clock.c
> @@ -0,0 +1,15 @@
> +/*
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * Copyright (C) 2015 Naveen N. Rao, IBM Corporation
> + */
> +
> +#include <asm/trace_clock.h>
> +#include <asm/time.h>
> +
> +u64 notrace trace_clock_ppc_tb(void)
> +{
> +	return get_tb();
> +}
