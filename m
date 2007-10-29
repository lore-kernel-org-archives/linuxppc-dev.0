Return-Path: <dtor@insightbb.com>
Received: from mxsf08.insightbb.com (mxsf08.insightbb.com [74.128.0.78])
	by ozlabs.org (Postfix) with ESMTP id 0D6B7DDE44
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Oct 2007 13:21:30 +1100 (EST)
From: Dmitry Torokhov <dtor@insightbb.com>
To: Joseph Jezak <josejx@woodpecker.gentoo.org>
Subject: Re: [PATCH] Prevent appletouch message log spam on 17" PB
Date: Sun, 28 Oct 2007 22:21:25 -0400
References: <20071028235319.GB16301@woodpecker.gentoo.org>
In-Reply-To: <20071028235319.GB16301@woodpecker.gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710282221.26241.dtor@insightbb.com>
Cc: linuxppc-dev@ozlabs.org, valderman@gmail.com,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Joseph,

On Sunday 28 October 2007 19:53, Joseph Jezak wrote:
> Perhaps this was a debugging message?  In any case, this printk
> causes lots of message log spam on my PB G4 1.67" (PowerBook5,9).
> 
> This removes the printk.
> 

I don't think we want do delete this message outright, we just need
to make sure we don't go through size detection when we re-initialize
the device. After all it is unlikely that touchpad will change its
size :)

BTW, could you tell me what product ID your touchpad has?

> Signed-off by: Joseph Jezak <josejx@gentoo.org>
> ---
> 
> diff --git a/drivers/input/mouse/appletouch.c b/drivers/input/mouse/appletouch.c
> index f132702..6c47641 100644
> --- a/drivers/input/mouse/appletouch.c
> +++ b/drivers/input/mouse/appletouch.c
> @@ -433,7 +433,6 @@ static void atp_complete(struct urb* urb)
>  		for (i = (atp_is_geyser_2(dev)?15:16); i < ATP_XSENSORS; i++) {
>  			if (!dev->xy_cur[i]) continue;
>  
> -			printk("appletouch: 17\" model detected.\n");
>  			if(atp_is_geyser_2(dev))
>  				input_set_abs_params(dev->input, ABS_X, 0,
>  						     (20 - 1) *
> 

-- 
Dmitry
