Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 75AC3B6FD3
 for <linuxppc-dev@ozlabs.org>; Mon, 23 Apr 2012 12:04:24 +1000 (EST)
Message-ID: <1335146650.21619.3.camel@pasglop>
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Apr 2012 12:04:10 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus !

Here are a few fixes for powerpc. Note the addition to the generic
irq.h. This is part of a 3-patches regression fix for mpic due to
changes in how IRQ_TYPE_NONE is being handled. Thomas agreed to the
addition of the new IRQ_TYPE_DEFAULT contant, however he hasn't
replied with an Ack to the actual patch yet. I don't to wait much
longer with these patches tho.

Cheers,
Ben.

The following changes since commit 932e9f352b5d685725076f21b237f7c7d804b29c:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security (2012-04-18 20:16:02 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

for you to fetch changes up to 446f6d06fab0b49c61887ecbe8286d6aaa796637:

  powerpc/mpic: Properly set default triggers (2012-04-23 11:04:30 +1000)

----------------------------------------------------------------
Baruch Siach (1):
      powerpc: fix build when CONFIG_BOOKE_WDT is enabled

Benjamin Herrenschmidt (5):
      Merge remote-tracking branch 'kumar/merge' into merge
      powerpc/pmac: Don't add_timer() twice
      powerpc/mpic: Fix confusion between hw_irq and virq
      irq: Add IRQ_TYPE_DEFAULT for use by PIC drivers
      powerpc/mpic: Properly set default triggers

Gavin Shan (1):
      powerpc/eeh: Fix crash caused by null eeh_dev

Mingkai Hu (4):
      powerpc/mpic_msgr: fix compile error when SMP disabled
      powerpc/mpic_msgr: add lock for MPIC message global variable
      powerpc/mpic_msgr: fix offset error when setting mer register
      powerpc/mpc85xx: add MPIC message dts node

Timur Tabi (1):
      powerpc/85xx: don't call of_platform_bus_probe() twice

 arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi |   43 ++++++++++++++++
 arch/powerpc/boot/dts/fsl/pq3-mpic.dtsi           |   10 ++++
 arch/powerpc/include/asm/mpic.h                   |   18 -------
 arch/powerpc/include/asm/mpic_msgr.h              |    1 +
 arch/powerpc/include/asm/reg_booke.h              |    5 --
 arch/powerpc/kernel/setup_32.c                    |    3 ++
 arch/powerpc/platforms/85xx/common.c              |    6 +++
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |   11 +----
 arch/powerpc/platforms/85xx/p1022_ds.c            |   13 +----
 arch/powerpc/platforms/powermac/low_i2c.c         |    9 ++++
 arch/powerpc/platforms/pseries/eeh.c              |    2 +-
 arch/powerpc/sysdev/mpic.c                        |   54 +++++++++++++--------
 arch/powerpc/sysdev/mpic_msgr.c                   |   12 ++---
 include/linux/irq.h                               |    7 +++
 14 files changed, 122 insertions(+), 72 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/fsl/pq3-mpic-message-B.dtsi
