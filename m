Return-Path: <John.Youn@synopsys.com>
Received: from smtprelay.synopsys.com (smtprelay2.synopsys.com
 [198.182.60.111])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tHm5b5lNhzDvgH
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 09:53:22 +1100 (AEDT)
Subject: Re: [PATCH 2/2] usb: dwc2: fixes host_dma logic
To: Christian Lamparter <chunkeey@googlemail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <b1ec4a4425388cdee36be081971484db2a7d048a.1478897792.git.chunkeey@gmail.com>
 <4043f817106c8dffdc9a3f411d965465168b263d.1478897792.git.chunkeey@gmail.com>
From: John Youn <John.Youn@synopsys.com>
CC: John Youn <John.Youn@synopsys.com>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Felipe Balbi <felipe.balbi@linux.intel.com>
Message-ID: <da778f8f-4038-17b5-6c9c-0585202aecff@synopsys.com>
Date: Mon, 14 Nov 2016 14:53:18 -0800
MIME-Version: 1.0
In-Reply-To: <4043f817106c8dffdc9a3f411d965465168b263d.1478897792.git.chunkeey@gmail.com>
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/11/2016 12:59 PM, Christian Lamparter wrote:
> This patch moves the the host_dma initialization
> before dwc2_set_param_dma_desc_enable and
> dwc2_set_param_dma_desc_fs_enable. The reason being
> that both function need it.
> 
> Fixes: 1205489cee75bf39 ("usb: dwc2: Get host DMA device properties")

This should probably be omitted since it's only in Felipe's
testing/next.

Otherwise looks good.

Acked-by: John Youn <johnyoun@synopsys.com>

Regards,
John


> 
> Cc: John Youn <johnyoun@synopsys.com>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>  drivers/usb/dwc2/params.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 5d822c5..222a83c 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -1157,9 +1157,6 @@ static void dwc2_set_parameters(struct dwc2_hsotg *hsotg,
>  	bool dma_capable = !(hw->arch == GHWCFG2_SLAVE_ONLY_ARCH);
>  
>  	dwc2_set_param_otg_cap(hsotg, params->otg_cap);
> -	dwc2_set_param_dma_desc_enable(hsotg, params->dma_desc_enable);
> -	dwc2_set_param_dma_desc_fs_enable(hsotg, params->dma_desc_fs_enable);
> -
>  	if ((hsotg->dr_mode == USB_DR_MODE_HOST) ||
>  	    (hsotg->dr_mode == USB_DR_MODE_OTG)) {
>  		bool disable;
> @@ -1174,6 +1171,8 @@ static void dwc2_set_parameters(struct dwc2_hsotg *hsotg,
>  				    !disable, false,
>  				    dma_capable);
>  	}
> +	dwc2_set_param_dma_desc_enable(hsotg, params->dma_desc_enable);
> +	dwc2_set_param_dma_desc_fs_enable(hsotg, params->dma_desc_fs_enable);
>  
>  	dwc2_set_param_host_support_fs_ls_low_power(hsotg,
>  			params->host_support_fs_ls_low_power);
> 
