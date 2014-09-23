Return-Path: <rostedt@goodmis.org>
Received: from cdptpa-oedge-vip.email.rr.com
 (cdptpa-outbound-snat.email.rr.com [107.14.166.230])
 by lists.ozlabs.org (Postfix) with ESMTP id 77E751A0054
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 09:18:50 +1000 (EST)
Date: Tue, 23 Sep 2014 19:11:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 1/3] powerpc: Remove -mno-sched-epilog workaround
Message-ID: <20140923191140.63cfafeb@gandalf.local.home>
In-Reply-To: <1410937624-25140-1-git-send-email-anton@samba.org>
References: <1410937624-25140-1-git-send-email-anton@samba.org>
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

I'm running my ftrace tests on my PAsemi box with your patches and
things are not going so well.

Just this patch alone causes my first stress test to lock up, and
things don't go so well after that.

INFO: rcu_sched detected stalls on CPUs/tasks: {} (detected by 1, t=5253 jiffies, g=3603, c=3602, q=15)
INFO: Stall ended before state dump start
INFO: rcu_sched detected stalls on CPUs/tasks: {} (detected by 1, t=21008 jiffies, g=3603, c=3602, q=15)
INFO: Stall ended before state dump start

That's repeated and the system is basically useless.

-- Steve



On Wed, 17 Sep 2014 17:07:02 +1000
Anton Blanchard <anton@samba.org> wrote:

> We added -mno-sched-epilog in commit 7563dc645853 (powerpc:
> Work around gcc's -fno-omit-frame-pointer bug).
> 
> We shouldn't apply -fno-omit-frame-pointer on powerpc any more (it's
> protected by CONFIG_FRAME_POINTER and CONFIG_SCHED_OMIT_FRAME_POINTER).
> 
> It's also an undocumented gcc option, so lets remove it.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>  arch/powerpc/Makefile                    |  5 -----
>  arch/powerpc/kernel/Makefile             | 12 ++++++------
>  arch/powerpc/platforms/powermac/Makefile |  2 +-
>  3 files changed, 7 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 132d9c6..c6f64e2 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -198,11 +198,6 @@ ifeq ($(CONFIG_6xx),y)
>  KBUILD_CFLAGS		+= -mcpu=powerpc
>  endif
>  
> -# Work around a gcc code-gen bug with -fno-omit-frame-pointer.
> -ifeq ($(CONFIG_FUNCTION_TRACER),y)
> -KBUILD_CFLAGS		+= -mno-sched-epilog
> -endif
> -
>  cpu-as-$(CONFIG_4xx)		+= -Wa,-m405
>  cpu-as-$(CONFIG_ALTIVEC)	+= -Wa,-maltivec
>  cpu-as-$(CONFIG_E200)		+= -Wa,-me200
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index 502cf69..e14bda6 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -17,14 +17,14 @@ endif
>  
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not trace early boot code
> -CFLAGS_REMOVE_cputable.o = -pg -mno-sched-epilog
> -CFLAGS_REMOVE_prom_init.o = -pg -mno-sched-epilog
> -CFLAGS_REMOVE_btext.o = -pg -mno-sched-epilog
> -CFLAGS_REMOVE_prom.o = -pg -mno-sched-epilog
> +CFLAGS_REMOVE_cputable.o = -pg
> +CFLAGS_REMOVE_prom_init.o = -pg
> +CFLAGS_REMOVE_btext.o = -pg
> +CFLAGS_REMOVE_prom.o = -pg
>  # do not trace tracer code
> -CFLAGS_REMOVE_ftrace.o = -pg -mno-sched-epilog
> +CFLAGS_REMOVE_ftrace.o = -pg
>  # timers used by tracing
> -CFLAGS_REMOVE_time.o = -pg -mno-sched-epilog
> +CFLAGS_REMOVE_time.o = -pg
>  endif
>  
>  obj-y				:= cputable.o ptrace.o syscalls.o \
> diff --git a/arch/powerpc/platforms/powermac/Makefile b/arch/powerpc/platforms/powermac/Makefile
> index 52c6ce1..e238872 100644
> --- a/arch/powerpc/platforms/powermac/Makefile
> +++ b/arch/powerpc/platforms/powermac/Makefile
> @@ -2,7 +2,7 @@ CFLAGS_bootx_init.o  		+= -fPIC
>  
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not trace early boot code
> -CFLAGS_REMOVE_bootx_init.o = -pg -mno-sched-epilog
> +CFLAGS_REMOVE_bootx_init.o = -pg
>  endif
>  
>  obj-y				+= pic.o setup.o time.o feature.o pci.o \
