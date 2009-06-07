Return-Path: <bounces@nabble.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id ACC31B70B0
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  7 Jun 2009 10:33:43 +1000 (EST)
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 691AEDDD0B
	for <linuxppc-dev@ozlabs.org>; Sun,  7 Jun 2009 10:33:43 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1MD6KS-00077J-4v
	for linuxppc-dev@ozlabs.org; Sat, 06 Jun 2009 17:33:40 -0700
Message-ID: <23906892.post@talk.nabble.com>
Date: Sat, 6 Jun 2009 17:33:39 -0700 (PDT)
From: wael showair <showair2003@yahoo.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: how can i send real-time signal?
In-Reply-To: <23892580.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <23892580.post@talk.nabble.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Am Fri, 5 Jun 2009 10:41:56 -0700 (PDT)
schrieb wael showair <showair2003@yahoo.com>:

> My aim is : Each time the DSP-core interrupts the MPC8555 processor, a
> process in the user space will be informed by the arrival of this each
> interrupt.
You should have a look at drivers/uio...

> So i decided to use sw signals, in the ISR of the DSP-core interrupt
> i send a SW signal to the user space process? Is this the best
> solution? are there any better suggestion to achieve my aim? 
signals are expensive. Look at the UIO-Framework for a cheaper solution.
preallocated RT-Signals on the other Hand are fragile. Blocking reads
are cheaper and in case of preempt-RT, but not resticted to it, much
easier to handle.

Bene
-- 
View this message in context: http://www.nabble.com/how-can-i-send-real-time-signal--tp23892580p23906892.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
