Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2001:470:1f0b:db:abcd:42:0:1])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2AA062C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Nov 2013 01:40:11 +1100 (EST)
Date: Fri, 29 Nov 2013 15:39:37 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [PATCH V4 7/9] cpuidle/powernv: Add "Fast-Sleep" CPU idle
 state
In-Reply-To: <20131129104319.651.29563.stgit@preeti.in.ibm.com>
Message-ID: <alpine.DEB.2.02.1311291301300.30673@ionos.tec.linutronix.de>
References: <20131129104010.651.23117.stgit@preeti.in.ibm.com>
 <20131129104319.651.29563.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org,
 shangw@linux.vnet.ibm.com, rjw@sisk.pl, paulmck@linux.vnet.ibm.com,
 arnd@arndb.de, linux-pm@vger.kernel.org, rostedt@goodmis.org,
 michael@ellerman.id.au, john.stultz@linaro.org, chenhui.zhao@freescale.com,
 deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 29 Nov 2013, Preeti U Murthy wrote:
> +static enum hrtimer_restart handle_broadcast(struct hrtimer *hrtimer)
> +{
> +	struct clock_event_device *bc_evt = &bc_timer;
> +	ktime_t interval, next_bc_tick, now;
> +
> +	now = ktime_get();
> +
> +	if (!restart_broadcast(bc_evt))
> +		return HRTIMER_NORESTART;
> +
> +	interval = ktime_sub(bc_evt->next_event, now);
> +	next_bc_tick = get_next_bc_tick();

So you're seriously using a hrtimer to poll in HZ frequency for
updates of bc->next_event?

To be honest, this design sucks.

First of all, why is this a PPC specific feature? There are probably
other architectures which could make use of this. So this should be
implemented in the core code to begin with.

And a lot of the things you need for this are already available in the
core in one form or the other.

For a start you can stick the broadcast hrtimer to the cpu which does
the timekeeping. The handover in the hotplug case is handled there as
well as is the handover for the NOHZ case.

This needs to be extended for this hrtimer broadcast thingy to work,
but it shouldn't be that hard to do so.

Now for the polling. That's a complete trainwreck.

This can be solved via the broadcast IPI as well. When a CPU which
goes down into deep idle sets the broadcast to expire earlier than the
active value it can denote that and send the timer broadcast IPI over
to the CPU which has the honour of dealing with this.

This supports HIGHRES and NO_HZ if done right, without polling at
all. So you can even let the last CPU which handles the broadcast
hrtimer go for a long sleep, just not in the deepest idle state.

Thanks,

	tglx
