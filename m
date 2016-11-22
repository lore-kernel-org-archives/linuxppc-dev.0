Return-Path: <John.Youn@synopsys.com>
Received: from smtprelay.synopsys.com (us01smtprelay-2.synopsys.com
 [198.182.60.111])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tN9yX02kszDvPZ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 14:32:35 +1100 (AEDT)
Subject: Re: [PATCH v2 2/4] usb: dwc2: Add binding for AHB burst
To: Christian Lamparter <chunkeey@googlemail.com>, John Youn
 <John.Youn@synopsys.com>
References: <cover.1479339900.git.johnyoun@synopsys.com>
 <6396482.jQaH1ArAfZ@debian64>
 <e01e1b30-a399-94cc-33c9-625008b31d4b@synopsys.com>
 <2016796.9qgSSGQn9z@debian64>
From: John Youn <John.Youn@synopsys.com>
CC: Rob Herring <robh@kernel.org>, Stefan Wahren <stefan.wahren@i2se.com>,
 Felipe Balbi <balbi@kernel.org>, "linux-usb@vger.kernel.org"
 <linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>, "Benjamin
 Herrenschmidt" <benh@kernel.crashing.org>
Message-ID: <0677657e-043d-c6d4-783e-9b471d12afcb@synopsys.com>
Date: Mon, 21 Nov 2016 19:32:30 -0800
MIME-Version: 1.0
In-Reply-To: <2016796.9qgSSGQn9z@debian64>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/2016 1:10 PM, Christian Lamparter wrote:
> Hello John,
> 
> On Monday, November 21, 2016 12:16:31 PM CET John Youn wrote:
>> On 11/18/2016 12:18 PM, Christian Lamparter wrote:
>>> On Friday, November 18, 2016 8:16:08 AM CET Rob Herring wrote:
>>>> On Thu, Nov 17, 2016 at 04:35:10PM +0100, Stefan Wahren wrote:
>>>>> Hi John,
>>>>>
>>>>> Am 17.11.2016 um 00:47 schrieb John Youn:
>>>>>> Add the "snps,ahb-burst" binding and read it in.
>>>>>>
>>>>>> This property controls which burst type to perform on the AHB bus as a
>>>>>> master in internal DMA mode. This overrides the legacy param value,
>>>>>> which we need to keep around for now since several platforms use it.
>>>>>>
>>>>>> Some platforms may see better or worse performance based on this
>>>>>> value. The HAPS platform is one example where all INCRx have worse
>>>>>> performance than INCR.
>>>>>>
>>>>>> Other platforms (such as the Canyonlands board) report that the default
>>>>>> value causes system hangs.
>>>>>>
>>>>>> Signed-off-by: John Youn <johnyoun@synopsys.com>
>>>>>> Cc: Christian Lamparter <chunkeey@googlemail.com>
>>>>>> ---
>>>>>>  Documentation/devicetree/bindings/usb/dwc2.txt |  2 +
>>>>>>  drivers/usb/dwc2/core.h                        |  9 +++++
>>>>>>  drivers/usb/dwc2/params.c                      | 56 ++++++++++++++++++++++++++
>>>>>>  3 files changed, 67 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
>>>>>> index 6c7c2bce..9e7b4b4 100644
>>>>>> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
>>>>>> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
>>>>>
>>>>> according to Documentation/devicetree/bindings/submitting-patches.txt
>>>>> this change should be a separate patch.
>>>>>
>>>>>> @@ -26,6 +26,8 @@ Optional properties:
>>>>>>  Refer to phy/phy-bindings.txt for generic phy consumer properties
>>>>>>  - dr_mode: shall be one of "host", "peripheral" and "otg"
>>>>>>    Refer to usb/generic.txt
>>>>>> +- snps,ahb-burst: specifies the ahb burst length. Valid arguments are:
>>>>>> +  "SINGLE", "INCR", "INCR4", "INCR8", "INCR16". Defaults to "INCR4".
>>>>>
>>>>> This doesn't apply in case of the bcm2835. I would prefer this option is
>>>>> ignored in that case with a dev_warn("snps,ahb-burst is not supported on
>>>>> this platform").
>>>>
>>>> Also, perhaps you should allow that the compatible string can define the 
>>>> default.
>>>>
>>> I hoped you would say that :).
>>>
>>> I've attached a patch (on top of John Youn changes) that does
>>> just that for the amcc,dwc-otg. I put the GAHBCFG_HBSTLEN_INCR
>>> value into the .data, if that's a problem, I can certainly 
>>> respin the patch and put it in a dedicated struct.
>>>
>>> Regards
>>>
>>> Christian
>>> ---
>>> From 4c31a029dde714828810b1c3e61a5b1412ac939a Mon Sep 17 00:00:00 2001
>>> From: Christian Lamparter <chunkeey@gmail.com>
>>> Date: Fri, 18 Nov 2016 21:03:19 +0100
>>> Subject: [PATCH] usb: dwc2: add a default ahb-burst setting for amcc,dwc-otg
>>>
>>> This patch adds a of_device_id table which can be used by
>>> existing devices to supply a ahb-burst value for the platform
>>> without having to add a "snps,ahb-burst" entry to the dts.
>>>
>>> Note: Adding new devices to this table is discouraged.
>>>       please consider adding the "snps,ahb-burst" property
>>>       with the correct configuration to your device tree
>>>       file instead.
>>>
>>> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
>>> ---
>>>  drivers/usb/dwc2/params.c | 22 ++++++++++++++++++++++
>>>  1 file changed, 22 insertions(+)
>>>
>>> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
>>> index e0fc9aa..51be266 100644
>>> --- a/drivers/usb/dwc2/params.c
>>> +++ b/drivers/usb/dwc2/params.c
>>> @@ -1097,6 +1097,22 @@ static const char *const ahb_bursts[] = {
>>>  	[GAHBCFG_HBSTLEN_INCR16]	= "INCR16",
>>>  };
>>>  
>>> +/*
>>> + * This table provides AHB burst configuration for existing
>>> + * device tree bindings that work poorly with the default setting.
>>> + *
>>> + * Note: Adding new devices to this table is discouraged.
>>> + *	 please consider adding the "snps,ahb-burst" property
>>> + *	 with the correct configuration to your device tree
>>> + *	 file instead.
>>> + */
>>> +static const struct of_device_id dwc2_compat_ahb_bursts[] = {
>>> +	{
>>> +		.compatible = "amcc,dwc-otg",
>>> +		.data = (void *) GAHBCFG_HBSTLEN_INCR16,
>>> +	},
>>> +};
>>> +
>>>  static int dwc2_get_property_ahb_burst(struct dwc2_hsotg *hsotg)
>>>  {
>>>  	struct device_node *node = hsotg->dev->of_node;
>>> @@ -1107,6 +1123,12 @@ static int dwc2_get_property_ahb_burst(struct dwc2_hsotg *hsotg)
>>>  	ret = device_property_read_string(hsotg->dev,
>>>  					  "snps,ahb-burst", &str);
>>>  	if (ret < 0) {
>>> +		const struct of_device_id *match;
>>> +
>>> +		match = of_match_node(dwc2_compat_ahb_bursts, node);
>>> +		if (match)
>>> +			ret = (int)match->data;
>>> +
>>>  		return ret;
>>>  	} else if (of_device_is_compatible(node, "brcm,bcm2835-usb")) {
>>>  		dev_warn(hsotg->dev,
>>>
>> I'd prefer if you use the binding which requires no extra code in
>> dwc2.
> I'm fine with either option. However it think that this would require
> that either Mark or Rob would allow an exception to the "keep existing
> dts the way they are) and ack the following change to the canyonlands.dts. 

I don't know about that. Under what circumstance can the dts change?

The canyonlands dts was binding to an external vendor driver. So it
wasn't documented nor expected to work with dwc2 until your recent
patch adding the compatible string.

Systems that use the vendor driver will still work with the dts. If
you remove the vendor driver and configure it to use dwc2, it won't
work due to a quirk of the canyonlands hardware, for which you need to
add a dts property.

I think this is reasonable. Rob or Mark, any feedback?

One of the reasons I don't want to add the code in dwc2 is because I'm
trying to make dwc2 a generic IP driver like dwc3.

Regards,
John

> 
> In that case I wouldn't need the overwrite in dwc2_get_property_ahb_burst.
> 
> Regards,
> Christian
> ---
> From e78604cb0b8ea8db277ef9bf321a613f8e0c7129 Mon Sep 17 00:00:00 2001
> From: Christian Lamparter <chunkeey@gmail.com>
> Date: Mon, 21 Nov 2016 21:46:19 +0100
> Subject: [PATCH] powerpc/dts: set snps,ahb-burst to INCR16
> 
> The dwc2 driver defaults to INCR4 which can cause a
> system hang when the USB and SATA is used concurrently.
> 
> Note: This patch requires:
> 	"usb: dwc2: add amcc,dwc-otg support"
> 	(which already landed in the usb subsystem queue)
> 	and "usb: dwc2: Add AHB burst configuration"
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>  arch/powerpc/boot/dts/canyonlands.dts | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/powerpc/boot/dts/canyonlands.dts b/arch/powerpc/boot/dts/canyonlands.dts
> index 0d6ac92..90db712 100644
> --- a/arch/powerpc/boot/dts/canyonlands.dts
> +++ b/arch/powerpc/boot/dts/canyonlands.dts
> @@ -179,6 +179,7 @@
>  
>  		USBOTG0: usbotg@bff80000 {
>  			compatible = "amcc,dwc-otg";
> +			snps,ahb-burst = "INCR16";
>  			reg = <0x4 0xbff80000 0x10000>;
>  			interrupt-parent = <&USBOTG0>;
>  			#interrupt-cells = <1>;
> 
