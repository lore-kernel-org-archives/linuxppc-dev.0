Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3skFMh6CpHzDrWR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Sep 2016 08:08:16 +1000 (AEST)
Date: Tue, 27 Sep 2016 17:08:04 -0500
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Message-ID: <20160927220804.GA19550@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Pull request: scottwood/linux.git next
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Highlights include qbman support (a prerequisite for datapath drivers
such as ethernet), a PCI DMA fix+improvement, reset handler changes, more
8xx optimizations, and some cleanups and fixes.

The following changes since commit f1a55ce0544251746d9b52fb85ad32f31a43fbd2:

  powerpc: Clean up tm_abort duplication in hash_utils_64.c (2016-09-23 07:54:23 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to e0b80f00bb96b925995d53980e0c764430bedb42:

  arch/powerpc: Add CONFIG_FSL_DPAA to corenetXX_smp_defconfig (2016-09-25 02:39:01 -0500)

----------------------------------------------------------------
Andrey Smirnov (6):
      powerpc/mpc85xx_mds: Select PHYLIB only if NETDEVICES is enabled
      powerpc/e8248e: Select PHYLIB only if NETDEVICES is enabled
      powerpc/sgy_cts1000: Fix gpio_halt_cb()'s signature
      powerpc: Factor out common code in setup-common.c
      powerpc: Call chained reset handlers during reset
      powerpc: Convert fsl_rstcr_restart to a reset handler

Christophe Leroy (9):
      powerpc32: Use instruction symbolic names in check_io_access()
      soc/fsl/qe: fix Oops on CPM1 (and likely CPM2)
      powerpc/8xx: use SPRN_EIE and SPRN_EID to enable/disable interrupts
      powerpc/8xx: add system_reset_exception
      powerpc/8xx: add dedicated machine check handler
      soc/fsl/qe: fix gpio save_regs functions
      powerpc/8xx: use r3 to scratch CR in ITLBmiss
      powerpc/8xx: Move additional DTLBMiss handlers out of exception area
      powerpc/8xx: make user addr DTLB miss the short path

Claudiu Manoil (5):
      soc/fsl: Introduce DPAA 1.x BMan device driver
      soc/fsl: Introduce DPAA 1.x QMan device driver
      soc/bman: Add self-test for BMan driver
      soc/qman: Add self-test for QMan driver
      arch/powerpc: Add CONFIG_FSL_DPAA to corenetXX_smp_defconfig

Julia Lawall (2):
      fsl/qe: use of_property_read_bool
      powerpc/mpic: use of_property_read_bool

Kevin Hao (1):
      powerpc/83xx: factor out the common codes of setup arch functions

Scott Wood (1):
      powerpc/fsl_pci: Size upper inbound window based on RAM size

Vaishali Thakkar (1):
      soc/fsl/qe: Use resource_size

Zhao Qiang (1):
      soc/fsl/qe: Use of_adress_to_resource() in get_qe_base()

 arch/powerpc/Makefile                         |    4 +-
 arch/powerpc/configs/dpaa.config              |    1 +
 arch/powerpc/include/asm/cputable.h           |    1 +
 arch/powerpc/include/asm/hw_irq.h             |    6 +
 arch/powerpc/include/asm/ppc-opcode.h         |    1 +
 arch/powerpc/include/asm/reg.h                |    2 +
 arch/powerpc/include/asm/reg_8xx.h            |    4 +
 arch/powerpc/kernel/cputable.c                |    1 +
 arch/powerpc/kernel/head_8xx.S                |  136 +-
 arch/powerpc/kernel/setup-common.c            |   27 +-
 arch/powerpc/kernel/traps.c                   |   45 +-
 arch/powerpc/platforms/82xx/Kconfig           |    4 +-
 arch/powerpc/platforms/82xx/ep8248e.c         |    4 +-
 arch/powerpc/platforms/83xx/asp834x.c         |    4 +-
 arch/powerpc/platforms/83xx/km83xx.c          |    5 +-
 arch/powerpc/platforms/83xx/misc.c            |    8 +
 arch/powerpc/platforms/83xx/mpc830x_rdb.c     |    5 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c     |    5 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c     |    5 +-
 arch/powerpc/platforms/83xx/mpc832x_rdb.c     |    5 +-
 arch/powerpc/platforms/83xx/mpc834x_itx.c     |    5 +-
 arch/powerpc/platforms/83xx/mpc834x_mds.c     |    5 +-
 arch/powerpc/platforms/83xx/mpc836x_mds.c     |    5 +-
 arch/powerpc/platforms/83xx/mpc836x_rdk.c     |    5 +-
 arch/powerpc/platforms/83xx/mpc837x_mds.c     |    5 +-
 arch/powerpc/platforms/83xx/mpc837x_rdb.c     |    5 +-
 arch/powerpc/platforms/83xx/mpc83xx.h         |    1 +
 arch/powerpc/platforms/83xx/sbc834x.c         |    5 +-
 arch/powerpc/platforms/85xx/Kconfig           |    2 +-
 arch/powerpc/platforms/85xx/bsc913x_qds.c     |    1 -
 arch/powerpc/platforms/85xx/bsc913x_rdb.c     |    1 -
 arch/powerpc/platforms/85xx/c293pcie.c        |    1 -
 arch/powerpc/platforms/85xx/corenet_generic.c |    1 -
 arch/powerpc/platforms/85xx/ge_imp3a.c        |    1 -
 arch/powerpc/platforms/85xx/mpc8536_ds.c      |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_ads.c     |    1 -
 arch/powerpc/platforms/85xx/mpc85xx_cds.c     |   25 +-
 arch/powerpc/platforms/85xx/mpc85xx_ds.c      |    3 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c     |   12 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c     |   10 -
 arch/powerpc/platforms/85xx/mvme2500.c        |    1 -
 arch/powerpc/platforms/85xx/p1010rdb.c        |    1 -
 arch/powerpc/platforms/85xx/p1022_ds.c        |    1 -
 arch/powerpc/platforms/85xx/p1022_rdk.c       |    1 -
 arch/powerpc/platforms/85xx/p1023_rdb.c       |    1 -
 arch/powerpc/platforms/85xx/ppa8548.c         |    1 -
 arch/powerpc/platforms/85xx/qemu_e500.c       |    1 -
 arch/powerpc/platforms/85xx/sbc8548.c         |    1 -
 arch/powerpc/platforms/85xx/sgy_cts1000.c     |    8 +-
 arch/powerpc/platforms/85xx/socrates.c        |    1 -
 arch/powerpc/platforms/85xx/stx_gp3.c         |    1 -
 arch/powerpc/platforms/85xx/tqm85xx.c         |    1 -
 arch/powerpc/platforms/85xx/twr_p102x.c       |    1 -
 arch/powerpc/platforms/85xx/xes_mpc85xx.c     |    3 -
 arch/powerpc/platforms/86xx/gef_ppc9a.c       |    1 -
 arch/powerpc/platforms/86xx/gef_sbc310.c      |    1 -
 arch/powerpc/platforms/86xx/gef_sbc610.c      |    1 -
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c    |    1 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c    |    1 -
 arch/powerpc/platforms/86xx/mvme7100.c        |    1 -
 arch/powerpc/platforms/86xx/sbc8641d.c        |    1 -
 arch/powerpc/sysdev/cpm1.c                    |    2 -
 arch/powerpc/sysdev/cpm2.c                    |    4 -
 arch/powerpc/sysdev/cpm_common.c              |   15 +
 arch/powerpc/sysdev/fsl_pci.c                 |   12 +-
 arch/powerpc/sysdev/fsl_soc.c                 |   33 +-
 arch/powerpc/sysdev/fsl_soc.h                 |    2 -
 arch/powerpc/sysdev/mpic.c                    |    2 +-
 drivers/soc/Kconfig                           |    1 +
 drivers/soc/fsl/Makefile                      |    1 +
 drivers/soc/fsl/qbman/Kconfig                 |   67 +
 drivers/soc/fsl/qbman/Makefile                |   12 +
 drivers/soc/fsl/qbman/bman.c                  |  797 +++++++
 drivers/soc/fsl/qbman/bman_ccsr.c             |  263 +++
 drivers/soc/fsl/qbman/bman_portal.c           |  219 ++
 drivers/soc/fsl/qbman/bman_priv.h             |   80 +
 drivers/soc/fsl/qbman/bman_test.c             |   53 +
 drivers/soc/fsl/qbman/bman_test.h             |   35 +
 drivers/soc/fsl/qbman/bman_test_api.c         |  151 ++
 drivers/soc/fsl/qbman/dpaa_sys.h              |  103 +
 drivers/soc/fsl/qbman/qman.c                  | 2881 +++++++++++++++++++++++++
 drivers/soc/fsl/qbman/qman_ccsr.c             |  808 +++++++
 drivers/soc/fsl/qbman/qman_portal.c           |  355 +++
 drivers/soc/fsl/qbman/qman_priv.h             |  371 ++++
 drivers/soc/fsl/qbman/qman_test.c             |   62 +
 drivers/soc/fsl/qbman/qman_test.h             |   36 +
 drivers/soc/fsl/qbman/qman_test_api.c         |  252 +++
 drivers/soc/fsl/qbman/qman_test_stash.c       |  617 ++++++
 drivers/soc/fsl/qe/gpio.c                     |    3 +-
 drivers/soc/fsl/qe/qe.c                       |   10 +-
 drivers/soc/fsl/qe/qe_common.c                |    8 +
 drivers/soc/fsl/qe/qe_tdm.c                   |    4 +-
 include/soc/fsl/bman.h                        |  129 ++
 include/soc/fsl/qman.h                        | 1074 +++++++++
 94 files changed, 8612 insertions(+), 248 deletions(-)
 create mode 100644 arch/powerpc/configs/dpaa.config
 create mode 100644 drivers/soc/fsl/qbman/Kconfig
 create mode 100644 drivers/soc/fsl/qbman/Makefile
 create mode 100644 drivers/soc/fsl/qbman/bman.c
 create mode 100644 drivers/soc/fsl/qbman/bman_ccsr.c
 create mode 100644 drivers/soc/fsl/qbman/bman_portal.c
 create mode 100644 drivers/soc/fsl/qbman/bman_priv.h
 create mode 100644 drivers/soc/fsl/qbman/bman_test.c
 create mode 100644 drivers/soc/fsl/qbman/bman_test.h
 create mode 100644 drivers/soc/fsl/qbman/bman_test_api.c
 create mode 100644 drivers/soc/fsl/qbman/dpaa_sys.h
 create mode 100644 drivers/soc/fsl/qbman/qman.c
 create mode 100644 drivers/soc/fsl/qbman/qman_ccsr.c
 create mode 100644 drivers/soc/fsl/qbman/qman_portal.c
 create mode 100644 drivers/soc/fsl/qbman/qman_priv.h
 create mode 100644 drivers/soc/fsl/qbman/qman_test.c
 create mode 100644 drivers/soc/fsl/qbman/qman_test.h
 create mode 100644 drivers/soc/fsl/qbman/qman_test_api.c
 create mode 100644 drivers/soc/fsl/qbman/qman_test_stash.c
 create mode 100644 include/soc/fsl/bman.h
 create mode 100644 include/soc/fsl/qman.h
