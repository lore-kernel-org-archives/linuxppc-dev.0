Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17780.52033.130460.362865@cargo.ozlabs.ibm.com>
Date: Tue, 5 Dec 2006 12:28:33 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'master' branch
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

or, if the mirroring hasn't caught up:

git pull \
master.kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git

to get a powerpc update, as listed below.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt       |   39 
 .../powerpc/mpc52xx-device-tree-bindings.txt       |  189 +++
 MAINTAINERS                                        |    7 
 arch/powerpc/.gitignore                            |    1 
 arch/powerpc/Kconfig                               |  105 +
 arch/powerpc/Kconfig.debug                         |   13 
 arch/powerpc/boot/.gitignore                       |   13 
 arch/powerpc/boot/Makefile                         |   15 
 arch/powerpc/boot/dts/kuroboxHG.dts                |  148 ++
 arch/powerpc/boot/dts/lite5200.dts                 |  313 ++++
 arch/powerpc/boot/dts/lite5200b.dts                |  318 ++++
 arch/powerpc/boot/dts/mpc7448hpc2.dts              |   44 -
 arch/powerpc/boot/flatdevtree.c                    |  880 +++++++++++
 arch/powerpc/boot/flatdevtree.h                    |   62 +
 arch/powerpc/boot/flatdevtree_env.h                |   47 +
 arch/powerpc/boot/flatdevtree_misc.c               |   51 +
 arch/powerpc/boot/io.h                             |   53 +
 arch/powerpc/boot/main.c                           |   57 -
 arch/powerpc/boot/mktree.c                         |  152 ++
 arch/powerpc/boot/ns16550.c                        |   74 +
 arch/powerpc/boot/of.c                             |    8 
 arch/powerpc/boot/ops.h                            |   26 
 arch/powerpc/boot/serial.c                         |  142 ++
 arch/powerpc/boot/simple_alloc.c                   |  149 ++
 arch/powerpc/boot/stdio.c                          |    3 
 arch/powerpc/boot/util.S                           |   88 +
 arch/powerpc/boot/wrapper                          |    3 
 arch/powerpc/boot/zImage.coff.lds.S                |    4 
 arch/powerpc/configs/cell_defconfig                |   50 +
 arch/powerpc/configs/linkstation_defconfig         | 1583 ++++++++++++++++++++
 arch/powerpc/configs/lite5200_defconfig            |  931 ++++++++++++
 arch/powerpc/configs/ppc64_defconfig               |    4 
 arch/powerpc/configs/ps3_defconfig                 |  837 +++++++++++
 arch/powerpc/kernel/Makefile                       |   15 
 arch/powerpc/kernel/asm-offsets.c                  |    3 
 arch/powerpc/kernel/cpu_setup_ppc970.S             |   16 
 arch/powerpc/kernel/cputable.c                     |   62 +
 arch/powerpc/kernel/crash.c                        |    4 
 arch/powerpc/kernel/dma_64.c                       |  249 ++-
 arch/powerpc/kernel/entry_64.S                     |   51 -
 arch/powerpc/kernel/head_64.S                      |  163 +-
 arch/powerpc/kernel/ibmebus.c                      |    9 
 arch/powerpc/kernel/idle.c                         |    7 
 arch/powerpc/kernel/idle_power4.S                  |    8 
 arch/powerpc/kernel/io.c                           |  105 +
 arch/powerpc/kernel/iomap.c                        |    2 
 arch/powerpc/kernel/iommu.c                        |    6 
 arch/powerpc/kernel/irq.c                          |   80 +
 arch/powerpc/kernel/of_device.c                    |  173 --
 arch/powerpc/kernel/of_platform.c                  |  489 ++++++
 arch/powerpc/kernel/pci_32.c                       |   96 -
 arch/powerpc/kernel/pci_64.c                       |   70 +
 arch/powerpc/kernel/pci_direct_iommu.c             |   98 -
 arch/powerpc/kernel/pci_iommu.c                    |  164 --
 arch/powerpc/kernel/ppc_ksyms.c                    |    4 
 arch/powerpc/kernel/prom.c                         |  111 +
 arch/powerpc/kernel/prom_init.c                    |   18 
 arch/powerpc/kernel/prom_parse.c                   |  290 ++--
 arch/powerpc/kernel/rtas.c                         |    5 
 arch/powerpc/kernel/rtas_flash.c                   |    4 
 arch/powerpc/kernel/rtas_pci.c                     |   35 
 arch/powerpc/kernel/setup_32.c                     |    6 
 arch/powerpc/kernel/setup_64.c                     |   18 
 arch/powerpc/kernel/smp-tbsync.c                   |    5 
 arch/powerpc/kernel/smp.c                          |    1 
 arch/powerpc/kernel/sys_ppc32.c                    |    1 
 arch/powerpc/kernel/sysfs.c                        |   76 +
 arch/powerpc/kernel/time.c                         |    7 
 arch/powerpc/kernel/traps.c                        |    8 
 arch/powerpc/kernel/vio.c                          |   94 -
 arch/powerpc/mm/Makefile                           |    2 
 arch/powerpc/mm/fault.c                            |   25 
 arch/powerpc/mm/hash_native_64.c                   |    2 
 arch/powerpc/mm/hash_utils_64.c                    |    2 
 arch/powerpc/mm/init_64.c                          |    2 
 arch/powerpc/mm/pgtable_32.c                       |   33 
 arch/powerpc/mm/pgtable_64.c                       |   52 -
 arch/powerpc/mm/slb.c                              |   13 
 arch/powerpc/oprofile/Makefile                     |    1 
 arch/powerpc/oprofile/common.c                     |   15 
 arch/powerpc/oprofile/op_model_cell.c              |  724 +++++++++
 arch/powerpc/platforms/52xx/Makefile               |    9 
 arch/powerpc/platforms/52xx/efika-pci.c            |  119 ++
 arch/powerpc/platforms/52xx/efika-setup.c          |  150 ++
 arch/powerpc/platforms/52xx/efika.h                |   19 
 arch/powerpc/platforms/52xx/lite5200.c             |  162 ++
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |  126 ++
 arch/powerpc/platforms/52xx/mpc52xx_pic.c          |  473 ++++++
 arch/powerpc/platforms/52xx/mpc52xx_pic.h          |   53 +
 arch/powerpc/platforms/82xx/mpc82xx_ads.c          |   13 
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |    2 
 arch/powerpc/platforms/83xx/mpc834x_itx.c          |    3 
 arch/powerpc/platforms/83xx/mpc834x_sys.c          |    3 
 arch/powerpc/platforms/83xx/mpc8360e_pb.c          |    2 
 arch/powerpc/platforms/83xx/mpc83xx.h              |    1 
 arch/powerpc/platforms/83xx/pci.c                  |    9 
 arch/powerpc/platforms/85xx/misc.c                 |    8 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |   11 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |   10 
 arch/powerpc/platforms/Makefile                    |    4 
 arch/powerpc/platforms/cell/Kconfig                |   14 
 arch/powerpc/platforms/cell/Makefile               |    7 
 arch/powerpc/platforms/cell/cbe_cpufreq.c          |  248 +++
 arch/powerpc/platforms/cell/cbe_regs.c             |   71 +
 arch/powerpc/platforms/cell/cbe_regs.h             |  203 ++-
 arch/powerpc/platforms/cell/cbe_thermal.c          |  226 +++
 arch/powerpc/platforms/cell/interrupt.c            |   16 
 arch/powerpc/platforms/cell/interrupt.h            |    2 
 arch/powerpc/platforms/cell/io-workarounds.c       |  346 ++++
 arch/powerpc/platforms/cell/iommu.c                | 1049 ++++++++-----
 arch/powerpc/platforms/cell/iommu.h                |   65 -
 arch/powerpc/platforms/cell/pervasive.c            |  101 -
 arch/powerpc/platforms/cell/pmu.c                  |  429 +++++
 arch/powerpc/platforms/cell/setup.c                |   78 +
 arch/powerpc/platforms/cell/spu_base.c             |  415 +----
 arch/powerpc/platforms/cell/spu_coredump.c         |   81 +
 arch/powerpc/platforms/cell/spu_priv1_mmio.c       |  428 +++++
 arch/powerpc/platforms/cell/spu_priv1_mmio.h       |   26 
 arch/powerpc/platforms/cell/spufs/Makefile         |    2 
 arch/powerpc/platforms/cell/spufs/backing_ops.c    |   31 
 arch/powerpc/platforms/cell/spufs/context.c        |   27 
 arch/powerpc/platforms/cell/spufs/coredump.c       |  238 +++
 arch/powerpc/platforms/cell/spufs/file.c           |  536 ++++++-
 arch/powerpc/platforms/cell/spufs/hw_ops.c         |   51 -
 arch/powerpc/platforms/cell/spufs/inode.c          |   58 +
 arch/powerpc/platforms/cell/spufs/run.c            |  149 ++
 arch/powerpc/platforms/cell/spufs/spufs.h          |   33 
 arch/powerpc/platforms/cell/spufs/switch.c         |   63 +
 arch/powerpc/platforms/chrp/chrp.h                 |    1 
 arch/powerpc/platforms/chrp/pci.c                  |    9 
 arch/powerpc/platforms/chrp/setup.c                |    2 
 arch/powerpc/platforms/embedded6xx/Kconfig         |   30 
 arch/powerpc/platforms/embedded6xx/Makefile        |    1 
 arch/powerpc/platforms/embedded6xx/linkstation.c   |  211 +++
 arch/powerpc/platforms/embedded6xx/ls_uart.c       |  131 ++
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c  |   94 -
 arch/powerpc/platforms/iseries/Makefile            |    8 
 arch/powerpc/platforms/iseries/dt.c                |   15 
 arch/powerpc/platforms/iseries/iommu.c             |   16 
 arch/powerpc/platforms/iseries/ksyms.c             |    6 
 arch/powerpc/platforms/iseries/misc.S              |   35 
 arch/powerpc/platforms/iseries/pci.c               |  372 ++---
 arch/powerpc/platforms/iseries/setup.c             |   48 -
 arch/powerpc/platforms/iseries/viopath.c           |    3 
 arch/powerpc/platforms/maple/maple.h               |    2 
 arch/powerpc/platforms/maple/pci.c                 |   47 -
 arch/powerpc/platforms/maple/setup.c               |    2 
 arch/powerpc/platforms/pasemi/pasemi.h             |    1 
 arch/powerpc/platforms/pasemi/pci.c                |    8 
 arch/powerpc/platforms/pasemi/setup.c              |   17 
 arch/powerpc/platforms/powermac/feature.c          |    8 
 arch/powerpc/platforms/powermac/pci.c              |   35 
 arch/powerpc/platforms/powermac/pmac.h             |    2 
 arch/powerpc/platforms/powermac/setup.c            |    7 
 arch/powerpc/platforms/ps3/Kconfig                 |   43 +
 arch/powerpc/platforms/ps3/Makefile                |    4 
 arch/powerpc/platforms/ps3/exports.c               |   27 
 arch/powerpc/platforms/ps3/htab.c                  |  277 +++
 arch/powerpc/platforms/ps3/hvcall.S                |  804 ++++++++++
 arch/powerpc/platforms/ps3/interrupt.c             |  575 +++++++
 arch/powerpc/platforms/ps3/mm.c                    |  831 ++++++++++
 arch/powerpc/platforms/ps3/os-area.c               |  259 +++
 arch/powerpc/platforms/ps3/platform.h              |   68 +
 arch/powerpc/platforms/ps3/repository.c            |  840 +++++++++++
 arch/powerpc/platforms/ps3/setup.c                 |  173 ++
 arch/powerpc/platforms/ps3/smp.c                   |  158 ++
 arch/powerpc/platforms/ps3/spu.c                   |  613 ++++++++
 arch/powerpc/platforms/ps3/time.c                  |  104 +
 arch/powerpc/platforms/pseries/iommu.c             |   90 +
 arch/powerpc/platforms/pseries/lpar.c              |    4 
 arch/powerpc/platforms/pseries/pci.c               |   35 
 arch/powerpc/platforms/pseries/pci_dlpar.c         |    6 
 arch/powerpc/platforms/pseries/reconfig.c          |    3 
 arch/powerpc/platforms/pseries/setup.c             |    5 
 arch/powerpc/platforms/pseries/xics.c              |   68 +
 arch/powerpc/sysdev/Makefile                       |    5 
 arch/powerpc/sysdev/dart_iommu.c                   |   34 
 arch/powerpc/sysdev/dcr-low.S                      |   39 
 arch/powerpc/sysdev/dcr.c                          |  137 ++
 arch/powerpc/sysdev/fsl_soc.c                      |   28 
 arch/powerpc/sysdev/mpic.c                         |  172 ++
 arch/powerpc/sysdev/qe_lib/qe.c                    |    3 
 arch/powerpc/sysdev/qe_lib/ucc_fast.c              |    4 
 arch/powerpc/sysdev/qe_lib/ucc_slow.c              |    4 
 arch/powerpc/sysdev/rom.c                          |   31 
 arch/powerpc/sysdev/todc.c                         |  392 -----
 arch/powerpc/sysdev/tsi108_pci.c                   |   48 +
 arch/powerpc/xmon/Makefile                         |    9 
 arch/powerpc/xmon/dis-asm.h                        |   31 
 arch/powerpc/xmon/ppc-dis.c                        |   29 
 arch/powerpc/xmon/ppc-opc.c                        |  778 +++++++---
 arch/powerpc/xmon/ppc.h                            |   39 
 arch/powerpc/xmon/spu-dis.c                        |  248 +++
 arch/powerpc/xmon/spu-insns.h                      |  410 +++++
 arch/powerpc/xmon/spu-opc.c                        |   44 +
 arch/powerpc/xmon/spu.h                            |  126 ++
 arch/powerpc/xmon/xmon.c                           |  356 ++++
 arch/ppc/.gitignore                                |    1 
 arch/ppc/Kconfig                                   |   11 
 arch/ppc/boot/images/.gitignore                    |    6 
 arch/ppc/boot/lib/.gitignore                       |    3 
 arch/ppc/boot/utils/.gitignore                     |    3 
 arch/ppc/kernel/setup.c                            |    2 
 arch/ppc/kernel/traps.c                            |    2 
 arch/ppc/platforms/4xx/bubinga.c                   |    2 
 arch/ppc/platforms/4xx/cpci405.c                   |    2 
 arch/ppc/platforms/4xx/ep405.c                     |    2 
 arch/ppc/platforms/83xx/mpc834x_sys.c              |    4 
 arch/ppc/platforms/85xx/mpc8540_ads.c              |    4 
 arch/ppc/platforms/85xx/mpc8560_ads.c              |    4 
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c       |    6 
 arch/ppc/platforms/85xx/sbc8560.c                  |    2 
 arch/ppc/platforms/85xx/stx_gp3.c                  |    2 
 arch/ppc/platforms/85xx/tqm85xx.c                  |    4 
 arch/ppc/platforms/mpc8272ads_setup.c              |    6 
 arch/ppc/platforms/mpc866ads_setup.c               |    4 
 arch/ppc/syslib/mpc8xx_devices.c                   |    8 
 drivers/Makefile                                   |    1 
 drivers/block/viodasd.c                            |   49 -
 drivers/ide/pci/via82cxxx.c                        |    4 
 drivers/macintosh/Kconfig                          |    7 
 drivers/macintosh/Makefile                         |    1 
 drivers/macintosh/rack-meter.c                     |  612 ++++++++
 drivers/macintosh/smu.c                            |    3 
 drivers/macintosh/therm_adt746x.c                  |    2 
 drivers/macintosh/therm_pm72.c                     |    5 
 drivers/macintosh/therm_windtunnel.c               |    7 
 drivers/net/ibm_emac/ibm_emac_mal.h                |    6 
 drivers/net/ibmveth.c                              |    4 
 drivers/net/ibmveth.h                              |    1 
 drivers/net/phy/fixed.c                            |    2 
 drivers/net/spider_net.c                           |   18 
 drivers/net/tulip/de4x5.c                          |    8 
 drivers/ps3/Makefile                               |    1 
 drivers/ps3/system-bus.c                           |  362 +++++
 drivers/serial/cpm_uart/cpm_uart_cpm2.c            |    2 
 drivers/serial/mpc52xx_uart.c                      |  469 +++++-
 drivers/video/platinumfb.c                         |    5 
 fs/binfmt_elf.c                                    |    8 
 include/asm-powerpc/Kbuild                         |    1 
 include/asm-powerpc/cell-pmu.h                     |  113 +
 include/asm-powerpc/cputable.h                     |   31 
 include/asm-powerpc/dbdma.h                        |    8 
 include/asm-powerpc/dcr-mmio.h                     |   51 +
 include/asm-powerpc/dcr-native.h                   |   39 
 include/asm-powerpc/dcr.h                          |   42 +
 include/asm-powerpc/device.h                       |   19 
 include/asm-powerpc/dma-mapping.h                  |  182 ++
 include/asm-powerpc/eeh.h                          |  213 ---
 include/asm-powerpc/elf.h                          |   13 
 include/asm-powerpc/firmware.h                     |   17 
 include/asm-powerpc/hw_irq.h                       |   44 -
 include/asm-powerpc/ibmebus.h                      |    1 
 include/asm-powerpc/ide.h                          |    8 
 include/asm-powerpc/immap_qe.h                     |   17 
 include/asm-powerpc/io-defs.h                      |   59 +
 include/asm-powerpc/io.h                           |  845 +++++++----
 include/asm-powerpc/iommu.h                        |   34 
 include/asm-powerpc/irq.h                          |    4 
 include/asm-powerpc/iseries/iommu.h                |    4 
 include/asm-powerpc/lv1call.h                      |  345 ++++
 include/asm-powerpc/machdep.h                      |   18 
 include/asm-powerpc/mmu.h                          |   15 
 include/asm-powerpc/mpc52xx.h                      |  254 +++
 include/asm-powerpc/mpc85xx.h                      |    8 
 include/asm-powerpc/mpic.h                         |   39 
 include/asm-powerpc/of_device.h                    |   36 
 include/asm-powerpc/of_platform.h                  |   60 +
 include/asm-powerpc/oprofile_impl.h                |    3 
 include/asm-powerpc/paca.h                         |    3 
 include/asm-powerpc/pci-bridge.h                   |    1 
 include/asm-powerpc/pci.h                          |   10 
 include/asm-powerpc/ppc-pci.h                      |   13 
 include/asm-powerpc/processor.h                    |    4 
 include/asm-powerpc/prom.h                         |   15 
 include/asm-powerpc/ps3.h                          |  462 ++++++
 include/asm-powerpc/rtas.h                         |    2 
 include/asm-powerpc/sparsemem.h                    |    6 
 include/asm-powerpc/spu.h                          |   30 
 include/asm-powerpc/spu_csa.h                      |    1 
 include/asm-powerpc/spu_info.h                     |   54 +
 include/asm-powerpc/spu_priv1.h                    |   46 -
 include/asm-powerpc/todc.h                         |  487 ------
 include/asm-powerpc/topology.h                     |    7 
 include/asm-powerpc/tsi108.h                       |    4 
 include/asm-powerpc/uaccess.h                      |    4 
 include/asm-powerpc/unistd.h                       |   12 
 include/asm-powerpc/vio.h                          |    1 
 include/asm-powerpc/xmon.h                         |    2 
 include/asm-ppc/io.h                               |   28 
 include/asm-ppc/m48t35.h                           |    2 
 include/asm-ppc/mpc52xx.h                          |   11 
 include/asm-ppc/mpc83xx.h                          |    8 
 include/asm-ppc/mpc85xx.h                          |    8 
 include/asm-ppc/pci-bridge.h                       |    1 
 include/linux/cpu.h                                |    8 
 include/linux/elf.h                                |    7 
 lib/iomap.c                                        |   32 
 298 files changed, 25464 insertions(+), 5051 deletions(-)
 create mode 100644 Documentation/powerpc/mpc52xx-device-tree-bindings.txt
 create mode 100644 arch/powerpc/.gitignore
 create mode 100644 arch/powerpc/boot/dts/kuroboxHG.dts
 create mode 100644 arch/powerpc/boot/dts/lite5200.dts
 create mode 100644 arch/powerpc/boot/dts/lite5200b.dts
 create mode 100644 arch/powerpc/boot/flatdevtree.c
 create mode 100644 arch/powerpc/boot/flatdevtree_env.h
 create mode 100644 arch/powerpc/boot/flatdevtree_misc.c
 create mode 100644 arch/powerpc/boot/io.h
 create mode 100644 arch/powerpc/boot/mktree.c
 create mode 100644 arch/powerpc/boot/ns16550.c
 create mode 100644 arch/powerpc/boot/serial.c
 create mode 100644 arch/powerpc/boot/simple_alloc.c
 create mode 100644 arch/powerpc/boot/util.S
 create mode 100644 arch/powerpc/configs/linkstation_defconfig
 create mode 100644 arch/powerpc/configs/lite5200_defconfig
 create mode 100644 arch/powerpc/configs/ps3_defconfig
 create mode 100644 arch/powerpc/kernel/of_platform.c
 delete mode 100644 arch/powerpc/kernel/pci_direct_iommu.c
 delete mode 100644 arch/powerpc/kernel/pci_iommu.c
 create mode 100644 arch/powerpc/oprofile/op_model_cell.c
 create mode 100644 arch/powerpc/platforms/52xx/Makefile
 create mode 100644 arch/powerpc/platforms/52xx/efika-pci.c
 create mode 100644 arch/powerpc/platforms/52xx/efika-setup.c
 create mode 100644 arch/powerpc/platforms/52xx/efika.h
 create mode 100644 arch/powerpc/platforms/52xx/lite5200.c
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_common.c
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_pic.c
 create mode 100644 arch/powerpc/platforms/52xx/mpc52xx_pic.h
 create mode 100644 arch/powerpc/platforms/cell/cbe_cpufreq.c
 create mode 100644 arch/powerpc/platforms/cell/cbe_thermal.c
 create mode 100644 arch/powerpc/platforms/cell/io-workarounds.c
 delete mode 100644 arch/powerpc/platforms/cell/iommu.h
 create mode 100644 arch/powerpc/platforms/cell/pmu.c
 create mode 100644 arch/powerpc/platforms/cell/spu_coredump.c
 create mode 100644 arch/powerpc/platforms/cell/spu_priv1_mmio.h
 create mode 100644 arch/powerpc/platforms/cell/spufs/coredump.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/linkstation.c
 create mode 100644 arch/powerpc/platforms/embedded6xx/ls_uart.c
 create mode 100644 arch/powerpc/platforms/ps3/Kconfig
 create mode 100644 arch/powerpc/platforms/ps3/Makefile
 create mode 100644 arch/powerpc/platforms/ps3/exports.c
 create mode 100644 arch/powerpc/platforms/ps3/htab.c
 create mode 100644 arch/powerpc/platforms/ps3/hvcall.S
 create mode 100644 arch/powerpc/platforms/ps3/interrupt.c
 create mode 100644 arch/powerpc/platforms/ps3/mm.c
 create mode 100644 arch/powerpc/platforms/ps3/os-area.c
 create mode 100644 arch/powerpc/platforms/ps3/platform.h
 create mode 100644 arch/powerpc/platforms/ps3/repository.c
 create mode 100644 arch/powerpc/platforms/ps3/setup.c
 create mode 100644 arch/powerpc/platforms/ps3/smp.c
 create mode 100644 arch/powerpc/platforms/ps3/spu.c
 create mode 100644 arch/powerpc/platforms/ps3/time.c
 create mode 100644 arch/powerpc/sysdev/dcr-low.S
 create mode 100644 arch/powerpc/sysdev/dcr.c
 create mode 100644 arch/powerpc/sysdev/rom.c
 delete mode 100644 arch/powerpc/sysdev/todc.c
 create mode 100644 arch/powerpc/xmon/dis-asm.h
 create mode 100644 arch/powerpc/xmon/spu-dis.c
 create mode 100644 arch/powerpc/xmon/spu-insns.h
 create mode 100644 arch/powerpc/xmon/spu-opc.c
 create mode 100644 arch/powerpc/xmon/spu.h
 create mode 100644 arch/ppc/.gitignore
 create mode 100644 arch/ppc/boot/images/.gitignore
 create mode 100644 arch/ppc/boot/lib/.gitignore
 create mode 100644 arch/ppc/boot/utils/.gitignore
 create mode 100644 drivers/macintosh/rack-meter.c
 create mode 100644 drivers/ps3/Makefile
 create mode 100644 drivers/ps3/system-bus.c
 create mode 100644 include/asm-powerpc/cell-pmu.h
 create mode 100644 include/asm-powerpc/dcr-mmio.h
 create mode 100644 include/asm-powerpc/dcr-native.h
 create mode 100644 include/asm-powerpc/dcr.h
 create mode 100644 include/asm-powerpc/io-defs.h
 create mode 100644 include/asm-powerpc/lv1call.h
 create mode 100644 include/asm-powerpc/mpc52xx.h
 create mode 100644 include/asm-powerpc/of_platform.h
 create mode 100644 include/asm-powerpc/ps3.h
 create mode 100644 include/asm-powerpc/spu_info.h
 delete mode 100644 include/asm-powerpc/todc.h

Adrian Bunk (1):
      [POWERPC] include/asm-powerpc/: "extern inline" -> "static inline"

Adrian Cox (1):
      [POWERPC] Fix wraparound problem in smp-tbsync on 32-bit

Andy Fleming (3):
      [POWERPC] Fix up the OF functions to only do PCI stuff if PCI is actually configured
      [PATCH] Slight refactor of interrupt mapping for FSL parts
      [PATCH] of_irq_to_resource now returns the virq

Arnd Bergmann (11):
      [POWERPC] spufs: Return correct event for data storage interrupt
      [POWERPC] spufs: Always map local store non-guarded
      [POWERPC] spufs: Use SPU master control to prevent wild SPU execution
      [POWERPC] cell: Add symbol exports for oprofile
      [POWERPC] update cell_defconfig for ps3 support
      [POWERPC] spufs: always send sigtrap on breakpoint
      [POWERPC] cell: fix building without spufs
      [POWERPC] ps3: multiplatform build fixes
      [POWERPC] ps3: add a default zImage target
      [POWERPC] fix missing #include in sys_ppc32.c
      [POWERPC] fix building without PCI

Benjamin Herrenschmidt (30):
      [POWERPC] Make pci_read_irq_line the default
      [POWERPC] Remove ppc_md.pci_map_irq & ppc_swizzle for ARCH=powerpc
      [POWERPC] Generic DCR infrastructure
      [POWERPC] Make EMAC use generic DCR access methods
      [POWERPC] Support for DCR based MPIC
      [POWERPC] Improve MPIC driver auto-configuration from DT
      [POWERPC] Native cell support for MPIC in southbridge
      [POWERPC] Souped-up of_platform_device support
      [POWERPC] Hook of_platform_bus_probe with cell
      [PATCH] ibmveth: Remove ibmveth "liobn" field
      [POWERPC] Refactor 64 bits DMA operations
      [POWERPC] Add DMA ops support for of_platform_device to Cell
      [POWERPC] Resolve the parent address of a PCI bus range
      [POWERPC] Resolve the BUID for RTAS PCI config space accesses
      [POWERPC] Add "parent" struct device for PCI host bridges
      [POWERPC] Generic OF platform driver for PCI host bridges.
      [POWERPC] Cell fixup DMA offset for new southbridge
      [POWERPC] Allow hooking of PCI MMIO & PIO accessors on 64 bits
      [POWERPC] Cell "Spider" MMIO workarounds
      [POWERPC] Spider uses low level BE MMIO accessors
      [POWERPC] Add an optional offset to direct DMA on 64 bits
      [POWERPC] Make direct DMA use node local allocations
      [POWERPC] Make cell use direct DMA ops
      [POWERPC] Remove ioremap64 and fixup_bigphys_addr
      [POWERPC] Merge 32 and 64 bits asm-powerpc/io.h
      [POWERPC] Fix __raw* accessors
      [POWERPC] Fix IDE build with ARCH=ppc
      [POWERPC] Xserve cpu-meter driver
      [POWERPC] powerpc: Workaround for of_platform without "reg" nor "dcr-reg"
      [POWERPC] cell: hard disable interrupts in power_save()

Christian Krafft (4):
      [POWERPC] cell: add support for registering sysfs attributes to spus
      [POWERPC] sysfs: add support for adding/removing spu sysfs attributes
      [POWERPC] cell: add temperature to SPU and CPU sysfs entries
      [POWERPC] cell: add cpufreq driver for Cell BE processor

Christoph Hellwig (1):
      [POWERPC] spufs: Avoid user-triggered oops in ptrace

David Erb (1):
      [POWERPC] cell: update Cell BE register definitions

David Gibson (3):
      [POWERPC] Remove todc code from ARCH=powerpc
      [POWERPC] Small clarification of initrd handling
      [POWERPC] Cleanup zImage handling of kernel entry with flat device tree

Dwayne Grant McConnell (6):
      [POWERPC] spufs: Change %llx to 0x%llx.
      [POWERPC] spufs: Add /lslr, /dma_info and /proxydma files
      [POWERPC] spufs: Remove /spu_tag_mask file
      [POWERPC] spufs: Implement /mbox_info, /ibox_info, and /wbox_info.
      [POWERPC] spufs: Read from signal files only if data is there
      [POWERPC] coredump: Add SPU elf notes to coredump.

Geert Uytterhoeven (3):
      [POWERPC] setup_kcore(): Fix incorrect function name in panic() call.
      [POWERPC] ps3: Missed renames of CONFIG_PS3 to CONFIG_PPC_PS3
      [POWERPC] Clean images in arch/powerpc/boot

Geoff Levand (19):
      [POWERPC] Make pSeries_lpar_hpte_insert static
      [POWERPC] cell: remove unused struct spu variable
      [PATCH] Check for null init_early routine
      [POWERPC] Change ppc_rtas declaration to weak
      [POWERPC] spufs: Replace spu.nid with spu.node
      [POWERPC] add virq_to_hw accessor routine
      [POWERPC] cell: abstract spu management routines
      [POWERPC] ps3: add support for ps3 platform
      [POWERPC] ps3: add lv1 hvcalls
      [POWERPC] ps3: add feature bits
      [POWERPC] ps3: add htab routines
      [POWERPC] ps3: add repository support
      [POWERPC] ps3: add interrupt support
      [POWERPC] ps3: add lpar addressing
      [POWERPC] ps3: add OS params support
      [POWERPC] ps3: add spu support
      [POWERPC] ps3: add ps3 platform system bus support
      [POWERPC] ps3: add ps3_defconfig
      [POWERPC] ps3: add a default zImage target

Grant Likely (13):
      [POWERPC] Don't compile arch/powerpc mpc52xx_pic driver for ARCH=ppc
      [POWERPC] Document describing mpc52xx device tree binding conventions
      [POWERPC] Move MPC52xx PIC driver into arch/powerpc/platforms/52xx
      [POWERPC] Put mpc52xx support file in platforms/52xx
      [POWERPC] Move Efika support files into platforms/52xx
      [POWERPC] Add common routines for 52xx support in arch/powerpc
      [POWERPC] Add lite5200 board support to arch/powerpc
      [POWERPC] Add device trees for lite5200 and lite5200b eval boards
      [POWERPC] defconfig for lite5200 board
      [POWERPC] typo fix and whitespace cleanup on mpc52xx-uart driver
      [POWERPC] Add of_platform_bus support to mpc52xx psc uart driver
      [POWERPC] Remove obsolete PPC_52xx and update CLASSIC32 comment
      [POWERPC] Add missing EXPORTS for mpc52xx support

Guennadi Liakhovetski (1):
      [POWERPC] Linkstation / kurobox support

Hugh Dickins (1):
      [POWERPC] Make soft_enabled irqs preempt safe

Jeremy Kerr (5):
      [POWERPC] spufs: Add isolated-mode SPE recycling support
      [POWERPC] Cell iommu support
      [POWERPC] spufs: Add runcntrl read accessors
      [POWERPC] spufs: Load isolation kernel from spu_run
      [POWERPC] spufs: return an error in spu_create is isolated create isnt supported

Josh Boyer (1):
      [POWERPC] Add mktree utility to arch/powerpc/boot

Kalle Pokki (2):
      [POWERPC] CPM_UART: Fix inconsistency of function definition
      [POWERPC] 8xx: Off-by-one fixes to SCC parameter RAM definitions

Kevin Corry (5):
      [POWERPC] cell: add shadow registers for pmd_reg
      [POWERPC] cell: add low-level performance monitoring code
      [POWERPC] cell: PMU register macros
      [POWERPC] cell: Move PMU-related stuff to include/asm-powerpc/cell-pmu.h
      [POWERPC] cell: Add routines for managing PMU interrupts

Kim Phillips (1):
      [PATCH] Make git ignore new wrapper generated files

Linas Vepstas (2):
      [POWERPC] Wrap cpu_die() with CONFIG_HOTPLUG_CPU
      [POWERPC] Change ppc64_defconfig to use AUTOFS_V4 not V3

Linus Torvalds (1):
      [PATCH] Arch provides generic iomap missing accessors

Mariusz Kozlowski (1):
      [POWERPC] ppc: m48t35 add missing bracket

Mark A. Greer (6):
      [POWERPC] More bootwrapper reorganization
      [POWERPC] Add flatdevtree source
      [POWERPC] Add non-OF serial console support
      [POWERPC] Add simple memory allocator to bootwrapper
      [PATCH] Remove dtb file created by wrapper script
      [PATCH] Remove arch/powerpc/boot/zImage file.

Mark Nutter (1):
      [POWERPC] spufs: add support for nonschedulable contexts

Masato Noguchi (3):
      [POWERPC] spufs: wrap mfc sdr access
      [POWERPC] spufs: Fix missing stop-and-signal
      [POWERPC] spufs: Fix return value of spufs_mfc_write

Matthew McClintock (1):
      [POWERPC] Fixed some missing files to be deleted when running make clean

Maynard Johnson (1):
      [POWERPC] cell: Add oprofile support

Michael Ellerman (16):
      [POWERPC] Move iSeries initrd logic into device tree
      [POWERPC] Make irq_dispose_mapping(NO_IRQ) a nop
      [POWERPC] add support for stopping spus from xmon
      [POWERPC] add support for dumping spu info from xmon
      [PATCH] Do a single one-line printk in bad_page_fault()
      [POWERPC] Fix sparse warning in xmon Cell code
      [POWERPC] Show state of spus as theyre stopped in Cell xmon helper
      [POWERPC] Add a sd command (spu dump) to xmon to dump spu local store
      [POWERPC] Prepare for spu disassembly in xmon
      [POWERPC] Import spu disassembly code into xmon
      [POWERPC] Add spu disassembly to xmon
      [POWERPC] Make xmon disassembly optional
      [POWERPC] Make 64-bit cpu features defined on 32-bit
      [POWERPC] Import updated version of ppc disassembly code for xmon
      [POWERPC] cell: spu management xmon routines
      [POWERPC] Provide dummy hard_irq_enable/disable() for PPC32

Mike Wolf (1):
      [POWERPC] powerpc: Make 970MP detectable by oprofile

Mohan Kumar M (1):
      [POWERPC] pSeries/kexec: Fix for interrupt distribution

Nicolas DET (4):
      [PATCH] Add MPC5200 Interrupt Controller support.
      [PATCH] Add Efika platform support
      [POWERPC] Compile a zImage.chrp if PPC_EFIKA seleted
      [POWERPC] Fix compile issue for Efika platform

Olaf Hering (1):
      [PATCH] Fix compile warnings with CONFIG_PM=n

Olof Johansson (2):
      [POWERPC] powerpc: Enable DEEPNAP power savings mode on 970MP
      [POWERPC] Fix OF pci flags parsing

Paul Mackerras (4):
      [POWERPC] Lazy interrupt disabling for 64-bit machines
      [POWERPC] Make sure interrupt enable gets restored properly
      [POWERPC] Distinguish POWER6 partition modes and tell userspace
      [POWERPC] Tell firmware we can handle POWER6 compatible mode

Rutger Nijlunsing (1):
      [POWERPC] Add files build to .gitignore

Sascha Hauer (2):
      [PATCH] Remove inclusion of asm/processor.h in via82cxxx.c
      [PATCH] Remove dead code in iommu.h

Scott Wood (1):
      [POWERPC] Add the e300c3 core to the CPU table.

Sergei Shtylyov (1):
      [POWERPC] Fix debug printks for 32-bit resources in the PCI code

Stephen Rothwell (14):
      [POWERPC] iSeries: improve viodasd initialisation
      [POWERPC] iSeries: fix irq.c for combined build
      [POWERPC] iSeries: fix sysfs.c for combined build
      [POWERPC] iSeries: fix time.c for combined build
      [POWERPC] iSeries: fix xmon.c for combined build
      [POWERPC] iSeries: fix slb.c for combined build
      [POWERPC] spufs: we should only execute init_spu_base on cell
      [POWERPC] iSeries: Eliminate "exceeds stub group size" warnings
      [POWERPC] iSeries: allow CONFIG_CMDLINE
      [POWERPC] Allow xmon to build on legacy iSeries
      [POWERPC] Allow CONFIG_BOOTX_TEXT on iSeries
      [POWERPC] Fix cputable.h for combined build
      [POWERPC] iSeries: stop dt_mod.o being rebuilt unnecessarily
      [POWERPC] iSeries: don't build head_64.o unnecessarily

Sylvain Munaut (2):
      [PATCH] ppc: Fix io.h for config with CONFIG_PCI not set
      [POWERPC] Separate IRQ config / register set from main header

Timur Tabi (1):
      [PATCH] Optimize qe_brg struct to use an array

Vitaly Wool (1):
      [POWERPC] Add of_platform support for ROM devices

Wojtek Kaniewski (1):
      [POWERPC] Compilation fixes for ppc4xx PCI-less configs

Yan Burman (1):
      [POWERPC] Replace kmalloc+memset with kzalloc

Zang Roy-r61911 (1):
      [POWERPC] Make pci_read_irq_line the default on mpc7448hpc2 board

arnd@arndb.de (3):
      [POWERPC] spufs: "stautus" isnt a word.
      [POWERPC] spufs: allow isolated mode apps by starting the SPE loader
      [POWERPC] cell: use ppc_md->power_save instead of cbe_idle_loop

nkalmala (1):
      [POWERPC] Book-E reg MCSR msg misquoted

s.hauer@pengutronix.de (7):
      [PATCH] Replace CONFIG_PPC_MULTIPLATFORM with CONFIG_PPC_PMAC in tulip driver
      [PATCH] Remove unnecessary ifdef in include/asm-powerpc/pci.h
      [PATCH] Remove _machine macro
      [PATCH] Remove occurences of PPC_MULTIPLATFORM in head_64.S
      [PATCH] Remove occurences of PPC_MULTIPLATFORM in pci_64.c
      [PATCH] Clean up usage of boot_dev
      [PATCH] Make nvram_64.o a 64bit-only object
