Return-Path: <galak@gate.crashing.org>
Date: Mon, 19 Dec 2005 14:49:56 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1134856762.6102.54.camel@gaston>
Message-ID: <Pine.LNX.4.44.0512191446570.4542-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Sun, 18 Dec 2005, Benjamin Herrenschmidt wrote:

> 
> > - Do we need a way to identify the type of soc bus? There are different
> >   standards for this, e.g. PLB4 on PPC440 or the EIB on the Cell BE.
> >   My initial idea was to have different device-type properties for these,
> >   but I now think that device_type = "soc" makes sense for all of them.
> >   Maybe we could add a model or compatible property for them.
> 
> That would be a good idea.
> 
> Also, it might be useful to ass a "clock-frequency" to it for processors
> where it makes sense. One of the things we are passing from uboot
> currently is the list of clock frequencies for PLB/OPB/PCI/... we need
> to replace this with appropriate nodes and their respective
> "clock-frequency" properties
> 
> > - It does not really belong into this document, but is related anyway:
> >   how do you want to represent this in Linux? Currently, most of these
> >   would be of_platform_device, but I think it would be good to have
> >   a new bus_type for it. The advantage would be that you can see the
> >   devices in /sys/devices/soc@xxx/ even if the driver is not loaded
> >   and the driver can even be autoloaded by udev.
> >   Also, which properties should show up in sysfs? All of them or just
> >   those specified in this document or a subset of them?

I'm still in favor of just leaving these devices as straight platform 
devices.  Unless there is something that is bus specific that each device 
on the bus conforms to I dont see any reason to create a new bus type.

> If we go that way, we also need to have the SOC type take optionally
> part in the matching. That is, the driver matching infos should be based
> on model & compatible like OF does, thus we could recommend something
> like:
> 
>  - Define a unique SOC name per SOC bus type/family, for example,
> ppc4xxPLB, etc... This goes into /soc/model.
> 
>  - Optionally, use compatible for similar busses. For example, if you
> have a new rev of that PLB that is similar but has extensions called
> PLB2, you can have model be ppc4xxPLB2 and compatible containing
> ppc4xxPLB.
> 
>  - Define that the "model" property of a device under /soc is of the
> form "socname,devicename"... For example, EMAC would be ppc4xxPLB,emac",
> Same rule applies with compatible (this one could be compatible, among
> others, with "ppc4xxPLB,emac" and model "ppc4xxPLB2,emac".
> 
> > - What do we do with pci root devices? They are often physically connected
> >   to the internal CPU bus, so it would make sense to represent them
> >   this way in the device tree. Should we add them to the specification
> >   here? Would it even work the expected way in Linux?


- kumar
