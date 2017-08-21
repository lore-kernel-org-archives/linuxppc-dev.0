Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xbFYB59dhzDrJV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Aug 2017 10:53:18 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id y129so21265900pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 17:53:18 -0700 (PDT)
Date: Mon, 21 Aug 2017 10:52:58 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, dzickus@redhat.com, sfr@canb.auug.org.au,
 linuxarm@huawei.com, abdhalee@linux.vnet.ibm.com, tglx@linutronix.de,
 sparclinux@vger.kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, john.stultz@linaro.org
Subject: Re: RCU lockup issues when CONFIG_SOFTLOCKUP_DETECTOR=n - any one
 else seeing this?
Message-ID: <20170821105258.191d04b1@roar.ozlabs.ibm.com>
In-Reply-To: <20170820211429.GA27111@linux.vnet.ibm.com>
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
 <20170820211429.GA27111@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 20 Aug 2017 14:14:29 -0700
"Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:

> On Sun, Aug 20, 2017 at 11:35:14AM -0700, Paul E. McKenney wrote:
> > On Sun, Aug 20, 2017 at 11:00:40PM +1000, Nicholas Piggin wrote:  
> > > On Sun, 20 Aug 2017 14:45:53 +1000
> > > Nicholas Piggin <npiggin@gmail.com> wrote:
> > >   
> > > > On Wed, 16 Aug 2017 09:27:31 -0700
> > > > "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:  
> > > > > On Wed, Aug 16, 2017 at 05:56:17AM -0700, Paul E. McKenney wrote:
> > > > > 
> > > > > Thomas, John, am I misinterpreting the timer trace event messages?    
> > > > 
> > > > So I did some digging, and what you find is that rcu_sched seems to do a
> > > > simple scheudle_timeout(1) and just goes out to lunch for many seconds.
> > > > The process_timeout timer never fires (when it finally does wake after
> > > > one of these events, it usually removes the timer with del_timer_sync).
> > > > 
> > > > So this patch seems to fix it. Testing, comments welcome.  
> > > 
> > > Okay this had a problem of trying to forward the timer from a timer
> > > callback function.
> > > 
> > > This was my other approach which also fixes the RCU warnings, but it's
> > > a little more complex. I reworked it a bit so the mod_timer fast path
> > > hopefully doesn't have much more overhead (actually by reading jiffies
> > > only when needed, it probably saves a load).  
> > 
> > Giving this one a whirl!  
> 
> No joy here, but then again there are other reasons to believe that I
> am seeing a different bug than Dave and Jonathan are.
> 
> OK, not -entirely- without joy -- 10 of 14 runs were error-free, which
> is a good improvement over 0 of 84 for your earlier patch.  ;-)  But
> not statistically different from what I see without either patch.
> 
> But no statistical difference compared to without patch, and I still
> see the "rcu_sched kthread starved" messages.  For whatever it is worth,
> by the way, I also see this: "hrtimer: interrupt took 5712368 ns".
> Hmmm...  I am also seeing that without any of your patches.  Might
> be hypervisor preemption, I guess.

Okay it makes the warnings go away for me, but I'm just booting then
leaving the system idle. You're doing some CPU hotplug activity?

Thanks,
Nick
