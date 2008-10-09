Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6B5DCDE211
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 06:03:43 +1100 (EST)
Date: Thu, 9 Oct 2008 23:03:40 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: PPC440EPx gpio driver
Message-ID: <20081009190340.GA28107@oksana.dev.rtsoft.ru>
References: <48ED1E96.4060406@harris.com>
	<20081009173810.GA14959@oksana.dev.rtsoft.ru>
	<48EE47C1.1000303@harris.com> <200810092046.44665.sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <200810092046.44665.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 09, 2008 at 08:46:44PM +0200, Stefan Roese wrote:
[...]
> > +struct ppc4xx_gpio_chip {
> > +	struct of_mm_gpio_chip mm_gc;
> > +	spinlock_t lock;
> > +	u32 shadow_or;
> > +	u32 shadow_tcr;
> > +	u32 shadow_osrl;
> > +	u32 shadow_osrh;
> > +	u32 shadow_tsrl;
> > +	u32 shadow_tsrh;
> > +	u32 shadow_odr;
> > +};
> 
> Do we really need all those shadow registers? Access to the "real" registers 
> is done while holding the spinlock.

The shadowed registers aren't about holding a spinlock, but are
about open drain pins and the fact that some GPIO controllers are
using single "data" register for "read state", "set state" and
"clear state" GPIO operations.

See Grant's reply:

http://ozlabs.org/pipermail/linuxppc-dev/2008-January/050826.html

(I didn't look for the hardware details of this driver, so I don't
know if the driver really needs to shadow the registers.)

[...]
> > +	for_each_compatible_node(np, NULL, "amcc,ppc4xx-gpio") {
> > +		int ret;
> > +		struct ppc4xx_gpio_chip *ppc4xx_gc;
> > +		struct of_mm_gpio_chip *mm_gc;
> > +		struct of_gpio_chip *of_gc;
> > +		struct gpio_chip *gc;
> > +
> > +		ppc4xx_gc = kzalloc(sizeof(*ppc4xx_gc), GFP_KERNEL);
> > +		if (!ppc4xx_gc) {
> > +			ret = -ENOMEM;
> > +			goto err;
> > +		}
> > +
> > +		spin_lock_init(&ppc4xx_gc->lock);
> > +
> > +		mm_gc = &ppc4xx_gc->mm_gc;
> > +		of_gc = &mm_gc->of_gc;
> > +		gc = &of_gc->gc;
> > +
> > +		mm_gc->save_regs = ppc4xx_gpio_save_regs;
> > +		of_gc->gpio_cells = 2;
> > +		gc->ngpio = 32;
> > +		gc->direction_input = ppc4xx_gpio_dir_in;
> > +		gc->direction_output = ppc4xx_gpio_dir_out;
> > +		gc->get = ppc4xx_gpio_get;
> > +		gc->set = ppc4xx_gpio_set;
> > +
> > +		ret = of_mm_gpiochip_add(np, mm_gc);
> > +		if (ret)
> > +			goto err;
> > +		continue;
> > +err:
> > +		pr_err("%s: registration failed with status %d\n",
> > +		       np->full_name, ret);
> > +		kfree(ppc4xx_gc);
> 
> This probably crashes if the kzalloc() fails above.

kfree(NULL); is defined to be a no-op.


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
