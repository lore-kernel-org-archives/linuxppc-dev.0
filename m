Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id CDFB6DDE10
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 22:11:53 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Mon, 11 Jun 2007 14:11:45 +0200
To: Mark Zhan <rongkai.zhan@windriver.com>
Subject: Re: [PATCH] Add the support of ST M48T59 RTC chip in rtc-class driver
	subsystem
Message-ID: <20070611121145.GA11297@iram.es>
References: <1181548600.5217.16.camel@mark>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1181548600.5217.16.camel@mark>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 11, 2007 at 03:56:40PM +0800, Mark Zhan wrote:
> Add the support of ST M48T59 RTC chip driver in RTC class subsystem for
> Wind River SBC PowerQUICCII 82xx board
> 

There are other boards which have exactly the same chip, but use
a very different (uglier) access method: using ISA 2 I/O ports
(0x74 and 0x75) to write the address and another port (0x77) to 
read/write the data.

Besides that, these boards also use the NVRAM part which means that
a spinlock must be used to serialize between RTC and NVRAM access.

I have no idea whether the drivers should be shared or two
different drivers should be written... But if there are two
different drivers, there should be a way to distinguish them
(different config name, different module names, and some
explanation in the config help text).


> Signed-off-by: Mark Zhan <rongkai.zhan@windriver.com>
> ---
>  b/drivers/rtc/Kconfig      |   10 +
>  b/drivers/rtc/Makefile     |    1 
>  b/drivers/rtc/rtc-m48t59.c |  360
> +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 371 insertions(+)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 4e4c10a..ca6a064 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -329,6 +329,16 @@ config RTC_DRV_S3C
>  	  This driver can also be build as a module. If so, the module
>  	  will be called rtc-s3c.
>  
> +config RTC_DRV_M48T59
> +	tristate "ST M48T59"
> +	depends on RTC_CLASS
> +	help
> +	  If you say Y here you will get support for the
> +	  ST M48T59 RTC chip.
> +
> +	  This driver can also be built as a module, if so, the module
> +	  will be called "rtc-m48t59".
> +
>  config RTC_DRV_EP93XX
>  	tristate "Cirrus Logic EP93XX"
>  	depends on RTC_CLASS && ARCH_EP93XX
> diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
> index a1afbc2..70ba581 100644
> --- a/drivers/rtc/Makefile
> +++ b/drivers/rtc/Makefile
> @@ -41,3 +41,4 @@ obj-$(CONFIG_RTC_DRV_V3020)	+= rtc-v3020
>  obj-$(CONFIG_RTC_DRV_AT91RM9200)+= rtc-at91rm9200.o
>  obj-$(CONFIG_RTC_DRV_SH)	+= rtc-sh.o
>  obj-$(CONFIG_RTC_DRV_BFIN)	+= rtc-bfin.o
> +obj-$(CONFIG_RTC_DRV_M48T59)	+= rtc-m48t59.o
> diff --git a/drivers/rtc/rtc-m48t59.c b/drivers/rtc/rtc-m48t59.c
> new file mode 100644
> index 0000000..0737827
> --- /dev/null
> +++ b/drivers/rtc/rtc-m48t59.c
> @@ -0,0 +1,360 @@
> +/*
> + * ST M48T59 RTC driver
> + *
> + * Copyright (c) 2007 Wind River Systems, Inc.
> + *
> + * Author: Mark Zhan <rongkai.zhan@windriver.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/rtc.h>
> +#include <linux/platform_device.h>
> +#include <linux/bcd.h>
> +
> +#define DEBUG_M48T59 1
> +
> +#ifdef DEBUG_M48T59
> +#define DPRINTK(fmt, args...)	printk(KERN_DEBUG "%s: "fmt,
> __FUNCTION__, ##args)
> +#else
> +#define DPRINTK(fmt, args...)
> +#endif
> +
> +#define M48T59_YEAR		0x1fff
> +#define M48T59_MONTH		0x1ffe
> +#define M48T59_MDAY		0x1ffd	/* Day of Month */
> +#define M48T59_WDAY		0x1ffc	/* Day of Week */
> +#define M48T59_HOUR		0x1ffb
> +#define M48T59_MIN		0x1ffa
> +#define M48T59_SEC		0x1ff9
> +#define M48T59_CNTL		0x1ff8
> +#define M48T59_WATCHDOG		0x1ff7
> +#define M48T59_INTR		0x1ff6
> +#define M48T59_ALARM_DATE	0x1ff5
> +#define M48T59_ALARM_HOUR	0x1ff4
> +#define M48T59_ALARM_MIN	0x1ff3
> +#define M48T59_ALARM_SEC	0x1ff2
> +#define M48T59_UNUSED		0x1ff1
> +#define M48T59_FLAGS		0x1ff0
> +
> +#define M48T59_WDAY_CB		0x20	/* Century Bit */
> +#define M48T59_WDAY_CEB		0x10	/* Century Enable Bit */
> +
> +#define M48T59_CNTL_READ	0x40;
> +#define M48T59_CNTL_WRITE	0x80;
> +
> +#define M48T59_FLAGS_WDT	0x80	/* watchdog timer expired */
> +#define M48T59_FLAGS_AF		0x40	/* alarm */
> +#define M48T59_FLAGS_BF		0x10	/* low battery */
> +
> +#define M48T59_INTR_AFE		0x80	/* Alarm Interrupt Enable */
> +#define M48T59_INTR_ABE		0x20
> +
> +static unsigned char * m48t59_vbase = NULL;
> +static unsigned int m48t59_irq = -1;

Shouldn't it be NO_IRQ (here and in several other places) ?

	Regards,
	Gabriel
