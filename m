Return-Path: <duykynguyen@hotmail.com>
Received: from bay0-omc1-s33.bay0.hotmail.com (bay0-omc1-s33.bay0.hotmail.com
	[65.54.246.105]) by ozlabs.org (Postfix) with ESMTP id C08ACDDEED
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Nov 2008 05:08:01 +1100 (EST)
Message-ID: <BLU119-DAV1277836B653D821B912BD1BB190@phx.gbl>
From: "Duy-Ky Nguyen" <duykynguyen@hotmail.com>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.3.1226019603.17582.linuxppc-embedded@ozlabs.org>
Subject: Broken network for different u-boot compilation
Date: Fri, 7 Nov 2008 10:07:59 -0800
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

I'm using u-boot 1.3.0 from the latest FreeScale Linux BSP MPC8313E-RDB.

If I set TEXT_BASE = 0x1000000, so I could use BDI debugger to load into RAM 
and run it out of RAM.
I'm ABLE to ping to the host from u-boot

But, if I set TEXT_BASE=0xFE000000, and burn the image it into Flash, 
recycle the power to run it out of Flash.
I'm NOT able to ping from u-boot with error message

"No link".

When I change TEXT_BASE from 0x1000000 to 0xFE000000, I have to do "make 
clean" before "make", otherwise it have error message
" undefined reference to 'env_name_space'"


On the other direction, when I change TEXT_BASE from 0xFE000000 to 
0x1000000, I have successful compilation without "make clean", but the 
u-boot hangs at "DRAM". I have to do "make clean" for successful u-boot AND 
network access.

I really appreciate your time and help.

Regards,

Duy-Ky


----- Original Message ----- 
From: <linuxppc-embedded-request@ozlabs.org>
To: <linuxppc-embedded@ozlabs.org>
Sent: Thursday, November 06, 2008 5:00 PM
Subject: Linuxppc-embedded Digest, Vol 51, Issue 9


> Send Linuxppc-embedded mailing list submissions to
> linuxppc-embedded@ozlabs.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> or, via email, send a message with subject or body 'help' to
> linuxppc-embedded-request@ozlabs.org
>
> You can reach the person managing the list at
> linuxppc-embedded-owner@ozlabs.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Linuxppc-embedded digest..."
>
>
> Today's Topics:
>
>   1. Using DMA (Bruce_Leonard@selinc.com)
>   2. Re: Using DMA (Scott Wood)
>   3. Re: Using DMA (Bill Gatliff)
>   4. Re: Using DMA (Bruce_Leonard@selinc.com)
>   5. Re: Using DMA (Bill Gatliff)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Wed, 5 Nov 2008 18:07:20 -0800
> From: Bruce_Leonard@selinc.com
> Subject: Using DMA
> To: linuxppc-embedded@ozlabs.org
> Message-ID:
> <OF1BC63DE0.D024D14C-ON882574F9.000ABAA9-882574F9.000BA2A1@selinc.com>
> Content-Type: text/plain; charset="US-ASCII"
>
> This may be the wrong forum for this question.  If so I apologize, and
> could someone please tell me the appropriate place to ask?
>
> Assuming this is the right place, I'm working with the 2.6.27 (stable)
> kernel and an MPC8347E processor.  I'm using a custom NAND controller and
> a custom driver to talk with that controller.  I'm now to the point where
> I'm trying to optimize/improve performance and something I'd like to do is
> set up the driver to use DMA transfers to the controller.  (As an
> additional bit of info, I modeled my driver on the Cafe driver.)  However,
> no one here has ever had to set up DMA from scratch before, it's always
> been done by an existing driver or the kernel, so I'm in uncharted
> teritory.
>
> In the Cafe driver, Linux Device Drivers 3rd Edition, and DMA-mapping.txt
> everyone talks about how to allocate buffers using
> dma/pci_alloc_coherent(), but no one talks about how to actually use it.
> I'm pretty sure (even in my ignorance) that just allocating a DMA coherent
> buffer and then copying in and out of it does NOT actually engage the
> underlying hardware and perform a DMA transfer.
>
> With some digging I've found the Freescale Elo/Elo Plus DMA driver which
> supports my processor.  What I'm not clear on is how to actually make use
> of it.  How do I tie my NAND driver to the Freescale DMA driver and
> actually get the hardware to work?  Any pointers are greatly appreciated.
>
> Thanks.
>
> Bruce
>
>
> ------------------------------
>
> Message: 2
> Date: Thu, 06 Nov 2008 12:29:38 -0600
> From: Scott Wood <scottwood@freescale.com>
> Subject: Re: Using DMA
> To: Bruce_Leonard@selinc.com
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <49133792.9080000@freescale.com>
> Content-Type: text/plain; charset=UTF-8; format=flowed
>
> Bruce_Leonard@selinc.com wrote:
>> In the Cafe driver, Linux Device Drivers 3rd Edition, and DMA-mapping.txt
>> everyone talks about how to allocate buffers using
>> dma/pci_alloc_coherent(), but no one talks about how to actually use it.
>> I'm pretty sure (even in my ignorance) that just allocating a DMA 
>> coherent
>> buffer and then copying in and out of it does NOT actually engage the
>> underlying hardware and perform a DMA transfer.
>
> Generally, you program the device itself to peform the transfer.  I'm
> assuming that your custom NAND controller can't do DMA by itself, though.
>
>> With some digging I've found the Freescale Elo/Elo Plus DMA driver which
>> supports my processor.  What I'm not clear on is how to actually make use
>> of it.  How do I tie my NAND driver to the Freescale DMA driver and
>> actually get the hardware to work?  Any pointers are greatly appreciated.
>
> Tell the DMA controller where to move data from, and where to move it to.
>
> -Scott
>
>
> ------------------------------
>
> Message: 3
> Date: Thu, 06 Nov 2008 12:36:58 -0600
> From: Bill Gatliff <bgat@billgatliff.com>
> Subject: Re: Using DMA
> To: Scott Wood <scottwood@freescale.com>
> Cc: Bruce_Leonard@selinc.com, linuxppc-embedded@ozlabs.org
> Message-ID: <4913394A.9040103@billgatliff.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> Scott Wood wrote:
>> Bruce_Leonard@selinc.com wrote:
>>> In the Cafe driver, Linux Device Drivers 3rd Edition, and
>>> DMA-mapping.txt everyone talks about how to allocate buffers using
>>> dma/pci_alloc_coherent(), but no one talks about how to actually use
>>> it. I'm pretty sure (even in my ignorance) that just allocating a DMA
>>> coherent buffer and then copying in and out of it does NOT actually
>>> engage the underlying hardware and perform a DMA transfer.
>
> Does the "adma" stuff address this any?
>
>
> b.g.
> -- 
> Bill Gatliff
> bgat@billgatliff.com
>
>
> ------------------------------
>
> Message: 4
> Date: Thu, 6 Nov 2008 12:58:53 -0800
> From: Bruce_Leonard@selinc.com
> Subject: Re: Using DMA
> To: Bill Gatliff <bgat@billgatliff.com>
> Cc: Scott Wood <scottwood@freescale.com>, linuxppc-embedded@ozlabs.org
> Message-ID:
> <OF4C3103D2.DABB64DF-ON882574F9.00733B0E-882574F9.00733B48@selinc.com>
> Content-Type: text/plain; charset="US-ASCII"
>
> Bill Gatliff <bgat@billgatliff.com> wrote on 11/06/2008 10:36:58 AM:
>
>> Scott Wood wrote:
>> > Bruce_Leonard@selinc.com wrote:
>> >> In the Cafe driver, Linux Device Drivers 3rd Edition, and
>> >> DMA-mapping.txt everyone talks about how to allocate buffers using
>> >> dma/pci_alloc_coherent(), but no one talks about how to actually use
>> >> it. I'm pretty sure (even in my ignorance) that just allocating a DMA
>> >> coherent buffer and then copying in and out of it does NOT actually
>> >> engage the underlying hardware and perform a DMA transfer.
>>
>> Does the "adma" stuff address this any?
>>
>
> What is "adma"?
>
> Bruce
>
>
> ------------------------------
>
> Message: 5
> Date: Thu, 06 Nov 2008 15:42:17 -0600
> From: Bill Gatliff <bgat@billgatliff.com>
> Subject: Re: Using DMA
> To: Bruce_Leonard@selinc.com
> Cc: Scott Wood <scottwood@freescale.com>, linuxppc-embedded@ozlabs.org
> Message-ID: <491364B9.607@billgatliff.com>
> Content-Type: text/plain; charset=ISO-8859-1
>
> Bruce_Leonard@selinc.com wrote:
>> Bill Gatliff <bgat@billgatliff.com> wrote on 11/06/2008 10:36:58 AM:
>>
>>> Scott Wood wrote:
>>>> Bruce_Leonard@selinc.com wrote:
>>>>> In the Cafe driver, Linux Device Drivers 3rd Edition, and
>>>>> DMA-mapping.txt everyone talks about how to allocate buffers using
>>>>> dma/pci_alloc_coherent(), but no one talks about how to actually use
>>>>> it. I'm pretty sure (even in my ignorance) that just allocating a DMA
>>>>> coherent buffer and then copying in and out of it does NOT actually
>>>>> engage the underlying hardware and perform a DMA transfer.
>>> Does the "adma" stuff address this any?
>>>
>>
>> What is "adma"?
>>
>> Bruce
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>
> Asynchronous DMA.  See this paper, for example:
>
> http://www.power.org/devcon/07/Session_Downloads/PADC07_Aytac_Haluk_09_13_07_layout_FINAL.pdf
>
> It looks like the structure of interest is async_tx_submit.  Beyond
> that, I can't offer much because I haven't used it.
>
>
> b.g.
> -- 
> Bill Gatliff
> bgat@billgatliff.com
>
>
> ------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> End of Linuxppc-embedded Digest, Vol 51, Issue 9
> ************************************************
> 
