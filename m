Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1A16FDDEC5
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 05:06:57 +1100 (EST)
Date: Wed, 2 Jan 2008 12:06:55 -0600
From: Scott Wood <scottwood@freescale.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH/RFC] powerpc: DBox2 Board Support
Message-ID: <20080102180655.GB4398@loki.buserror.net>
References: <476D61DB.2090201@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <476D61DB.2090201@scram.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 22, 2007 at 08:13:31PM +0100, Jochen Friedrich wrote:
> +		gtx@0 {
> +			compatible = "c-cube,gtx";
> +			reg = <400000 3000 0 200000>;
> +			interrupts = <2 2>;
> +			interrupt-parent = <&PIC>;
> +		};
> +
> +		fp@0 {
> +			compatible = "betaresearch,dbox2-fp";
> +			interrupts = <4 2>;
> +			interrupt-parent = <&PIC>;
> +			gpios = <0 e>;
> +			gpio-parent = <&CPM1_PIO>;
> +		};
> +
> +		fe@0 {
> +			compatible = "betaresearch,dbox2-fe";
> +			interrupts = <e 2>;
> +			interrupt-parent = <&PIC>;
> +		};

These unit addresses look wrong.

> +		cam@4000000 {
> +			compatible = "betaresearch,dbox2-cam";
> +			reg = <4000000 20000>;
> +			interrupts = <6 2>;
> +			interrupt-parent = <&PIC>;
> +			gpios = <1 1c 1 1d 1 1e 1 1f>;
> +			gpio-parent = <&CPM1_PIO>;
> +		};
> +
> +		cam@4040000 {
> +			compatible = "betaresearch,dbox2-cam";
> +			reg = <4040000 20000>;
> +			interrupts = <6 2>;
> +			interrupt-parent = <&PIC>;
> +			gpios = <1 1c 1 1d 1 1e 1 1f>;
> +			gpio-parent = <&CPM1_PIO>;
> +		};

Maybe gpios should have a length field?  Or maybe we should just
phandle to a separate node under the gpio controller node.  What happens if
a device sits on two different gpio-parents?

> +		flash@8000000 {
> +			// Flash also has info about model needed by setup
> +			compatible = "cfi-flash",
> +				     "betaresearch,dbox2-config";

What does dbox2-config mean?

> +			ovpartition@20000 {
> +				label = "Flash without bootloader";
> +				reg = <20000 7e0000>;
> +			};
> +			ovpartition@0 {
> +				label = "Complete Flash";
> +				reg = <0 800000>;
> +				read-only;
> +			};

What is "ovpartition"?

> +		wdt@0 {
> +			device_type = "watchdog";
> +			compatible = "fsl,mpc823-wdt",
> +				     "fsl,pq1-wdt";
> +			reg = <0 10>;
> +		};

No device_type.

> +		cpm@9c0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges;
> +			reg = <9c0 40>;
> +			command-proc = <9c0>;

command-proc is obsolete.

> +			muram@2000 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				ranges = <0 2000 2000>;
> +
> +				data@0 {
> +					compatible = "fsl,cpm-muram-data";
> +					reg = <0 1c00>;
> +				};
> +			};

Should have compatible of fsl,cpm-muram on the muram node as well, even
though the current code doesn't use it.

> +			// Port D is LCD exclusive. Don't export as GPIO
> +			CPM1_PIO: pio@970 {
> +				compatible = "fsl,cpm1-pario";
> +				reg = <970 180>;
> +				num-ports = <3>;
> +				#gpio-cells = <2>;
> +			};

Why are we doing things differently just because all of the pins on this
port happen to be directed to one device?  If it's because the Linux GPIO
API sucks, then either fix the API, or work around the suckage in software,
not the device tree.

> +			lcd@970 {
> +				reg = <970 10>;
> +				compatible = "samsung,ks0713";
> +			};

So some driver that matches on samsung,ks0713 has to know the details of the
mpc8xx GPIO registers?

> +			brg@9f0 {
> +				compatible = "fsl,mpc823-brg",
> +					     "fsl,cpm1-brg",
> +					     "fsl,cpm-brg";
> +				reg = <9f0 10>;
> +			};

Should have clock-frequency in the brg node.

> +			i2c@860 {
> +				compatible = "fsl,mpc823-i2c",
> +					     "fsl,cpm1-i2c",
> +					     "fsl,cpm-i2c";
> +				reg = <860 20 3c80 30>;
> +				interrupts = <10 3>;
> +				interrupt-parent = <&CPM_PIC>;
> +				fsl,cpm-command = <0010>;
> +			};

Should have #address-cells and #size-cells.

> +enum dbox2_mid dbox2_get_mid(void)
> +{
> +	return dbox2_manuf_id;
> +}
> +EXPORT_SYMBOL_GPL(dbox2_get_mid);

Honestly, you're claiming derived-work status by calling a function that
returns an integer, that was read directly from hardware?

> +	if (dbox2_manuf_id == DBOX2_MID_NOKIA)
> +		np = of_find_node_by_path("/localbus@8000000/enx@0");
> +	else
> +		np = of_find_node_by_path("/localbus@8000000/gtx@0");
> +
> +	if (np) {
> +		of_detach_node(np);
> +		of_node_put(np);
> +	}
> +
> +	if (dbox2_manuf_id == DBOX2_MID_PHILIPS)
> +		np = of_find_node_by_path("/localbus@8000000/cam@4000000");
> +	else
> +		np = of_find_node_by_path("/localbus@8000000/cam@4040000");
> +
> +	if (np) {
> +		of_detach_node(np);
> +		of_node_put(np);
> +	}
> +}

I'd use separate device trees (I only did this kind of thing in mpc885ads
because it's dip-switchable), but whatever...

> diff --git a/include/asm-powerpc/mpc8xx.h b/include/asm-powerpc/mpc8xx.h
> index 2be014b..b6fd7d6 100644
> --- a/include/asm-powerpc/mpc8xx.h
> +++ b/include/asm-powerpc/mpc8xx.h
> @@ -23,6 +23,10 @@
> #include <platforms/8xx/mpc885ads.h>
> #endif
>
> +#if defined(CONFIG_DBOX2)
> +#include <platforms/8xx/dbox2.h>
> +#endif

This shouldn't be needed.

-Scott
