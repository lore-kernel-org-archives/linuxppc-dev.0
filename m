Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18200.37750.627398.669482@cargo.ozlabs.ibm.com>
Date: Fri, 19 Oct 2007 21:22:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH v2 3/4] Implement clockevents driver for powerpc
In-Reply-To: <20071019092205.GA9668@iram.es>
References: <20070921032603.0D3EA32C887@thor> <4713A616.3090103@ru.mvista.com>
	<18195.64334.985238.848522@cargo.ozlabs.ibm.com>
	<47161D79.6000003@ru.mvista.com>
	<18198.43687.44059.477047@cargo.ozlabs.ibm.com>
	<47177229.2030200@ru.mvista.com>
	<18199.63230.583536.307945@cargo.ozlabs.ibm.com>
	<20071019092205.GA9668@iram.es>
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

Gabriel Paubert writes:

> I'd really wish there were a guarantee of a minimum timebase 
> frequency, for anything above ~10MHz, we are splitting hairs
> about an off-by-one error that never accumulates, but if systems
> with very low TB freq exist, you have to be very careful.

Exactly.  In looking through the generic clockevents code, there are a
few places where counts are rounded down.  For example,
clockevents_program_event does this to convert from nanoseconds (in
"delta") to the count value for the clock event device:

	clc = delta * dev->mult;
	clc >>= dev->shift;

Here the right shift can lose up to a whole count.  If the clock
frequency of the device is very slow, say 1kHz, then this could lose
up to 999999 nanoseconds.  Then, on Book E, putting 1 into the
decrementer could result in an interrupt anywhere from straight away to
1 millisecond later (assuming 1kHz timebase frequency, again).

The net result is that delta = 1999999 nanoseconds could result in the
interrupt coming in immediately, i.e. almost 2ms early.

I believe the clockevents framework has not been designed for use with
very slow one-shot clock event devices.  If it is to be used with very
low clock rates, then there are several points where I think the
rounding/truncation issues need to be carefully thought through.

In any case, the code we have at the moment won't work with timebase
clock rates below 15.258kHz, because decrementer_clockevent.mult will
become zero.

Regards,
Paul.
