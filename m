Return-Path: <atomlin@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6651C1A00CD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Sep 2014 19:53:07 +1000 (EST)
Date: Fri, 12 Sep 2014 10:50:21 +0100
From: Aaron Tomlin <atomlin@redhat.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 3/3] sched: BUG when stack end location is over written
Message-ID: <20140912095021.GE1873@atomlin.usersys.redhat.com>
References: <1410255749-2956-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-1-git-send-email-atomlin@redhat.com>
 <1410450088-18236-4-git-send-email-atomlin@redhat.com>
 <1410501891.17540.6.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1410501891.17540.6.camel@concordia>
Cc: dzickus@redhat.com, jcastillo@redhat.com, riel@redhat.com,
 prarit@redhat.com, peterz@infradead.org, bmr@redhat.com, x86@kernel.org,
 oleg@redhat.com, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
 minchan@kernel.org, mingo@redhat.com, tglx@linutronix.de,
 aneesh.kumar@linux.vnet.ibm.com, hannes@cmpxchg.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, jgh@redhat.com, akpm@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 12, 2014 at 04:04:51PM +1000, Michael Ellerman wrote:
> On Thu, 2014-09-11 at 16:41 +0100, Aaron Tomlin wrote:
> > Currently in the event of a stack overrun a call to schedule()
> > does not check for this type of corruption. This corruption is
> > often silent and can go unnoticed. However once the corrupted
> > region is examined at a later stage, the outcome is undefined
> > and often results in a sporadic page fault which cannot be
> > handled.
> > 
> > This patch checks for a stack overrun and takes appropriate
> > action since the damage is already done, there is no point
> > in continuing.
> > 
> > Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
> > ---
> >  kernel/sched/core.c |  3 +++
> >  lib/Kconfig.debug   | 12 ++++++++++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index ec1a286..0b70b73 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2660,6 +2660,9 @@ static noinline void __schedule_bug(struct task_struct *prev)
> >   */
> >  static inline void schedule_debug(struct task_struct *prev)
> >  {
> > +#ifdef CONFIG_SCHED_STACK_END_CHECK
> > +	BUG_ON(unlikely(task_stack_end_corrupted(prev)))
> > +#endif
> 
> Spot the bug? Please compile your code in future.

Oops! Sorry about that.

-- 
Aaron Tomlin
