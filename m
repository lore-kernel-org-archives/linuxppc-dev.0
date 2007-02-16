Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17877.18134.508118.257189@cargo.ozlabs.ibm.com>
Date: Fri, 16 Feb 2007 16:53:26 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: current patches in powerpc.git
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just committed the patches below to the powerpc.git master branch,
and I plan to ask Linus to pull them tomorrow.

Paul.

 Documentation/powerpc/booting-without-of.txt |    5 
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
 arch/powerpc/kernel/prom.c                   |    1 
 arch/powerpc/mm/pgtable_64.c                 |    2 
 arch/powerpc/platforms/celleb/Makefile       |    3 
 arch/powerpc/platforms/celleb/setup.c        |    2 
 arch/powerpc/platforms/ps3/Kconfig           |   10 
 arch/powerpc/platforms/ps3/setup.c           |   27 +
 arch/powerpc/platforms/pseries/pseries.h     |    4 
 arch/powerpc/sysdev/Makefile                 |    1 
 arch/powerpc/sysdev/mpic.c                   |    2 
 arch/powerpc/sysdev/pmi.c                    |  305 +++++++++++++
 drivers/ps3/Makefile                         |    1 
 drivers/ps3/sys-manager.c                    |  604 ++++++++++++++++++++++++++
 drivers/ps3/vuart.c                          |  398 +++++++++++------
 drivers/ps3/vuart.h                          |   59 ++-
 drivers/serial/cpm_uart/cpm_uart_cpm2.c      |    2 
 drivers/usb/host/ehci-hcd.c                  |   19 +
 drivers/usb/host/ohci-hcd.c                  |   18 +
 include/asm-powerpc/atomic.h                 |   40 ++
 include/asm-powerpc/dcr-native.h             |    4 
 include/asm-powerpc/pmi.h                    |   67 +++
 include/asm-powerpc/ps3.h                    |   27 -
 34 files changed, 1428 insertions(+), 193 deletions(-)
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

Mathieu Desnoyers (1):
      [POWERPC] atomic.h: Add atomic64 cmpxchg, xchg and add_unless to powerpc

Michael Ellerman (1):
      [POWERPC] Fix cut and paste breakage in arch/powerpc/platforms/pseries/pseries.h

Paul Gortmaker (1):
      [POWERPC] Fix compile failure in cpm_uart_cpm2

Timur Tabi (1):
      [POWERPC] Delete boot-cpu property from all DTS files
