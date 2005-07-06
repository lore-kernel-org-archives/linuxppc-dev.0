Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3ECA467C32
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 18:58:18 +1000 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17099.40223.728.64701@astp0002.localdomain>
Date: Wed, 6 Jul 2005 11:58:06 +0300
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20050705195328.GC6878@smtp.west.cox.net>
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
	<20050701101713.GC11121@logos.cnet>
	<1120244191.18872.3.camel@jmcmullan.timesys>
	<17096.61878.43282.752343@astp0002.localdomain>
	<20050705195328.GC6878@smtp.west.cox.net>
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

>>>>> Tom Rini writes:

    Yuli> [...deleted...]

    Jason> Ha. Funny. The glibc powerpc maintainer doesn't want any
    Jason> embedded fixes in the mainline. Last I checked, that was for
    Jason> 'the tools vendors' to fix.

    Jason> "We won't work around processor bugs" is their philosophy.

    Yuli> [...deleted...]

    Yuli> I investigated the problem a bit when I had trouble with a
    Yuli> self-compiled glibc a year or so ago. IIRC, I found bug in the
    Yuli> memset code, not in the chip. The code was just wrong for
    Yuli> cache line sizes not equal to 32. So memset.S is good for 60x
    Yuli> series (PQII included) but for 8xx it fails. We use dcbX
    Yuli> instructions in some kernel drivers and since we never had any
    Yuli> problems with those drivers I'm a bit surprised to hear that
    Yuli> all 8xx chips have got that bug.

    Tom> It's also OK on a multiple of 32, iirc, but not smaller.  And
    Tom> using the information the kernel does export would be too slow.
    Tom> Or at least no one figured out a good way to do it, userspace
    Tom> side.

IMHO the cache line size from cputable is not used in the kernel but
only passed to the ELF interpreter. I did not want to re-build glibc so
I changed the entry for mpc8xx to pass 0 instead of 16. This disabled
the assembler implementation of memset and since then all our
mpc8xx-based boards work properly. In any case, since it looks like a
coding bug and not CPU errata, maybe the glibc maintainer would be
willing to fix it?

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
