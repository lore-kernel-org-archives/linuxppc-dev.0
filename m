Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9C06CDDF70
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 19:15:07 +1000 (EST)
In-Reply-To: <20070619084015.202120@gmx.net>
References: <20070618185715.321010@gmx.net>
	<20070619054232.GB32039@localhost.localdomain>
	<20070619084015.202120@gmx.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <73aafd0955b8ea695af9221b48aaa3f1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Device tree for new desktop platform in arch/powerpc
Date: Tue, 19 Jun 2007 11:14:44 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> 3. The dts files define the device_type of a serial port as
>>> "serial", whereas the OF spec says "pnpPNP,501". What's the
>>> difference between the two?
>>
>> Err... device_type == "pnpPNP,501", or compatible == "pnpPNP,501"?
> Sorry, I meant compatible = "ns16550" and compatible = "pnpPNP,501".

"pnpPNP,501" says that the device is a 16550A-compatible
UART compatible with how that is used in a PC (using the
same base clock, and some other minor things).

"ns16550" simply says the device is compatible with
the NS16550.  Also note the lack of "A".

>> This node has no children, so #address-cells and #size-cells values
>> are meaningless.
> Ah, I thought these properties are always necessary, if a ranges or reg
> property is defined.

They are necessary if one of the children has a "reg" or
"ranges" or similar, or if this node has a "ranges"
property.  "#xxx-cells" defines the number of cells for
the bus that this node is the controller for.  So, for
"reg", the relevant #xxx-cells entry is that in your parent;
for "ranges" you need both the "#address-cells" entry in
your parent and your own #xxx-cells values (since "ranges"
uses parent bus address, child bus address, child bus size).

>>>   	interrupt-controller {
>>> 		device_type = "interrupt-controller";
>>> 		compatible = "chrp,iic";
>>
>> Is there a device binding defined somewhere for "chrp,iic"?
> Dunno. :-) It's based on these document here:
> http://playground.sun.com/1275/bindings/devices/html/isa-pic-1_1d.html
> http://playground.sun.com/1275/bindings/pci/pci2_1.pdf

How does PCI come into the picture here?

>>> 	timer@40 {
>>> 		device_type = "timer";
>>
>> For flat device trees we're generally avoiding setting the device_type
>> property unless there is a clearly defined "class binding" which
>> applies.  There are a number of cases here where I'm not sure if
>> that's true.
> What about platforms that provide a real OF device tree? Do they define
> device nodes for timers?

Sure.  There typically is a device node for every
(addressable) device on the system.  There is no
defined binding for timer devices though, so there
shouldn't be a "device_type" in a timer node.

>>> 		clock-frequency = <0>;			// Not necessary?

Since this is an AT timer, you should use "compatible"
= "pnpPNP,100", and the clock frequency is implicit.

>>> 	fdc@3f0 {

>>> 		disk {
>>> 			device_type = "block";
>>> 			reg = <0>;
>>> 		};
>>>
>> Don't think you need this subnode.
> It's mentioned here (if I interpreted it correctly):
> http://playground.sun.com/1275/bindings/devices/html/fdc.html

"disk" subnodes describe the floppy disk _drives_ actually.
You should have a disk@0 and/or a disk@1, if you have any
floppy disk drives at all that is.

> Not sure, if the Linux kernel needs it.

The linux floppy driver will do its own probing, so no
it won't care.  Can't hurt to include it though.

In real OF these nodes are very necessary of course,
since without device node you cannot use it to read
files from.


Segher
