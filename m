Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3444467AC5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 06:41:35 +1000 (EST)
Date: Fri, 22 Apr 2005 12:39:21 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Pantelis Antoniou <panto@intracom.gr>
Message-ID: <20050422153921.GI12703@logos.cnet>
References: <20050421183239.GJ6525@logos.cnet>
	<20050421185027.GB12442@logos.cnet> <42689729.3030100@intracom.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <42689729.3030100@intracom.gr>
Cc: 26-devel@cyclades.com, linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [26-devel] v2.6 performance slowdown on MPC8xx: Measuring TLB
	cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>




On Fri, Apr 22, 2005 at 09:18:17AM +0300, Pantelis Antoniou wrote:
> Marcelo Tosatti wrote:
> >On Thu, Apr 21, 2005 at 03:32:39PM -0300, Marcelo Tosatti wrote:
> >
> >>Capture session of /proc/tlbmiss with 1 second interval:
> >
> >
> >Forgot to attach /proc/tlbmiss patch, here it is.
> >
> >
> [snip]
> 
> >
> > 
> 
> Thanks Marcelo.
> 
> I'll try to run this on my 870 board & mail the results.

Hi, 

Here goes more data about the v2.6 performance slowdown on MPC8xx.

Thanks Benjamin for the TLB miss counter idea! 

This are results of the following test script which zeroes the TLB counters,
copies 16MB of data from memory to memory using "dd", and reads the counters
again. 

-- 

#!/bin/bash
echo 0 > /proc/tlbmiss
time dd if=/dev/zero of=file bs=4k count=3840
cat /proc/tlbmiss

-- 

The results:

v2.6: 				v2.4: 				delta
[root@CAS root]# sh script     	[root@CAS root]# sh script     
real    0m4.241s                         real    0m3.440s
user    0m0.140s                         user    0m0.090s
sys     0m3.820s                         sys     0m3.330s

I-TLB userspace misses: 142369  I-TLB userspace misses: 2179    ITLB u: 139190
I-TLB kernel misses: 118288    	I-TLB kernel misses: 1369	ITLB k: 116319
D-TLB userspace misses: 222916 	D-TLB userspace misses: 180249	DTLB u: 38667
D-TLB kernel misses: 207773    	D-TLB kernel misses: 167236	DTLB k: 38273

The sum of all TLB miss counter delta's between v2.4 and v2.6 is: 

139190 + 116319 + 38667 + 38273  = 332449 

Multiplied by 23 cycles, which is the average wait time to read a 
page translation miss from memory:

332449 * 23 = 7646327 cycles.

Which is about 16% of 48000000, the total number of cycles this CPU 
performs on one second. Its very likely that there is a significant
indirect effect of this TLB miss increase, other than the wasted 
cycles to bring the page tables from memory: exception execution time 
and context switching.

Checking "time" output, we can see 1s of slowdown:  

[root@CAS root]# time dd if=/dev/zero of=file bs=4k count=3840 

v2.4:				v2.6:				diff
real    0m3.366s		real    0m4.360s		0.994s
user    0m0.080s		user    0m0.111s	        0.31s
sys     0m3.260s		sys     0m4.218s 		0.958s

Mostly caused by increased kernel execution time.

This proves that the slowdown is, in great part, due to increased 
translation cache trashing. 

Now, what is the best way to bring the performance back to v2.4 levels? 

For this "dd" test, which is dominated by "sys_read/sys_write", I thought 
of trying to bring the hotpath functions into the same pages, thus
decreasing the number of page translations required for such tasks.

Comments are appreciated.
