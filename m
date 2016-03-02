Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACB3D1A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 22:44:25 +1100 (AEDT)
Date: Wed, 2 Mar 2016 12:44:13 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mingo@redhat.com, acme@kernel.org, Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH] hw_breakpoint: Fix Oops at destroying hw_breakpoint
 event on powerpc
Message-ID: <20160302114413.GB6356@twins.programming.kicks-ass.net>
References: <1456912517-5711-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456912517-5711-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 02, 2016 at 03:25:17PM +0530, Ravi Bangoria wrote:
> At a time of destroying hw_breakpoint event, kernel ends up with Oops.
> Here is the sample output from 4.5.0-rc6 kernel.

> Call chain:
> 
>   hw_breakpoint_event_init()
>     bp->destroy = bp_perf_event_destroy;
> 
>   do_exit()
>     perf_event_exit_task()
>       perf_event_exit_task_context()
>         WRITE_ONCE(child_ctx->task, TASK_TOMBSTONE);
>         perf_event_exit_event()
>           free_event()
>             _free_event()
>               bp_perf_event_destroy()//event->destroy(event);
>                 release_bp_slot()
>                   arch_unregister_hw_breakpoint()
> 
> perf_event_exit_task_context sets child_ctx->task as TASK_TOMBSTONE
> which is (void *)-1. arch_unregister_hw_breakpoint tries to fetch
> 'thread' attribute of 'task' resulting in Oops.
> 
> This patch adds one more condition before accessing data from 'task'.
> 
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/hw_breakpoint.c | 3 ++-
>  include/linux/perf_event.h          | 2 ++
>  kernel/events/core.c                | 2 --
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 05e804c..43d8496 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -29,6 +29,7 @@
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/smp.h>
> +#include <linux/perf_event.h>
>  
>  #include <asm/hw_breakpoint.h>
>  #include <asm/processor.h>
> @@ -110,7 +111,7 @@ void arch_unregister_hw_breakpoint(struct perf_event *bp)
>  	 * and the single_step_dabr_instruction(), then cleanup the breakpoint
>  	 * restoration variables to prevent dangling pointers.
>  	 */
> -	if (bp->ctx && bp->ctx->task)
> +	if (bp->ctx && bp->ctx->task && bp->ctx->task != TASK_TOMBSTONE)
>  		bp->ctx->task->thread.last_hit_ubp = NULL;
>  }

Yuck.. you should not be touching ctx (esp not this late).

And I suppose you cannot use bp->hw.target either because we don't
actually keep that up-to-date.

Why do you keep per task state anyway? What do per-cpu breakpoints do?
