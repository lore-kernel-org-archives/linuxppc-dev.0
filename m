Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17904.60099.441388.484204@cargo.ozlabs.ibm.com>
Date: Fri, 9 Mar 2007 16:04:03 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: patches pushed to powerpc.git for-2.6.22 branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have committed the patches listed below and pushed them to the
for-2.6.22 branch of the powerpc.git repository.

If your patch isn't there and you think it should be, let me know.  I
am aware of Sylvain's uevent patches, but I haven't had time to review
them properly yet and neither has Ben H or anyone else, so I haven't
put them in.  There are some other patches that depend on those
(e.g. the ibmebus patches) so they haven't gone in yet either.

Paul.

 Documentation/powerpc/booting-without-of.txt      |  134 ++++++++++++++-------
 arch/powerpc/Kconfig                              |    5 -
 arch/powerpc/boot/dts/kuroboxHD.dts               |    1 
 arch/powerpc/boot/dts/kuroboxHG.dts               |    1 
 arch/powerpc/boot/dts/lite5200.dts                |    1 
 arch/powerpc/boot/dts/lite5200b.dts               |    1 
 arch/powerpc/boot/dts/mpc7448hpc2.dts             |    1 
 arch/powerpc/boot/dts/mpc8272ads.dts              |    1 
 arch/powerpc/boot/dts/mpc8313erdb.dts             |    1 
 arch/powerpc/boot/dts/mpc832x_mds.dts             |    1 
 arch/powerpc/boot/dts/mpc8349emitx.dts            |    1 
 arch/powerpc/boot/dts/mpc8349emitxgp.dts          |    1 
 arch/powerpc/boot/dts/mpc834x_mds.dts             |    1 
 arch/powerpc/boot/dts/mpc836x_mds.dts             |    1 
 arch/powerpc/boot/dts/mpc8540ads.dts              |    1 
 arch/powerpc/boot/dts/mpc8541cds.dts              |    1 
 arch/powerpc/boot/dts/mpc8548cds.dts              |    1 
 arch/powerpc/boot/dts/mpc8555cds.dts              |    1 
 arch/powerpc/boot/dts/mpc8560ads.dts              |    1 
 arch/powerpc/boot/dts/mpc8568mds.dts              |    1 
 arch/powerpc/boot/dts/mpc8641_hpcn.dts            |    1 
 arch/powerpc/boot/dts/mpc866ads.dts               |    1 
 arch/powerpc/boot/dts/mpc885ads.dts               |    1 
 arch/powerpc/kernel/Makefile                      |    4 -
 arch/powerpc/kernel/cputable.c                    |   12 ++
 arch/powerpc/kernel/head_64.S                     |    2 
 arch/powerpc/kernel/iommu.c                       |   10 ++
 arch/powerpc/kernel/pci_64.c                      |   14 ++
 arch/powerpc/kernel/process.c                     |   43 +++++--
 arch/powerpc/kernel/prom.c                        |   26 ++++
 arch/powerpc/kernel/rtas_pci.c                    |    4 -
 arch/powerpc/kernel/setup-common.c                |   22 ---
 arch/powerpc/lib/locks.c                          |    4 +
 arch/powerpc/mm/lmb.c                             |    4 +
 arch/powerpc/platforms/cell/iommu.c               |    8 +
 arch/powerpc/platforms/celleb/iommu.c             |    4 -
 arch/powerpc/platforms/embedded6xx/Kconfig        |    1 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   10 --
 arch/powerpc/platforms/iseries/iommu.c            |    2 
 arch/powerpc/platforms/iseries/irq.c              |    3 
 arch/powerpc/platforms/pasemi/iommu.c             |    4 -
 arch/powerpc/platforms/ps3/mm.c                   |    2 
 arch/powerpc/platforms/ps3/system-bus.c           |    2 
 arch/powerpc/platforms/pseries/Makefile           |    5 -
 arch/powerpc/platforms/pseries/iommu.c            |   57 +++++----
 arch/powerpc/platforms/pseries/setup.c            |    5 +
 arch/powerpc/sysdev/dart_iommu.c                  |    4 -
 arch/powerpc/xmon/xmon.c                          |    4 +
 drivers/macintosh/mac_hid.c                       |    2 
 drivers/ps3/ps3av.c                               |    9 +
 drivers/ps3/sys-manager.c                         |    6 +
 drivers/ps3/vuart.c                               |    2 
 drivers/video/Kconfig                             |    2 
 include/asm-powerpc/current.h                     |    1 
 include/asm-powerpc/edac.h                        |   40 ++++++
 include/asm-powerpc/pci.h                         |   14 ++
 include/asm-powerpc/ppc-pci.h                     |    9 +
 include/asm-powerpc/prom.h                        |    1 
 include/asm-powerpc/unistd.h                      |    3 
 59 files changed, 334 insertions(+), 171 deletions(-)
 create mode 100644 include/asm-powerpc/edac.h

Adrian Bunk (1):
      [POWERPC] Unexport mac_hid_mouse_emulate_buttons

Andrew Morton (1):
      [POWERPC] Fix compile error in prom.h

Dave Jiang (1):
      [POWERPC] EDAC ECC software scrubber

David Gibson (2):
      [POWERPC] Allow duplicate lmb_reserve() calls
      [POWERPC] Automatically lmb_reserve() initrd

Geert Uytterhoeven (1):
      [POWERPC] ps3: always make sure we're running on a PS3

Jake Moilanen (2):
      [POWERPC] DMA 4GB boundary protection
      [POWERPC] 750CL cputable entry

MOKUNO Masakazu (1):
      [POWERPC] Remove some redundant isync instructions

Olaf Hering (1):
      [POWERPC] Include stddef.h in asm-powerpc/current.h to get offsetof

Paul Mackerras (1):
      [POWERPC] Harden validate_sp against stack corruption

Segher Boessenkool (1):
      [POWERPC] PowerPC: select default image for Linkstation

Stephen Rothwell (8):
      [POWERPC] Allocate syscall number for sys_getcpu
      [POWERPC] Make ppc64_defconfig without CONFIG_PPC_PSERIES build
      [POWERPC] Create and use set_pci_dma_ops
      [POWERPC] Create and use get_pci_dma_ops()
      [POWERPC] Make iSeries build without CONFIG_PCI
      [POWERPC] Allow pSeries to build without CONFIG_PCI
      [POWERPC] Allow xmon to build without CONFIG_DEBUG_BUGVERBOSE
      [POWERPC] Make find_and_init_pbs() a void function

Stuart Yoder (3):
      [POWERPC] Remove interrupt-controller as a property under /chosen
      [POWERPC] Remove unused, undocumented #cpus property from cpus node
      [POWERPC] Update interrupt info in booting-without-of.txt

Zang Roy-r61911 (1):
      [POWERPC] Remove fixed setting of ROOT_DEV for 7448HPC2 platforms
