Return-Path: <cbouatmailru@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.184])
	by ozlabs.org (Postfix) with ESMTP id 17711DDEFD
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 08:47:30 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so440943nfd.9
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 15:47:27 -0700 (PDT)
Date: Thu, 1 May 2008 02:47:26 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH v2 4/6] [POWERPC] QE: implement support for the GPIO
	LIB API
Message-ID: <20080430224726.GA5529@zarina>
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190045.GD21203@polina.dev.rtsoft.ru>
	<20080430193040.GA9239@polina.dev.rtsoft.ru>
	<4818CB8B.9010106@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4818CB8B.9010106@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 30, 2008 at 02:42:03PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> 
> > +   Example:
> > +	qe_pio_a: gpio-controller@1400 {
> > +		#gpio-cells = <2>;
> > +		compatible = "fsl,mpc8360-qe-pario-bank",
> > +			     "fsl,mpc8323-qe-pario-bank";
> 
> I know this is an example, but would we ever include both compatible strings in
> one DTS?  Isn't the norm something like:
> 
> "fsl,mpc8360-qe-pario-bank", "fsl,qe-pario-bank";
> 
> I.e. specific version, then generic version?

Per Grant Likely's comments, "fsl,qe-pario-bank" considered as a made up
stuff. MPC8323 is the first QE chip, so every next QE chips should be
compatible.

Though, for fsl,gtm we can't use this, since we really want generic
name.

> Otherwise, every time we introduce a new QE part, we'll have to update *every*
> QE-enabled device tree *and* the QE gpio driver.

Nope. If the the QE is compatible with the previous, just write
"fsl,newchip-qe-pario-bank", "fsl,mpc8323-qe-pario-bank".

Btw, the same we do for the 8349 compatible PCI.

> > +static int qe_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> > +{
> > +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> > +	struct qe_pio_regs __iomem *regs = mm_gc->regs;
> > +	u32 pin_mask = 1 << (QE_PIO_PINS - 1 - gpio);
> > +
> > +	return in_be32(&regs->cpdata) & pin_mask;
> > +}
> 
> Return value should be "u32", not "int".

gpio.h disagree

$ cat include/asm-generic/gpio.h  | grep \*get
        int                     (*get)(struct gpio_chip *chip,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
