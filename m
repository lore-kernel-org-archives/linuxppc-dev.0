Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp02.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC9122C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 14:14:53 +1000 (EST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 26 Jul 2013 09:35:21 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EAD60E0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 09:44:04 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6Q4Er2Z20250638
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 09:44:56 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6Q4DvFe007041
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 14:13:58 +1000
Message-ID: <51F1F6F9.1050102@linux.vnet.ibm.com>
Date: Fri, 26 Jul 2013 09:41:37 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [RFC PATCH 4/5] cpuidle/ppc: CPU goes tickless if there are no
 arch-specific constraints
References: <20130725090016.12500.28888.stgit@preeti.in.ibm.com>
 <20130725090302.12500.42998.stgit@preeti.in.ibm.com>
 <20130725133044.GA7400@somewhere> <51F1E15B.3050106@linux.vnet.ibm.com>
In-Reply-To: <51F1E15B.3050106@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: deepthi@linux.vnet.ibm.com, shangw@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, geoff@infradead.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, rjw@sisk.pl, paul.gortmaker@windriver.com,
 paulus@samba.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
 john.stultz@linaro.org, tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Frederic,

I apologise for the confusion. As Paul pointed out maybe the usage of
the term lapic is causing a large amount of confusion. So please see the
clarification below. Maybe it will help answer your question.

On 07/26/2013 08:09 AM, Preeti U Murthy wrote:
> Hi Frederic,
> 
> On 07/25/2013 07:00 PM, Frederic Weisbecker wrote:
>> On Thu, Jul 25, 2013 at 02:33:02PM +0530, Preeti U Murthy wrote:
>>> In the current design of timer offload framework, the broadcast cpu should
>>> *not* go into tickless idle so as to avoid missed wakeups on CPUs in deep idle states.
>>>
>>> Since we prevent the CPUs entering deep idle states from programming the lapic of the
>>> broadcast cpu for their respective next local events for reasons mentioned in
>>> PATCH[3/5], the broadcast CPU checks if there are any CPUs to be woken up during
>>> each of its timer interrupt programmed to its local events.
>>>
>>> With tickless idle, the broadcast CPU might not get a timer interrupt till after
>>> many ticks which can result in missed wakeups on CPUs in deep idle states. By
>>> disabling tickless idle, worst case, the tick_sched hrtimer will trigger a
>>> timer interrupt every period to check for broadcast.
>>>
>>> However the current setup of tickless idle does not let us make the choice
>>> of tickless on individual cpus. NOHZ_MODE_INACTIVE which disables tickless idle,
>>> is a system wide setting. Hence resort to an arch specific call to check if a cpu
>>> can go into tickless idle.
>>
>> Hi Preeti,
>>
>> I'm not exactly sure why you can't enter the broadcast CPU in dynticks idle mode.
>> I read in the previous patch that's because in dynticks idle mode the broadcast
>> CPU deactivates its lapic so it doesn't receive the IPI. But may be I misunderstood.
>> Anyway that's not good for powersaving.

Firstly, when CPUs enter deep idle states, their local clock event
devices get switched off. In the case of powerpc, local clock event
device is the decrementer. Hence such CPUs *do not get timer interrupts*
but are still *capable of taking IPIs.*

So we need to ensure that some other CPU, in this case the broadcast
CPU, makes note of when the timer interrupt of the CPU in such deep idle
states is to trigger and at that moment issue an IPI to that CPU.

*The broadcast CPU however should have its decrementer active always*,
meaning it is disallowed from entering deep idle states, where the
decrementer switches off, precisely because the other idling CPUs bank
on it for the above mentioned reason.

> *The lapic of a broadcast CPU is active always*. Say CPUX, wants the
> broadcast CPU to wake it up at timeX.  Since we cannot program the lapic
> of a remote CPU, CPUX will need to send an IPI to the broadcast CPU,
> asking it to program its lapic to fire at timeX so as to wake up CPUX.
> *With multiple CPUs the overhead of sending IPI, could result in
> performance bottlenecks and may not scale well.*

Rewording the above. The decrementer of the broadcast CPU is active
always. Since we cannot program the clock event device
of a remote CPU, CPUX will need to send an IPI to the broadcast CPU,
(which the broadcast CPU is very well capable of receiving), asking it
to program its decrementer to fire at timeX so as to wake up CPUX
*With multiple CPUs the overhead of sending IPI, could result in
performance bottlenecks and may not scale well.*

> 
> Hence the workaround is that the broadcast CPU on each of its timer
> interrupt checks if any of the next timer event of a CPU in deep idle
> state has expired, which can very well be found from dev->next_event of
> that CPU. For example the timeX that has been mentioned above has
> expired. If so the broadcast handler is called to send an IPI to the
> idling CPU to wake it up.
> 
> *If the broadcast CPU, is in tickless idle, its timer interrupt could be
> many ticks away. It could miss waking up a CPU in deep idle*, if its
> wakeup is much before this timer interrupt of the broadcast CPU. But
> without tickless idle, atleast at each period we are assured of a timer
> interrupt. At which time broadcast handling is done as stated in the
> previous paragraph and we will not miss wakeup of CPUs in deep idle states.
> 
> Yeah it is true that not allowing the broadcast CPU to enter tickless
> idle is bad for power savings, but for the use case that we are aiming
> at in this patch series, the current approach seems to be the best, with
> minimal trade-offs in performance, power savings, scalability and no
> change in the broadcast framework that exists today in the kernel.
> 

Regards
Preeti U Murthy
