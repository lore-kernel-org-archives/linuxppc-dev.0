Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1A70DDF70
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 00:24:31 +1000 (EST)
In-Reply-To: <1182429406.24740.6.camel@localhost.localdomain>
References: <20070618185715.321010@gmx.net>
	<1182429406.24740.6.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e3de5208ef08748bb23d2b19cb040e04@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Date: Thu, 21 Jun 2007 16:24:17 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> 3. The dts files define the device_type of a serial port as "serial",
>> whereas the OF spec says "pnpPNP,501". What's the difference between
>> the two?
>
> Use the pnp stuff for "compatible", you can mostly ignore device_type 
> or
> set it to the same as name.

Only if the name is indeed the correct, defined, device_type
for that device, and you implement the whole binding for that
device_type (I recommend you do, for serial; it makes it
easier to use that device as an early console).

>> 4. I couldn't find any information for a device tree representation of
>> the i8259 interrupt controller in the booting-without-of.txt file. Is
>> my implementation correct (inspired by the OF documents)?
>
> Haven't looked at your .dts yet but it should be 
> "interrupt-controller",
> compatible "chrp,iic" or "i8259", with a #interrupt-cells of 2 and
> interrupts following the standard ISA encoding. You probably also want
> an interrupt-parent property in the isa bridge node pointing back to 
> the
> 8259 so it becomes the default for all ISA devices.

Yeah.  You can also use the "pnpPNP," name for the 8259 if
it is hooked up like on a PC.

>> I would be grateful, if you could take a look at my dts file and
>> comment on every line that doesn't meet your views.

Please send a new .dts based on the comments you've had so far?


Segher
