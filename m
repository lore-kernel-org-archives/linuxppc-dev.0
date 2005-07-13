Return-Path: <gjalt007@chello.nl>
Received: from amsfep15-int.chello.nl (amsfep15-int.chello.nl [213.46.243.27])
	by ozlabs.org (Postfix) with ESMTP id 087EB67B9A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Jul 2005 02:02:07 +1000 (EST)
Message-ID: <42D5361B.2070402@chello.nl>
Date: Wed, 13 Jul 2005 17:41:15 +0200
From: Theo Gjaltema <gjalt007@chello.nl>
MIME-Version: 1.0
To: Yuli Barcohen <yuli@arabellasw.com>
References: <42C1AAC1.4060702@gmail.com>
	<20050629085913.GA2153@logos.cnet>	<faba7798050630071347d4ad63@mail.gmail.com>	<20050701094438.GA11121@logos.cnet>	<1120229717.21507.9.camel@jmcmullan.timesys>	<20050701101713.GC11121@logos.cnet>	<1120244191.18872.3.camel@jmcmullan.timesys>	<17096.61878.43282.752343@astp0002.localdomain>	<20050708003639.GA5174@dmt.cnet>
	<17104.52971.2458.935609@astp0002.localdomain>
In-Reply-To: <17104.52971.2458.935609@astp0002.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi,

It appeard that on my mpc862 target I had also this problem. I am using
ELDK3.1.1 which includes a 2.4.25 kernel.
The symptoms however were:
    Large application (20MB c++, mostly shared-libs) crashes (sigseg) at
startup BEFORE main() is called.
    Attempts to debug the application also fail: the debugger crashes
also (sigseg).
I didn't change the C-lib, I took the 2.4.30/arch/ppc/kernel/head_8xx.S
file and copied this over the 2.4.25 head_8xx.S file.
In the 2.4.30 version there is a piece of code mentioning the dcbX
instruction problems.

Has anyone an idea why only this large application failed? busybox_1.0
and more applications work fine.
system is a: mcp862/32Mb SDRAM started from u-boot 0.4.1,
kernel enhanced with atm/utopia driver.

This driver causes the CPM sometimes to hang when performing a memset,
can this be caused by the same problem?
(CPM stops responding, console buffers are not flused anymore and
kernel stops waiting for buffers)

Greetings,
   Theo Gjaltema



Yuli Barcohen schreef:

>>>>>>Marcelo Tosatti writes:
>>>>>>            
>>>>>>
>
>    Yuli> [...deleted...]
>
>    Jason> Ha. Funny. The glibc powerpc maintainer doesn't want any
>    Jason> embedded fixes in the mainline. Last I checked, that was for
>    Jason> 'the tools vendors' to fix.
>
>    Jason> "We won't work around processor bugs" is their philosophy.
>
>    Yuli> [...deleted...]
>
>    Yuli> I investigated the problem a bit when I had trouble with a
>    Yuli> self-compiled glibc a year or so ago. IIRC, I found bug in the
>    Yuli> memset code, not in the chip. The code was just wrong for
>    Yuli> cache line sizes not equal to 32. So memset.S is good for 60x
>    Yuli> series (PQII included) but for 8xx it fails.
>
>    Marcelo> I suppose you didnt actually use dcbz for userspace memset
>    Marcelo> on 8xx?
>
>Standard glibc did. After the fix, it doesn't do it any more on our
>systems.
>
>    Yuli> We use dcbX instructions in some kernel drivers and since we
>    Yuli> never had any problems with those drivers I'm a bit surprised
>    Yuli> to hear that all 8xx chips have got that bug.
>
>    Marcelo> The problem is that the DAR register is correctly unset (it
>    Marcelo> comes as NULL IIRC) on pagefaults for the dcbz
>    Marcelo> instruction. The dcbz instructions you issue are probably
>    Marcelo> always works on kernel addresses whose pagetables are
>    Marcelo> present?
>
>It's not dcbz, it's dcbi/dcbf. And yes, they work on kernel addresses. I
>never investigated if the page tables are present or not because there
>were no problems.
>
>    Marcelo> Joakim has developed a workaround for the
>    Marcelo> problem... although I promised him several times to test it
>    Marcelo> I never managed to get dcbz to work on the kernel copying
>    Marcelo> functions. :(
>
>[...patch deleted...]
>
>Well, if I manage to find time, I'll try it. No timetables though. I'm
>not sure if using dcbz in user-space memset is such a great
>optimisation. It well can be an example of over-engineering.
>
>  
>
