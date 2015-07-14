Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lb0-f182.google.com (mail-lb0-f182.google.com
 [209.85.217.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EE6321A08ED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 21:14:58 +1000 (AEST)
Received: by lbbpo10 with SMTP id po10so4035216lbb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 04:14:56 -0700 (PDT)
Subject: Re: [PATCH v2 45/48] usb: gadget: net2280: add net2280_match_ep()
 function
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org,
 balbi@ti.com
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
 <1436866776-5004-46-git-send-email-r.baldyga@samsung.com>
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com,
 dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com,
 leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, michal.simek@xilinx.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 andrzej.p@samsung.com, m.szyprowski@samsung.com
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <55A4EF2E.9090306@cogentembedded.com>
Date: Tue, 14 Jul 2015 14:14:54 +0300
MIME-Version: 1.0
In-Reply-To: <1436866776-5004-46-git-send-email-r.baldyga@samsung.com>
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
> diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
> index 0295cf7..4933321 100644
> --- a/drivers/usb/gadget/udc/net2280.c
> +++ b/drivers/usb/gadget/udc/net2280.c
> @@ -1533,6 +1533,49 @@ static int net2280_pullup(struct usb_gadget *_gadget, int is_on)
>   	return 0;
>   }
>
> +static struct usb_ep *net2280_find_ep(struct usb_gadget *_gadget,
> +		const char *name)

    Shouldn't this be a generic function as before?

> +{
> +	struct usb_ep *ep;
> +
> +	list_for_each_entry(ep, &_gadget->ep_list, ep_list) {
> +		if (0 == strcmp(ep->name, name))

    Please make 0 the 2nd operand to ==.

> +			return ep;
> +	}
> +
> +	return NULL;
> +}
[...]

WBR, Sergei
