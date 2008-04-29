Return-Path: <cbouatmailru@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 5F42DDE268
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 07:23:12 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id e27so33796nfd.9
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 14:23:12 -0700 (PDT)
Date: Wed, 30 Apr 2008 01:23:05 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 4/6] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080429212304.GA8103@zarina>
References: <20080429185920.GA19735@polina.dev.rtsoft.ru>
	<20080429190045.GD21203@polina.dev.rtsoft.ru>
	<4817850C.20201@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <4817850C.20201@freescale.com>
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

On Tue, Apr 29, 2008 at 03:29:00PM -0500, Timur Tabi wrote:
> Anton Vorontsov wrote:
> > This is needed to access QE GPIOs via Linux GPIO API.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  Documentation/powerpc/booting-without-of.txt |   37 ++++---
> >  arch/powerpc/sysdev/qe_lib/Kconfig           |    9 ++
> >  arch/powerpc/sysdev/qe_lib/Makefile          |    1 +
> >  arch/powerpc/sysdev/qe_lib/gpio.c            |  145 ++++++++++++++++++++++++++
> >  include/asm-powerpc/qe.h                     |    1 +
> >  5 files changed, 180 insertions(+), 13 deletions(-)
> >  create mode 100644 arch/powerpc/sysdev/qe_lib/gpio.c
> > 
> > diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
> > index fc7a235..4fefc44 100644
> > --- a/Documentation/powerpc/booting-without-of.txt
> > +++ b/Documentation/powerpc/booting-without-of.txt
> > @@ -1723,24 +1723,35 @@ platforms are moved over to use the flattened-device-tree model.
> >     information.
> >  
> >     Required properties:
> > -   - device_type : should be "par_io".
> > +   - #gpio-cells : should be "2".
> > +   - compatible : should be "fsl,<chip>-qe-pario-bank",
> > +     "fsl,mpc8323-qe-pario-bank".
> >     - reg : offset to the register set and its length.
> > -   - num-ports : number of Parallel I/O ports
> > +   - gpio-controller : node to identify gpio controllers.
> >  
> > -   Example:
> > -	par_io@1400 {
> > -		reg = <1400 100>;
> > -		#address-cells = <1>;
> > -		#size-cells = <0>;
> > -		device_type = "par_io";
> > -		num-ports = <7>;
> > -		ucc_pin@01 {
> > -			......
> > -		};
> > +   For example, two QE Par I/O banks:
> > +	qe_pio_a: gpio-controller@1400 {
> 
> I think this change will break a number of boards, because a lot of them do this:
> 
> 	if ((np = of_find_node_by_name(NULL, "par_io")) != NULL) {
> 		par_io_init(np);
> 
> So if you're going to change the par_io nodes, you need to change the code as well.
> 
> A patch that changes the documentation should also change the code.  And if
> you're code changes the device tree, it should also maintain compatibility for
> older device trees.

Well, I'm indeed removing [further] support for the par_io nodes,
overwriting it with gpio nodes. That way we'll stop new use cases of
these nodes.

Eventually I plan to adjust the existing code/device trees accordingly.
If you think that code should be adjusted at the same time as
documentation, I'm fine with it as well. I'll just add new documentation
instead of replacing the old.

> > +		#gpio-cells = <2>;
> > +		compatible = "fsl,mpc8360-qe-pario-bank",
> > +			     "fsl,mpc8323-qe-pario-bank";
> > +		reg = <0x1400 0x18>;
> > +		gpio-controller;
> > +	};
> >  
> > +	qe_pio_e: gpio-controller@1460 {
> > +		#gpio-cells = <2>;
> > +		compatible = "fsl,mpc8360-qe-pario-bank",
> > +			     "fsl,mpc8323-qe-pario-bank";
> > +		reg = <0x1460 0x18>;
> > +		gpio-controller;
> > +	};
> >  
> >     vi) Pin configuration nodes
> >  
> > +   NOTE: pin configuration nodes are obsolete. Usually, their existance
> > +         is an evidence of the firmware shortcomings. Such fixups are
> > +         better handled by the Linux board file, not the device tree.
> 
> You can't just delete the par_io documentation without updating the code and
> planning for feature removal.  Almost all of the existing code out there for QE
> boards expects a par_io node, and the device trees still have them.

Yup, exactly. Old device tree still use them, but don't we want to get
rid of this? If so, we should remove documentation, or someone will
use it for the new device trees. ;-)

> > +static int qe_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> > +{
> > +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> > +	struct qe_pio_regs __iomem *regs = mm_gc->regs;
> > +	u32 pin_mask = 1 << (QE_PIO_PINS - 1 - gpio);
> > +
> > +	return !!(in_be32(&regs->cpdata) & pin_mask);
> 
> Do we need to do "!!"?  I thought as long as the result was non-zero, it didn't
> matter what the actual value is.  "!!" converts non-zero to 1.

Just checked with the Documentation/gpio.txt... yup we don't need this.
"The values are boolean, zero for low, nonzero for high."

> > +static int qe_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
> > +{
> > +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> > +	struct qe_gpio_chip *qe_gc = to_qe_gpio_chip(mm_gc);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&qe_gc->lock, flags);
> > +
> > +	__par_io_config_pin(mm_gc->regs, gpio, 2, 0, 0, 0);
> 
> No magic numbers, please.

Ok.

> > +void __init qe_add_gpiochips(void)
> > +{
> > +	int ret;
> > +	struct device_node *np;
> > +
> > +	for_each_compatible_node(np, NULL, "fsl,mpc8323-qe-pario-bank") {
> > +		struct qe_gpio_chip *qe_gc;
> > +		struct of_mm_gpio_chip *mm_gc;
> > +		struct of_gpio_chip *of_gc;
> > +		struct gpio_chip *gc;
> > +
> > +		qe_gc = kzalloc(sizeof(*qe_gc), GFP_KERNEL);
> > +		if (!qe_gc) {
> > +			ret = -ENOMEM;
> > +			goto err;
> > +		}
> > +
> > +		spin_lock_init(&qe_gc->lock);
> > +
> > +		mm_gc = &qe_gc->mm_gc;
> > +		of_gc = &mm_gc->of_gc;
> > +		gc = &of_gc->gc;
> > +
> > +		mm_gc->save_regs = qe_gpio_save_regs;
> > +		of_gc->gpio_cells = 2;
> > +		gc->ngpio = QE_PIO_PINS;
> > +		gc->direction_input = qe_gpio_dir_in;
> > +		gc->direction_output = qe_gpio_dir_out;
> > +		gc->get = qe_gpio_get;
> > +		gc->set = qe_gpio_set;
> > +
> > +		ret = of_mm_gpiochip_add(np, mm_gc);
> > +		if (ret)
> > +			goto err;
> > +	}
> > +
> > +	return;
> > +err:
> > +	pr_err("%s: registration failed with status %d\n", np->full_name, ret);
> > +	of_node_put(np);
> 
> Memory leak here.  If of_mm_gpiochip_add() fails or if the 2nd call to kzalloc()
> fails, the already-allocated qe_gc objects won't be released.

Thanks for catching this.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
