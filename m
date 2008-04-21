Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 6E59ADE0E8
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 00:49:39 +1000 (EST)
Date: Mon, 21 Apr 2008 18:49:38 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/5] [POWERPC] QE: implement support for the GPIO LIB API
Message-ID: <20080421144938.GA25627@polina.dev.rtsoft.ru>
References: <20080418190632.GA32204@polina.dev.rtsoft.ru>
	<20080418190959.GD4407@polina.dev.rtsoft.ru>
	<fa686aa40804210719x475698f8n3b82e795547bfc70@mail.gmail.com>
	<20080421143313.GB18008@polina.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <20080421143313.GB18008@polina.dev.rtsoft.ru>
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 06:33:13PM +0400, Anton Vorontsov wrote:
[...]
> > >  +static int __init qe_add_gpiochips(void)
> > >  +{
> > >  +       int ret;
> > >  +       struct device_node *np;
> > >  +
> > >  +       for_each_compatible_node(np, NULL, "fsl,qe-pario-bank") {
> > >  +               struct qe_gpio_chip *qe_gc;
> > >  +               struct of_mm_gpio_chip *mm_gc;
> > >  +               struct of_gpio_chip *of_gc;
> > >  +               struct gpio_chip *gc;
> > >  +
> > >  +               qe_gc = kzalloc(sizeof(*qe_gc), GFP_KERNEL);
> > >  +               if (!qe_gc) {
> > >  +                       ret = -ENOMEM;
> > >  +                       goto err;
> > >  +               }
> > >  +
> > >  +               spin_lock_init(&qe_gc->lock);
> > >  +
> > >  +               mm_gc = &qe_gc->mm_gc;
> > >  +               of_gc = &mm_gc->of_gc;
> > >  +               gc = &of_gc->gc;
> > >  +
> > >  +               mm_gc->save_regs = qe_gpio_save_regs;
> > >  +               of_gc->gpio_cells = 2;
> > >  +               gc->ngpio = QE_PIO_PINS;
> > >  +               gc->direction_input = qe_gpio_dir_in;
> > >  +               gc->direction_output = qe_gpio_dir_out;
> > >  +               gc->get = qe_gpio_get;
> > >  +               gc->set = qe_gpio_set;
> > >  +
> > >  +               ret = of_mm_gpiochip_add(np, mm_gc);
> > >  +               if (ret)
> > >  +                       goto err;
> > >  +       }
> > >  +
> > >  +       return 0;
> > >  +err:
> > >  +       pr_err("%s: registration failed with status %d\n", np->full_name, ret);
> > >  +       of_node_put(np);
> > >  +       return ret;
> > >  +}
> > >  +arch_initcall(qe_add_gpiochips);
> > 
> > Should this really be a arch_initcall()?  Would it be better for
> > platforms needing it to call it explicitly from one of the platform's
> > machine_arch_initcall()?  Otherwise it gets called for all platforms
> > in a multiplatform kernel.
> 
> Ok, I'll place it into qe_reset().

Ugh, no, I can't. qe_reset() is called too early. And I don't like
having every QE board file to call this through machine_arch_initcall...
Hmm, what to do.. well, is this thaat bad to call this for every
platform?..

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
