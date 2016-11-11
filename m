Return-Path: <John.Youn@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay.synopsys.com [198.182.60.111])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFvh26PMQzDvv7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 09:28:18 +1100 (AEDT)
Subject: Re: [PATCH 1/2] usb: dwc2: add amcc,dwc-otg support
To: Christian Lamparter <chunkeey@googlemail.com>, John Youn
 <John.Youn@synopsys.com>
References: <b1ec4a4425388cdee36be081971484db2a7d048a.1478897792.git.chunkeey@gmail.com>
 <bfd8be90-930d-1648-e663-0e0e8c496e02@synopsys.com>
 <1546251.ssrfyj8Loe@debian64>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Mark Rutland
 <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Felipe Balbi <felipe.balbi@linux.intel.com>
From: John Youn <John.Youn@synopsys.com>
Message-ID: <caf17dcd-c7c5-e202-cde4-7c8702b5868b@synopsys.com>
Date: Fri, 11 Nov 2016 14:20:42 -0800
MIME-Version: 1.0
In-Reply-To: <1546251.ssrfyj8Loe@debian64>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/11/2016 2:05 PM, Christian Lamparter wrote:
> Hello,
> 
> On Friday, November 11, 2016 1:22:16 PM CET John Youn wrote:
>> On 11/11/2016 12:59 PM, Christian Lamparter wrote:
>>> This patch adds support for the "amcc,usb-otg" device
>>> which is found in the PowerPC Canyonlands' dts.
>>>
>>> The device definition was added by:
>>> commit c89b3458d8cc ("powerpc/44x: Add USB DWC DTS entry to Canyonlands board")'
>>> but without any driver support as the dwc2 driver wasn't
>>> available at that time.
>>>
>>> Note: The system can't use the generic "snps,dwc2" compatible
>>> because of the special ahbcfg configuration. The default
>>> GAHBCFG_HBSTLEN_INCR4 of snps,dwc2 can cause a system hang
>>> when the USB and SATA is used concurrently.
>>
>> I don't want to add any more of these param structures to the driver
>> unless really necessary. We're trying to remove usage of them in favor
>> of using auto-detected defaults and device properties to override
>> them.
> Ok, thanks. I think that would work. I've attached an updated patch.
> Can it be applied/queued now? Or do you want me to resent it later?
> 
>> The AHB Burst is actually one of the ones we were going to do next
>> because our platform also doesn't work well with INCR4. In fact I'm
>> thinking of making the default INCR.
> Is that actually possible to change the default still? This would
> require to re-evaluate all existing archs/platforms that use 
> "snps,dwc2" for INCR16 compatibility. 

INCR, not INCR16, but you're right, so we may not change it even
though though INCR is usually the right choice over INCR4.

Anyways, with the binding, can't you just set the compatible string to
snps,dwc2?

Regards,
John


> 
> From what I can tell based would be:
> bcm11351, bcm21664, bcm23550, exynos3250, stm32f429, rk3xxx,
> stratix10, meson-gxbb, rt3050 and some Altera FPGAs.
> 
>> If that's all you need then a devicetree binding should be enough
>> right?
> Yes. The device is working fine so far.
> 
> Regards,
> Christian
> 
> ---
> From 70dd4be016b89655a56bc8260f04683b50f07644 Mon Sep 17 00:00:00 2001
> From: Christian Lamparter <chunkeey@gmail.com>
> Date: Sun, 6 Nov 2016 00:39:24 +0100
> Subject: [PATCH] usb: dwc2: add amcc,dwc-otg support
> 
> This patch adds support for the "amcc,usb-otg" device
> which is found in the PowerPC Canyonlands' dts.
> 
> The device definition was added by:
> commit c89b3458d8cc ("powerpc/44x: Add USB DWC DTS entry to Canyonlands board")'
> but without any driver support as the dwc2 driver wasn't
> available at that time.
> 
> Note: The system can't use the generic "snps,dwc2" compatible
> because of the special ahbcfg configuration. The default
> GAHBCFG_HBSTLEN_INCR4 of snps,dwc2 can cause a system hang
> when the USB and SATA is used concurrently.
> 
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: John Youn <johnyoun@synopsys.com>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
> v1->v2:
> 	- moved definitons to params.c
> 	- removed dma_enable / host_dma parameter
> 	- added dma_desc_fs_enable parameter
> v2->v3:
> 	- removed parameters
> 
> Please queue this patch until GAHBCFG_HBSTLEN_INCR16 is the default
> for ahbcfg.
> ---
>  Documentation/devicetree/bindings/usb/dwc2.txt | 1 +
>  drivers/usb/dwc2/params.c                      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
> index 10a2a4b..6ccfe85 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc2.txt
> @@ -12,6 +12,7 @@ Required properties:
>    - "lantiq,xrx200-usb": The DWC2 USB controller instance in Lantiq XRX SoCs;
>    - "amlogic,meson8b-usb": The DWC2 USB controller instance in Amlogic Meson8b SoCs;
>    - "amlogic,meson-gxbb-usb": The DWC2 USB controller instance in Amlogic S905 SoCs;
> +  - "amcc,dwc-otg": The DWC2 USB controller instance in AMCC Canyonlands 460EX SoCs;
>    - snps,dwc2: A generic DWC2 USB controller with default parameters.
>  - reg : Should contain 1 register range (address and length)
>  - interrupts : Should contain 1 interrupt
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 64d5c66..9506ab0 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -239,6 +239,7 @@ const struct of_device_id dwc2_of_match_table[] = {
>  	{ .compatible = "samsung,s3c6400-hsotg", .data = NULL},
>  	{ .compatible = "amlogic,meson8b-usb", .data = &params_amlogic },
>  	{ .compatible = "amlogic,meson-gxbb-usb", .data = &params_amlogic },
> +	{ .compatible = "amcc,dwc-otg", .data = NULL },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dwc2_of_match_table);
> 
