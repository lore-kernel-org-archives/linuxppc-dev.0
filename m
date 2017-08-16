Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXTqs1CyLzDqHj
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 22:56:24 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7GCrqCI071601
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 08:56:22 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cckrcuq5m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Aug 2017 08:56:22 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 16 Aug 2017 08:56:21 -0400
Date: Wed, 16 Aug 2017 05:56:17 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dzickus@redhat.com,
 sfr@canb.auug.org.au, linuxarm@huawei.com,
 Nicholas Piggin <npiggin@gmail.com>, abdhalee@linux.vnet.ibm.com,
 tglx@linutronix.de, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170728165529.GF3730@linux.vnet.ibm.com>
 <20170728182053.000072aa@huawei.com>
 <20170728190349.GM3730@linux.vnet.ibm.com>
 <20170731120847.00003d5c@huawei.com>
 <20170731150411.GA3730@linux.vnet.ibm.com>
 <20170731162757.000058ba@huawei.com>
 <20170801184646.GE3730@linux.vnet.ibm.com>
 <20170802172555.0000468a@huawei.com>
 <20170815154743.GK7017@linux.vnet.ibm.com>
 <87wp63smwn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87wp63smwn.fsf@concordia.ellerman.id.au>
Message-Id: <20170816125617.GY7017@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 16, 2017 at 10:43:52PM +1000, Michael Ellerman wrote:
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
> ...
> >
> > commit 33103e7b1f89ef432dfe3337d2a6932cdf5c1312
> > Author: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > Date:   Mon Aug 14 08:54:39 2017 -0700
> >
> >     EXP: Trace tick return from tick_nohz_stop_sched_tick
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> >
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index c7a899c5ce64..7358a5073dfb 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -817,6 +817,7 @@ static ktime_t tick_nohz_stop_sched_tick(struct tick_sched *ts,
> >  	 * (not only the tick).
> >  	 */
> >  	ts->sleep_length = ktime_sub(dev->next_event, now);
> > +	trace_printk("tick_nohz_stop_sched_tick: %lld\n", (tick - ktime_get()) / 1000);
> >  	return tick;
> >  }
> 
> Should I be seeing negative values? A small sample:

Maybe due to hypervisor preemption delays, but I confess that I am
surprised to see them this large.  1,602,250,019 microseconds is something
like a half hour, which could result in stall warnings all by itself.

>           <idle>-0     [015] d...  1602.039695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250019
>           <idle>-0     [009] d...  1602.039701: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250025
>           <idle>-0     [007] d...  1602.039702: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250025
>           <idle>-0     [048] d...  1602.039703: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: 9973
>           <idle>-0     [006] d...  1602.039704: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250027
>           <idle>-0     [001] d...  1602.039730: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250053
>           <idle>-0     [008] d...  1602.039732: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602250055
>           <idle>-0     [006] d...  1602.049695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602260018
>           <idle>-0     [009] d...  1602.049695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602260018
>           <idle>-0     [001] d...  1602.049695: __tick_nohz_idle_enter: tick_nohz_stop_sched_tick: -1602260018
> 
> 
> I have a full trace, I'll send it to you off-list.

I will take a look!

							Thanx, Paul
