Return-Path: <sha@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D40FF2C0168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2013 05:38:47 +1000 (EST)
Date: Mon, 15 Jul 2013 21:38:29 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 05/24] clk: wrap I/O access for improved portability
Message-ID: <20130715193829.GS14452@pengutronix.de>
References: <1373914074-20889-1-git-send-email-gsi@denx.de>
 <1373914074-20889-6-git-send-email-gsi@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1373914074-20889-6-git-send-email-gsi@denx.de>
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 Wolfram Sang <wsa@the-dreams.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 Mark Brown <broonie@kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>,
 Wolfgang Grandegger <wg@grandegger.com>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-kernel@lists.infradead.org,
 Mauro Carvalho Chehab <m.chehab@samsung.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 15, 2013 at 08:47:34PM +0200, Gerhard Sittig wrote:
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index 6d55eb2..2c07061 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -104,7 +104,7 @@ static unsigned long clk_divider_recalc_rate(struct clk_hw *hw,
>  	struct clk_divider *divider = to_clk_divider(hw);
>  	unsigned int div, val;
>  
> -	val = readl(divider->reg) >> divider->shift;
> +	val = clk_readl(divider->reg) >> divider->shift;
>  	val &= div_mask(divider);

Would it be an option to use regmap for the generic dividers/muxes
instead? This should be suitable for ppc and also for people who want to
use the generic clocks on i2c devices.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
