Return-Path: <catalin.marinas@arm.com>
Received: from collaborate-mta1.arm.com (fw-tnat.austin.arm.com
 [217.140.110.23]) by ozlabs.org (Postfix) with ESMTP id F114C2C00A4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 02:58:31 +1100 (EST)
Date: Mon, 27 Jan 2014 15:57:55 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 2/9] ARM64: get rid of arch_cpu_idle_prepare()
Message-ID: <20140127155755.GH32608@arm.com>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-3-git-send-email-nicolas.pitre@linaro.org>
 <20140127154315.GG32608@arm.com>
 <alpine.LFD.2.11.1401271047240.1652@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LFD.2.11.1401271047240.1652@knanqh.ubzr>
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>,
 Russell King <linux@arm.linux.org.uk>,
 "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@redhat.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 27, 2014 at 03:51:02PM +0000, Nicolas Pitre wrote:
> On Mon, 27 Jan 2014, Catalin Marinas wrote:
> 
> > On Mon, Jan 27, 2014 at 06:08:17AM +0000, Nicolas Pitre wrote:
> > > ARM and ARM64 are the only two architectures implementing
> > > arch_cpu_idle_prepare() simply to call local_fiq_enable().
> > > 
> > > We have secondary_start_kernel() already calling local_fiq_enable() and
> > > this is done a second time in arch_cpu_idle_prepare() in that case. And
> > > enabling FIQs has nothing to do with idling the CPU to start with.
> > > 
> > > So let's introduce init_fiq_boot_cpu() to take care of FIQs on the boot
> > > CPU and remove arch_cpu_idle_prepare(). This is now done a bit earlier
> > > at late_initcall time but this shouldn't make a difference in practice
> > > given that FIQs are not currently used on ARM64.
> > > 
> > > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> > 
> > For arm64, we could simply remove any reference to FIQs. I'm not aware
> > of anyone using them.
> 
> OK. What if I sumply remove arch_cpu_idle_prepare() and let you do the 
> remove the rest?
> 
> IMHO I'd simply remove local_fiq_{enable/disable}() from 
> arm64/kernel/smp.c and leave the infrastructure in place in case someone 
> needs it eventually.  In which case I could include that into my patch 
> as well.

Sounds good. We can keep the local_fiq_*() functions but remove about 4
calling sites (process.c and smp.c) until needed.

Thanks.

-- 
Catalin
