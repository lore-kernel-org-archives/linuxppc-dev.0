Return-Path: <dgibson@ozlabs.org>
Date: Sun, 23 Dec 2007 14:40:46 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] [POWERPC] Implement GPIO API embryo
Message-ID: <20071223034046.GC10699@localhost.localdomain>
References: <20071221202824.GA4607@localhost.localdomain>
	<20071221203115.GA4633@localhost.localdomain>
	<b632798b4f5523653160b6a7156266e1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <b632798b4f5523653160b6a7156266e1@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Dec 23, 2007 at 03:49:30AM +0100, Segher Boessenkool wrote:
> > +int __of_parse_gpio_bank_pin(struct device_node *np, int index,
> > +			     int bank_width, int max_bank)
> > +{
> > +	int bank;
> > +	int pin;
> > +	const u32 *gpios;
> > +
> > +	/*
> > +	 * We can get there only if of_get_gpio() succeeded, thus
> > +	 * no need checking for "gpios" existence.
> > +	 */
> > +	gpios = of_get_property(np, "gpios", NULL);
> > +	bank = gpios[index * 2];
> > +	pin = gpios[index * 2 + 1];
> 
> If you stick with the #gpio-cells plan, here is where you should use it.

I think part of what's happening here is due to the patch's history.
The "bank pin" information was always of a format local to the
controller, but originally the size wasn't explicitly stated in the
tree - it was just implicit in the type of gpio controller.  I
suggested that #gpio-cells be added, which it has been, but it looks
like the code hasn't been updated to use it everywhere.  Obviously a
driver for a particular gpio controller would generally need to assert
that the controller's #gpio-cells has the correct value for this
controller type, after which code like the above would be acceptable.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
