Return-Path: <chf.fritz@googlemail.com>
Received: from mail-wg0-f45.google.com (mail-wg0-f45.google.com [74.125.82.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D29D8B7010
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 May 2012 08:51:36 +1000 (EST)
Received: by wgbdt14 with SMTP id dt14so3840265wgb.14
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 May 2012 15:51:32 -0700 (PDT)
Date: Mon, 14 May 2012 00:51:26 +0200
From: Christoph Fritz <chf.fritz@googlemail.com>
To: Fabio Estevam <festevam@gmail.com>, Neil Zhang <zhangwm@marvell.com>,
 Li Yang <leoli@freescale.com>, Felipe Balbi <balbi@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "Hans J. Koch" <hjk@hansjkoch.de>, Daniel Mack <daniel@caiaq.de>
Subject: Re: [RFC] [PATCH] usb: gadget: fix dtd dma confusion
Message-ID: <20120513225126.GA3683@lovely.krouter>
References: <F281D0F91ED19E4D8E63A7504E8A64980AFFE3@039-SN2MPN1-022.039d.mgd.msft.net>
 <CAOMZO5AjQsNw7_4ETkB38mmuBXj4pnCwJwAsi4zC4b_83=Enfw@mail.gmail.com>
 <20120409200656.GD2640@local>
 <CAOMZO5BTrA8G6wwQZ3e6bydJX7UtG7jj2c29Ln7u_3_jyUGB+w@mail.gmail.com>
 <20120410001017.GF2640@local>
 <CAOMZO5A=sHeyoQ0PCd=09qGGKb0NjXi-kF5qyG+3U-GhD7rhzg@mail.gmail.com>
 <20120410021151.GB23044@lovely.krouter>
 <20120411073918.GA9180@lovely.krouter>
 <CAOMZO5C729Ki0Bequ+s1nnrgt4NZWvwg3Wnjk4kHp=d9BtkeXw@mail.gmail.com>
 <20120509000221.GA19525@lovely.krouter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120509000221.GA19525@lovely.krouter>
Cc: Oliver Neukum <oneukum@suse.de>, Kukjin Kim <kgene.kim@samsung.com>,
 Eric Miao <eric.y.miao@gmail.com>, Chen Peter-B29397 <B29397@freescale.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Nicolas Ferre <nicolas.ferre@atmel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Estevam Fabio-R49496 <r49496@freescale.com>,
 Ido Shayevitz <idos@codeaurora.org>, Ben Dooks <ben-linux@fluff.org>,
 Thomas Dahlmann <dahlmann.thomas@arcor.de>,
 Russell King <linux@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 09, 2012 at 02:02:22AM +0200, Christoph Fritz wrote:
> 
> Hi to All,
> 
> after a while of testing and searching I can come up with a patch
> that fixes g_ether <-> iperf for fsl_udc on ARM i.MX35.
> 
> The sad part is that this kind of fix is already implemented for
> marvell mv_udc driver since last year but still _not_ in the ~15
> other *udc.c drivers.
> 
> See here:
> daec765da767e4a6a30e1298862b28f2cae9a73f
> usb: gadget: mv_udc: fix dtd dma confusion
> 
> So hereby I'm CC-ing all *udc.c maintainers to point out that this
> issue maybe affects you too.
> 
> 
> ---
> Subject: [PATCH] usb: gadget: fsl_udc: fix dtd dma confusion
> 
> The controller will hang when doing testings with g_ether and iperf
> (tool for measuring maximum TCP and UDP bandwidth).  This patch adds a
> delay to wait for controller to release dtd dma before freeing it.
> 
> Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
> ---
>  drivers/usb/gadget/fsl_udc_core.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/usb/gadget/fsl_udc_core.c b/drivers/usb/gadget/fsl_udc_core.c
> index 55abfb6..fc86108 100644
> --- a/drivers/usb/gadget/fsl_udc_core.c
> +++ b/drivers/usb/gadget/fsl_udc_core.c
> @@ -1638,6 +1638,15 @@ static int process_ep_req(struct fsl_udc *udc, int pipe,
>  			status = REQ_UNCOMPLETE;
>  			return status;
>  		} else if (remaining_length) {
> +			/* wait controller release dtd dma */
> +			while ((curr_qh->curr_dtd_ptr == curr_td->td_dma)) {
> +				if (curr_td->next_td_ptr ==
> +						EP_QUEUE_HEAD_NEXT_TERMINATE) {
> +					udelay(100);
> +					break;
> +				}
> +				udelay(1);
> +			}
>  			if (direction) {
>  				VDBG("Transmit dTD remaining length not zero");
>  				status = -EPROTO;
> -- 
> 1.7.2.5

 ping  -  what about this patch? Will it be applied?

Thanks,
 -- Christoph
 
