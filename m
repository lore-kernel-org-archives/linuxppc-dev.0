Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 39067679E1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 04:05:03 +1000 (EST)
Message-ID: <42B06DCE.3080709@ru.mvista.com>
Date: Wed, 15 Jun 2005 22:05:02 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
MIME-Version: 1.0
To: Allen Curtis <acurtis@onz.com>
References: <42eb0bacadb197b42502ac1828450843@onz.com>	<a38c1fefe53947c6b80ec3d6b4ffd09e@freescale.com>	<c2628642aad8b8107d0e9db84535ea0c@onz.com>	<1118845450.7564.111.camel@jmcmullan.timesys>	<e7e59bf0180e5958169a0f7fc0196098@freescale.com>
	<a9c3f58e85815e58496be38eeee609bf@onz.com>
In-Reply-To: <a9c3f58e85815e58496be38eeee609bf@onz.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Allen Curtis wrote:

>> On Jun 15, 2005, at 9:24 AM, Jason McMullan wrote:
>>
>>> My personal opinions:
>>>
>>>     * Use macro-offsets into a cpm2_map_t struct
>>
>>
>> Not going to happen.  Sorry.
>>
>
> Interesting... So are you thinking of eliminating the cpm_map_t 
> structure all together?

I guess not that tough. I used to have really disappointing problem when 
on of the patches added a small error to immr structure. Whole day of 
ghost hust while the problem wasn't even mine. So the hardcoded offsets 
are intended to prevent such cases. I don't think cpm_map_t will be 
eliminated as structure is much more comfortable and understandable than 
pure offsets.  Bus I agree that structure-dependence within platform 
definitions is not very good idea. IMHO.

>
>>>     * Put fcc_c regs back in
>>
>>
>> Can you explain this.  I'm not 100% sure what regs you are referring to.
>>
>
> The registers that he is referring to are in my patch with a comment 
> about moving them to the device driver specific structure. The base 
> address changed depending on processor.
>
>>>     * dpram[PROFF_*] should be in the resources list
>>
>>
>> The patch I posted seems to do that.  I'm guessing these comments may 
>> be against Allen's initial patch.
>>
> My patch did you the #defines from cpm2.h to specify the PROFF 
> locations. It did not use dpram[PROFF] since that would be an address 
> not an offset from the base.
>
>>>     * cpm2_* is a better name than MPC82xx_* or MPC85xx_*
>>>     * Keep CPM2_DMA, etc, as these *should* be showing up in
>>>       /proc/iomem, since, IIRC, the platform layer does
>>>       reserve them upon registration. (And I *do* have a DMA
>>>       layer then uses CPM2_DMA as a driver-ish thing)
>>
>>
>> I'll agree on DMA, do you see value in CPM, SI1 and SI2 being here?  
>> And if so for what?
>>
> I really do not want to belabor this point about naming conventions 
> but I believe it will become more of a problem in the future. The 
> problem as I see it is the PQ2 is a multi-core processor composed of a 
> PPC 603 and a CPM. So the question is, is it more efficient to 
> describe the multi-core permutations or the pieces that are put 
> together to create the processor. As industry uses more IP blocks to 
> create SoCs I can see the "describe the chip" approach to be a 
> exponential problem.
>
Definitely.And there isn't only one issue. For example, I think 8xx will 
never get such device/sys files because the fact that the board has 8xx 
chip means nearly nothing in term of what devices it has. The best 
decision this case to manually call platform_device_register on 
structures created within board-specific code.

> DMA and CPM should be in the device list. They represent a shared 
> resource or a management function shared by the "real" devices. 
> Putting them in the list has the advantage that their resources are 
> mapped with the device is registered. (as mentioned by Jason M.) 
> Perhaps there will be a need for a DMA manager.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>


-- 
Sincerely, 
Vitaly
