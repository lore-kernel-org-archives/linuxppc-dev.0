Return-Path: <tony@atomide.com>
Received: from mho-01-ewr.mailhop.org (mho-01-ewr.mailhop.org [204.13.248.71])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 64C51B7242
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Feb 2012 13:12:12 +1100 (EST)
Date: Sat, 4 Feb 2012 17:38:53 -0800
From: Tony Lindgren <tony@atomide.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH v3 00/25] irq_domain generalization and refinement
Message-ID: <20120205013853.GQ20333@atomide.com>
References: <1327700179-17454-1-git-send-email-grant.likely@secretlab.ca>
 <20120204221748.GN14129@n2100.arm.linux.org.uk>
 <20120204223125.GO14129@n2100.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120204223125.GO14129@n2100.arm.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, Milton Miller <miltonm@bga.com>,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 14:00]:
> 
> Actually, it turns out to be not that hard, because twl doesn't actually
> make use of the IRQ domain stuff:
> 
> commit aeb5032b3f8b9ab69daa545777433fa94b3494c4
> Author:     Benoit Cousson <b-cousson@ti.com>
> AuthorDate: Mon Aug 29 16:20:23 2011 +0200
> Commit:     Samuel Ortiz <sameo@linux.intel.com>
> CommitDate: Mon Jan 9 00:37:40 2012 +0100
> 
>     mfd: twl-core: Add initial DT support for twl4030/twl6030
> 
>     [grant.likely@secretlab.ca: Fix IRQ_DOMAIN dependency in kconfig]
> 
> Adding any dependency - especially one which wouldn't be enabled - for
> a new feature which wasn't required before is going to break existing
> users, so this shouldn't have been done in the first place.
> 
> A better fix to preserve existing users would've been as below - yes
> it means more ifdefs, but if irq domain is to remain a DT only thing
> then we're going to end up with _lots_ of this stuff.
> 
> I'd much prefer to see irq domain become more widely available so it
> doesn't require these ifdefs everywhere.

Your patch below looks like a correct fix to me to the problem
you and Grazvydas are seeing:

Acked-by: Tony Lindgren <tony@atomide.com>
 
>  drivers/mfd/Kconfig    |    2 +-
>  drivers/mfd/twl-core.c |    4 ++++
>  2 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 28a301b..bd60ce0 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -200,7 +200,7 @@ config MENELAUS
>  
>  config TWL4030_CORE
>  	bool "Texas Instruments TWL4030/TWL5030/TWL6030/TPS659x0 Support"
> -	depends on I2C=y && GENERIC_HARDIRQS && IRQ_DOMAIN
> +	depends on I2C=y && GENERIC_HARDIRQS
>  	help
>  	  Say yes here if you have TWL4030 / TWL6030 family chip on your board.
>  	  This core driver provides register access and IRQ handling
> diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
> index e04e04d..5913aaa 100644
> --- a/drivers/mfd/twl-core.c
> +++ b/drivers/mfd/twl-core.c
> @@ -263,7 +263,9 @@ struct twl_client {
>  
>  static struct twl_client twl_modules[TWL_NUM_SLAVES];
>  
> +#ifdef CONFIG_IRQ_DOMAIN
>  static struct irq_domain domain;
> +#endif
>  
>  /* mapping the module id to slave id and base address */
>  struct twl_mapping {
> @@ -1226,6 +1228,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	pdata->irq_base = status;
>  	pdata->irq_end = pdata->irq_base + nr_irqs;
>  
> +#ifdef CONFIG_IRQ_DOMAIN
>  	domain.irq_base = pdata->irq_base;
>  	domain.nr_irq = nr_irqs;
>  #ifdef CONFIG_OF_IRQ
> @@ -1233,6 +1236,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  	domain.ops = &irq_domain_simple_ops;
>  #endif
>  	irq_domain_add(&domain);
> +#endif
>  
>  	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
>  		dev_dbg(&client->dev, "can't talk I2C?\n");
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
