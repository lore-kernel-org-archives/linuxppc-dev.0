Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id C05A0DDE0A
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 01:15:36 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: "Dale Farnsworth" <dale@farnsworth.org>
Subject: Re: [PATCH 7/13] powerpc: Add arch/powerpc mv64x60 MPSC platform data
	setup
Date: Thu, 26 Apr 2007 17:14:59 +0200
References: <20070425234630.GA4046@mag.az.mvista.com>
	<200704261324.20226.arnd@arndb.de>
	<20070426143001.GC29241@xyzzy.farnsworth.org>
In-Reply-To: <20070426143001.GC29241@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704261714.59509.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 26 April 2007, Dale Farnsworth wrote:
> On Thu, Apr 26, 2007 at 01:24:19PM +0200, Arnd Bergmann wrote:
> > On Thursday 26 April 2007, Dale Farnsworth wrote:
> > > > This looks wrong to me. See drivers/serial/of_serial.c to find how we do it for
> > > > 8250 compatible serial ports. You should probably just add your serial port
> > > > stuff in there as well, instead of doing your own scanning of the device tree.
> > > 
> > > Unfortunately, this hardware is very much non-8250 compatible.
> > 
> > That shouldn't matter much. The driver is not 8250 specific by itself,
> > it's just that right now it doesn't know about any other chips.
> 
> Hmm, I wouldn't call that a driver, I'd call it OF interface
> glue used to register the driver. 

I mean driver in the sense that it registers a struct device_driver, not
that it does anything particularly interesting with the hardware

> I guess I could put the 
> platform_device_register call for the mpsc driver in that file.
> But I think that will increase, rather than reduce complexity.

Right, I wasn't thinking of that. Instead I meant you should call the
mpsc_drv_probe() function (or some variation of that) directly from
of_platform_serial_probe(), the way that I call serial8250_register_port.

> > > > > +???????????pdev = platform_device_register_simple(MPSC_CTLR_NAME, i, r, 5);
> > > > > +???????????if (IS_ERR(pdev)) {
> > > > > +???????????????????err = PTR_ERR(pdev);
> > > > > +???????????????????goto ret_node_put;
> > > > > +???????????}
> 
> Can you coerce your mailer to stop munging tabs?

sorry about that, it always happens when I copy something over from my vim.

> > Ok, I see where some of the limitations come from. However, instead of
> > introducing the new "sdma" and "brg" properties, why not just add the
> > register ranges to the "reg" property, like other drivers do?
> 
> The sdma and brg are not simply properties of the serial device, these
> nodes represent hardware modules that may be shared by multiple drivers.

Ok, this looks like a mess that is rather hard to clean up and now might
not be the time to start working on that. If these are shared by multiple
high-level drivers, it sounds like there ought to be a driver for each of
them that also does the necessary locking to serialize register accesses.

	Arnd <><
