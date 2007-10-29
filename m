Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77BDADE02B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Oct 2007 02:18:44 +1100 (EST)
Message-ID: <4725FA58.4030505@genesi-usa.com>
Date: Mon, 29 Oct 2007 15:20:56 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yoder Stuart-B08248 wrote:
> We've had some discussions internally here at Freescale among 
> various PPC Linux developers about the device_type property
> and how 'classes' of devices should be represented in the
> device tree.
> 
> The initial list of official classes would be small--
> "cpu","memory", "cache", "pci", "serial", "network",
> "open-pic"(?).  As other types get codified in actual use
> and have official bindings specified (perhaps through
> power.org) new types would be supported--e.g. "i2c",
> "jdec-flash".
> 
> Thoughts?

I think device_type, compatible and model properties fulfil
this already, they simply aren't being used correctly.

Remember that, while you may want to make FDTs easier to
design, OpenFirmware and the requirement on device interfaces
through the client interface still exist and are still
implemented (from time to time).

What I would recommend is that the device_type encapsulate
the class of the device as it is currently. This means for
a display, you set device_type to "display".

OF platform devices for displays can then get a list of
all the "displays" available on a system, or "i2c" controllers
available on a system.

For readability, the name of the device needn't match device_type;
for instance on the 5121E it may be that the 'diu' unit be
called diu, but be of device_type 'display' - further information
can be added through the 'compatible' property of devices that
also support the same register model.

Further differentiation should be done through the 'model'
property in my opinion. This is optional in the OpenFirmware
spec, but that does not mean it should be important. It is
currently defined as something to determine the exact model
of a chip in order to enable quirks, bugfixes and suchlike,
but most implementations switch on something else entirely
(like SVR or a heuristic behaviour).

Selecting the "model" would be no different to, for example,
having a list of PCI IDs that will work with a driver.

Basically, I envision that instead device trees should be
a little more verbose, and that OF device probing should be
improved so that drivers can hook in on many levels of
matching.

There was a little discussion at bplan once that it would be
easier to implement a kind of vendor/device id system much
like PCI, USB etc. implements in hardware in order to match
hardware. I suppose you could use a "class" property to
implement this - but for instance in the case of USB or
PCI, this is already encoded in the device_type for anything
the firmware cannot work out (pci1106,6062 or so).

Perhaps it is a solution though; mark each device with a
class property, for instance on the 5200B give it a unique
chip ID (fsl5200 or soc5200?) and each unit a device id and take a big
hint from PCI class codes and programming interfaces here -
USB might be fsl5200,0c0310 (0c, 03 and 10 are all the PCI
class, subclass and progif for USB OHCI).

Additionally you can add more specific information such as
the type of USB controller, for instance in the case of EHCI,
perhaps also differentiate between EHCI with a companion controller,
EHCI with a transaction translator and no companion controller, etc.
with a further code - fsl520B,0c0320.01

References to peek at:

http://www.openbios.org/data/docs/bus.usb.pdf
http://www.openbios.org/data/docs/bus.pci.pdf

Especially take a peek at the PCI docs, page 10 where
"Table 1: Generic Names based upon Class Code" gives a
bunch of really nice name/device_types.

Note that none of this adds any further properties to
the specification for identification - you can do it
all using device_type and compatible.

So, why not start up a registry of vendor, device and
"class-code" numbers for SoC devices for when PCI
numbering cannot adequately fill the gap? In this case,
Freescale, IBM, AMCC and PASemi already have registered
vendor codes, class-codes for 99% of interfaces can
be derived from the PCI specifications?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
