Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 07C21685CF
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 20:57:29 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 28 Oct 2005 12:57:22 +0200
References: <200510280857.44625.david.jander@protonic.nl>
	<200510281136.21575.roger.larsson@norran.net>
In-Reply-To: <200510281136.21575.roger.larsson@norran.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510281257.22650.david.jander@protonic.nl>
Subject: Re: Kernel 2.6 on MPC8xx performance trouble...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 28 October 2005 11:36, Roger Larsson wrote:
> >[...]
> > Result: The test takes 3 seconds on kernel-2.6 and 1.5 seconds on
> > kernel-2.4. Here is what "time" has to say about it:
> >
> > real    0m3.119s
> > user    0m3.080s
> > sys     0m0.040s
> >
> > The test loop is pretty brain-dead, but that doesn't matter right now.
> > This is it:
> > 	[....]
> > 	gettimeofday(&tv0,NULL);
> >         for(t=0L; t<10000000L; t++)
> >         {
> >                 a+=b; /* Do something */
> >         }
> >         gettimeofday(&tv,NULL);
> > 	[...]
> >
> > Any ideas?
> > Am I misconfiguring something? Is 2.6 support for mpc8xx still broken
> > (cache/tlb, mm, etc) or is 2.6 supposed to perform THAT bad??
>
> Have you verified the system measured time with wall clock (wrist watch)?
> System time could be wrong on one of the systems.

Yes. Wall-clock==gettimeofday-clock on both systems.

> What is 'a' and 'b'? The only other explanation I can see is that your
> "Do something" is more memory heavy than you think - array calculations?
> (Cache problems should probably give a worse result, but you could check
> that those config registers are the same).

They are just integers with fixed start values. These are in the loop, so it's 
not an empty loop and hopefully the compiler won't out-optimize it so easily 
(that is of course without specifying any optimization flags). Please don't 
tell me it's a lousy benchmark, because I already know that! Be it as lousy 
as it is, I shouldn't get _those_ results IMHO.

I have downloaded nbench (hopefully a more serious benchmark for raw computing 
power), and the results are as follows (I deliberately excluded tests that 
don't make sense (ie. use FP)):

Kernel 2.4.25:

TEST                : Iterations/sec.  : Old Index   : New Index
                    :                  : Pentium 90* : AMD K6/233*
--------------------:------------------:-------------:------------
NUMERIC SORT        :          30.438  :       0.78  :       0.26
STRING SORT         :          1.5842  :       0.71  :       0.11
BITFIELD            :      7.9506e+06  :       1.36  :       0.28
FP EMULATION        :           3.258  :       1.56  :       0.36
IDEA                :          108.89  :       1.67  :       0.49

Kernel 2.6.14-r5:

TEST                : Iterations/sec.  : Old Index   : New Index
                    :                  : Pentium 90* : AMD K6/233*
--------------------:------------------:-------------:------------
NUMERIC SORT        :          21.042  :       0.54  :       0.18
STRING SORT         :         0.88215  :       0.39  :       0.06
BITFIELD            :      6.0979e+06  :       1.05  :       0.22
FP EMULATION        :          1.6453  :       0.79  :       0.18
IDEA                :          110.25  :       1.69  :       0.50


Now, the strange thing is, IDEA is the only test where 2.6 is slightly faster 
(results are consistent over repeated runs). Compiler options are: "-s 
-static -Wall -O3 -msoft-float", FP-emulation in the kernel is never 
activated.

I think I will need to look closer at how the "IDEA"-test works, but first 
I'll have to run the nbench sources through "indent", because they are pretty 
unreadable as is ;-)

I also downloaded oprofile, and am studying its manual right now. Hopefully 
using this might get me a clue. If anybody already happens to know the 
answer, please shout!

Greetings,

-- 
David Jander
