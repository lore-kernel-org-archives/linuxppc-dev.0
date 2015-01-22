Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A9ECF1A0E44
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 22:16:04 +1100 (AEDT)
Date: Thu, 22 Jan 2015 12:15:36 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V3] tick/broadcast: Make movement of broadcast hrtimer
 robust against hotplug
In-Reply-To: <54C09391.9080202@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.11.1501221209260.5526@nanos>
References: <20150120103559.8430.50933.stgit@preeti.in.ibm.com>
 <alpine.DEB.2.11.1501211243270.5526@nanos>
 <54C09391.9080202@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: aik@ozlabs.ru, shreyas@linux.vnet.ibm.com,
 LKML <linux-kernel@vger.kernel.org>, michael@ellerman.id.au,
 Peter Zijlstra <peterz@infradead.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 22 Jan 2015, Preeti U Murthy wrote:
> On 01/21/2015 05:16 PM, Thomas Gleixner wrote:
> How about when the cpu that is going offline receives a timer interrupt
> just before setting its state to CPU_DEAD ? That is still possible right
> given that its clock devices may not have been shutdown and it is
> capable of receiving interrupts for a short duration. Even with the
> above patch, is the following scenario possible ?
> 
>                 CPU0                                  CPU1
> t0         Receives timer interrupt
> 
> t1         Sees that there are hrtimers
>            to be serviced (hrtimers are not yet migrated)
> 
> t2         calls hrtimer_interrupt()
> 
> t3         tick_program_event()                   CPU_DEAD notifiers
>                                                 CPU0's td->evtdev = NULL
> 
> t4         clockevent_program_event()
>            references NULL tick device pointer
> 
> So my concern is that since the CLOCK_EVT_NOTIFY_CPU_DEAD callback
> handles shutting down of devices besides moving tick related duties.
> it's functions may race with the hotplug cpu still handling tick events.

  __cpu_disable() is supposed to block interrupts on the dying cpu.

But I agree, we should make it more robust. So we want an explicit
call for disabling the cpu local stuff and an explicit takeover of the
broadcast duty. I'm anyway distangling the clockevents_notify() stuff,
so it should be simple to do so.

Thanks,

	tglx
