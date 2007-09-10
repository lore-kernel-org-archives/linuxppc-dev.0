Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 72951DDDF2
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Sep 2007 19:09:43 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 10 Sep 2007 11:09:35 +0200
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH 1/2] Basic generic time/clocksource code for PowerPC
Message-ID: <20070910090935.GA14769@iram.es>
References: <18144.4514.601900.881855@cargo.ozlabs.ibm.com>
	<20070906165535.GA11420@iram.es>
	<20070906170123.GA17990@ld0162-tx32.am.freescale.net>
	<20070906170547.GA12432@iram.es>
	<20070906172415.GA18226@ld0162-tx32.am.freescale.net>
	<20070907082143.GA27058@iram.es>
	<18147.49943.182399.64990@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18147.49943.182399.64990@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Sep 09, 2007 at 07:55:35PM +1000, Paul Mackerras wrote:
> Gabriel Paubert writes:
> 
> > The solution now used by i386/x86-64/sparc64 is
> > CONFIG_GENERIC_CMOS_UPDATE. Maybe powerpc should be switched
> > to use something similar, but the generic code has some
> 
> Yes.  I'll turn on CONFIG_GENERIC_CMOS_UPDATE.  Do you think it needs
> to be a config option that can be turned on and off in the kernel
> config, or should it just be always on as on x86[-64]?

I believe that it can be turned on systematically. But 
I only have 32 bit, non HV machines (basically 603e, 750, 
and 74xx processors).

> 
> > problems (it assumes that you have to set the clock
> > on a half-second, which is not the case of the RTC on 
> > my boards to start with).
> 
> Let's get the generic code fixed to do what we need then.  Care to
> send a patch?

I'm unsure on how to implement it in a way acceptable
upstream, the problem is that the following lines:

	if (abs(xtime.tv_nsec - (NSEC_PER_SEC / 2)) <= tick_nsec / 2)
		fail = update_persistent_clock(now);

        next.tv_nsec = (NSEC_PER_SEC / 2) - now.tv_nsec;

are hardwired to half a second. Can it be transformed into
a per arch static inline function defined in asm-${arch}?

There is also a possible problem in notify_cmos_timer, I believe
that the logic is wrong and the condition is reversed and should
be "if (!no_sync_cmos_clock)". 

Otherwise the clock update timer will never be started! This boolean 
really should be called disable_persistent_clock_updates or something 
similar. 

I'm really wondering how much testing all this code has had. The 
more I look at the timekeeping code changes in the last months, 
the less I understand them.

	Gabriel
