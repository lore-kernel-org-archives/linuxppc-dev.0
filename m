Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id 35FCBDDF84
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Sep 2008 22:20:17 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so526478anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Sep 2008 05:20:16 -0700 (PDT)
Date: Thu, 4 Sep 2008 08:19:26 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Jander <david.jander@protonic.nl>
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
Message-ID: <20080904121926.GA12867@yoda.jdub.homelinux.org>
References: <200808251131.02071.david.jander@protonic.nl>
	<49c0ff980809031333g1b63694bkffbacb0ae8112120@mail.gmail.com>
	<18623.16970.61036.731524@cargo.ozlabs.ibm.com>
	<200809041405.16489.david.jander@protonic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200809041405.16489.david.jander@protonic.nl>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	munroesj@us.ibm.com, John Rigby <jrigby@freescale.com>,
	prodyut hazarika <prodyuth@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 04, 2008 at 02:05:16PM +0200, David Jander wrote:
>> I would be careful about adding overhead to memcpy.  I found that in
>> the kernel, almost all calls to memcpy are for less than 128 bytes (1
>> cache line on most 64-bit machines).  So, adding a lot of code to
>> detect cacheability and do prefetching is just going to slow down the
>> common case, which is short copies.  I don't have statistics for glibc
>> but I wouldn't be surprised if most copies were short there also.
>
>Then please explain the following. This is a memcpy() speed test for different 
>sized blocks on a MPC5121e (DIU is turned on). The first case is glibc code 
>without optimizations, and the second case is 16-register strides with 
>dcbt/dcbz instructions, written in assembly language (see attachment)
>
>$ ./memcpyspeed
>Fully aligned:
>100000 chunks of 5 bytes   :  3.48 Mbyte/s ( throughput:  6.96 Mbytes/s)
>50000 chunks of 16 bytes   :  14.3 Mbyte/s ( throughput:  28.6 Mbytes/s)
>10000 chunks of 100 bytes  :  14.4 Mbyte/s ( throughput:  28.8 Mbytes/s)
>5000 chunks of 256 bytes   :  14.4 Mbyte/s ( throughput:  28.7 Mbytes/s)
>1000 chunks of 1000 bytes  :  14.4 Mbyte/s ( throughput:  28.7 Mbytes/s)
>50 chunks of 16384 bytes   :  14.2 Mbyte/s ( throughput:  28.4 Mbytes/s)
>1 chunks of 1048576 bytes  :  14.4 Mbyte/s ( throughput:  28.8 Mbytes/s)
>
>$ LD_PRELOAD=./libmemcpye300dj.so ./memcpyspeed
>Fully aligned:
>100000 chunks of 5 bytes   :  7.44 Mbyte/s ( throughput:  14.9 Mbytes/s)
>50000 chunks of 16 bytes   :  13.1 Mbyte/s ( throughput:  26.2 Mbytes/s)
>10000 chunks of 100 bytes  :  29.4 Mbyte/s ( throughput:  58.8 Mbytes/s)
>5000 chunks of 256 bytes   :  90.2 Mbyte/s ( throughput:   180 Mbytes/s)
>1000 chunks of 1000 bytes  :    77 Mbyte/s ( throughput:   154 Mbytes/s)
>50 chunks of 16384 bytes   :  96.8 Mbyte/s ( throughput:   194 Mbytes/s)
>1 chunks of 1048576 bytes  :  97.6 Mbyte/s ( throughput:   195 Mbytes/s)
>
>(I have edited the output of this tool to fit into an e-mail without wrapping 
>lines for readability).
>Please tell me how on earth there can be such a big difference???
>Note that on a MPC5200B this is TOTALLY different, and both processors have an 
>e300 core (different versions of it though).

How can there be such a big difference in throughput?  Well, your algorithm
seems better optimized than the glibc one for your testcase :).

>> The other thing that I have found is that code that is optimal for
>> cache-cold copies is usually significantly slower than optimal for
>> cache-hot copies, because the cache management instructions consume
>> cycles and don't help in the cache-hot case.
>>
>> In other words, I don't think we should be tuning the glibc memcpy
>> based on tests of how fast it copies multiple megabytes.
>
>I don't just copy multiple megabytes! See above example. Also I do constant 
>performance testing of different applications using LD_PRELOAD, to se the 
>impact. Recentrly I even tried prboom (a free doom port), to remember the 
>good old days of PC benchmarking ;-)
>I have yet to come across a test that has lower performance with this 
>optimization (on an MPC5121e that is).
>
>> Still, for 6xx/e300 cores, we probably do want to use dcbt/dcbz for
>> larger copies.  We don't want to use dcbt/dcbz on the larger 64-bit
>
>At least for MPC5121e you really, really need it!!
>
>> processors (POWER4/5/6) because the hardware prefetching and
>> write-combining mean that dcbt/dcbz don't help and just slow things
>> down.
>
>That's explainable.
>What's not explainable, are the results I am getting on the MPC5121e.
>Please, could someone tell me what I am doing wrong? (I must be doing 
>something wrong, I'm almost sure).

I don't think you're doing anything wrong exactly.  But it seems that
your testcase sits there and just copies data with memcpy in varying
sizes and amounts.  That's not exactly a real-world usecase is it?

I think what Paul was saying is that during the course of runtime for a
normal program (the kernel or userspace), most memcpy operations will be of
a small order of magnitude.  They will also be scattered among code that does
_other_ stuff than just memcpy.  So he's concerned about the overhead of an
implementation that sets up the cache to do a single 32 byte memcpy.

Of course, I could be totally wrong.  I haven't had my coffee yet this
morning after all.

josh
