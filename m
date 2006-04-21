Return-Path: <akshaymishra@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.224])
	by ozlabs.org (Postfix) with ESMTP id 9DC00679F7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 22 Apr 2006 01:10:31 +1000 (EST)
Received: by wproxy.gmail.com with SMTP id i20so369658wra
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Apr 2006 08:10:29 -0700 (PDT)
Message-ID: <460643480604210810t23d8845erdd4500adf4882839@mail.gmail.com>
Date: Fri, 21 Apr 2006 20:40:29 +0530
From: "Akshay Mishra" <akshaymishra@gmail.com>
To: linuxppc-embedded@ozlabs.org, kpoole@mrv.com
Subject: kernel access of bad area, sig: 11 ( mpc852t)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

What processor frequency do you use ? The EP board  for 852T uses 10
MHz OSCM and CLKIN. We were trying 66 MHz earlier and 25Mhz after
that. But never got any results. The hardware is clean afaik. and the
memory timing is more critical on the MPC8280 on the same board and it
works very well.

We tried changing the clock source to oscillator/crystal and slowing
the clockout to the SDRAM to verify if memory access were a problem.
But no result there too.

The kernel we have is 2.4.21. Will migrating to 2.6 make lives any better ?

Best,
Akshay

----------Quoting Kenneth
We have been experiencing this same issue with random boards in
production. The exact same version of software will run for months on
other instances of the exact same board design, but a few percent get
'random' trap 300s. When they do occur, it's only after Linux has booted
and address translation and caching are turned on. Examining the oops-es
and memory shows that some location in SDRAM has a bogus value, but I
don't have the tools to trace back how it got that way.

I have ported a rigorous moving-inversions memory test into our
firmware, and have run it extensively across the entire SDRAM address
space (the test code executes from flash). I have let this test run
continuously for hours and hours, but never found a memory problem.
Unfortunately, I do not have test software that enables the MMU address
translation or caching, so as Mark said, I can't test memory using
bursting. Our hardware engineers have reviewed the designs very
carefully and are quite confident that there is plenty of margin in the
memory timing. Signal quality has also been carefully checked.

Our manufacturing people have replaced the CPU on some of these boards,
and the problem went away.

If anyone else on the mailing list has experienced this issue, or has
developed a virtual address memory test, please let us know.

Ken Poole
