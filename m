Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
 [71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id B5C982C0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 08:50:03 +1000 (EST)
Message-ID: <1372114196.18733.185.camel@gandalf.local.home>
Subject: Re: [PATCH 01/45] CPU hotplug: Provide APIs to prevent CPU offline
 from atomic context
From: Steven Rostedt <rostedt@goodmis.org>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 18:49:56 -0400
In-Reply-To: <20130623133756.19094.41723.stgit@srivatsabhat.in.ibm.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623133756.19094.41723.stgit@srivatsabhat.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, xiaoguangrong@linux.vnet.ibm.com,
 Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 "Rafael J. Wysocki" <rjw@sisk.pl>, namhyung@kernel.org, tglx@linutronix.de,
 laijs@cn.fujitsu.com, zhong@linux.vnet.ibm.com, netdev@vger.kernel.org,
 oleg@redhat.com, sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-06-23 at 19:08 +0530, Srivatsa S. Bhat wrote:
> The current CPU offline code uses stop_machine() internally. And disabling
> preemption prevents stop_machine() from taking effect, thus also preventing
> CPUs from going offline, as a side effect.
> 
> There are places where this side-effect of preempt_disable() (or equivalent)
> is used to synchronize with CPU hotplug. Typically these are in atomic
> sections of code, where they can't make use of get/put_online_cpus(), because
> the latter set of APIs can sleep.
> 
> Going forward, we want to get rid of stop_machine() from the CPU hotplug
> offline path. And then, with stop_machine() gone, disabling preemption will
> no longer prevent CPUs from going offline.
> 
> So provide a set of APIs for such atomic hotplug readers, to prevent (any)
> CPUs from going offline. For now, they will default to preempt_disable()
> and preempt_enable() itself, but this will help us do the tree-wide conversion,
> as a preparatory step to remove stop_machine() from CPU hotplug.
> 
> (Besides, it is good documentation as well, since it clearly marks places
> where we synchronize with CPU hotplug, instead of combining it subtly with
> disabling preemption).
> 
> In future, when actually removing stop_machine(), we will alter the
> implementation of these APIs to a suitable synchronization scheme.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  include/linux/cpu.h |   18 ++++++++++++++++++
>  kernel/cpu.c        |   38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
