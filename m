Return-Path: <dja@axtens.net>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xY3tb0NpxzDrF3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 21:30:46 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id y129so9441287pgy.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 04:30:46 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, bhelgaas@google.com, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 dri-devel@lists.freedesktop.org, lukas@wunner.de,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH v2 0/1] Split VGA default nomination out from VGA arbiter
Date: Thu, 17 Aug 2017 21:30:27 +1000
Message-Id: <20170817113028.16853-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is approach 3, version 2, of my patch series to sort out Xorg
autoconfiguration for the Hibmc card beind a Hisilicon bridge on
arm64.

Approach 1 was a simple quirk for the card+bridge to mark it as
default. This higlighted the fact that the default card was picked by
the arbiter, which assumed legacy resources. The lack of legacy
resources leads to quirks in ppc and concerns in arm land, so a more
generic approach was desired.
Link: https://www.spinics.net/lists/linux-pci/msg62865.html

Approach 2 allowed platforms to opt in to a class enable hook that
added a card as default if there was no default. This:

 - was possibly racy as ACPI PCI init and vgaarb are both subsys
   initcalls.

 - didn't check to see if a card had a driver.

 - meant that platforms for which the vga arbiter didn't make sense
   still needed it.

Links: https://www.spinics.net/lists/linux-pci/msg63092.html
       https://www.spinics.net/lists/linux-pci/msg63083.html

This is approach 3. It pulls the default handling out of the arbiter,
into its own file and behind its own Kconfig option. It adds the extra
detection as a late initcall and an enable hook that only operates
after the initcall, so it's not racy. It checks for drivers. It means
people can turn off the vga arbiter. It works sensibly for modules
too.

v1: https://www.spinics.net/lists/linux-pci/msg63581.html

Changes in v2:

Drop all the powerpc patches.

Including just the new handler doesn't change behaviour on powerpc.

This is because - as Bjorn pointed out on v1 - I had not fully
understood how fixup_vga worked. fixup_vga is quite aggressive: if
there is no default, and it finds a VGA card, it will mark that card
as default. Later on, if it finds a card with decoding enabled, it
will update the default.

This means that if there is any vga card in the system at all, a
default will be marked. This all happens at the FIXUP_CLASS_FINAL
stage, so if there is a vga card, a default will be marked before the
late_initcall that kicks off this new discovery process. This will
completely prevent my code from firing.

Once this is merged I will discuss with the ppc folks if they want to
move to this approach or if ppc should continue to be very optimistic
about the cards it marks as default.

Regards,
Daniel


Daniel Axtens (1):
  Split VGA default device handler out of VGA arbiter

 arch/ia64/pci/fixup.c            |   2 +-
 arch/powerpc/kernel/pci-common.c |   2 +-
 arch/x86/pci/fixup.c             |   2 +-
 arch/x86/video/fbdev.c           |   2 +-
 drivers/gpu/vga/Kconfig          |  12 +++
 drivers/gpu/vga/Makefile         |   1 +
 drivers/gpu/vga/vga_default.c    | 159 +++++++++++++++++++++++++++++++++++++++
 drivers/gpu/vga/vga_switcheroo.c |   2 +-
 drivers/gpu/vga/vgaarb.c         |  41 +---------
 drivers/pci/pci-sysfs.c          |   2 +-
 include/linux/vga_default.h      |  44 +++++++++++
 include/linux/vgaarb.h           |  14 ----
 12 files changed, 225 insertions(+), 58 deletions(-)
 create mode 100644 drivers/gpu/vga/vga_default.c
 create mode 100644 include/linux/vga_default.h

-- 
2.11.0
