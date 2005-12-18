Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1134856762.6102.54.camel@gaston>
References: <1133816807.8577.50.camel@cashmere.sps.mot.com>
	<200512062048.56131.arnd@arndb.de>
	<1134856762.6102.54.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3a8648f28b591dee596d6cb195f1cad1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Date: Sun, 18 Dec 2005 07:35:32 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: RFC: Rev 0.5 Booting the Linux/ppc kernel without Open Firmware
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> - Do we need a way to identify the type of soc bus? There are 
>> different
>>   standards for this, e.g. PLB4 on PPC440 or the EIB on the Cell BE.
>>   My initial idea was to have different device-type properties for 
>> these,
>>   but I now think that device_type = "soc" makes sense for all of 
>> them.
>>   Maybe we could add a model or compatible property for them.
>
> That would be a good idea.

"device_type" is what defines the (OF) programming interface.  As not
all SoC busses are identical for this, they should not have the same
device_type.

If you do want all of those semi-transparent SoC busses to be found
by one wildcard, you can add it to the "compatible" property.

> Also, it might be useful to ass a "clock-frequency" to it for 
> processors
> where it makes sense.

Certainly.

> One of the things we are passing from uboot
> currently is the list of clock frequencies for PLB/OPB/PCI/... we need
> to replace this with appropriate nodes and their respective
> "clock-frequency" properties
>
>> - It does not really belong into this document, but is related anyway:
>>   how do you want to represent this in Linux? Currently, most of these
>>   would be of_platform_device, but I think it would be good to have
>>   a new bus_type for it. The advantage would be that you can see the
>>   devices in /sys/devices/soc@xxx/ even if the driver is not loaded
>>   and the driver can even be autoloaded by udev.
>>   Also, which properties should show up in sysfs? All of them or just
>>   those specified in this document or a subset of them?

All that make sense.

> If we go that way, we also need to have the SOC type take optionally
> part in the matching. That is, the driver matching infos should be 
> based
> on model & compatible like OF does, thus we could recommend something
> like:
>
>  - Define a unique SOC name per SOC bus type/family, for example,
> ppc4xxPLB, etc... This goes into /soc/model.

"model" should be a string that is the "official" vendor name for
the device.

>  - Optionally, use compatible for similar busses. For example, if you
> have a new rev of that PLB that is similar but has extensions called
> PLB2, you can have model be ppc4xxPLB2 and compatible containing
> ppc4xxPLB.

"compatible" does not contain alternatives for "model"; it contains
alternatives for "name".

>  - Define that the "model" property of a device under /soc is of the
> form "socname,devicename"... For example, EMAC would be 
> ppc4xxPLB,emac",
> Same rule applies with compatible (this one could be compatible, among
> others, with "ppc4xxPLB,emac" and model "ppc4xxPLB2,emac".
>
>> - What do we do with pci root devices? They are often physically 
>> connected
>>   to the internal CPU bus, so it would make sense to represent them
>>   this way in the device tree. Should we add them to the specification
>>   here? Would it even work the expected way in Linux?
>
> They are generally below the root of the tree, they don't have to
> though. Linux shouldn't care as there is no generic code to instanciate
> them, it's platform specific. I may change that in the future though 
> but
> this isn't the case yet. The only rule is their name should be "pci"

No.  Their name can be whatever is required.  The "device_type" should
be "pci", for conventional PCI busses; and it should be whatever is
defined by the appropriate OF binding for newer, mostly PCI-comnpatible,
busses (like HT, PCIe, PCI-X, etc.)

>> - For some devices, you mandate a model property, for others you 
>> don't.
>>   Is this intentional? It might be easier to find the right device
>>   driver if the match string always contains a model name.

It is up to a device's parent bus to find the correct driver; for
the parent bus, device_type and/or compatible are normally enough
to do the matching.  "model" is useful to disambiguate sometimes,
but it normally is _too_ exact to do useful driver matching.

>> - How would I represent nested interrupt controllers? E.g. suppose I
>>   have a Cell internal interrupt controller on one SOC bus and
>>   and an external interrupt controller on another SOC bus but have
>>   that deliver interrupts to the first one.
>
> Read OF interrupt binding :) Typically, nodes contain either an
> interrupt-parent or a parent device with interrupt routing info (like a
> PCI bridge) which points to their actual parent controller. If it's a
> nested controller, it will itself have an interrupt parent and
> "interrupts" property to link it to its parent controller.

Interrupts are evil evil evil as always ;-)

>> - Should it mention nested SOC buses, e.g. a PLB4 bus connected to a
>>   PLB5 bus?
>>
> Do we have many of these horrors in real life ?

Yes, almost every SoC has at least two busses; e.g., you often see
a high-speed coherent "system" bus, and a lower-speed non-coherent
I/O bus connected to it.  But there are lots of variations to this
theme.

>> - The title says 'without Open Firmware', but it should also be 
>> allowed
>>   to use the same SOC bus layout when using SLOF or some other OF
>>   implementation, right?
>
> Yes, in fact, this document does cover open firmware as well. It 
> defines
> the flattened tree format, but doesn't exclude open firmware, and then
> defines the subset of OF required by the kernel.
>
>> - Also not new in this version, but still: Should there be support for
>>   specifying CPUs with multiple SMT threads?
>
> We need to think about this...

SMT threads should not be represented as separate CPUs.  But some
CPU resources that are described in a CPU node are non-shared between
SMT threads; we need to find a way to describe those.

The biggest problem is interrupts (as always); the unit-id for a
"cpu" node in OF is the IPI number of that CPU, but on SMT, IPIs
are per thread.


Segher
