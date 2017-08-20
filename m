Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xb8hr0BM4zDqY3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 07:14:35 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7KLDq5b073227
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 17:14:33 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2cehgawm63-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 17:14:33 -0400
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 20 Aug 2017 17:14:31 -0400
Date: Sun, 20 Aug 2017 14:14:29 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, dzickus@redhat.com,
 sfr@canb.auug.org.au, linuxarm@huawei.com, abdhalee@linux.vnet.ibm.com,
 tglx@linutronix.de, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, john.stultz@linaro.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Reply-To: paulmck@linux.vnet.ibm.com
References: <20170731162757.000058ba@huawei.com>
 <20170801184646.GE3730@linux.vnet.ibm.com>
 <20170802172555.0000468a@huawei.com>
 <20170815154743.GK7017@linux.vnet.ibm.com>
 <87wp63smwn.fsf@concordia.ellerman.id.au>
 <20170816125617.GY7017@linux.vnet.ibm.com>
 <20170816162731.GA22978@linux.vnet.ibm.com>
 <20170820144553.2ab2727b@ppc64le>
 <20170820230040.706b62ac@roar.ozlabs.ibm.com>
 <20170820183514.GM11320@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170820183514.GM11320@linux.vnet.ibm.com>
Message-Id: <20170820211429.GA27111@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Aug 20, 2017 at 11:35:14AM -0700, Paul E. McKenney wrote:
> On Sun, Aug 20, 2017 at 11:00:40PM +1000, Nicholas Piggin wrote:
> > On Sun, 20 Aug 2017 14:45:53 +1000
> > Nicholas Piggin <npiggin@gmail.com> wrote:
> > 
> > > On Wed, 16 Aug 2017 09:27:31 -0700
> > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> > > > On Wed, Aug 16, 2017 at 05:56:17AM -0700, Paul E. McKenney wrote:
> > > > 
> > > > Thomas, John, am I misinterpreting the timer trace event messages?  
> > > 
> > > So I did some digging, and what you find is that rcu_sched seems to do a
> > > simple scheudle_timeout(1) and just goes out to lunch for many seconds.
> > > The process_timeout timer never fires (when it finally does wake after
> > > one of these events, it usually removes the timer with del_timer_sync).
> > > 
> > > So this patch seems to fix it. Testing, comments welcome.
> > 
> > Okay this had a problem of trying to forward the timer from a timer
> > callback function.
> > 
> > This was my other approach which also fixes the RCU warnings, but it's
> > a little more complex. I reworked it a bit so the mod_timer fast path
> > hopefully doesn't have much more overhead (actually by reading jiffies
> > only when needed, it probably saves a load).
> 
> Giving this one a whirl!

No joy here, but then again there are other reasons to believe that I
am seeing a different bug than Dave and Jonathan are.

OK, not -entirely- without joy -- 10 of 14 runs were error-free, which
is a good improvement over 0 of 84 for your earlier patch.  ;-)  But
not statistically different from what I see without either patch.

But no statistical difference compared to without patch, and I still
see the "rcu_sched kthread starved" messages.  For whatever it is worth,
by the way, I also see this: "hrtimer: interrupt took 5712368 ns".
Hmmm...  I am also seeing that without any of your patches.  Might
be hypervisor preemption, I guess.

							Thanx, Paul

PS.  I will be off the grid for the next day or so.  Eclipse day here...
