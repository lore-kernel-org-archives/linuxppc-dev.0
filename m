Return-Path: <dja@axtens.net>
Received: from mail-wr0-x244.google.com (mail-wr0-x244.google.com
 [IPv6:2a00:1450:400c:c0c::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xP2yH68vjzDqJC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 20:21:11 +1000 (AEST)
Received: by mail-wr0-x244.google.com with SMTP id g32so2691772wrd.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 03:21:11 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
Cc: benh@kernel.crashing.org, z.liuxinliang@hisilicon.com,
 zourongrong@gmail.com, catalin.marinas@arm.com, will.deacon@arm.com,
 gabriele.paoloni@huawei.com, bhelgaas@google.com, airlied@linux.ie,
 daniel.vetter@intel.com, alex.williamson@redhat.com,
 Daniel Axtens <dja@axtens.net>
Subject: [PATCH 0/3] Split VGA default selection from VGA arbiter
Date: Fri,  4 Aug 2017 20:20:30 +1000
Message-Id: <20170804102033.27731-1-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is approach 3 of my patch series to sort out Xorg
autoconfiguration for the Hibmc card beind a Hisilicon bridge on
arm64.

Approach 1 was a simple quirk for the card+bridge to mark it as
default. This higlighted the fact that the default card was picked by
the arbiter, which assumed legacy resources. The lack of legacy
resources leads to quirks in ppc and concerns in arm land, so a more
generic approach was desired.

Approach 2 allowed platforms to opt in to a class enable hook that
added a card as default if there was no default. This:

 - was possibly racy as ACPI PCI init and vgaarb are both subsys
   initcalls.

 - didn't check to see if a card had a driver.

 - meant that platforms for which the vga arbiter didn't make sense
   still needed it.

This is approach 3. It pulls the default handling out of the arbiter,
into its own file and behind its own Kconfig option. It adds the extra
detection as a late initcall and an enable hook that only operates
after the initcall, so it's not racy. It checks for drivers. It means
people can turn off the vga arbiter. It works sensibly for modules
too.

Patch 1 cleans up the powerpc fixup, as with approach 2.
Patch 2 is the big split.
Patch 3 moves ppc over, as with approach 2.
There is no need for an arm-specific patch this time as the Kconfig option
is on by default.

Regards,
Daniel

Daniel Axtens (3):
  powerpc: simplify and fix VGA default device behaviour
  Split VGA default device handler out of VGA arbiter
  powerpc: replace vga_fixup() with generic code

 arch/ia64/pci/fixup.c            |   2 +-
 arch/powerpc/kernel/pci-common.c |  13 ----
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
 12 files changed, 224 insertions(+), 70 deletions(-)
 create mode 100644 drivers/gpu/vga/vga_default.c
 create mode 100644 include/linux/vga_default.h

-- 
2.11.0
