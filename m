Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18088.36671.181395.477326@cargo.ozlabs.ibm.com>
Date: Thu, 26 Jul 2007 22:10:39 +1000
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

to get some bug-fixes for powerpc, as listed below.

Thanks,
Paul.

 arch/powerpc/Kconfig.debug                  |    2 -
 arch/powerpc/boot/dts/kuroboxHD.dts         |   18 +++++---
 arch/powerpc/boot/dts/kuroboxHG.dts         |   19 +++++---
 arch/powerpc/boot/dts/mpc7448hpc2.dts       |    2 -
 arch/powerpc/boot/dts/mpc8544ds.dts         |    8 ++++
 arch/powerpc/boot/dts/mpc8568mds.dts        |    6 +++
 arch/powerpc/kernel/head_64.S               |    7 ++-
 arch/powerpc/kernel/iomap.c                 |    8 +++-
 arch/powerpc/kernel/irq.c                   |    8 ++--
 arch/powerpc/kernel/pci-common.c            |   25 +++++++++++
 arch/powerpc/kernel/pci_32.c                |   20 ++++++++-
 arch/powerpc/kernel/process.c               |    4 ++
 arch/powerpc/kernel/prom_parse.c            |    2 -
 arch/powerpc/kernel/setup-common.c          |    4 ++
 arch/powerpc/kernel/udbg.c                  |    2 -
 arch/powerpc/mm/lmb.c                       |    4 +-
 arch/powerpc/platforms/cell/spufs/context.c |    3 +
 arch/powerpc/platforms/cell/spufs/run.c     |    4 ++
 arch/powerpc/platforms/cell/spufs/sched.c   |    4 --
 arch/powerpc/platforms/iseries/lpevents.c   |    2 -
 arch/powerpc/platforms/maple/pci.c          |    3 +
 arch/powerpc/sysdev/fsl_pci.c               |    4 +-
 arch/powerpc/sysdev/fsl_soc.c               |   61 +++++++++++++++++++++++++++
 arch/powerpc/sysdev/indirect_pci.c          |    1 
 include/asm-powerpc/pci-bridge.h            |   20 +++++++++
 include/asm-powerpc/ppc_asm.h               |   12 +++++
 include/asm-powerpc/vio.h                   |    5 ++
 27 files changed, 221 insertions(+), 37 deletions(-)

Alan Curry (1):
      [POWERPC] Fix Pegasos keyboard detection

Benjamin Herrenschmidt (3):
      [POWERPC] Add function to check if address is an IO port
      [POWERPC] Make pci_iounmap actually unmap things
      [POWERPC] Fix Maple platform ISA bus

Christoph Hellwig (1):
      [POWERPC] spusched: Fix initial timeslice calculation

Guennadi Liakhovetski (2):
      [POWERPC] Add of_register_i2c_devices()
      [POWERPC] Fix RTC and device tree on linkstation machines

Kumar Gala (6):
      [POWERPC] Fix PCI indirect for big-endian cfg_addr
      [POWERPC] Don't try to allocate resources for a Freescale POWERPC PHB
      [POWERPC] Fix ethernet PHY support on MPC8544 DS
      [POWREPC] Fixup a number of modpost warnings on ppc32
      [POWERPC] Only allow building of BootX text support on PPC_MULTIPLATFORM
      [POWERPC] Fix register labels on show_regs() message for 4xx/Book-E

Manish Ahuja (1):
      [POWERPC] Fix loop with unsigned long counter variable

Masato Noguchi (1):
      [POWERPC] spufs: Fix incorrect initialization of cbe_spu_info.spus

Paul Mackerras (1):
      Revert "[POWERPC] Don't complain if size-cells == 0 in prom_parse()"

Roy Zang (2):
      [POWERPC] Fix mpc7448hpc2 tsi108 device_type bug
      [POWERPC] Fix the ability to reset on MPC8544 DS and MPC8568 MDS boards

Stephen Rothwell (3):
      [POWERPC] iSeries: We need vio_enable_interrupts
      [POWERPC] iSeries: Fix section mismatch warnings
      [POWERPC] iSeries: Fix section mismatch warning in lpevents
