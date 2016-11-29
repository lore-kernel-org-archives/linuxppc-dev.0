Return-Path: <John.Youn@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay4.synopsys.com [198.182.47.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSTd8291dzDvy4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 14:32:27 +1100 (AEDT)
Subject: Re: [PATCH v2 2/4] usb: dwc2: Add binding for AHB burst
To: Christian Lamparter <chunkeey@googlemail.com>, John Youn
 <John.Youn@synopsys.com>
References: <cover.1479339900.git.johnyoun@synopsys.com>
 <2016796.9qgSSGQn9z@debian64>
 <0677657e-043d-c6d4-783e-9b471d12afcb@synopsys.com>
 <1495076.fZ1uLW9fli@debian64>
CC: Rob Herring <robh@kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>,
 Felipe Balbi <balbi@kernel.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>
From: John Youn <John.Youn@synopsys.com>
Message-ID: <dab2e32a-1bd0-2aa5-5a7a-61f2201786b4@synopsys.com>
Date: Mon, 28 Nov 2016 19:32:20 -0800
MIME-Version: 1.0
In-Reply-To: <1495076.fZ1uLW9fli@debian64>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/22/2016 12:51 PM, Christian Lamparter wrote:
> On Monday, November 21, 2016 7:32:30 PM CET John Youn wrote:
>> On 11/21/2016 1:10 PM, Christian Lamparter wrote:
>>> On Monday, November 21, 2016 12:16:31 PM CET John Youn wrote:
>>>> On 11/18/2016 12:18 PM, Christian Lamparter wrote:
>>>>> On Friday, November 18, 2016 8:16:08 AM CET Rob Herring wrote:
>>>>>> Also, perhaps you should allow that the compatible string can define the 
>>>>>> default.
>>>>>>
>>>>> I hoped you would say that :).
>>>>>
>>>>> I've attached a patch (on top of John Youn changes) [...]
>>>>> ---
>>>>> Subject: [PATCH] usb: dwc2: add a default ahb-burst setting for amcc,dwc-otg
>>>>> [...]
>>>>> @@ -1097,6 +1097,22 @@ static const char *const ahb_bursts[] = {
>>>>> +/* [...] */
>>>>> +static const struct of_device_id dwc2_compat_ahb_bursts[] = {
>>>>> +	{
>>>>> +		.compatible = "amcc,dwc-otg",
>>>>> +		.data = (void *) GAHBCFG_HBSTLEN_INCR16,
>>>>> +	},
>>>>> +};
>> [...]
>>>>>> @@ -1107,6 +1123,12 @@ static int dwc2_get_property_ahb_burst(struct dwc2_hsotg *hsotg)
>>>>>  	ret = device_property_read_string(hsotg->dev, "snps,ahb-burst", &str);
>>>>>  	if (ret < 0) {
>>>>> +		const struct of_device_id *match;
>>>>> +
>>>>> +		match = of_match_node(dwc2_compat_ahb_bursts, node);
>>>>> +		if (match)
>>>>> +			ret = (int)match->data;
>>>>> +
>> [...]
>>>> I'd prefer if you use the binding which requires no extra code in
>>>> dwc2.
>>> I'm fine with either option. However it think that this would require
>>> that either Mark or Rob would allow an exception to the "keep existing
>>> dts the way they are) and ack the following change to the canyonlands.dts. 
>>
>> I don't know about that. Under what circumstance can the dts change?
> As far as I know, the justification for not changing the DTS is that a
> compiled DTB might be stored in an read-only ROM on a board. So it would
> be impossible to update it. Hence, the driver have work with the existing
> (and sometimes buggy or incomplete) information to stay compatible.
> 
> (Note: Thankfully, the canyonlands dtb is stored in flash, it's possible
> to update it. But it is an extra step that's not done automatically
> with make install). 
> 
>> The canyonlands dts was binding to an external vendor driver. So it
>> wasn't documented nor expected to work with dwc2 until your recent
>> patch adding the compatible string.
> 
> Oh, no that's not what happend. Let me explain why there was no "external 
> vendor driver": AMCC/APM were planing to upstream their hole platform. And
> in fact, the devs tried very hard to include their driver back in 2011 [0].
> But this driver was denied inclusion back then due to:
> 
> "[...]
> I would also like to point out that the same Synopsys USB controller
> is used in a number of other SoCs (especially ARM chips), and
> supported by other drivers, some of these even in mainline.
> 
> See http://thread.gmane.org/gmane.linux.usb.general/61714/focus=62139
> for a related thread.
> 
> Instead of trying to add a completely new driver to mainline (and one
> which has been repeatedly been rejected), I vote for focusing on the
> existing driver code that is already in mainline, and testing and
> improving this so we can use a single implementation of this driver
> code for all SoCs that use the same IP block." [1]
> 
> Of course: The listed link goes the "USB Host driver for i.MX28" driver.
> And this is an ehci-hcd like driver... Which is as you are well aware not
> that similar to the dwc2 OTG. And as far as I can tell: AMCC abandoned
> the patch series right there. 
> 
> Note: AMCC did however succeed in pushing your employer's Synopsys
> DesignWare SATA and DMA drivers to the kernel back then. And I'm happy
> to report that both drivers are still around and working fine for the 460EX 
> (sata_dwc_460ex.c[2] and the DW AHB DMA [3]). (The drivers also work for
> different platforms than the original PPC. I know that because I helped
> Andy Shevchenko with testing and pushing some fixes to it when he was
> adding support for the Intel Quark SoC, which uses the DWC SATA and DMA).

Ok thanks for clearing that up. I understand.

For now we can just set the property to "INCR16" based on the
compatible string. Perhaps in the future do this from a glue-layer
driver which binds to all compatible strings other than "snps,dwc2".

I won't be able to do anything with this until next week though.

Regards,
John
