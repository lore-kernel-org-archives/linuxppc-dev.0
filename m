Return-Path: <andre.schwarz@matrix-vision.de>
Received: from mail1.matrix-vision.com (mail1.matrix-vision.com [78.47.19.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "localhost", Issuer "localhost" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 0C7E4B6EFE
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Sep 2010 04:14:52 +1000 (EST)
Subject: Re: How to define an I2C-to-SPI bridge device ?
From: =?ISO-8859-1?Q?Andr=E9?= Schwarz <andre.schwarz@matrix-vision.de>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20100910173706.GD11284@angua.secretlab.ca>
References: <1283502979.17812.22.camel@swa-m460>
	<20100903120858.GA19380@oksana.dev.rtsoft.ru>
	<4C84D334.6060008@matrix-vision.de>
	<c843f864-2a5a-4146-bd95-13c2fb91f430@email.android.com>
	<1284106293.2267.42.camel@swa-m460>
	<20100910173706.GD11284@angua.secretlab.ca>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 10 Sep 2010 20:14:44 +0200
Message-ID: <1284142484.2152.18.camel@swa-e6500>
Mime-Version: 1.0
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

Grant,

[snip]
> > 
> > 1.
> > The SC18IS602 is capable of generating interrupts which is *extremely*
> > useful triggering on the end of the actual SPI transaction and not the
> > end of I2C chip access. Since we need an IRQ_ACK over I2C (which takes
> > loooong with IRQ being still asserted) I'm thinking about using an edge
> > triggered interrupt.
> > Since all transactions are in-order there's no risk of missing multiple
> > edges ... what do you think about this ? Any known issues with edge
> > triggered IRQs ?
> 
> Does the device actually generate edge interrupts?  Or is it a level
> irq device?  If it is a level irq device, then the correct way to
> handle this is to disable the irq line so that the event can be
> handled at non-irq context, and then reenable it when finished.

The irq is level-low active.
Will do it via disable/re-enable then.

> 
> > 2.
> > chips select generations is a little tricky.
> > The device has up to four cs# lines with their assertion being encoded
> > as subaddr representing a bitfield, i.e. Subaddr 0x01 generates cs0,
> > 0x04 asserts cs3 and 0x07 asserts cs0-2.
> 
> I'm really not sure what is tricky about this.  The spi layer handles
> multiple CS lines on a single bus just fine.

huh - ok ... didn't know that, sorry.

> 
> To start, how the CS lines are manipulated is only a hardware
> implementation detail.  The driver can and should do the work of
> translate Linux CS line numbers into the format/bitfield expected by
> the hardware.  Other drivers do the same thing.

ok - will do it.

> 
> > At first I thought about registering 4 SPI busses representing the 4 cs#
> > lines and hide the cs# generation from the user. This would make
> > multiple cs# assertions for a single write impossible which is a very
> > useful feature.
> 
> The SPI subsystem doesn't directly support this use-case.  If you want
> to do this, then assign another chip select number for the purpose of
> enabling multiple CS lines at once... and be careful which drivers you
> allow to be bound to the oddball CS number.  The in-kernel drivers
> certainly don't support this use-case, and care must be taken to
> ensure only one device is writing to the input line at a time.
> 
> What specific hardware do you need this feature for?

We have a board with multiple parallel video transmitters connected to
an FPGA. Video timing and general parameters are always the same and
there are quite a lot of settings to write during init/mode change.

Doing this in parallel will speed things up significantly.

Of course this is a write-only scenario, i.e. no combined reads.

> 
> > Exposing the desired cs# setting for the next transaction via sysfs or
> > libGPIO requires the user to serialize cs# config and actual SPI
> > read/write. I also wouldn't know how to properly present the cs# lines
> > from multiple chips to the user in a clear and unambiguous way.
> 
> Exposing via sysfs or discrete GPIO manipulations is completely the
> wrong thing to do.

Thanks for pointing this out.


BTW: would "drivers/misc" be a proper location ?
Who's supposed to pick that driver up and on what list shall I post it
for review ?


Will try to get more spi knowledge before moving on and asking stupid
questions. Thanks for your help so far.


Regards,
André



MATRIX VISION GmbH, Talstrasse 16, DE-71570 Oppenweiler
Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschaeftsfuehrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
