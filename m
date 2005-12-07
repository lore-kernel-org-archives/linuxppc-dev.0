Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20051207001720.GB25533@localhost.localdomain>
References: <1133816807.8577.50.camel@cashmere.sps.mot.com>
	<200512062048.56131.arnd@arndb.de>
	<20051207001720.GB25533@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D6B0E6A6-A7A4-4A44-B96C-D625C8C9BFA2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 7 Dec 2005 10:54:28 -0600
To: David Gibson <david@gibson.dropbear.id.au>
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


On Dec 6, 2005, at 6:17 PM, David Gibson wrote:

> On Tue, Dec 06, 2005 at 08:48:55PM +0100, Arnd Bergmann wrote:
>> On Maandag 05 Dezember 2005 22:06, Jon Loeliger wrote:
>>> Included below is a proposed Revision 0.5 of the
>>> "Booting the Linux/ppc kernel without Open Firmware"
>>> document.  This modification primarily extends the
>>> Revision 0.4 by adding definitions for OF Nodes that
>>> cover the System-On-a-Chip features found on PPC parts.
>>> It also generalizes some earlier wording that pertained
>>> to only PPC64 parts and covers the new, merged PPC 32
>>> and 64 parts together.  Finally, minor typos, style
>>> consistency and grammar problems were corrected.
>>
>> A few points are not clear yet, either because I don't understand the
>> document or one it references correctly or because I might have
>> different requirements:
>
> All comments below IMHO, and subject to persuasion otherwise.
>
>> - Do we need a way to identify the type of soc bus? There are  
>> different
>>   standards for this, e.g. PLB4 on PPC440 or the EIB on the Cell BE.
>>   My initial idea was to have different device-type properties for  
>> these,
>>   but I now think that device_type = "soc" makes sense for all of  
>> them.
>>   Maybe we could add a model or compatible property for them.
>
> It think it would be a good idea to have something labelling the
> specific type of SOC bus, though I'm not immediately sure where.
> "model" perhaps, if it rarely has an effect on how to operate the bus.

I think this should be optional since it rarely has an effect on usage.

>> - It does not really belong into this document, but is related  
>> anyway:
>>   how do you want to represent this in Linux? Currently, most of  
>> these
>>   would be of_platform_device, but I think it would be good to have
>>   a new bus_type for it. The advantage would be that you can see the
>>   devices in /sys/devices/soc@xxx/ even if the driver is not loaded
>>   and the driver can even be autoloaded by udev.
>>   Also, which properties should show up in sysfs? All of them or just
>>   those specified in this document or a subset of them?
>
> I concur - I believe we already have a bus_type for on-chip devices on
> 4xx.

Not, sure what the 4xx reference is but, we have be using the  
platform bus in the kernel for "soc" connected devices.  I dont see  
the need to invent a new bus type unless there is a specific reason to.

>> - What do we do with pci root devices? They are often physically  
>> connected
>>   to the internal CPU bus, so it would make sense to represent them
>>   this way in the device tree. Should we add them to the  
>> specification
>>   here? Would it even work the expected way in Linux?
>
> The host bridges should sit on the soc bus then, as you suggest (just
> as the PCI busses hang off HyperTransport on the G5).  I think you
> need to refer to the OF docs for how to represent the PCI host bridge
> and devices themselves.

We need to provide some details on PCI nodes based on the OF docs.   
Ben and I have talked a little about this.  Its mainly about what  
parts of the OF spec are truly required.  We will probably add some  
additional information that the OF spec doesnt handle for host  
bridges setup.

>> - For some devices, you mandate a model property, for others you  
>> don't.
>>   Is this intentional? It might be easier to find the right device
>>   driver if the match string always contains a model name.
>
> You rarely want to match model name to find a device - generally you
> want to match either on "compatible" or "device_type", or possibly
> both.
>
>> - How would I represent nested interrupt controllers? E.g. suppose I
>>   have a Cell internal interrupt controller on one SOC bus and
>>   and an external interrupt controller on another SOC bus but have
>>   that deliver interrupts to the first one.
>
> Again, I believe this is in the OF docs - interrupt controllers have
> an interrupt-parent property IIRC, which gives the phandle of the next
> interrupt controller up the chain.

Yep, you need to check out the "Interrupt Mapping" OF spec for  
details.  It handles describing the chaining you speak of.  However,  
you will need to provide some "spec" for any properties of the  
interrupt controllers that you may need.

>> - Should it mention nested SOC buses, e.g. a PLB4 bus connected to a
>>   PLB5 bus?
>
> Yes.

Is there anything special about this? are these PLB4/5 busses  
software visible?

>
>> - The title says 'without Open Firmware', but it should also be  
>> allowed
>>   to use the same SOC bus layout when using SLOF or some other OF
>>   implementation, right?
>
> I guess so.
>
>> - Also not new in this version, but still: Should there be support  
>> for
>>   specifying CPUs with multiple SMT threads?
>
> Umm.. maybe.

- kumar
