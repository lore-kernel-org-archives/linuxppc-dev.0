Return-Path: <John.Youn@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.60.111])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9BvV0MdGzDqCK
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 10:36:20 +1000 (AEST)
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
To: Christian Lamparter <chunkeey@googlemail.com>, John Youn
 <John.Youn@synopsys.com>
References: <4231696.iL6nGs74X8@debian64> <2920638.peXreEnG6d@debian64>
 <573BAE58.1010206@synopsys.com> <1569777.jHIobOl9fm@debian64>
From: John Youn <John.Youn@synopsys.com>
CC: Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Felipe Balbi <felipe.balbi@linux.intel.com>,
 "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "a.seppala@gmail.com" <a.seppala@gmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Message-ID: <573D0A7E.7020401@synopsys.com>
Date: Wed, 18 May 2016 17:36:14 -0700
MIME-Version: 1.0
In-Reply-To: <1569777.jHIobOl9fm@debian64>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 5/18/2016 12:15 PM, Christian Lamparter wrote:
> On Tuesday, May 17, 2016 04:50:48 PM John Youn wrote:
>> On 5/14/2016 6:11 AM, Christian Lamparter wrote:
>>> On Thursday, May 12, 2016 11:40:28 AM John Youn wrote:
>>>> On 5/12/2016 6:30 AM, Christian Lamparter wrote:
>>>>> On Thursday, May 12, 2016 01:55:44 PM Arnd Bergmann wrote:
>>>>>> On Thursday 12 May 2016 11:58:18 Christian Lamparter wrote:
>>>>>>>>>> Detecting the endianess of the
>>>>>>>>>> device is probably the best future-proof solution, but it's also
>>>>>>>>>> considerably more work to do in the driver, and comes with a
>>>>>>>>>> tiny runtime overhead.
>>>>>>>>>
>>>>>>>>> The runtime overhead is probably non-measurable compared with the cost
>>>>>>>>> of the actual MMIOs.
>>>>>>>>
>>>>>>>> Right. The code size increase is probably measurable (but still small),
>>>>>>>> the runtime overhead is not.
>>>>>>>
>>>>>>> Ok, so no rebuts or complains have been posted.
>>>>>>>
>>>>>>> I've tested the patch you made in: https://lkml.org/lkml/2016/5/9/354
>>>>>>> and it works: 
>>>>>>>
>>>>>>> Tested-by: Christian Lamparter <chunkeey@googlemail.com>
>>>>>>>
>>>>>>> So, how do we go from here? There is are two small issues with the
>>>>>>> original patch (#ifdef DWC2_LOG_WRITES got converted to lower case:
>>>>>>> #ifdef dwc2_log_writes) and I guess a proper subject would be nice.  
>>>>>>>
>>>>>>> Arnd, can you please respin and post it (cc'd stable as well)?
>>>>>>> So this is can be picked up? Or what's your plan?
>>>>>>
>>>>>> (I just realized my reply was stuck in my outbox, so the patch
>>>>>> went out first)
>>>>>>
>>>>>> If I recall correctly, the rough consensus was to go with your longer
>>>>>> patch in the future (fixed up for the comments that BenH and
>>>>>> I sent), and I'd suggest basing it on top of a fixed version of
>>>>>> my patch.
>>>>> Well, but it comes with the "overhead"! So this was just as I said:
>>>>> "Let's look at it and see if it's any good"... And I think it isn't
>>>>> since the usb/host/ehci people also opted for #ifdef CONFIG_BIG_ENDIAN
>>>>> archs etc...
>>>>
>>>> I slightly prefer the more general patch for future kernel versions.
>>>> The overhead will probably be negligible, but we can perform some
>>>> testing to make sure.
>>>>
>>>> Can you resubmit with all gathered feedback?
>>>
>>> Yes, here are the changes.
>>>
>>> I've tested it on my MyBook Live Duo. The usbotg comes right up:
>>> [12610.540004] dwc2 4bff80000.usbotg: USB bus 1 deregistered
>>> [12612.513934] dwc2 4bff80000.usbotg: Specified GNPTXFDEP=1024 > 256
>>> [12612.518756] dwc2 4bff80000.usbotg: EPs: 3, shared fifos, 2042 entries in SPRAM
>>> [12612.530112] dwc2 4bff80000.usbotg: DWC OTG Controller
>>> [12612.533948] dwc2 4bff80000.usbotg: new USB bus registered, assigned bus number 1
>>> [12612.540083] dwc2 4bff80000.usbotg: irq 33, io mem 0x00000000
>>>
>>> John: Can you run some perf test with it?
>>>
>>> I've based this on:
>>>
>>> commit 6ea2fffc9057a67df1994d85a7c085d899eaa25a
>>> Author: Arnd Bergmann <arnd@arndb.de>
>>> Date:   Fri May 13 15:52:27 2016 +0200
>>>
>>>     usb: dwc2: fix regression on big-endian PowerPC/ARM systems
>>>
>>> so naturally, it needs to be applied first.
>>> Most of the conversion work was done by the attached
>>> coccinelle semantic patches. 
>>>
>>> I had to edit the __bic32 and __orr32 helpers by hand.
>>> As well as some debugfs code and stuff in gadget.c.
>>>
>>
>> Thanks Christian.
>>
>> I'll keep this in our internal tree and send it to Felipe later. This
>> causes a bunch of conflicts that I have to fix up and I should do a
>> bit of testing as well.
>>
>> And since there is a patch that fixes the regression this is can wait.
>>
>> Regards,
>> John
> ---
> Hey, that's really nice of you to do that :-D. Please keep me in the
> loop (Cc) for those then. 

Sure no problem.

> 
> Yes, this needs definitely testing on all the affected ARCHs. 
> I've attached a diff to a updated version of the patch. It
> drops the special MIPS case (as requested by Arnd).
> 
> BTW, I looked into the ioread32_rep and iowrite32_rep again. I'm
> not entirely convinced that the hardware FIFOs are actually endian
> neutral. But I can't verify it since my Western Digital My Book Live
> only supports the host configuration (forces host mode), so I don't
> know what a device in dual-mode or peripheral do here.
> 
> The reason why I think it was broken is because there's a PIO copy
> to and from the HCFIFO(x) in dwc2_hc_write_packet and
> dwc2_hc_read_packet access in the hcd.c file as well... And there,
> the code was using the dwc2_readl and dwc2_writel to access the data.
> I added special accessors for the FIFOS now:
> 	dwc2_readl_rep and dwc2_writel_rep.
> 

Hmmm, you could be right in that case. I'll have to check with the IP
engineers and maybe try to run some tests on our platforms. So native
access to the host FIFO will fail then? This platform is a BE CPU with
the IP connected as LE, right?


> I went all the way and implemented the helpers to do unaligned access
> if necessary (not sure if adding likely branches is a good idea, as
> this could be either always true or false for a specific driver the
> whole time).
> 
> NB: it also fixes a "regs variable not used in dwc2_hsotg_dump" warning
> if DEBUG isn't selected.
> 
> NB2: If it you need a patch against a specific tree, please
> let me know.

I can't provide you a tree to rebase on just yet. I'm hoping to get a
few things queued for 4.8 and just apply this on top.

It would help if you could resend these as proper patches with a
commit message and signed-off-by line, and the CONFIG_MIPS removal and
compile warning fix merged in. And the fifo accessors in a separate
patch. That way I can do any simple fix-ups if needed.

Regards,
John
