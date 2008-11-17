Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADB48DDDF0
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 20:00:34 +1100 (EST)
Subject: Re: pmac_zilog debugging ...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Diggs <kevdig@hypersurf.com>
In-Reply-To: <49212D61.3080305@hypersurf.com>
References: <4914B549.9010805@hypersurf.com>
	<1226096603.13603.74.camel@pasglop> <491C11B2.1060909@hypersurf.com>
	<1226612654.7178.84.camel@pasglop> <491CAA32.20307@hypersurf.com>
	<1226624429.7178.105.camel@pasglop>  <49212D61.3080305@hypersurf.com>
Content-Type: text/plain
Date: Mon, 17 Nov 2008 20:00:22 +1100
Message-Id: <1226912422.7178.228.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> > Well, the main thing is that when using DMA, it doesn't need to wait for
> > the kernel to come fetch the bytes, and thus the only latency that
> > matters if the DMA list is appropriately provisioned is the bus latency,
> > which is much less likely to be an issue even with a small buffer.
> > 
> "... if the DMA list is appropriately provisioned ..." ???

Well, if you have some descriptors to available buffers :-) If you let
that run out too, then the chip will miss

> > It's definitely not a "basic" 8530, it's an ESCC but I don't think the
> > base rx buffer in polled mode is any bigger (I may be wrong).
> > 
> Any idea how we might find out?

Nope. Trial and error ? :-)
 
> I reinstalled the disk with 2.4.31 and reran the tests. With "nortscts" added to
> the pppd options macserial still works fine. Even at 115,200 it seemed fine (I
> expected to see some type of packet errors via pppstats or ifconfig). I did not,
> however, verify that pppd actually does something with this option.
> 
> I can't get pmac_zilog to work even at 1200 baud. That is pretty slow.

That's definitely strange. I would expect the kernel to be able to get
interrupts fast enough to service a 1200 bauds serial port. Maybe
there's something else wrong, or an other driver causing undue interrupt
latencies.... 

Out of curiosity, check that IDE properly unmasks interrupts (hdparm
-u1 /dev/hda).

> Ah! I think I get it. I was thinking that cpu intervention would be required after
> each byte. But the descriptors are more like linked commands for the DMA
> hardware.

Yes.

>  So, I'm on board with this approach. Since I don't really know what I am
> doing, how do you recommend I proceed?

Google for a document called MacTech.pdf which contains various
documentations for bits of the ancestor of the IO chip in your machine,
along with a description of the DBDMA engine :-) Something else you can
do is to look at how it's properly used by other drivers such as bmac
and look at some of the darwin source code for reference on how the HW
works.

> Would it be correct to say that DMA would also free the cpu from doing io accesses
> which are MUCH slower than normal memory acdcesses?

To a certain extent yes.

Cheers,
Ben.
