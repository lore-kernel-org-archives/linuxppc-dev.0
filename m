Return-Path: <hzpeterchen@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrNKS6mLpzDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 16:42:20 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id t190so5875091pfb.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 23:42:20 -0700 (PDT)
Date: Fri, 15 Jul 2016 14:34:29 +0800
From: Peter Chen <hzpeterchen@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Li Yang <leoli@freescale.com>, Xie Xiaobo <X.Xie@freescale.com>,
 Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] usb: gadget: fsl_qe_udc: off by one in
 setup_received_handle()
Message-ID: <20160715063429.GD817@shlinux2>
References: <20160713101433.GI29468@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160713101433.GI29468@mwanda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 13, 2016 at 01:14:33PM +0300, Dan Carpenter wrote:
> The udc->eps[] array has USB_MAX_ENDPOINTS elements so > should be >=.
> 
> Fixes: 3948f0e0c999 ('usb: add Freescale QE/CPM USB peripheral controller driver')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
> index 93d28cb..cf8819a 100644
> --- a/drivers/usb/gadget/udc/fsl_qe_udc.c
> +++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
> @@ -2053,7 +2053,7 @@ static void setup_received_handle(struct qe_udc *udc,
>  			struct qe_ep *ep;
>  
>  			if (wValue != 0 || wLength != 0
> -				|| pipe > USB_MAX_ENDPOINTS)
> +				|| pipe >= USB_MAX_ENDPOINTS)
>  				break;
>  			ep = &udc->eps[pipe];
>  

Acked-by: Peter Chen <peter.chen@nxp.com>

-- 

Best Regards,
Peter Chen
