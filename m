Return-Path: <steven.scholz@imc-berlin.de>
Received: from mail.imc-berlin.de (mail.imc-berlin.de [217.110.46.186])
	by ozlabs.org (Postfix) with ESMTP id E234C679F8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 May 2006 01:29:27 +1000 (EST)
Received: from mailserver.berlin.imc-berlin.de
	(mailserver.berlin.imc-berlin.de [10.0.0.19])
	by mail.imc-berlin.de (Postfix) with ESMTP id B06A32F022
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 May 2006 17:10:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id E8E141E20AF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 May 2006 17:10:43 +0200 (CEST)
Received: from [10.0.2.10] (scholz.berlin.imc-berlin.de [10.0.2.10])
	by mailserver.berlin.imc-berlin.de (Postfix) with ESMTP id 191861E2027
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 May 2006 17:10:43 +0200 (CEST)
Message-ID: <446C8E70.3040601@imc-berlin.de>
Date: Thu, 18 May 2006 17:10:40 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: MPC8xx: resolution of gettimeofday() ?
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

Hi all,

what is the resolution of gettimeofday() for an MPC8xx?

IIUC then the "decrementer" is used to generate the timer interrupts every 10ms.

This decrementer runs at cpuclk/16. Thus with 80MHz CPU clock has a
resolution of 16/80MHz = 200ns and overflows every 50000 ticks.

But is this decrementer used to update xtime?
Will gettimeofday() have a resolution of 200ns?

How about linux 2.4 where xtime is a "struct timeval" rather then "struct
timespec"?

This trivial test programm

	struct timeval first, next;
	double diff;

	gettimeofday(&first, NULL);
	do {
		gettimeofday(&next, NULL);
	} while (first.tv_usec == next.tv_usec &&
		 first.tv_sec == next.tv_sec);

	diff  = ((double)  next.tv_sec - (double) first.tv_sec) * 1e6;
	diff +=  (double) (next.tv_usec - first.tv_usec);

	printf ("Resolution gettimeofday() = %g µs\n", diff);

says it's between 13 - 16 µs on a linux-2.4.20. Could that be? how does this
relate to the decrementer frequency?

Thanks a million!

--
Steven
