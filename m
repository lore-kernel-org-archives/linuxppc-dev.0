Message-ID: <384D4294.E868F70B@netx4.com>
Date: Tue, 07 Dec 1999 12:23:32 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: FEC ERROR 41200000 on CLLF-860T
References: <19991207070538.5A4B9118F0@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:

> .... I notice that the fec driver in the 2.3.18
> kernel is a little different, but I haven't managed to get that kernel to run
> at all yet, so I'm hanging with 2.2.13 at least for now.

Yes, I have learned the importance of being able to start and
shutdown network drivers (the SCC doesn't do this).  The FEC also
has to be configured for half/full duplex, and this we must get
the link change interrupts to detect this.  If you never disconnect
the Ethernet, this wouldn't be necessary, but that isn't real
life.  The drivers are changing to accomodate all of these things.


> Hmmm... performance tests are something I'm thinking about trying pretty soon!

Keep in mind that both the SCC and FEC Ethernet can send and
receive back-to-back packets.  They also have some tuning parameters
for things like backoff timers to be more friendly on the network,
and for SDMA system performance.  The SCC Ethernet on a 50 MHz 860
can easily maintain the theoretical network limits between 8
and 9 Mbit/sec with the TCP/IP stack.

I could never understand why people use this as a "benchmark"
as it is more important what you do with the data when you
receive it or before you send it.  This is a function of your
task and the speed of the processor.  There are no bounded
latency guarantees or predictable behavior with Ethernet, so
why try to use it like that?

The SCC and FEC will send packets as fast as you can create them,
and will discard packets if you can't keep up.  They provide
efficient burst mode DMA and off load the PPC core.  What more
do you need to know?


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
