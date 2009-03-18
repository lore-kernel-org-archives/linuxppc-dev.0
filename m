Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4DC83DDED9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Mar 2009 15:14:11 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 18 Mar 2009 15:11:07 +1100
Message-Id: <1237349467.25062.311.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Linus !

So here's the new ps3 nvram driver for 2.6.29 that we discussed earlier
(I actually sent this days ago but screwed up the email by not actually
sending it to you :-)

In the meantime I've added a PS3 defconfig update and two patches fixing
another fallout from the changes to the way we handle the coherent bit
in our PTEs. Hopefully there should be no more regressions in that area.

Cheers,
Ben.

The following changes since commit ee568b25ee9e160b32d1aef73d8b2ee9c05d34db:
  Linus Torvalds (1):
        Avoid 64-bit "switch()" statements on 32-bit architectures

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (1):
      Merge commit 'gcl/merge' into merge

Geert Uytterhoeven (1):
      ps3/block: Replace mtd/ps3vram by block/ps3vram

Geoff Levand (1):
      powerpc/ps3: ps3_defconfig updates

Kumar Gala (1):
      powerpc/mm: Respect _PAGE_COHERENT on classic ppc32 SW

Piotr Ziecik (1):
      powerpc/5200: Enable CPU_FTR_NEED_COHERENT for MPC52xx

 arch/powerpc/configs/ps3_defconfig  |  250 ++++++++---
 arch/powerpc/include/asm/cputable.h |    4 +-
 arch/powerpc/kernel/head_32.S       |    6 +-
 arch/powerpc/platforms/ps3/Kconfig  |    7 +
 drivers/block/Makefile              |    1 +
 drivers/block/ps3vram.c             |  865 +++++++++++++++++++++++++++++++++++
 drivers/mtd/devices/Kconfig         |    7 -
 drivers/mtd/devices/Makefile        |    1 -
 drivers/mtd/devices/ps3vram.c       |  768 -------------------------------
 9 files changed, 1069 insertions(+), 840 deletions(-)
 create mode 100644 drivers/block/ps3vram.c
 delete mode 100644 drivers/mtd/devices/ps3vram.c
