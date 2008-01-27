Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id B1C0FDDE16
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 07:59:53 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so343122anc.78
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 12:59:52 -0800 (PST)
Message-ID: <fa686aa40801271259k5fd3340bg1b7f29da774be85b@mail.gmail.com>
Date: Sun, 27 Jan 2008 13:59:51 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: cbouatmailru@gmail.com
Subject: Re: [PATCH 3/3] [POWERPC] QE: implement GPIO LIB API
In-Reply-To: <20080127160818.GA25859@zarina>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080108184341.GA29753@localhost.localdomain>
	<20080108184525.GC18445@localhost.localdomain>
	<479C8A34.2000701@scram.de> <20080127160818.GA25859@zarina>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/27/08, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> On Sun, Jan 27, 2008 at 02:42:12PM +0100, Jochen Friedrich wrote:
> > Hi Anton,
> >
> > > +static void qe_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> > > +{
> > > +   struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> > > +   struct port_regs *regs = mm_gc->regs;
> > > +   u32 pin_mask;
> > > +   u32 tmp_val;
> > > +
> > > +   /* calculate pin location */
> > > +   pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - gpio));
> > > +
> > > +   tmp_val = in_be32(&regs->cpdata);
> > > +
> > > +   if (val == 0)
> > > +           out_be32(&regs->cpdata, ~pin_mask & tmp_val);
> > > +   else
> > > +           out_be32(&regs->cpdata, pin_mask | tmp_val);
> > > +}
> >
> > I see a possible problem with this (and in the corresponding call in CPM1, as well):
> >
> > if there is a pin configured as open drain, you might accidently switch this pin to 0
> > while switching a different pin, if an external device is pulling the pin to 0.
>
> Unfortunately I can't think out any workaround for this, except
> implementing generic gpio_bank_{,un}lock(gpio_pin_on_the_bank), and
> start using it in the drivers that might care about this issue. Though,
> looking into i2c-gpio.c I don't clearly see were we can insert these
> locks, there should be "start/end transaction" handlers or something,
> but it seems that it's in the bitbanging code, not in the i2c-gpio
> driver..
>
> Actually, I see this as a hardware limitation. For example, on ARMs
> PXA2xx, there are separate, per bank, read/set/clear GPIO registers,
> not all-in-one data register.

I've run into this exact issue on other GPIO hardware too.  It's not
uncommon behaviour in GPIO hardware.

The solution is to not depend on the hardware to remember what the
output pin values should be.  Add a shadow register in the driver
private data.  Set the pin state for each output pin in the shadow
register and then write that value to the hardware.  That way input
state doesn't interfere with the output values.

Also, you do still need spinlocks around the manipulation of the
shared registers; otherwise you'll have very hard to debug race
conditions.  Probably one spin lock per bank.

Here's what I did for a Xilinx GPIO block driver (but ignore the fact
that I'm not using driver private data so only one GPIO block can be
supported; that will be fixed before I post this driver)

+void gpio_set_value(unsigned gpio, int value)
+{
+       unsigned long flags;
+
+       if (!gpio_regs)
+               return;
+
+       spin_lock_irqsave(&gpio_spinlock, flags);
+       if (value)
+               gpio_output_state |= 1<<gpio;
+       else
+               gpio_output_state &= ~(1<<gpio);
+       out_be32(gpio_regs, gpio_output_state);
+       spin_unlock_irqrestore(&gpio_spinlock, flags);
+}
+EXPORT_SYMBOL_GPL(gpio_set_value);

Cheers,
g.

>
> --
> Anton Vorontsov
> email: cbou@mail.ru
> backup email: ya-cbou@yandex.ru
> irc://irc.freenode.net/bd2
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
