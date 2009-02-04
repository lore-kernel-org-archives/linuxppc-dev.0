Return-Path: <fweisbec@gmail.com>
Received: from mail-fx0-f11.google.com (mail-fx0-f11.google.com
	[209.85.220.11]) by ozlabs.org (Postfix) with ESMTP id D8EFADDED3
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Feb 2009 02:34:11 +1100 (EST)
Received: by fxm4 with SMTP id 4so3765091fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 04 Feb 2009 07:34:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090204150840.GC30027@oksana.dev.rtsoft.ru>
References: <20090204150755.GA24163@oksana.dev.rtsoft.ru>
	<20090204150840.GC30027@oksana.dev.rtsoft.ru>
Date: Wed, 4 Feb 2009 16:26:15 +0100
Message-ID: <c62985530902040726x34aeee7fr3b2937d898d3061e@mail.gmail.com>
Subject: Re: [PATCH 3/3] tracing: Tracers that use CALLER_ADDR macros should
	select FRAME_POINTER
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Steven Rostedt <srostedt@redhat.com>,
	Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/2/4 Anton Vorontsov <avorontsov@ru.mvista.com>:
> Irqsoff, switch and preempt tracers use CALLER_ADDR macros, so they
> should select FRAME_POINTER. Otherwise traces are meaningless.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>  kernel/trace/Kconfig |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index e2a4ff6..48f7a37 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -86,6 +86,7 @@ config IRQSOFF_TRACER
>        select TRACE_IRQFLAGS
>        select TRACING
>        select TRACER_MAX_TRACE
> +       select FRAME_POINTER
>        help
>          This option measures the time spent in irqs-off critical
>          sections, with microsecond accuracy.
> @@ -108,6 +109,7 @@ config PREEMPT_TRACER
>        depends on DEBUG_KERNEL
>        select TRACING
>        select TRACER_MAX_TRACE
> +       select FRAME_POINTER
>        help
>          This option measures the time spent in preemption off critical
>          sections, with microsecond accuracy.
> @@ -136,6 +138,7 @@ config SCHED_TRACER
>        select TRACING
>        select CONTEXT_SWITCH_TRACER
>        select TRACER_MAX_TRACE
> +       select FRAME_POINTER
>        help
>          This tracer tracks the latency of the highest priority task
>          to be scheduled in, starting from the point it has woken up.
> --


Looks right.

BTW, how behaves builtin_return_address in case of !FRAME_POINTERS ?
I guess it would only work with the first caller builtin_return_address(0)
