Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6865C2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jul 2013 09:44:33 +1000 (EST)
Date: Mon, 1 Jul 2013 18:43:10 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git next
Message-ID: <20130701234310.GA22106@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Note to contributors: This is only a fraction of the outstanding patches
for FSL PPC.  I haven't been able to process the entire backlog since
starting to help Kumar with this a few weeks ago.  If your patch is still
"action required" in patchwork, I haven't forgotten it -- but it will not
make it into this merge window.

The following changes since commit 1a5272866f87d7fbf04dc8060f8da3e8456490ab:

  powerpc: Optimize hugepage invalidate (2013-06-21 16:01:58 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to a63b3bc7db32b63bfe5f48fa8582f931db81c86e:

  powerpc/fsl: add MPIC timer wakeup support (2013-07-01 18:38:42 -0500)

----------------------------------------------------------------
Chunhe Lan (1):
      powerpc/fsl: Enable CONFIG_E1000E in mpc85xx_smp_defconfig

Dongsheng.wang@freescale.com (4):
      powerpc/mpic: add irq_set_wake support
      powerpc/mpic: add global timer support
      powerpc/mpic: create mpic subsystem object
      powerpc/fsl: add MPIC timer wakeup support

Hongtao Jia (1):
      powerpc/mpic: Add get_version API both for internal and external use

Joe Liccese (1):
      powerpc: Add T4 LAC device tree binding & defs

Kevin Hao (1):
      powerpc/85xx: enable coreint for all the 64bit boards

LEROY Christophe (1):
      powerpc/8xx: Erroneous double irq_eoi() on CPM IRQ in MPC8xx

Sachin Surendran (1):
      i2c-cpm: Fix to takeback i2c bus master-ship after a collision

Tudor Laurentiu (1):
      powerpc/watchdog: Don't enable interrupt on PPC64 BookE

Wei Yongjun (1):
      powerpc/83xx: use module_i2c_driver to simplify the code

 .../bindings/powerpc/fsl/interlaken-lac.txt        | 309 +++++++++++
 .../boot/dts/fsl/interlaken-lac-portals.dtsi       | 156 ++++++
 arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi      |  45 ++
 arch/powerpc/configs/mpc85xx_smp_defconfig         |   1 +
 arch/powerpc/include/asm/mpic.h                    |   5 +
 arch/powerpc/include/asm/mpic_timer.h              |  46 ++
 arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c     |  12 +-
 arch/powerpc/platforms/85xx/p5020_ds.c             |   5 -
 arch/powerpc/platforms/85xx/p5040_ds.c             |   5 -
 arch/powerpc/platforms/85xx/t4240_qds.c            |   5 -
 arch/powerpc/platforms/8xx/m8xx_setup.c            |  13 +-
 arch/powerpc/platforms/Kconfig                     |  21 +
 arch/powerpc/sysdev/Makefile                       |   2 +
 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c        | 161 ++++++
 arch/powerpc/sysdev/mpic.c                         |  58 +-
 arch/powerpc/sysdev/mpic_timer.c                   | 593 +++++++++++++++++++++
 drivers/i2c/busses/i2c-cpm.c                       |   8 +
 drivers/watchdog/booke_wdt.c                       |   8 +
 18 files changed, 1410 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/interlaken-lac.txt
 create mode 100644 arch/powerpc/boot/dts/fsl/interlaken-lac-portals.dtsi
 create mode 100644 arch/powerpc/boot/dts/fsl/interlaken-lac.dtsi
 create mode 100644 arch/powerpc/include/asm/mpic_timer.h
 create mode 100644 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c
 create mode 100644 arch/powerpc/sysdev/mpic_timer.c
