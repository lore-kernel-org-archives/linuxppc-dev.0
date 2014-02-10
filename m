Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 998712C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 14:48:41 +1100 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 10 Feb 2014 09:18:37 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 6A9E61258053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 09:20:28 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1A3mWZa52428914
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 09:18:33 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1A3mYF9014108
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Feb 2014 09:18:34 +0530
Message-ID: <52F84B40.8090403@linux.vnet.ibm.com>
Date: Mon, 10 Feb 2014 09:15:04 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>,
 Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [PATCH 1/2] PPC: powernv: remove redundant cpuidle_idle_call()
References: <1391696188-14540-1-git-send-email-nicolas.pitre@linaro.org>
 <CAKnoXLxCAqKaniGOwegNcOarS4FpoNKDY5PxOhe6j4wdtUAkLQ@mail.gmail.com>
 <52F3BCFE.3010703@linux.vnet.ibm.com>
 <alpine.LFD.2.11.1402070105170.1906@knanqh.ubzr>
 <52F46EB3.5080403@linux.vnet.ibm.com>
 <alpine.LFD.2.11.1402071022490.1906@knanqh.ubzr>
 <52F4C666.4050308@linux.vnet.ibm.com>
 <20140207124140.GB9987@twins.programming.kicks-ass.net>
In-Reply-To: <20140207124140.GB9987@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>,
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

Hi Peter,

On 02/07/2014 06:11 PM, Peter Zijlstra wrote:
> On Fri, Feb 07, 2014 at 05:11:26PM +0530, Preeti U Murthy wrote:
>> But observe the idle state "snooze" on powerpc. The power that this idle
>> state saves is through the lowering of the thread priority of the CPU.
>> After it lowers the thread priority, it is done. It cannot
>> "wait_for_interrupts". It will exit my_idle(). It is now upto the
>> generic idle loop to increase the thread priority if the need_resched
>> flag is set. Only an interrupt routine can increase the thread priority.
>> Else we will need to do it explicitly. And in such states which have a
>> polling nature, the cpu will not receive a reschedule IPI.
>>
>> That is why in the snooze_loop() we poll on need_resched. If it is set
>> we up the priority of the thread using HMT_MEDIUM() and then exit the
>> my_idle() loop. In case of interrupts, the priority gets automatically
>> increased.
> 
> You can poll without setting TS_POLLING/TIF_POLLING_NRFLAGS just fine
> and get the IPI if that is what you want.
> 
> Depending on how horribly unprovisioned the thread gets at the lowest
> priority, that might actually be faster than polling and raising the
> prio whenever it does get ran.

So I am assuming you mean something like the below:

my_idle()
{
   local_irq_enable();
   /* Remove the setting of the polling flag */
   HMT_low();
   return index;
}

And then exit into the generic idle loop. But the issue I see here is
that the TS_POLLING/TIF_POLLING_NRFLAGS gets set immediately. So, if on
testing need_resched() immediately after this returns that the
TIF_NEED_RESCHED flag is set, the thread will exit at low priority right?
 We could raise the priority of the thread in arch_cpu_idle_exit() soon
after setting the polling flag but that would mean for cases where the
TIF_NEED_RESCHED flag is not set we unnecessarily raise the priority of
the thread.

Thanks

Regards
Preeti U Murthy

> 
