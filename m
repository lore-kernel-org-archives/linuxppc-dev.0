Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJyNx53zNzDrS4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 04:41:37 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6SIceGj044646
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 14:41:35 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c0648gb9j-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 14:41:34 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 28 Jul 2017 14:41:33 -0400
Date: Fri, 28 Jul 2017 11:41:29 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dzickus@redhat.com,
 sfr@canb.auug.org.au, linuxarm@huawei.com,
 Nicholas Piggin <npiggin@gmail.com>, abdhalee@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170726.162200.1904949371593276937.davem@davemloft.net>
 <20170727014214.GH3730@linux.vnet.ibm.com>
 <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
 <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728125416.j7gcgvnxgv2gq73u@tardis>
 <20170728145530.GE3730@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170728145530.GE3730@linux.vnet.ibm.com>
Message-Id: <20170728184129.GA24364@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 28, 2017 at 07:55:30AM -0700, Paul E. McKenney wrote:
> On Fri, Jul 28, 2017 at 08:54:16PM +0800, Boqun Feng wrote:
> > Hi Jonathan,
> > 
> > FWIW, there is wakeup-missing issue in swake_up() and swake_up_all():
> > 
> > 	https://marc.info/?l=linux-kernel&m=149750022019663
> > 
> > and RCU begins to use swait/wake last year, so I thought this could be
> > relevant.
> > 
> > Could you try the following patch and see if it works? Thanks.
> > 
> > Regards,
> > Boqun
> > 
> > ------------------>8
> > Subject: [PATCH] swait: Remove the lockless swait_active() check in
> >  swake_up*()
> > 
> > Steven Rostedt reported a potential race in RCU core because of
> > swake_up():
> > 
> >         CPU0                            CPU1
> >         ----                            ----
> >                                 __call_rcu_core() {
> > 
> >                                  spin_lock(rnp_root)
> >                                  need_wake = __rcu_start_gp() {
> >                                   rcu_start_gp_advanced() {
> >                                    gp_flags = FLAG_INIT
> >                                   }
> >                                  }
> > 
> >  rcu_gp_kthread() {
> >    swait_event_interruptible(wq,
> >         gp_flags & FLAG_INIT) {
> 
> So the idea is that we get the old value of ->gp_flags here, correct?
> 
> >    spin_lock(q->lock)
> > 
> >                                 *fetch wq->task_list here! *
> 
> And the above fetch is really part of the swait_active() called out
> below, right?
> 
> >    list_add(wq->task_list, q->task_list)
> >    spin_unlock(q->lock);
> > 
> >    *fetch old value of gp_flags here *
> 
> And here we fetch the old value of ->gp_flags again, this time under
> the lock, right?
> 
> >                                  spin_unlock(rnp_root)
> > 
> >                                  rcu_gp_kthread_wake() {
> >                                   swake_up(wq) {
> >                                    swait_active(wq) {
> >                                     list_empty(wq->task_list)
> > 
> >                                    } * return false *
> > 
> >   if (condition) * false *
> >     schedule();
> > 
> > In this case, a wakeup is missed, which could cause the rcu_gp_kthread
> > waits for a long time.
> > 
> > The reason of this is that we do a lockless swait_active() check in
> > swake_up(). To fix this, we can either 1) add a smp_mb() in swake_up()
> > before swait_active() to provide the proper order or 2) simply remove
> > the swait_active() in swake_up().
> > 
> > The solution 2 not only fixes this problem but also keeps the swait and
> > wait API as close as possible, as wake_up() doesn't provide a full
> > barrier and doesn't do a lockless check of the wait queue either.
> > Moreover, there are users already using swait_active() to do their quick
> > checks for the wait queues, so it make less sense that swake_up() and
> > swake_up_all() do this on their own.
> > 
> > This patch then removes the lockless swait_active() check in swake_up()
> > and swake_up_all().
> > 
> > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Even though Jonathan's testing indicates that it didn't fix this
> particular problem:
> 
> Acked-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

And while we are at it:

Tested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> > ---
> >  kernel/sched/swait.c | 6 ------
> >  1 file changed, 6 deletions(-)
> > 
> > diff --git a/kernel/sched/swait.c b/kernel/sched/swait.c
> > index 3d5610dcce11..2227e183e202 100644
> > --- a/kernel/sched/swait.c
> > +++ b/kernel/sched/swait.c
> > @@ -33,9 +33,6 @@ void swake_up(struct swait_queue_head *q)
> >  {
> >  	unsigned long flags;
> > 
> > -	if (!swait_active(q))
> > -		return;
> > -
> >  	raw_spin_lock_irqsave(&q->lock, flags);
> >  	swake_up_locked(q);
> >  	raw_spin_unlock_irqrestore(&q->lock, flags);
> > @@ -51,9 +48,6 @@ void swake_up_all(struct swait_queue_head *q)
> >  	struct swait_queue *curr;
> >  	LIST_HEAD(tmp);
> > 
> > -	if (!swait_active(q))
> > -		return;
> > -
> >  	raw_spin_lock_irq(&q->lock);
> >  	list_splice_init(&q->task_list, &tmp);
> >  	while (!list_empty(&tmp)) {
> > -- 
> > 2.13.0
> > 
