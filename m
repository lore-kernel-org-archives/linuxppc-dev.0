Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E47C8B70AF
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 08:47:28 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E6ECDDD1B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 08:47:28 +1000 (EST)
Subject: Re: Missing some interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: wael showair <showair2003@yahoo.com>
In-Reply-To: <23901807.post@talk.nabble.com>
References: <23901807.post@talk.nabble.com>
Content-Type: text/plain
Date: Sun, 07 Jun 2009 08:47:22 +1000
Message-Id: <1244328442.31984.45.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2009-06-06 at 06:17 -0700, wael showair wrote:
> Hi All,
> i have a freescale board, that contains MPC8555 processor & DSP-core
> there is a GPIO connecting the DSP-core into an input pin of the OpenPIC of
> the MPC8555 processor.
> 
> i test one interrupt from the DSP-core to the MPC8555 processor where i
> configure this interrupt line to be edge-triggered (falling edge) & i
> receive it successfully 
> but 
> when i generate this interrupt 10 successive times using for loop
> i just receive 2 interrupts?
> 
> why can't i receive the 8 other interrupts?
> i print the value of every irq number inside do_IRQ & i found that i receive
> the DSP-interrupt just only twice.

That sounds normal... It all depends what you are doing in the interrupt
handler. If you are doing something for too long, you will "miss" some
interrupts, but that isn't necessarily a problem.

You cannot really rely on getting the exact same number of edge
interrupts that were emitted. At least not unless you have a hard RT
system and can guarantee that you'll always dequeue them fast enough.

Basically, what happens is that in a PIC like the MPIC, if one edge
interrupt is latched, and another one arrives before that first one has
been acked, then the second one is "subsumed", ie, there's only one
input latch.

That should however not be a problem if your driver is written properly.
The idea is that when you get the interrupt, you need to check your
device for -all- the work to do, not only one "item". For example, if
the device fills a ring buffer, you need to check for more than one
entry in there.

The only guarantee you have is that the interrupt will have been acked
before your handler is called. So if another interrupt happens while
your handler is running, you -will- be called again. So you don't need
to worry too much about racing with new incoming messages inside the
interrupt handler itself. But you need to be prepared to pick up more
than one item of work... whatever that is.

Cheers,
Ben.
