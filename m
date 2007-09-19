Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD85CDDE18
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Sep 2007 13:01:16 +1000 (EST)
Subject: Re: [PATCH] atyfb: force 29MHz xtal on G3 PowerBooks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20070825091358.GA12235@aepfle.de>
References: <20070825091358.GA12235@aepfle.de>
Content-Type: text/plain
Date: Wed, 19 Sep 2007 13:01:06 +1000
Message-Id: <1190170866.6403.133.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-08-25 at 11:13 +0200, Olaf Hering wrote:
> The atyfb does not work on my 233MHz PowerBook with Mach64 LP, when the
> kernel is booted from firmware. aty_ld_pll_ct() returns 0x22 and xtal
> remains at 14.31818. When booted from MacOS, aty_ld_pll_ct() returns 0x3c
> and xtal is changed to 29.498928.
> Google indicates that all 4 PowerBook models need the higher value.

Seems to break it on my wallstreet first gen (M64 LG)

So NAK for now until we find out a better way.

Ben.

> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> --- a/drivers/video/aty/atyfb_base.c
> +++ b/drivers/video/aty/atyfb_base.c
> @@ -2411,7 +2411,7 @@ static int __devinit aty_init(struct fb_
>  				diff1 = -diff1;
>  			if (diff2 < 0)
>  				diff2 = -diff2;
> -			if (diff2 < diff1) {
> +			if (diff2 < diff1 || (M64_HAS(G3_PB_1024x768))) {
>  				par->ref_clk_per = 1000000000000ULL / 29498928;
>  				xtal = "29.498928";
>  			}
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
