Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEC1F1A004F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Sep 2014 01:31:04 +1000 (EST)
Date: Thu, 4 Sep 2014 17:30:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH 1/2] sched: Add helper for task stack page overrun checking
Message-ID: <20140904153047.GD346@worktop.programming.kicks-ass.net>
References: <1409842224-11847-1-git-send-email-atomlin@redhat.com>
 <1409842224-11847-2-git-send-email-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409842224-11847-2-git-send-email-atomlin@redhat.com>
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

On Thu, Sep 04, 2014 at 03:50:23PM +0100, Aaron Tomlin wrote:

> @@ -537,8 +535,8 @@ void bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
>  	printk(KERN_ALERT "Faulting instruction address: 0x%08lx\n",
>  		regs->nip);
>  
> -	stackend = end_of_stack(current);
> -	if (current != &init_task && *stackend != STACK_END_MAGIC)
> +	if (current != &init_task &&
> +		task_stack_end_corrupted(current))

superfluous linebreak.

> @@ -2614,6 +2615,8 @@ static inline unsigned long *end_of_stack(struct task_struct *p)
>  }
>  
>  #endif

Here otoh we could do with some extra whitespace

> @@ -171,8 +170,8 @@ check_stack(unsigned long ip, unsigned long *stack)
>  			i++;
>  	}
>  
> -	if ((current != &init_task &&
> -		*(end_of_stack(current)) != STACK_END_MAGIC)) {
> +	if (current != &init_task &&
> +		task_stack_end_corrupted(current)) {

Again, superfluous linebreak.
