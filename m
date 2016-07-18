Return-Path: <hzpeterchen@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
 [209.85.192.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rt5vc3Yh9zDqDy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 11:59:23 +1000 (AEST)
Received: by mail-pf0-f194.google.com with SMTP id y134so6262314pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Jul 2016 18:59:23 -0700 (PDT)
Date: Mon, 18 Jul 2016 09:50:23 +0800
From: Peter Chen <hzpeterchen@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Li Yang <leoli@freescale.com>, Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [patch] usb: gadget: fsl_qe_udc: signedness bug in qe_get_frame()
Message-ID: <20160718015023.GA31293@shlinux2>
References: <20160715111547.GF9258@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160715111547.GF9258@mwanda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 15, 2016 at 02:15:47PM +0300, Dan Carpenter wrote:
> We can't assign -EINVAL to a u16.
> 
> Fixes: 3948f0e0c999 ('usb: add Freescale QE/CPM USB peripheral controller driver')
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
> index 93d28cb..901366f 100644
> --- a/drivers/usb/gadget/udc/fsl_qe_udc.c
> +++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
> @@ -1878,11 +1878,8 @@ static int qe_get_frame(struct usb_gadget *gadget)
>  
>  	tmp = in_be16(&udc->usb_param->frame_n);
>  	if (tmp & 0x8000)
> -		tmp = tmp & 0x07ff;
> -	else
> -		tmp = -EINVAL;
> -
> -	return (int)tmp;
> +		return tmp & 0x07ff;
> +	return -EINVAL;
>  }

Acked-by: Peter Chen <peter.chen@nxp.com>
>  
>  static int fsl_qe_start(struct usb_gadget *gadget,
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 

Best Regards,
Peter Chen
