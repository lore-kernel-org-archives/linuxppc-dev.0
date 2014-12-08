Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0069.hostedemail.com
 [216.40.44.69])
 by lists.ozlabs.org (Postfix) with ESMTP id 0C85C1A09DC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Dec 2014 01:03:54 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id B34FE493F
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Dec 2014 13:54:22 +0000 (UTC)
Date: Mon, 8 Dec 2014 08:54:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] kthread: kthread_bind fails to enforce CPU affinity
 (fixes kernel BUG at kernel/smpboot.c:134!)
Message-ID: <20141208085405.730577a3@gandalf.local.home>
In-Reply-To: <1418009221-12719-1-git-send-email-anton@samba.org>
References: <1418009221-12719-1-git-send-email-anton@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: yuyang.du@intel.com, computersforpeace@gmail.com, peterz@infradead.org,
 lkp@01.org, rafael.j.wysocki@intel.com, yuanhan.liu@linux.intel.com,
 linux-kernel@vger.kernel.org, bsegall@google.com,
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

On Mon,  8 Dec 2014 14:27:01 +1100
Anton Blanchard <anton@samba.org> wrote:

> I have a busy ppc64le KVM box where guests sometimes hit the infamous
> "kernel BUG at kernel/smpboot.c:134!" issue during boot:
> 
> BUG_ON(td->cpu != smp_processor_id());
> 
> Basically a per CPU hotplug thread scheduled on the wrong CPU. The oops
> output confirms it:
> 
> CPU: 0
> Comm: watchdog/130
> 
> The issue is in kthread_bind where we set the cpus_allowed mask, but do
> not touch task_thread_info(p)->cpu. The scheduler assumes the previously
> scheduled CPU is in the cpus_allowed mask, but in this case we are
> moving a thread to another CPU so it is not.
> 

Does this happen always on boot up, and always with the watchdog thread?

I followed the logic that starts the watchdog threads.

watchdog_enable_all_cpus()
  smpboot_register_percpu-thread() {

    for_each_online_cpu(cpu) { ... }

Where watchdog_enable_all_cpus() can be called by
lockup_detector_init() before SMP is started, but also by
proc_dowatchdog() which is called by the sysctl commands (after SMP is
up and running).

I noticed there's no "get_online_cpus()" anywhere, although the
unregister_percpu_thread() has it. Is it possible that we created a
thread on a CPU that wasn't fully online yet?

Perhaps the following patch is needed? Even if this isn't the solution
to this bug, it is probably needed as watchdog_enable_all_cpus() can be
called after boot up too.

-- Steve

diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index eb89e1807408..60d35ac5d3f1 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -279,6 +279,7 @@ int smpboot_register_percpu_thread(struct smp_hotplug_thread *plug_thread)
 	unsigned int cpu;
 	int ret = 0;
 
+	get_online_cpus();
 	mutex_lock(&smpboot_threads_lock);
 	for_each_online_cpu(cpu) {
 		ret = __smpboot_create_thread(plug_thread, cpu);
@@ -291,6 +292,7 @@ int smpboot_register_percpu_thread(struct smp_hotplug_thread *plug_thread)
 	list_add(&plug_thread->list, &hotplug_threads);
 out:
 	mutex_unlock(&smpboot_threads_lock);
+	put_online_cpus();
 	return ret;
 }
 EXPORT_SYMBOL_GPL(smpboot_register_percpu_thread);
