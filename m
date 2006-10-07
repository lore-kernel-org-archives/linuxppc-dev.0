Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17703.40590.791171.334403@cargo.ozlabs.ibm.com>
Date: Sat, 7 Oct 2006 22:33:18 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'merge' branch
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
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get a bunch of PowerPC bug fixes and comment and documentation
updates, including fixes for the irq breakage.

Thanks,
Paul.

 arch/powerpc/boot/dts/mpc8349emitx.dts            |  246 +++++++++++++++++++++
 arch/powerpc/boot/of.c                            |    5 
 arch/powerpc/configs/iseries_defconfig            |   86 ++++++-
 arch/powerpc/configs/pseries_defconfig            |    2 
 arch/powerpc/kernel/ibmebus.c                     |    2 
 arch/powerpc/kernel/iommu.c                       |    2 
 arch/powerpc/kernel/irq.c                         |    2 
 arch/powerpc/kernel/prom.c                        |    2 
 arch/powerpc/kernel/prom_parse.c                  |   17 +
 arch/powerpc/kernel/time.c                        |    2 
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |    5 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |    5 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |    7 -
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |    5 
 arch/powerpc/platforms/cell/interrupt.c           |    5 
 arch/powerpc/platforms/cell/spu_base.c            |    6 -
 arch/powerpc/platforms/chrp/setup.c               |    7 -
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    5 
 arch/powerpc/platforms/iseries/irq.c              |   17 +
 arch/powerpc/platforms/iseries/irq.h              |    2 
 arch/powerpc/platforms/iseries/lpevents.c         |    4 
 arch/powerpc/platforms/iseries/mf.c               |    4 
 arch/powerpc/platforms/iseries/smp.c              |    6 -
 arch/powerpc/platforms/iseries/smp.h              |    6 +
 arch/powerpc/platforms/iseries/viopath.c          |    2 
 arch/powerpc/platforms/powermac/pic.c             |   12 +
 arch/powerpc/platforms/powermac/pic.h             |    4 
 arch/powerpc/platforms/powermac/smp.c             |    8 -
 arch/powerpc/platforms/pseries/iommu.c            |    3 
 arch/powerpc/platforms/pseries/setup.c            |    2 
 arch/powerpc/platforms/pseries/xics.c             |    4 
 arch/powerpc/sysdev/cpm2_pic.c                    |    2 
 arch/powerpc/sysdev/cpm2_pic.h                    |    2 
 arch/powerpc/sysdev/fsl_soc.c                     |    9 -
 arch/powerpc/sysdev/i8259.c                       |    2 
 arch/powerpc/sysdev/ipic.c                        |    2 
 arch/powerpc/sysdev/mpic.c                        |    6 -
 arch/powerpc/sysdev/qe_lib/qe_ic.c                |   14 +
 arch/powerpc/sysdev/tsi108_pci.c                  |    3 
 arch/ppc/kernel/time.c                            |    2 
 arch/ppc/platforms/85xx/mpc8560_ads.c             |    6 -
 arch/ppc/platforms/85xx/mpc85xx_cds_common.c      |    6 -
 arch/ppc/platforms/85xx/stx_gp3.c                 |    6 -
 arch/ppc/platforms/85xx/tqm85xx.c                 |    6 -
 arch/ppc/syslib/i8259.c                           |    2 
 arch/ppc/syslib/open_pic.c                        |   14 +
 drivers/char/viocons.c                            |    2 
 include/asm-powerpc/i8259.h                       |    4 
 include/asm-powerpc/ibmebus.h                     |    2 
 include/asm-powerpc/ipic.h                        |    4 
 include/asm-powerpc/iseries/hv_lp_event.h         |    2 
 include/asm-powerpc/iseries/it_lp_queue.h         |    2 
 include/asm-powerpc/machdep.h                     |    2 
 include/asm-powerpc/mpic.h                        |    4 
 include/asm-powerpc/reg.h                         |    2 
 include/asm-ppc/floppy.h                          |    6 -
 include/asm-ppc/machdep.h                         |    2 
 include/asm-ppc/open_pic.h                        |    6 -
 include/asm-ppc/smp.h                             |    2 
 59 files changed, 453 insertions(+), 154 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/mpc8349emitx.dts
 create mode 100644 arch/powerpc/platforms/iseries/smp.h

Anton Blanchard:
      [POWERPC] Update MTFSF_L() comment

Benjamin Herrenschmidt:
      [POWERPC] Fix zImage decompress location
      [POWERPC] Don't get PCI IRQ from OF for devices with no IRQ

Brian King:
      [POWERPC] Update pSeries defconfig for SATA

Geoff Levand:
      [POWERPC] Minor fix for bootargs property

Nathan Lynch:
      [POWERPC] linux,tce-size property is 32 bits

Nick Piggin:
      [POWERPC] Fix harmless typo

Olaf Hering:
      [POWERPC] Fix up after irq changes
      [POWERPC] SPU fixup after irq changes
      [POWERPC] PReP fixup after irq changes

Olof Johansson:
      [POWERPC] Fix fsl_soc build breaks

Paul Mackerras:
      [PPC] Fix some irq breakage with ARCH=ppc

Stephen Rothwell:
      [POWERPC] Update iseries_defconfig
      [POWERPC] Fix viocons for irq breakage
      [POWERPC] Fix iseries/smp.c for irq breakage

Timur Tabi:
      [POWERPC] Add DTS for MPC8349E-mITX board
