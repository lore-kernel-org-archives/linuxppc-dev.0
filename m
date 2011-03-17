Return-Path: <sshtylyov@mvista.com>
Received: from mail-wy0-f170.google.com (mail-wy0-f170.google.com
	[74.125.82.170]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8C22CB6FDE
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2011 23:49:09 +1100 (EST)
Received: by wyb34 with SMTP id 34so3597039wyb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Mar 2011 05:49:05 -0700 (PDT)
Message-ID: <4D8202EA.1030405@ru.mvista.com>
Date: Thu, 17 Mar 2011 15:47:38 +0300
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: Valentin Longchamp <valentin.longchamp@keymile.com>
Subject: Re: [PATCH 1/1] fsl_qe_udc: send ZLP when zero flag and length %
	maxpacket == 0
References: <1300357858-1288-1-git-send-email-valentin.longchamp@keymile.com>
In-Reply-To: <1300357858-1288-1-git-send-email-valentin.longchamp@keymile.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: dbrownell@users.sourceforge.net, stefan.bigler@keymile.com,
	linux-usb@vger.kernel.org, linuxppc-dev@ozlabs.org,
	holger.brunck@keymile.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 17-03-2011 13:30, Valentin Longchamp wrote:

> The driver did not take the zero flag in the USB request. If the
> request length is the same as the endpoint's maxpacket, an additional
> ZLP with no data has to be transmitted.

> The method used here is inspired to what is done in fsl_udc_core.c
> (and pxa27x_udc.c and at91_udc.c) where this is supported.

> This is the first version of the patch, it may still contain mistakes,
> but I send it as a RFC since there already was a discussion about this
> topic with people from Keymile:

> http://thread.gmane.org/gmane.linux.usb.general/38951

> Signed-off-by: Valentin Longchamp<valentin.longchamp@keymile.com>
> ---
>   drivers/usb/gadget/fsl_qe_udc.c |   28 +++++++++++++++++++++++-----
>   1 files changed, 23 insertions(+), 5 deletions(-)

> diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
> index 8dc15da..08538f5 100644
> --- a/drivers/usb/gadget/fsl_qe_udc.c
> +++ b/drivers/usb/gadget/fsl_qe_udc.c
[...]
> @@ -1158,13 +1164,24 @@ static int txcomplete(struct qe_ep *ep, unsigned char restart)
>   			ep->last = 0;
>   		}
>
> +		/* zlp needed when req->re.zero is set */
> +		if (req->req.zero) {
> +			if (last_len == 0 ||
> +				(req->req.length % ep->ep.maxpacket) != 0)
> +				zlp = 0;
> +			else
> +				zlp = 1;
> +		} else
> +			zlp = 0;
> +
>   		/* a request already were transmitted completely */
>   		if ((ep->tx_req->req.length - ep->sent) <= 0) {
> -			ep->tx_req->req.actual = (unsigned int)ep->sent;
> -			done(ep, ep->tx_req, 0);
> -			ep->tx_req = NULL;
> -			ep->last = 0;
> -			ep->sent = 0;
> +			if (!zlp) {

    This *if* could be collapsed into previous *if*, and so the subsequest 
indentation level not changed.

> +				done(ep, ep->tx_req, 0);
> +				ep->tx_req = NULL;
> +				ep->last = 0;
> +				ep->sent = 0;
> +			}
>   		}
>   	}
>

WBR, Sergei
