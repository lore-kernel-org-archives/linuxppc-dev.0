Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-la0-f48.google.com (mail-la0-f48.google.com
 [209.85.215.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D77EB1A1967
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 21:16:33 +1000 (AEST)
Received: by lagw2 with SMTP id w2so3977497lag.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jul 2015 04:16:30 -0700 (PDT)
Subject: Re: [PATCH v2 48/48] usb: gadget: epautoconf: cleanup dead code
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org,
 balbi@ti.com
References: <1436866776-5004-1-git-send-email-r.baldyga@samsung.com>
 <1436866776-5004-49-git-send-email-r.baldyga@samsung.com>
Cc: Peter.Chen@freescale.com, johnyoun@synopsys.com,
 dahlmann.thomas@arcor.de, nicolas.ferre@atmel.com, cernekee@gmail.com,
 leoli@freescale.com, daniel@zonque.org, haojian.zhuang@gmail.com,
 robert.jarzmik@free.fr, michal.simek@xilinx.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 andrzej.p@samsung.com, m.szyprowski@samsung.com
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <55A4EF8B.7090806@cogentembedded.com>
Date: Tue, 14 Jul 2015 14:16:27 +0300
MIME-Version: 1.0
In-Reply-To: <1436866776-5004-49-git-send-email-r.baldyga@samsung.com>
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

> Function find_ep() is no longer needed here, so we can remove it.
> We also don't use anything from gadget_chips.h header any longer.

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>   drivers/usb/gadget/epautoconf.c | 14 --------------
>   1 file changed, 14 deletions(-)

> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> index e9a8682..9a80925 100644
> --- a/drivers/usb/gadget/epautoconf.c
> +++ b/drivers/usb/gadget/epautoconf.c
> @@ -20,20 +20,6 @@
>   #include <linux/usb/ch9.h>
>   #include <linux/usb/gadget.h>
>
> -#include "gadget_chips.h"
> -
> -static struct usb_ep *
> -find_ep (struct usb_gadget *gadget, const char *name)
> -{
> -	struct usb_ep	*ep;
> -
> -	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
> -		if (0 == strcmp (ep->name, name))
> -			return ep;
> -	}
> -	return NULL;
> -}
> -

    I don't think duplicating the function in each driver that needs it is 
better than turniong this function into public.

WBR, Sergei
