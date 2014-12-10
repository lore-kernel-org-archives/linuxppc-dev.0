Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F1ED61A0B8F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Dec 2014 01:09:44 +1100 (AEDT)
Date: Wed, 10 Dec 2014 15:08:57 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] powerpc: secondary CPUs signal to master before setting
 active and online (fixes kernel BUG at kernel/smpboot.c:134!)
In-Reply-To: <CA+55aFyR5PzNkojvEej1NXnpEFOPOYfnxCcPDAjg1rE79tQv7A@mail.gmail.com>
Message-ID: <alpine.DEB.2.11.1412101427080.13233@nanos>
References: <1418009221-12719-1-git-send-email-anton@samba.org>
 <20141208083408.GA8023@gmail.com> <20141208211859.6e81ec81@kryten>
 <20141209105819.0e847b4b@kryten>
 <CA+55aFyR5PzNkojvEej1NXnpEFOPOYfnxCcPDAjg1rE79tQv7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <peterz@infradead.org>,
 Yuanhan Liu <yuanhan.liu@linux.intel.com>,
 Benjamin Segall <bsegall@google.com>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@kernel.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Paul Turner <pjt@google.com>,
 yuyang.du@intel.com, Daniel J Blueman <daniel@numascale.com>,
 Steven Rostedt <rostedt@goodmis.org>, Anton Blanchard <anton@samba.org>,
 subbaram@codeaurora.org, Wu Fengguang <fengguang.wu@intel.com>, lkp@01.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Slava Pestov <sp@datera.io>, Tejun Heo <tj@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brian Norris <computersforpeace@gmail.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 9 Dec 2014, Linus Torvalds wrote:
> On Mon, Dec 8, 2014 at 3:58 PM, Anton Blanchard <anton@samba.org> wrote:
> > Hi Ingo,
> >
> >> At that point I thought the previous task_cpu() was somewhat ingrained
> >> in the scheduler and came up with the patch. If not, we could go on a
> >> hunt to see what else needs fixing.
> >
> > I had another look. The scheduled does indeed make assumptions about the
> > previous task_cpu, but we have a hammer to fix it up called
> > select_fallback_rq.
> >
> > I annotated select_fallback_rq, and did hit a case where the CPU was
> > not active. ppc64 patch below.
> 
> Anton, I'll assume I will get this through the usual powerpc pull requests?
> 
> > I think x86 have a similar (although harder to hit) issue.

Indeed way harder to hit:

CPU 0				CPU 1

    				set_cpu_online(1, true) {
while (!cpu_online(cpu1))	   cpumask_set_cpu(1, to_cpumask(cpu_online_bits));
      relax();

wakeup_thread_on_cpu1();
				   cpumask_set_cpu(1, to_cpumask(cpu_active_bits));

On bare metal probably impossible, but on virt it should be
observable. Fix is simple.

Thanks,

	tglx

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 668d8f2a8781..534f3384f03f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -222,7 +222,6 @@ static void notrace start_secondary(void *unused)
 	lock_vector_lock();
 	set_cpu_online(smp_processor_id(), true);
 	unlock_vector_lock();
-	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 	x86_platform.nmi_init();
 
 	/* enable local interrupts */
@@ -234,6 +233,7 @@ static void notrace start_secondary(void *unused)
 	x86_cpuinit.setup_percpu_clockev();
 
 	wmb();
+	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 	cpu_startup_entry(CPUHP_ONLINE);
 }
 
@@ -932,7 +932,7 @@ int native_cpu_up(unsigned int cpu, struct task_struct *tidle)
 	check_tsc_sync_source(cpu);
 	local_irq_restore(flags);
 
-	while (!cpu_online(cpu)) {
+	while (per_cpu(cpu_state,cpu) != CPU_ONLINE) {
 		cpu_relax();
 		touch_nmi_watchdog();
 	}
