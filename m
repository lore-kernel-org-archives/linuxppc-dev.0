Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 25CDA67E43
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 09:25:37 +1000 (EST)
Received: from [127.0.0.1] (helo=dmt.cnet)
	by parcelfarce.linux.theplanet.co.uk with esmtp (Exim 4.43)
	id 1E1Y52-00086B-CI
	for linuxppc-embedded@ozlabs.org; Sun, 07 Aug 2005 00:27:56 +0100
Date: Sat, 6 Aug 2005 20:20:22 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Message-ID: <20050806232022.GC1099@dmt.cnet>
References: <20050806180131.GU5210@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050806180131.GU5210@cathedrallabs.org>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] 8xx: port i2c-algo-8xx to 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Aug 06, 2005 at 03:01:31PM -0300, Aristeu Sergio Rozanski Filho wrote:
> 8xx: port i2c-algo_8xx to 2.6
> 
> Based on Tom Rini's work 
>
> compile tested 

Would be good to test before submitting? :)

> Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
> 
> Index: 2.6-8xx/drivers/i2c/algos/i2c-algo-8xx.c
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ 2.6-8xx/drivers/i2c/algos/i2c-algo-8xx.c	2005-08-05 17:16:08.000000000 -0300
> @@ -0,0 +1,625 @@
> +/*
> + * i2c-algo-8xx.c i2x driver algorithms for MPC8XX CPM
> + * Copyright (c) 1999 Dan Malek (dmalek@jlc.net).
> + *
> +    This program is free software; you can redistribute it and/or modify
> +    it under the terms of the GNU General Public License as published by
> +    the Free Software Foundation; either version 2 of the License, or
> +    (at your option) any later version.
> +
> +    This program is distributed in the hope that it will be useful,
> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +    GNU General Public License for more details.
> +
> +    You should have received a copy of the GNU General Public License
> +    along with this program; if not, write to the Free Software
> +    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + * moved into proper i2c interface; separated out platform specific
> + * parts into i2c-rpx.c
> + * Brad Parker (brad@heeltoe.com)
> + */
> +
> +// XXX todo
> +// timeout sleep?
> +
> +/* $Id: i2c-algo-8xx.c,v 1.7 2002/08/03 22:48:18 ac9410 Exp $ */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/delay.h>
> +#include <linux/slab.h>
> +#include <linux/version.h>
> +#include <linux/init.h>
> +#include <asm/uaccess.h>
> +#include <linux/ioport.h>
> +#include <linux/errno.h>
> +#include <linux/sched.h>
> +
> +#include <asm/mpc8xx.h>
> +#include <asm/commproc.h>
> +
> +#include <linux/i2c.h>
> +#include <linux/i2c-algo-8xx.h>
> +
> +#define CPM_MAX_READ	513
> +/* Try uncomment this if you have an older CPU(earlier than rev D4) */
> +/* #define I2C_CHIP_ERRATA */
> +
> +static char *module_name = "i2c_algo_8xx";
> +#define DEBUGP(level, x, y...) do { \
> +				if (cpm_debug >= level) \
> +					printk(KERN_DEBUG "%s: " x, \
> +					       module_name, ## y); \
> +				} while(0)
> +
> +static wait_queue_head_t iic_wait;
> +static ushort r_tbase, r_rbase;
> +
> +int cpm_scan = 0;
> +int cpm_debug = 0;
> +
> +static  void
> +cpm_iic_interrupt(void *dev_id, struct pt_regs *regs)
> + {
> +	volatile i2c8xx_t *i2c = (i2c8xx_t *)dev_id;

You got an extra space everywhere other than the initial TAB?
