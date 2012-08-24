Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A69192C00BD
 for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2012 20:59:23 +1000 (EST)
Message-ID: <1345805954.29170.36.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 Aug 2012 20:59:14 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

I meant to sent that earlier but got swamped with other things, so here
are some powerpc fixes for 3.6. A few regression fixes and some bug
fixes that I deemed should still make it.

There's a FSL update from Kumar with a bunch of defconfig updates along
with a few embedded fixes.

I also reverted my g5_defconfig update that I merged earlier as it was
completely busted, not too sure what happened there, I'll do a new one
later.

Cheers,
Ben.

The following changes since commit 0d7614f09c1ebdbaa1599a5aba7593f147bf96ee:

  Linux 3.6-rc1 (2012-08-02 16:38:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 2c39bf49fd05305bea6d70670855047b2191d3f5:

  Revert "powerpc: Update g5_defconfig" (2012-08-24 20:55:55 +1000)

----------------------------------------------------------------
Aaro Koskinen (1):
      powerpc/dma-iommu: Fix IOMMU window check

Anton Blanchard (2):
      powerpc: POWER7 copy_to_user/copy_from_user patch applied twice
      powerpc: Fix VMX in interrupt check in POWER7 copy loops

Benjamin Herrenschmidt (1):
      Revert "powerpc: Update g5_defconfig"

Jia Hongtao (1):
      powerpc/fsl-pci: Only scan PCI bus if configured as a host

Jiri Kosina (1):
      powerpc: Fix personality handling in ppc64_personality()

Kim Phillips (2):
      powerpc/fsl: update defconfigs
      powerpc/fsl: fix "Failed to mount /dev: No such device" errors

Michael Ellerman (2):
      powerpc: Fix xmon dl command for new printk implementation
      powerpc: Fixup whitespace in xmon

Michael Neuling (2):
      powerpc: Fix null pointer deref in perf hardware breakpoints
      powerpc: Remove unnecessary ifdefs

Scott Wood (1):
      powerpc/mpic_msgr: Add missing includes

Shengzhou Liu (1):
      powerpc/p4080ds: dts - add usb controller version info and port0

Sukadev Bhattiprolu (1):
      powerpc/perf: Use pmc_overflow() to detect rolled back events

Tiejun Chen (4):
      booke/wdt: some ioctls do not return values properly
      powerpc/kgdb: Do not set kgdb_single_step on ppc
      powerpc/kgdb: Bail out of KGDB when we've been triggered
      powerpc/kgdb: Restore current_thread_info properly

Zhao Chenhui (1):
      powerpc/85xx: mpc85xx_defconfig - add VIA PATA support for MPC85xxCDS

 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi  |    7 ++
 arch/powerpc/configs/85xx/p1023rds_defconfig |   31 +++-----
 arch/powerpc/configs/corenet32_smp_defconfig |   29 +++-----
 arch/powerpc/configs/corenet64_smp_defconfig |    1 +
 arch/powerpc/configs/g5_defconfig            |  103 ++++++++++++++++++--------
 arch/powerpc/configs/mpc83xx_defconfig       |   18 ++---
 arch/powerpc/configs/mpc85xx_defconfig       |   33 +++------
 arch/powerpc/configs/mpc85xx_smp_defconfig   |   32 ++------
 arch/powerpc/include/asm/cputable.h          |    2 -
 arch/powerpc/include/asm/mpic_msgr.h         |    1 +
 arch/powerpc/kernel/dma-iommu.c              |    9 +--
 arch/powerpc/kernel/hw_breakpoint.c          |    2 +-
 arch/powerpc/kernel/kgdb.c                   |   27 ++++++-
 arch/powerpc/kernel/syscalls.c               |    8 +-
 arch/powerpc/lib/copyuser_power7.S           |   35 +--------
 arch/powerpc/lib/memcpy_power7.S             |    4 +-
 arch/powerpc/perf/core-book3s.c              |    2 +-
 arch/powerpc/sysdev/fsl_pci.c                |   13 ++--
 arch/powerpc/sysdev/mpic_msgr.c              |    3 +
 arch/powerpc/xmon/xmon.c                     |   84 +++++++++------------
 drivers/watchdog/booke_wdt.c                 |    7 +-
 21 files changed, 209 insertions(+), 242 deletions(-)
