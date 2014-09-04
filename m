Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 527AB1A03C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 01:32:43 +1000 (EST)
Date: Thu, 4 Sep 2014 17:32:31 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH 2/2] sched: BUG when stack end location is over written
Message-ID: <20140904153231.GE346@worktop.programming.kicks-ass.net>
References: <1409842224-11847-1-git-send-email-atomlin@redhat.com>
 <1409842224-11847-3-git-send-email-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409842224-11847-3-git-send-email-atomlin@redhat.com>
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com, bmr@redhat.com,
 x86@kernel.org, oleg@redhat.com, rostedt@goodmis.org,
 linux-kernel@vger.kernel.org, minchan@kernel.org, mingo@redhat.com,
 aneesh.kumar@linux.vnet.ibm.com, hannes@cmpxchg.org, tglx@linutronix.de,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, pzijlstr@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2014 at 03:50:24PM +0100, Aaron Tomlin wrote:
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
>  kernel/sched/core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ec1a286..d6af6a0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2660,6 +2660,9 @@ static noinline void __schedule_bug(struct task_struct *prev)
>   */
>  static inline void schedule_debug(struct task_struct *prev)
>  {
> +	if (unlikely(prev != &init_task &&
> +		task_stack_end_corrupted(prev)))
> +		BUG();

superfluous linebreak, also we appear to have BUG_ON() for situations
just like these.

secondly, while I appreciate the 'feature' you're making schedule()
slower for everybody, what do you propose to do about that?
