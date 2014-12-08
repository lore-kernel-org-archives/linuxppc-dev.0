Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x231.google.com (mail-wi0-x231.google.com
 [IPv6:2a00:1450:400c:c05::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87AA41A06AF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 19:34:17 +1100 (AEDT)
Received: by mail-wi0-f177.google.com with SMTP id l15so3999169wiw.16
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Dec 2014 00:34:12 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 8 Dec 2014 09:34:08 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] kthread: kthread_bind fails to enforce CPU affinity
 (fixes kernel BUG at kernel/smpboot.c:134!)
Message-ID: <20141208083408.GA8023@gmail.com>
References: <1418009221-12719-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418009221-12719-1-git-send-email-anton@samba.org>
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


* Anton Blanchard <anton@samba.org> wrote:

> I have a busy ppc64le KVM box where guests sometimes hit the 
> infamous "kernel BUG at kernel/smpboot.c:134!" issue during 
> boot:
> 
> BUG_ON(td->cpu != smp_processor_id());
> 
> Basically a per CPU hotplug thread scheduled on the wrong CPU. The oops
> output confirms it:
> 
> CPU: 0
> Comm: watchdog/130
> 
> The issue is in kthread_bind where we set the cpus_allowed 
> mask, but do not touch task_thread_info(p)->cpu. The scheduler 
> assumes the previously scheduled CPU is in the cpus_allowed 
> mask, but in this case we are moving a thread to another CPU so 
> it is not.
> 
> We used to call set_task_cpu which sets 
> task_thread_info(p)->cpu (in fact kthread_bind still has a 
> comment suggesting this). That was removed in e2912009fb7b 
> ("sched: Ensure set_task_cpu() is never called on blocked 
> tasks").
> 
> Since we cannot call set_task_cpu (the task is in a sleeping 
> state), just do an explicit set of task_thread_info(p)->cpu.

So we cannot call set_task_cpu() because in the normal life time 
of a task the ->cpu value gets set on wakeup. So if a task is 
blocked right now, and its affinity changes, it ought to get a 
correct ->cpu selected on wakeup. The affinity mask and the 
current value of ->cpu getting out of sync is thus 'normal'.

(Check for example how set_cpus_allowed_ptr() works: we first set 
the new allowed mask, then do we migrate the task away if 
necessary.)

In the kthread_bind() case this is explicitly assumed: it only 
calls do_set_cpus_allowed().

But obviously the bug triggers in kernel/smpboot.c, and that 
assert shows a real bug - and your patch makes the assert go 
away, so the question is, how did the kthread get woken up and 
put on a runqueue without its ->cpu getting set?

One possibility is a generic scheduler bug in ttwu(), resulting 
in ->cpu not getting set properly. If this was the case then 
other places would be blowing up as well, and I don't think we 
are seeing this currently, especially not over such a long 
timespan.

Another possibility would be that kthread_bind()'s assumption 
that the task is inactive is false: if the task activates when we 
think it's blocked and we just hotplug-migrate it away while its 
running (setting its td->cpu?), the assert could trigger I think 
- and the patch would make the assert go away.

A third possibility would be, if this is a freshly created 
thread, some sort of initialization race - either in the kthread 
or in the scheduler code.

Weird.

Thanks,

	Ingo
