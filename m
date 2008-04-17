Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0613BDEA91
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 05:56:56 +1000 (EST)
Message-ID: <4807AB7A.90005@freescale.com>
Date: Thu, 17 Apr 2008 14:56:42 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/5] [POWERPC] QE: add support for QE USB clocks routing
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192846.GB28286@polina.dev.rtsoft.ru>
In-Reply-To: <20080417192846.GB28286@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:

> +config QE_USB
> +	bool
> +	help
> +	  QE USB Host Controller support

Don't you need something like "depends on USB"?  I would assume that you need
core USB support before any USB drivers can be loaded.

> --- /dev/null
> +++ b/arch/powerpc/sysdev/qe_lib/usb.c
> @@ -0,0 +1,57 @@
> +/*
> + * QE USB routines
> + *
> + * Copyright (c) Freescale Semicondutor, Inc. 2006.
> + *               Shlomi Gridish <gridish@freescale.com>

Is this code from one of our BSPs?

> +int qe_usb_clock_set(enum qe_clock clk, int rate)
> +{
> +	struct qe_mux __iomem *mux = &qe_immr->qmx;
> +	unsigned long flags;
> +	const bool is_brg = clk < QE_CLK1;

You don't really need "is_brg", since it's only used once.

> +	spin_lock_irqsave(&cmxgcr_lock, flags);
> +
> +	clrsetbits_be32(&mux->cmxgcr, QE_CMXGCR_USBCS, val);

Would it be useful if I made the clrsetbits functions atomic, using lwarx/stwcx.?

-- 
Timur Tabi
Linux kernel developer at Freescale
