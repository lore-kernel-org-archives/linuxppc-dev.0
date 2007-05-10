Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17987.4113.974182.825950@cargo.ozlabs.ibm.com>
Date: Thu, 10 May 2007 22:29:05 +1000
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
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git master

to get some more powerpc patches for 2.6.22.  There are various bug
fixes and a few minor cleanups there, plus a 3-liner to wire up
sys_utimensat.

Thanks,
Paul.

 arch/powerpc/boot/dts/mpc832x_mds.dts       |    2 
 arch/powerpc/boot/dts/mpc834x_mds.dts       |    4 
 arch/powerpc/configs/celleb_defconfig       |  129 +++--
 arch/powerpc/kernel/pci_64.c                |   37 +
 arch/powerpc/kernel/prom.c                  |   47 +-
 arch/powerpc/lib/Makefile                   |    2 
 arch/powerpc/lib/rheap.c                    |  117 +++--
 arch/powerpc/mm/hash_native_64.c            |   37 +
 arch/powerpc/platforms/83xx/mpc8313_rdb.c   |    2 
 arch/powerpc/platforms/83xx/mpc832x_rdb.c   |    2 
 arch/powerpc/platforms/83xx/mpc834x_itx.c   |    2 
 arch/powerpc/platforms/83xx/mpc834x_mds.c   |    2 
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c  |    7 
 arch/powerpc/platforms/celleb/pci.c         |    1 
 arch/powerpc/platforms/celleb/scc_epci.c    |    8 
 arch/powerpc/platforms/celleb/setup.c       |    2 
 arch/powerpc/platforms/pseries/eeh.c        |   13 -
 arch/powerpc/platforms/pseries/eeh_driver.c |    7 
 arch/powerpc/platforms/pseries/iommu.c      |    3 
 arch/powerpc/platforms/pseries/kexec.c      |    1 
 arch/powerpc/sysdev/commproc.c              |   20 -
 arch/powerpc/sysdev/cpm2_common.c           |   21 -
 arch/powerpc/sysdev/qe_lib/qe.c             |   29 +
 arch/powerpc/sysdev/qe_lib/ucc_fast.c       |    5 
 arch/powerpc/sysdev/qe_lib/ucc_slow.c       |    7 
 arch/ppc/8xx_io/commproc.c                  |   22 -
 arch/ppc/lib/Makefile                       |    3 
 arch/ppc/lib/rheap.c                        |  692 ---------------------------
 arch/ppc/syslib/cpm2_common.c               |   23 -
 drivers/net/fs_enet/mac-scc.c               |    2 
 drivers/net/ucc_geth.c                      |   30 +
 drivers/serial/cpm_uart/cpm_uart.h          |    2 
 drivers/serial/cpm_uart/cpm_uart_core.c     |    3 
 drivers/serial/cpm_uart/cpm_uart_cpm1.c     |    6 
 drivers/serial/cpm_uart/cpm_uart_cpm2.c     |    6 
 include/asm-powerpc/mmu-hash64.h            |   12 
 include/asm-powerpc/mmzone.h                |    4 
 include/asm-powerpc/ppc-pci.h               |   18 +
 include/asm-powerpc/ps3.h                   |    5 
 include/asm-powerpc/qe.h                    |   13 -
 include/asm-powerpc/reg_booke.h             |  469 ++++++++++++++++++
 include/asm-powerpc/rheap.h                 |   20 -
 include/asm-powerpc/systbl.h                |    1 
 include/asm-powerpc/unistd.h                |    3 
 include/asm-ppc/commproc.h                  |   13 -
 include/asm-ppc/cpm2.h                      |   13 -
 include/linux/pmu.h                         |    2 
 47 files changed, 867 insertions(+), 1002 deletions(-)
 delete mode 100644 arch/ppc/lib/rheap.c
 create mode 100644 include/asm-powerpc/reg_booke.h
 rename include/{asm-ppc/rheap.h => asm-powerpc/rheap.h} (75%)

Becky Bruce (1):
      [POWERPC] Move reg_booke.h to include/asm-powerpc

Geoff Levand (1):
      [POWERPC] PS3: Fix sys manager build error

Ishizaki Kou (4):
      [POWERPC] celleb: Fix support for multiple PCI domains
      [POWERPC] celleb: Fix PCI config space accesses to subordinate buses
      [POWERPC] celleb: Fix parsing of machine type hack command line option
      [POWERPC] celleb: Update celleb_defconfig

Jason Jin (1):
      [POWERPC] 86xx: Enable the AC97 interface on 8641D board.

Kumar Gala (3):
      [POWERPC] 83xx: Suppress warning when CONFIG_ options aren't defined
      [POWERPC] User rheap from arch/powerpc/lib
      [POWERPC] CPM_UART: Removed __init from cpm_uart_init_portdesc to fix warning

Li Yang (1):
      [POWERPC] 83xx: Suppress warning when CONFIG_PCI is not defined

Linas Vepstas (1):
      [POWERPC] Assorted janitorial EEH cleanups

Michael Ellerman (1):
      [POWERPC] Split initrd logic out of early_init_dt_scan_chosen() to fix warning

Michael Neuling (1):
      [POWERPC] Minor pSeries IOMMU debug cleanup

Paul Mackerras (3):
      [POWERPC] Fix incorrect calculation of I/O window addresses
      [POWERPC] Fix warning in hpte_decode(), and generalize it
      [POWERPC] Fix compile error with kexec and CONFIG_SMP=n

Scott Wood (3):
      [POWERPC] CPM_UART: cpm_uart_set_termios should take ktermios, not termios
      [POWERPC] 83xx: Fix the PCI ranges in the MPC832x_MDS device tree.
      [POWERPC] 83xx: Fix the PCI ranges in the MPC834x_MDS device tree.

Stephen Rothwell (3):
      [POWERPC] Wire up sys_utimensat
      [POWERPC] pmu_sys_suspended is only defined for PPC32
      [POWERPC] We don't define CONFIG_HAVE_ARCH_EARLY_PFN_TO_NID

Timur Tabi (1):
      [POWERPC] Change rheap functions to use ulongs instead of pointers
