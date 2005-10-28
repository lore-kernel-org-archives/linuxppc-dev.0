Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 644B3685CC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 19:36:12 +1000 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by mail.skekraft.net (Postfix) with ESMTP id DF6D4A4039
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 11:36:09 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 28 Oct 2005 11:36:21 +0200
References: <200510280857.44625.david.jander@protonic.nl>
In-Reply-To: <200510280857.44625.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510281136.21575.roger.larsson@norran.net>
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

On Friday 28 October 2005 08.57, David Jander wrote:
> Hi all,
>
> Many people have said it before: 2.6 has a performance penalty specially
> for embdedded systems.
> But now that I have 2.6 running on our 100MHz MPC852T based board, I was
> shocked to see the result:
> The most simple task doing nothing but a closed loop of integer math runs
> at _half_ the speed compared to kernel 2.4.25!!!!!
>
> Here are the conditions for the test:
> - Bogomips are the same, so the CPU definitely runs at the same clock-rate
> (and not half) as with "2.4".
> - Enabling and disabling preemption doesn't have any impact (as expected
> for such kinds of tasks).
> - Setting HZ to 100 or 1000 also has only about 3% impact on speed.
> - The binary of the test program is the same in both cases (no re-compile
> with other optimizations by accident).
> - The hardware is the same (exact same board).
> - Certain hardware drivers that are not ported to "2.6" yet were present in
> "2.4" but (obviously) not in "2.6", but non of them could have a _positive_
> impact on performance.
> - Kernel versions are 2.4.25 (denx-devel) and 2.6.14-rc5 (denx-git
> 20051027).
>
> Result: The test takes 3 seconds on kernel-2.6 and 1.5 seconds on
> kernel-2.4. Here is what "time" has to say about it:
>
> real    0m3.119s
> user    0m3.080s
> sys     0m0.040s
>
> The test loop is pretty brain-dead, but that doesn't matter right now.
> This is it:
> 	[....]
> 	gettimeofday(&tv0,NULL);
>         for(t=0L; t<10000000L; t++)
>         {
>                 a+=b; /* Do something */
>         }
>         gettimeofday(&tv,NULL);
> 	[...]
>
> Any ideas?
> Am I misconfiguring something? Is 2.6 support for mpc8xx still broken
> (cache/tlb, mm, etc) or is 2.6 supposed to perform THAT bad??

Have you verified the system measured time with wall clock (wrist watch)?
System time could be wrong on one of the systems.

What is 'a' and 'b'? The only other explanation I can see is that your
"Do something" is more memory heavy than you think - array calculations?
(Cache problems should probably give a worse result, but you could check that
those config registers are the same).

/RogerL
