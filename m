Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id 5F733DDF24
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 00:30:03 +1000 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Thu, 26 Apr 2007 07:30:01 -0700
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/13] powerpc: Add arch/powerpc mv64x60 MPSC platform data
	setup
Message-ID: <20070426143001.GC29241@xyzzy.farnsworth.org>
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704260214.08329.arnd@arndb.de>
	<20070426055716.GB2030@xyzzy.farnsworth.org>
	<200704261324.20226.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200704261324.20226.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 26, 2007 at 01:24:19PM +0200, Arnd Bergmann wrote:
> On Thursday 26 April 2007, Dale Farnsworth wrote:
> > > This looks wrong to me. See drivers/serial/of_serial.c to find how we do it for
> > > 8250 compatible serial ports. You should probably just add your serial port
> > > stuff in there as well, instead of doing your own scanning of the device tree.
> > 
> > Unfortunately, this hardware is very much non-8250 compatible.
> 
> That shouldn't matter much. The driver is not 8250 specific by itself,
> it's just that right now it doesn't know about any other chips.

Hmm, I wouldn't call that a driver, I'd call it OF interface
glue used to register the driver.  I guess I could put the
platform_device_register call for the mpsc driver in that file.
But I think that will increase, rather than reduce complexity.

> 
> If you find that there is more code that needs to be added than what is already
> in there, you could also create a new one based on of_serial for your port.
> 
> I can understand why you want to keep using the platform_device here, and in the
> other places, but if you do then please use platform_device_register from an
> of_platform_driver probe function instead of platform_device_register_simple
> so you can set the parent to the of_device.
> 
> > > > +???????????pdev = platform_device_register_simple(MPSC_CTLR_NAME, i, r, 5);
> > > > +???????????if (IS_ERR(pdev)) {
> > > > +???????????????????err = PTR_ERR(pdev);
> > > > +???????????????????goto ret_node_put;
> > > > +???????????}

Can you coerce your mailer to stop munging tabs?

> > > Now this really needs some explanation.
> > > 
> > > Why the heck do you have a platform device that gets its resources from
> > > nonstandard properties of a serial port?
> > 
> > There is an existing mpsc driver usable on both MIPS and powerpc platforms
> > that requires these non-standard properties.
> 
> Ok, I see where some of the limitations come from. However, instead of
> introducing the new "sdma" and "brg" properties, why not just add the
> register ranges to the "reg" property, like other drivers do?

The sdma and brg are not simply properties of the serial device, these
nodes represent hardware modules that may be shared by multiple drivers.

-Dale
