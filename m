Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17582.17835.641485.233064@cargo.ozlabs.ibm.com>
Date: Fri, 7 Jul 2006 21:29:47 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: patches added to powerpc.git tree
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches have been pushed to the powerpc.git tree (master
branch):

Benjamin Herrenschmidt:
      [POWERPC] Workaround Pegasos incorrect ISA "ranges"
      [POWERPC] Fix 32 bits warning in prom_init.c
      [POWERPC] Fix non-MPIC CHRPs with CONFIG_SMP set
      [POWERPC] Fix default clock for udbg_16550
      [POWERPC] Fix legacy_serial.c error handling on 32 bits
      [POWERPC] Add briq support to CHRP
      [POWERPC] Add support for briq front panel
      [POWERPC] More offb/bootx fixes
      [POWERPC] Xserve G5 thermal control fixes
      [POWERPC] Add cpufreq support for Xserve G5

Jeremy Kerr:
      [POWERPC] Remove linux,device properties
      [POWERPC] Use const qualifiers for prom parsing utilites
      [POWERPC] Remove linux,pci-domain properties

Johannes Berg:
      [POWERPC] fix up front-LED Kconfig

Michael Ellerman:
      [POWERPC] Fix mem= handling when the memory limit is > RMO size

Niels Kristian Bech Jensen:
      [POWERPC] Add -fno-stack-protector to BOOTCFLAGS in arch/powerpc/boot/Makefile.

 arch/powerpc/Kconfig                         |    2 
 arch/powerpc/boot/Makefile                   |    4 
 arch/powerpc/configs/pmac32_defconfig        |  112 ++++++++-
 arch/powerpc/kernel/legacy_serial.c          |   13 +
 arch/powerpc/kernel/of_device.c              |   24 --
 arch/powerpc/kernel/pci_64.c                 |   39 ---
 arch/powerpc/kernel/prom_init.c              |   42 ++++
 arch/powerpc/kernel/prom_parse.c             |   22 +-
 arch/powerpc/kernel/smp.c                    |   24 +-
 arch/powerpc/kernel/udbg_16550.c             |    6 -
 arch/powerpc/mm/lmb.c                        |    3 
 arch/powerpc/platforms/chrp/pci.c            |   42 +++-
 arch/powerpc/platforms/chrp/setup.c          |   39 +++
 arch/powerpc/platforms/powermac/bootx_init.c |   35 ++-
 arch/powerpc/platforms/powermac/cpufreq_64.c |   78 ++++---
 drivers/char/Kconfig                         |   14 +
 drivers/char/Makefile                        |    1 
 drivers/char/briq_panel.c                    |  268 +++++++++++++++++++++++
 drivers/ide/Kconfig                          |   14 -
 drivers/macintosh/Kconfig                    |    9 +
 drivers/macintosh/therm_pm72.c               |  218 +++++++++++++++++-
 drivers/macintosh/therm_pm72.h               |   33 +++
 drivers/macintosh/via-pmu-led.c              |    2 
 drivers/video/offb.c                         |  307 ++++++++++++++------------
 include/asm-powerpc/processor.h              |    1 
 include/asm-powerpc/prom.h                   |    2 
 26 files changed, 1023 insertions(+), 331 deletions(-)
 create mode 100644 drivers/char/briq_panel.c
