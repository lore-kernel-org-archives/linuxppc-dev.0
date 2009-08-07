Return-Path: <kenneth@southpole.se>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 54516B6EDF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  7 Aug 2009 22:54:00 +1000 (EST)
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id DDED8DDD04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 22:53:59 +1000 (EST)
Received: from [127.0.0.1] (ssh.southpole.se [193.12.106.19])
	by mail.southpole.se (Postfix) with ESMTPSA id 921B64D4296
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Aug 2009 14:53:55 +0200 (CEST)
Subject: 5121 cache handling.
From: Kenneth Johansson <kenneth@southpole.se>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Fri, 07 Aug 2009 14:53:52 +0200
Message-Id: <1249649632.4940.38.camel@localhost>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

on 5121 there is a e300 core that unfortunately is connected to the rest
of the SOC with a bus that do not support coherency.

solution for many driver has been to use uncached memory. But for the
framebuffer that is not going to work as the performance impact of doing
graphics operations on uncached memory is to large.

currently the "solution" is to flush the cache in the interrupt
handler. 

#if defined(CONFIG_NOT_COHERENT_CACHE)
                        int i;
                        unsigned int *ptr;
                        ptr  = coherence_data;
                        for (i = 0; i < 1024*8; i++)
                                *ptr++ = 0;
#endif

Now this apparently is not enough on a e300 core that has a PLRU cache
replacement algorithm. but what is the optimal solution? 

should not the framebuffer be marked as cache write through. that is the
W bit should be set in the tlb mapping. Why is this not done ? is that
feature also not working on 5121 ??

if this manual handling needs to be done what is best. 

do it like now but over 52KB memory basically throwing out anything in
the cache in the process regardless if it was needed or not.

or do it carefully over just the framebuffer memory.

problem with doing it over just the framebuffer is that a 1024x768
buffer is 98304 cache lines it's going to take a considerable time to
do. how many cycles does it take per cache line if we never get a hit ??
3cycles at 400MHz gives 4.5milisec/sec or 4-5% overhead

1024*768*4/32*3*(1/400000000)*60
.04423680000000000000

52kB on the other hand is only 1664 lines but is obviously going to have
to do a lot of actual memory writes also for any modified cache line and
later a lot of reads to read back what was evicted. 
