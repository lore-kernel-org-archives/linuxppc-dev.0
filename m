Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net
	[151.189.21.51])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 03385DDF4E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 16:16:20 +1000 (EST)
In-Reply-To: <20070619054232.GB32039@localhost.localdomain>
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <69de6646562b9fb3432909afff57a962@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Date: Tue, 19 Jun 2007 08:16:09 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: ppcdev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>   	interrupt-controller {
>> 		device_type = "interrupt-controller";
>> 		compatible = "chrp,iic";
>
> Is there a device binding defined somewhere for "chrp,iic"?

In the CHRP platform binding, which doesn't apply here.

>> 		keyboard {
>> 			device_type = "keyboard";
>> 			compatible = "pnpPNP,303";
>> 			reg = <0>;
>> 		};
>
>> 		mouse {
>> 			device_type = "mouse";
>> 			compatible = "pnpPNP,f03";
>> 			reg = <1>;
>> 		};
>> 	};
>
>> 	timer@40 {
>> 		device_type = "timer";
>
> For flat device trees we're generally avoiding setting the device_type
> property unless there is a clearly defined "class binding" which
> applies.  There are a number of cases here where I'm not sure if
> that's true.

Keyboard and mouse have defined "device_type"s.  Timer I
don't think so.

Either way, I'd leave out the device_type here, the OS
isn't supposed to use it anyway.

>> 	serial@3f8 {
>> 		device_type = "serial";
>> /*		compatible = "pnpPNP,501";*/
>> 		compatible = "ns16550";
>> 		reg = <3f8 8>;
>> 		interrupts = <4 3>;			// IRQ4 (rising edge)
>> 		interrupt-parent = <&interrupt-controller>;
>> 		clock-frequency = <0>;			// Not necessary?
>
> Probably necessary, but may need to be filled in from the bootwrapper.

If absent, "clock-frequency" should be taken to be the
default thing.  Actually, for pnpPNP (PC-style) serial,
the clock frequency is fixed.

>>   	pci@80000000 {
>> 		device_type = "pci";
>> 		bus-frequency = <01fca055>;		// 33.3MHz

So write it in decimal...


Segher
