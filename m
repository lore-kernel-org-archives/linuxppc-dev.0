Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED74EDDDE1
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 19:14:26 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id m978EIk4001758
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Oct 2008 03:14:19 -0500
Subject: powerpc.git status
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 07 Oct 2008 16:27:48 +1100
Message-Id: <1223357268.8157.38.camel@pasglop>
Mime-Version: 1.0
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While paul was away, I've been taking care of the tree, so currently
up to date is my git at:

 git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git

I've pushed a batch of stuff to the "master" branch. I haven't yet
updated the "next" branch, I'm going to let master settle a day or two
first just in case.

I'll update patchwork status asap.

 Documentation/powerpc/00-INDEX                     |    4 
 .../powerpc/dts-bindings/fsl/8xxx_gpio.txt         |   40 +
 Documentation/powerpc/ppc_htab.txt                 |  118 ---
 Documentation/powerpc/smp.txt                      |   34 -
 arch/powerpc/Kconfig                               |    3 
 arch/powerpc/boot/dts/arches.dts                   |  293 ++++++++
 arch/powerpc/boot/dts/asp834x-redboot.dts          |    4 
 arch/powerpc/boot/dts/mpc8313erdb.dts              |    4 
 arch/powerpc/boot/dts/mpc8315erdb.dts              |    4 
 arch/powerpc/boot/dts/mpc832x_mds.dts              |    4 
 arch/powerpc/boot/dts/mpc832x_rdb.dts              |    4 
 arch/powerpc/boot/dts/mpc8349emitx.dts             |    4 
 arch/powerpc/boot/dts/mpc8349emitxgp.dts           |    4 
 arch/powerpc/boot/dts/mpc834x_mds.dts              |    4 
 arch/powerpc/boot/dts/mpc836x_mds.dts              |    4 
 arch/powerpc/boot/dts/mpc836x_rdk.dts              |    4 
 arch/powerpc/boot/dts/mpc8377_mds.dts              |    4 
 arch/powerpc/boot/dts/mpc8377_rdb.dts              |    4 
 arch/powerpc/boot/dts/mpc8378_mds.dts              |    4 
 arch/powerpc/boot/dts/mpc8378_rdb.dts              |    4 
 arch/powerpc/boot/dts/mpc8379_mds.dts              |    4 
 arch/powerpc/boot/dts/mpc8379_rdb.dts              |    4 
 arch/powerpc/boot/dts/sbc8349.dts                  |    4 
 arch/powerpc/configs/44x/arches_defconfig          |  767 ++++++++++++++++++++
 arch/powerpc/configs/83xx/asp8347_defconfig        |    2 
 arch/powerpc/configs/83xx/mpc8313_rdb_defconfig    |    2 
 arch/powerpc/configs/83xx/mpc8315_rdb_defconfig    |    2 
 arch/powerpc/configs/83xx/mpc832x_mds_defconfig    |    2 
 arch/powerpc/configs/83xx/mpc832x_rdb_defconfig    |    2 
 arch/powerpc/configs/83xx/mpc834x_itx_defconfig    |    2 
 arch/powerpc/configs/83xx/mpc834x_itxgp_defconfig  |    2 
 arch/powerpc/configs/83xx/mpc834x_mds_defconfig    |    2 
 arch/powerpc/configs/83xx/mpc836x_mds_defconfig    |    2 
 arch/powerpc/configs/83xx/mpc836x_rdk_defconfig    |    2 
 arch/powerpc/configs/83xx/mpc837x_mds_defconfig    |    2 
 arch/powerpc/configs/83xx/mpc837x_rdb_defconfig    |    2 
 arch/powerpc/configs/83xx/sbc834x_defconfig        |    2 
 arch/powerpc/configs/86xx/mpc8610_hpcd_defconfig   |    2 
 arch/powerpc/configs/86xx/mpc8641_hpcn_defconfig   |    2 
 arch/powerpc/configs/86xx/sbc8641d_defconfig       |    2 
 arch/powerpc/configs/ep8248e_defconfig             |    2 
 arch/powerpc/configs/mpc8272_ads_defconfig         |    2 
 arch/powerpc/configs/mpc83xx_defconfig             |    2 
 arch/powerpc/configs/mpc86xx_defconfig             |   44 -
 arch/powerpc/configs/pq2fads_defconfig             |    2 
 arch/powerpc/include/asm/dcr-regs.h                |   11 
 arch/powerpc/include/asm/device.h                  |    3 
 arch/powerpc/include/asm/dma-mapping.h             |  187 ++---
 arch/powerpc/include/asm/highmem.h                 |    2 
 arch/powerpc/include/asm/io.h                      |    2 
 arch/powerpc/include/asm/machdep.h                 |    5 
 arch/powerpc/include/asm/page_32.h                 |    8 
 arch/powerpc/include/asm/pci.h                     |   14 
 arch/powerpc/include/asm/pgtable-ppc32.h           |   57 +
 arch/powerpc/include/asm/reg_booke.h               |    7 
 arch/powerpc/include/asm/sfp-machine.h             |  114 +--
 arch/powerpc/include/asm/tlbflush.h                |   13 
 arch/powerpc/include/asm/types.h                   |    2 
 arch/powerpc/kernel/.gitignore                     |    1 
 arch/powerpc/kernel/Makefile                       |    4 
 arch/powerpc/kernel/asm-offsets.c                  |    1 
 arch/powerpc/kernel/dma-iommu.c                    |  103 +++
 arch/powerpc/kernel/dma.c                          |  127 +++
 arch/powerpc/kernel/dma_64.c                       |  200 -----
 arch/powerpc/kernel/head_32.S                      |    4 
 arch/powerpc/kernel/head_fsl_booke.S               |    2 
 arch/powerpc/kernel/misc_32.S                      |   54 +
 arch/powerpc/kernel/of_device.c                    |    2 
 arch/powerpc/kernel/pci-common.c                   |   53 +
 arch/powerpc/kernel/pci_32.c                       |    7 
 arch/powerpc/kernel/pci_64.c                       |   49 -
 arch/powerpc/kernel/ppc_ksyms.c                    |    3 
 arch/powerpc/kernel/swsusp_asm64.S                 |    2 
 arch/powerpc/kernel/vio.c                          |    2 
 arch/powerpc/math-emu/Makefile                     |    7 
 arch/powerpc/math-emu/double.h                     |  129 ---
 arch/powerpc/math-emu/fadd.c                       |   17 
 arch/powerpc/math-emu/fadds.c                      |   20 -
 arch/powerpc/math-emu/fcmpo.c                      |   10 
 arch/powerpc/math-emu/fcmpu.c                      |   10 
 arch/powerpc/math-emu/fctiw.c                      |    8 
 arch/powerpc/math-emu/fctiwz.c                     |    8 
 arch/powerpc/math-emu/fdiv.c                       |   14 
 arch/powerpc/math-emu/fdivs.c                      |   16 
 arch/powerpc/math-emu/fmadd.c                      |   16 
 arch/powerpc/math-emu/fmadds.c                     |   18 
 arch/powerpc/math-emu/fmsub.c                      |   16 
 arch/powerpc/math-emu/fmsubs.c                     |   18 
 arch/powerpc/math-emu/fmul.c                       |   14 
 arch/powerpc/math-emu/fmuls.c                      |   16 
 arch/powerpc/math-emu/fnmadd.c                     |   16 
 arch/powerpc/math-emu/fnmadds.c                    |   18 
 arch/powerpc/math-emu/fnmsub.c                     |   16 
 arch/powerpc/math-emu/fnmsubs.c                    |   18 
 arch/powerpc/math-emu/frsp.c                       |   14 
 arch/powerpc/math-emu/fsel.c                       |    8 
 arch/powerpc/math-emu/fsqrt.c                      |   12 
 arch/powerpc/math-emu/fsqrts.c                     |   14 
 arch/powerpc/math-emu/fsub.c                       |   14 
 arch/powerpc/math-emu/fsubs.c                      |   16 
 arch/powerpc/math-emu/lfd.c                        |    4 
 arch/powerpc/math-emu/lfs.c                        |   19 
 arch/powerpc/math-emu/math.c                       |    8 
 arch/powerpc/math-emu/mcrfs.c                      |    3 
 arch/powerpc/math-emu/mffs.c                       |    3 
 arch/powerpc/math-emu/mtfsb0.c                     |    3 
 arch/powerpc/math-emu/mtfsb1.c                     |    3 
 arch/powerpc/math-emu/mtfsf.c                      |   20 -
 arch/powerpc/math-emu/mtfsfi.c                     |    3 
 arch/powerpc/math-emu/op-1.h                       |  245 ------
 arch/powerpc/math-emu/op-2.h                       |  434 -----------
 arch/powerpc/math-emu/op-4.h                       |  317 --------
 arch/powerpc/math-emu/op-common.h                  |  688 ------------------
 arch/powerpc/math-emu/single.h                     |   66 --
 arch/powerpc/math-emu/soft-fp.h                    |  104 ---
 arch/powerpc/math-emu/stfs.c                       |   19 
 arch/powerpc/math-emu/types.c                      |   51 -
 arch/powerpc/math-emu/udivmodti4.c                 |    2 
 arch/powerpc/mm/hash_low_32.S                      |   86 ++
 arch/powerpc/mm/mem.c                              |    5 
 arch/powerpc/mm/pgtable_32.c                       |    4 
 arch/powerpc/mm/tlb_32.c                           |    1 
 arch/powerpc/platforms/44x/Kconfig                 |   17 
 arch/powerpc/platforms/44x/ppc44x_simple.c         |    3 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |    1 
 arch/powerpc/platforms/85xx/sbc8560.c              |    1 
 arch/powerpc/platforms/86xx/gef_sbc610.c           |   25 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c         |    8 
 arch/powerpc/platforms/86xx/sbc8641d.c             |    8 
 arch/powerpc/platforms/Kconfig                     |    9 
 arch/powerpc/platforms/Kconfig.cputype             |   17 
 arch/powerpc/platforms/cell/iommu.c                |    6 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c  |    1 
 arch/powerpc/platforms/ps3/system-bus.c            |    2 
 arch/powerpc/platforms/pseries/rtasd.c             |   26 -
 arch/powerpc/sysdev/Makefile                       |    1 
 arch/powerpc/sysdev/fsl_soc.c                      |   47 -
 arch/powerpc/sysdev/mpc8xxx_gpio.c                 |  171 ++++
 arch/powerpc/sysdev/ppc4xx_pci.c                   |    9 
 drivers/block/floppy.c                             |    2 
 drivers/block/viodasd.c                            |    3 
 drivers/char/ipmi/ipmi_si_intf.c                   |    2 
 drivers/i2c/busses/i2c-pca-isa.c                   |    2 
 drivers/input/serio/i8042-io.h                     |    2 
 drivers/net/ibm_newemac/Kconfig                    |   12 
 drivers/net/ibm_newemac/core.c                     |   60 +-
 drivers/net/ibm_newemac/core.h                     |   11 
 drivers/net/ibm_newemac/mal.c                      |   60 +-
 drivers/net/ibm_newemac/mal.h                      |   34 +
 drivers/net/ibm_newemac/phy.c                      |   84 ++
 drivers/net/ibm_newemac/phy.h                      |    2 
 drivers/pnp/isapnp/core.c                          |    2 
 drivers/pnp/pnpbios/core.c                         |    4 
 drivers/serial/mpc52xx_uart.c                      |  181 -----
 include/linux/proc_fs.h                            |    1 
 155 files changed, 2603 insertions(+), 3232 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/fsl/8xxx_gpio.txt
 delete mode 100644 Documentation/powerpc/ppc_htab.txt
 delete mode 100644 Documentation/powerpc/smp.txt
 create mode 100644 arch/powerpc/boot/dts/arches.dts
 create mode 100644 arch/powerpc/configs/44x/arches_defconfig
 rename arch/powerpc/configs/{mpc8610_hpcd_defconfig => 86xx/mpc8610_hpcd_defconfig} (100%)
 copy arch/powerpc/configs/{mpc8641_hpcn_defconfig => 86xx/mpc8641_hpcn_defconfig} (100%)
 rename arch/powerpc/configs/{sbc8641d_defconfig => 86xx/sbc8641d_defconfig} (100%)
 rename arch/powerpc/configs/{mpc8641_hpcn_defconfig => mpc86xx_defconfig} (98%)
 rename arch/powerpc/{math-emu/sfp-machine.h => include/asm/sfp-machine.h} (84%)
 create mode 100644 arch/powerpc/kernel/.gitignore
 create mode 100644 arch/powerpc/kernel/dma-iommu.c
 create mode 100644 arch/powerpc/kernel/dma.c
 delete mode 100644 arch/powerpc/kernel/dma_64.c
 delete mode 100644 arch/powerpc/math-emu/double.h
 delete mode 100644 arch/powerpc/math-emu/op-1.h
 delete mode 100644 arch/powerpc/math-emu/op-2.h
 delete mode 100644 arch/powerpc/math-emu/op-4.h
 delete mode 100644 arch/powerpc/math-emu/op-common.h
 delete mode 100644 arch/powerpc/math-emu/single.h
 delete mode 100644 arch/powerpc/math-emu/soft-fp.h
 delete mode 100644 arch/powerpc/math-emu/types.c
 create mode 100644 arch/powerpc/sysdev/mpc8xxx_gpio.c

Anton Vorontsov (1):
      powerpc/fsl_soc: remove mpc83xx_wdt code

Becky Bruce (7):
      powerpc: Rename dma_64.c to dma.c
      powerpc: Move iommu dma ops from dma.c to dma-iommu.c
      powerpc: Drop archdata numa_node
      powerpc: Merge 32 and 64-bit dma code
      powerpc: Make dma_addr_t a u64 if CONFIG_PHYS_64BIT is set
      POWERPC: Allow 32-bit hashed pgtable code to support 36-bit physical
      powerpc: Drop redundant machine type print in show_cpuinfo

Benjamin Herrenschmidt (1):
      powerpc: Fix sysfs pci mmap on 32-bit machines with 64-bit PCI

Geert Uytterhoeven (2):
      powerpc: Remove remains of /proc/ppc_htab
      powerpc: Remove outdated Documentation/powerpc/smp.txt

Johann Felix Soden (1):
      powerpc/iseries: Remove unused variable in viodasd.c

Johannes Berg (2):
      powerpc: Fix 64-bit hibernation with 64k pages
      powerpc: Enforce sane MAX_ORDER

Josh Boyer (3):
      ibm_newemac: Allow the "no flow control" EMAC feature to work
      ibm_newemac: Introduce mal_has_feature
      ibm_newemac: MAL support for PowerPC 405EZ

Kumar Gala (9):
      powerpc: convert CONFIG_PPC_MERGE to CONFIG_PPC for legacy io checks
      powerpc/83xx: Add missing cell-index to dma-channel device nodes
      powerpc/86xx: Introduce a generic mpc86xx_defconfig
      powerpc: Move 8xxx GPIO Kconfig under the platform menu
      powerpc: Introduce local (non-broadcast) forms of tlb invalidates
      powerpc: Fixes for CONFIG_PTE_64BIT for SMP support
      powerpc/mm: Implement _PAGE_SPECIAL & pte_special() for 32-bit
      serial/mpc52xx_uart: remove code associated with !CONFIG_PPC_MERGE
      powerpc/math-emu: Use kernel generic math-emu code

Martyn Welch (1):
      powerpc: Correct USB support for GE Fanuc SBC610

Matthias Fuchs (1):
      powerpc/4xx: Allow 4xx PCI bridge to be disabled via device tree

Peter Korsgaard (1):
      powerpc: gpio driver for mpc8349/8572/8610 and compatible

Roland Dreier (1):
      powerpc: Avoid integer overflow in page_is_ram()

Sebastien Dugue (1):
      powerpc: Ignore generated vmlinux.lds in git

Timur Tabi (1):
      powerpc: Remove CHRP and PMAC support from FSL defconfigs

Victor Gallardo (4):
      ibm_newemac: Add support for GPCS, SGMII and M88E1112 PHY
      powerpc/44x: Add AMCC Arches eval board support
      powerpc/44x: Add AMCC Arches DTS
      powerpc/44x: Add AMCC Arches defconfig file

Vitaly Mayatskikh (1):
      powerpc: Honor O_NONBLOCK flag when reading RTAS log
