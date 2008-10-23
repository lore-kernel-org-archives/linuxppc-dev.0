Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 03132DDE08
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Oct 2008 10:05:20 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so228385qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 16:05:18 -0700 (PDT)
Message-ID: <4901032F.3090805@genesi-usa.com>
Date: Thu, 23 Oct 2008 18:05:19 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
In-Reply-To: <4900F90B.80703@firmworks.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Mitch Bradley wrote:
[snip]

> You could adopt the convention that preassigned GPIOs must be 
> represented by subordinate nodes, and any GPIO that is not covered by a 
> subordinate node's "reg" property is implicitly available.  That's the 
> way it works for other address spaces.

I like that idea except for the implicitly available bit.

Just summarizing this in my head (also on the list), if we had 
an "available" property in the node marked as a 
gpio-controller, that would easily give gpiolib something to 
parse so that it only gives out allocations for pins that are 
really, really not being multiplexed for something else or 
just not being connected.

There's a GPIO spec in booting-without-of.txt which basically 
defines a controller and a bank, and you can assign a bank of 
GPIO to some other device. Assigning specific GPIO pins should 
be possible.. umm..

http://patchwork.ozlabs.org/patch/5478/

With regards to this patch, how about device usage of pins 
being defined as a range of pins (reusing the standard-ish 
"ranges" property from PCI binding)? That way you have all the 
information you could ever need for each device.

1) where the controller sits ("gpio-controller" property)

2) which pins are available for use (everything not in 
"available" is therefore out of bounds)

3) define banks of gpio for a specific function with "ranges" 
(for instance pins 10, 11 and 15 would be encoded as <10 2> 
and <15 1> and these encapsulate some kind of function be it 
user definable gpio or some control function for a chip)

4) assign "gpio" properties to other nodes which refer to 
banks (see booting-without-of.txt section IX, at the end) 
rather than individual pins.

5) optionally a bank may contain gpio pin node which describes 
EXACTLY what that pin function is (and any lovely properties 
it may well have).

At the moment it's encoded as:

	gpios = <&controller-phandle pin-number pin-flags>

Ad infinitum. Instead of a controller phandle you'd pass in a 
bank (which is a subset of the controller's available pins) 
and then you can give each pin it's little options.

Actually I would also advocate allowing each pin to be 
assigned a node of it's own and a compatible property - after 
all if you have a board where gpios can move around (consider 
an FPGA with a processor core, where positions of lines to use 
are actually reflected by a read-only register or the device 
tree is derived directly from the VHDL source or a constraints 
script?) and don't want to rewrite your driver every time, it 
would be good to be able to find exactly which pin controls 
exactly which line on the peripheral chip?

Therefore you'd get something like this in a DTS; please hit 
me on the head if you think it's getting really unwieldy :D

gpio_1: gpio-controller@1000 {
	#gpio-cells = <2>;
	compatible = "fsl,mpc5200b-gpio";
	reg = <0x1000 0x4>;
	gpio-controller;
	available = <1 10 15 4 30 1>;

	gpio_1_bank_1: gpio-bank {
		\\ 5 pins for some nefarious purpose
		compatible = "gpio-bank";
		ranges = <1 5 0>; \\ start length flags

		gpio_pin@2 {
\\ I guess this address has to be
\\ the global offset and not the offset into the range to make
\\ it easier?
			reg = <2 1>
			compatible = "magic";
		};
	};
}

device@9000 {
	compatible = "somedevice";
	reg = <0x9000 0x18>;
	gpios = <&gpio_1_bank_1>
};

Most implementations won't need the explicit pin definitions 
but it would probably come in handy somewhere if you were 
bitbanging some protocol (SPI, I2C or so) or driving a device 
where you could change this stuff, or even dynamically work 
out if a connector was inserted a certain way (I'm thinking of 
maybe an expansion connector which can run line-reversed like 
PCI Express.. but made out of GPIO. Am I nuts?)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
