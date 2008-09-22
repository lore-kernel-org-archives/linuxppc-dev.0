Return-Path: <jacmet@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 2A186DE1D7
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 00:19:45 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id m2so1463896uge.14
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 07:19:43 -0700 (PDT)
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v3] powerpc: gpio driver for mpc8349/8572/8610 and
	compatible with OF bindings
References: <1222065154-19310-1-git-send-email-jacmet@sunsite.dk>
	<20080922133254.GA25776@oksana.dev.rtsoft.ru>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Mon, 22 Sep 2008 16:19:21 +0200
In-Reply-To: <20080922133254.GA25776@oksana.dev.rtsoft.ru> (Anton Vorontsov's
	message of "Mon\, 22 Sep 2008 17\:32\:54 +0400")
Message-ID: <87ej3ctg9i.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "Anton" == Anton Vorontsov <avorontsov@ru.mvista.com> writes:

 Anton> On Mon, Sep 22, 2008 at 08:32:34AM +0200, Peter Korsgaard wrote:
 >> Structured similar to the existing QE GPIO support.
 >> 
 >> Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>

 Anton> Looks good to me, thanks.

 Anton> Few comments below, might want to consider some of them if you want to.

 >> +	gpio1: gpio-controller@c00 {
 >> +		#gpio-cells = <2>;
 >> +		compatible = "fsl,mpc8347-gpio, fsl,mpc8349-gpio";

 Anton> Some quotes are missing. Should be "fsl,mpc8347-gpio",
 Anton> "fsl,mpc8349-gpio";

Argh, sorry about that.

 >> +#define GPIO_DIR		0x00
 >> +#define GPIO_ODR		0x04
 >> +#define GPIO_DAT		0x08
 >> +#define GPIO_IER		0x0c
 >> +#define GPIO_IMR		0x10
 >> +#define GPIO_ICR		0x14

 Anton> This is better described in a struct. Will save few characters,
 Anton> and just looks nicer. That is,

I think that's basically a question about taste. Some people like
structs, some don't - I prefer the defines as it's very easy to see
exactly what addresses gets used.

 >> +struct mpc8xxx_gpio_chip {
 >> +	struct of_mm_gpio_chip mm_gc;
 >> +	spinlock_t lock;
 >> +
 >> +	/* shadowed data register to be able to clear/set output pins in
 >> +	   open drain mode safely */

 Anton> Why not a canonical comment?

 Anton> /*
 Anton>  * Multi-line
 Anton>  * comment.
 Anton>  */

Fine with me. It started as a single line comment that I later
expanded on.

 >> +static int mpc8xxx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
 >> +{
 >> +	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
 >> +
 >> +	return !!(in_be32(mm->regs + GPIO_DAT) & mpc8xxx_gpio2mask(gpio));

 Anton> No need for !!. gpio api spec says that you may return any
 Anton> value != 0 for the logical 1. Negative values are ok.

True.

 >> +static int mpc8xxx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
 >> +{
 >> +	struct of_mm_gpio_chip *mm = to_of_mm_gpio_chip(gc);
 >> +	struct mpc8xxx_gpio_chip *mpc8xxx_gc = to_mpc8xxx_gpio_chip(mm);
 >> +	unsigned long flags;
 >> +
 >> +	spin_lock_irqsave(&mpc8xxx_gc->lock, flags);
 >> +
 >> +	out_be32(mm->regs + GPIO_DIR,
 >> +		 in_be32(mm->regs + GPIO_DIR) & ~mpc8xxx_gpio2mask(gpio));

 Anton> Would look better if you'd use clrbits32().

Ok.

 >> +static int __init mpc8xxx_add_controller(struct device_node *np)
 >> +{

 Anton> You don't check return value for this function. `void' return type
 Anton> would work.

Yes, I kept it as we already keep track of the return value within the
function (for error reporting) - I'll get rid of it.

I'll send an updated patch shortly.

-- 
Bye, Peter Korsgaard
