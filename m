Return-Path: <srostedt@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 095A5DDE0F
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Nov 2008 05:10:22 +1100 (EST)
Message-ID: <491F107E.4070702@redhat.com>
Date: Sat, 15 Nov 2008 13:10:06 -0500
From: Steven Rostedt <srostedt@redhat.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH][for 2.6.28] Remove -mno-spe flags as they dont belong
References: <1226772154-6109-1-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1226772154-6109-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> For some unknown reason at Steven Rostedt added in disabling of the SPE
> instruction generation for e500 based PPC cores in commit
> 6ec562328fda585be2d7f472cfac99d3b44d362a.
>   

The unknown reason was that my PPC64 failed to compile without it ;-) It 
was unknown because I forgot to mention that in the change log (my bad).

On Monday, I'll apply this patch and make sure that my PPC64 still compiles.

-- Steve

> We are removing it because:
>
> 1. It generates e500 kernels that don't work
> 2. its not the correct set of flags to do this
> 3. we handle this in the arch/powerpc/Makefile already
> 4. its unknown in talking to Steven why he did this
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  kernel/Makefile |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/Makefile b/kernel/Makefile
> index 9a3ec66..19fad00 100644
> --- a/kernel/Makefile
> +++ b/kernel/Makefile
> @@ -11,8 +11,6 @@ obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
>  	    hrtimer.o rwsem.o nsproxy.o srcu.o semaphore.o \
>  	    notifier.o ksysfs.o pm_qos_params.o sched_clock.o
>  
> -CFLAGS_REMOVE_sched.o = -mno-spe
> -
>  ifdef CONFIG_FUNCTION_TRACER
>  # Do not trace debug files and internal ftrace files
>  CFLAGS_REMOVE_lockdep.o = -pg
> @@ -21,7 +19,7 @@ CFLAGS_REMOVE_mutex-debug.o = -pg
>  CFLAGS_REMOVE_rtmutex-debug.o = -pg
>  CFLAGS_REMOVE_cgroup-debug.o = -pg
>  CFLAGS_REMOVE_sched_clock.o = -pg
> -CFLAGS_REMOVE_sched.o = -mno-spe -pg
> +CFLAGS_REMOVE_sched.o = -pg
>  endif
>  
>  obj-$(CONFIG_FREEZER) += freezer.o
>   
