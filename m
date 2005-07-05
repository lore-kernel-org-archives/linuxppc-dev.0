Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao10.cox.net (fed1rmmtao10.cox.net [68.230.241.29])
	by ozlabs.org (Postfix) with ESMTP id A7D9067C7D
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 05:53:30 +1000 (EST)
Date: Tue, 5 Jul 2005 12:53:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Yuli Barcohen <yuli@arabellasw.com>
Message-ID: <20050705195328.GC6878@smtp.west.cox.net>
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
	<20050701101713.GC11121@logos.cnet>
	<1120244191.18872.3.camel@jmcmullan.timesys>
	<17096.61878.43282.752343@astp0002.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17096.61878.43282.752343@astp0002.localdomain>
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: mpc8xx and ld.so problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Jul 04, 2005 at 11:22:14AM +0300, Yuli Barcohen wrote:
> >>>>> Jason McMullan writes:
> 
> [...deleted...]
> 
>     Jason> Ha. Funny. The glibc powerpc maintainer doesn't want any
>     Jason> embedded fixes in the mainline. Last I checked, that was for
>     Jason> 'the tools vendors' to fix.
> 
>     Jason> "We won't work around processor bugs" is their philosophy.
> 
> [...deleted...]
> 
> I investigated the problem a bit when I had trouble with a self-compiled
> glibc a year or so ago. IIRC, I found bug in the memset code, not in the
> chip. The code was just wrong for cache line sizes not equal to 32. So
> memset.S is good for 60x series (PQII included) but for 8xx it fails. We
> use dcbX instructions in some kernel drivers and since we never had any
> problems with those drivers I'm a bit surprised to hear that all 8xx
> chips have got that bug.

It's also OK on a multiple of 32, iirc, but not smaller.  And using the
information the kernel does export would be too slow.  Or at least no
one figured out a good way to do it, userspace side.

-- 
Tom Rini
http://gate.crashing.org/~trini/
