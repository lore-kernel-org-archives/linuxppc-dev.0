Return-Path: <linus971@gmail.com>
Received: from mail-qc0-x231.google.com (mail-qc0-x231.google.com
 [IPv6:2607:f8b0:400d:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DEFF11A0557
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 15:28:36 +1100 (AEDT)
Received: by mail-qc0-f177.google.com with SMTP id x3so2962562qcv.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 07 Dec 2014 20:28:34 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1418009221-12719-1-git-send-email-anton@samba.org>
References: <1418009221-12719-1-git-send-email-anton@samba.org>
Date: Sun, 7 Dec 2014 20:28:34 -0800
Message-ID: <CA+55aFw6gMN5VxONPo9xtJA_+p2iLArSaK-m_4vDL+L07Z6vuA@mail.gmail.com>
Subject: Re: [PATCH] kthread: kthread_bind fails to enforce CPU affinity
 (fixes kernel BUG at kernel/smpboot.c:134!)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Anton Blanchard <anton@samba.org>
Content-Type: text/plain; charset=UTF-8
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

On Sun, Dec 7, 2014 at 7:27 PM, Anton Blanchard <anton@samba.org> wrote:
>
> Since we cannot call set_task_cpu (the task is in a sleeping state),
> just do an explicit set of task_thread_info(p)->cpu.

Scheduler people: is this sufficient and ok?

The __set_task_cpu() function does various other things too:

        set_task_rq(p, cpu);
  #ifdef CONFIG_SMP
        /*
         * After ->cpu is set up to a new value, task_rq_lock(p, ...) can be
         * successfuly executed on another CPU. We must ensure that updates of
         * per-task data have been completed by this moment.
         */
        smp_wmb();
        task_thread_info(p)->cpu = cpu;
        p->wake_cpu = cpu;
  #endif

which makes me worry about just setting the thread_info->cpu value.
That set_task_rq() initializes various group scheduling things, an
dthat whole "wake_cpu" thing seems relevant too.

I'm not saying the patch is wrong, I just want confirmation/ack for
it. Although to be honest, I'd rather see this come in through the
scheduler tree anyway.

Hmm? This seems to go back to 2.6.33 if that "Fixes" line is accurate,
so it's been around forever (almost exactly five years). Comments?

                    Linus
