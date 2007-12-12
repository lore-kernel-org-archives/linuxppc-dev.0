Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B0C33DDE38
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 23:44:28 +1100 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id C507E8815
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Dec 2007 17:44:25 +0400 (SAMT)
Date: Wed, 12 Dec 2007 15:47:32 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
Message-ID: <20071212124732.GA3904@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210230453.GB5495@localhost.localdomain>
	<20071210231052.GB1141@zarina>
	<20071211003647.GB12363@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071211003647.GB12363@localhost.localdomain>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 11, 2007 at 11:36:47AM +1100, David Gibson wrote:
[...]
> > > > OF device tree GPIOs bindings are similar to IRQs:
> > > > 
> > > > node {
> > > > 	gpios = <bank pin bank pin bank pin>;
> > > > 	gpio-parent = <&par_io_controller>;
> > > > };
> > > > 
> > > > "bank pin" scheme is controller specific, so controllers that want
> > > > to implement flat mappings or any other could do so.
> > > 
> > > It might be safest to do as is done for interrupts, and not define the
> > > internal format at all.
> > 
> > This is how it is done already. Take a look into second and third patches:
> > 
> > +static int par_io_xlate(struct device_node *np, int index)
> > +{
> > +       return __of_parse_gpio_bank_pin(np, index, 32, num_par_io_ports);
> > +}
> > +
> > +static struct of_gpio_chip of_gpio_chip = {
> > +       .xlate = par_io_xlate,
> > +};
> > 
> > __of_parse_gpio_bank_pin() is helper function, I just factored
> > it out, because both QE and CPM2 using same format.
> > 
> > But generally, controllers are encouraged to do their own xlates.
> > 
> > Or am I missing the point?
> 
> Right, but you are assuming a fixed size (2 cells?)

Nope, of_get_gpio() doesn't assume that, but per-controller's .xlate()
is free to assume (and check) that, right.

> for the bank/pin
> information, arent' you - I didn't see any #gpio-cells or similar
> looking property.

Well, per-controller .xlate() is checking for correct cell count
(just reminding -- __of_parse_gpio_bank_pin is helper function,
controllers are free to implement their own):

int __of_parse_gpio_bank_pin(struct device_node *np, int index,
                             int bank_width, int max_bank)
{
...
        gpios = of_get_property(np, "gpios", &len);
        len /= sizeof(u32);

        if (len < 2 || len % 2 || index > len / 2 - 1)
                return -EINVAL;
...
}

On the other hand, I might indeed introduce #gpio-cells, and move
that check into generic of_get_gpio(), which will use #gpio-cells.
I think this is good idea anyway, so I'll just do it. ;-)

> I'm wondering if some gpio controllers might want
> less (only one bank) or more (bank, pin, polarity/flags perhaps).

Yup, they might. With #gpio-cells or without. The matter of where
to place sanity checks.


Much thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
