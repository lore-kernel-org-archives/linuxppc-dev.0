Date: Thu, 1 Jul 2004 08:24:49 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Mark A. Greer" <mgreer@mvista.com>,
	linux-emb <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mv6360 support in mv64x60.c (was Re: GT64260_eth (Ethernet) Driver)
Message-ID: <20040701082449.A9754@home.com>
References: <40E1E94B.9060204@mvista.com> <1088691201.14216.2977.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1088691201.14216.2977.camel@hades.cambridge.redhat.com>; from dwmw2@infradead.org on Thu, Jul 01, 2004 at 03:13:21PM +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Jul 01, 2004 at 03:13:21PM +0100, David Woodhouse wrote:
> ∃ an Ethernet driver for the MV64340 (the MIPS version of the chip). It
> doesn't use OCP though -- there's no OCP on MIPS. Can someone explain
> why OCP is used instead of the generic platform_device functionality
> provided by the kernel? Should we convert MIPS to OCP?

OCP is used because it is simply wrapping a standard API around a
standard LDM "bus".  platform devices try to make non-hardware-scan
capable devices a special case.  OCP provides a standard way to get
at all platform specific information that a driver needs rather
than just a few things like platform devices currently do
(io, mem, irq resources).

One of the goals is to extend to allow hierarchical PM and hotplug
in OCP, its a standard bus now, but it's a flat list of devices
on the "bus".  In reality, SoCs that have internal PM/hotplug
capabilities have a hierarchical set of buses that should be
represented to properly manage this. Eventually, the idea is
to have OCP instantiate a tree of these dumb devices.

"We" should probably convert MIPS, ARM, SH, etc. to OCP, but
it only recently got rewritten (it's been around for ages in
PPC) in 2.4 and ported to 2.6.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
