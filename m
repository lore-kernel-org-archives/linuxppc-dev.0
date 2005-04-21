Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21CF067A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 09:29:18 +1000 (EST)
Date: Thu, 21 Apr 2005 15:32:39 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: 26-devel@cyclades.com,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Message-ID: <20050421183239.GJ6525@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: v2.6 performance slowdown on MPC8xx: Measuring TLB cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi everyone,

I found out that the previous TLB counter numbers were wrong, two 
of the values were switched!

CPU is a 48Mhz 855T with 32 TLB entries, and 128Mb of RAM.

Now I've got valid results. With an idle machine, this are the results
of /proc/tlbmiss capture session with 1 second interval. Note that
idle actually means about 4/5 processes (AcsWeb, cy_pmd, cy_alarm, cy_wdt
kernel's keventd) running and switching over, but CPU is about 96-97% 
idle. 

As you can see, the ratio which TLB misses happen in v2.6 is 
significantly higher, for both I/D caches, even with an almost idle machine.

The v2.6 kernel has grown in size relative to TLB usage (cache footprint), 
which is, I start to believe, the major cause for this issue. If that 
is the case other platforms will also suffer. 

As one example, the number of page addresses which the "sys_read()" 
system call needs to fetch to the I-cache in order to execute the task
(the calltree) is about twice in size as in v2.4. 

Pantelis Antoniou informed that that 64 TLB-entry versions of MPC8xx
processors do not suffer such significant performance slowdown.

One point in reading these numbers is that v2.6 will count twice for
page fault misses which result in pte creation (DataTLBMiss->DataTLBError),
but I hope to change that for better precision. In this specific 
case I guess it should not be significant given that no processes are 
being created, mostly already mapped (periodic) routines are running. 

I hope that capturing the TLB miss difference between v2.4 and v2.6 
on a simple CPU intense benchmark such as the "dd" I've been using before 
and multiplying that by translation cache miss penalty (20-23 clocks 
on a miss versus 1 clock on a hit) should give us a good estimate
the real cost of these misses). 

And I wonder, no other arches have been noticed this? 

Comments are appreciated.

Capture session of /proc/tlbmiss with 1 second interval:


v2.6:					v2.4:
I-TLB userspace misses: 2577            I-TLB userspace misses: 2192
I-TLB kernel misses: 1557               I-TLB kernel misses: 1328
D-TLB userspace misses: 7173            D-TLB userspace misses: 6801
D-TLB kernel misses: 4442               D-TLB kernel misses: 4260
*                                       *
I-TLB userspace misses: 5324            I-TLB userspace misses: 4557
I-TLB kernel misses: 3277               I-TLB kernel misses: 2821
D-TLB userspace misses: 14399           D-TLB userspace misses: 13816
D-TLB kernel misses: 9069               D-TLB kernel misses: 8734
*                                       *
I-TLB userspace misses: 8078            I-TLB userspace misses: 7003
I-TLB kernel misses: 4960               I-TLB kernel misses: 4360
D-TLB userspace misses: 22038           D-TLB userspace misses: 20952
D-TLB kernel misses: 13929              D-TLB kernel misses: 13299
*                                       *
I-TLB userspace misses: 10791           I-TLB userspace misses: 9404
I-TLB kernel misses: 6643               I-TLB kernel misses: 5874
D-TLB userspace misses: 29350           D-TLB userspace misses: 27963
D-TLB kernel misses: 18555              D-TLB kernel misses: 17768
*                                       *
I-TLB userspace misses: 13531           I-TLB userspace misses: 11801
I-TLB kernel misses: 8311               I-TLB kernel misses: 7390
D-TLB userspace misses: 36750           D-TLB userspace misses: 35123
D-TLB kernel misses: 23271              D-TLB kernel misses: 22416
*                                       *
I-TLB userspace misses: 16434           I-TLB userspace misses: 14229
I-TLB kernel misses: 10172              I-TLB kernel misses: 8925
D-TLB userspace misses: 51096           D-TLB userspace misses: 42241
D-TLB kernel misses: 34982              D-TLB kernel misses: 26995
*                                       *
I-TLB userspace misses: 19183           I-TLB userspace misses: 16646
I-TLB kernel misses: 11890              I-TLB kernel misses: 10445
D-TLB userspace misses: 58557           D-TLB userspace misses: 49291
D-TLB kernel misses: 39726              D-TLB kernel misses: 31479
*                                       *
I-TLB userspace misses: 21973           I-TLB userspace misses: 19125
I-TLB kernel misses: 13596              I-TLB kernel misses: 12011
D-TLB userspace misses: 65933           D-TLB userspace misses: 56376
D-TLB kernel misses: 44401              D-TLB kernel misses: 36025
*                                       *
I-TLB userspace misses: 24644           I-TLB userspace misses: 21509
I-TLB kernel misses: 15231              I-TLB kernel misses: 13526
D-TLB userspace misses: 73345           D-TLB userspace misses: 63431
D-TLB kernel misses: 49083              D-TLB kernel misses: 40567
*                                       *
I-TLB userspace misses: 27451           I-TLB userspace misses: 23894
I-TLB kernel misses: 16974              I-TLB kernel misses: 15031
D-TLB userspace misses: 80652           D-TLB userspace misses: 70467
D-TLB kernel misses: 53739              D-TLB kernel misses: 45089
