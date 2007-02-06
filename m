Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 6AF00DDE39
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 00:18:01 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/3] add USB setup code for 8349emds PB
Date: Tue, 6 Feb 2007 14:17:52 +0100
References: <45C844BF.8020805@freescale.com>
In-Reply-To: <45C844BF.8020805@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702061417.53446.arnd@arndb.de>
Cc: Li Yang <leoli@freescale.com>, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 06 February 2007 10:05, Li Yang wrote:
>  
> +static volatile u8 *bcsr_regs = NULL;

A 'static volatile u8*' type sounds very wrong. You use the variable
only in one function, so it should be local to that. There is normally
no reason to ever mark a variable volatile in driver code, instead
you want it to be '__iomem'. It should probably also be 'void *'
instead of 'u8 *', so it doesn't get dereferenced by accident.
Your references should be changed to use in_8/out_8 or readb/writeb,
depending on whether it's on-chip or PCI space.

> +	if ((np = of_find_compatible_node(np, "usb", "fsl-usb2-dr")) != NULL)
> +		port0_is_dr = 1;
> +	if ((np = of_find_compatible_node(np, "usb", "fsl-usb2-mph")) != NULL){
> +		if (port0_is_dr) {
> +			printk(KERN_WARNING
> +				"There is only one USB port on PB board! \n");
> +			return -1;
> +		} else if (!port0_is_dr)
> +			/* No usb port enabled */
> +			return -1;
> +	}

I'm not sure if scanning through the device tree to find mmio addresses
is still considered valid style. I would instead prefer you to provide a
of_platform_driver that attaches to the respective 'compatible' property
and does the register access in its probe() function in order to not
conflict with other drivers.

	Arnd <><
