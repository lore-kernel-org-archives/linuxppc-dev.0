To: jon@eccincorp.com
Cc: Embedded Linux Forum <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Interrupt Latency 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 12 Jun 2002 14:50:32 EDT."
             <3D0797F8.4030100@eccincorp.com>
Date: Wed, 12 Jun 2002 22:16:14 +0200
Message-Id: <20020612201619.CA2DF102F8@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jon,

in message <3D0797F8.4030100@eccincorp.com> you wrote:
>
> I have an Embedded Planet RPX Classic CLLF_BW31 MPC860 running at 48Mhz with
> non-realtime Hard Hat 1.2 with the 2.2.14 kernel.
>
> In general what kind of interrupt latency can I expect?  I am seeing a pretty
> consistent 10 us min IRQ2 latency but occassionally see up to 70 us max.  I am

This is about what you can get on such a CPU.

Even with RTAI, running the latency calibration test,  you  will  see
average latencies af some 14 us.

> running ISR2.  First, I was surprised the 10 us min latency, I thought I might
> occassionally see a much quicker response.  Second, I was surprised to see the

What do you expect? This is just a 50 MHz system  with  tiny  caches.
This is not the fast number-cruncher you seem to expect...

> occassional slow response of 70 us max.  It would be nice if we could get the
> max under 50 us.  Or do you have to go to a real-time kernel?  I am looking into

Yes, if you need guaranteed response times you have to use a hard  RT
capable system; my recommendation is RTAI.

> and checking the driver code efficiency.  Could the non-realtime linux kernel
> mask the interrupts for that long?  I am going to look into what all linux is

Sure it can.

Latencies scale more or less with the clock frequency; CPU clock, bus
clock and cache size have visible impact. Here are  some  results  we
got when running the RTAI latency test on a couple of systems:

IBM PowerPC 405GP Rev. D at 198 MHz 16 kB I-Cache 8 kB D-Cache:

	Interrupt latency approx.  5.9 us

MPC855 at 80 MHz / 40 MHz bus clock  4 kB I-Cache 4 kB D-Cache:

	Interrupt latency approx. 22.0 us

MPC860DP at 50 MHz / 50 MHz bus clock  16 kB I-Cache 8 kB D-Cache:

	Interrupt latency approx. 16.0 us

MPC8240 at 247.500 MHz 16 kB I-Cache 16 kB D-Cache:

	Interrupt latency approx.  4.5 us

MPC8260 at 199.999 MHz

	Interrupt latency approx.  4.0 us

PowerPC 750 @ 300 Mhz:

	Interrupt latency approx.  3.0 us

PowerPC 750 at 450 MHz 1 MB L2-Cache

	Interrupt latency approx.  1.5 us


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"I've finally learned what `upward compatible' means. It means we get
to keep all our old mistakes." - Dennie van Tassel

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
