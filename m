Return-Path: <cbouatmailru@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 09C77DDE4A
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 04:21:38 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id q7so826960uge.0
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jan 2008 09:21:36 -0800 (PST)
Date: Sun, 27 Jan 2008 19:08:18 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH 3/3] [POWERPC] QE: implement GPIO LIB API
Message-ID: <20080127160818.GA25859@zarina>
References: <20080108184341.GA29753@localhost.localdomain>
	<20080108184525.GC18445@localhost.localdomain>
	<479C8A34.2000701@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <479C8A34.2000701@scram.de>
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

On Sun, Jan 27, 2008 at 02:42:12PM +0100, Jochen Friedrich wrote:
> Hi Anton,
> 
> > +static void qe_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
> > +{
> > +	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
> > +	struct port_regs *regs = mm_gc->regs;
> > +	u32 pin_mask;
> > +	u32 tmp_val;
> > +
> > +	/* calculate pin location */
> > +	pin_mask = (u32) (1 << (NUM_OF_PINS - 1 - gpio));
> > +
> > +	tmp_val = in_be32(&regs->cpdata);
> > +
> > +	if (val == 0)
> > +		out_be32(&regs->cpdata, ~pin_mask & tmp_val);
> > +	else
> > +		out_be32(&regs->cpdata, pin_mask | tmp_val);
> > +}
> 
> I see a possible problem with this (and in the corresponding call in CPM1, as well):
> 
> if there is a pin configured as open drain, you might accidently switch this pin to 0
> while switching a different pin, if an external device is pulling the pin to 0.

Unfortunately I can't think out any workaround for this, except
implementing generic gpio_bank_{,un}lock(gpio_pin_on_the_bank), and
start using it in the drivers that might care about this issue. Though,
looking into i2c-gpio.c I don't clearly see were we can insert these
locks, there should be "start/end transaction" handlers or something,
but it seems that it's in the bitbanging code, not in the i2c-gpio
driver..

Actually, I see this as a hardware limitation. For example, on ARMs
PXA2xx, there are separate, per bank, read/set/clear GPIO registers,
not all-in-one data register.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
