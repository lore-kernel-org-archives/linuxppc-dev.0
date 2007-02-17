Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17878.61905.316569.773889@cargo.ozlabs.ibm.com>
Date: Sat, 17 Feb 2007 23:15:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git master branch
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

The commits there are mostly minor bug fixes and cleanups.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt |   14 -
 arch/powerpc/Kconfig                         |    9 
 arch/powerpc/boot/dts/kuroboxHD.dts          |    1 
 arch/powerpc/boot/dts/kuroboxHG.dts          |    1 
 arch/powerpc/boot/dts/mpc7448hpc2.dts        |    1 
 arch/powerpc/boot/dts/mpc8272ads.dts         |    1 
 arch/powerpc/boot/dts/mpc8323emds.dts        |    1 
 arch/powerpc/boot/dts/mpc8360emds.dts        |    1 
 arch/powerpc/boot/dts/mpc8560ads.dts         |    1 
 arch/powerpc/boot/dts/mpc8641_hpcn.dts       |    1 
 arch/powerpc/boot/dts/mpc866ads.dts          |    1 
 arch/powerpc/boot/dts/mpc885ads.dts          |    1 
 arch/powerpc/configs/cell_defconfig          |    1 
 arch/powerpc/configs/ppc64_defconfig         |    4 
 arch/powerpc/configs/pseries_defconfig       |    4 
 arch/powerpc/kernel/prom.c                   |    1 
 arch/powerpc/kernel/prom_parse.c             |   40 ++
 arch/powerpc/mm/pgtable_64.c                 |    2 
 arch/powerpc/platforms/celleb/Makefile       |    3 
 arch/powerpc/platforms/celleb/setup.c        |    2 
 arch/powerpc/platforms/ps3/Kconfig           |   10 
 arch/powerpc/platforms/ps3/setup.c           |   27 +
 arch/powerpc/platforms/pseries/Makefile      |    2 
 arch/powerpc/platforms/pseries/power.c       |   87 ++++
 arch/powerpc/platforms/pseries/pseries.h     |    7 
 arch/powerpc/platforms/pseries/setup.c       |   30 +
 arch/powerpc/sysdev/Makefile                 |    1 
 arch/powerpc/sysdev/fsl_soc.c                |   19 -
 arch/powerpc/sysdev/mpic.c                   |    2 
 arch/powerpc/sysdev/pmi.c                    |  305 +++++++++++++
 drivers/ps3/Makefile                         |    1 
 drivers/ps3/sys-manager.c                    |  604 ++++++++++++++++++++++++++
 drivers/ps3/vuart.c                          |  398 +++++++++++------
 drivers/ps3/vuart.h                          |   59 ++-
 drivers/serial/cpm_uart/cpm_uart_cpm2.c      |    2 
 drivers/serial/mpc52xx_uart.c                |    4 
 drivers/usb/host/ehci-hcd.c                  |   19 +
 drivers/usb/host/ohci-hcd.c                  |   18 +
 include/asm-powerpc/atomic.h                 |   40 ++
 include/asm-powerpc/dcr-native.h             |    4 
 include/asm-powerpc/pmi.h                    |   67 +++
 include/asm-powerpc/prom.h                   |    2 
 include/asm-powerpc/ps3.h                    |   27 -
 43 files changed, 1605 insertions(+), 220 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/power.c
 create mode 100644 arch/powerpc/sysdev/pmi.c
 create mode 100644 drivers/ps3/sys-manager.c
 create mode 100644 include/asm-powerpc/pmi.h

Benjamin Herrenschmidt (1):
      [POWERPC] Fix bug with early ioremap and 64k pages

Christian Krafft (1):
      [POWERPC] Add PMI driver for cell blade

Dave Jones (1):
      [POWERPC] Export of_find_property

David Gibson (1):
      [POWERPC] More DCR native fixups

Geoff Levand (3):
      [POWERPC] PS3: Vuart cleanups
      [POWERPC] PS3: Vuart add async read
      [POWERPC] PS3: System manager support

Ishizaki Kou (3):
      [POWERPC] celleb: fix CONFIG_KEXEC dependency
      [POWERPC] celleb: fix scc_uhc.c dependency
      [POWERPC] ps3: don't call ps3_system_bus_driver_register on other platforms

Johannes Berg (1):
      [POWERPC] mpic: set IPIs to be per-CPU

Manish Ahuja (1):
      [POWERPC] pseries: Enabling auto poweron after power is restored.

Mathieu Desnoyers (1):
      [POWERPC] atomic.h: Add atomic64 cmpxchg, xchg and add_unless to powerpc

Michael Ellerman (1):
      [POWERPC] Fix cut and paste breakage in arch/powerpc/platforms/pseries/pseries.h

Olaf Hering (1):
      [POWERPC] use winbond libata instead of ide driver for pseries CD drives

Paul Gortmaker (1):
      [POWERPC] Fix compile failure in cpm_uart_cpm2

Stuart Yoder (1):
      [POWERPC] powerpc: remove references to the obsolete linux,platform property

Sylvain Munaut (1):
      [POWERPC] Dispose irq mapping when done in mpc52xx_serial.c

Timur Tabi (2):
      [POWERPC] Delete boot-cpu property from all DTS files
      [POWERPC] add of_get_mac_address and update fsl_soc.c to use it
