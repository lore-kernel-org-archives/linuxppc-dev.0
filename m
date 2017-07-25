Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGzzv6mL6zDqmj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 23:46:35 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6PDjXRu043111
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 09:46:33 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bx6c2ame4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 09:46:33 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 25 Jul 2017 09:46:32 -0400
Date: Tue, 25 Jul 2017 06:46:26 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
 Andrew Morton <akpm@linux-foundation.org>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Don Zickus <dzickus@redhat.com>, David Miller <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n  - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170725193039.00007c80@huawei.com>
 <20170725222654.5a968588@roar.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170725222654.5a968588@roar.ozlabs.ibm.com>
Message-Id: <20170725134626.GL3730@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 25, 2017 at 10:26:54PM +1000, Nicholas Piggin wrote:
> On Tue, 25 Jul 2017 19:32:10 +0800
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > Hi All,
> > 
> > We observed a regression on our d05 boards (but curiously not
> > the fairly similar but single socket / smaller core count
> > d03), initially seen with linux-next prior to the merge window
> > and still present in v4.13-rc2.
> > 
> > The symptom is:

Adding Dave Miller and the sparclinux@vger.kernel.org email on CC, as
they have been seeing something similar, and you might well have saved
them the trouble of bisecting.

[ . . . ]

> > [ 1984.628602] rcu_preempt kthread starved for 5663 jiffies! g1566 c1565 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1

This is the cause from an RCU perspective.  You had a lot of idle CPUs,
and RCU is not permitted to disturb them -- the battery-powered embedded
guys get very annoyed by that sort of thing.  What happens instead is
that each CPU updates a per-CPU state variable when entering or exiting
idle, and the grace-period kthread ("rcu_preempt kthread" in the above
message) checks these state variables, and if when sees an idle CPU,
it reports a quiescent state on that CPU's behalf.

But the grace-period kthread can only do this work if it gets a chance
to run.  And the message above says that this kthread hasn't had a chance
to run for a full 5,663 jiffies.  For completeness, the "g1566 c1565"
says that grace period #1566 is in progress, the "f0x0" says that no one
is needing another grace period #1567.  The "RCU_GP_WAIT_FQS(3)" says
that the grace-period kthread has fully initialized the current grace
period and is sleeping for a few jiffies waiting to scan for idle tasks.
Finally, the "->state=0x1" says that the grace-period kthread is in
TASK_INTERRUPTIBLE state, in other words, still sleeping.

So my first question is "What did commit 05a4a9527 (kernel/watchdog:
split up config options) do to prevent the grace-period kthread from
getting a chance to run?"  I must confess that I don't see anything
obvious in that commit, so my second question is "Are we sure that
reverting this commit makes the problem go away?" and my third is "Is
this an intermittent problem that led to a false bisection?"

[ . . . ]

> > Reducing the RCU CPU stall timeout makes it happen more often,
> > but we are seeing even with the default value of 24 seconds.
> > 
> > Tends to occur after a period or relatively low usage, but has
> > also been seen mid way through performance tests.
> > 
> > This was not seen with v4.12 so a bisection run later lead to
> > commit 05a4a9527 (kernel/watchdog: split up config options).
> > 
> > Which was odd until we discovered that a side effect of this patch
> > was to change whether the softlockup detector was enabled or not in
> > the arm64 defconfig.
> > 
> > On 4.13-rc2 enabling the softlockup detector indeed stopped us
> > seeing the rcu issue. Disabling the equivalent on 4.12 made the
> > issue occur there as well.
> > 
> > Clearly the softlockup detector results in a thread on every cpu,
> > which might be related but beyond that we are still looking into
> > the issue.
> > 
> > So the obvious question is whether anyone else is seeing this as
> > it might help us to focus in on where to look!
> 
> Huh. Something similar has been seen very intermittently on powerpc
> as well. We couldn't reproduce it reliably to bisect it already, so
> this is a good help.
> 
> http://marc.info/?l=linuxppc-embedded&m=149872815523646&w=2
> 
> It looks like the watchdog patch has a similar effect on powerpc in
> that it stops enabling the softlockup detector by default. Haven't
> confirmed, but it looks like the same thing.
> 
> A bug in RCU stall detection?

Well, if I am expected to make grace periods complete when my grace-period
kthreads aren't getting any CPU time, I will have to make some substantial
changes.  ;-)

One possibility is that the timer isn't firing and another is that the
timer's wakeup is being lost somehow.

So another thing to try is to boot with rcutree.rcu_kick_kthreads=1.
This will cause RCU to do redundant wakeups on the grace-period kthread
if the grace period is moving slowly.  This is of course a crude hack,
which is why this boot parameter will also cause a splat if it ever has
to do anything.

Does this help at all?

							Thanx, Paul

> > In the meantime we'll carry on digging.
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > p.s. As a more general question, do we want to have the
> > soft lockup detector enabledon arm64 by default?
> 
> I've cc'ed Don. My patch should not have changed defconfigs, I
> should have been more careful with that.
> 
> Thanks,
> Nick
> 
