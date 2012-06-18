Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e34.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C8619B6FCA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2012 07:59:10 +1000 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 18 Jun 2012 15:59:07 -0600
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
 [9.17.195.227])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 1C63219D8053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2012 21:59:02 +0000 (WET)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5ILwxaJ120704
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2012 15:59:01 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5ILwwIL012640
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2012 15:58:59 -0600
Date: Mon, 18 Jun 2012 14:58:57 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: RCU stalls on 32-bit pmac SMP
Message-ID: <20120618215857.GG2400@linux.vnet.ibm.com>
References: <1339979746.2372.6.camel@pasglop>
 <20120618170521.GD2400@linux.vnet.ibm.com>
 <1340052331.2372.32.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1340052331.2372.32.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 19, 2012 at 06:45:31AM +1000, Benjamin Herrenschmidt wrote:
> Hi Paul !
> 
> On Mon, 2012-06-18 at 10:05 -0700, Paul E. McKenney wrote:
> 
> > > sd 0:0:0:0: Attached scsi generic sg0 type 0
> > >  sda: [mac] sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8 sda9 sda10 sda11 sda12 sda13 sda14 sda15
> > > sd 0:0:0:0: [sda] Attached SCSI disk
> > > scsi 0:0:1:0: Direct-Access     ATA      ST380021A        3.75 PQ: 0 ANSI: 5
> > > sd 0:0:1:0: [sdb] 156301488 512-byte logical blocks: (80.0 GB/74.5 GiB)
> > > sd 0:0:1:0: [sdb] Write Protect is off
> > > sd 0:0:1:0: Attached scsi generic sg1 type 0
> > > sd 0:0:1:0: [sdb] Mode Sense: 00 3a 00 00
> > > sd 0:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > > INFO: rcu_sched self-detected stall on CPU { 0}  (t=16163 jiffies)
> > > Call Trace:
> > > INFO: rcu_sched self-detected stall on CPU { 1}  (t=16163 jiffies)
> > > Call Trace:
> > > [ef877d30] [c0008d04] show_stack+0x50/0x158 (unreliable)
> > > [ef877d70] [c0097fe4] __rcu_pending+0x184/0x46c
> > > [ef877da0] [c00991a0] rcu_check_callbacks+0x7c/0x168
> > > [ef877dc0] [c0044a40] update_process_times+0x3c/0x70
> > > [ef877de0] [c0083a3c] tick_sched_timer+0x88/0x100
> > > [ef877e10] [c005b11c] __run_hrtimer.clone.29+0x54/0x104
> > > [ef877e30] [c005bf44] hrtimer_interrupt+0x158/0x3f8
> > > [ef877ea0] [c000b5c4] timer_interrupt+0x1cc/0x204
> > > [ef877ed0] [c0011b88] ret_from_except+0x0/0x1c
> > > --- Exception: 901 at cpu_idle+0xe4/0x188
> > 
> > Am I reading this correctly?  Did the system really take a scheduling-clock
> > interrupt from within another scheduling-clock interrupt?
> 
> Not that I can see. I see only one interrupt on that CPU. It was idle,
> took a timer interrupt -> hrtimer ... etc... RCU boom !
> 
> > If so, my first question is "Why did the scheduling-clock interrupt
> > run for so long?"  ;-)
> 
> This is still that CPU:
> 
> >      LR = cpu_idle+0xc8/0x188
> > > [ef877f90] [c00097e8] cpu_idle+0x60/0x188 (unreliable)
> > > [ef877fc0] [c046531c] start_secondary+0x2c8/0x2cc
> > > [ef877ff0] [00003278] 0x3278
> 
> And now we have the other one:
> 
> > > [ef873b60] [c0008d04] show_stack+0x50/0x158 (unreliable)
> > > [ef873ba0] [c0097fe4] __rcu_pending+0x184/0x46c
> > > [ef873bd0] [c0099240] rcu_check_callbacks+0x11c/0x168
> > > [ef873bf0] [c0044a40] update_process_times+0x3c/0x70
> > > [ef873c10] [c0083a3c] tick_sched_timer+0x88/0x100
> > > [ef873c40] [c005b11c] __run_hrtimer.clone.29+0x54/0x104
> > > [ef873c60] [c005bf44] hrtimer_interrupt+0x158/0x3f8
> > > [ef873cd0] [c000b5c4] timer_interrupt+0x1cc/0x204
> > > [ef873d00] [c0011b88] ret_from_except+0x0/0x1c
> > > --- Exception: 901 at wake_up_new_task+0x134/0x16c
> > >     LR = wake_up_new_task+0x134/0x16c
> > > [ef873dc0] [c0065f08] wake_up_new_task+0xfc/0x16c (unreliable)
> > > [ef873df0] [c0035530] do_fork+0xe8/0x2bc
> > > [ef873e30] [c0008a4c] sys_clone+0x50/0x90
> > > [ef873e50] [c00114b8] ret_from_syscall+0x0/0x40
> > > --- Exception: c00 at kernel_thread+0x28/0x68
> > >     LR = __call_usermodehelper+0x40/0xdc
> > > [ef873f10] [c005f5c8] async_run_entry_fn+0x128/0x1e4 (unreliable)
> > > [ef873f20] [ef878c00] 0xef878c00
> > > [ef873f40] [c004e668] process_one_work+0x150/0x3f0
> > > [ef873f70] [c00514f0] worker_thread+0x18c/0x37c
> > > [ef873fb0] [c00567bc] kthread+0x84/0x88
> > > [ef873ff0] [c000f514] kernel_thread+0x4c/0x68
> 
> Here what we have is a kernel thread trying to call_usermodehelper
> (probably the hotplug stuff from discovering the disk) taking a timer
> interrupt from wake_up_new_task.
> 
> Looks like the hang has to be with some RCU stuff update_process_times
> does vs. taking the interrupt in wake_up_new_task ? Hard to tell...

The RCU stuff from update_process_times() is usually the diagnostic.

> This happens more/less reliably once at boot on this machine, then no
> more (after the long pause the machine moves on, apparently fine).

What happens if you reduce the stall-warning timeout?  You can use either
the CONFIG_RCU_CPU_STALL_TIMEOUT kernel config parameter or the
rcutree.rcu_cpu_stall_timeout boot parameter.

If you can get two stall-warning messages to appear during the hang,
comparing the stacks is usually informative.

							Thanx, Paul
