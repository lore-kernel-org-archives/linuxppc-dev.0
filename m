Return-Path: <mlan@cpu.lu>
Received: from smtp-out.coditel.net (smtp-out.coditel.net [212.95.66.33])
	by ozlabs.org (Postfix) with ESMTP id 4A882679F8
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 08:00:24 +1000 (EST)
Received: from smtp.coditel.net (localhost.localdomain [127.0.0.1])
	by smtp-out.coditel.net (Postfix) with ESMTP id 9D986EB221
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 23:37:54 +0200 (CEST)
Received: from owl.grunz.lu (cable-83.217.129.40.coditel.net [83.217.129.40])
	by smtp.coditel.net (Postfix) with ESMTP id D32482FD2C
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Apr 2006 23:37:51 +0200 (CEST)
Received: from localhost ([127.0.0.1] helo=cpu.lu)
	by owl.grunz.lu with esmtp (Exim 4.61) (envelope-from <mlan@cpu.lu>)
	id 1FY8kd-0000mH-PO
	for linuxppc-dev@ozlabs.org; Mon, 24 Apr 2006 23:37:48 +0200
Date: Mon, 24 Apr 2006 23:37:42 +0200 (CEST)
From: Mich Lanners <mlan@cpu.lu>
Subject: Clock running fast on Mac Mini?
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E1FY8kd-0000mH-PO@owl.grunz.lu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

I have a problem on my Mac Mini with the kernel clock, which is running
fast.

In fact, it is gaining 10 ms every 5 seconds, as can be seen here, with
ntpdate called every 5 seconds:

owl:~# while true; do ntpdate -u be.pool.ntp.org; sleep 5; done
24 Apr 23:14:17 ntpdate[2601]: adjust time server 195.47.215.226 offset 0.151197 sec
24 Apr 23:14:22 ntpdate[2607]: adjust time server 195.47.215.226 offset 0.160348 sec
24 Apr 23:14:28 ntpdate[2613]: adjust time server 195.47.215.226 offset 0.170311 sec
[...]
24 Apr 23:17:15 ntpdate[2813]: adjust time server 195.47.215.226 offset 0.489635 sec
24 Apr 23:17:20 ntpdate[2819]: adjust time server 195.47.215.226 offset 0.499386 sec
24 Apr 23:17:25 ntpdate[2825]: step time server 195.47.215.226 offset 0.509342 sec
24 Apr 23:17:31 ntpdate[2831]: adjust time server 195.47.215.226 offset 0.013693 sec
24 Apr 23:17:36 ntpdate[2837]: adjust time server 195.47.215.226 offset 0.021668 sec

and so on.

This is with ntpd stopped, after a fresh boot with /etc/adjtime removed
to make sure hwclock is not falsly tuning the kernel timekeeping (I did
this because I once had a 2.6.16 kernel running, where clock problems
have been reported. I thought that may have falsified ntp's drift file
and/or hwclock's /etc/adjtime).

All this is with a 2.6.15 kernel.

My Alu powerbook with a 2.6.15 kernel does not show this problem.

Anybody know what's up?

Thanks, and cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "
