Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D3C931A09DC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 21:19:01 +1100 (AEDT)
Date: Mon, 8 Dec 2014 21:18:59 +1100
From: Anton Blanchard <anton@samba.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] kthread: kthread_bind fails to enforce CPU affinity
 (fixes kernel BUG at kernel/smpboot.c:134!)
Message-ID: <20141208211859.6e81ec81@kryten>
In-Reply-To: <20141208083408.GA8023@gmail.com>
References: <1418009221-12719-1-git-send-email-anton@samba.org>
 <20141208083408.GA8023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: yuyang.du@intel.com, computersforpeace@gmail.com, peterz@infradead.org,
 lkp@01.org, rafael.j.wysocki@intel.com, yuanhan.liu@linux.intel.com,
 rostedt@goodmis.org, linux-kernel@vger.kernel.org, bsegall@google.com,
 linuxppc-dev@lists.ozlabs.org, mingo@redhat.com, sp@datera.io,
 daniel@numascale.com, tj@kernel.org, subbaram@codeaurora.org,
 akpm@linux-foundation.org, fengguang.wu@intel.com,
 torvalds@linux-foundation.org, tglx@linutronix.de, pjt@google.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Ingo,

> So we cannot call set_task_cpu() because in the normal life time 
> of a task the ->cpu value gets set on wakeup. So if a task is 
> blocked right now, and its affinity changes, it ought to get a 
> correct ->cpu selected on wakeup. The affinity mask and the 
> current value of ->cpu getting out of sync is thus 'normal'.
> 
> (Check for example how set_cpus_allowed_ptr() works: we first set 
> the new allowed mask, then do we migrate the task away if 
> necessary.)
> 
> In the kthread_bind() case this is explicitly assumed: it only 
> calls do_set_cpus_allowed().
> 
> But obviously the bug triggers in kernel/smpboot.c, and that 
> assert shows a real bug - and your patch makes the assert go 
> away, so the question is, how did the kthread get woken up and 
> put on a runqueue without its ->cpu getting set?

I started going down this line earlier today, and found things like:

select_task_rq_fair:

        if (p->nr_cpus_allowed == 1)
                return prev_cpu;

I tried returning cpumask_first(tsk_cpus_allowed()) instead, and while
I couldn't hit the BUG I did manage to get a scheduler lockup during
testing.

At that point I thought the previous task_cpu() was somewhat ingrained
in the scheduler and came up with the patch. If not, we could go on a
hunt to see what else needs fixing.

Anton
