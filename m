Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B87031A0072
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 15:46:39 +1100 (AEDT)
Date: Mon, 8 Dec 2014 15:46:38 +1100
From: Anton Blanchard <anton@samba.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] kthread: kthread_bind fails to enforce CPU affinity
 (fixes kernel BUG at kernel/smpboot.c:134!)
Message-ID: <20141208154638.37c1ec18@kryten>
In-Reply-To: <CA+55aFw6gMN5VxONPo9xtJA_+p2iLArSaK-m_4vDL+L07Z6vuA@mail.gmail.com>
References: <1418009221-12719-1-git-send-email-anton@samba.org>
 <CA+55aFw6gMN5VxONPo9xtJA_+p2iLArSaK-m_4vDL+L07Z6vuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: yuyang.du@intel.com, Brian Norris <computersforpeace@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>, Paul Turner <pjt@google.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Yuanhan Liu <yuanhan.liu@linux.intel.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Benjamin Segall <bsegall@google.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@redhat.com>, sp@datera.io,
 Daniel J Blueman <daniel@numascale.com>, Tejun Heo <tj@kernel.org>,
 subbaram@codeaurora.org, Andrew Morton <akpm@linux-foundation.org>,
 Wu Fengguang <fengguang.wu@intel.com>, lkp@01.org,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Linus,

> The __set_task_cpu() function does various other things too:
> 
>         set_task_rq(p, cpu);
>   #ifdef CONFIG_SMP
>         /*
>          * After ->cpu is set up to a new value, task_rq_lock(p, ...)
> can be
>          * successfuly executed on another CPU. We must ensure that
> updates of
>          * per-task data have been completed by this moment.
>          */
>         smp_wmb();
>         task_thread_info(p)->cpu = cpu;
>         p->wake_cpu = cpu;
>   #endif
> 
> which makes me worry about just setting the thread_info->cpu value.
> That set_task_rq() initializes various group scheduling things, an
> dthat whole "wake_cpu" thing seems relevant too.

Yeah, I would definitely like the scheduler guys to weigh in on this,
especially considering how difficult it can be to hit.

Anton
