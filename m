Return-Path: <r.baldyga@hackerion.com>
Received: from sender163-mail.zoho.com (sender163-mail.zoho.com
 [74.201.84.163])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 16BC81A0052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2015 02:28:30 +1000 (AEST)
Message-ID: <55D6001E.3000504@hackerion.com>
Date: Thu, 20 Aug 2015 18:28:14 +0200
From: Robert Baldyga <r.baldyga@hackerion.com>
MIME-Version: 1.0
To: balbi@ti.com, Robert Baldyga <r.baldyga@samsung.com>
CC: gregkh@linuxfoundation.org, Peter.Chen@freescale.com,
 johnyoun@synopsys.com, dahlmann.thomas@arcor.de,
 nicolas.ferre@atmel.com, cernekee@gmail.com, leoli@freescale.com,
 daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
 michal.simek@xilinx.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-geode@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 andrzej.p@samsung.com, m.szyprowski@samsung.com,
 stern@rowland.harvard.edu, petr.cvek@tul.cz
Subject: Re: [PATCH v5 01/46] usb: gadget: encapsulate endpoint claiming
 mechanism
References: <1438351258-31578-1-git-send-email-r.baldyga@samsung.com>
 <1438351258-31578-2-git-send-email-r.baldyga@samsung.com>
 <20150820153553.GD1639@saruman.tx.rr.com>
In-Reply-To: <20150820153553.GD1639@saruman.tx.rr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Felipe,

On 08/20/2015 05:35 PM, Felipe Balbi wrote:
[...]
> just letting you know that this regresses all gadget drivers making them
> try to disable previously disabled endpoints and enable previously
> enabled endpoints.
>
> I have a possible fix (see below) but then it shows a problem on the
> host side when using with g_zero (see further below):
>
> commit 3b8932100aacb6cfbffe288ca93025d8b8430c00
> Author: Felipe Balbi <balbi@ti.com>
> Date:   Wed Aug 19 18:05:27 2015 -0500
>
>      usb: gadget: fix ep->claimed lifetime
>
>      In order to fix a regression introduced by commit
>      cc476b42a39d ("usb: gadget: encapsulate endpoint
>      claiming mechanism") we have to introduce a simple
>      helper to check if a particular is enabled or not.
>
>      After that, we need to move ep->claimed lifetime to
>      usb_ep_enable() and usb_ep_disable() since those
>      are the only functions which actually enable and
>      disable endpoints.
>
>      A follow-up patch will come to drop all driver_data
>      checks from function drivers, since those are, now,
>      pointless.
>
>      Fixes: cc476b42a39d ("usb: gadget: encapsulate endpoint
>      	claiming mechanism")
>      Cc: Robert Baldyga <r.baldyga@samsung.com>
>      Signed-off-by: Felipe Balbi <balbi@ti.com>
>
> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> index 978435a51038..ad45070cd76f 100644
> --- a/drivers/usb/gadget/epautoconf.c
> +++ b/drivers/usb/gadget/epautoconf.c
> @@ -126,7 +126,6 @@ found_ep:
>   	ep->address = desc->bEndpointAddress;
>   	ep->desc = NULL;
>   	ep->comp_desc = NULL;
> -	ep->claimed = true;

Removing this line causes autoconfig can return the same endpoint many 
times. This probably causes problems with g_zero.

I will try to fix it ASAP.

Thanks,
Robert
