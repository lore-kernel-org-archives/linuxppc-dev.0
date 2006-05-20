Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B0DFB679E1
	for <linuxppc-dev@ozlabs.org>; Sun, 21 May 2006 09:57:05 +1000 (EST)
Subject: Re: snd-aoa status update / automatic driver loading
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1148034127.15507.178.camel@johannes>
References: <1147860564.14395.6.camel@johannes>
	<446B721D.8020203@gentoo.org>  <1148034127.15507.178.camel@johannes>
Content-Type: text/plain
Date: Sun, 21 May 2006 09:56:28 +1000
Message-Id: <1148169389.13249.44.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Berg <benjamin@sipsolutions.net>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Alternatively we could use the register just to detect if we lost
> interrupts, i.e. calculate how many frames we have per period and then
> see if the frame count increased approximately by that much (I've seen
> +- a few frames probably due to timing, with higher samplerates we'll
> probably see a bit more error) and if it increased by much more we could
> estimate how many interrupts we lost. What do you think?

What do you mean by lost interrupts ?

DBDMA sends edge interrupts. Thus, if it emits interrupts A, then B and
C, and for any reason, your kenrel is not able to service interrupts (is
doing something with IRQs disabled) from before B happens to after C
happens, you'll indeed get called only twice (A and C) and "B" will be
sort-of lost.

First thing about that is: what the heck is causing us to have such a
latency !!! that would be useful to figure out. A way to do that would
be maybe to "detect" when C happens that we missed B (see below how to
do that) and print something along with the regs->nip & lr (or even a
backtrace). That might give us an idea of there interrupts are
re-enabled after the long latency which could perhaps lead us to the
cause of the latency.

Now for detecting lost interrupts (and for being immune to them), the
technique is not to just assume IRQ -> 1 period completed, but instead,
when an irq happens, to go read the DBDMA descriptors in memory to see
which ones have actually been completed. Their status field should be
updated as their get comleted. Thus, you keep track of the "previous"
last completed descriptor and you walk from that to recycle them.

Since we can only update the framecounter on a per-period basis, the
driver would benefit from having lots of very small periods. I don't
know if we can provide "hints" to userland about that though. Using the
i2s frame counter means we need some kind of calibration... it might
still be counting if for the reason the DBDMA "misses" something or gets
stopped....

Ben.
