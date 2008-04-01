Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18418.5519.903340.966932@cargo.ozlabs.ibm.com>
Date: Tue, 1 Apr 2008 21:59:27 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Commits added to powerpc.git master/powerpc-next branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have updated the master and powerpc-next branches of the powerpc.git
repository with the following commits, including some pulled from Josh
Boyer and Kumar Gala.

Paul.

Alexandr Smirnov (4):
      [POWERPC] 85xx: Emerson KSI8560 base support
      [POWERPC] 85xx: Emerson KSI8560 bootwrapper
      [POWERPC] 85xx: Emerson KSI8560 default config
      [POWERPC] 85xx: Emerson KSI8560 device tree

Badari Pulavarty (1):
      [POWERPC] Add error return from htab_remove_mapping()

David Gibson (1):
      [POWERPC] Start removing linux,network-index in favour of aliases

Geert Uytterhoeven (4):
      [POWERPC] PS3: Save power in busy loops on halt
      [POWERPC] move_device_tree() should be __init
      [POWERPC] arch_add_memory() cannot be __devinit
      [POWERPC] PS3: Split device setup for static vs. dynamic devices

Geoff Levand (2):
      [POWERPC] PS3: Bootwrapper improvements
      [POWERPC] PS3: Sys-manager Wake-on-LAN support

Harvey Harrison (2):
      [POWERPC] Replace remaining __FUNCTION__ occurrences
      [POWERPC] ppc: Replace remaining __FUNCTION__ occurrences

Johannes Weiner (2):
      [POWERPC] Remove redundant display of free swap space in show_mem()
      [POWERPC] ppc: Remove redundant display of free swap space in show_mem()

Josh Boyer (3):
      [POWERPC] 4xx: Add AMCC 440EP Yosemite DTS
      [POWERPC] 4xx: Add platform support for the AMCC Yosemite board
      [POWERPC] 4xx: Add bootwrapper for AMCC Yosemite board

Julia Lawall (1):
      [POWERPC] Use FIELD_SIZEOF in drivers/block/viodasd.c

Masakazu Mokuno (1):
      [POWERPC] PS3: Gelic network driver Wake-on-LAN support

Robert Brose (1):
      [POWERPC] Add kernel parameter to set l3cr for MPC745x

Roel Kluin (1):
      [POWERPC] PS3: Fix unlikely typo in ps3_get_irq

Stefan Roese (10):
      [POWERPC] 4xx: Add AMCC 460EX/460GT support to cputable.c & cpu_setup_44x.S
      [POWERPC] 4xx: Add AMCC Canyonlands 460EX eval board support to platforms/44x
      [POWERPC] 4xx: Add Canyonlands DTS
      [POWERPC] 4xx: Add 460EX PCIe support to 4xx pci driver
      [POWERPC] 4xx: Add Canyonlands defconfig file
      [POWERPC] 4xx: Add TAH support to taishan dts
      [POWERPC] 4xx: Add AMCC Glacier 460GT eval board dts
      [POWERPC] 4xx: Add "amcc, haleakala" to the toplevel compatible property
      [POWERPC] 4xx: Add PPC4xx L2-cache support (440GX)
      [POWERPC] 4xx: Add L2 cache node to AMCC Taishan dts file

Stephen Neuendorffer (3):
      [POWERPC] Xilinx: hwicap: Refactor status handling code.
      [POWERPC] Xilinx: hwicap: Verify sync before reading idcode.
      [POWERPC] Xilinx: hwicap: Use fixed device major.

Takashi Yamamoto (1):
      [POWERPC] PS3: Add ps3_get_speid routine

Valentine Barshak (2):
      [POWERPC] 4xx: Add dcri_clrset() for locked read/modify/write functionality
      [POWERPC] 4xx: Use dcri_clrset() for PCIe indirect dcr read/modify/write access

 Documentation/kernel-parameters.txt               |    2 
 Documentation/powerpc/booting-without-of.txt      |   16 
 arch/powerpc/Kconfig                              |    3 
 arch/powerpc/boot/Makefile                        |    4 
 arch/powerpc/boot/bamboo.c                        |    3 
 arch/powerpc/boot/cuboot-rainier.c                |    3 
 arch/powerpc/boot/cuboot-sequoia.c                |    3 
 arch/powerpc/boot/cuboot-taishan.c                |    3 
 arch/powerpc/boot/cuboot-warp.c                   |    2 
 arch/powerpc/boot/cuboot-yosemite.c               |   44 +
 arch/powerpc/boot/dts/bamboo.dts                  |    2 
 arch/powerpc/boot/dts/canyonlands.dts             |  391 +++++++++
 arch/powerpc/boot/dts/ebony.dts                   |    2 
 arch/powerpc/boot/dts/glacier.dts                 |  464 +++++++++++
 arch/powerpc/boot/dts/haleakala.dts               |    2 
 arch/powerpc/boot/dts/ksi8560.dts                 |  267 ++++++
 arch/powerpc/boot/dts/rainier.dts                 |    2 
 arch/powerpc/boot/dts/sequoia.dts                 |    2 
 arch/powerpc/boot/dts/taishan.dts                 |   27 +
 arch/powerpc/boot/dts/walnut.dts                  |    1 
 arch/powerpc/boot/dts/warp.dts                    |    1 
 arch/powerpc/boot/dts/yosemite.dts                |  304 +++++++
 arch/powerpc/boot/ebony.c                         |    3 
 arch/powerpc/boot/libfdt-wrapper.c                |    2 
 arch/powerpc/boot/ps3-head.S                      |   25 -
 arch/powerpc/boot/ps3.c                           |   23 -
 arch/powerpc/boot/treeboot-walnut.c               |    2 
 arch/powerpc/boot/wrapper                         |   23 -
 arch/powerpc/configs/canyonlands_defconfig        |  721 +++++++++++++++++
 arch/powerpc/configs/ksi8560_defconfig            |  899 +++++++++++++++++++++
 arch/powerpc/kernel/cpu_setup_44x.S               |    5 
 arch/powerpc/kernel/cputable.c                    |   28 +
 arch/powerpc/kernel/ibmebus.c                     |   12 
 arch/powerpc/kernel/iommu.c                       |    4 
 arch/powerpc/kernel/isa-bridge.c                  |    2 
 arch/powerpc/kernel/lparcfg.c                     |   12 
 arch/powerpc/kernel/prom.c                        |    2 
 arch/powerpc/kernel/rtas.c                        |    2 
 arch/powerpc/kernel/rtas_flash.c                  |    2 
 arch/powerpc/kernel/rtas_pci.c                    |   10 
 arch/powerpc/kernel/setup_32.c                    |   12 
 arch/powerpc/kernel/vio.c                         |   10 
 arch/powerpc/math-emu/fabs.c                      |    2 
 arch/powerpc/math-emu/fadd.c                      |    2 
 arch/powerpc/math-emu/fadds.c                     |    2 
 arch/powerpc/math-emu/fcmpo.c                     |    2 
 arch/powerpc/math-emu/fcmpu.c                     |    2 
 arch/powerpc/math-emu/fctiw.c                     |    2 
 arch/powerpc/math-emu/fctiwz.c                    |    2 
 arch/powerpc/math-emu/fdiv.c                      |    6 
 arch/powerpc/math-emu/fdivs.c                     |    6 
 arch/powerpc/math-emu/fmadd.c                     |    2 
 arch/powerpc/math-emu/fmadds.c                    |    2 
 arch/powerpc/math-emu/fmr.c                       |    2 
 arch/powerpc/math-emu/fmsub.c                     |    2 
 arch/powerpc/math-emu/fmsubs.c                    |    2 
 arch/powerpc/math-emu/fmul.c                      |    2 
 arch/powerpc/math-emu/fmuls.c                     |    2 
 arch/powerpc/math-emu/fnabs.c                     |    2 
 arch/powerpc/math-emu/fneg.c                      |    2 
 arch/powerpc/math-emu/fnmadd.c                    |    2 
 arch/powerpc/math-emu/fnmadds.c                   |    2 
 arch/powerpc/math-emu/fnmsub.c                    |    2 
 arch/powerpc/math-emu/fnmsubs.c                   |    2 
 arch/powerpc/math-emu/fres.c                      |    2 
 arch/powerpc/math-emu/frsp.c                      |    2 
 arch/powerpc/math-emu/frsqrte.c                   |    2 
 arch/powerpc/math-emu/fsel.c                      |    2 
 arch/powerpc/math-emu/fsqrt.c                     |    2 
 arch/powerpc/math-emu/fsqrts.c                    |    2 
 arch/powerpc/math-emu/fsub.c                      |    2 
 arch/powerpc/math-emu/fsubs.c                     |    2 
 arch/powerpc/math-emu/lfd.c                       |    2 
 arch/powerpc/math-emu/lfs.c                       |    2 
 arch/powerpc/math-emu/mcrfs.c                     |    4 
 arch/powerpc/math-emu/mffs.c                      |    2 
 arch/powerpc/math-emu/mtfsb0.c                    |    2 
 arch/powerpc/math-emu/mtfsb1.c                    |    2 
 arch/powerpc/math-emu/mtfsf.c                     |    2 
 arch/powerpc/math-emu/mtfsfi.c                    |    2 
 arch/powerpc/math-emu/stfd.c                      |    2 
 arch/powerpc/math-emu/stfiwx.c                    |    2 
 arch/powerpc/math-emu/stfs.c                      |    2 
 arch/powerpc/mm/hash_utils_64.c                   |   14 
 arch/powerpc/mm/init_32.c                         |    2 
 arch/powerpc/mm/init_64.c                         |    2 
 arch/powerpc/mm/mem.c                             |    3 
 arch/powerpc/oprofile/cell/spu_task_sync.c        |   12 
 arch/powerpc/oprofile/cell/vma_map.c              |   10 
 arch/powerpc/oprofile/op_model_cell.c             |   14 
 arch/powerpc/platforms/44x/Kconfig                |   28 +
 arch/powerpc/platforms/44x/Makefile               |    2 
 arch/powerpc/platforms/44x/canyonlands.c          |   64 +
 arch/powerpc/platforms/52xx/lite5200.c            |    4 
 arch/powerpc/platforms/85xx/Kconfig               |    7 
 arch/powerpc/platforms/85xx/Makefile              |    1 
 arch/powerpc/platforms/85xx/ksi8560.c             |  257 ++++++
 arch/powerpc/platforms/85xx/mpc85xx_ds.c          |    2 
 arch/powerpc/platforms/cell/iommu.c               |    8 
 arch/powerpc/platforms/cell/pervasive.c           |    2 
 arch/powerpc/platforms/cell/ras.c                 |   10 
 arch/powerpc/platforms/cell/spu_base.c            |    8 
 arch/powerpc/platforms/cell/spu_callbacks.c       |    2 
 arch/powerpc/platforms/cell/spu_manage.c          |    8 
 arch/powerpc/platforms/cell/spufs/file.c          |    4 
 arch/powerpc/platforms/cell/spufs/run.c           |   10 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   10 
 arch/powerpc/platforms/ps3/device-init.c          |   78 +-
 arch/powerpc/platforms/ps3/interrupt.c            |    2 
 arch/powerpc/platforms/ps3/setup.c                |   14 
 arch/powerpc/platforms/ps3/spu.c                  |    7 
 arch/powerpc/platforms/pseries/pci_dlpar.c        |    2 
 arch/powerpc/platforms/pseries/reconfig.c         |   12 
 arch/powerpc/sysdev/Makefile                      |    1 
 arch/powerpc/sysdev/cpm1.c                        |    2 
 arch/powerpc/sysdev/cpm2.c                        |    2 
 arch/powerpc/sysdev/ppc4xx_pci.c                  |  127 +++
 arch/powerpc/sysdev/ppc4xx_pci.h                  |   59 +
 arch/powerpc/sysdev/ppc4xx_soc.c                  |  189 ++++
 arch/powerpc/sysdev/qe_lib/qe_io.c                |    2 
 arch/powerpc/sysdev/qe_lib/ucc_fast.c             |   32 -
 arch/powerpc/sysdev/qe_lib/ucc_slow.c             |   18 
 arch/powerpc/sysdev/tsi108_dev.c                  |    4 
 arch/powerpc/sysdev/tsi108_pci.c                  |    4 
 arch/ppc/8xx_io/fec.c                             |    4 
 arch/ppc/mm/init.c                                |    1 
 arch/ppc/platforms/radstone_ppc7d.c               |    8 
 drivers/block/viodasd.c                           |    2 
 drivers/char/xilinx_hwicap/buffer_icap.c          |   22 -
 drivers/char/xilinx_hwicap/buffer_icap.h          |    5 
 drivers/char/xilinx_hwicap/fifo_icap.c            |   31 +
 drivers/char/xilinx_hwicap/fifo_icap.h            |    1 
 drivers/char/xilinx_hwicap/xilinx_hwicap.c        |   63 +
 drivers/char/xilinx_hwicap/xilinx_hwicap.h        |   24 +
 drivers/net/ps3_gelic_net.c                       |   81 ++
 drivers/net/ps3_gelic_net.h                       |   20 
 drivers/ps3/ps3-sys-manager.c                     |   74 +-
 drivers/ps3/sys-manager-core.c                    |   16 
 include/asm-powerpc/dcr-native.h                  |   17 
 include/asm-powerpc/dcr-regs.h                    |   78 ++
 include/asm-powerpc/ps3.h                         |    7 
 include/asm-powerpc/sparsemem.h                   |    2 
 142 files changed, 4563 insertions(+), 371 deletions(-)
 create mode 100644 arch/powerpc/boot/cuboot-yosemite.c
 create mode 100644 arch/powerpc/boot/dts/canyonlands.dts
 create mode 100644 arch/powerpc/boot/dts/glacier.dts
 create mode 100644 arch/powerpc/boot/dts/ksi8560.dts
 create mode 100644 arch/powerpc/boot/dts/yosemite.dts
 create mode 100644 arch/powerpc/configs/canyonlands_defconfig
 create mode 100644 arch/powerpc/configs/ksi8560_defconfig
 create mode 100644 arch/powerpc/platforms/44x/canyonlands.c
 create mode 100644 arch/powerpc/platforms/85xx/ksi8560.c
 create mode 100644 arch/powerpc/sysdev/ppc4xx_soc.c
