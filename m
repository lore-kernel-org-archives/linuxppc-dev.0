Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Date: Tue, 6 Dec 2005 20:48:55 +0100
References: <1133816807.8577.50.camel@cashmere.sps.mot.com>
In-Reply-To: <1133816807.8577.50.camel@cashmere.sps.mot.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200512062048.56131.arnd@arndb.de>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
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

On Maandag 05 Dezember 2005 22:06, Jon Loeliger wrote:
> Included below is a proposed Revision 0.5 of the
> "Booting the Linux/ppc kernel without Open Firmware"
> document.  This modification primarily extends the
> Revision 0.4 by adding definitions for OF Nodes that
> cover the System-On-a-Chip features found on PPC parts.
> It also generalizes some earlier wording that pertained
> to only PPC64 parts and covers the new, merged PPC 32
> and 64 parts together.  Finally, minor typos, style
> consistency and grammar problems were corrected.

A few points are not clear yet, either because I don't understand the
document or one it references correctly or because I might have
different requirements:

- Do we need a way to identify the type of soc bus? There are different
  standards for this, e.g. PLB4 on PPC440 or the EIB on the Cell BE.
  My initial idea was to have different device-type properties for these,
  but I now think that device_type = "soc" makes sense for all of them.
  Maybe we could add a model or compatible property for them.

- It does not really belong into this document, but is related anyway:
  how do you want to represent this in Linux? Currently, most of these
  would be of_platform_device, but I think it would be good to have
  a new bus_type for it. The advantage would be that you can see the
  devices in /sys/devices/soc@xxx/ even if the driver is not loaded
  and the driver can even be autoloaded by udev.
  Also, which properties should show up in sysfs? All of them or just
  those specified in this document or a subset of them?

- What do we do with pci root devices? They are often physically connected
  to the internal CPU bus, so it would make sense to represent them
  this way in the device tree. Should we add them to the specification
  here? Would it even work the expected way in Linux?

- For some devices, you mandate a model property, for others you don't.
  Is this intentional? It might be easier to find the right device
  driver if the match string always contains a model name.

- How would I represent nested interrupt controllers? E.g. suppose I
  have a Cell internal interrupt controller on one SOC bus and
  and an external interrupt controller on another SOC bus but have
  that deliver interrupts to the first one.

- Should it mention nested SOC buses, e.g. a PLB4 bus connected to a
  PLB5 bus?

- The title says 'without Open Firmware', but it should also be allowed
  to use the same SOC bus layout when using SLOF or some other OF
  implementation, right?

- Also not new in this version, but still: Should there be support for
  specifying CPUs with multiple SMT threads?

	Arnd <><
