Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E3A34DDE40
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 03:04:26 +1000 (EST)
Message-ID: <46965F93.2090806@ru.mvista.com>
Date: Thu, 12 Jul 2007 21:06:27 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: mingo@elte.hu, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Fwd: [PATCH] 2.6.18-rt7: fix more issues with 32-bit cycles_t
	in	latency_trace.c
References: <200611130026.17204.sshtylyov@ru.mvista.com>
In-Reply-To: <200611130026.17204.sshtylyov@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello, I wrote:

> In addition to clock wrap check being falsely triggered with 32-bit cycles_t,
> as noticed to Kevin Hilman, there's another issue: using %Lx format to print
> 32-bit values warrants erroneous values on 32-bit machines like ARM and PPC32.

> Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

> ---
> PPC32 actually has 64-bit timebase counter, so could provide for 64-bit
> cycles_t -- maybe it's worth to rewrite get_cycles() to read both lower and
> upper registers?

    This one (called latency-tracer-prink-fix.patch in the broken out 
patchset) has been erroneously "restored" some months ago. Since 
preempt_max_latency is of type 'unsigned long' now and all the other vars are 
of type 'cycle_t' (which aliases 'u64'), only the first cast is actually 
needed (or rather, the first format specifier needs to be changed to %08lx). 
Erm, maybe I'll cook a patch...

> Index: linux-2.6/kernel/latency_trace.c
> ===================================================================
> --- linux-2.6.orig/kernel/latency_trace.c
> +++ linux-2.6/kernel/latency_trace.c
> @@ -1623,8 +1623,8 @@ check_critical_timing(int cpu, struct cp
>  #ifndef CONFIG_CRITICAL_LATENCY_HIST
>  	if (!preempt_thresh && preempt_max_latency > delta) {
>  		printk("bug: updating %016Lx > %016Lx?\n",
> -			preempt_max_latency, delta);
> -		printk("  [%016Lx %016Lx %016Lx]\n", T0, T1, T2);
> +			(u64)preempt_max_latency, (u64)delta);
> +		printk("  [%016Lx %016Lx %016Lx]\n", (u64)T0, (u64)T1, (u64)T2);
>  	}
>  #endif

WBR, Sergei
