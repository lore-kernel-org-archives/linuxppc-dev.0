Return-Path: <nicolas.pitre@linaro.org>
Received: from mail-qa0-f49.google.com (mail-qa0-f49.google.com
 [209.85.216.49])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C562B2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jan 2014 02:51:07 +1100 (EST)
Received: by mail-qa0-f49.google.com with SMTP id w8so7365560qac.22
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jan 2014 07:51:04 -0800 (PST)
Date: Mon, 27 Jan 2014 10:51:02 -0500 (EST)
From: Nicolas Pitre <nicolas.pitre@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 2/9] ARM64: get rid of arch_cpu_idle_prepare()
In-Reply-To: <20140127154315.GG32608@arm.com>
Message-ID: <alpine.LFD.2.11.1401271047240.1652@knanqh.ubzr>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-3-git-send-email-nicolas.pitre@linaro.org>
 <20140127154315.GG32608@arm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Mon, 27 Jan 2014, Catalin Marinas wrote:

> On Mon, Jan 27, 2014 at 06:08:17AM +0000, Nicolas Pitre wrote:
> > ARM and ARM64 are the only two architectures implementing
> > arch_cpu_idle_prepare() simply to call local_fiq_enable().
> > 
> > We have secondary_start_kernel() already calling local_fiq_enable() and
> > this is done a second time in arch_cpu_idle_prepare() in that case. And
> > enabling FIQs has nothing to do with idling the CPU to start with.
> > 
> > So let's introduce init_fiq_boot_cpu() to take care of FIQs on the boot
> > CPU and remove arch_cpu_idle_prepare(). This is now done a bit earlier
> > at late_initcall time but this shouldn't make a difference in practice
> > given that FIQs are not currently used on ARM64.
> > 
> > Signed-off-by: Nicolas Pitre <nico@linaro.org>
> 
> For arm64, we could simply remove any reference to FIQs. I'm not aware
> of anyone using them.

OK. What if I sumply remove arch_cpu_idle_prepare() and let you do the 
remove the rest?

IMHO I'd simply remove local_fiq_{enable/disable}() from 
arm64/kernel/smp.c and leave the infrastructure in place in case someone 
needs it eventually.  In which case I could include that into my patch 
as well.


Nicolas
