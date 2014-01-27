Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qc0-f172.google.com (mail-qc0-f172.google.com
 [209.85.216.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 671F02C00BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 04:37:04 +1100 (EST)
Received: by mail-qc0-f172.google.com with SMTP id c9so8342241qcz.17
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 09:37:01 -0800 (PST)
Date: Mon, 27 Jan 2014 12:36:59 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/9] ARM: get rid of arch_cpu_idle_prepare()
In-Reply-To: <20140127160654.GO15937@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1401271232130.1652@knanqh.ubzr>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-2-git-send-email-nicolas.pitre@linaro.org>
 <20140127124511.GK15937@n2100.arm.linux.org.uk>
 <alpine.LFD.2.11.1401271004060.1652@knanqh.ubzr>
 <20140127160654.GO15937@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linaro-kernel@lists.linaro.org, linux-sh@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Catalin Marinas <catalin.marinas@arm.com>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 27 Jan 2014, Russell King - ARM Linux wrote:

> On Mon, Jan 27, 2014 at 10:45:59AM -0500, Nicolas Pitre wrote:
> > On Mon, 27 Jan 2014, Russell King - ARM Linux wrote:
> > 
> > > On Mon, Jan 27, 2014 at 01:08:16AM -0500, Nicolas Pitre wrote:
> > > > ARM and ARM64 are the only two architectures implementing
> > > > arch_cpu_idle_prepare() simply to call local_fiq_enable().
> > > > 
> > > > We have secondary_start_kernel() already calling local_fiq_enable() and
> > > > this is done a second time in arch_cpu_idle_prepare() in that case. And
> > > > enabling FIQs has nothing to do with idling the CPU to start with.
> > > > 
> > > > So let's introduce init_fiq_boot_cpu() to take care of FIQs on the boot
> > > > CPU and remove arch_cpu_idle_prepare(). This is now done a bit earlier
> > > > at late_initcall time but this shouldn't make a difference in practice
> > > > i.e. when FIQs are actually used.
> > > > 
> > > > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > > > ---
> > > >  arch/arm/kernel/process.c | 5 -----
> > > >  arch/arm/kernel/setup.c   | 7 +++++++
> > > >  2 files changed, 7 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > > > index 92f7b15dd2..725b8c95e0 100644
> > > > --- a/arch/arm/kernel/process.c
> > > > +++ b/arch/arm/kernel/process.c
> > > > @@ -142,11 +142,6 @@ static void default_idle(void)
> > > >  	local_irq_enable();
> > > >  }
> > > >  
> > > > -void arch_cpu_idle_prepare(void)
> > > > -{
> > > > -	local_fiq_enable();
> > > > -}
> > > > -
> > > >  void arch_cpu_idle_enter(void)
> > > >  {
> > > >  	ledtrig_cpu(CPU_LED_IDLE_START);
> > > > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > > > index 987a7f5bce..d027b1a6fe 100644
> > > > --- a/arch/arm/kernel/setup.c
> > > > +++ b/arch/arm/kernel/setup.c
> > > > @@ -789,6 +789,13 @@ static int __init init_machine_late(void)
> > > >  }
> > > >  late_initcall(init_machine_late);
> > > >  
> > > > +static int __init init_fiq_boot_cpu(void)
> > > > +{
> > > > +	local_fiq_enable();
> > > > +	return 0;
> > > > +}
> > > > +late_initcall(init_fiq_boot_cpu);
> > > 
> > > arch_cpu_idle_prepare() gets called from the swapper thread, and changes
> > > the swapper thread's CPSR. init_fiq_boot_cpu() gets called from PID1, the
> > > init thread, and changes the init thread's CPSR, which will already have
> > > FIQs enabled by way of how kernel threads are created.
> > > 
> > > Hence, the above code fragment has no effect what so ever, and those
> > > platforms using FIQs will not have FIQs delivered if they're idle
> > > (because the swapper will have FIQs masked at the CPU.)
> > 
> > You're right.
> > 
> > What about moving local_fiq_enable() to trap_init() then?
> 
> That's potentially unsafe, as we haven't touched any of the IRQ
> controllers at that point - we can't guarantee what state they'd be
> in.  Given that the default FIQ is to just return, a FIQ being raised
> at that point will end up with an infinite loop re-entering the FIQ
> handler.

Okay... I don't see any obvious way to work around that besides adding 
another explicit hook, which arch_cpu_idle_prepare() incidentally 
already is. So, unless you have a better idea, I'll drop this patch and 
leave ARM as the only user of arch_cpu_idle_prepare().


Nicolas
