Return-Path: <euphoria@arcor.de>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B368DDDDFE
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 10:39:31 +1100 (EST)
Received: from mail-in-17-z2.arcor-online.net (mail-in-17-z2.arcor-online.net
	[151.189.8.34])
	by mail-in-01.arcor-online.net (Postfix) with ESMTP id 9E969252F01
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 00:39:18 +0100 (CET)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	by mail-in-17-z2.arcor-online.net (Postfix) with ESMTP id 8DEC345C049
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 00:39:18 +0100 (CET)
Received: from [192.168.100.2] (e181008131.adsl.alicedsl.de [85.181.8.131])
	(Authenticated sender: florian.boelstler@arcor.de)
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id 2DB6612D32
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Nov 2007 00:39:18 +0100 (CET)
Message-ID: <47339E23.70806@arcor.de>
Date: Fri, 09 Nov 2007 00:39:15 +0100
From: Florian Boelstler <euphoria@arcor.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: OT: Strange delays / what usually happens every 10 min?
Content-Type: text/plain; charset=ISO-8859-15
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

I am currently working on a MPC8540-based custom board, which runs Linux
2.6.15 (arch/ppc).

I set up a periodically running kernel thread, which is delayed for a
single jiffy using schedule_timeout() in an infinite loop. It is used to
measure delays between invocations of that thread. For measuring the
distance in time the PPC's time base lower half register is used
(obtained using get_cycles() defined in asm/timex.h).

The thread calculates the delay to the previous run and only outputs the
result if a new maximum value has been determined (in respect to all
previous cycles). Further the thread outputs a warning if a very "high"
delay was determined. I.e. a delay greater than 5ms.

While running that test driver a delay of about 10ms _exactly_ occurs
every 10 minutes.

The kernel is configured using CONFIG_HZ=1000 and CONFIG_PREEMPT.
The CCB is at 333MHz, whereas the TBR update rate is 333 MHz / 8, i.e.
41,625 MHz.

Apart of some kernel threads almost all user processes have been killed
during the test. Only SSH and a bash were running.
The kernel comes with compiled in CIFS support, some kernel debugging
features like soft-lockup detection and preemption debugging. I.e. ps
lists the kernel threads ksoftirqd, watchdog, events, khelper, kthread,
kblockd, pdflush, aio, cifsoplockd and cifsdnotifyd.

An appropriate userspace test tool based on nanosleep() determined the
same results like the kernel thread.

I also run tcpdump once to check whether some "random" network activity
might be the reason. While there havn't been any packets matching that
10 minutes interval, I got to know that a nearby Windows machine issues
 ARP requests every 10 minutes (though not matching the 10ms delay).
Which leads to the question whether Linux does something similar in the
network sub system?

Thanks for any idea, I'm lost.

Cheers,

  Florian
