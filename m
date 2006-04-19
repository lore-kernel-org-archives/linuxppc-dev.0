Return-Path: <markc@mail.com>
Received: from smtp1.us4.outblaze.com (smtp1.us4.outblaze.com [205.158.62.78])
	by ozlabs.org (Postfix) with SMTP id CF6A1679E7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Apr 2006 23:46:01 +1000 (EST)
Message-ID: <006401c663b7$903a9080$6401a8c0@CHUCK2>
From: "Mark Chambers" <markc@mail.com>
To: "Kenneth Poole" <kpoole@mrv.com>,
	<linuxppc-embedded@ozlabs.org>
References: <4D8794260B62C940BBA7150CC5EB3BD432D423@bosmail.BOS.int.mrv.com>
Subject: Re: kernel access of bad area, sig: 11 ( mpc852t)
Date: Wed, 19 Apr 2006 09:45:45 -0400
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

kernel access of bad area, sig: 11 ( mpc852t)>>> board.The kernel
>>> panics randomly with sig 11.

>We have been experiencing this same issue with random boards in production. 
>The exact same version of software will run for months on other >instances 
>of the exact same board design, but a few percent get 'random' trap 300s. 
>When they do occur, it's only after Linux has booted and >address 
>translation and caching are turned on. Examining the oops-es and memory 
>shows that some location in SDRAM has a bogus value, >but I don't have the 
>tools to trace back how it got that way.
>I have ported a rigorous moving-inversions memory test into our firmware, 
>and have run it extensively across the entire SDRAM address >space (the 
>test code executes from flash). I have let this test run continuously for 
>hours and hours, but never found a memory problem. >Unfortunately, I do not 
>have test software that enables the MMU address translation or caching, so 
>as Mark said, I can't test memory using >bursting. Our hardware engineers 
>have reviewed the designs very carefully and are quite confident that there 
>is plenty of margin in the memory >timing. Signal quality has also been 
>carefully checked.

Ouch!  Yeah, these are the tough ones, the intermittent ones.  You can, btw, 
force a burst cycle using the RUN
command in the MCR, similar to what you do to generate a few refreshes when 
configuring the DRAM.  And
you can easily enable the cache for testing and then you'll get bursts (I 
don't think MMU will have any effect).
A burst is not so much different from other cycles, so I don't think 
bursting per se is what causes problems when
the kernel starts.  I think it has more to do with the increased randomness 
of accesses with multitasking and
cacheing and all that.

>Our manufacturing people have replaced the CPU on some of these boards, and 
>the problem went away.

It also seems to me that the cache is the most delicate bit of logic in the 
852.  So if you have ground noise or
problems on the 1.8V rail it will likely show up in the cache - I had 
hardware problems where I could
track it down to a mismatch between the cache line and memory (and the scope 
showed the read burst to
be fine).  Also look closely at the PLL circuit - it can work both ways, the 
PLL can inject noise back into
the unfiltered supply (I use a ferrite instead of the inductor that 
Freescale recommends).

That's my $.02 :-)

Mark C.
