Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E5DEC2C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 12:42:54 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 26 Jul 2013 12:35:57 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D92083578055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 12:42:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6Q2QRBr30343196
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 12:26:43 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r6Q2fqgE019900
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 12:41:53 +1000
Message-ID: <51F1E15B.3050106@linux.vnet.ibm.com>
Date: Fri, 26 Jul 2013 08:09:23 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [RFC PATCH 4/5] cpuidle/ppc: CPU goes tickless if there are no
 arch-specific constraints
References: <20130725090016.12500.28888.stgit@preeti.in.ibm.com>
 <20130725090302.12500.42998.stgit@preeti.in.ibm.com>
 <20130725133044.GA7400@somewhere>
In-Reply-To: <20130725133044.GA7400@somewhere>
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

On 07/25/2013 07:00 PM, Frederic Weisbecker wrote:
> On Thu, Jul 25, 2013 at 02:33:02PM +0530, Preeti U Murthy wrote:
>> In the current design of timer offload framework, the broadcast cpu should
>> *not* go into tickless idle so as to avoid missed wakeups on CPUs in deep idle states.
>>
>> Since we prevent the CPUs entering deep idle states from programming the lapic of the
>> broadcast cpu for their respective next local events for reasons mentioned in
>> PATCH[3/5], the broadcast CPU checks if there are any CPUs to be woken up during
>> each of its timer interrupt programmed to its local events.
>>
>> With tickless idle, the broadcast CPU might not get a timer interrupt till after
>> many ticks which can result in missed wakeups on CPUs in deep idle states. By
>> disabling tickless idle, worst case, the tick_sched hrtimer will trigger a
>> timer interrupt every period to check for broadcast.
>>
>> However the current setup of tickless idle does not let us make the choice
>> of tickless on individual cpus. NOHZ_MODE_INACTIVE which disables tickless idle,
>> is a system wide setting. Hence resort to an arch specific call to check if a cpu
>> can go into tickless idle.
> 
> Hi Preeti,
> 
> I'm not exactly sure why you can't enter the broadcast CPU in dynticks idle mode.
> I read in the previous patch that's because in dynticks idle mode the broadcast
> CPU deactivates its lapic so it doesn't receive the IPI. But may be I misunderstood.
> Anyway that's not good for powersaving.

Let me elaborate. The CPUs in deep idle states have their lapics
deactivated. This means the next timer event which would typically have
been taken care of by a lapic firing at the appropriate moment does not
get taken care of in deep idle states, due to the lapic being switched off.

Hence such CPUs offload their next timer event to the broadcast CPU,
which should *not* enter deep idle states. The broadcast CPU has the
responsibility of waking the CPUs in deep idle states.

*The lapic of a broadcast CPU is active always*. Say CPUX, wants the
broadcast CPU to wake it up at timeX.  Since we cannot program the lapic
of a remote CPU, CPUX will need to send an IPI to the broadcast CPU,
asking it to program its lapic to fire at timeX so as to wake up CPUX.
*With multiple CPUs the overhead of sending IPI, could result in
performance bottlenecks and may not scale well.*

Hence the workaround is that the broadcast CPU on each of its timer
interrupt checks if any of the next timer event of a CPU in deep idle
state has expired, which can very well be found from dev->next_event of
that CPU. For example the timeX that has been mentioned above has
expired. If so the broadcast handler is called to send an IPI to the
idling CPU to wake it up.

*If the broadcast CPU, is in tickless idle, its timer interrupt could be
many ticks away. It could miss waking up a CPU in deep idle*, if its
wakeup is much before this timer interrupt of the broadcast CPU. But
without tickless idle, atleast at each period we are assured of a timer
interrupt. At which time broadcast handling is done as stated in the
previous paragraph and we will not miss wakeup of CPUs in deep idle states.

Yeah it is true that not allowing the broadcast CPU to enter tickless
idle is bad for power savings, but for the use case that we are aiming
at in this patch series, the current approach seems to be the best, with
minimal trade-offs in performance, power savings, scalability and no
change in the broadcast framework that exists today in the kernel.

> 
> Also when an arch wants to prevent a CPU from entering dynticks idle mode, it typically
> use arch_needs_cpu(). May be that could fit for you as well?

Oh ok thanks :) I will look into this and get back on if we can use it.

Regards
Preeti U Murthy
