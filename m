Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18251.17424.262674.134425@cargo.ozlabs.ibm.com>
Date: Tue, 27 Nov 2007 09:09:20 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get another batch of fixes for powerpc, as listed below.  Since the
pull request I sent last week while you were away, I have added four
more commits from Kumar.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt   |    5 +
 arch/powerpc/boot/dts/mpc832x_mds.dts          |   16 ++-
 arch/powerpc/boot/dts/mpc834x_mds.dts          |    9 ++
 arch/powerpc/boot/dts/mpc836x_mds.dts          |    9 ++
 arch/powerpc/boot/dts/mpc8544ds.dts            |   20 ++--
 arch/powerpc/boot/dts/mpc8572ds.dts            |  108 ++++++++++++++++++---
 arch/powerpc/boot/dts/mpc8641_hpcn.dts         |  126 ++++++++++++++++++++----
 arch/powerpc/configs/mpc832x_mds_defconfig     |   48 +++++++++
 arch/powerpc/configs/mpc832x_rdb_defconfig     |   41 +++++++-
 arch/powerpc/configs/mpc834x_itx_defconfig     |    2 
 arch/powerpc/configs/mpc834x_itxgp_defconfig   |   88 +++++++++++++++++
 arch/powerpc/configs/mpc834x_mds_defconfig     |   48 +++++++++
 arch/powerpc/configs/mpc836x_mds_defconfig     |   48 +++++++++
 arch/powerpc/configs/mpc8568mds_defconfig      |   48 +++++++++
 arch/powerpc/kernel/asm-offsets.c              |    4 +
 arch/powerpc/kernel/rtas.c                     |  111 ++++++++++++---------
 arch/powerpc/kernel/time.c                     |    5 +
 arch/powerpc/kernel/vdso.c                     |   11 ++
 arch/powerpc/kernel/vdso32/cacheflush.S        |   41 ++++++--
 arch/powerpc/kernel/vdso64/cacheflush.S        |   41 ++++++--
 arch/powerpc/mm/mem.c                          |    2 
 arch/powerpc/mm/mmu_decl.h                     |    2 
 arch/powerpc/mm/stab.c                         |    1 
 arch/powerpc/platforms/40x/walnut.c            |    3 -
 arch/powerpc/platforms/44x/bamboo.c            |    3 -
 arch/powerpc/platforms/44x/ebony.c             |    3 -
 arch/powerpc/platforms/44x/sequoia.c           |    3 -
 arch/powerpc/platforms/83xx/mpc832x_mds.c      |   31 +-----
 arch/powerpc/platforms/83xx/mpc832x_rdb.c      |   14 ++-
 arch/powerpc/platforms/83xx/mpc834x_mds.c      |   24 -----
 arch/powerpc/platforms/83xx/mpc836x_mds.c      |   55 +++++-----
 arch/powerpc/platforms/83xx/usb.c              |    8 +-
 arch/powerpc/platforms/cell/spufs/inode.c      |    1 
 arch/powerpc/platforms/embedded6xx/prpmc2800.c |    1 
 arch/powerpc/platforms/pasemi/setup.c          |    2 
 arch/powerpc/platforms/pseries/Kconfig         |    2 
 arch/powerpc/platforms/pseries/setup.c         |    3 -
 arch/powerpc/sysdev/uic.c                      |   18 +++
 arch/ppc/kernel/setup.c                        |    7 +
 arch/ppc/mm/init.c                             |    2 
 arch/ppc/mm/mmu_decl.h                         |    2 
 arch/ppc/platforms/4xx/yucca.c                 |    1 
 arch/ppc/syslib/virtex_devices.c               |   31 ++++++
 include/asm-powerpc/page_32.h                  |    4 +
 include/asm-powerpc/pci-bridge.h               |    5 +
 include/asm-powerpc/rtas.h                     |    3 -
 include/asm-powerpc/vdso_datapage.h            |    8 ++
 47 files changed, 832 insertions(+), 236 deletions(-)

Anton Vorontsov (2):
      [POWERPC] 83xx: MPC832x RDB - remove spidev stub, use mmc_spi
      [POWERPC] 83xx: Update mpc832x_rdb_defconfig to enable MMC-over-SPI

Benjamin Herrenschmidt (3):
      [POWERPC] Fix declaration of pcibios_free_controller
      [POWERPC] Fix kmalloc alignment on non-coherent DMA platforms
      [POWERPC] Fix 8xx build breakage due to _tlbie changes

Cyrill Gorcunov (1):
      [POWERPC] Fix potential NULL dereference

Grant Likely (1):
      [POWERPC] 83xx: Update mpc8349emitx(gp) defconfig for USB

Jeremy Kerr (1):
      [POWERPC] spufs: Fix context destroy vs /spu readdir race

Joachim Foerster (1):
      [POWERPC] Xilinx: Register AC97 Controller Reference with the platform bus

Jon Loeliger (1):
      [POWERPC] 4xx: Replace #includes of asm/of_platform.h with linux/of_platform.h.

Josh Boyer (1):
      [POWERPC] 4xx: Use virtual PVR value to init FPU on arch/ppc 440EP

Kamalesh Babulal (1):
      [POWERPC] Fix build failure on legacy iSeries

Kim Phillips (5):
      [POWERPC] 83xx: mpc832x mds: Fix board PHY reset code
      [POWERPC] 83xx: Fix 2nd UCC entry in mpc832x_mds.dts
      [POWERPC] Document rgmii-rxid and rgmii-txid phy-connection-types
      [POWERPC] 83xx: Handle mpc8360 rev. 2.1 RGMII timing erratum
      [POWERPC] 8xxx: MDS board RTC fixes

Kumar Gala (1):
      [POWERPC] Fix device tree interrupt map for Freescale ULI1575 boards

Linas Vepstas (1):
      [POWERPC] Fix RTAS os-term usage on kernel panic

Mark A. Greer (1):
      [POWERPC] prpmc2800: Enable L2 cache

Michael Neuling (1):
      [POWERPC] Fix possible division by zero in scaled time accounting

Nathan Lynch (1):
      [POWERPC] Fix multiple bugs in rtas_ibm_suspend_me code

Olof Johansson (2):
      [POWERPC] pasemi: Don't reset mpic at boot
      [POWERPC] vdso: Fixes for cache block sizes

Roel Kluin (1):
      [POWERPC] 4xx: balance ioremap/ioumap calls for Yucca

Stephen Rothwell (1):
      [POWERPC] pSeries: make pseries_defconfig minus PCI build again

Valentine Barshak (1):
      [POWERPC] 4xx: UIC add mask_ack callback
