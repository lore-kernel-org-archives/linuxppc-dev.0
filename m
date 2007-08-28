Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E8642DDE04
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 03:48:57 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7SHms6W024504
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 13:48:54 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7SHmsqV497732
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 11:48:54 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7SHmsRJ026334
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Aug 2007 11:48:54 -0600
Date: Tue, 28 Aug 2007 12:48:52 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH 3/4] PowerPC 440EPx: Sequoia board support
Message-ID: <20070828124852.1c25bfab@weaponx.rchland.ibm.com>
In-Reply-To: <20070828170007.GA1605@ru.mvista.com>
References: <20070828165321.GA1501@ru.mvista.com>
	<20070828170007.GA1605@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 28 Aug 2007 21:00:07 +0400
Valentine Barshak <vbarshak@ru.mvista.com> wrote:

> diff -ruN linux-2.6.orig/arch/powerpc/platforms/44x/sequoia.c linux-2.6/arch/powerpc/platforms/44x/sequoia.c
> --- linux-2.6.orig/arch/powerpc/platforms/44x/sequoia.c	1970-01-01 03:00:00.000000000 +0300
> +++ linux-2.6/arch/powerpc/platforms/44x/sequoia.c	2007-08-28 17:04:51.000000000 +0400
> @@ -0,0 +1,66 @@
> +/*
> + * Sequoia board specific routines
> + *
> + * Valentine Barshak <vbarshak@ru.mvista.com>
> + * Copyright 2007 MontaVista Software Inc.
> + *
> + * Based on the Bamboo code by
> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> + * Copyright 2007 IBM Corporation
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#include <linux/init.h>
> +#include <asm/machdep.h>
> +#include <asm/prom.h>
> +#include <asm/udbg.h>
> +#include <asm/time.h>
> +#include <asm/uic.h>
> +#include <asm/of_platform.h>
> +#include "44x.h"
> +
> +static struct of_device_id sequoia_of_bus[] = {
> +	{ .compatible = "ibm,plb", },

As we discussed on IRC, this needs to explicitly match one of the
compatible properties in the Sequoia DTS file.  Otherwise it won't
probe your PLB and find anything.

josh
