Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
 [209.85.217.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A1D4A1A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 21:04:39 +1000 (AEST)
Received: by lblf12 with SMTP id f12so3905788lbl.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 04:04:35 -0700 (PDT)
Subject: Re: [PATCH v2 42/48] usb: gadget: epautoconf: use 'ep_match' gadget
 callback
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org,
 balbi@ti.com
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
 <1436866776-5004-43-git-send-email-r.baldyga@samsung.com>
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com,
 dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com,
 leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, michal.simek@xilinx.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 andrzej.p@samsung.com, m.szyprowski@samsung.com
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <55A4ECC0.4030205@cogentembedded.com>
Date: Tue, 14 Jul 2015 14:04:32 +0300
MIME-Version: 1.0
In-Reply-To: <1436866776-5004-43-git-send-email-r.baldyga@samsung.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 7/14/2015 12:39 PM, Robert Baldyga wrote:

> If gadget has set 'ep_match' callback we prefer to call it first to allow
> UDC driver to find the best matching endpoint basing on chip-specific "best
> usage" knowledge.

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>   drivers/usb/gadget/epautoconf.c | 6 ++++++
>   1 file changed, 6 insertions(+)

> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> index ee0d4e6..92a1a4c 100644
> --- a/drivers/usb/gadget/epautoconf.c
> +++ b/drivers/usb/gadget/epautoconf.c
> @@ -165,6 +165,12 @@ struct usb_ep *usb_ep_autoconfig_ss(
>
>   	type = desc->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK;
>
> +	if (gadget->ops->match_ep) {
> +		ep = gadget->ops->match_ep(gadget, desc, ep_comp);
> +		if (ep)
> +			goto found_ep;
> +	}
> +

    I think this patch should be merged with the previous one.

[...]

WBR, Sergei
