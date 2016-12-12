Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tcbLK3Ch3zDvhD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Dec 2016 19:17:44 +1100 (AEDT)
Date: Mon, 12 Dec 2016 02:17:31 -0600
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org
Message-ID: <20161212081731.GA31497@home.buserror.net>
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

Highlights include 8xx hugepage support, qbman fixes/cleanup, device
tree updates, and some misc cleanup.

The following changes since commit 555c16328ae6d75a90e234eac9b51998d68f185b:

  powerpc/mm: Correct process and partition table max size (2016-11-17 17:11:53 +1100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to baae856ebdeeaefbadd4a02cdb54b7c2277ff4dd:

  powerpc/fsl/dts: add FMan node for t1042d4rdb (2016-12-09 23:11:17 -0600)

----------------------------------------------------------------
Andy Fleming (1):
      powerpc/85xx: Enable gpio power/reset driver

Christophe Leroy (3):
      powerpc: port 64 bits pgtable_cache to 32 bits
      powerpc: get hugetlbpage handling more generic
      powerpc/8xx: Implement support of hugepages

Claudiu Manoil (15):
      soc/qman: Fix h/w resource cleanup error path handling
      soc/qbman: Fix resource leak on portal probing error path
      soc/qman: Fix struct qm_fqd set accessor for context_a
      soc/qman: Fix direct access to fd's addr_lo, use proper accesor
      soc/qman: test: Fix implementation of fd_cmp()
      soc/qman: Don't add a new platform device for dma mapping
      soc/qman: test: Don't use dummy platform device for dma mapping
      soc/qman: Remove redundant checks from qman_create_cgr()
      soc/qman: Remove unused struct qm_mcc* layouts
      soc/qman: Fix accesses to fqid, cleanup
      soc/qman: Drop unused field from eqcr/dqrr descriptors
      soc/qbman: Handle endianness of qm/bm_in/out()
      soc/qman: Change remaining contextB into context_b
      soc/qman: Clean up CGR CSCN target update operations
      soc/qman: Handle endianness of h/w descriptors

Colin Ian King (1):
      soc/fsl: fix spelling mistakes in critical error messages

David Engraf (1):
      powerpc/85xx/qemu: Enable CONFIG_E500 and CONFIG_PPC_E500MC

Fabian Frederick (2):
      powerpc/fsl-lbc: use DEFINE_SPINLOCK()
      soc/fsl/qman: test: use DEFINE_SPINLOCK()

Florian Larysch (2):
      DT: i2c: W83793 is a trivial device
      powerpc/dts: add device tree entry for W83793 on T4240RDB

Geliang Tang (3):
      powerpc/83xx/suspend: use builtin_platform_driver
      powerpc/fsl_pmc: use builtin_platform_driver
      soc/fsl/qe: use builtin_platform_driver

Heiner Kallweit (3):
      powerpc/fsl_soc: improve and simplify fsl_get_sys_freq
      powerpc/fsl_soc: improve and simplify get_brgfreq
      powerpc/fsl_soc: improve and simplify get_baudrate

Madalin Bucur (6):
      soc/qman: Check ioremap return value
      soc/qman: Replace of_get_property() with portable equivalent
      powerpc/fsl/dts: add QMan and BMan nodes on t1023
      powerpc/fsl/dts: add QMan and BMan nodes on t1024
      powerpc/fsl/dts: add sg_2500_aqr105_phy4 alias on t1024rdb
      powerpc/fsl/dts: add FMan node for t1042d4rdb

Wei Yongjun (1):
      soc/fsl/bman: Use resource_size instead of computation

 .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
 arch/powerpc/boot/dts/fsl/t1023rdb.dts             |  29 +++
 arch/powerpc/boot/dts/fsl/t1023si-post.dtsi        | 103 +++++++++
 arch/powerpc/boot/dts/fsl/t1024qds.dts             |  29 +++
 arch/powerpc/boot/dts/fsl/t1024rdb.dts             |  33 +++
 arch/powerpc/boot/dts/fsl/t1042d4rdb.dts           |  52 +++++
 arch/powerpc/boot/dts/fsl/t4240rdb.dts             |   4 +
 arch/powerpc/configs/fsl-emb-nonhw.config          |   6 +
 arch/powerpc/include/asm/book3s/32/pgalloc.h       |  44 +++-
 arch/powerpc/include/asm/book3s/32/pgtable.h       |  40 ++--
 arch/powerpc/include/asm/book3s/64/pgtable.h       |   3 -
 arch/powerpc/include/asm/hugetlb.h                 |  19 +-
 arch/powerpc/include/asm/mmu-8xx.h                 |  35 ++++
 arch/powerpc/include/asm/mmu.h                     |  23 +-
 arch/powerpc/include/asm/nohash/32/pgalloc.h       |  44 +++-
 arch/powerpc/include/asm/nohash/32/pgtable.h       |  42 ++--
 arch/powerpc/include/asm/nohash/32/pte-8xx.h       |   1 +
 arch/powerpc/include/asm/nohash/64/pgtable.h       |   2 -
 arch/powerpc/include/asm/nohash/pgtable.h          |   4 +
 arch/powerpc/include/asm/pgtable.h                 |   2 +
 arch/powerpc/include/asm/reg_8xx.h                 |   2 +-
 arch/powerpc/kernel/head_8xx.S                     | 119 ++++++++++-
 arch/powerpc/mm/Makefile                           |   3 +-
 arch/powerpc/mm/hugetlbpage.c                      | 216 +++++++++----------
 arch/powerpc/mm/init-common.c                      | 107 ++++++++++
 arch/powerpc/mm/init_64.c                          |  77 -------
 arch/powerpc/mm/pgtable_32.c                       |  37 ----
 arch/powerpc/mm/tlb_nohash.c                       |  21 +-
 arch/powerpc/platforms/83xx/suspend.c              |   6 +-
 arch/powerpc/platforms/85xx/Kconfig                |   2 +
 arch/powerpc/platforms/8xx/Kconfig                 |   1 +
 arch/powerpc/platforms/Kconfig.cputype             |   1 +
 arch/powerpc/sysdev/fsl_lbc.c                      |   2 +-
 arch/powerpc/sysdev/fsl_pmc.c                      |   6 +-
 arch/powerpc/sysdev/fsl_soc.c                      |  48 ++---
 drivers/soc/fsl/qbman/bman.c                       |   8 +-
 drivers/soc/fsl/qbman/bman_ccsr.c                  |   3 +-
 drivers/soc/fsl/qbman/bman_portal.c                |  17 +-
 drivers/soc/fsl/qbman/dpaa_sys.h                   |   1 +
 drivers/soc/fsl/qbman/qman.c                       | 233 ++++++++++-----------
 drivers/soc/fsl/qbman/qman_ccsr.c                  |   3 +
 drivers/soc/fsl/qbman/qman_portal.c                |  41 +++-
 drivers/soc/fsl/qbman/qman_priv.h                  |  17 +-
 drivers/soc/fsl/qbman/qman_test_api.c              |  27 +--
 drivers/soc/fsl/qbman/qman_test_stash.c            |  38 ++--
 drivers/soc/fsl/qe/qe.c                            |   6 +-
 include/soc/fsl/qman.h                             |  62 +++---
 47 files changed, 1040 insertions(+), 580 deletions(-)
 create mode 100644 arch/powerpc/mm/init-common.c
