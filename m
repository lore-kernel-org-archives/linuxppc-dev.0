Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (unknown [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 4B3ED2C02FD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 05:07:32 +1100 (EST)
Date: Thu, 30 Jan 2014 19:06:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2 1/6] idle: move the cpuidle entry point to the generic
 idle loop
Message-ID: <20140130180659.GI5002@laptop.programming.kicks-ass.net>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-2-git-send-email-nicolas.pitre@linaro.org>
 <alpine.LFD.2.11.1401291526320.1652@knanqh.ubzr>
 <52E9C946.50704@linux.vnet.ibm.com>
 <alpine.LFD.2.11.1401300021530.1652@knanqh.ubzr>
 <52EA5720.8010000@linaro.org>
 <alpine.LFD.2.11.1401301056180.1652@knanqh.ubzr>
 <52EA8BD4.6020803@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52EA8BD4.6020803@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-kernel@lists.linaro.org,
 Russell King <linux@arm.linux.org.uk>, linux-pm@vger.kernel.org,
 linux-sh@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>,
 Paul Mundt <lethal@linux-sh.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 30, 2014 at 06:28:52PM +0100, Daniel Lezcano wrote:
> Ok, I think the mess is coming from 'default_idle' which does not re-enable
> the local_irq but used from different places like amd_e400_idle and
> apm_cpu_idle.
> 
> void default_idle(void)
> {
>         trace_cpu_idle_rcuidle(1, smp_processor_id());
>         safe_halt();
>         trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
> }
> 
> Considering the system configured without cpuidle because this one *always*
> enable the local irq, we have the different cases:
> 
> x86_idle = default_idle();
> ==> local_irq_enable is missing
> 

safe_halt() is "sti; hlt" and so very much does the irq_enable.
