Return-Path: <sshtylyov@mvista.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E37072C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 22:33:04 +1000 (EST)
Received: by lags15 with SMTP id s15so243873lag.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Sep 2012 05:33:00 -0700 (PDT)
Message-ID: <50474637.6000800@mvista.com>
Date: Wed, 05 Sep 2012 16:31:51 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Subject: Re: [PATCH] usb: gadget: fsl_udc_core: remove mapped flag
References: <1346779499-6085-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
In-Reply-To: <1346779499-6085-1-git-send-email-enrico.scholz@sigma-chemnitz.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, balbi@ti.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 04-09-2012 21:24, Enrico Scholz wrote:

> The 'mapped' flag in 'struct fsl_req' flag is redundant with checking
> for 'req.dma != DMA_ADDR_INVALID' and it was also set to a wrong value
> (see 2nd hunk of patch).

> Replacing it in the way described above saves 60 bytes:

>    function                                     old     new   delta
>    fsl_udc_irq                                 2952    2940     -12
>    ep0_prime_status                             380     368     -12
>    done                                         448     432     -16
>    fsl_ep_queue                                 668     648     -20

> and has same (or less) runtime costs like evaluating 'req->mapped'.

> Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
> ---
>   drivers/usb/gadget/fsl_udc_core.c | 10 ++--------
>   drivers/usb/gadget/fsl_usb2_udc.h |  1 -
>   2 files changed, 2 insertions(+), 9 deletions(-)

> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
> index 55c4a61..1282a11 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -195,14 +195,13 @@ static void done(struct fsl_ep *ep, struct fsl_req *req, int status)
>   		dma_pool_free(udc->td_pool, curr_td, curr_td->td_dma);
>   	}
>
> -	if (req->mapped) {
> +	if (req->req.dma != DMA_ADDR_INVALID) {
>   		dma_unmap_single(ep->udc->gadget.dev.parent,
>   			req->req.dma, req->req.length,
>   			ep_is_in(ep)
>   				? DMA_TO_DEVICE
>   				: DMA_FROM_DEVICE);
>   		req->req.dma = DMA_ADDR_INVALID;
> -		req->mapped = 0;
>   	} else
>   		dma_sync_single_for_cpu(ep->udc->gadget.dev.parent,
>   			req->req.dma, req->req.length,
> @@ -915,15 +914,12 @@ fsl_ep_queue(struct usb_ep *_ep, struct usb_request *_req, gfp_t gfp_flags)
>   					req->req.length, ep_is_in(ep)
>   						? DMA_TO_DEVICE
>   						: DMA_FROM_DEVICE);
> -		req->mapped = 1;
> -	} else {
> +	} else

    You should keep the { here, according to the Documentation/CodingStyle.
If one branch of the *if* statement uses {}, so should the other.

WBR, Sergei
