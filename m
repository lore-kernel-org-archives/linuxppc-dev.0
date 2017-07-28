Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJytk5J4szDrVT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Jul 2017 05:03:58 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6SJ2DMe004492
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 15:03:56 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c0709n2dd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jul 2017 15:03:55 -0400
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Fri, 28 Jul 2017 15:03:54 -0400
Date: Fri, 28 Jul 2017 12:03:50 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: dzickus@redhat.com, sfr@canb.auug.org.au, linuxarm@huawei.com,
 Nicholas Piggin <npiggin@gmail.com>, abdhalee@linux.vnet.ibm.com,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, tglx@linutronix.de
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170727014214.GH3730@linux.vnet.ibm.com>
 <20170727143400.23e4d2b2@roar.ozlabs.ibm.com>
 <20170727124913.GL3730@linux.vnet.ibm.com>
 <20170727144903.000022a1@huawei.com>
 <20170727173923.000001b2@huawei.com>
 <20170727165245.GD3730@linux.vnet.ibm.com>
 <20170728084411.00001ddb@huawei.com>
 <20170728142403.0000122b@huawei.com>
 <20170728165529.GF3730@linux.vnet.ibm.com>
 <20170728182053.000072aa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170728182053.000072aa@huawei.com>
Message-Id: <20170728190349.GM3730@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 28, 2017 at 06:27:05PM +0100, Jonathan Cameron wrote:
> On Fri, 28 Jul 2017 09:55:29 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > On Fri, Jul 28, 2017 at 02:24:03PM +0100, Jonathan Cameron wrote:
> > > On Fri, 28 Jul 2017 08:44:11 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:  
> > 
> > [ . . . ]
> > 
> > > Ok.  Some info.  I disabled a few driver (usb and SAS) in the interest of having
> > > fewer timer events.  Issue became much easier to trigger (on some runs before
> > > I could get tracing up and running)
> > >e
> > > So logs are large enough that pastebin doesn't like them - please shoet if  
> > >>e another timer period is of interest.  
> > > 
> > > https://pastebin.com/iUZDfQGM for the timer trace.
> > > https://pastebin.com/3w1F7amH for dmesg.  
> > > 
> > > The relevant timeout on the RCU stall detector was 8 seconds.  Event is
> > > detected around 835.
> > > 
> > > It's a lot of logs, so I haven't identified a smoking gun yet but there
> > > may well be one in there.  
> > 
> > The dmesg says:
> > 
> > rcu_preempt kthread starved for 2508 jiffies! g112 c111 f0x0 RCU_GP_WAIT_FQS(3) ->state=0x1
> > 
> > So I look for "rcu_preempt" timer events and find these:
> > 
> > rcu_preempt-9     [019] ....   827.579114: timer_init: timer=ffff8017d5fc7da0
> > rcu_preempt-9     [019] d..1   827.579115: timer_start: timer=ffff8017d5fc7da0 function=process_timeout 
> > 
> > Next look for "ffff8017d5fc7da0" and I don't find anything else.
> It does show up off the bottom of what would fit in pastebin...
> 
>      rcu_preempt-9     [001] d..1   837.681077: timer_cancel: timer=ffff8017d5fc7da0
>      rcu_preempt-9     [001] ....   837.681086: timer_init: timer=ffff8017d5fc7da0
>      rcu_preempt-9     [001] d..1   837.681087: timer_start: timer=ffff8017d5fc7da0 function=process_timeout expires=4295101298 [timeout=1] cpu=1 idx=0 flags=

Odd.  I would expect an expiration...  And ten seconds is way longer
than the requested one jiffy!

> > The timeout was one jiffy, and more than a second later, no expiration.
> > Is it possible that this event was lost?  I am not seeing any sign of
> > this is the trace.
> > 
> > I don't see any sign of CPU hotplug (and I test with lots of that in
> > any case).
> > 
> > The last time we saw something like this it was a timer HW/driver problem,
> > but it is a bit hard to imagine such a problem affecting both ARM64
> > and SPARC.  ;-)
> Could be different issues, both of which were hidden by that lockup detector.
> 
> There is an errata work around for the timers on this particular board.
> I'm only vaguely aware of it, so may be unconnected.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/clocksource/arm_arch_timer.c?h=v4.13-rc2&id=bb42ca47401010fc02901b5e8f79e40a26f208cb
> 
> Seems unlikely though! + we've not yet seen it on the other chips that
> errata effects (not that that means much).

If you can reproduce quickly, might be worth trying anyway...

							Thanx, Paul

> Jonathan
> 
> > 
> > Thomas, any debugging suggestions?
> > 
> > 							Thanx, Paul
> > 
> 
