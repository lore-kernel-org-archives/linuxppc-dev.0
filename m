Return-Path: <acolin@isi.edu>
Received: from mail-d.ads.isi.edu (mail-d.ads.isi.edu [128.9.180.199])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41fzNw4rgkzF153
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 00:30:07 +1000 (AEST)
From: Alexei Colin <acolin@isi.edu>
To: Alexandre Bounine <alex.bou9@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Alexei Colin <acolin@isi.edu>, John Paul Walters <jwalters@isi.edu>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
 Will Deacon <will.deacon@arm.com>, Ralf Baechle <ralf@linux-mips.org>,
 Paul Burton <paul.burton@mips.com>,
 Alexander Sverdlin <alexander.sverdlin@nokia.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Peter Anvin <hpa@zytor.com>, Matt Porter <mporter@kernel.crashing.org>,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 0/6] rapidio: move Kconfig menu definition to subsystem
Date: Tue, 31 Jul 2018 10:29:48 -0400
Message-Id: <20180731142954.30345-1-acolin@isi.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Resending the patchset from prior submission:
https://lkml.org/lkml/2018/7/30/911

The only change are the Cc tags in all patches now include the mailing
lists for all affected architectures, and patch 1/6 (which adds the menu
item to RapdidIO subsystem Kconfig) is CCed to all maintainers who are
getting this cover letter. The cover letter has been updated with
explanations to points raised in the feedback.



The top-level Kconfig entry for RapidIO subsystem is currently
duplicated in several architecture-specific Kconfig files. This set of
patches does two things:

1. Move the Kconfig menu definition into the RapidIO subsystem and
remove the duplicate definitions from arch Kconfig files.

2. Enable RapidIO Kconfig menu entry for arm and arm64 architectures,
where it was not enabled before. I tested that subsystem and drivers
build successfully for both architectures, and tested that the modules
load on a custom arm64 Qemu model.

For all architectures, RapidIO menu should be offered when either:
(1) The platform has a PCI bus (which host a RapidIO module on the bus).
(2) The platform has a RapidIO IP block (connected to a system bus, e.g.
AXI on ARM). In this case, 'select HAS_RAPIDIO' should be added to the
'config ARCH_*' menu entry for the SoCs that offer the IP block.

Prior to this patchset, different architectures used different criteria:
* powerpc: (1) and (2)
* mips: (1) and (2) after recent commit into next that added (2):
  https://www.linux-mips.org/archives/linux-mips/2018-07/msg00596.html
  fc5d988878942e9b42a4de5204bdd452f3f1ce47
  491ec1553e0075f345fbe476a93775eabcbc40b6
* x86: (1)
* arm,arm64: none (RapidIO menus never offered)

This set of architectures are the ones that implement support for
RapidIO as system bus. On some platforms RapidIO can be the only system
bus available replacing PCI/PCIe.  As it is done now, RapidIO is
configured in "Bus Options" (x86/PPC) or "Bus Support" (ARMs) sub-menu
and from system configuration option it should be kept this way.
Current location of RAPIDIO configuration option is familiar to users of
PowerPC and x86 platforms, and is similarly available in some ARM
manufacturers kernel code trees. (Alex Bounine)

HAS_RAPIDIO is not enabled unconditionally, because HAS_RAPIDIO option
is intended for SOCs that have built in SRIO controllers, like TI
KeyStoneII or FPGAs. Because RapidIO subsystem core is required during
RapidIO port driver initialization, having separate option allows us to
control available build options for RapidIO core and port driver (bool
vs.  tristate) and disable module option if port driver is configured as
built-in. (Alex Bounine)

Responses to feedback from prior submission (thanks for the reviews!):
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593347.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593349.html

Changelog:
  * Moved Kconfig entry into RapidIO subsystem instead of duplicating

In the current patchset, I took the approach of adding '|| PCI' to the
depends in the subsystem. I did try the alterantive approach mentioned
in the reviews for v1 of this patch, where the subsystem Kconfig does
not add a '|| PCI' and each per-architecture Kconfig has to add a
'select HAS_RAPIDIO if PCI' and SoCs with IP blocks have to also add
'select HAS_RAPIDIO'. This works too but requires each architecture's
Kconfig to add the line for RapidIO (whereas current approach does not
require that involvement) and also may create a false impression that
the dependency on PCI is strict.

We appreciate the suggestion for also selecting the RapdiIO subsystem for
compilation with COMPILE_TEST, but hope to address it in a separate
patchset, localized to the subsystem, since it will need to change
depends on all drivers, not just on the top level, and since this
patch now spans multiple architectures.

Alexei Colin (6):
  rapidio: define top Kconfig menu in driver subtree
  x86: factor out RapidIO Kconfig menu
  powerpc: factor out RapidIO Kconfig menu entry
  mips: factor out RapidIO Kconfig entry
  arm: enable RapidIO menu in Kconfig
  arm64: enable RapidIO menu in Kconfig

 arch/arm/Kconfig        |  2 ++
 arch/arm64/Kconfig      |  2 ++
 arch/mips/Kconfig       | 11 -----------
 arch/powerpc/Kconfig    | 13 +------------
 arch/x86/Kconfig        |  8 --------
 drivers/rapidio/Kconfig | 15 +++++++++++++++
 6 files changed, 20 insertions(+), 31 deletions(-)

-- 
2.18.0
