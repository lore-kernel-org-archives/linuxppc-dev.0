Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e33.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FD302C00A6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Dec 2013 02:10:35 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 2 Dec 2013 08:10:32 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id AFBB819D803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Dec 2013 08:10:23 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with
 ESMTP id rB2D8PKX3080550
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Dec 2013 14:08:25 +0100
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rB2FARoo027114
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Dec 2013 08:10:29 -0700
Message-ID: <529CA219.20109@linux.vnet.ibm.com>
Date: Mon, 02 Dec 2013 20:37:05 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V4 7/9] cpuidle/powernv: Add "Fast-Sleep" CPU idle state
References: <20131129104010.651.23117.stgit@preeti.in.ibm.com>
 <20131129104319.651.29563.stgit@preeti.in.ibm.com>
 <alpine.DEB.2.02.1311291301300.30673@ionos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.02.1311291301300.30673@ionos.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: michael@ellerman.id.au, r58472@freescale.com, shangw@linux.vnet.ibm.com,
 arnd@arndb.de, linux-pm@vger.kernel.org, geoff@infradead.org,
 fweisbec@gmail.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 deepthi@linux.vnet.ibm.com, rjw@sisk.pl, paul.gortmaker@windriver.com,
 paulus@samba.org, srivatsa.bhat@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
 john.stultz@linaro.org, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thomas,

On 11/29/2013 08:09 PM, Thomas Gleixner wrote:
> On Fri, 29 Nov 2013, Preeti U Murthy wrote:
>> +static enum hrtimer_restart handle_broadcast(struct hrtimer *hrtimer)
>> +{
>> +	struct clock_event_device *bc_evt = &bc_timer;
>> +	ktime_t interval, next_bc_tick, now;
>> +
>> +	now = ktime_get();
>> +
>> +	if (!restart_broadcast(bc_evt))
>> +		return HRTIMER_NORESTART;
>> +
>> +	interval = ktime_sub(bc_evt->next_event, now);
>> +	next_bc_tick = get_next_bc_tick();
> 
> So you're seriously using a hrtimer to poll in HZ frequency for
> updates of bc->next_event?
> 
> To be honest, this design sucks.
> 
> First of all, why is this a PPC specific feature? There are probably
> other architectures which could make use of this. So this should be
> implemented in the core code to begin with.
> 
> And a lot of the things you need for this are already available in the
> core in one form or the other.
> 
> For a start you can stick the broadcast hrtimer to the cpu which does
> the timekeeping. The handover in the hotplug case is handled there as
> well as is the handover for the NOHZ case.
> 
> This needs to be extended for this hrtimer broadcast thingy to work,
> but it shouldn't be that hard to do so.
> 
> Now for the polling. That's a complete trainwreck.
> 
> This can be solved via the broadcast IPI as well. When a CPU which
> goes down into deep idle sets the broadcast to expire earlier than the
> active value it can denote that and send the timer broadcast IPI over
> to the CPU which has the honour of dealing with this.
> 
> This supports HIGHRES and NO_HZ if done right, without polling at
> all. So you can even let the last CPU which handles the broadcast
> hrtimer go for a long sleep, just not in the deepest idle state.

Thank you for the review. The above points are all valid. I will rework
the design to:

1. Eliminate the concept of a broadcast CPU and integrate its
functionality in the timekeeping CPU.

2. Avoid polling by using IPIs to communicate the next wakeup of the
CPUs in deep idle state so as to reprogram the broadcast hrtimer.

3. Make this feature generic and not arch-specific.

Regards
Preeti U Murthy
> 
> Thanks,
> 
> 	tglx
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
