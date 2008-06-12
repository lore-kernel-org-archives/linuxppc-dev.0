Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F1A44DE3E2
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 01:28:53 +1000 (EST)
Date: Thu, 12 Jun 2008 10:28:38 -0500
From: Scott Wood <scottwood@freescale.com>
To: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: Re: [PATCH] [8xx] powerpc: Add support for the MPC852 based mgsuvd
	board from keymile.
Message-ID: <20080612152838.GA2756@loki.buserror.net>
References: <20080612003247.12717.18346.stgit@vitb-lp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612003247.12717.18346.stgit@vitb-lp>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 12, 2008 at 04:32:47AM +0400, Vitaly Bordug wrote:
> +			interrupts = <0x0f 2>;		/* decrementer interrupt */

Interrupts should probably be decimal.

> +			compatible = "fsl,cpm1";

compatible = "fsl,mpc852-cpm", "fsl,cpm1".

> +			command-proc = <0x9c0>;

This is obsolete; there should be no remaining code that refers to it.

> +			muram@2000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 0x2000 0x2000>;
> +
> +				data@0 {
> +					compatible = "fsl,cpm-muram-data";
> +					reg = <0x800 0x1800>;
> +				};
> +			};

The muram node itself should also have a compatible (fsl,cpm-muram).

> +				clock-frequency = <0x3ef1480>;

clock-frequency should be decimal (or better, filled in by u-boot).

> +			CPM_PIC: interrupt-controller@930 {
> +				interrupt-controller;
> +				#interrupt-cells = <1>;
> +				interrupts = <5 2 0 2 0x20 2>;
> +				interrupt-parent = <&PIC>;
> +				reg = <0x930 0x20>;
> +				compatible = "fsl,cpm1-pic";

"fsl,mpc852-cpm-pic", "fsl,cpm1-pic".
Likewise elsewhere.

> +			/* MON-1 */
> +			serial@a80 {
> +				device_type = "serial";
> +				compatible = "cpm_uart",
> +				             "fsl,cpm1-smc-uart";
> +				model = "SMC";
> +				device-id = <1>;
> +				reg = <0xa80 0x10 0x3fc0 0x40>;
> +				interrupts = <4>;
> +				interrupt-parent = <&CPM_PIC>;
> +				fsl,cpm-brg = <1>;
> +				fsl,cpm-command = <0x0090>;
> +				current-speed = <0>; /* Filled in by u-boot */
> +			};
> +
> +			ethernet@a40 {
> +				device_type = "network";
> +				compatible = "fs_enet",
> +				             "fsl,cpm1-scc-enet";
> +				model = "SCC";
> +				device-id = <3>;

The "cpm_uart" and "fs_enet" compatible values, as well as the device-id
property and this usage of the model property, are obsolete and there should
be no code remaining that references it.

> +				reg = <0xa40 0x18 0x3e00 0xb0>;
> +				mac-address = [ 00 00 00 00 00 00 ];  /* Filled in by u-boot */

Should be local-mac-address.

> +				fixed-link = <0 0 0x0a 0 0>;

We should move the documentation for this out of the gianfar-specific
section of booting-without-of.txt.  Speed should be decimal.

> +config PPC_MGSUVD
> +	bool "MGSUVD"
> +	select CPM1
> +	select PPC_CPM_NEW_BINDING

No need to explicitly select PPC_CPM_NEW_BINDING any more.

> +struct cpm_pin {
> +		int port, pin, flags;
> +};

Only one tab, please.

> +static __initdata struct of_device_id of_bus_ids[] = {
> +	{ .name = "soc", },
> +	{ .name = "cpm", },
> +	{ .name = "localbus", },
> +	{},
> +};

Replace these with { .compatible = "simple-bus" }, and add simple-bus to the
dts where appropriate.

> +static int __init declare_of_platform_devices(void)
> +{
> +	of_platform_bus_probe (NULL, of_bus_ids, NULL);
> +	return 0;
> +}
> +machine_device_initcall(mgsuvd, declare_of_platform_devices);
> +
> +static int __init mgsuvd_probe(void)
> +{
> +	unsigned long root = of_get_flat_dt_root ();
> +	return of_flat_dt_is_compatible (root, "keymile,mgsuvd");
> +}

No space between a function name and the arguments -- this isn't u-boot. :-)

> +define_machine(mgsuvd) {
> +	.name			= "MGSUVD",
> +	.probe			= mgsuvd_probe,
> +	.setup_arch		= mgsuvd_setup_arch,
> +	.init_IRQ		= mpc8xx_pics_init,
> +	.get_irq		= mpc8xx_get_irq,
> +	.restart		= mpc8xx_restart,
> +	.calibrate_decr		= mpc8xx_calibrate_decr,
> +	.set_rtc_time		= mpc8xx_set_rtc_time,
> +	.get_rtc_time		= mpc8xx_get_rtc_time,
> +};

This tab-alignment will look like hell if viewed with another tab size...

-Scott
