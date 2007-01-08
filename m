Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 30131DDDFA
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 11:39:35 +1100 (EST)
Subject: Re: [PATCH] Probe Efika platform before CHRP.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <45A17D1A.4050201@genesi-usa.com>
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>
	<1166528379.19254.69.camel@localhost.localdomain>
	<4587D338.7060906@246tNt.com>
	<1166538553.25827.99.camel@pmac.infradead.org>
	<1166558300.19254.71.camel@localhost.localdomain>
	<1167773388.22068.443.camel@pmac.infradead.org>
	<1167773863.6165.82.camel@localhost.localdomain>
	<1167775493.3660.23.camel@shinybook.infradead.org>
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>
	<45A01416.6080401@genesi-usa.com>
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
	<45A1535C.1080007@genesi-usa.com>
	<f0c5df8b1d2bcc1abcd04894e0210cc1@kernel.crashing.org>
	<45A16FF1.5000401@genesi-usa.com> <45A175B3.4010506@246tNt.com>
	<45A17D1A.4050201@genesi-usa.com>
Content-Type: text/plain
Date: Mon, 08 Jan 2007 11:37:58 +1100
Message-Id: <1168216678.22458.95.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Sylvain Munaut <tnt@246tNt.com>, bbrv@genesi-usa.com,
	Linux PPC DEV <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> device_type = "ethernet", well, then it's ethernet. Which kind? Well, it's the
> kind that can only be available on that particular combination of hardware. If
> it is an MPC5200B chip or an MPC5200 chip, you can determine exactly which one
> it is. If it is an MPC8349E or an MPC82xx or something, it may be different,
> but in general you can determine the exact device you have much easier (one
> register comparison..) than running through a null-terminated string list,
> doing comparisons against another list, and you get a wealth of information
> out of that single 32-bit register value of the SVR that you would not from
> a simple name. This is where it differs from PCI devices which you can have
> 10 of them in the same box and need to work out which one came from where, and
> what esoteric combination the user will use. The device tree is simply there
> to inform you what is present and what is configured (especially in the case
> when a unit can be configured as multiple devices and may be dangerous to
> reconfigure) and on an SoC or even a northbridge or southbridge which
> implements "non PCI" devices, you have plenty of options for determining
> exactly what is in them (/builtin/ethernet@1 on Pegasos is the Marvell
> controller, even though we use a chip with 2 ethernet controllers in it,
> only one works - there is no PHY card for the other. However rather
> scarily the option of 1 or 2 ethernet ports in Linux is defined by a
> kernel config flag... so much for the device tree..)

I don't know where to begin to explain how wrong I think you are ...

To simplify, let's say that a device should be represented by a device
node that is pretty much self contained. There should be no need to go
look at anything else (processor node, SVR register, whatever). You
should be able to uniquely identify every device in the system based on
a few properties, and OpenFirmware provides precisely a mecanism to do
so.

This mecanism, is the "compatible" property.

If you look closely at the OF PCI binding (since PCI is one of your
examples), you'll notice that while pciDDDD,VVVV (device,vendor) is at
the beginning of the compatible list, pciCCCC (class) follows.

Again, same logic as explained earlier: you define your device from the
more specific to the more generic.

In many cases, a device programming interface is generic (for example,
the UHCI, OHCI and EHCI USB host controller drivers, on PCI, match based
on the class, not the vendor/device IDs. They only use the later for
identifying a handful a chips that need erratas/quirks, they do NOT have
and do not need a complete list of all the vendor/device ID combinations
for those types of controllers).

That sort of class level matching is also widely used for USB devices.

Thus, the driver -choses- at what level it wants to detect supported
devices, based on that, -and- can still explicitely look at the more
"precise" indentification when it needs to single out a given
revision/version of a piece of hardware.

So this mecanism is great and isn't actually that clumsy at all. What
might eventually be clumsy is purely the naming choice when the vendor
doesn't provide something nice/unique enough for a given part. For
example, in order to properly identify the 52xx "fec" ethernet part,
since we don't have a nice/unique codename for it, we use mpc52xx-fec.
it's good enough and it's our convention.

For PCI devices, the compatible property is defined to be a fairly long
list, which can contain vid/did pairs (and multiple ones as one device
cna be made HW compatible with another one) but goes down to class based
matching which is more useful for well defined programming interfaces.

Strings are perfect, much better than numbers, as long as we properly
define the content of the string.

Ben.
