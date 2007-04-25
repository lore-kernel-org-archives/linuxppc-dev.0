Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 889D7DDF52
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Apr 2007 09:39:10 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [2.6.22] pasemi: hardware rng driver
Date: Thu, 26 Apr 2007 01:38:31 +0200
References: <20070425204512.GB19781@lixom.net>
In-Reply-To: <20070425204512.GB19781@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704260138.32220.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, egor@pasemi.com, mb@bu3sch.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 25 April 2007, Olof Johansson wrote:

> +static void __iomem *rng_regs;
> +
> +static int pasemi_rng_data_present(struct hwrng *rng)
> +{
> +	return (in_le32(rng_regs + SDCRNG_CTL_REG)
> +		& SDCRNG_CTL_FVLD_M) ? 1 : 0;
> +}

It would be nicer to get rid of the global rng_regs variable by sticking
it into rng->priv.

> +static int __devinit rng_probe(struct of_device *ofdev,
> +				     const struct of_device_id *match)
> +{
> +	struct device_node *rng_np;
> +	struct resource res;
> +	int err = 0;
> +
> +	rng_np = of_find_compatible_node(NULL, "rng", "1682m-rng");
> +	if (!rng_np)
> +		return -ENODEV;

I would guess that the call to of_find_compatible_node is entirely bogus
here, because the device is already passed in as ofdev in to the probe
function.

> +int rng_init(void)
> +{
> +       return of_register_platform_driver(&rng_driver);
> +}
> +
> +void rng_exit(void)
> +{
> +       of_unregister_platform_driver(&rng_driver);
> +}
> +
> +device_initcall(rng_init);

rng_init and rng_exit should be static
rng_init should be __init
rng_exit should be __exit
Since the driver is tristate in Kconfig, it would be more conventional to
use module_init() instead of device_initcall().
rng_exit needs to be marked as module_exit() to allow unloading the driver.

	Arnd <><
