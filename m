Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
 [209.85.215.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 804311A02AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 21:11:08 +1000 (AEST)
Received: by lahh5 with SMTP id h5so3929782lah.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 04:11:04 -0700 (PDT)
Subject: Re: [PATCH v2 47/48] usb: musb: gadget: add musb_match_ep() function
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org,
 balbi@ti.com
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
 <1436866776-5004-48-git-send-email-r.baldyga@samsung.com>
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com,
 dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com,
 leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, michal.simek@xilinx.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 andrzej.p@samsung.com, m.szyprowski@samsung.com
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <55A4EE46.6000402@cogentembedded.com>
Date: Tue, 14 Jul 2015 14:11:02 +0300
MIME-Version: 1.0
In-Reply-To: <1436866776-5004-48-git-send-email-r.baldyga@samsung.com>
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

> Add 'match_ep' callback to utilize chip-specific knowledge in endpoint matching
> process. Functions does the same that was done by chip-specific code inside
> of epautoconf. Now this code can be removed from there to separate generic code
> from platform specific logic.

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

[...]
> diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
> index 043248a..5f1eb35 100644
> --- a/drivers/usb/musb/musb_gadget.c
> +++ b/drivers/usb/musb/musb_gadget.c
> @@ -1684,6 +1684,49 @@ static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
>   	return 0;
>   }
>
> +#ifdef CONFIG_BLACKFIN
> +static struct usb_ep *musb_find_ep(struct usb_gadget *g,
> +		const char *name)
> +{
> +	struct usb_ep *ep;
> +
> +	list_for_each_entry(ep, &g->ep_list, ep_list) {
> +		if (0 == strcmp(ep->name, name))

    Please make the immediate value the 2nd operand of ==.

> +			return ep;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct usb_ep *match_match_ep(struct usb_gadget *g,
> +		struct usb_endpoint_descriptor *desc,
> +		struct usb_ss_ep_comp_descriptor *ep_comp)
> +{
> +	struct usb_ep *ep = NULL;
> +	u8 type = usb_endpoint_type(desc);
> +
> +	if ((USB_ENDPOINT_XFER_BULK == type) ||
> +			(USB_ENDPOINT_XFER_ISOC == type)) {

    Likewise.

> +		if (USB_DIR_IN & desc->bEndpointAddress)

    The same about &.

> +			ep = musb_find_ep(g, "ep5in");
> +		else
> +			ep = musb_find_ep(g, "ep6out");
> +	} else if (USB_ENDPOINT_XFER_INT == type) {

    Likewise.

> +		if (USB_DIR_IN & desc->bEndpointAddress)
> +			ep = musb_find_ep(g, "ep1in");
> +		else
> +			ep = musb_find_ep(g, "ep2out");
> +	}

    This string of *if* statements is asking to be *switch* instead.

[...]

WBR, Sergei
