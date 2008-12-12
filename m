Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2731DDE04B
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Dec 2008 06:36:50 +1100 (EST)
Subject: Re: powerbook VT garbled between rc7 and rc8
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <jeprjxphfl.fsf@sykes.suse.de>
References: <1229078554.3600.8.camel@johannes.berg>
	<je7i65r42j.fsf@sykes.suse.de> <1229092999.3600.10.camel@johannes.berg>
	<jeprjxphfl.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Sat, 13 Dec 2008 06:36:42 +1100
Message-Id: <1229110602.22413.215.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Johannes Berg <johannes@sipsolutions.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-12-12 at 16:00 +0100, Andreas Schwab wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
> > On Fri, 2008-12-12 at 13:05 +0100, Andreas Schwab wrote:
> >> Johannes Berg <johannes@sipsolutions.net> writes:
> >> 
> >> > After upgrading to -rc8 yesterday my powerbook started up today with the
> >> > screen totally garbled, only occasionally was a word readable.
> >> 
> >> Try 6c34bc2976b30dc8b56392c020e25bae1f363cab (Revert "radeonfb:
> >> accelerate imageblit and other improvements").
> >
> > That's post -rc8, ok, but -rc7 worked fine here, and the stuff it
> > reverts is all pre -rc7, no? Strange. I'll try later.
> 
> This appears to be a side effect of setting up info->pixmap in
> radeon_set_fbinfo even if accel_cexp is 0.  Alternatively to the cited
> patch you can also use something like this:

Right but Linus just reverted the whole thing. Which is probably the way
to go. I'll try to fix the fbdev core itself one of these days, it's
seriously broken vs. handling of pitch in images.

Ben.

> diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
> index d5b27f9..532e2c5 100644
> --- a/drivers/video/aty/radeon_base.c
> +++ b/drivers/video/aty/radeon_base.c
> @@ -1895,6 +1895,9 @@ static int __devinit radeon_set_fbinfo (struct radeonfb_info *rinfo)
>  	/* Allocate colormap */
>  	fb_alloc_cmap(&info->cmap, 256, 0);
>  
> +	if (!accel_cexp)
> +		goto bail;
> +
>  	/* Setup pixmap used for acceleration */
>  #define PIXMAP_SIZE	(2048 * 4)
>  
> 
> Andreas.
> 
