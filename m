Return-Path: <scottwood@freescale.com>
Date: Mon, 30 Jun 2008 13:54:43 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/2] Convert i2c-mpc from a platform driver into a
	of_platform driver, V3
Message-ID: <20080630185442.GA3528@ld0162-tx32.am.freescale.net>
References: <20080630183413.4614.8840.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080630183413.4614.8840.stgit@terra>
Cc: Linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 30, 2008 at 02:34:13PM -0400, Jon Smirl wrote:
> +		result = request_irq(i2c->irq, mpc_i2c_isr,
> +							IRQF_SHARED, "i2c-mpc", i2c);

That's a rather excessive indentation of the continuation line -- it
looks like it was aligned using 4-character tabs.  It's best to use
spaces for alignment (after using tabs to reach the indentation level),
especially if you're using a non-standard tab size.

>  static int __init fsl_i2c_init(void)
>  {
> -	return platform_driver_register(&fsl_i2c_driver);
> +	int rv;
> +
> +	rv = of_register_platform_driver(&mpc_i2c_driver);
> +	if (rv)
> +		printk(KERN_ERR DRV_NAME 
> +		" of_register_platform_driver failed (%i)\n", rv);

Please align the continuation line with the first parameter.

-Scott
