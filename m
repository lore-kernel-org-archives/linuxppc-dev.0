Subject: Re: FEC ERROR 41200000 on CLLF-860T
To: dan@netx4.com (Dan Malek)
Date: Thu, 9 Dec 1999 11:24:42 +1100 (EST)
Cc: greyham@research.canon.com.au, linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <384D4294.E868F70B@netx4.com> from "Dan Malek" at Dec 7, 99 12:23:32 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Message-Id: <19991209002442.41D86118CD@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek writes:
> The drivers are changing to accomodate all of these things.

Sounds great; I'd be interested in testing an update whenever it's doable.

> The SCC Ethernet on a 50 MHz 860 can easily maintain the theoretical network
> limits between 8 and 9 Mbit/sec with the TCP/IP stack.

We're using the FEC exclusively, and I'm hoping for a similar story at around
8 Mbytes/sec with the TCP/IP stack.

> I could never understand why people use this as a "benchmark"
> as it is more important what you do with the data when you
> receive it or before you send it.  This is a function of your
> task and the speed of the processor.  There are no bounded
> latency guarantees or predictable behavior with Ethernet, so
> why try to use it like that?

You're absolutely right, of course: what matters here is system throughput in
which the Ethernet is just one link. Our system is heavily pipelined all the
way from the remote application down to the lowest hardware level. So long as
none of the links in the pipeline stalls long enough to become the bottleneck,
all the data should fly through nicely. Buffering in the various pipeline
stages (including the TCP/IP buffers) affects how far a stall will propagate
back up the pipeline. As you say, the important part here is what we do with
the data when we receive it and before we send it; if we get that right, the
ethernet link throughput will fall out in the wash.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
