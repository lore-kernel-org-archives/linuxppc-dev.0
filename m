Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from outbound6-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id C3D61DDEF2
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 07:54:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Device Tree tool [was RE: [PATCH] Consolidate
	XILINX_VIRTEXboardsupport]
Date: Tue, 14 Aug 2007 14:54:36 -0700
In-Reply-To: <20070810153619.0471D190055@mail15-fra.bigfish.com>
From: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>
To: "Stephen Neuendorffer" <stephen.neuendorffer@xilinx.com>,
	"Grant Likely" <grant.likely@secretlab.ca>
Message-Id: <20070814215438.3C7AA1B7006C@mail148-cpk.bigfish.com>
Cc: microblaze-uclinux@itee.uq.edu.au, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


> BTW: I'm currently hacking away to see if I can get a=20
> microblaze system
> booting
> using a flat device tree...  I haven't decided if it's worth it to go
> that
> route in the end yet, but...
>=20
> Steve

I've managed to get the first step working: a microblaze system
advertising of_devices in 2.6 using a flat device tree.  The next task
is to
reimplement probe() for a driver or two (probably the xilinx_emac driver
first).   My plan is to have the driver advertise both through
of_platform_bus, and
through the regular platform bus, and have a config option that either
advertises
the devices through of and links in the device tree, or using the
exising
platform_device mechanism.

Grant:  Does this make sense (in terms of dealing with drivers) with
your plans for
moving Virtex platforms to arch/powerpc?  I'd like to avoid duplicating
work on the
drivers, if possible.

Is there a concensus on how microblaze systems should get booted?
Currently,
I'm linking the device tree directly into the kernel itself, loading the
whole
mess using SystemAce and the start address jumps directly into the
kernel, which
is quite a bit different than the way powerpc works.  It's certainly
simpler:
maybe too simple.  At the same time, replicating
the complexity of arch/powerpc with separate boot code may or may not be
worth it...
Any thoughts?

Steve
