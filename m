Return-Path: <dgibson@ozlabs.org>
Date: Fri, 22 Jun 2007 13:31:58 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Subject: Re: [PATCH v3] Create add_rtc() function to enable the RTC CMOS driver
Message-ID: <20070622033158.GA21419@localhost.localdomain>
References: <1182298510.5674.358.camel@rhino> <1182358772.5674.383.camel@rhino>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1182358772.5674.383.camel@rhino>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jun 20, 2007 at 09:59:32AM -0700, Wade Farnsworth wrote:
> In order to use the RTC CMOS driver, each architecture must register a
> platform device for the RTC.
> 
> This creates a function to register the platform device based on the RTC
> device node and verifies that the RTC port against the hard-coded value
> in asm/mc146818rtc.h.
> 
> Signed-off-by: Wade Farnsworth <wfarnsworth@mvista.com>

Hrm.  It seems rather specific.  Can we do this more generally, by
creating an of_platform device which binds to rtc nodes, then
registers an appropriate platform device for each so that the generic
rtc drivers pick them up.  Obviously we'd need some sort of table
mapping the device node compatible properties to the appropriate
platform device names.

> Index: linux-2.6-powerpc-8641/arch/powerpc/sysdev/Makefile
> ===================================================================
> --- linux-2.6-powerpc-8641.orig/arch/powerpc/sysdev/Makefile
> +++ linux-2.6-powerpc-8641/arch/powerpc/sysdev/Makefile
> @@ -18,6 +18,7 @@ obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pc
>  obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
>  mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
>  obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o
> +obj-$(CONFIG_RTC_DRV_CMOS)	+= rtc_cmos_setup.o
>  
>  # contains only the suspend handler for time
>  obj-$(CONFIG_PM)		+= timer.o
> Index: linux-2.6-powerpc-8641/arch/powerpc/sysdev/rtc_cmos_setup.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6-powerpc-8641/arch/powerpc/sysdev/rtc_cmos_setup.c
> @@ -0,0 +1,51 @@
> +/*
> + * Setup code for PC-style Real-Time Clock.
> + *
> + * Author: Wade Farnsworth <wfarnsworth@mvista.com>
> + *
> + * 2007 (c) MontaVista Software, Inc. This file is licensed under
> + * the terms of the GNU General Public License version 2. This program
> + * is licensed "as is" without any warranty of any kind, whether
> express
> + * or implied.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/mc146818rtc.h>
> +
> +#include <asm/prom.h>
> +
> +static int  __init add_rtc(void)
> +{
> +	struct device_node *np;
> +	struct platform_device *pd;
> +	struct resource res;
> +
> +	np = of_find_compatible_node(NULL, NULL, "pnpPNP,b00");
> +	if (!np)
> +		return -ENODEV;
> +
> +	if (of_address_to_resource(np, 0, &res)) {
> +		of_node_put(np);
> +		return -ENODEV;
> +	}
> +
> +	/*
> +	 * RTC_PORT(x) is hardcoded in asm/mc146818rtc.h.  Verify that the
> +	 * address provided by the device node matches.
> +	 */
> +	if (res.start != RTC_PORT(0)) {
> +		of_node_put(np);
> +		return -ENODEV;
> +	}

This looks totally bogus.  If we have a device tree we should be using
the address information from there, not using hardcoded magic.  Sounds
like asm/mc146818rtc.h needs some serious fixing.

> +
> +	pd = platform_device_register_simple("rtc_cmos", -1,
> +					     &res, 1);
> +	of_node_put(np);
> +	if (IS_ERR(pd))
> +		return PTR_ERR(pd);
> +
> +	return 0;
> +}
> +fs_initcall(add_rtc);
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
