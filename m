Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A05E12C0096
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 23:41:47 +1100 (EST)
Date: Fri, 7 Feb 2014 13:41:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
Message-ID: <20140207124140.GB9987@twins.programming.kicks-ass.net>
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <CAKnoXLxCAqKaniGOwegNcOarS4FpoNKDY5PxOhe6j4wdtUAkLQ@mail.gmail.com>
 <52F3BCFE.3010703@linux.vnet.ibm.com>
 <alpine.LFD.2.11.1402070105170.1906@knanqh.ubzr>
 <52F46EB3.5080403@linux.vnet.ibm.com>
 <alpine.LFD.2.11.1402071022490.1906@knanqh.ubzr>
 <52F4C666.4050308@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52F4C666.4050308@linux.vnet.ibm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>,
 Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, LKML <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 07, 2014 at 05:11:26PM +0530, Preeti U Murthy wrote:
> But observe the idle state "snooze" on powerpc. The power that this idle
> state saves is through the lowering of the thread priority of the CPU.
> After it lowers the thread priority, it is done. It cannot
> "wait_for_interrupts". It will exit my_idle(). It is now upto the
> generic idle loop to increase the thread priority if the need_resched
> flag is set. Only an interrupt routine can increase the thread priority.
> Else we will need to do it explicitly. And in such states which have a
> polling nature, the cpu will not receive a reschedule IPI.
> 
> That is why in the snooze_loop() we poll on need_resched. If it is set
> we up the priority of the thread using HMT_MEDIUM() and then exit the
> my_idle() loop. In case of interrupts, the priority gets automatically
> increased.

You can poll without setting TS_POLLING/TIF_POLLING_NRFLAGS just fine
and get the IPI if that is what you want.

Depending on how horribly unprovisioned the thread gets at the lowest
priority, that might actually be faster than polling and raising the
prio whenever it does get ran.
