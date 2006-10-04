Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17699.45225.614110.388085@cargo.ozlabs.ibm.com>
Date: Wed, 4 Oct 2006 23:01:29 +1000
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

to get some more PowerPC updates.

This includes a series from Leo Li and Kim Phillips adding support for
devices on the Freescale 83xx chips, a series from Stephen Rothwell
that means we can include support for legacy iSeries along with other
64-bit platforms, a series from Vitaly Bordug adding support for the
mpc8272ads board, and various bug fixes and cleanups.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt |  252 ++++++
 arch/powerpc/Kconfig                         |   21 -
 arch/powerpc/boot/dts/mpc8272ads.dts         |  223 ++++++
 arch/powerpc/boot/dts/mpc8360emds.dts        |  375 ++++++++++
 arch/powerpc/boot/zImage.coff.lds.S          |    1 
 arch/powerpc/configs/mpc8360emds_defconfig   | 1018 ++++++++++++++++++++++++++
 arch/powerpc/kernel/cputable.c               |   15 
 arch/powerpc/kernel/entry_64.S               |   18 
 arch/powerpc/kernel/head_64.S                |   28 +
 arch/powerpc/kernel/misc_64.S                |   46 +
 arch/powerpc/kernel/pci_64.c                 |   58 +
 arch/powerpc/kernel/setup-common.c           |   25 -
 arch/powerpc/kernel/setup_32.c               |    8 
 arch/powerpc/kernel/setup_64.c               |   12 
 arch/powerpc/kernel/vmlinux.lds.S            |    8 
 arch/powerpc/mm/pgtable_64.c                 |   29 -
 arch/powerpc/mm/slb_low.S                    |    3 
 arch/powerpc/platforms/82xx/Kconfig          |   21 +
 arch/powerpc/platforms/82xx/Makefile         |    5 
 arch/powerpc/platforms/82xx/m82xx_pci.h      |   19 
 arch/powerpc/platforms/82xx/mpc82xx.c        |  111 +++
 arch/powerpc/platforms/82xx/mpc82xx_ads.c    |  661 +++++++++++++++++
 arch/powerpc/platforms/82xx/pq2ads.h         |   67 ++
 arch/powerpc/platforms/83xx/Kconfig          |   13 
 arch/powerpc/platforms/83xx/mpc832x_mds.c    |  215 +++++
 arch/powerpc/platforms/83xx/mpc832x_mds.h    |   19 
 arch/powerpc/platforms/83xx/mpc8360e_pb.c    |  219 ++++++
 arch/powerpc/platforms/cell/interrupt.c      |  235 ++++--
 arch/powerpc/platforms/cell/interrupt.h      |   97 ++
 arch/powerpc/platforms/cell/spider-pic.c     |    9 
 arch/powerpc/platforms/cell/spu_base.c       |   19 
 arch/powerpc/platforms/iseries/pci.c         |    8 
 arch/powerpc/platforms/iseries/setup.c       |   16 
 arch/powerpc/platforms/powermac/udbg_scc.c   |   14 
 arch/powerpc/platforms/pseries/setup.c       |    2 
 arch/powerpc/sysdev/Makefile                 |    1 
 arch/powerpc/sysdev/cpm2_pic.c               |    2 
 arch/powerpc/sysdev/cpm2_pic.h               |    2 
 arch/powerpc/sysdev/fsl_soc.c                |   62 +-
 arch/powerpc/sysdev/qe_lib/Kconfig           |   30 +
 arch/powerpc/sysdev/qe_lib/Makefile          |    8 
 arch/powerpc/sysdev/qe_lib/qe.c              |  353 +++++++++
 arch/powerpc/sysdev/qe_lib/qe_ic.c           |  555 ++++++++++++++
 arch/powerpc/sysdev/qe_lib/qe_ic.h           |  106 +++
 arch/powerpc/sysdev/qe_lib/qe_io.c           |  226 ++++++
 arch/powerpc/sysdev/qe_lib/ucc.c             |  251 ++++++
 arch/powerpc/sysdev/qe_lib/ucc_fast.c        |  396 ++++++++++
 arch/powerpc/sysdev/qe_lib/ucc_slow.c        |  404 ++++++++++
 arch/powerpc/xmon/xmon.c                     |   35 +
 drivers/block/swim3.c                        |    4 
 drivers/char/hvc_iseries.c                   |    8 
 drivers/char/hvc_vio.c                       |    4 
 include/asm-powerpc/firmware.h               |   67 +-
 include/asm-powerpc/immap_qe.h               |  477 ++++++++++++
 include/asm-powerpc/qe.h                     |  457 ++++++++++++
 include/asm-powerpc/qe_ic.h                  |   64 ++
 include/asm-powerpc/system.h                 |    4 
 include/asm-powerpc/ucc.h                    |   84 ++
 include/asm-powerpc/ucc_fast.h               |  243 ++++++
 include/asm-powerpc/ucc_slow.h               |  289 +++++++
 include/asm-powerpc/xmon.h                   |   26 -
 include/linux/fsl_devices.h                  |   65 +-
 62 files changed, 7809 insertions(+), 304 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8272ads.dts
 create mode 100644 arch/powerpc/boot/dts/mpc8360emds.dts
 create mode 100644 arch/powerpc/configs/mpc8360emds_defconfig
 create mode 100644 arch/powerpc/platforms/82xx/Kconfig
 create mode 100644 arch/powerpc/platforms/82xx/Makefile
 create mode 100644 arch/powerpc/platforms/82xx/m82xx_pci.h
 create mode 100644 arch/powerpc/platforms/82xx/mpc82xx.c
 create mode 100644 arch/powerpc/platforms/82xx/mpc82xx_ads.c
 create mode 100644 arch/powerpc/platforms/82xx/pq2ads.h
 create mode 100644 arch/powerpc/platforms/83xx/mpc832x_mds.c
 create mode 100644 arch/powerpc/platforms/83xx/mpc832x_mds.h
 create mode 100644 arch/powerpc/platforms/83xx/mpc8360e_pb.c
 create mode 100644 arch/powerpc/sysdev/qe_lib/Kconfig
 create mode 100644 arch/powerpc/sysdev/qe_lib/Makefile
 create mode 100644 arch/powerpc/sysdev/qe_lib/qe.c
 create mode 100644 arch/powerpc/sysdev/qe_lib/qe_ic.c
 create mode 100644 arch/powerpc/sysdev/qe_lib/qe_ic.h
 create mode 100644 arch/powerpc/sysdev/qe_lib/qe_io.c
 create mode 100644 arch/powerpc/sysdev/qe_lib/ucc.c
 create mode 100644 arch/powerpc/sysdev/qe_lib/ucc_fast.c
 create mode 100644 arch/powerpc/sysdev/qe_lib/ucc_slow.c
 create mode 100644 include/asm-powerpc/immap_qe.h
 create mode 100644 include/asm-powerpc/qe.h
 create mode 100644 include/asm-powerpc/qe_ic.h
 create mode 100644 include/asm-powerpc/ucc.h
 create mode 100644 include/asm-powerpc/ucc_fast.h
 create mode 100644 include/asm-powerpc/ucc_slow.h

Benjamin Herrenschmidt:
      [POWERPC] Cell interrupt rework
      [POWERPC] Fix zImage.coff on oldworld PowerMac
      [POWERPC] Get default baud rate in udbg_scc

Kim Phillips:
      [POWERPC] Add initial support for the e300c2 core
      [POWERPC] Add support for the mpc832x mds board

Li Yang:
      [POWERPC] Add QE device tree node definition
      [POWERPC] Add QUICC Engine (QE) infrastructure
      [POWERPC] Add MPC8360EMDS board support
      [POWERPC] Add MPC8360EMDS default dts file

Michael Ellerman:
      [POWERPC] Cleanup include/asm-powerpc/xmon.h
      [POWERPC] Fix xmon=off and cleanup xmon initialisation
      [POWERPC] Fix a printk in pseries_mpic_init_IRQ

Olaf Hering:
      [POWERPC] Update swim3 printk after blkdev.h change

Paul Mackerras:
      [POWERPC] Don't try to just continue if xmon has no input device

Stephen Rothwell:
      [POWERPC] iSeries: set FW_FEATURE_ISERIES earlier
      [POWERPC] The two vio HVC backends clash
      [POWERPC] modify PCI code for a merged kernel
      [POWERPC] fix ioremap for a combined kernel
      [POWERPC] Allow combined iSeries and MULTIPLATFORM build
      [POWERPC] iSeries does not need pcibios_fixup_resources
      [POWERPC] implement BEGIN/END_FW_FTR_SECTION
      [POWERPC] iSeries has no legacy I/O

Vitaly Bordug:
      POWERPC: Added devicetree for mpc8272ads board
      POWERPC: 8272ads merge to powerpc: common stuff
      POWERPC: mpc82xx merge: board-specific/platform stuff(resend)
