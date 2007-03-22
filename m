Return-Path: <chuckmeade@mindspring.com>
Received: from elasmtp-masked.atl.sa.earthlink.net
	(elasmtp-masked.atl.sa.earthlink.net [209.86.89.68])
	by ozlabs.org (Postfix) with ESMTP id 79D17DDFB1
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 04:30:43 +1100 (EST)
Message-ID: <4602BD39.9020102@mindspring.com>
Date: Thu, 22 Mar 2007 13:30:33 -0400
From: Chuck Meade <chuckmeade@mindspring.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC83xx SDMR setup error
References: <460292FA.8050206@mindspring.com>
	<E9D1DC31-9730-4431-9414-0870FDD3EAF6@kernel.crashing.org>
In-Reply-To: <E9D1DC31-9730-4431-9414-0870FDD3EAF6@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> .... the CEN field will be set to
>> zero.  This means the SDMR buffer size will always be 512, rather than
>> the intended (and allocated) 1024 bytes.
> 
> What does this effect?  I agree the code is wrong.

The SDMA moves data between the QUICC Engine (which includes the units for
Ethernet, etc.) and external memory.  The buffer we are talking about
exists in on-chip MURAM, and is used internally by the SDMA controller.
The manual does not go into detail on its use.  It is pointed to by the
SDEBCR, which in one section of the manual is referred to as a "temporary
buffer base" and in another section as "SDMA CAM entries base".

This buffer can be set to sizes ranging from 512 bytes to 3Kbytes.  I
assume, based on this, that the size of this buffer affects SDMA performance.
The current code allocates a 1Kbyte buffer for this use, but does not
correctly set the buffer size to 1K, but rather it is left at 512 bytes.
This in itself is probably just a reduced performance issue, caused by
a coding error.

However, as I mention below, it is unclear whether the buffer alignment
requirement is 64 bytes or 4Kbytes.  The code aligns the buffer to 64 bytes.
If the alignment requirement is truly 4Kbytes, then it is conceivable that
with the current code, the SDMA controller could be overwriting MURAM that
it has not allocated, potentially owned by other controllers.  That would
be a much worse situation, and lead to some nasty and hard to find problems.

>> ..... The code
>> in arch/powerpc/sysdev/qe_lib/qe.c (line 254) that allocates this buffer
>> aligns it to a 64-byte boundary.  This is only correct if the manual 
>> section
>> 18.1.7, which requires a 4KByte alignment, is wrong.  Which manual 
>> section
>> is correct?
> 
> Hopefully someone at freescale will know.  I'd suggest possibly posting 
> a support request to them to see if you can get a clarification since 
> their UM is not self-consistent on the details.

I am hoping that some of the Freescale regulars on this list, Dave Liu,
Timur Tabi, Li Yang, Kim Phillips, will know and can comment.

Thanks,
Chuck
