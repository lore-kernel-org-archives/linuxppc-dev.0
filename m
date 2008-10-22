Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3997DDDDED
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 16:02:08 +1100 (EST)
Subject: [git pull] Please pull from powerpc.git next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 22 Oct 2008 16:01:57 +1100
Message-Id: <1224651717.7654.332.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus !

Here's some additions to yesterday's pull request. Mostly things that
slipped through the cracks, for example, for the hvc_console work
there was some confusion as to who was going to merge it, and the
kdump bits I mentioned yesterday that were getting some
rebasing/massaging. The rest is either trivial enough or bug fixes,

That should now bit it for the "features" for this merge window

The following changes since commit a02efb906d12c9d4eb2ab7c59049ba9545e5412d:
  Benjamin Herrenschmidt (1):
        Merge commit 'origin' into master

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git master

Becky Bruce (1):
      powerpc: Move memory size print into common show_cpuinfo for 32-bit

David Gibson (1):
      powerpc: Further compile fixup for STRICT_MM_TYPECHECKS

Hendrik Brueckner (5):
      hvc_console: Add a hangup notifier for backends
      hvc_console: Add tty driver flag TTY_DRIVER_RESET_TERMIOS
      hvc_console: Fix loop if put_char() returns 0
      hvc_console: Add support for tty window resizing
      hvc_console: Remove __devexit annotation of hvc_remove()

Jon Tollefson (1):
      powerpc: Don't use a 16G page if beyond mem= limits

Michael Neuling (1):
      powerpc: Remove empty #else from signal_64.c

Mike Ditto (1):
      powerpc: Add del_node() for early boot code to prune inapplicable devices.

Mohan Kumar M (1):
      powerpc: Support for relocatable kdump kernel

 Documentation/kdump/kdump.txt                  |   14 +++-
 arch/powerpc/Kconfig                           |   10 +--
 arch/powerpc/boot/libfdt-wrapper.c             |    6 ++
 arch/powerpc/boot/ops.h                        |    6 ++
 arch/powerpc/include/asm/kdump.h               |   17 +++--
 arch/powerpc/kernel/crash_dump.c               |    2 +
 arch/powerpc/kernel/head_64.S                  |   39 +++++++++--
 arch/powerpc/kernel/iommu.c                    |   69 ++++++++++---------
 arch/powerpc/kernel/machine_kexec.c            |    2 +
 arch/powerpc/kernel/machine_kexec_64.c         |   13 +++-
 arch/powerpc/kernel/misc_64.S                  |    9 ++-
 arch/powerpc/kernel/pci-common.c               |    3 +-
 arch/powerpc/kernel/setup-common.c             |    7 ++
 arch/powerpc/kernel/signal_64.c                |    2 -
 arch/powerpc/mm/hash_utils_64.c                |    6 +-
 arch/powerpc/platforms/85xx/ksi8560.c          |    4 -
 arch/powerpc/platforms/85xx/mpc85xx_ads.c      |    4 -
 arch/powerpc/platforms/85xx/mpc85xx_cds.c      |    4 -
 arch/powerpc/platforms/85xx/sbc8548.c          |    4 -
 arch/powerpc/platforms/85xx/sbc8560.c          |    4 -
 arch/powerpc/platforms/85xx/stx_gp3.c          |    4 -
 arch/powerpc/platforms/85xx/tqm85xx.c          |    4 -
 arch/powerpc/platforms/86xx/gef_sbc610.c       |    2 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c     |    2 -
 arch/powerpc/platforms/86xx/sbc8641d.c         |    2 -
 arch/powerpc/platforms/cell/ras.c              |    6 +-
 arch/powerpc/platforms/embedded6xx/c2k.c       |    3 -
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |    3 -
 arch/powerpc/platforms/pseries/iommu.c         |    6 +-
 drivers/char/hvc_console.c                     |   86 ++++++++++++++++++++----
 drivers/char/hvc_console.h                     |   12 +++-
 drivers/char/hvc_irq.c                         |    5 ++
 drivers/char/hvc_iseries.c                     |    1 +
 drivers/char/hvc_vio.c                         |    1 +
 drivers/char/hvc_xen.c                         |    1 +
 drivers/char/virtio_console.c                  |    1 +
 36 files changed, 238 insertions(+), 126 deletions(-)
