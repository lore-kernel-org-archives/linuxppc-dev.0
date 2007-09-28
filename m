Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28113DDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Sep 2007 09:04:23 +1000 (EST)
Subject: Re: Powerbook shuts down hard when hot, patch found
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
In-Reply-To: <200709282332.52819.mb@bu3sch.de>
References: <200709282332.52819.mb@bu3sch.de>
Content-Type: text/plain
Date: Sat, 29 Sep 2007 09:04:13 +1000
Message-Id: <1191020653.6158.90.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2007-09-28 at 23:32 +0200, Michael Buesch wrote:
> Hi,
> 
> some time ago I already mailed you about this problem.
> I will quickly describe what's going on, again:
> 
> My powerbook boots fine when it's cold. You can work with
> it and you can also run it hot (compile something, etc...).
> But when you try to boot it while it is hot, it will
> automatically shutdown hard inside of the boot process.
> Some part of the hardware is shutting it down.
> This does not happen when it's getting hot _after_ boot.
> Only while boot when it's hot.
> 
> I bisected the problem and found out that the following patch
> is responsible for this. Yeah, this sounds a little bit
> crazy, as this patch does not seem to be related to
> this at all. But I confirmed it by booting kernel
> 4f71c5de19c27f2198105d3b26b398494d5c353b
> That kernel triggered the bug. Then I patch -R the patch below
> and it booted properly, even when hot. I also rechecked
> that it really was hot enough to trigger the event by
> immediately rebooting into a known bad kernel, that immediately
> shut down the pbook, as expected.
> So I'm pretty sure it's the patch below causing this weird
> behaviour. Any idea why?

This is very strange... Can you try also clearing VGA_DDC_CLK_OUT_EN and
VGA_DDC_DATA_OUT_EN and the same time and see if that helps ?

> 
> commit 4f71c5de19c27f2198105d3b26b398494d5c353b
> Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date:   Fri Nov 17 15:35:00 2006 +1100
> 
>     [PATCH] Fix radeon DDC regression
>     
>     When radeonfb was changed to use the new "generic" ddc, a bit of
>     code initializing the GPIO lines was lost, causing it to not work
>     if the firmware didn't configure them properly, which seems to
>     happen on some cards.
>     
>     Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> diff --git a/drivers/video/aty/radeon_i2c.c b/drivers/video/aty/radeon_i2c.c
> index 6767545..869725a 100644
> --- a/drivers/video/aty/radeon_i2c.c
> +++ b/drivers/video/aty/radeon_i2c.c
> @@ -139,7 +139,13 @@ void radeon_delete_i2c_busses(struct rad
>  int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn,
>  			       u8 **out_edid)
>  {
> -	u8 *edid = fb_ddc_read(&rinfo->i2c[conn-1].adapter);
> +	u32 reg = rinfo->i2c[conn-1].ddc_reg;
> +	u8 *edid;
> +
> +	OUTREG(reg, INREG(reg) &
> +			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
> +
> +	edid = fb_ddc_read(&rinfo->i2c[conn-1].adapter);
>  
>  	if (out_edid)
>  		*out_edid = edid;
> 
