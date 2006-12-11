Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17789.53149.71762.21540@cargo.ozlabs.ibm.com>
Date: Tue, 12 Dec 2006 08:37:33 +1100
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

to get another PowerPC update, with the commits listed below.

Thanks,
Paul.

 arch/powerpc/Kconfig                         |    8 
 arch/powerpc/configs/ps3_defconfig           |    1 
 arch/powerpc/kernel/Makefile                 |    1 
 arch/powerpc/kernel/cputable.c               |    5 
 arch/powerpc/kernel/head_32.S                |    7 
 arch/powerpc/kernel/module_32.c              |   23 -
 arch/powerpc/kernel/module_64.c              |   23 -
 arch/powerpc/kernel/of_device.c              |    4 
 arch/powerpc/kernel/of_platform.c            |    2 
 arch/powerpc/kernel/pci_32.c                 |  143 ++--
 arch/powerpc/kernel/pci_64.c                 |   42 +
 arch/powerpc/kernel/ppc_ksyms.c              |    2 
 arch/powerpc/kernel/prom.c                   |   55 +
 arch/powerpc/kernel/prom_init.c              |    2 
 arch/powerpc/kernel/rtas.c                   |   35 -
 arch/powerpc/kernel/sysfs.c                  |   16 
 arch/powerpc/kernel/traps.c                  |   56 --
 arch/powerpc/kernel/vmlinux.lds.S            |    6 
 arch/powerpc/mm/numa.c                       |   65 ++
 arch/powerpc/platforms/52xx/lite5200.c       |    2 
 arch/powerpc/platforms/cell/cbe_thermal.c    |    2 
 arch/powerpc/platforms/cell/pmu.c            |    5 
 arch/powerpc/platforms/cell/spufs/coredump.c |    2 
 arch/powerpc/platforms/maple/pci.c           |    2 
 arch/powerpc/platforms/maple/setup.c         |   12 
 arch/powerpc/platforms/ps3/Kconfig           |   11 
 arch/powerpc/platforms/pseries/Makefile      |    2 
 arch/powerpc/platforms/pseries/eeh.c         |    1 
 arch/powerpc/platforms/pseries/eeh_driver.c  |   13 
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  275 +++++++
 arch/powerpc/platforms/pseries/setup.c       |   30 -
 arch/powerpc/platforms/pseries/smp.c         |  200 -----
 arch/powerpc/sysdev/Makefile                 |    3 
 arch/powerpc/sysdev/dcr.S                    |   39 -
 arch/powerpc/sysdev/qe_lib/qe_ic.c           |   40 -
 arch/powerpc/sysdev/rom.c                    |    1 
 arch/powerpc/xmon/xmon.c                     |   10 
 arch/ppc/kernel/pci.c                        |   41 +
 drivers/ps3/Makefile                         |    1 
 drivers/ps3/vuart.c                          |  965 ++++++++++++++++++++++++++
 drivers/ps3/vuart.h                          |   94 +++
 include/asm-powerpc/Kbuild                   |    2 
 include/asm-powerpc/bug.h                    |   80 +-
 include/asm-powerpc/cputable.h               |   16 
 include/asm-powerpc/dcr-native.h             |   37 +
 include/asm-powerpc/dcr.h                    |    2 
 include/asm-powerpc/hw_irq.h                 |   19 -
 include/asm-powerpc/module.h                 |    2 
 include/asm-powerpc/pci-bridge.h             |    4 
 include/asm-powerpc/pci.h                    |   33 +
 include/asm-powerpc/reg.h                    |    2 
 include/asm-powerpc/rtas.h                   |    3 
 include/asm-ppc/pci-bridge.h                 |    8 
 include/asm-ppc/pci.h                        |   23 +
 include/asm-ppc/reg_booke.h                  |   36 -
 include/linux/fsl_devices.h                  |    1 
 56 files changed, 1884 insertions(+), 631 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/hotplug-cpu.c
 delete mode 100644 arch/powerpc/sysdev/dcr.S
 create mode 100644 drivers/ps3/vuart.c
 create mode 100644 drivers/ps3/vuart.h

Anton Blanchard:
      [POWERPC] Add DSCR SPR to sysfs
      [POWERPC] Add SPURR SPR to sysfs
      [POWERPC] micro optimise pSeries_probe
      [POWERPC] dont allow pSeries_probe to succeed without initialising MMU

Arnd Bergmann:
      [POWERPC] cell: Fix spu_info.h header export

Benjamin Herrenschmidt:
      [POWERPC] Fix mmap of PCI resource with hack for X
      [POWERPC] Fix irq routing on some 32-bit PowerMacs
      [POWERPC] Remove old dcr.S

Christian Krafft:
      [POWERPC] cbe_thermal: Fix initialization of sysfs attribute_group

Geert Uytterhoeven:
      [POWERPC] of_platform_make_bus_id(): make `magic' int

Geoff Levand:
      [POWERPC] powerpc: fix build error in rom.c
      [POWERPC] ps3: Add vuart support

Jeremy Fitzhardinge:
      [POWERPC] Generic BUG for powerpc

Kim Phillips:
      [POWERPC] Add support for FP emulation for the e300c2 core

Kumar Gala:
      [POWERPC] of_device_register: propagate device_create_file return code
      [POWERPC] Fix 440SPe CPU table entry
      [POWERPC] Only export __mtdcr/__mfdcr if CONFIG_PPC_DCR is set
      [PPC] Fix compile failure do to introduction of PHY_POLL

Linas Vepstas:
      [POWERPC] EEH recovery tweaks

Matthew Wilcox:
      [POWERPC] Delete unused irq functions on powerpc

Michael Ellerman:
      [POWERPC] Move rtas_stop_self() into platforms/pseries/hotplug-cpu.c
      [POWERPC] Move pSeries_mach_cpu_die() into platforms/pseries/hotplug-cpu.c
      [POWERPC] Move the rest of the hotplug cpu code into platforms/pseries/hotplug-cpu.c
      [POWERPC] Only enable cpu hotplug via RTAS if the required firmware support is found
      [POWERPC] Cleanup pass over platforms/pseries/hotplug-cpu.c

Nathan Lynch:
      [POWERPC] maple: Match "pcie" name for CPC945
      [POWERPC] maple: Select PPC_RTAS
      [POWERPC] Add rtas_service_present() helper
      [POWERPC] maple: Use RTAS for reboot and halt

Paul Mackerras:
      [POWERPC] Support ibm,dynamic-reconfiguration-memory nodes
      [POWERPC] Fix SPU coredump code for max_fdset removal

Roland Dreier:
      [POWERPC] Define pci_unmap_addr() et al. when CONFIG_NOT_COHERENT_CACHE=y

Scott Wood:
      [POWERPC] qe_ic: Do a sync when masking interrupts

Stephen Rothwell:
      [POWERPC] Fix cell pmu initialisation
      [POWERPC] iSeries: head_64.o needs to depend on lparmap.s

Timur Tabi:
      [POWERPC] Remove QE header files from lite5200.c
