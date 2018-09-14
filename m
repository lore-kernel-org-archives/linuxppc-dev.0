Return-Path: <groeck7@gmail.com>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bj8126GjzF3Xb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 03:25:05 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id b129-v6so4693600pga.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 10:25:04 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 14 Sep 2018 10:25:01 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
 Radu Rendec <radu.rendec@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-watchdog@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] watchdog: mpc8xxx: use dev_xxxx() instead of
 pr_xxxx()
Message-ID: <20180914172501.GE26861@roeck-us.net>
References: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5edda1a360cf7867b98a72a1dfa22db3bd5ed7b4.1536931725.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 14, 2018 at 01:31:59PM +0000, Christophe Leroy wrote:
> mpc8xxx watchdog driver is a platform device drivers, it is
> therefore possible to use dev_xxx() messaging rather than pr_xxx()
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/mpc8xxx_wdt.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/watchdog/mpc8xxx_wdt.c b/drivers/watchdog/mpc8xxx_wdt.c
> index aca2d6323f8a..1dcf5f10cdd9 100644
> --- a/drivers/watchdog/mpc8xxx_wdt.c
> +++ b/drivers/watchdog/mpc8xxx_wdt.c
> @@ -17,8 +17,6 @@
>   * option) any later version.
>   */
>  
> -#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> -
>  #include <linux/fs.h>
>  #include <linux/init.h>
>  #include <linux/kernel.h>
> @@ -137,26 +135,27 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  	struct mpc8xxx_wdt_ddata *ddata;
>  	u32 freq = fsl_get_sys_freq();
>  	bool enabled;
> +	struct device *dev = &ofdev->dev;
>  
> -	wdt_type = of_device_get_match_data(&ofdev->dev);
> +	wdt_type = of_device_get_match_data(dev);
>  	if (!wdt_type)
>  		return -EINVAL;
>  
>  	if (!freq || freq == -1)
>  		return -EINVAL;
>  
> -	ddata = devm_kzalloc(&ofdev->dev, sizeof(*ddata), GFP_KERNEL);
> +	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
>  	if (!ddata)
>  		return -ENOMEM;
>  
>  	res = platform_get_resource(ofdev, IORESOURCE_MEM, 0);
> -	ddata->base = devm_ioremap_resource(&ofdev->dev, res);
> +	ddata->base = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(ddata->base))
>  		return PTR_ERR(ddata->base);
>  
>  	enabled = in_be32(&ddata->base->swcrr) & SWCRR_SWEN;
>  	if (!enabled && wdt_type->hw_enabled) {
> -		pr_info("could not be enabled in software\n");
> +		dev_info(dev, "could not be enabled in software\n");
>  		return -ENODEV;
>  	}
>  
> @@ -166,7 +165,7 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  	ddata->wdd.ops = &mpc8xxx_wdt_ops,
>  
>  	ddata->wdd.timeout = WATCHDOG_TIMEOUT;
> -	watchdog_init_timeout(&ddata->wdd, timeout, &ofdev->dev);
> +	watchdog_init_timeout(&ddata->wdd, timeout, dev);
>  
>  	watchdog_set_nowayout(&ddata->wdd, nowayout);
>  
> @@ -189,12 +188,13 @@ static int mpc8xxx_wdt_probe(struct platform_device *ofdev)
>  
>  	ret = watchdog_register_device(&ddata->wdd);
>  	if (ret) {
> -		pr_err("cannot register watchdog device (err=%d)\n", ret);
> +		dev_err(dev, "cannot register watchdog device (err=%d)\n", ret);
>  		return ret;
>  	}
>  
> -	pr_info("WDT driver for MPC8xxx initialized. mode:%s timeout=%d sec\n",
> -		reset ? "reset" : "interrupt", ddata->wdd.timeout);
> +	dev_info(dev,
> +		 "WDT driver for MPC8xxx initialized. mode:%s timeout=%d sec\n",
> +		 reset ? "reset" : "interrupt", ddata->wdd.timeout);
>  
>  	platform_set_drvdata(ofdev, ddata);
>  	return 0;
> @@ -204,8 +204,8 @@ static int mpc8xxx_wdt_remove(struct platform_device *ofdev)
>  {
>  	struct mpc8xxx_wdt_ddata *ddata = platform_get_drvdata(ofdev);
>  
> -	pr_crit("Watchdog removed, expect the %s soon!\n",
> -		reset ? "reset" : "machine check exception");
> +	dev_crit(&ofdev->dev, "Watchdog removed, expect the %s soon!\n",
> +		 reset ? "reset" : "machine check exception");
>  	watchdog_unregister_device(&ddata->wdd);
>  
>  	return 0;
> -- 
> 2.13.3
> 
