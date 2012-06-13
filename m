Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 26ADEB7027
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 07:54:12 +1000 (EST)
Message-ID: <1339623217.9220.119.camel@pasglop>
Subject: Re: [PATCH] i2c: let the core register devices from devicetree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 14 Jun 2012 07:33:37 +1000
In-Reply-To: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
References: <1339622215-4733-1-git-send-email-w.sang@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Viresh Kumar <viresh.kumar@st.com>,
 Mauro Carvalho Chehab <mchehab@redhat.com>, Tony Lindgren <tony@atomide.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Laxman Dewangan <ldewangan@nvidia.com>, linux-i2c@vger.kernel.org,
 Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>,
 Deepak Sikri <deepak.sikri@st.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>,
 Dirk Brandewie <dirk.brandewie@gmail.com>, Pawel Moll <pawel.moll@arm.com>,
 Wolfram Sang <wolfram@the-dreams.de>, Sascha Hauer <s.hauer@pengutronix.de>,
 Rusty Russell <rusty@rustcorp.com.au>, Tang Yuantian <B29983@freescale.com>,
 "Jean Delvare \(PC drivers, core\)" <khali@linux-fr.org>,
 Magnus Damm <damm@opensource.se>, Lars-Peter Clausen <lars@metafoo.de>,
 "Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>,
 linux-arm-kernel@lists.infradead.org, Jiri Kosina <jkosina@suse.cz>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Karol Lewandowski <k.lewandowsk@samsung.com>, Olof Johansson <olof@lixom.net>,
 Shawn Guo <shawn.guo@linaro.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-06-13 at 23:12 +0200, Wolfram Sang wrote:
> Currently, every driver has to do it on its own, but it should be done
> in the core, like we already do with board_info structs.
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> ---
> 
> Based on v3.5-rc2. Only build tested, I don't have a OF based device
> around at the moment.

Won't that conflict with i2c-powermac doing it its own way ?

Cheers,
Ben.

> @Peter: Why does ocores do the device registration manually via
> platform_data instead of using board_info?
> 
>  drivers/i2c/busses/i2c-cpm.c                |    5 -----
>  drivers/i2c/busses/i2c-designware-platdrv.c |    1 -
>  drivers/i2c/busses/i2c-gpio.c               |    2 --
>  drivers/i2c/busses/i2c-ibm_iic.c            |    3 ---
>  drivers/i2c/busses/i2c-imx.c                |    2 --
>  drivers/i2c/busses/i2c-mpc.c                |    1 -
>  drivers/i2c/busses/i2c-mxs.c                |    2 --
>  drivers/i2c/busses/i2c-ocores.c             |    2 --
>  drivers/i2c/busses/i2c-omap.c               |    2 --
>  drivers/i2c/busses/i2c-pnx.c                |    2 --
>  drivers/i2c/busses/i2c-pxa.c                |    1 -
>  drivers/i2c/busses/i2c-s3c2410.c            |    1 -
>  drivers/i2c/busses/i2c-sh_mobile.c          |    1 -
>  drivers/i2c/busses/i2c-tegra.c              |    2 --
>  drivers/i2c/busses/i2c-versatile.c          |    1 -
>  drivers/i2c/busses/i2c-xiic.c               |    2 --
>  drivers/i2c/i2c-core.c                      |    3 +++
>  17 files changed, 3 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-cpm.c b/drivers/i2c/busses/i2c-cpm.c
> index c1e1096..749e63c 100644
> --- a/drivers/i2c/busses/i2c-cpm.c
> +++ b/drivers/i2c/busses/i2c-cpm.c
> @@ -673,11 +673,6 @@ static int __devinit cpm_i2c_probe(struct platform_device *ofdev)
>  	dev_dbg(&ofdev->dev, "hw routines for %s registered.\n",
>  		cpm->adap.name);
>  
> -	/*
> -	 * register OF I2C devices
> -	 */
> -	of_i2c_register_devices(&cpm->adap);
> -
>  	return 0;
>  out_shut:
>  	cpm_i2c_shutdown(cpm);
> diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
> index 0506fef..cf3b23c 100644
> --- a/drivers/i2c/busses/i2c-designware-platdrv.c
> +++ b/drivers/i2c/busses/i2c-designware-platdrv.c
> @@ -147,7 +147,6 @@ static int __devinit dw_i2c_probe(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "failure adding adapter\n");
>  		goto err_free_irq;
>  	}
> -	of_i2c_register_devices(adap);
>  
>  	return 0;
>  
> diff --git a/drivers/i2c/busses/i2c-gpio.c b/drivers/i2c/busses/i2c-gpio.c
> index e62d2d9..75e26b9 100644
> --- a/drivers/i2c/busses/i2c-gpio.c
> +++ b/drivers/i2c/busses/i2c-gpio.c
> @@ -195,8 +195,6 @@ static int __devinit i2c_gpio_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto err_add_bus;
>  
> -	of_i2c_register_devices(adap);
> -
>  	platform_set_drvdata(pdev, priv);
>  
>  	dev_info(&pdev->dev, "using pins %u (SDA) and %u (SCL%s)\n",
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
> index 806e225..8894ab6 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -759,9 +759,6 @@ static int __devinit iic_probe(struct platform_device *ofdev)
>  	dev_info(&ofdev->dev, "using %s mode\n",
>  		 dev->fast_mode ? "fast (400 kHz)" : "standard (100 kHz)");
>  
> -	/* Now register all the child nodes */
> -	of_i2c_register_devices(adap);
> -
>  	return 0;
>  
>  error_cleanup:
> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> index 8d6b504..16d9356 100644
> --- a/drivers/i2c/busses/i2c-imx.c
> +++ b/drivers/i2c/busses/i2c-imx.c
> @@ -568,8 +568,6 @@ static int __init i2c_imx_probe(struct platform_device *pdev)
>  		goto fail5;
>  	}
>  
> -	of_i2c_register_devices(&i2c_imx->adapter);
> -
>  	/* Set up platform driver data */
>  	platform_set_drvdata(pdev, i2c_imx);
>  
> diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
> index b76731e..a86049a 100644
> --- a/drivers/i2c/busses/i2c-mpc.c
> +++ b/drivers/i2c/busses/i2c-mpc.c
> @@ -675,7 +675,6 @@ static int __devinit fsl_i2c_probe(struct platform_device *op)
>  		dev_err(i2c->dev, "failed to add adapter\n");
>  		goto fail_add;
>  	}
> -	of_i2c_register_devices(&i2c->adap);
>  
>  	return result;
>  
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 04eb441..2bc0ec6 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -379,8 +379,6 @@ static int __devinit mxs_i2c_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> -	of_i2c_register_devices(adap);
> -
>  	return 0;
>  }
>  
> diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
> index 75194c5..a6a11cb 100644
> --- a/drivers/i2c/busses/i2c-ocores.c
> +++ b/drivers/i2c/busses/i2c-ocores.c
> @@ -344,8 +344,6 @@ static int __devinit ocores_i2c_probe(struct platform_device *pdev)
>  	if (pdata) {
>  		for (i = 0; i < pdata->num_devices; i++)
>  			i2c_new_device(&i2c->adap, pdata->devices + i);
> -	} else {
> -		of_i2c_register_devices(&i2c->adap);
>  	}
>  
>  	return 0;
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 801df60..c290091 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -1121,8 +1121,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  		goto err_free_irq;
>  	}
>  
> -	of_i2c_register_devices(adap);
> -
>  	return 0;
>  
>  err_free_irq:
> diff --git a/drivers/i2c/busses/i2c-pnx.c b/drivers/i2c/busses/i2c-pnx.c
> index 99389d2..c64d960 100644
> --- a/drivers/i2c/busses/i2c-pnx.c
> +++ b/drivers/i2c/busses/i2c-pnx.c
> @@ -730,8 +730,6 @@ static int __devinit i2c_pnx_probe(struct platform_device *pdev)
>  		goto out_irq;
>  	}
>  
> -	of_i2c_register_devices(&alg_data->adapter);
> -
>  	dev_dbg(&pdev->dev, "%s: Master at %#8x, irq %d.\n",
>  		alg_data->adapter.name, res->start, alg_data->irq);
>  
> diff --git a/drivers/i2c/busses/i2c-pxa.c b/drivers/i2c/busses/i2c-pxa.c
> index a997c7d..9475235 100644
> --- a/drivers/i2c/busses/i2c-pxa.c
> +++ b/drivers/i2c/busses/i2c-pxa.c
> @@ -1194,7 +1194,6 @@ static int i2c_pxa_probe(struct platform_device *dev)
>  		printk(KERN_INFO "I2C: Failed to add bus\n");
>  		goto eadapt;
>  	}
> -	of_i2c_register_devices(&i2c->adap);
>  
>  	platform_set_drvdata(dev, i2c);
>  
> diff --git a/drivers/i2c/busses/i2c-s3c2410.c b/drivers/i2c/busses/i2c-s3c2410.c
> index 0195915..ad3a79b 100644
> --- a/drivers/i2c/busses/i2c-s3c2410.c
> +++ b/drivers/i2c/busses/i2c-s3c2410.c
> @@ -1058,7 +1058,6 @@ static int s3c24xx_i2c_probe(struct platform_device *pdev)
>  		goto err_cpufreq;
>  	}
>  
> -	of_i2c_register_devices(&i2c->adap);
>  	platform_set_drvdata(pdev, i2c);
>  
>  	pm_runtime_enable(&pdev->dev);
> diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
> index 8110ca4..9acd286 100644
> --- a/drivers/i2c/busses/i2c-sh_mobile.c
> +++ b/drivers/i2c/busses/i2c-sh_mobile.c
> @@ -670,7 +670,6 @@ static int sh_mobile_i2c_probe(struct platform_device *dev)
>  	dev_info(&dev->dev, "I2C adapter %d with bus speed %lu Hz\n",
>  		 adap->nr, pd->bus_speed);
>  
> -	of_i2c_register_devices(adap);
>  	return 0;
>  
>   err_all:
> diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
> index 8b2e555..67388cc 100644
> --- a/drivers/i2c/busses/i2c-tegra.c
> +++ b/drivers/i2c/busses/i2c-tegra.c
> @@ -684,8 +684,6 @@ static int __devinit tegra_i2c_probe(struct platform_device *pdev)
>  		goto err_free_irq;
>  	}
>  
> -	of_i2c_register_devices(&i2c_dev->adapter);
> -
>  	return 0;
>  err_free_irq:
>  	free_irq(i2c_dev->irq, i2c_dev);
> diff --git a/drivers/i2c/busses/i2c-versatile.c b/drivers/i2c/busses/i2c-versatile.c
> index eec20db..14a1432 100644
> --- a/drivers/i2c/busses/i2c-versatile.c
> +++ b/drivers/i2c/busses/i2c-versatile.c
> @@ -108,7 +108,6 @@ static int i2c_versatile_probe(struct platform_device *dev)
>  	ret = i2c_bit_add_numbered_bus(&i2c->adap);
>  	if (ret >= 0) {
>  		platform_set_drvdata(dev, i2c);
> -		of_i2c_register_devices(&i2c->adap);
>  		return 0;
>  	}
>  
> diff --git a/drivers/i2c/busses/i2c-xiic.c b/drivers/i2c/busses/i2c-xiic.c
> index 641d0e5..d76bb71 100644
> --- a/drivers/i2c/busses/i2c-xiic.c
> +++ b/drivers/i2c/busses/i2c-xiic.c
> @@ -754,8 +754,6 @@ static int __devinit xiic_i2c_probe(struct platform_device *pdev)
>  			i2c_new_device(&i2c->adap, pdata->devices + i);
>  	}
>  
> -	of_i2c_register_devices(&i2c->adap);
> -
>  	return 0;
>  
>  add_adapter_failed:
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> index a6ad32b..4791833 100644
> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c
> @@ -39,6 +39,7 @@
>  #include <linux/irqflags.h>
>  #include <linux/rwsem.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/of_i2c.h>
>  #include <asm/uaccess.h>
>  
>  #include "i2c-core.h"
> @@ -880,6 +881,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  #endif
>  
>  	/* create pre-declared device nodes */
> +	of_i2c_register_devices(adap);
> +
>  	if (adap->nr < __i2c_first_dynamic_bus_num)
>  		i2c_scan_static_board_info(adap);
>  
