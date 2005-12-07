Return-Path: <dgibson@ozlabs.org>
Date: Wed, 7 Dec 2005 11:17:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20051207001720.GB25533@localhost.localdomain>
References: <1133816807.8577.50.camel@cashmere.sps.mot.com>
	<200512062048.56131.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200512062048.56131.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: RFC: Rev 0.5 Booting the Linux/ppc kernel without Open Firmware
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 06, 2005 at 08:48:55PM +0100, Arnd Bergmann wrote:
> On Maandag 05 Dezember 2005 22:06, Jon Loeliger wrote:
> > Included below is a proposed Revision 0.5 of the
> > "Booting the Linux/ppc kernel without Open Firmware"
> > document.  This modification primarily extends the
> > Revision 0.4 by adding definitions for OF Nodes that
> > cover the System-On-a-Chip features found on PPC parts.
> > It also generalizes some earlier wording that pertained
> > to only PPC64 parts and covers the new, merged PPC 32
> > and 64 parts together.  Finally, minor typos, style
> > consistency and grammar problems were corrected.
> 
> A few points are not clear yet, either because I don't understand the
> document or one it references correctly or because I might have
> different requirements:

All comments below IMHO, and subject to persuasion otherwise.

> - Do we need a way to identify the type of soc bus? There are different
>   standards for this, e.g. PLB4 on PPC440 or the EIB on the Cell BE.
>   My initial idea was to have different device-type properties for these,
>   but I now think that device_type = "soc" makes sense for all of them.
>   Maybe we could add a model or compatible property for them.

It think it would be a good idea to have something labelling the
specific type of SOC bus, though I'm not immediately sure where.
"model" perhaps, if it rarely has an effect on how to operate the bus.

> - It does not really belong into this document, but is related anyway:
>   how do you want to represent this in Linux? Currently, most of these
>   would be of_platform_device, but I think it would be good to have
>   a new bus_type for it. The advantage would be that you can see the
>   devices in /sys/devices/soc@xxx/ even if the driver is not loaded
>   and the driver can even be autoloaded by udev.
>   Also, which properties should show up in sysfs? All of them or just
>   those specified in this document or a subset of them?

I concur - I believe we already have a bus_type for on-chip devices on
4xx.

> - What do we do with pci root devices? They are often physically connected
>   to the internal CPU bus, so it would make sense to represent them
>   this way in the device tree. Should we add them to the specification
>   here? Would it even work the expected way in Linux?

The host bridges should sit on the soc bus then, as you suggest (just
as the PCI busses hang off HyperTransport on the G5).  I think you
need to refer to the OF docs for how to represent the PCI host bridge
and devices themselves.

> - For some devices, you mandate a model property, for others you don't.
>   Is this intentional? It might be easier to find the right device
>   driver if the match string always contains a model name.

You rarely want to match model name to find a device - generally you
want to match either on "compatible" or "device_type", or possibly
both.

> - How would I represent nested interrupt controllers? E.g. suppose I
>   have a Cell internal interrupt controller on one SOC bus and
>   and an external interrupt controller on another SOC bus but have
>   that deliver interrupts to the first one.

Again, I believe this is in the OF docs - interrupt controllers have
an interrupt-parent property IIRC, which gives the phandle of the next
interrupt controller up the chain.

> - Should it mention nested SOC buses, e.g. a PLB4 bus connected to a
>   PLB5 bus?

Yes.

> - The title says 'without Open Firmware', but it should also be allowed
>   to use the same SOC bus layout when using SLOF or some other OF
>   implementation, right?

I guess so.

> - Also not new in this version, but still: Should there be support for
>   specifying CPUs with multiple SMT threads?

Umm.. maybe.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
