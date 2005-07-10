Return-Path: <yuli@arabellasw.com>
Received: from gold.webfusion.co.uk (gold.webfusion.co.uk [212.67.202.159])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ACE4967BEF
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Jul 2005 17:32:10 +1000 (EST)
From: Yuli Barcohen <yuli@arabellasw.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17104.52971.2458.935609@astp0002.localdomain>
Date: Sun, 10 Jul 2005 10:31:55 +0300
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
In-Reply-To: <20050708003639.GA5174@dmt.cnet>
References: <42C1AAC1.4060702@gmail.com> <20050629085913.GA2153@logos.cnet>
	<faba7798050630071347d4ad63@mail.gmail.com>
	<20050701094438.GA11121@logos.cnet>
	<1120229717.21507.9.camel@jmcmullan.timesys>
	<20050701101713.GC11121@logos.cnet>
	<1120244191.18872.3.camel@jmcmullan.timesys>
	<17096.61878.43282.752343@astp0002.localdomain>
	<20050708003639.GA5174@dmt.cnet>
Cc: Joakim Tjernlund <joakim.tjernlund@lumentis.se>,
	Jason McMullan <jason.mcmullan@gmail.com>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
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

>>>>> Marcelo Tosatti writes:

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
    Yuli> series (PQII included) but for 8xx it fails.

    Marcelo> I suppose you didnt actually use dcbz for userspace memset
    Marcelo> on 8xx?

Standard glibc did. After the fix, it doesn't do it any more on our
systems.

    Yuli> We use dcbX instructions in some kernel drivers and since we
    Yuli> never had any problems with those drivers I'm a bit surprised
    Yuli> to hear that all 8xx chips have got that bug.

    Marcelo> The problem is that the DAR register is correctly unset (it
    Marcelo> comes as NULL IIRC) on pagefaults for the dcbz
    Marcelo> instruction. The dcbz instructions you issue are probably
    Marcelo> always works on kernel addresses whose pagetables are
    Marcelo> present?

It's not dcbz, it's dcbi/dcbf. And yes, they work on kernel addresses. I
never investigated if the page tables are present or not because there
were no problems.

    Marcelo> Joakim has developed a workaround for the
    Marcelo> problem... although I promised him several times to test it
    Marcelo> I never managed to get dcbz to work on the kernel copying
    Marcelo> functions. :(

[...patch deleted...]

Well, if I manage to find time, I'll try it. No timetables though. I'm
not sure if using dcbz in user-space memset is such a great
optimisation. It well can be an example of over-engineering.

-- 
========================================================================
 Yuli Barcohen       | Phone +972-9-765-1788 |  Software Project Leader
 yuli@arabellasw.com | Fax   +972-9-765-7494 | Arabella Software, Israel
========================================================================
