Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDF60DDEE1
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 14:39:56 +1100 (EST)
Subject: Re: radeon boot "hot-crash"
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Buesch <mb@bu3sch.de>
In-Reply-To: <200711021955.49169.mb@bu3sch.de>
References: <200711021955.49169.mb@bu3sch.de>
Content-Type: text/plain
Date: Sun, 04 Nov 2007 14:39:45 +1100
Message-Id: <1194147585.6511.13.camel@pasglop>
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


On Fri, 2007-11-02 at 19:55 +0100, Michael Buesch wrote:
> Hi,
> 
> I'm wondering how we are finally going to fix my radeon
> "hot-crash" issue.
> Fact is, applying the patch below fixes the issue.

And will break somebody else ... 

> Though, I see that this is not the correct patch to fix it.
> Other devices might need the register write which is removed here.
> So what about the following:
> We add a specialcase for the exact type (and revision and so on)
> for my chip here.
> How do  find out what's my chiprevision?
> What exactly should be checked for here, so that only this chip
> is affected by the workaround?

I think best is to check for the specific machine. What powerbook model
is this ?

Ben.

> 
> Index: wireless-2.6/drivers/video/aty/radeon_i2c.c
> ===================================================================
> --- wireless-2.6.orig/drivers/video/aty/radeon_i2c.c	2007-10-17 18:03:10.000000000 +0200
> +++ wireless-2.6/drivers/video/aty/radeon_i2c.c	2007-10-17 18:18:52.000000000 +0200
> @@ -137,13 +137,7 @@ void radeon_delete_i2c_busses(struct rad
>  int radeon_probe_i2c_connector(struct radeonfb_info *rinfo, int conn,
>  			       u8 **out_edid)
>  {
> -	u32 reg = rinfo->i2c[conn-1].ddc_reg;
> -	u8 *edid;
> -
> -	OUTREG(reg, INREG(reg) &
> -			~(VGA_DDC_DATA_OUTPUT | VGA_DDC_CLK_OUTPUT));
> -
> -	edid = fb_ddc_read(&rinfo->i2c[conn-1].adapter);
> +	u8 *edid = fb_ddc_read(&rinfo->i2c[conn-1].adapter);
>  
>  	if (out_edid)
>  		*out_edid = edid;
> 
