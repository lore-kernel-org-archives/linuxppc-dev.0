Return-Path: <bounces@nabble.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 7A9E5B7084
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  6 Jun 2009 03:42:00 +1000 (EST)
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 3082CDDDA0
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Jun 2009 03:41:59 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MCdQS-0008Q2-9m
	for linuxppc-dev@ozlabs.org; Fri, 05 Jun 2009 10:41:56 -0700
Message-ID: <23892580.post@talk.nabble.com>
Date: Fri, 5 Jun 2009 10:41:56 -0700 (PDT)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: how can i send real-time signal?
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi All,
i m using linux-kernel 2.6.27 & a board of MPC8555 processor.
i have also DSP-core on the same board.

My aim is : Each time the DSP-core interrupts the MPC8555 processor, a
process in the user space will be informed by the arrival of this each
interrupt.

So i decided to use sw signals, in the ISR of the DSP-core interrupt i send
a SW signal to the user space process? Is this the best solution? are there
any better suggestion to achieve my aim? 

i used the kernel API send_sig_info because i want to send information with
the sent signal & my signal type was SIGUSR1

i could receive the SW signal successfully but i found out that the standard
SW signals are not queued if they r in the pending queue of the user space
process but the real-time signals do.
so i changed the type of the signal to SIGRTMIN but unfortunately i could
receive any SW signal from my ISR & i noticed that always the second
interrupt causes a kernel panic

so am i using the correct signal type?
am i using the correct kernel API to send a real-time SW signal?

plz help 
-- 
View this message in context: http://www.nabble.com/how-can-i-send-real-time-signal--tp23892580p23892580.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
