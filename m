Return-Path: <vz@mleia.com>
Received: from mail.mleia.com (mleia.com [178.79.152.223])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s80Sv0WWqzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 02:42:54 +1000 (AEST)
Subject: Re: [PATCH] i2c: don't print error when adding adapter fails
To: Wolfram Sang <wsa-dev@sang-engineering.com>, linux-kernel@vger.kernel.org
References: <1470742581-12971-1-git-send-email-wsa-dev@sang-engineering.com>
 <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
 Wolfram Sang <wsa@the-dreams.de>,
 Ludovic Desroches <ludovic.desroches@atmel.com>, Ray Jui
 <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Jon Mason <jonmason@broadcom.com>, bcm-kernel-feedback-list@broadcom.com,
 Florian Fainelli <f.fainelli@gmail.com>, Sonic Zhang
 <sonic.zhang@analog.com>, Brian Norris <computersforpeace@gmail.com>,
 Gregory Fong <gregory.0xf0@gmail.com>, Michal Simek
 <michal.simek@xilinx.com>, =?UTF-8?Q?S=c3=b6ren_Brinkmann?=
 <soren.brinkmann@xilinx.com>, Jochen Friedrich <jochen@scram.de>,
 Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Guenter Roeck <linux@roeck-us.net>, =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?=
 <kernel@pengutronix.de>, Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Seth Heasley <seth.heasley@intel.com>, Neil Horman <nhorman@tuxdriver.com>,
 Joachim Eastwood <manabian@gmail.com>, Carlo Caione <carlo@caione.org>,
 Alessandro Rubini <rubini@unipv.it>, Linus Walleij
 <linus.walleij@linaro.org>, Peter Korsgaard <jacmet@sunsite.dk>,
 Tony Lindgren <tony@atomide.com>, Sylvain Lemieux <slemieux.tyco@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
 Barry Song <baohua@kernel.org>, Patrice Chotard <patrice.chotard@st.com>,
 Laxman Dewangan <ldewangan@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Alexandre Courbot <gnurou@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Tony Prisk <linux@prisktech.co.nz>, linux-arm-kernel@lists.infradead.org,
 adi-buildroot-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
 linux-samsung-soc@vger.kernel.org, linux-amlogic@lists.infradead.org,
 linux-omap@vger.kernel.org, linux-rockchip@lists.infradead.org,
 kernel@stlinux.com, linux-tegra@vger.kernel.org
From: Vladimir Zapolskiy <vz@mleia.com>
Message-ID: <a8dd593f-a38e-9661-22f3-ca5e5dfe53c4@mleia.com>
Date: Tue, 9 Aug 2016 19:36:55 +0300
MIME-Version: 1.0
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09.08.2016 14:36, Wolfram Sang wrote:
> The core will do this for us now.
> 
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>
> ---

For 

>  drivers/i2c/busses/i2c-pnx.c            | 4 +---

[snip]

> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 7ea67aa46fb730..fd5f9d2bf6d94e 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -714,10 +714,8 @@ static int i2c_pnx_probe(struct platform_device *pdev)
>  
>  	/* Register this adapter with the I2C subsystem */
>  	ret = i2c_add_numbered_adapter(&alg_data->adapter);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "I2C: Failed to add bus\n");
> +	if (ret < 0)
>  		goto out_clock;
> -	}
>  
>  	dev_dbg(&pdev->dev, "%s: Master at %#8x, irq %d.\n",
>  		alg_data->adapter.name, res->start, alg_data->irq);

Acked-by: Vladimir Zapolskiy <vz@mleia.com>

--
With best wishes,
Vladimir
