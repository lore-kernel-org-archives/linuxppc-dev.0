Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17874.8572.761026.618811@cargo.ozlabs.ibm.com>
Date: Wed, 14 Feb 2007 07:37:16 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: patches in powerpc.git
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These are the patches that are on the master branch of the powerpc.git
repository on kernel.org.  I plan to ask Linus to pull them later
today, along with whatever I get from Kumar's for_paulus branch, and
probably David Gibson's "Use udbg_early_init() on ppc32" patch.

Paul.

 Documentation/powerpc/booting-without-of.txt       |    4 
 .../powerpc/mpc52xx-device-tree-bindings.txt       |  183 ++-
 arch/powerpc/Kconfig                               |    2 
 arch/powerpc/boot/dts/kuroboxHD.dts                |  148 ++
 arch/powerpc/boot/dts/lite5200.dts                 |  135 +-
 arch/powerpc/boot/dts/lite5200b.dts                |  135 +-
 arch/powerpc/boot/dts/mpc8313erdb.dts              |  219 +++
 arch/powerpc/boot/dts/mpc834x_mds.dts              |    6 
 arch/powerpc/configs/linkstation_defconfig         |  118 +-
 arch/powerpc/configs/mpc8313_rdb_defconfig         | 1409 ++++++++++++++++++++
 arch/powerpc/configs/mpc834x_mds_defconfig         |    9 
 arch/powerpc/kernel/cputable.c                     |    2 
 arch/powerpc/kernel/head_44x.S                     |    2 
 arch/powerpc/kernel/prom_init.c                    |   81 +
 arch/powerpc/kernel/vdso.c                         |   34 
 arch/powerpc/mm/mem.c                              |    3 
 arch/powerpc/mm/pgtable_32.c                       |    2 
 arch/powerpc/platforms/52xx/Makefile               |    2 
 arch/powerpc/platforms/52xx/efika-pci.c            |  119 --
 arch/powerpc/platforms/52xx/efika-setup.c          |  150 --
 arch/powerpc/platforms/52xx/efika.c                |  243 +++
 arch/powerpc/platforms/52xx/efika.h                |   19 
 arch/powerpc/platforms/52xx/lite5200.c             |   29 
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |    4 
 arch/powerpc/platforms/52xx/mpc52xx_pic.c          |   10 
 arch/powerpc/platforms/83xx/Kconfig                |   24 
 arch/powerpc/platforms/83xx/Makefile               |    3 
 arch/powerpc/platforms/83xx/mpc8313_rdb.c          |   99 +
 arch/powerpc/platforms/83xx/mpc834x_itx.c          |    2 
 arch/powerpc/platforms/83xx/mpc834x_mds.c          |  213 +++
 arch/powerpc/platforms/83xx/mpc834x_sys.c          |  140 --
 arch/powerpc/platforms/83xx/mpc834x_sys.h          |   23 
 arch/powerpc/platforms/83xx/mpc83xx.h              |   18 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c          |    7 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c          |   17 
 arch/powerpc/platforms/Makefile                    |    2 
 arch/powerpc/platforms/cell/spu_manage.c           |  102 -
 arch/powerpc/platforms/cell/spufs/context.c        |   12 
 arch/powerpc/platforms/cell/spufs/file.c           |  137 +-
 arch/powerpc/platforms/cell/spufs/spufs.h          |    2 
 arch/powerpc/platforms/celleb/htab.c               |   19 
 arch/powerpc/platforms/embedded6xx/linkstation.c   |   12 
 arch/powerpc/platforms/ps3/spu.c                   |   42 -
 arch/powerpc/platforms/pseries/pci.c               |    4 
 arch/powerpc/sysdev/fsl_soc.c                      |   78 +
 arch/powerpc/sysdev/qe_lib/ucc_slow.c              |    6 
 arch/ppc/configs/taishan_defconfig                 | 1077 +++++++++++++++
 arch/ppc/kernel/ppc_ksyms.c                        |    2 
 arch/ppc/mm/pgtable.c                              |    2 
 arch/ppc/platforms/4xx/Kconfig                     |   10 
 arch/ppc/platforms/4xx/Makefile                    |    1 
 arch/ppc/platforms/4xx/taishan.c                   |  395 ++++++
 arch/ppc/platforms/4xx/taishan.h                   |   67 +
 arch/ppc/syslib/Makefile                           |    1 
 drivers/ata/pata_mpc52xx.c                         |    6 
 drivers/macintosh/adbhid.c                         |    4 
 drivers/macintosh/apm_emu.c                        |    2 
 drivers/macintosh/mac_hid.c                        |    4 
 drivers/macintosh/therm_adt746x.c                  |    6 
 drivers/macintosh/via-cuda.c                       |    2 
 drivers/macintosh/via-macii.c                      |   10 
 drivers/macintosh/via-maciisi.c                    |    6 
 drivers/macintosh/via-pmu.c                        |   13 
 drivers/macintosh/via-pmu68k.c                     |    4 
 drivers/serial/mpc52xx_uart.c                      |    5 
 include/asm-powerpc/floppy.h                       |  135 ++
 include/asm-powerpc/systbl.h                       |    1 
 include/asm-powerpc/ucc_slow.h                     |    2 
 include/asm-powerpc/vdso.h                         |    5 
 include/asm-ppc/ibm4xx.h                           |    4 
 70 files changed, 4765 insertions(+), 1029 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/kuroboxHD.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8313erdb.dts
 rename arch/powerpc/boot/dts/{mpc8349emds.dts => mpc834x_mds.dts} (99%)
 create mode 100644 arch/powerpc/configs/mpc8313_rdb_defconfig
 delete mode 100644 arch/powerpc/platforms/52xx/efika-pci.c
 delete mode 100644 arch/powerpc/platforms/52xx/efika-setup.c
 create mode 100644 arch/powerpc/platforms/52xx/efika.c
 delete mode 100644 arch/powerpc/platforms/52xx/efika.h
 create mode 100644 arch/powerpc/platforms/83xx/mpc8313_rdb.c
 create mode 100644 arch/powerpc/platforms/83xx/mpc834x_mds.c
 delete mode 100644 arch/powerpc/platforms/83xx/mpc834x_sys.c
 delete mode 100644 arch/powerpc/platforms/83xx/mpc834x_sys.h
 create mode 100644 arch/ppc/configs/taishan_defconfig
 create mode 100644 arch/ppc/platforms/4xx/taishan.c
 create mode 100644 arch/ppc/platforms/4xx/taishan.h

Akira Iguchi (1):
      [POWERPC] Celleb: improve MMU hashtable locking

Benjamin Herrenschmidt (4):
      [POWERPC] Fix vDSO page count calculation
      [POWERPC] spufs: remove need for struct page for SPEs
      [POWERPC] powerpc: Remove SPU struct pages for PS3
      [POWERPC] spufs: Fix bitrot of the SPU mmap facility

David Gibson (1):
      [POWERPC] Remove ibm4{xx,4x}.h from arch/powerpc

Grant Likely (2):
      [POWERPC] Fixup mp5200 drivers to match device tree changes
      [POWERPC] mpc5200 device tree bindings refinement

Guennadi Liakhovetski (1):
      [POWERPC] Update to linkstation / kurobox support

Kim Phillips (2):
      [POWERPC] 83xx: Add base support for the MPC8313E RDB
      [POWERPC] 83xx: add the mpc8313erdb defconfig

Kumar Gala (3):
      [POWERPC] Fix is_power_of_4(x) compile error
      [POWERPC] 85xx: Marked functions static
      [POWERPC] 83xx: Updated and renamed MPC834x SYS to MPC834x MDS

Li Yang (3):
      [POWERPC] 83xx: Added new dr_mode property for usb controller on 83xx
      [POWERPC] 83xx: Add USB setup code for MPC8349E MDS-PB
      [POWERPC] 83xx: Add platform_device for USB DR peripheral driver

Olaf Hering (3):
      [POWERPC] move variables in drivers/macintosh to bss
      [POWERPC] Mark winbond IDE PCI resources with start 0 as unassigned
      [POWERPC] Correct AC Power: in /proc/pmu/info on ibook1

Pavel Fedin (1):
      [POWERPC] Virtual DMA support for floppy driver for new powerpc architecture

Rojhalat Ibrahim (1):
      [PPC] Fix compile error for e500 core based processors

Stefan Roese (1):
      [POWERPC] ppc: Add support for AMCC Taishan 440GX eval board

Stephen Rothwell (2):
      [POWERPC] Wire up sys_getcpu
      [POWERPC] correct a prototype

Sylvain Munaut (5):
      [POWERPC] Add device tree fixups for the EFIKA
      [POWERPC] Restore 'proper' link order in platform
      [POWERPC] Use common 52xx of_platform probe code for EFIKA
      [POWERPC] Fix unbalanced of_node_{get,put} in efika-setup.c
      [POWERPC] Small cleanup of EFIKA platform

Timur Tabi (1):
      [POWERPC] QE: Rename ucc_slow_info.us_regs to ucc_slow_info.regs
