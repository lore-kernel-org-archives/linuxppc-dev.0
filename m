Return-Path: <dgibson@ozlabs.org>
Date: Sun, 16 Dec 2007 17:44:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH RFC 0/7] "NAND on UPM" and related patches
Message-ID: <20071216064420.GI21311@localhost.localdomain>
References: <20071210204705.GA31263@localhost.localdomain>
	<20071210230453.GB5495@localhost.localdomain>
	<20071210231052.GB1141@zarina>
	<20071211003647.GB12363@localhost.localdomain>
	<20071212124732.GA3904@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071212124732.GA3904@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 12, 2007 at 03:47:32PM +0300, Anton Vorontsov wrote:
> On Tue, Dec 11, 2007 at 11:36:47AM +1100, David Gibson wrote:
> [...]
> > > > > OF device tree GPIOs bindings are similar to IRQs:
> > > > > 
> > > > > node {
> > > > > 	gpios = <bank pin bank pin bank pin>;
> > > > > 	gpio-parent = <&par_io_controller>;
> > > > > };
> > > > > 
> > > > > "bank pin" scheme is controller specific, so controllers that want
> > > > > to implement flat mappings or any other could do so.
> > > > 
> > > > It might be safest to do as is done for interrupts, and not define the
> > > > internal format at all.
> > > 
> > > This is how it is done already. Take a look into second and third patches:
> > > 
> > > +static int par_io_xlate(struct device_node *np, int index)
> > > +{
> > > +       return __of_parse_gpio_bank_pin(np, index, 32, num_par_io_ports);
> > > +}
> > > +
> > > +static struct of_gpio_chip of_gpio_chip = {
> > > +       .xlate = par_io_xlate,
> > > +};
> > > 
> > > __of_parse_gpio_bank_pin() is helper function, I just factored
> > > it out, because both QE and CPM2 using same format.
> > > 
> > > But generally, controllers are encouraged to do their own xlates.
> > > 
> > > Or am I missing the point?
> > 
> > Right, but you are assuming a fixed size (2 cells?)
> 
> Nope, of_get_gpio() doesn't assume that, but per-controller's .xlate()
> is free to assume (and check) that, right.

Ah, ok, I see.  I think doing this without an explicit '#gpio-cells'
is not a great idea, though.  It would be nice to be able to sanity
check the "gpio descriptors" without having to deduce the correct
format from the controller's "compatible" property.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
