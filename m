Return-Path: <ludovic.desroches@atmel.com>
Received: from email.microchip.com (exsmtp03.microchip.com [198.175.253.49])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s8LgP2QC6zDqRR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 16:23:12 +1000 (AEST)
Date: Wed, 10 Aug 2016 08:17:15 +0200
From: Ludovic Desroches <ludovic.desroches@atmel.com>
To: Wolfram Sang <wsa-dev@sang-engineering.com>
CC: <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>, Jean Delvare
 <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>, Ludovic Desroches
 <ludovic.desroches@atmel.com>, Ray Jui <rjui@broadcom.com>, Scott Branden
 <sbranden@broadcom.com>, Jon Mason <jonmason@broadcom.com>,
 <bcm-kernel-feedback-list@broadcom.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Sonic Zhang <sonic.zhang@analog.com>, Brian Norris
 <computersforpeace@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 "Michal Simek" <michal.simek@xilinx.com>, =?iso-8859-1?Q?S=F6ren?= Brinkmann
 <soren.brinkmann@xilinx.com>, Jochen Friedrich <jochen@scram.de>, Sekhar Nori
 <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Guenter Roeck
 <linux@roeck-us.net>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
 <kernel@pengutronix.de>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski
 <k.kozlowski@samsung.com>, Seth Heasley <seth.heasley@intel.com>, Neil Horman
 <nhorman@tuxdriver.com>, Joachim Eastwood <manabian@gmail.com>, Carlo Caione
 <carlo@caione.org>, Alessandro Rubini <rubini@unipv.it>, Linus Walleij
 <linus.walleij@linaro.org>, Peter Korsgaard <jacmet@sunsite.dk>, "Tony
 Lindgren" <tony@atomide.com>, Vladimir Zapolskiy <vz@mleia.com>, "Sylvain
 Lemieux" <slemieux.tyco@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 "Heiko Stuebner" <heiko@sntech.de>, Barry Song <baohua@kernel.org>, Patrice
 Chotard <patrice.chotard@st.com>, Laxman Dewangan <ldewangan@nvidia.com>,
 "Thierry Reding" <thierry.reding@gmail.com>, Alexandre Courbot
 <gnurou@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Tony
 Prisk <linux@prisktech.co.nz>, <linux-arm-kernel@lists.infradead.org>,
 <adi-buildroot-devel@lists.sourceforge.net>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-amlogic@lists.infradead.org>,
 <linux-omap@vger.kernel.org>, <linux-rockchip@lists.infradead.org>,
 <kernel@stlinux.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
Message-ID: <20160810061715.GH12809@odux.rfo.atmel.com>
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2016 at 01:36:17PM +0200, Wolfram Sang wrote:
> The core will do this for us now.
> 
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
> ---

[...]

>  drivers/i2c/busses/i2c-at91.c           | 2 --

Acked-by: Ludovic Desroches <ludovic.desroches@atmel.com>

[...]

> diff --git a/drivers/i2c/busses/i2c-at91.c b/drivers/i2c/busses/i2c-at91.c
> index f23372669f770f..03a519d29616d7 100644
> --- a/drivers/i2c/busses/i2c-at91.c
> +++ b/drivers/i2c/busses/i2c-at91.c
> @@ -1118,8 +1118,6 @@ static int at91_twi_probe(struct platform_device *pdev)
>  
>  	rc = i2c_add_numbered_adapter(&dev->adapter);
>  	if (rc) {
> -		dev_err(dev->dev, "Adapter %s registration failed\n",
> -			dev->adapter.name);
>  		clk_disable_unprepare(dev->clk);
>  
>  		pm_runtime_disable(dev->dev);
