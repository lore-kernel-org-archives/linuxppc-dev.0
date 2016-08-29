Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMzZJ6NbXzDrgZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 14:44:08 +1000 (AEST)
Message-ID: <1472445840.2889.99.camel@kernel.crashing.org>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-4.8-4 tag
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc dev list
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 29 Aug 2016 14:44:00 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

So my appologies for being a lousy replacement maintainer while Michael
is on vacation ... this was meant to be sent early last week, but I
has a change pending on one of the fixes and other things made me forget
all about. Ugh.

This is my first signed-tag and use of 2fa so I hope I got it all right...
I tried to use the same format Michael uses for the tag etc...

We have some misc fixes for powerpc 4.8. Some trivial bits and some
regressions, and a trivial cleanup or two that I saw no point in letting
rot in patchwork.

Cheers,
Ben.

The following changes since commit fa8410b355251fd30341662a40ac6b22d3e38468:

  Linux 4.8-rc3 (2016-08-21 16:14:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-4.8-4

for you to fetch changes up to 78a3e8889b4b6b99775ed954696ff3e017f5d19b:

  powerpc: signals: Discard transaction state from signal frames (2016-08-29 12:48:40 +1000)

----------------------------------------------------------------

Andrew Donnellan (1):
      cxl: use pcibios_free_controller_deferred() when removing vPHBs

Andrzej Hajda (1):
      powerpc/powernv/pci: fix iterator signedness

Boqun Feng (1):
      powerpc, hotplug: Avoid to touch non-existent cpumasks.

Christophe Leroy (1):
      powerpc: sysdev: cpm: fix gpio save_regs functions

Cyril Bur (1):
      powerpc: signals: Discard transaction state from signal frames

Guenter Roeck (1):
      powerpc: cputhreads: Add missing include file

Markus Elfring (3):
      drivers/macintosh: Delete owner assignment
      powerpc/512x: Delete unnecessary assignment for the field "owner"
      powerpc: mpc8349emitx: Delete unnecessary assignment for the field "owner"

Mauricio Faria de Oliveira (1):
      powerpc/pseries: use pci_host_bridge.release_fn() to kfree(phb)

Michael Ellerman (1):
      powerpc/prom: Fix sub-processor option passed to ibm, client-architecture-support

Mukesh Ojha (1):
      powerpc/powernv : Drop reference added by kset_find_obj()

Nicholas Piggin (3):
      powerpc/pseries: PACA save area fix for general exception vs MCE
      powerpc/pseries: PACA save area fix for MCE vs MCE
      powerpc/tm: do not use r13 for tabort_syscall

Paolo Bonzini (1):
      powerpc: move hmi.c to arch/powerpc/kvm/

Paul Gortmaker (1):
      powerpc: migrate exception table users off module.h and onto extable.h

 Documentation/powerpc/transactional_memory.txt     |  2 ++
 arch/powerpc/include/asm/cputhreads.h              |  1 +
 arch/powerpc/include/asm/hmi.h                     |  2 +-
 arch/powerpc/include/asm/paca.h                    | 12 +++++---
 arch/powerpc/include/asm/pci-bridge.h              |  1 +
 arch/powerpc/kernel/Makefile                       |  2 +-
 arch/powerpc/kernel/entry_64.S                     | 12 ++++----
 arch/powerpc/kernel/exceptions-64s.S               | 29 ++++++++++++++---
 arch/powerpc/kernel/kprobes.c                      |  2 +-
 arch/powerpc/kernel/pci-common.c                   | 36 ++++++++++++++++++++++
 arch/powerpc/kernel/prom_init.c                    |  9 ++++--
 arch/powerpc/kernel/signal_32.c                    | 14 +++++++++
 arch/powerpc/kernel/signal_64.c                    | 14 +++++++++
 arch/powerpc/kernel/smp.c                          |  2 +-
 arch/powerpc/kernel/traps.c                        |  3 +-
 arch/powerpc/kvm/Makefile                          |  1 +
 arch/powerpc/{kernel/hmi.c => kvm/book3s_hv_hmi.c} |  0
 arch/powerpc/mm/fault.c                            |  2 +-
 arch/powerpc/platforms/512x/mpc512x_lpbfifo.c      |  1 -
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c     |  1 -
 arch/powerpc/platforms/embedded6xx/holly.c         |  2 +-
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c  |  2 +-
 arch/powerpc/platforms/powernv/opal-dump.c         |  7 ++++-
 arch/powerpc/platforms/powernv/opal-elog.c         |  7 ++++-
 arch/powerpc/platforms/powernv/pci-ioda.c          |  2 +-
 arch/powerpc/platforms/pseries/pci.c               |  4 +++
 arch/powerpc/platforms/pseries/pci_dlpar.c         |  7 +++--
 arch/powerpc/sysdev/cpm1.c                         |  6 ++--
 arch/powerpc/sysdev/cpm_common.c                   |  3 +-
 arch/powerpc/sysdev/fsl_rio.c                      |  2 +-
 drivers/macintosh/ams/ams-i2c.c                    |  1 -
 drivers/macintosh/windfarm_pm112.c                 |  1 -
 drivers/macintosh/windfarm_pm72.c                  |  1 -
 drivers/macintosh/windfarm_rm31.c                  |  1 -
 drivers/misc/cxl/vphb.c                            | 10 +++++-
 drivers/pci/host-bridge.c                          |  1 +
 36 files changed, 160 insertions(+), 43 deletions(-)
 rename arch/powerpc/{kernel/hmi.c => kvm/book3s_hv_hmi.c} (100%)
