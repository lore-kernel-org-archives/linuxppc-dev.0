Return-Path: <dhlii@comcast.net>
Received: from sccrmhc11.comcast.net (sccrmhc11.comcast.net [204.127.202.55])
	by ozlabs.org (Postfix) with ESMTP id D113F687F5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 03:00:21 +1100 (EST)
Message-ID: <438490CC.6040205@comcast.net>
Date: Wed, 23 Nov 2005 10:54:52 -0500
From: "David H. Lynch Jr" <dhlii@comcast.net>
MIME-Version: 1.0
To: zjznliang <zjznliang_popo@163.com>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Help ! 2.6.14 kernel can't bring up
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 I was stuck at exactly this point for over a week. Basically, at this
point lots of things happen all at once:
Prior to this the MMU has had a small collection of TLB's setup.
The 6 lines of code you listed:
change from whatever Machine Status you powered up in to the proper
Machine status for running the kernel with memory translation and
exception handling enabled.
and switch from executing using physical addresses to executing using
virtual addresses.
and "jump" via the "rfi" from real mode to virtual mode at virtual
address start_here.

If you are using a LED IO port for debugging, then you MUST setup a TLB
entry for that LED or after the rfi you will not be able to write to it.
There should be a setup tlb block inside a CONFIG_SERIAL_TEXT_DEBUG
block copy it, change the address to match your LED port and set a new
index and your LED debug port should be good to go.

In my instance, my problem turned out to be with Machine Check
exceptions - The moment that rfi executes not only is virtual memory
enabled - but all exception handling is turned on.
I was able to find this my "testing" things one bit in the MSR at a
time, until I figured out which ones could be turned on and which could not.


zjznliang wrote:
> Hello David H. Lynch Jr.,£¡
>
> 	Now ,I am tracing the code in Linux 2.6.14 in head_8xx.S .
> 	I used led to trace the procedure,and I found the block in it .
> 	
> 644	/* Now turn on the MMU for real! */
> 645		li	r4,MSR_KERNEL
> 646		lis	r3,start_kernel@h
> 647		ori	r3,r3,start_kernel@l
> 648		mtspr	SPRN_SRR0,r3
> 649		mtspr	SPRN_SRR1,r4
> 650		rfi			/* enable MMU and jump to start_kernel */
>
> I set the led between the 649 and 650 ,and the led was light ,
> but when I set the led in the function start_kernel the led is not
> light .
>
> I thought the function start_kernel was not jumped to .
>
> what do you think ?
>   
