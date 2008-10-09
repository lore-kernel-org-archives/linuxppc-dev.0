Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 49CE4DE35A
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 04:38:12 +1100 (EST)
Date: Thu, 9 Oct 2008 21:38:10 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: PPC440EPx gpio driver
Message-ID: <20081009173810.GA14959@oksana.dev.rtsoft.ru>
References: <48ED1E96.4060406@harris.com> <48EE1EE1.1050206@harris.com>
	<20081009160803.GA20923@oksana.dev.rtsoft.ru>
	<48EE3ABE.6090007@harris.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <48EE3ABE.6090007@harris.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 09, 2008 at 01:09:18PM -0400, Steven A. Falco wrote:
> Please disregard the previous version, and consider this one instead.
> The only difference is making better use of to_ppc4xx_gpiochip(), which
> helps readability.
> 
> Signed-off-by: Steve Falco <sfalco at harris.com>
[...]
>  #endif /* __ASM_POWERPC_PPC4xx_H__ */
> diff --git a/arch/powerpc/sysdev/Kconfig b/arch/powerpc/sysdev/Kconfig
> index 72fb35b..f4a8edb 100644
> --- a/arch/powerpc/sysdev/Kconfig
> +++ b/arch/powerpc/sysdev/Kconfig
> @@ -6,3 +6,11 @@ config PPC4xx_PCI_EXPRESS
>  	bool
>  	depends on PCI && 4xx
>  	default n
> +
> +config PPC4xx_GPIO
> +	bool "PPC4xx GPIO support"
> +	depends on 4xx
> +	select ARCH_REQUIRE_GPIOLIB
> +	select GENERIC_GPIO
> +	help
> +	  Enable gpiolib support for PPC4xx based boards

User-selectable options should go into the
arch/powerpc/platforms/Kconfig, otherwise you'll see the PPC4xx GPIO
support in the top-level menu in the menuconfig.

> diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
> index a90054b..35d5765 100644
> --- a/arch/powerpc/sysdev/Makefile
> +++ b/arch/powerpc/sysdev/Makefile
> @@ -35,6 +35,7 @@ obj-$(CONFIG_OF_RTC)		+= of_rtc.o
>  ifeq ($(CONFIG_PCI),y)
>  obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
>  endif
> +obj-$(CONFIG_PPC4xx_GPIO)	+= ppc4xx_gpio.o

Though the driver and Makefile entries are OK to live in the the
sysdev/.

>  
>  # Temporary hack until we have migrated to asm-powerpc
>  ifeq ($(ARCH),powerpc)
> diff --git a/arch/powerpc/sysdev/ppc4xx_gpio.c b/arch/powerpc/sysdev/ppc4xx_gpio.c
> new file mode 100644
> index 0000000..93acd3f
> --- /dev/null
> +++ b/arch/powerpc/sysdev/ppc4xx_gpio.c
> @@ -0,0 +1,238 @@
> +/*
> + * PPC4xx gpio driver
> + *
> + * Copyright (c) 2008 Harris Corporation
> + * Copyright (c) 2008 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
> + * Copyright (c) MontaVista Software, Inc. 2008.
> + *
> + * Author: Steve Falco <sfalco@harris.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/spinlock.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
> +#include <linux/gpio.h>

We explicitly include all the headers, even if they're already
included in some header files. Thus you might want to add
#include <linux/types.h>


Reviewed-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
