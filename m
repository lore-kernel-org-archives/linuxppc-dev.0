Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 85A1B2C00F1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 13:06:20 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 26 Jul 2013 08:28:01 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 678A6E0055
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 08:36:06 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6Q35wQF32243842
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 08:35:58 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6Q3603S031544
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jul 2013 13:06:01 +1000
Message-ID: <51F1E70C.1020408@linux.vnet.ibm.com>
Date: Fri, 26 Jul 2013 08:33:40 +0530
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
> 
> Also when an arch wants to prevent a CPU from entering dynticks idle mode, it typically
> use arch_needs_cpu(). May be that could fit for you as well?

Yes this will suit our requirement perfectly. I will note down this
change for the next version of this patchset. Thank you very much for
pointing this out :)

Regards
Preeti U Murthy
