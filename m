Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F0A19DDEC8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 04:02:43 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Ihqka-0004zb-Qm
	for linuxppc-embedded@ozlabs.org; Tue, 16 Oct 2007 11:02:40 -0700
Message-ID: <13239003.post@talk.nabble.com>
Date: Tue, 16 Oct 2007 11:02:40 -0700 (PDT)
From: aauer1 <aauer1@gmx.at>
To: linuxppc-embedded@ozlabs.org
Subject: RE: Linux booting problem on Xilinx ppc
In-Reply-To: <000901c81006$7303b490$bb3ca688@LGE.NET>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <12694083.post@talk.nabble.com>
	<fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com>
	<12696686.post@talk.nabble.com> <13219154.post@talk.nabble.com>
	<000901c81006$7303b490$bb3ca688@LGE.NET>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


The on-chip memories are disabled. Only the BRAM is enabled. Now, we also use
the ELDK 4.1 from Denx and the included cross compiler. The result is the
same... the Kernel stops at "Now booting the kernel". Now, we also have an
USB JTAG cable. So, we can debug the memory. 
Probably, anyone has another idea.

Thanks,
Andreas



Sergey Oleynichenko wrote:
> 
> 
> I noticed this problem happens when on-chip memories are enabled in a
> design
> (it is 4th page in base system builder). Try to leave them "none" for both
> instruction and data.
> 
> Sergey
> 
> -----Original Message-----
> From: linuxppc-embedded-bounces+soleynichenko=zenith.com@ozlabs.org
> [mailto:linuxppc-embedded-bounces+soleynichenko=zenith.com@ozlabs.org] On
> Behalf Of aauer1
> Sent: Monday, October 15, 2007 1:47 PM
> To: linuxppc-embedded@ozlabs.org
> Subject: Re: Linux booting problem on Xilinx ppc
> 
> 
> Hello
> 
> I'm also working with ML403 board from Xilinx and have the same problem as
> you. The boot process stops after decompressing with the message "Now
> booting the kernel". We also used gcc-4.1.0 for the cross compilation. So,
> I
> would be glad to know, which gcc version have you used to get a working
> kernel!
> 
> Thanks,
> Andreas
> 
> 
> 
> Junqiang Hu wrote:
>> 
>> 
>> Hi Grant,
>> 
>>    Thank you so much for the reply!  Fortunately I got it work now --
>> it's
>> the crosstool compiler problem.  Originally I was using gcc-4.1.0, yet
>> when compiling kernel 2.6.22, I noticed that it says gcc-4.1.0 will
>> miscompile the kernel, so I changed to another version, and now I can let
>> it go!
>> 
>>   Right now still not fully booted because of the SystemACE problem, or
>> maybe the partition is not correct.  I'm still working on it, hopefully
>> to
>> get it solved soon :-)
>> 
>> Thanks,
>> -J.
>> 
>> 
>> Grant Likely-2 wrote:
>>> 
>>> On 9/15/07, Junqiang Hu <jqhu936@yahoo.com> wrote:
>>>>
>>>>
>>>> Dear friends,
>>>>
>>>>    I'm trying to run Linux in AvNet (Memec) Xilinx-XC2VP50-EVKT-FF1152
>>>>  board.  The Linux version I'm using is 2.4; the cross-compiler is
>>>> gcc-4.1.0, glibc 2.3.6.  When booting the kernel, it shows:
>>>>       loaded at:     00400000 004B51E4
>>>>       board data at: 00000000 00000018
>>>>       relocated to:  0040526C 00405284
>>>>       zimage at:     00405B2B 004B177C
>>>>       avail ram:     004B6000 60000000
>>> 
>>> I strongly recommend moving to a 2.6 kernel.  Recent mainline has
>>> support for the Xilinx ppc built in.
>>>>
>>>>       Linux/PPC load: console=ttyS0,9600 root=/dev/xsysace/disc0/part3
>>>> rw
>>>>       Uncompressing Linux...done.
>>>>       Now booting the kernel
>>>>
>>>> Then it hangs. First it seems to me that the "avail ram" is not
>>>> correct,
>>>> since I configured only 32MB SDRAM.  Moreover, if it's first powered
>>>> on,
>>>> the
>>>> end address of "avail ram" would be FFD9FBED. Then I tried to
>>>> investigate
>>>> the problem using xmd.  When  launched, it says:
>>> 
>>> (If you're using u-boot) You might have a mismatch between the board
>>> info structure used by u-boot and the one used by Linux.
>>> 
>>> Also, you should use your debugger to inspect the __log_buf memory of
>>> the kernel.  A common problem is the kernel starts booting, but the
>>> console is setup incorrectly and so you see nothing.  But, you can
>>> read the console output directly from memory if you look at the
>>> __log_buf region (find the address in the System.map file; you might
>>> need to subtract 0xC0000000 from the address to view the memory)
>>> 
>>> Cheers,
>>> g.
>>> 
>>> -- 
>>> Grant Likely, B.Sc., P.Eng.
>>> Secret Lab Technologies Ltd.
>>> grant.likely@secretlab.ca
>>> (403) 399-0195
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>> 
>>> 
>> 
>> 
> 
> -- 
> View this message in context:
> http://www.nabble.com/Linux-booting-problem-on-Xilinx-ppc-tf4449060.html#a13
> 219154
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 

-- 
View this message in context: http://www.nabble.com/Linux-booting-problem-on-Xilinx-ppc-tf4449060.html#a13239003
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
