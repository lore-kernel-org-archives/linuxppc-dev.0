Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A75A9DDEBC
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 08:23:14 +1100 (EST)
Subject: Re: [PATCH] ps3: don't call ps3_system_bus_driver_register on
	other platforms
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200702140704.l1E74IqP013586@toshiba.co.jp>
References: <200702140704.l1E74IqP013586@toshiba.co.jp>
Content-Type: text/plain
Date: Thu, 15 Feb 2007 08:22:51 +1100
Message-Id: <1171488171.20192.170.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: greg@kroah.com, dbrownell@users.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-02-14 at 16:04 +0900, Ishizaki Kou wrote:
> ps3_system_bus_driver_register is PS3 platform specific function.
> On other platforms, it triggers WARN_ON in kref_get.
> 
> Signed-off-by: Kou Ishizaki <kou.ishizaki@toshiba.co.jp>

A bit nasty but that's the price of wanting to have all the bus glues in
one file (I didn't agree but that's what David prefers...)

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
> 
> Index: linux-powerpc-git/drivers/usb/host/ehci-hcd.c
> diff -u linux-powerpc-git/drivers/usb/host/ehci-hcd.c:1.1.1.2 linux-powerpc-git/drivers/usb/host/ehci-hcd.c:1.4
> --- linux-powerpc-git/drivers/usb/host/ehci-hcd.c:1.1.1.2	Fri Feb  9 13:44:37 2007
> +++ linux-powerpc-git/drivers/usb/host/ehci-hcd.c	Wed Feb 14 12:30:56 2007
> @@ -42,6 +42,9 @@
>  #include <asm/irq.h>
>  #include <asm/system.h>
>  #include <asm/unaligned.h>
> +#ifdef CONFIG_PPC_PS3
> +#include <asm/firmware.h>
> +#endif
>  
> 
>  /*-------------------------------------------------------------------------*/
> @@ -951,15 +954,18 @@
>  #endif
>  
>  #ifdef PS3_SYSTEM_BUS_DRIVER
> -	retval = ps3_system_bus_driver_register(&PS3_SYSTEM_BUS_DRIVER);
> -	if (retval < 0) {
> +	if (firmware_has_feature(FW_FEATURE_PS3_LV1)) {
> +		retval = ps3_system_bus_driver_register(
> +				&PS3_SYSTEM_BUS_DRIVER);
> +		if (retval < 0) {
>  #ifdef PLATFORM_DRIVER
> -		platform_driver_unregister(&PLATFORM_DRIVER);
> +			platform_driver_unregister(&PLATFORM_DRIVER);
>  #endif
>  #ifdef PCI_DRIVER
> -		pci_unregister_driver(&PCI_DRIVER);
> +			pci_unregister_driver(&PCI_DRIVER);
>  #endif
> -		return retval;
> +			return retval;
> +		}
>  	}
>  #endif
>  
> @@ -976,7 +982,8 @@
>  	pci_unregister_driver(&PCI_DRIVER);
>  #endif
>  #ifdef PS3_SYSTEM_BUS_DRIVER
> -	ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
> +	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
> +		ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
>  #endif
>  }
>  module_exit(ehci_hcd_cleanup);
> Index: linux-powerpc-git/drivers/usb/host/ohci-hcd.c
> diff -u linux-powerpc-git/drivers/usb/host/ohci-hcd.c:1.1.1.4 linux-powerpc-git/drivers/usb/host/ohci-hcd.c:1.2
> --- linux-powerpc-git/drivers/usb/host/ohci-hcd.c:1.1.1.4	Fri Feb  9 13:44:37 2007
> +++ linux-powerpc-git/drivers/usb/host/ohci-hcd.c	Wed Feb 14 12:30:56 2007
> @@ -42,6 +42,9 @@
>  #include <asm/system.h>
>  #include <asm/unaligned.h>
>  #include <asm/byteorder.h>
> +#ifdef CONFIG_PPC_PS3
> +#include <asm/firmware.h>
> +#endif
>  
>  #include "../core/hcd.h"
>  
> @@ -944,9 +947,12 @@
>  		sizeof (struct ed), sizeof (struct td));
>  
>  #ifdef PS3_SYSTEM_BUS_DRIVER
> -	retval = ps3_system_bus_driver_register(&PS3_SYSTEM_BUS_DRIVER);
> -	if (retval < 0)
> -		goto error_ps3;
> +	if (firmware_has_feature(FW_FEATURE_PS3_LV1)) {
> +		retval = ps3_system_bus_driver_register(
> +				&PS3_SYSTEM_BUS_DRIVER);
> +		if (retval < 0)
> +			goto error_ps3;
> +	}
>  #endif
>  
>  #ifdef PLATFORM_DRIVER
> @@ -992,7 +998,8 @@
>   error_platform:
>  #endif
>  #ifdef PS3_SYSTEM_BUS_DRIVER
> -	ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
> +	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
> +		ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
>   error_ps3:
>  #endif
>  	return retval;
> @@ -1014,7 +1021,8 @@
>  	platform_driver_unregister(&PLATFORM_DRIVER);
>  #endif
>  #ifdef PS3_SYSTEM_BUS_DRIVER
> -	ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
> +	if (firmware_has_feature(FW_FEATURE_PS3_LV1))
> +		ps3_system_bus_driver_unregister(&PS3_SYSTEM_BUS_DRIVER);
>  #endif
>  }
>  module_exit(ohci_hcd_mod_exit);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
