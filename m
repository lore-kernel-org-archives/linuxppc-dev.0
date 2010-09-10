Return-Path: <glikely@secretlab.ca>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) by ozlabs.org (Postfix) with ESMTP id 1D38DB70FF
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Sep 2010 03:37:10 +1000 (EST)
Received: by pvg16 with SMTP id 16so1546845pvg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Sep 2010 10:37:08 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Fri, 10 Sep 2010 11:37:06 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: =?iso-8859-1?Q?Andr=E9?= Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: How to define an I2C-to-SPI bridge device ?
Message-ID: <20100910173706.GD11284@angua.secretlab.ca>
References: <1283502979.17812.22.camel@swa-m460>
	<20100903120858.GA19380@oksana.dev.rtsoft.ru>
	<4C84D334.6060008@matrix-vision.de>
	<c843f864-2a5a-4146-bd95-13c2fb91f430@email.android.com>
	<1284106293.2267.42.camel@swa-m460>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1284106293.2267.42.camel@swa-m460>
Cc: LinuxPPC List <linuxppc-dev@ozlabs.org>,
	DevTreeDiscuss <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 10, 2010 at 10:11:33AM +0200, André Schwarz wrote:
> Grant, Anton,
> 
> 
> > 
> > There is no longer any need for separate of and non-of drivers for the same hardware.  Any device may have the of_node pointer in struct device set, and drivers can use the pointer as an alternative to platform_data to get information about the hardware configuration.
> 
> > Just read the data out of the node in the driver's probe hook.
> 
> ok - will do it that way.
> 
> > 
> > For i2c and (soon) spi, the core code will even register child devices for you.
> 
> excellent.
> 
> 
> 
> Thinking about this device raises even more questions. Since there are
> several possible solutions I'd like to hear your opinions :
> 
> 1.
> The SC18IS602 is capable of generating interrupts which is *extremely*
> useful triggering on the end of the actual SPI transaction and not the
> end of I2C chip access. Since we need an IRQ_ACK over I2C (which takes
> loooong with IRQ being still asserted) I'm thinking about using an edge
> triggered interrupt.
> Since all transactions are in-order there's no risk of missing multiple
> edges ... what do you think about this ? Any known issues with edge
> triggered IRQs ?

Does the device actually generate edge interrupts?  Or is it a level
irq device?  If it is a level irq device, then the correct way to
handle this is to disable the irq line so that the event can be
handled at non-irq context, and then reenable it when finished.

> 2.
> chips select generations is a little tricky.
> The device has up to four cs# lines with their assertion being encoded
> as subaddr representing a bitfield, i.e. Subaddr 0x01 generates cs0,
> 0x04 asserts cs3 and 0x07 asserts cs0-2.

I'm really not sure what is tricky about this.  The spi layer handles
multiple CS lines on a single bus just fine.

To start, how the CS lines are manipulated is only a hardware
implementation detail.  The driver can and should do the work of
translate Linux CS line numbers into the format/bitfield expected by
the hardware.  Other drivers do the same thing.

> At first I thought about registering 4 SPI busses representing the 4 cs#
> lines and hide the cs# generation from the user. This would make
> multiple cs# assertions for a single write impossible which is a very
> useful feature.

The SPI subsystem doesn't directly support this use-case.  If you want
to do this, then assign another chip select number for the purpose of
enabling multiple CS lines at once... and be careful which drivers you
allow to be bound to the oddball CS number.  The in-kernel drivers
certainly don't support this use-case, and care must be taken to
ensure only one device is writing to the input line at a time.

What specific hardware do you need this feature for?

> Exposing the desired cs# setting for the next transaction via sysfs or
> libGPIO requires the user to serialize cs# config and actual SPI
> read/write. I also wouldn't know how to properly present the cs# lines
> from multiple chips to the user in a clear and unambiguous way.

Exposing via sysfs or discrete GPIO manipulations is completely the
wrong thing to do.

g.
