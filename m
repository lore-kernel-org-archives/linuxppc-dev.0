Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0104.outbound.protection.outlook.com [65.55.169.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ACF3A1A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 14:30:21 +1000 (AEST)
Date: Mon, 17 Aug 2015 23:30:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: <benh@kernel.crashing.org>, Michael Ellerman <mpe@ellerman.id.au>
CC: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: Pull request: scottwood/linux.git next
Message-ID: <20150818043004.GA29954@home.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Highlights include 32-bit memcpy/memset optimizations, checksum
optimizations, 85xx config fragments and updates, device tree updates,
e6500 fixes for non-SMP, and misc cleanup and minor fixes.

The following changes since commit 79cd95200035fb4b39b089dd01c13302eee6ee03:

  powerpc/eeh: Dump PHB diag-data for non-existing PE (2015-07-21 11:38:47 +1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git next

for you to fetch changes up to 4524cd093fa8f03b198e095ebbb679c30839559c:

  powerpc/t1023rdb/dts: set ifc nand chip select from 2 to 1 (2015-08-17 19:41:16 -0500)

----------------------------------------------------------------
Hou Zhiqiang (1):
      powerpc/85xx: Remove unused pci fixup hooks on c293pcie

Jaiprakash Singh (2):
      fsl_ifc: Change IO accessor based on endianness
      powerpc/t1023rdb/dts: set ifc nand chip select from 2 to 1

Jason Jin (1):
      powerpc: Add a vga alias node for P1022

Kevin Hao (2):
      powerpc/e6500: remove the stale TCD_LOCK macro
      powerpc/e6500: hw tablewalk: optimize a bit for tcd lock acquiring codes

LEROY Christophe (8):
      powerpc: put csum_tcpudp_magic inline
      powerpc: add support for csum_add()
      powerpc: use memset_io() to clear CPM Muram
      Partially revert "powerpc: Remove duplicate cacheable_memcpy/memzero functions"
      powerpc/32: memset(0): use cacheable_memzero
      powerpc/32: Merge the new memset() with the old one
      powerpc/32: cacheable_memcpy becomes memcpy
      powerpc/32: Few optimisations in memcpy

Michael Ellerman (1):
      powerpc: Update corenet32_smp_defconfig for modern distros

Priyanka Jain (1):
      powerpc/fsl-booke: Add T1040D4RDB/T1042D4RDB board support

Scott Wood (5):
      powerpc/85xx: Make defconfigs consistent
      powerpc/85xx: Use kconfig fragments
      powerpc/mm: Don't call __flush_dcache_icache_phys() with PA>VA
      powerpc/booke64: Move mb() to __set_pte_at() with kernel-addr test
      powerpc/fsl: Force coherent memory on e500mc derivatives

Shaohui Xie (2):
      powerpc/85xx: enable teranetics PHY
      powerpc/config: enable aquantia PHY

Shengzhou Liu (2):
      powerpc/t1024rdb: add ina220 current sensor node
      powerpc/t1023rdb: add ina220 current sensor node

Wang Dongsheng (2):
      powerpc/85xx: Add binding for SCFG
      powerpc/mpc85xx:Add SCFG device tree support of T104x

Yangbo Lu (1):
      powerpc/corenet: enable eSDHC

Yao Yuan (1):
      powerpc/corenet32: enable DMA in defconfig

 .../bindings/memory-controllers/fsl/ifc.txt        |   3 +
 .../devicetree/bindings/powerpc/fsl/scfg.txt       |  18 ++
 arch/powerpc/Makefile                              |  20 ++
 arch/powerpc/boot/dts/fsl/p1022si-post.dtsi        |   2 +-
 arch/powerpc/boot/dts/fsl/p1022si-pre.dtsi         |   2 +
 arch/powerpc/boot/dts/fsl/t1040si-post.dtsi        |   5 +
 arch/powerpc/boot/dts/t1023rdb.dts                 |  13 +-
 arch/powerpc/boot/dts/t1024rdb.dts                 |   6 +
 arch/powerpc/boot/dts/t1040d4rdb.dts               |  46 ++++
 arch/powerpc/boot/dts/t1042d4rdb.dts               |  53 +++++
 arch/powerpc/boot/dts/t104xd4rdb.dtsi              | 205 ++++++++++++++++
 arch/powerpc/configs/85xx-32bit.config             |   5 +
 arch/powerpc/configs/85xx-64bit.config             |   4 +
 arch/powerpc/configs/85xx-hw.config                | 142 +++++++++++
 arch/powerpc/configs/85xx-smp.config               |   2 +
 arch/powerpc/configs/altivec.config                |   1 +
 arch/powerpc/configs/corenet32_smp_defconfig       | 185 ---------------
 arch/powerpc/configs/corenet_basic_defconfig       |   1 +
 ...orenet64_smp_defconfig => fsl-emb-nonhw.config} | 264 +++++++++------------
 arch/powerpc/configs/mpc85xx_basic_defconfig       |  23 ++
 arch/powerpc/configs/mpc85xx_defconfig             | 252 --------------------
 arch/powerpc/configs/mpc85xx_smp_defconfig         | 244 -------------------
 arch/powerpc/include/asm/cacheflush.h              |   7 +-
 arch/powerpc/include/asm/checksum.h                |  37 ++-
 arch/powerpc/include/asm/pgtable.h                 |  11 +
 arch/powerpc/include/asm/pte-common.h              |   3 +-
 arch/powerpc/kernel/asm-offsets.c                  |   1 -
 arch/powerpc/kernel/exceptions-64e.S               |  13 +-
 arch/powerpc/kernel/fsl_booke_entry_mapping.S      |  15 +-
 arch/powerpc/lib/checksum_32.S                     |  16 --
 arch/powerpc/lib/checksum_64.S                     |  21 --
 arch/powerpc/lib/copy_32.S                         | 109 ++++++++-
 arch/powerpc/mm/fsl_booke_mmu.c                    |   2 +-
 arch/powerpc/mm/mem.c                              |  14 +-
 arch/powerpc/mm/pgtable_64.c                       |  10 -
 arch/powerpc/mm/tlb_low_64e.S                      |  10 +-
 arch/powerpc/platforms/85xx/c293pcie.c             |   4 -
 arch/powerpc/platforms/85xx/corenet_generic.c      |   2 +
 arch/powerpc/sysdev/cpm_common.c                   |   2 +-
 drivers/memory/fsl_ifc.c                           |  43 +++-
 drivers/mtd/nand/fsl_ifc_nand.c                    | 258 ++++++++++----------
 include/linux/fsl_ifc.h                            |  50 ++++
 42 files changed, 1054 insertions(+), 1070 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/powerpc/fsl/scfg.txt
 create mode 100644 arch/powerpc/boot/dts/t1040d4rdb.dts
 create mode 100644 arch/powerpc/boot/dts/t1042d4rdb.dts
 create mode 100644 arch/powerpc/boot/dts/t104xd4rdb.dtsi
 create mode 100644 arch/powerpc/configs/85xx-32bit.config
 create mode 100644 arch/powerpc/configs/85xx-64bit.config
 create mode 100644 arch/powerpc/configs/85xx-hw.config
 create mode 100644 arch/powerpc/configs/85xx-smp.config
 create mode 100644 arch/powerpc/configs/altivec.config
 delete mode 100644 arch/powerpc/configs/corenet32_smp_defconfig
 create mode 100644 arch/powerpc/configs/corenet_basic_defconfig
 rename arch/powerpc/configs/{corenet64_smp_defconfig => fsl-emb-nonhw.config} (50%)
 create mode 100644 arch/powerpc/configs/mpc85xx_basic_defconfig
 delete mode 100644 arch/powerpc/configs/mpc85xx_defconfig
 delete mode 100644 arch/powerpc/configs/mpc85xx_smp_defconfig
