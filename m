Return-Path: <mingo@elte.hu>
Received: from mx3.mail.elte.hu (mx3.mail.elte.hu [157.181.1.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2A0BC474E6
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 06:17:23 +1100 (EST)
Date: Thu, 20 Nov 2008 20:16:50 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/5] powerpc: dynamic ftrace port
Message-ID: <20081120191650.GD3955@elte.hu>
References: <20081120190948.057007623@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20081120190948.057007623@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Steven Rostedt <rostedt@goodmis.org> wrote:

> Paul and Ingo,
> 
> The following are the changes to get dynamic ftrace working on PowerPC.
> I modified these a little from the last postings.
> 
>  1) I removed the changes to recordmcount.pl.  This is not a PowerPC
>     change, although PowerPC needs it for dynamic ftrace. But
>     the changes here can go via linux-tip.
> 
>  2) I removed the adding of HAVE_DYNAMIC_FTRACE and HAVE_FTRACE_MCOUNT_RECORD.
>     Without these config options, this code will not be compiled.
>     I have a separate patch that adds them in when the time is right.
> 
> Paul, these patches should not harm anything if you decide to pull them
> in. As I stated above, without the above config options, they are
> not enabled.
> 
> There is one exception and that is for the first patch. The first patch
> is actually a fix for the irqsoff latency tracer which is already
> in mainline for PowerPC.
> 
> These patches only touch PowerPC code.
> 
> The following patches are in:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-2.6-trace.git
> 
>     branch: ppc/ftrace
> 
> 
> Steven Rostedt (5):
>       powerpc: ftrace, do not latency trace idle
>       powerpc: ftrace, convert to new dynamic ftrace arch API
>       powerpc: ftrace, use probe_kernel API to modify code
>       powerpc/ppc64: ftrace, handle module trampolines for dyn ftrace
>       powerpc/ppc32: ftrace, dynamic ftrace to handle modules
> 
> ----
>  arch/powerpc/include/asm/ftrace.h |   14 +-
>  arch/powerpc/include/asm/module.h |   16 ++-
>  arch/powerpc/kernel/ftrace.c      |  473 +++++++++++++++++++++++++++++++++---
>  arch/powerpc/kernel/idle.c        |    5 +
>  arch/powerpc/kernel/module_32.c   |   10 +
>  arch/powerpc/kernel/module_64.c   |   13 +
>  6 files changed, 489 insertions(+), 42 deletions(-)

looks perfect to me! Thanks Steve for going through this - this was 
really a logistical worst-case-scenario.

Now lets hope it looks good to Paul too and we can get his Acked-by
:-)

	Ingo
