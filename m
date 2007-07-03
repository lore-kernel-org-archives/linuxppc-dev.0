Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18057.57417.999506.887803@cargo.ozlabs.ibm.com>
Date: Tue, 3 Jul 2007 15:36:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to 2.6.23 branch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches have been added to the for-2.6.23 branch on
powerpc.git.  In addition, the master branch has the merge of the
for-2.6.23 and merge branches, which means that it is up-to-date with
Linus' 2.6.22-rc7 plus the patches I recently asked Linus to pull for
inclusion in 2.6.22.

Paul.

Arnd Bergmann (6):
      [POWERPC] move 82xx/83xx/86xx Kconfig options to platform selection
      [POWERPC] rename add_bridge to avoid namespace clashes
      [POWERPC] mpc82xx_ads build fix
      [POWERPC] kill isa_{io,mem}_base definitions for !PCI
      [POWERPC] fix building without PCI
      [POWERPC] disallow building powermac and tsi108 without PCI

Christoph Hellwig (12):
      [POWERPC] spusched: Switch from workqueues to kthread + timer tick
      [POWERPC] spusched: Dynamic timeslicing for SCHED_OTHER
      [POWERPC] spusched: Update scheduling paramters on every spu_run
      [POWERPC] spusched: fix cpu/node binding
      [POWERPC] spusched: Catch nosched contexts in spu_deactivate
      [POWERPC] spusched: No preemption for nosched contexts
      [POWERPC] spufs: Add tid file
      [POWERPC] spufs: Implement /proc/spu_loadavg
      [POWERPC] spufs: Add stat file to spufs
      [POWERPC] spusched: Disable tick when not needed
      [POWERPC] spusched: Fix runqueue corruption
      [POWERPC] spufs: Add spu stats in sysfs

Jeremy Kerr (5):
      [POWERPC] spusched: Fix timeslice calculations
      [POWERPC] spusched: Print out scheduling tunables with DEBUG
      [POWERPC] spufs: Remove spufs_dir_inode_operations
      [POWERPC] spufs: Trivial whitespace fixes
      [POWERPC] spufs: Fix libassist accounting

Kazunori Asayama (2):
      [POWERPC] spufs: Fix lost events in poll/epoll on mfc
      [POWERPC] spufs: Save dma_tagstatus_R in CSA

Kumar Gala (18):
      [POWERPC] Remove set_cfg_type for PCI indirect users that don't need it
      [POWERPC] 52xx: Remove support for PCI bus_offset
      [POWERPC] Pass the pci_controller into pci_exclude_device
      [POWERPC] Remove hack to determine the 2nd PHBs bus number
      [POWERPC] Remove bus_offset in places its not really used
      [POWERPC] Added self_busno to indicate which bus number the PHB is
      [POWERPC] Removed remnants of bus_offset
      [POWERPC] Added indirect_type to handle variants of PCI ops
      [POWERPC] 86xx: Workaround PCI_PRIMARY_BUS usage
      [POWERPC] Merge asm-ppc/pci-bridge.h into asm-power/pci-bridge.h
      [POWERPC] Remove local_number from pci_controller
      [POWERPC] Removed dead code related to PCI on ppc32
      [POWERPC] Use global_number in ppc32 pci_controller
      [POWERPC] Merge ppc32 and ppc64 pcibios_alloc_controller() prototypes
      [POWERPC] Move pci_bus_to_hose users to pci_bus_to_host
      [POWERPC] Move common PCI code out of pci_32/pci_64
      [POWERPC] Use ppc64 style list management for pci_controller on ppc32
      [POWERPC] Add copyright header to pci-common.c based on pci_{32,64}.c

Sebastian Siewior (2):
      [POWERPC] spufs: fix building spufs/spu_save_dump.h
      [POWERPC] spufs: Add bit definition

Wade Farnsworth (1):
      [POWERPC] 86xx: Add uli1575 pci-bridge sector to MPC8641HPCN dts file.

York Sun (1):
      [POWERPC] Let subordinate transparent bridges be transparent.

Zhang Wei (4):
      [POWERPC] Remove PCI-e errata for MPC8641 silicon ver 1.0
      [POWERPC] 86xx: Avoid system halt if link training isn't at least L0.
      [POWERPC] MPC8641HPCN: Set IDE in ULI1575 to not native mode.
      [POWERPC] 86xx: Created quirk_fsl_pcie_transparent() to initialize bridge resources.

 arch/powerpc/Kconfig                              |    6 
 arch/powerpc/boot/dts/mpc8641_hpcn.dts            |   99 ++++
 arch/powerpc/kernel/Makefile                      |    2 
 arch/powerpc/kernel/pci-common.c                  |  454 ++++++++++++++++++++
 arch/powerpc/kernel/pci_32.c                      |  476 +--------------------
 arch/powerpc/kernel/pci_64.c                      |  391 -----------------
 arch/powerpc/kernel/ppc_ksyms.c                   |    4 
 arch/powerpc/platforms/52xx/efika.c               |    9 
 arch/powerpc/platforms/52xx/mpc52xx_pci.c         |   18 -
 arch/powerpc/platforms/82xx/Kconfig               |    2 
 arch/powerpc/platforms/82xx/mpc82xx_ads.c         |   17 -
 arch/powerpc/platforms/83xx/Kconfig               |    2 
 arch/powerpc/platforms/83xx/mpc8313_rdb.c         |    7 
 arch/powerpc/platforms/83xx/mpc832x_mds.c         |    7 
 arch/powerpc/platforms/83xx/mpc832x_rdb.c         |    7 
 arch/powerpc/platforms/83xx/mpc834x_itx.c         |    7 
 arch/powerpc/platforms/83xx/mpc834x_mds.c         |    7 
 arch/powerpc/platforms/83xx/mpc836x_mds.c         |    7 
 arch/powerpc/platforms/83xx/mpc83xx.h             |    6 
 arch/powerpc/platforms/83xx/pci.c                 |   18 -
 arch/powerpc/platforms/85xx/mpc85xx.h             |    2 
 arch/powerpc/platforms/85xx/mpc85xx_ads.c         |   10 
 arch/powerpc/platforms/85xx/mpc85xx_cds.c         |   17 -
 arch/powerpc/platforms/85xx/mpc85xx_mds.c         |    7 
 arch/powerpc/platforms/85xx/pci.c                 |   11 
 arch/powerpc/platforms/86xx/Kconfig               |    2 
 arch/powerpc/platforms/86xx/mpc86xx.h             |   11 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c        |   12 -
 arch/powerpc/platforms/86xx/pci.c                 |   67 ++-
 arch/powerpc/platforms/Kconfig                    |   24 +
 arch/powerpc/platforms/Kconfig.cputype            |   51 --
 arch/powerpc/platforms/cell/spu_base.c            |   47 ++
 arch/powerpc/platforms/cell/spufs/backing_ops.c   |    6 
 arch/powerpc/platforms/cell/spufs/context.c       |   15 -
 arch/powerpc/platforms/cell/spufs/fault.c         |   29 +
 arch/powerpc/platforms/cell/spufs/file.c          |  122 +++++
 arch/powerpc/platforms/cell/spufs/inode.c         |   10 
 arch/powerpc/platforms/cell/spufs/run.c           |   33 +
 arch/powerpc/platforms/cell/spufs/sched.c         |  476 +++++++++++++++++----
 arch/powerpc/platforms/cell/spufs/spu_restore.c   |    2 
 arch/powerpc/platforms/cell/spufs/spu_save.c      |    2 
 arch/powerpc/platforms/cell/spufs/spufs.h         |   84 +++-
 arch/powerpc/platforms/cell/spufs/switch.c        |   18 +
 arch/powerpc/platforms/chrp/Kconfig               |    1 
 arch/powerpc/platforms/chrp/Makefile              |    3 
 arch/powerpc/platforms/chrp/pci.c                 |    7 
 arch/powerpc/platforms/embedded6xx/Kconfig        |    1 
 arch/powerpc/platforms/embedded6xx/holly.c        |    2 
 arch/powerpc/platforms/embedded6xx/linkstation.c  |   10 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    9 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.h |    5 
 arch/powerpc/platforms/iseries/pci.c              |    2 
 arch/powerpc/platforms/maple/pci.c                |    6 
 arch/powerpc/platforms/pasemi/pci.c               |    4 
 arch/powerpc/platforms/powermac/Kconfig           |    1 
 arch/powerpc/platforms/powermac/pci.c             |   14 -
 arch/powerpc/sysdev/Makefile                      |    3 
 arch/powerpc/sysdev/fsl_pcie.c                    |  171 --------
 arch/powerpc/sysdev/indirect_pci.c                |   44 ++
 arch/powerpc/sysdev/mv64x60_pci.c                 |    7 
 arch/powerpc/sysdev/tsi108_pci.c                  |   10 
 arch/ppc/syslib/Makefile                          |    1 
 arch/ppc/syslib/indirect_pci.c                    |  134 ++++++
 include/asm-powerpc/machdep.h                     |    2 
 include/asm-powerpc/mpc86xx.h                     |    6 
 include/asm-powerpc/pci-bridge.h                  |  129 +++++-
 include/asm-powerpc/pci.h                         |    7 
 include/asm-powerpc/spu.h                         |   24 +
 68 files changed, 1731 insertions(+), 1476 deletions(-)
 create mode 100644 arch/powerpc/kernel/pci-common.c
 delete mode 100644 arch/powerpc/sysdev/fsl_pcie.c
 create mode 100644 arch/ppc/syslib/indirect_pci.c
