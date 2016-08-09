Return-Path: <ray.jui@broadcom.com>
Received: from mail-pf0-x230.google.com (mail-pf0-x230.google.com
 [IPv6:2607:f8b0:400e:c00::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7zsd5v5qzDqdv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Aug 2016 02:15:48 +1000 (AEST)
Received: by mail-pf0-x230.google.com with SMTP id y134so6493169pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Aug 2016 09:15:48 -0700 (PDT)
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
 Tony Lindgren <tony@atomide.com>, Vladimir Zapolskiy <vz@mleia.com>,
 Sylvain Lemieux <slemieux.tyco@gmail.com>, Guan Xuetao
 <gxt@mprc.pku.edu.cn>, Heiko Stuebner <heiko@sntech.de>,
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
From: Ray Jui <ray.jui@broadcom.com>
Message-ID: <1fc84a39-733e-5867-1f74-26a5076b18fc@broadcom.com>
Date: Tue, 9 Aug 2016 09:15:41 -0700
MIME-Version: 1.0
In-Reply-To: <1470742581-12971-2-git-send-email-wsa-dev@sang-engineering.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

On 8/9/2016 4:36 AM, Wolfram Sang wrote:
> The core will do this for us now.
>
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>

[...]

> diff --git a/drivers/i2c/busses/i2c-bcm-iproc.c b/drivers/i2c/busses/i2c-bcm-iproc.c
> index 19c843828fe2ca..8e3477f9297eda 100644
> --- a/drivers/i2c/busses/i2c-bcm-iproc.c
> +++ b/drivers/i2c/busses/i2c-bcm-iproc.c
> @@ -488,13 +488,7 @@ static int bcm_iproc_i2c_probe(struct platform_device *pdev)
>  	adap->dev.parent = &pdev->dev;
>  	adap->dev.of_node = pdev->dev.of_node;
>
> -	ret = i2c_add_adapter(adap);
> -	if (ret) {
> -		dev_err(iproc_i2c->device, "failed to add adapter\n");
> -		return ret;
> -	}
> -
> -	return 0;
> +	return i2c_add_adapter(adap);
>  }
>
>  static int bcm_iproc_i2c_remove(struct platform_device *pdev)
> diff --git a/drivers/i2c/busses/i2c-bcm-kona.c b/drivers/i2c/busses/i2c-bcm-kona.c
> index ac9f47679c3a4b..a5c9098507896b 100644
> --- a/drivers/i2c/busses/i2c-bcm-kona.c
> +++ b/drivers/i2c/busses/i2c-bcm-kona.c
> @@ -858,10 +858,8 @@ static int bcm_kona_i2c_probe(struct platform_device *pdev)
>  	adap->dev.of_node = pdev->dev.of_node;
>
>  	rc = i2c_add_adapter(adap);
> -	if (rc) {
> -		dev_err(dev->device, "failed to add adapter\n");
> +	if (rc)
>  		return rc;
> -	}
>
>  	dev_info(dev->device, "device registered successfully\n");
>

For both i2c-bcm-iproc.c and i2c-bcm-kona.c:

Acked-by: Ray Jui <ray.jui@broadcom.com>

Thanks,

Ray
