Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 035641A0027
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 14:06:59 +1000 (EST)
Message-ID: <1410494817.17540.4.camel@concordia>
Subject: Re: [PATCH v3 3/3] sched: BUG when stack end location is over written
From: Michael Ellerman <mpe@ellerman.id.au>
To: Aaron Tomlin <atomlin@redhat.com>
Date: Fri, 12 Sep 2014 14:06:57 +1000
In-Reply-To: <1410450088-18236-4-git-send-email-atomlin@redhat.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-4-git-send-email-atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com,
 prarit@redhat.com, mingo@kernel.com, pzijlstr@redhat.com, peterz@infradead.org,
 bmr@redhat.com, x86@kernel.org, oleg@redhat.com, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org, minchan@kernel.org, mingo@redhat.com,
 tglx@linutronix.de, aneesh.kumar@linux.vnet.ibm.com, hannes@cmpxchg.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org, jgh@redhat.com,
 akpm@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-09-11 at 16:41 +0100, Aaron Tomlin wrote:
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index a285900..2a8280a 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -824,6 +824,18 @@ config SCHEDSTATS
>  	  application, you can say N to avoid the very slight overhead
>  	  this adds.
>  
> +config SCHED_STACK_END_CHECK
> +	bool "Detect stack corruption on calls to schedule()"
> +	depends on DEBUG_KERNEL
> +	default y

Did you really mean default y?

Doing so means it will be turned on more or less everywhere, which defeats the
purpose of having a config option in the first place.

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ec1a286..0b70b73 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2660,6 +2660,9 @@ static noinline void __schedule_bug(struct task_struct *prev)
>   */
>  static inline void schedule_debug(struct task_struct *prev)
>  {
> +#ifdef CONFIG_SCHED_STACK_END_CHECK
> +	BUG_ON(unlikely(task_stack_end_corrupted(prev)))
> +#endif

If this was my code I'd make you put that in a static inline.

cheers
