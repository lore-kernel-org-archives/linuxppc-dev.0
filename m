Message-Id: <4.3.2.20010711154256.00c59320@falcon.si.com>
Date: Wed, 11 Jul 2001 16:30:19 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jerry Van Baren <vanbaren_gerald@si.com>
Subject: Re: How fast should a bogomip be
In-Reply-To: <Pine.LNX.3.95.1010711084748.21073D-100000@november.bhjjh.e
 rols.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Circumstantial evidence would indicate bogomips should go down by a
factor of 14.  On July 9, 2001, Andrew <anj@aps.anl.gov> sent a message
complaining about speed: he was running a 8240 (603e core) at 200MHz
without caches and getting a bogomips rating of 9.59 where he expected
133.  This matches my experience that caches are VERY important on
modern processors.  He later confirmed that his problem was that caches
were disabled.

Main memory speed is  VERY slow compared to the 100MHz or 200MHz core
clock rate.  Even with "PC133" or such SDRAM, which would lead you to
believe that it is fast memory, you have to look at latency, not just
the data clocking speed.  What you will find is that the initial
latency causes a substantial delay, and then it will burst the data at
bus speed (50MHz, 66MHz, or what have you).  Note also that the
bursting ONLY takes place if it is cached, which REALLY kills your
memory subsystem speed if you are running with caches disabled because
EVERY memory access causes the multiple clock cycle latency.

gvb


At 08:58 AM 7/11/01 -0400, Justin (Gus) Hurwitz wrote:

>First off- let me run for cover while saying that I know bogomips are
>relatively arbitrary numbers.
>
>I've seen numbers that indicate on 6xx series processors bogomips is
>usually about 2/3 the processor speed- so about 66.6 for a 100Mhz
>processor. I hope this is accurate, because that's what I'm getting.
>
>But, about what should I expect for a 6xx (603e) 100Mhz processor running
>without cache? I've been trying to disable cache so I can continue
>development until the kernel supports propper allocation of non-cacheable
>memory (on a 603e with broken memory controller). When I run the kernel
>with code changes that *should* disable the cache the bootup process does
>feel marginally slower, and bogomips goes down a whopping .64 (from 66.56
>to 65.92). It then crashes with a segfault in kupdated (when in _wake_up).
>And I've been scratching my head trying to figure out a) whether the
>caches are actually disabled b) what causes that segfault, and c) how the
>two are related.
>
>Any feedback it appreciated,
>--Gus
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
