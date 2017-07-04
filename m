Return-Path: <abdhalee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x25g72c0yzDqj1
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 00:17:23 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v64EDYIB134786
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Jul 2017 10:17:20 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bg6gdk7w8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 10:17:20 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <abdhalee@linux.vnet.ibm.com>;
 Wed, 5 Jul 2017 00:17:17 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v64EFpVX8323340
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 00:15:59 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v64EFQsI004030
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 00:15:27 +1000
Subject: Re: [linux-next] cpus stalls detected few hours after booting next
 kernel
From: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: sachinp <sachinp@linux.vnet.ibm.com>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Paul McKenney <Paul.McKenney@us.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>, linux-next
 <linux-next@vger.kernel.org>, paulus@samba.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 04 Jul 2017 19:44:58 +0530
In-Reply-To: <20170630172802.6d4ddca2@roar.ozlabs.ibm.com>
References: <1498728106.19484.21.camel@abdul>
 <20170629193614.376e27e6@roar.ozlabs.ibm.com>
 <20170629202305.6187367f@roar.ozlabs.ibm.com>
 <20170630004534.228f7c08@roar.ozlabs.ibm.com>
 <1498800138.19484.25.camel@abdul>
 <20170630172802.6d4ddca2@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1499177698.19784.7.camel@abdul.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-06-30 at 17:28 +1000, Nicholas Piggin wrote:
> On Fri, 30 Jun 2017 10:52:18 +0530
> Abdul Haleem <abdhalee@linux.vnet.ibm.com> wrote:
> 
> > On Fri, 2017-06-30 at 00:45 +1000, Nicholas Piggin wrote:
> > > On Thu, 29 Jun 2017 20:23:05 +1000
> > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > > 
> > > > On Thu, 29 Jun 2017 19:36:14 +1000
> > > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > > 
> > > > > I don't *think* the replay-wakeup-interrupt patch is directly involved, but
> > > > > it's likely to be one of the idle patches.  
> > > 
> > > Okay this turned out to be misconfigured sleep states I added for the
> > > simulator, sorry for the false alarm.
> > > 
> > > > Although you have this in the backtrace. I wonder if that's a stuck
> > > > lock in rcu_process_callbacks?
> > > 
> > > So this spinlock becomes top of the list of suspects. Can you try
> > > enabling lockdep and try to reproduce it?
> > 
> > Yes, recreated again with CONFIG_LOCKDEP=y & CONFIG_DEBUG_LOCKDEP=y set.
> > I do not see any difference in trace messages with and without LOCKDEP
> > enabled.
> > 
> > Please find the attached log file.
> 
> Can you get an rcu_invoke_callback event trace that Paul suggested?

I could not reproduce the issue with the latest next kernel
(4.12.0-rc7-next-20170703).

> Does this bug show up with just the powerpc next branch?

Perhaps, stress-ng test on today's mainline kernel (4.12.0) triggered a
different trace message and this not reproducible all the time.


stress-ng --io 100  --vm 10 --vm-bytes 100g --timeout 1h --oomable

INFO: rcu_sched self-detected stall on CPU
        8-...: (2099 ticks this GP) idle=37e/140000000000001/0
softirq=1404131/1404131 fqs=932 
         (t=2100 jiffies g=394894 c=394893 q=21997)
Task dump for CPU 8:
kworker/u162:2  R  running task    11168 28468      2 0x00000884   
Workqueue: writeback wb_workfn (flush-253:1)
Call Trace:
[c00000036e3eb340] [c000000000114480] sched_show_task+0xf0/0x160
(unreliable)
[c00000036e3eb3b0] [c0000000009adc2c] rcu_dump_cpu_stacks+0xd0/0x134
[c00000036e3eb400] [c00000000015e4d0] rcu_check_callbacks+0x8f0/0xaf0
[c00000036e3eb530] [c000000000165e2c] update_process_times+0x3c/0x90
[c00000036e3eb560] [c00000000017b73c] tick_sched_handle.isra.13
+0x2c/0xc0
[c00000036e3eb590] [c00000000017b828] tick_sched_timer+0x58/0xb0
[c00000036e3eb5d0] [c0000000001669e8] __hrtimer_run_queues+0xf8/0x330
[c00000036e3eb650] [c000000000167744] hrtimer_interrupt+0xe4/0x280
[c00000036e3eb710] [c000000000022620] __timer_interrupt+0x90/0x270
[c00000036e3eb760] [c000000000022cf0] timer_interrupt+0xa0/0xe0
[c00000036e3eb790] [c0000000000091e8] decrementer_common+0x158/0x160
--- interrupt: 901 at move_expired_inodes+0x30/0x200
    LR = queue_io+0x8c/0x190
[c00000036e3eba80] [c00000036e3ebac0] 0xc00000036e3ebac0 (unreliable)
[c00000036e3ebac0] [c000000000319b24] wb_writeback+0x2b4/0x420
[c00000036e3ebb90] [c00000000031a980] wb_workfn+0xf0/0x4b0
[c00000036e3ebca0] [c0000000000fa160] process_one_work+0x180/0x470
[c00000036e3ebd30] [c0000000000fa6d4] worker_thread+0x284/0x500
[c00000036e3ebdc0] [c000000000101fc0] kthread+0x160/0x1a0
[c00000036e3ebe30] [c00000000000bb60] ret_from_kernel_thread+0x5c/0x7c
INFO: rcu_sched self-detected stall on CPU
        51-...: (2099 ticks this GP) idle=7c2/140000000000001/0
softirq=1272749/1272749 fqs=995 
         (t=2100 jiffies g=394900 c=394899 q=32186)
~                                                   

stress-ng : http://kernel.ubuntu.com/git/cking/stress-ng.git

> 
> Thanks,
> Nick
> 


-- 
Regard's

Abdul Haleem
IBM Linux Technology Centre
