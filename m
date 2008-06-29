Return-Path: <khali@linux-fr.org>
Date: Sun, 29 Jun 2008 08:31:43 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [i2c] [PATCH] Convert i2c-mpc from a platform driver to an
	of_platform one
Message-ID: <20080629083143.7f39b3c1@hyperion.delvare>
In-Reply-To: <20080629044940.GC13658@secretlab.ca>
References: <9e4733910806101940o7f2f9863jb5e556ee2fc39a7e@mail.gmail.com>
	<20080625155825.43d07d20@hyperion.delvare>
	<9e4733910806281905l61714e33h8b26870e2c93539e@mail.gmail.com>
	<20080629044940.GC13658@secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Wolfram Sang <w.sang@pengutronix.de>, David Brownell <david-b@pacbell.net>,
	linuxppc-dev list <Linuxppc-dev@ozlabs.org>, Linux,
	Timur Tabi <timur@freescale.com>, I2C <i2c@lm-sensors.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jon, Grant,

On Sat, 28 Jun 2008 22:49:40 -0600, Grant Likely wrote:
> On Sat, Jun 28, 2008 at 10:05:28PM -0400, Jon Smirl wrote:
> > On 6/25/08, Jean Delvare <khali@linux-fr.org> wrote:
> > >  >
> > >  >       i2c->adap = mpc_ops;
> > >  > -     i2c->adap.nr = pdev->id;
> > >  >       i2c_set_adapdata(&i2c->adap, i2c);
> > >  > -     i2c->adap.dev.parent = &pdev->dev;
> > >  > -     if ((result = i2c_add_numbered_adapter(&i2c->adap)) < 0) {
> > >  > +     i2c->adap.dev.parent = &op->dev;
> > >  > +
> > >  > +     result = i2c_add_adapter(&i2c->adap);
> > >
> > >
> > > The driver was previously using i2c_add_numbered_adapter(), giving MPC
> > >  platform the possibility to use new-style i2c drivers:
> > >  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1469fa263870acd890a4b9f6ef557acc5d673b44
> > >  You're breaking this, I doubt it's on purpose?
> > 
> > Grant, what do you want here? You're the one who converted it to
> > i2c_add_numbered_adapter. But in other posts you've said that the
> > device tree should have nothing to do with bus numbering.
> 
> Yes, I did make that change, but that was when it was a platform bus
> driver.  Converting it to an of_platform bus driver entirely changes the
> situation and it should go back to using i2c_add_adapter() with a parse
> of the device tree for child nodes.

I am surprised and disappointed, as this sounds like a regression.
Registering the i2c buses with random numbers and parsing the device
tree later to figure out which devices are where, is what everybody was
doing before the new i2c device/driver matching model was implemented,
because there was no other way. I'm curious why you are going back to
this approach when i2c-core now offers something way cleaner and more
efficient.

But well, you'll know better. I'm not familiar with the platform, and
don't have the time to look into it anyway.

> > Once this driver is converted to an OF one it shouldn't need bus ids
> > since all of the i2c devices will be children of the bus node. We can
> > just let the i2c subsystem assign a bus number.
> 
> Exactly.
> 
> > Timur has some issues with the i2c bus number in his ALSA driver. The
> > problem is locating the i2c device when the i2s driver loads. Parsing
> > the device tree to extract an i2c bus and device number is not a good
> > solution.
> 
> The trick here is to store the pointer to the device node inside the
> i2c device.  I do this with SPI devices like this:
> 
> 	/* Store a pointer to the node in the device structure */
> 	of_node_get(nc);
> 	spi->dev.archdata.of_node = nc;
> 
> Then, when you've got a device_node pointer, you can parse through the
> set of registered SPI devices and match against the one that has the
> same device node pointer.
> 
> > codec-handle should give you the i2c device node. But then we can't
> > use of_find_device_by_node because the i2c device is not an of_device,
> > it's a cross platform i2c_device. Should of_find_device_by_node()
> > return a 'struct device' instead of a 'struct of_device' and leave it
> > as a user exercise to cast up? It is used nine times in the kernel,
> > mostly sparc.
> 
> No, this doesn't work because I2C and SPI devices are not of_platform
> devices.  They aren't even platform devices.  of_find_device_by_node()
> only works for the of_platform bus.
> 
> Using archdata.of_node is part of the device structure and works for
> every bus type (platform, of_platform, SPI, I2C, PCI, etc.)

-- 
Jean Delvare
