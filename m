Return-Path: <atomlin@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 733191A0061
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 01:54:38 +1000 (EST)
Date: Thu, 4 Sep 2014 16:52:00 +0100
From: Aaron Tomlin <atomlin@redhat.com>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH 1/2] sched: Add helper for task stack page overrun checking
Message-ID: <20140904155200.GC1436@atomlin.usersys.redhat.com>
References: <1409842224-11847-1-git-send-email-atomlin@redhat.com>
 <1409842224-11847-2-git-send-email-atomlin@redhat.com>
 <20140904150234.GA6480@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20140904150234.GA6480@redhat.com>
Cc: dzickus@redhat.com, pzijlstr@redhat.com, riel@redhat.com,
 peterz@infradead.org, bmr@redhat.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, minchan@kernel.org,
 mingo@redhat.com, aneesh.kumar@linux.vnet.ibm.com, hannes@cmpxchg.org,
 tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 jcastillo@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2014 at 05:02:34PM +0200, Oleg Nesterov wrote:
> On 09/04, Aaron Tomlin wrote:
> >
> > +#define task_stack_end_corrupted(task) \
> > +		(*(end_of_stack(task)) != STACK_END_MAGIC)
> 
> and it is always used along with "tsk != init_task".
> 
> But why we exclude swapper/0? Can't we add
> 
> 	end_of_stack(current) = STACK_END_MAGIC;
> 
> somewhere at the start of start_kernel() ?

Good point. I can look into it.

> If not, perhaps this new helper should check "task != &init_task"
> itself so that we can simplify its users?
> 
> Oleg.
> 
> >  
> >  static inline int object_is_on_stack(void *obj)
> >  {
> > diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
> > index 8a4e5cb..06c7390 100644
> > --- a/kernel/trace/trace_stack.c
> > +++ b/kernel/trace/trace_stack.c
> > @@ -13,7 +13,6 @@
> >  #include <linux/sysctl.h>
> >  #include <linux/init.h>
> >  #include <linux/fs.h>
> > -#include <linux/magic.h>
> >  
> >  #include <asm/setup.h>
> >  
> > @@ -171,8 +170,8 @@ check_stack(unsigned long ip, unsigned long *stack)
> >  			i++;
> >  	}
> >  
> > -	if ((current != &init_task &&
> > -		*(end_of_stack(current)) != STACK_END_MAGIC)) {
> > +	if (current != &init_task &&
> > +		task_stack_end_corrupted(current)) {
> >  		print_max_stack();
> >  		BUG();
> >  	}
> > -- 
> > 1.9.3
> > 
> 

-- 
Aaron Tomlin
