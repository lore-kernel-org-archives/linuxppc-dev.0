Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 58E26DE251
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 05:42:17 +1000 (EST)
Message-ID: <4818CB8B.9010106@freescale.com>
Date: Wed, 30 Apr 2008 14:42:03 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2 4/6] [POWERPC] QE: implement support for the GPIO LIB
	API
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190045.GD21203@polina.dev.rtsoft.ru>
	<20080430193040.GA9239@polina.dev.rtsoft.ru>
In-Reply-To: <20080430193040.GA9239@polina.dev.rtsoft.ru>
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

> +   Example:
> +	qe_pio_a: gpio-controller@1400 {
> +		#gpio-cells = <2>;
> +		compatible = "fsl,mpc8360-qe-pario-bank",
> +			     "fsl,mpc8323-qe-pario-bank";

I know this is an example, but would we ever include both compatible strings in
one DTS?  Isn't the norm something like:

"fsl,mpc8360-qe-pario-bank", "fsl,qe-pario-bank";

I.e. specific version, then generic version?

Otherwise, every time we introduce a new QE part, we'll have to update *every*
QE-enabled device tree *and* the QE gpio driver.

> +static int qe_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> +	struct qe_pio_regs __iomem *regs = mm_gc->regs;
> +	u32 pin_mask = 1 << (QE_PIO_PINS - 1 - gpio);
> +
> +	return in_be32(&regs->cpdata) & pin_mask;
> +}

Return value should be "u32", not "int".

-- 
Timur Tabi
Linux kernel developer at Freescale
