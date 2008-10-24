Return-Path: <wmb@firmworks.com>
Message-ID: <49011C42.2020101@firmworks.com>
Date: Thu, 23 Oct 2008 14:52:18 -1000
From: Mitch Bradley <wmb@firmworks.com>
MIME-Version: 1.0
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
References: <4900ED81.3040202@genesi-usa.com> <4900F90B.80703@firmworks.com>
	<4901032F.3090805@genesi-usa.com>
In-Reply-To: <4901032F.3090805@genesi-usa.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

>
>
> Mitch Bradley wrote:
> [snip]
>
>> You could adopt the convention that preassigned GPIOs must be 
>> represented by subordinate nodes, and any GPIO that is not covered by 
>> a subordinate node's "reg" property is implicitly available.  That's 
>> the way it works for other address spaces.
>
> I like that idea except for the implicitly available bit.
>
> Just summarizing this in my head (also on the list), if we had an 
> "available" property in the node marked as a gpio-controller, that 
> would easily give gpiolib something to parse so that it only gives out 
> allocations for pins that are really, really not being multiplexed for 
> something else or just not being connected.
>
> There's a GPIO spec in booting-without-of.txt which basically defines 
> a controller and a bank, and you can assign a bank of GPIO to some 
> other device. Assigning specific GPIO pins should be possible.. umm..
>
> http://patchwork.ozlabs.org/patch/5478/
>
> With regards to this patch, how about device usage of pins being 
> defined as a range of pins (reusing the standard-ish "ranges" property 
> from PCI binding)?


Okay, so it looks to me like your "bank" concept is sort of akin to a 
"gpio-to-gpio bridge", with analogy to a pci-to-pci bridge.  Following 
that model, the "name" of your "gpio-bank" would instead be 
"gpio-controller", because its children are GPIO pin nodes that could 
just as well be attached directly to the top-level gpio-controller 
node.  The "compatible" property would be different, reflecting the fact 
that it is a "gpio-to-gpio bridge" instead of an "io-to-gpio bridge" 
(for example).

"ranges" is fully standard.  Its specification is tight enough to permit 
generic address-translation code to walk up a tree and work out how to 
translate addresses through multiple levels, even in the face of 
different address representations at the various levels.  (But the 
chained address spaces must be of the same general flavor, such as 
memory mapped spaces translated through PCI nodes.)  Each "ranges" entry 
defines a subrange of the child address space and the corresponding 
subrange of the parent address space.

So to use "ranges" in the context of "gpio-to-gpio bridge" node, the 
value would be a list of each entries each containing <child-start-pin# 
parent-start-pin# size>.  You could choose whether or not to offset the 
child and parent pin numbers.  If you wrote  <0 5 2>, that would mean 
that child pins 0 and 1 would actually be parent pins 5 and 6 - the 
child "reg" property would have to say, e.g. <0 2>.   If you wrote <5 5 
2>, that would mean no offsetting from child to parent; the child "reg" 
would be <5 2>.  Generic "ranges" handling code wouldn't care.

That said, I'm not sure that the intermediate level ("banks" or "g2g 
bridge", whatever you want to call it) is worth the effort.  There is a 
very good reason for pci-to-pci bridge nodes - they exist in hardware 
and impose a translation on the configuration addresses.  The "g2g" 
intermediate nodes might make it slightly easier to move around chunks 
of GPIO pins, but I'm not sure that it's really that much easier, 
compared to just changing the values in the "reg" property of the 
child.  If a child function requires a group of related GPIO pins, you 
can list all the pins in its reg property, ordered according to their  
purposes.  For example, the first reg entry might be for the "SCL" pin 
and the second for the "SDA" pin.

> That way you have all the information you could ever need for each 
> device.
>
> 1) where the controller sits ("gpio-controller" property)
>
> 2) which pins are available for use (everything not in "available" is 
> therefore out of bounds)
>
> 3) define banks of gpio for a specific function with "ranges" (for 
> instance pins 10, 11 and 15 would be encoded as <10 2> and <15 1> and 
> these encapsulate some kind of function be it user definable gpio or 
> some control function for a chip)

As argued above, I think the grouping should be done directly in the 
child node, listing the pins in the reg property.

>
> 4) assign "gpio" properties to other nodes which refer to banks (see 
> booting-without-of.txt section IX, at the end) rather than individual 
> pins.

I think that's an improvement over the "gpios" formulation in section 
IX.  I'm concerned that the stipulated "gpios" format pushes a lot of 
address-format complexity out into unrelated nodes. 


>
> 5) optionally a bank may contain gpio pin node which describes EXACTLY 
> what that pin function is (and any lovely properties it may well have).
>
> At the moment it's encoded as:
>
>     gpios = <&controller-phandle pin-number pin-flags>
>
> Ad infinitum. Instead of a controller phandle you'd pass in a bank 
> (which is a subset of the controller's available pins) and then you 
> can give each pin it's little options.

How about
     gpios = <&controller-child-phandle0 &controller-child-phandle1 ...>

The flags, if any, should be properties of the child node.

One might argue that the code to process the "new" gpios will need 
additional complexity to deal with addressing issues at the target child 
nodes.  I would counter that it is probably actually easier, because 
instead of needing code to handle "#gpio-cells", you instead re-use 
existing code to handle "#address-cells" in the child/parent context.

>
> Actually I would also advocate allowing each pin to be assigned a node 
> of it's own and a compatible property - after all if you have a board 
> where gpios can move around (consider an FPGA with a processor core, 
> where positions of lines to use are actually reflected by a read-only 
> register or the device tree is derived directly from the VHDL source 
> or a constraints script?) and don't want to rewrite your driver every 
> time, it would be good to be able to find exactly which pin controls 
> exactly which line on the peripheral chip?

Yep.  The existing OFW addressing framework was designed to solve 
exactly this sort of problem, with its abstraction of the notion of an 
"address" and its ability to change the interpretation of "addresses" as 
you move around in the tree.


>
> Therefore you'd get something like this in a DTS; please hit me on the 
> head if you think it's getting really unwieldy :D
>
> gpio_1: gpio-controller@1000 {
>     #gpio-cells = <2>;

"#gpio-cells" is unnecessary if the "gpios" property is just a list of 
phandles.  But you do need "#address-cells = <1>" and "#size-cells = 
<1>", because this node defines a proper subordinate address space.

>     compatible = "fsl,mpc5200b-gpio";
>     reg = <0x1000 0x4>;
>     gpio-controller;
>     available = <1 10 15 4 30 1>;
>
>     gpio_1_bank_1: gpio-bank {
>         \\ 5 pins for some nefarious purpose
>         compatible = "gpio-bank";
>         ranges = <1 5 0>; \\ start length flags

As stated, I'd forego this intermediate level.


>
>         gpio_pin@2 {

The name here should reflect the purpose of the pin, i.e. what it does 
(perhaps "NAME,magic"), not the fact that is is GPIO pin.  By analogy, 
an ethernet controller's node name is "ethernet", not "pci-card".  The 
fact that the node represents one or more gpio pins is implicit and 
obvious - all children of a gpio-controller node are gpio pin(s).  All 
children of a scsi node are SCSI devices, ad nauseum.

> \\ I guess this address has to be
> \\ the global offset and not the offset into the range to make
> \\ it easier?

Eliminating the intermediate level moots this question.

>             reg = <2 1>
>             compatible = "magic";
>         };
>     };
> }
>
> device@9000 {
>     compatible = "somedevice";
>     reg = <0x9000 0x18>;
>     gpios = <&gpio_1_bank_1>

gpios = <&NAME,magic>

> };
>
> Most implementations won't need the explicit pin definitions but it 
> would probably come in handy somewhere if you were bitbanging some 
> protocol (SPI, I2C or so) or driving a device where you could change 
> this stuff, or even dynamically work out if a connector was inserted a 
> certain way (I'm thinking of maybe an expansion connector which can 
> run line-reversed like PCI Express.. but made out of GPIO. Am I nuts?)

It has been my experience that full explicit descriptions are usually a 
win in the long run.  (Which is not to say that I've always done the 
right thing, but when I have it has often been worthwhile.)


>
> -- 
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
