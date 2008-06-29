Return-Path: <khali@linux-fr.org>
Date: Sun, 29 Jun 2008 09:17:25 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [i2c] [PATCH] Convert i2c-mpc from a platform driver to an
	of_platform one
Message-ID: <20080629091725.291974e9@hyperion.delvare>
In-Reply-To: <20080629065812.GO13876@secretlab.ca>
References: <9e4733910806101940o7f2f9863jb5e556ee2fc39a7e@mail.gmail.com>
	<20080625155825.43d07d20@hyperion.delvare>
	<9e4733910806281905l61714e33h8b26870e2c93539e@mail.gmail.com>
	<20080629044940.GC13658@secretlab.ca>
	<20080629083143.7f39b3c1@hyperion.delvare>
	<20080629065812.GO13876@secretlab.ca>
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

On Sun, 29 Jun 2008 00:58:12 -0600, Grant Likely wrote:
> On Sun, Jun 29, 2008 at 08:31:43AM +0200, Jean Delvare wrote:
> > Hi Jon, Grant,
> > 
> > On Sat, 28 Jun 2008 22:49:40 -0600, Grant Likely wrote:
> > > On Sat, Jun 28, 2008 at 10:05:28PM -0400, Jon Smirl wrote:
> > > > >
> > > > > The driver was previously using i2c_add_numbered_adapter(), giving MPC
> > > > >  platform the possibility to use new-style i2c drivers:
> > > > >  http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1469fa263870acd890a4b9f6ef557acc5d673b44
> > > > >  You're breaking this, I doubt it's on purpose?
> > > > 
> > > > Grant, what do you want here? You're the one who converted it to
> > > > i2c_add_numbered_adapter. But in other posts you've said that the
> > > > device tree should have nothing to do with bus numbering.
> > > 
> > > Yes, I did make that change, but that was when it was a platform bus
> > > driver.  Converting it to an of_platform bus driver entirely changes the
> > > situation and it should go back to using i2c_add_adapter() with a parse
> > > of the device tree for child nodes.
> > 
> > I am surprised and disappointed, as this sounds like a regression.
> > Registering the i2c buses with random numbers and parsing the device
> > tree later to figure out which devices are where, is what everybody was
> > doing before the new i2c device/driver matching model was implemented,
> > because there was no other way. I'm curious why you are going back to
> > this approach when i2c-core now offers something way cleaner and more
> > efficient.
> 
> Ah, but the whole random number parsing thing is no longer necessary
> because we ensure that registration of i2c devices always occurs
> after the i2c adapter is created (for device tree aware i2c adapter
> drivers.  adapters that aren't device tree aware still need to assign a
> number).
> 
> After the i2c adapter registers itself, of_register_i2c_devices() is called
> which walks through the child nodes of the i2c adapter node in the device
> tree.  Each child node is an i2c device, and it immediately get
> registered with the adapter.  Because this ensures that i2c device
> registration always happens after adapter registration, and since the
> pointer to the i2c_adapter is known, then i2c_new_device() can be used
> directly without ever needing to know the bus number.

Ah, OK. If you use i2c_new_device() then it's alright.

-- 
Jean Delvare
