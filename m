Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id DBB06B6EE8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2012 04:51:19 +1100 (EST)
Date: Sun, 25 Mar 2012 19:42:10 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: Re: [PATCH v2.1 01/10] cpu: Introduce clear_tasks_mm_cpumask() helper
Message-ID: <20120325174210.GA23605@redhat.com>
References: <20120324102609.GA28356@lizard> <20120324102751.GA29067@lizard>
 <1332593021.16159.27.camel@twins> <20120324164316.GB3640@lizard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120324164316.GB3640@lizard>
Cc: Mike Frysinger <vapier@gentoo.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 user-mode-linux-devel@lists.sourceforge.net, linux-sh@vger.kernel.org,
 Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org,
 uclinux-dist-devel@blackfin.uclinux.org, linux-mm@kvack.org,
 Paul Mundt <lethal@linux-sh.org>, John Stultz <john.stultz@linaro.org>,
 KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Russell King <linux@arm.linux.org.uk>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/24, Anton Vorontsov wrote:
>
> Many architctures clear tasks' mm_cpumask like this:
>
> 	read_lock(&tasklist_lock);
> 	for_each_process(p) {
> 		if (p->mm)
> 			cpumask_clear_cpu(cpu, mm_cpumask(p->mm));
> 	}
> 	read_unlock(&tasklist_lock);

Namely arm, powerpc, and sh.

> The code above has several problems, such as:
>
> 1. Working with task->mm w/o getting mm or grabing the task lock is
>    dangerous as ->mm might disappear (exit_mm() assigns NULL under
>    task_lock(), so tasklist lock is not enough).

This is not actually true for arm and sh, afaics. They do not even
need tasklist or rcu lock for for_each_process().

__cpu_disable() is called by __stop_machine(), we know that nobody
can preempt us and other CPUs can do nothing.

> 2. Checking for process->mm is not enough because process' main
>    thread may exit or detach its mm via use_mm(), but other threads
>    may still have a valid mm.

Yes,

> Also, Per Peter Zijlstra's idea, now we don't grab tasklist_lock in
> the new helper, instead we take the rcu read lock. We can do this
> because the function is called after the cpu is taken down and marked
> offline, so no new tasks will get this cpu set in their mm mask.

And only powerpc needs rcu_read_lock() and task_lock().

OTOH, I do not understand why powepc does this on CPU_DEAD...
And probably CPU_UP_CANCELED doesn't need to clear mm_cpumask().

That said, personally I think these patches are fine, the common
helper makes sense.

Oleg.
