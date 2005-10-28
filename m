Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 2B4E368593
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 16:57:53 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 3EF0729EBB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 08:56:13 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 05066-04 for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 08:56:12 +0200 (CEST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 5416C28067
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Oct 2005 08:56:12 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Date: Fri, 28 Oct 2005 08:57:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200510280857.44625.david.jander@protonic.nl>
Subject: Kernel 2.6 on MPC8xx performance trouble...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

Many people have said it before: 2.6 has a performance penalty specially for 
embdedded systems.
But now that I have 2.6 running on our 100MHz MPC852T based board, I was 
shocked to see the result:
The most simple task doing nothing but a closed loop of integer math runs at 
_half_ the speed compared to kernel 2.4.25!!!!!

Here are the conditions for the test:
- Bogomips are the same, so the CPU definitely runs at the same clock-rate 
(and not half) as with "2.4".
- Enabling and disabling preemption doesn't have any impact (as expected for 
such kinds of tasks).
- Setting HZ to 100 or 1000 also has only about 3% impact on speed.
- The binary of the test program is the same in both cases (no re-compile with 
other optimizations by accident).
- The hardware is the same (exact same board).
- Certain hardware drivers that are not ported to "2.6" yet were present in 
"2.4" but (obviously) not in "2.6", but non of them could have a _positive_ 
impact on performance.
- Kernel versions are 2.4.25 (denx-devel) and 2.6.14-rc5 (denx-git 20051027).

Result: The test takes 3 seconds on kernel-2.6 and 1.5 seconds on kernel-2.4. 
Here is what "time" has to say about it:

real    0m3.119s
user    0m3.080s
sys     0m0.040s

The test loop is pretty brain-dead, but that doesn't matter right now.
This is it:
	[....]
	gettimeofday(&tv0,NULL);
        for(t=0L; t<10000000L; t++)
        {
                a+=b; /* Do something */
        }
        gettimeofday(&tv,NULL);
	[...]

Any ideas?
Am I misconfiguring something? Is 2.6 support for mpc8xx still broken 
(cache/tlb, mm, etc) or is 2.6 supposed to perform THAT bad??

Greetings,

-- 
David Jander
