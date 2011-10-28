Return-Path: <geoff@infradead.org>
Message-ID: <4EAA02A7.7010109@infradead.org>
Date: Thu, 27 Oct 2011 18:17:27 -0700
From: Geoff Levand <geoff@infradead.org>
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: Kernel hang on PS3 with SMP
References: <CAHsu+b-AEtOs+YuYxYFTkMjGwUMoc3jP9cYYkb31nZ+JVrGNVQ@mail.gmail.com>
 <1310808863.13765.3.camel@twins>
In-Reply-To: <1310808863.13765.3.camel@twins>
Content-Type: text/plain; charset="UTF-8"
Cc: cbe-oss-dev@lists.ozlabs.org, Andre Heider <a.heider@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Frank Rowand <frank.rowand@us.sony.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 07/16/2011 02:34 AM, Peter Zijlstra wrote:
> On Sat, 2011-07-16 at 09:38 +0200, Andre Heider wrote:
>> Hi,
>> 
>> when I boot a recent kernel I'm getting hangs early in the boot process.
>> 
>> The kernel boots most of the time, but when /sbin/init kicks in it
>> waits forever for something. I only get a few lines of output, mostly
>> udev related.
>> When the kernel does not boot, it seems to hang somewhere when mapping
>> the irqs (at least that's what the last lines of ps3fb output
>> suggest).
>> I can run into both situation with the same kernel binary. It's also
>> consistent with two userlands, I tried debian stable and testing.
>> 
>> When this happens, I can't interact with the system, so I don't have
>> much more info.
>> 
>> I bisected this to:
>> 
>> commit 317f394160e9beb97d19a84c39b7e5eb3d7815a8
>> Author: Peter Zijlstra <a.p.zijlstra@chello.nl>
>> Date:   Tue Apr 5 17:23:58 2011 +0200
>> 
>>     sched: Move the second half of ttwu() to the remote cpu
>> 
>> All kernels including this patch only work for me when booted with 'nosmp'.

I verified that indeed 317f394160e9beb97d19a84c39b7e5eb3d7815a8
'sched: Move the second half of ttwu() to the remote cpu' introduces
the hang.

>> Any ideas?
> 
> Verify 184748cc50b2dceb8287f9fb657eda48ff8fcfe7 does indeed cover your
> PPC flavour. It has some ppc changes, but I could have missed PS3 if its
> 'special'.

I don't think PS3 is special.  The IPI code is here:

  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=arch/powerpc/platforms/ps3/smp.c;hb=HEAD

> Another thing to check is if your sched IPI handler calls
> irq_enter()/irq_exit(), if not try that.

I tried adding some these, but no change.

I tried to figure out what is happening, but I can't seem to.  It seems
when ttwu_queue_remote() is used the pending scheduling is not performed.

I can't say for sure what is happening.  With the test patch below the
system boots OK.

Also, if I add a udbg_printf(".") statement in the body of ps3's do_message_pass()
the system boots OK.

Any help would be greatly appreciated.

-Geoff

diff --git a/kernel/sched.c b/kernel/sched.c
index 9e3ede1..c16a35a 100644
--- a/kernel/sched.c
+++ b/kernel/sched.c
@@ -2561,21 +2561,21 @@ static void ttwu_queue_remote(struct task_struct *p, int cpu)
 
 	if (!next)
 		smp_send_reschedule(cpu);
 }
 #endif
 
 static void ttwu_queue(struct task_struct *p, int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
 
-#if defined(CONFIG_SMP) && defined(CONFIG_SCHED_TTWU_QUEUE)
+#if 0 //defined(CONFIG_SMP) && defined(CONFIG_SCHED_TTWU_QUEUE)
 	if (sched_feat(TTWU_QUEUE) && cpu != smp_processor_id()) {
 		ttwu_queue_remote(p, cpu);
 		return;
 	}
 #endif
 
 	raw_spin_lock(&rq->lock);
 	ttwu_do_activate(rq, p, 0);
 	raw_spin_unlock(&rq->lock);
 }
