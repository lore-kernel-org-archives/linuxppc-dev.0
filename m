Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD1FEDDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 22:09:43 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Ii7iS-0000Zy-Vp
	for linuxppc-embedded@ozlabs.org; Wed, 17 Oct 2007 05:09:36 -0700
Message-ID: <13252272.post@talk.nabble.com>
Date: Wed, 17 Oct 2007 05:09:36 -0700 (PDT)
From: aauer1 <aauer1@gmx.at>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Linux booting problem on Xilinx ppc
In-Reply-To: <fa686aa40710161237t54688b71g9c7cf9acdac2b744@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12694083.post@talk.nabble.com>
	<fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com>
	<12696686.post@talk.nabble.com> <13219154.post@talk.nabble.com>
	<000901c81006$7303b490$bb3ca688@LGE.NET>
	<13239003.post@talk.nabble.com>
	<fa686aa40710161237t54688b71g9c7cf9acdac2b744@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello.


Grant Likely-2 wrote:
> 
> On 10/16/07, aauer1 <aauer1@gmx.at> wrote:
>>
>> The on-chip memories are disabled. Only the BRAM is enabled. Now, we also
>> use
>> the ELDK 4.1 from Denx and the included cross compiler. The result is the
>> same... the Kernel stops at "Now booting the kernel". Now, we also have
>> an
>> USB JTAG cable. So, we can debug the memory.
>> Probably, anyone has another idea.
> 
> There are two common reasons for this behaviour:
> 1. kernel crashes before the console is configured
> 2. the console is not configured correctly.
> 
> In both cases; finding a way to look at __log_buf is the fastest way
> to figure out what is going on.
> 
> 

I was able to look at the __log_buf variable with the JTAG cable. So, I
recognized that the kernel doesn't halt after the "No booting the kernel"
message. There are many output messages in the __log_buf variable until it
stops at with a "Kernel panic" because the rootfs is not found (but this is
the minor problem).
Now, I know that the kernel boots but I don't get an output with my Xilinx
UartLite module. Are there some kernel modules which must be activated?? 
Btw. I have used the Linux-2.6-virtex kernel from
http://git.secretlab.ca/git/ and another Kernel (2.6.23 from kernel.org) -
both with the same result.

Thanks a lot,
Andreas
-- 
View this message in context: http://www.nabble.com/Linux-booting-problem-on-Xilinx-ppc-tf4449060.html#a13252272
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
