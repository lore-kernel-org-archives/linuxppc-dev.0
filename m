Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 27DDDDDEA0
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 19:44:58 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Fri, 19 Oct 2007 11:22:05 +0200
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
Message-ID: <20071019092205.GA9668@iram.es>
References: <20070921032603.0D3EA32C887@thor> <4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
	<47161D79.6000003@ru.mvista.com>
	<18198.43687.44059.477047@cargo.ozlabs.ibm.com>
	<47177229.2030200@ru.mvista.com>
	<18199.63230.583536.307945@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18199.63230.583536.307945@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, Thomas Gleixner <tglx@linutronix.de>,
	Realtime Kernel <linux-rt-users@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 10:14:54AM +1000, Paul Mackerras wrote:
> Sergei Shtylyov writes:
> 
> > > What problem do you see arising from this?
> > 
> >     Timers firing too early.
> 
> Only if the minimum interrupt latency is less than 1 decrementer
> tick.  That seems pretty unlikely to me unless you have a very slow
> timebase frequency.
> 
> In fact what we should program the decrementer to is:
> 
> 	timeout - (is_booke? 0: 1) - min_interrupt_latency
> 
> I was assuming that min_interrupt_latency (measured in timebase ticks)
> would be at least 1, but apparently some systems can have a timebase
> frequency as low as 1kHz, so we'll have to have an ifdef or something.

If it is the case (the slowest I've seen was in the 8 MHz range), then
it is better not to subtract the one: think of what happens when you
have say, a 10kHz timebase/decrementer frequency and you want to
interrupt after 1 ms. You actually want to interrupt after 11
transitions of the decrementer, not 10 since the result could be
as low as 900us if you happen to read the timebase just before
a transition.

I'd really wish there were a guarantee of a minimum timebase 
frequency, for anything above ~10MHz, we are splitting hairs
about an off-by-one error that never accumulates, but if systems
with very low TB freq exist, you have to be very careful. In any case
timer interrupts should never came earlier than asked for.

	Gabriel
