Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.169])
	by ozlabs.org (Postfix) with ESMTP id 3B47ADDD0C
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 08:41:49 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so861027uge.0
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 13:41:48 -0800 (PST)
Date: Mon, 28 Jan 2008 00:23:38 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] [POWERPC] QE: implement GPIO LIB API
Message-ID: <20080127212338.GA14084@zarina>
References: <20080108184341.GA29753@localhost.localdomain>
	<20080108184525.GC18445@localhost.localdomain>
	<479C8A34.2000701@scram.de> <20080127160818.GA25859@zarina>
	<fa686aa40801271259k5fd3340bg1b7f29da774be85b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40801271259k5fd3340bg1b7f29da774be85b@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	David Gibson <david@gibson.dropbear.id.au>
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 27, 2008 at 01:59:51PM -0700, Grant Likely wrote:
a> On 1/27/08, Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> > On Sun, Jan 27, 2008 at 02:42:12PM +0100, Jochen Friedrich wrote:
> > > Hi Anton,
> > >
> > > > +static void qe_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> > > > +{
> > > > +   struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> > > > +   struct port_regs *regs = mm_gc->regs;
> > > > +   u32 pin_mask;
> > > > +   u32 tmp_val;
> > > > +
> > > > +   /* calculate pin location */
> > > > +   pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - gpio));
> > > > +
> > > > +   tmp_val = in_be32(&regs->cpdata);
> > > > +
> > > > +   if (val == 0)
> > > > +           out_be32(&regs->cpdata, ~pin_mask & tmp_val);
> > > > +   else
> > > > +           out_be32(&regs->cpdata, pin_mask | tmp_val);
> > > > +}
> > >
> > > I see a possible problem with this (and in the corresponding call in CPM1, as well):
> > >
> > > if there is a pin configured as open drain, you might accidently switch this pin to 0
> > > while switching a different pin, if an external device is pulling the pin to 0.
> >
> > Unfortunately I can't think out any workaround for this, except
> > implementing generic gpio_bank_{,un}lock(gpio_pin_on_the_bank), and
> > start using it in the drivers that might care about this issue. Though,
> > looking into i2c-gpio.c I don't clearly see were we can insert these
> > locks, there should be "start/end transaction" handlers or something,
> > but it seems that it's in the bitbanging code, not in the i2c-gpio
> > driver..
> >
> > Actually, I see this as a hardware limitation. For example, on ARMs
> > PXA2xx, there are separate, per bank, read/set/clear GPIO registers,
> > not all-in-one data register.
> 
> I've run into this exact issue on other GPIO hardware too.  It's not
> uncommon behaviour in GPIO hardware.
> 
> The solution is to not depend on the hardware to remember what the
> output pin values should be.  Add a shadow register in the driver
> private data.  Set the pin state for each output pin in the shadow
> register and then write that value to the hardware.  That way input
> state doesn't interfere with the output values.

Great idea, much thanks. Would be easy to implement also.

> Also, you do still need spinlocks around the manipulation of the
> shared registers; otherwise you'll have very hard to debug race
> conditions.  Probably one spin lock per bank.

With GPIO LIB we already have per bank spinlock, so it isn't
a problem.


Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
