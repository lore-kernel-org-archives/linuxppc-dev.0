Return-Path: <miltonm@bga.com>
In-Reply-To: <44DE1357.5010703@ru.mvista.com>
References: <311553550076b8b45674.846930886.miltonm@bga.com>
	<44DE1357.5010703@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <91f1d0619c8ff22cf70404059d514857@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] Adding MTD to device tree
Date: Sat, 12 Aug 2006 16:15:56 -0500
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 12, 2006, at 12:43 PM, Sergei Shtylyov wrote:

> Hello.
>
> Milton Miller wrote:
>
>>>> +   h) MTD nodes
>>>> +
>>>> +   Memory Technology Devices are flash, ROM, and similar chips, 
>>>> often used
>>>> +   for solid state file systems on embedded devices.
>>>> +
>>>> +   Required properties:
>>>> +
>>>> +    - device_type : has to be "mtd"
>>>> +    - compatible : Should be the name of the MTD driver. 
>>>> Currently, this is
>>>> +      most likely to be "physmap".
>>>> +    - reg : Offset and length of the register set for the device.
>
>>> I would prefer to call them something different in the device tree.
>>> The name 'mtd' is very specific to Linux, but the device tree
>>> is a more generic concept.
>
>    "Memory type devices" are specific to Linux? Doubt it. :-)
>    In fact, device type "flash" sounds too restrictive.

First of all, I was only quoting that.

Second, no, memory type devices are not specific to Linux.  But the 
term MTD
probably is[1].  If you don't want to call it flash, then call it rom.  
The
fact that its programable rom is a detail.

>>> I understand that the booting-without-of.txt file is by definition
>>> Linux specific as well, but we should be prepared for making parts
>>> of it a OS independent binding at the point where we put the same
>>> device nodes into actual OF implementations that able to boot
>>> different operating systems.
>
>>> I would prefer a naming that has
>
>>>   Required properties:
>>>    - device_type : one of "nand-flash", "nor-flash", or "rom".
>>>    - model : an identifier for the actual controller chip used.
>>>    - compatible : Should be the name of the MTD driver. For
>>>      type "rom", this is most likely "physmap".
>
>> I'm with your suggestion for device_type and model, but not 
>> compatable.
>>  "physmap"?  What kind of device is that?  A
>
>    Directly mapped NOR flash or ROM I think.

I don't know how you got there, without your linux implementation 
knowledge.

>> command set name, maybe with a width, would be
>
>    That'd be pretty useless if you don't let Linux know which MTD 
> *map* driver
> to use. And I have specified the "bank-width" prop.

The fact that its directly mapped should be evident from its location in
the device tree and its properties such as reg.

I think you are getting caught up the layering of the linux mtd 
subsystem, and not
thinking about describing the hardware.

>> appropriate.   Physmap is the name of another linux driver.
>
>    And the role of the "compatible" prop is exactly to help OS in 
> selecting the driver.

Yes, help select.  But not say "here is the name of the driver to use." 
  Its to specify
the programing interface.

We don't say "use the ohci driver" but "this device has pci class 
0C0310" and the
ohci-pci driver says "I handle devices that are pci class serial 
subclass usb and
programming interface ohci".

Putting "cfi-xxx", "cfi", "rom" would show that it should be probed by 
cfi
instead of by jedec for example.

Are we still talking about doing a driver that calls physmap with the 
appropriate
address gathered from of_device?  It would be the one to select the 
nodes compatable
nodes, finds the relevant parms, and calls the mtd layer.

>> Something like direct or linear might be appropriate for a rom, where 
>> just address
>> and length appear.
>
>    I agree that "linear" or "direct" may be better variants.

Yea.

>>  Even rom would be better than physmap.
>
>    Doubt it since the ROM is the only one thing (and even the least 
> probable) that we're
> going to support.

But it would make sense to be a later compatible entry ... we can treat 
the flash as a
true read-only memory and it will work, we just will not have the 
feature of writing
to it.

As segher pointed out, compatible is a (specific to generic) list of 
hints to the
programming interface.

I'll admit I'm not that familiar with the mtd subsystem.  But I did go 
and browse the
redboot, ebony, and ocetea map drivers, along with physmap.  With the 
addresses filled
out, they would appear to collapse into one driver, with multiple 
device nodes for each
one.  Except for the partitioning information.

Ok that brings up partitions: if you need partitions, and don't have a 
table system
like redboot, then we need some way to convey that in the device tree.  
My
first instinct is that would be via device nodes under the map device 
in the tree.
The nodes would get a reg with relative address and size, and the name 
would be
the name of the partition.   We could also do it in properties on the 
mtd node, but
then would not not have a good place to put the name.   (Well, we could 
do a list of
strings and a parallel list of partition sizes.   I would prefer we not 
encode both
in one property).  Yes, we can rely on cmdline partitioning ... but 
that means a long
argument in your device tree you don't want edited.

milton

[1] Google seems to confirm this: the first several hits are for a 
power equipment
manufacturer, and then linux-mtd site by itself, without other os's 
"mtd" projects
in the first 4 pages of hits.
