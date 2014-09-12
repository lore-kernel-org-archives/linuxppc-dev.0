Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 468091A006C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 16:04:53 +1000 (EST)
Message-ID: <1410501891.17540.6.camel@concordia>
Subject: Re: [PATCH v3 3/3] sched: BUG when stack end location is over written
From: Michael Ellerman <mpe@ellerman.id.au>
To: Aaron Tomlin <atomlin@redhat.com>
Date: Fri, 12 Sep 2014 16:04:51 +1000
In-Reply-To: <1410450088-18236-4-git-send-email-atomlin@redhat.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-4-git-send-email-atomlin@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com,
 prarit@redhat.com, pzijlstr@redhat.com, peterz@infradead.org, bmr@redhat.com,
 x86@kernel.org, oleg@redhat.com, rostedt@goodmis.org,
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
> Currently in the event of a stack overrun a call to schedule()
> does not check for this type of corruption. This corruption is
> often silent and can go unnoticed. However once the corrupted
> region is examined at a later stage, the outcome is undefined
> and often results in a sporadic page fault which cannot be
> handled.
> 
> This patch checks for a stack overrun and takes appropriate
> action since the damage is already done, there is no point
> in continuing.
> 
> Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> ---
>  kernel/sched/core.c |  3 +++
>  lib/Kconfig.debug   | 12 ++++++++++++
>  2 files changed, 15 insertions(+)
> 
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

Spot the bug? Please compile your code in future.


../kernel/sched/core.c: In function ‘schedule_debug’:
../kernel/sched/core.c:2671:2: error: expected ‘;’ before ‘if’
  if (unlikely(in_atomic_preempt_off() && prev->state != TASK_DEAD))
  ^
../kernel/sched/core.c: At top level:
../kernel/sched/core.c:2635:22: warning: ‘__schedule_bug’ defined but not used [-Wunused-function]
 static noinline void __schedule_bug(struct task_struct *prev)
                      ^
make[3]: *** [kernel/sched/core.o] Error 1
make[2]: *** [kernel/sched] Error 2
make[1]: *** [kernel] Error 2
make: *** [sub-make] Error 2


cheers
