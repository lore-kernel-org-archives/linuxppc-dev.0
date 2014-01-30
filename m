Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0DF912C0245
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 02:25:34 +1100 (EST)
Date: Thu, 30 Jan 2014 16:25:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH v2 6/6] cpu/idle.c: move to sched/idle.c
Message-ID: <20140130152500.GB5002@laptop.programming.kicks-ass.net>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1391017513-12995-7-git-send-email-nicolas.pitre@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Russell King <linux@arm.linux.org.uk>,
 linux-sh@vger.kernel.org, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Mundt <lethal@linux-sh.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 29, 2014 at 12:45:13PM -0500, Nicolas Pitre wrote:
> Integration of cpuidle with the scheduler requires that the idle loop be
> closely integrated with the scheduler proper. Moving cpu/idle.c into the
> sched directory will allow for a smoother integration, and eliminate a
> subdirectory which contained only one source file.
> 
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
> ---
>  kernel/Makefile              | 1 -
>  kernel/cpu/Makefile          | 1 -
>  kernel/sched/Makefile        | 2 +-
>  kernel/{cpu => sched}/idle.c | 0
>  4 files changed, 1 insertion(+), 3 deletions(-)
>  delete mode 100644 kernel/cpu/Makefile
>  rename kernel/{cpu => sched}/idle.c (100%)

> --- a/kernel/sched/Makefile
> +++ b/kernel/sched/Makefile
> @@ -11,7 +11,7 @@ ifneq ($(CONFIG_SCHED_OMIT_FRAME_POINTER),y)
>  CFLAGS_core.o := $(PROFILING) -fno-omit-frame-pointer
>  endif
>  
> -obj-y += core.o proc.o clock.o cputime.o idle_task.o fair.o rt.o stop_task.o
> +obj-y += core.o proc.o clock.o cputime.o idle_task.o idle.o fair.o rt.o stop_task.o
>  obj-y += wait.o completion.o
>  obj-$(CONFIG_SMP) += cpupri.o
>  obj-$(CONFIG_SCHED_AUTOGROUP) += auto_group.o
> diff --git a/kernel/cpu/idle.c b/kernel/sched/idle.c
> similarity index 100%
> rename from kernel/cpu/idle.c
> rename to kernel/sched/idle.c

This is not a valid patch for PATCH(1). Please try again.
