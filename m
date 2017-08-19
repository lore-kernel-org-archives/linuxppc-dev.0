Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xZPVS4JwpzDr2Q
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 20 Aug 2017 01:48:00 +1000 (AEST)
Date: Sat, 19 Aug 2017 10:47:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, gabriele.paoloni@huawei.com,
 airlied@linux.ie, benh@kernel.crashing.org, will.deacon@arm.com,
 dri-devel@lists.freedesktop.org, z.liuxinliang@hisilicon.com,
 bhelgaas@google.com, alex.williamson@redhat.com, lukas@wunner.de,
 catalin.marinas@arm.com, zourongrong@gmail.com, daniel.vetter@intel.com
Subject: Re: [PATCH v2 1/1] Split VGA default device handler out of VGA arbiter
Message-ID: <20170819154753.GQ28977@bhelgaas-glaptop.roam.corp.google.com>
References: <20170817113028.16853-1-dja@axtens.net>
 <20170817113028.16853-2-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170817113028.16853-2-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Aug 17, 2017 at 09:30:28PM +1000, Daniel Axtens wrote:
> A system without PCI legacy resources (e.g. ARM64)

Can you be a little more specific about what you mean by "a system
without PCI legacy resources"?  I'm not sure what the connection with
ARM64 as an architecture is.

My understanding is that "legacy resources" are addresses that are
hard-wired into a device and not discoverable or configurable via a
BAR [1].  For example,

  VGA devices (see [2])
    mem 0xa0000-0xbffff    (frame buffer)
    io  0x3b0-0x3bb        (plus ISA aliases)
    io  0x3c0-0x3df        (plus ISA aliases)

  IDE devices in compatibility mode (see [3])
    io  0x170-0x177        (secondary command)
    io  0x1f0-0x1f7        (primary command)
    io  0x376              (secondary control)
    io  0x3f6              (primary control)

The meaning of these resources in the PCI/PCIe domain is defined by
the PCI specs, not the platform arch specs.

So if ARM64 doesn't have these PCI legacy resources, does that mean an
ARM64 host bridge cannot generate these legacy addresses on PCI?  That
is, there's no host bridge window that maps to those PCI addresses?
That seems like a curious restriction on host bridges, but I guess it
would be possible.

I think you're fixing an issue related to the HiSilicon [19e5:1610]
PCI-to-PCI bridge, which doesn't support VGA Enable (I first thought
the bridge was broken, but per [4], I think it is legal).  With VGA
Enable not being supported, a downstream VGA device will not work if
it depends on the legacy VGA resources.  But this is merely related to
one PCI-to-PCI bridge in the system; it's not a question of the system
as a whole or the CPU architecture.

Maybe I'm reading too much into the "ARM64 has no PCI legacy
resources" idea and the point here is simply that the VGA arbiter
previously would not mark a VGA device as default if it found that the
legacy resources are not routed to it, e.g., because an upstream
bridge doesn't support VGA ENABLE?

That's "safe" because if the arbiter selects a default VGA device that
does not receive accesses to the legacy VGA resources, that device may
not work.  For example, it looks like vga16fb.c would not work because
it depends on VGA_FB_PHYS at 0xA0000.  A native driver certainly
*could* work, but that depends on whether the specific device and
driver require the legacy resources.

IIUC, part of what this patch does is relax this so we can set a
default "VGA device" that doesn't receive accesses to legacy VGA
resources.  If so, it's probably worth mentioning somehow that some
VGA things, e.g., vga16fb.c, may not work with this default device.

[1] PCI spec r3.0, sec G
[2] PCI-to-PCI bridge spec r1.2, sec 3.2.5.18, sec 12.1.1
[3] PCI IDE Controller spec, r1.0, sec 2.1
[4] PCI-to-PCI bridge spec r1.2, sec 4.5

> may find that no
> default/boot VGA device has been marked, because the VGA arbiter
> checks for legacy resource decoding before marking a card as default.
> 
> Split the small bit of code that does default VGA handling out from
> the arbiter. Add a Kconfig option to allow the kernel to be built
> with just the default handling, or the arbiter and default handling.
> 
> Add handling for devices that should be marked as default but aren't
> handled by the vga arbiter by adding a late initcall and a class
> enable hook. If there is no default from vgaarb then the first card
> that is enabled, has a driver bound, and can decode memory or I/O
> will be marked as default.

> + * vga_default_device - return the default VGA device
> + *
> + * This can be defined by the platform. The default implementation
> + * is rather dumb and will probably only work properly on single
> + * vga card setups and/or x86 platforms.

In what sense can this be defined by the platform?  I guess this
comment isn't new and was just moved, but I don't see any arch hook or
obvious way to do a platform-specific definition.
