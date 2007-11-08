Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18226.56504.711428.743802@cargo.ozlabs.ibm.com>
Date: Thu, 8 Nov 2007 20:54:00 +1100
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

to get a bunch of bug-fixes, documentation updates and defconfig
updates for powerpc.

Thanks,
Paul.

 Documentation/powerpc/booting-without-of.txt |  275 +++++++++++++++++++++++
 arch/powerpc/boot/dts/walnut.dts             |    4 
 arch/powerpc/boot/wrapper                    |   43 ++--
 arch/powerpc/configs/pasemi_defconfig        |  308 ++++++++++++++++----------
 arch/powerpc/configs/ppc64_defconfig         |  247 +++++++++++++++------
 arch/powerpc/kernel/cputable.c               |   36 ++-
 arch/powerpc/kernel/entry_32.S               |   23 ++
 arch/powerpc/kernel/head_64.S                |    2 
 arch/powerpc/kernel/idle.c                   |    2 
 arch/powerpc/kernel/misc_32.S                |   32 ++-
 arch/powerpc/kernel/prom.c                   |   12 +
 arch/powerpc/kernel/prom_init.c              |    2 
 arch/powerpc/kernel/setup_64.c               |   19 +-
 arch/powerpc/kernel/swsusp_32.S              |    2 
 arch/powerpc/kernel/time.c                   |   10 -
 arch/powerpc/kernel/vmlinux.lds.S            |    3 
 arch/powerpc/mm/40x_mmu.c                    |   17 +
 arch/powerpc/mm/44x_mmu.c                    |    1 
 arch/powerpc/mm/fault.c                      |    2 
 arch/powerpc/mm/hash_low_64.S                |    5 
 arch/powerpc/mm/hash_utils_64.c              |    7 -
 arch/powerpc/mm/mmu_decl.h                   |    4 
 arch/powerpc/mm/slb.c                        |   35 +++
 arch/powerpc/platforms/cell/interrupt.c      |   24 +-
 arch/powerpc/platforms/cell/smp.c            |    1 
 arch/powerpc/platforms/celleb/setup.c        |    1 
 arch/powerpc/platforms/iseries/irq.h         |    4 
 arch/powerpc/platforms/iseries/setup.c       |    4 
 arch/powerpc/platforms/iseries/vio.c         |   10 +
 arch/powerpc/platforms/pseries/eeh.c         |   13 +
 arch/powerpc/platforms/pseries/eeh_driver.c  |   18 +-
 arch/powerpc/platforms/pseries/firmware.c    |    1 
 arch/powerpc/platforms/pseries/msi.c         |    6 +
 arch/powerpc/sysdev/i8259.c                  |    1 
 arch/powerpc/sysdev/mv64x60_pci.c            |   10 +
 arch/ppc/kernel/entry.S                      |   23 ++
 arch/ppc/kernel/misc.S                       |   31 ++-
 arch/ppc/mm/44x_mmu.c                        |    1 
 arch/ppc/mm/4xx_mmu.c                        |   17 +
 arch/ppc/mm/fault.c                          |    2 
 arch/ppc/mm/mmu_decl.h                       |    4 
 arch/ppc/platforms/4xx/ebony.c               |    2 
 arch/ppc/platforms/4xx/luan.c                |    7 +
 arch/ppc/platforms/4xx/ocotea.c              |    2 
 arch/ppc/platforms/4xx/taishan.c             |    2 
 arch/ppc/syslib/i8259.c                      |    1 
 arch/ppc/syslib/m8260_setup.c                |   13 +
 drivers/macintosh/windfarm_core.c            |   10 -
 drivers/serial/uartlite.c                    |   10 +
 include/asm-powerpc/pgtable-ppc32.h          |   13 +
 include/asm-powerpc/systbl.h                 |    2 
 include/asm-powerpc/time.h                   |   20 +-
 include/asm-powerpc/tlbflush.h               |   12 +
 53 files changed, 996 insertions(+), 360 deletions(-)

Alexey Dobriyan (1):
      [POWERPC] Fix sysctl table check failure on PowerMac

Aurelien Jarno (1):
      [POWERPC] i8259: Add disable method

Benjamin Herrenschmidt (5):
      [POWERPC] powerpc: Fix demotion of segments to 4K pages
      [POWERPC] 4xx: Fix 4xx flush_tlb_page()
      [POWERPC] 4xx: Deal with 44x virtually tagged icache
      [POWERPC] Fix cache line vs. block size confusion
      [POWERPC] Fix si_addr value on low level hash failures

Dale Farnsworth (1):
      [POWERPC] Fix mv643xx_pci sysfs .read and .write functions

Grant Likely (5):
      [POWERPC] bootwrapper: Allow wrapper script to execute verbosely
      [POWERPC] bootwrapper: Bail from script if any command fails
      [POWERPC] Device tree bindings for Xilinx devices
      [POWERPC] Uartlite: speed up console output
      [POWERPC] ppc405 Fix arithmatic rollover bug when memory size under 16M

Johannes Berg (2):
      [POWERPC] windfarm: Fix windfarm thread freezer interaction
      [POWERPC] Make altivec code in swsusp_32.S depend on CONFIG_ALTIVEC

Li Zefan (1):
      [POWERPC] ] Fix memset size error

Linas Vepstas (4):
      [POWERPC] EEH: Clean up comments
      [POWERPC] EEH: Drivers that need reset trump others
      [POWERPC] EEH: Avoid crash on null device
      [POWERPC] EEH: Make sure warning message is printed

Michael Ellerman (1):
      [POWERPC] Read back MSI message in rtas_setup_msi_irqs() so restore works

Olof Johansson (4):
      [POWERPC] Fix build break in arch/ppc/syslib/m8260_setup.c
      [POWERPC] Fix CONFIG_SMP=n build break
      [POWERPC] pasemi: Update defconfig
      [POWERPC] Refresh ppc64_defconfig and enable pasemi-related options

Patrick Mansfield (1):
      [POWERPC] Change fallocate to match unistd.h on powerpc

Paul Mackerras (1):
      [POWERPC] Fix off-by-one error in setting decrementer on Book E/4xx (v2)

Roel Kluin (1):
      [POWERPC] allocation fix in ppc/platforms/4xx/luan.c

Scott Wood (1):
      [POWERPC] bootwrapper: Revert ps3 binary flag usage, and remove .bin suffix

Stephen Rothwell (3):
      [POWERPC] iSeries_init_IRQ non-PCI tidy
      [POWERPC] Fix link errors for allyesconfig
      [POWERPC] iSeries: Fix ref counting in vio setup

Steven A. Falco (1):
      [POWERPC] 4xx: Fix Walnut DTS interrupt property

Tony Breeds (1):
      [POWERPC] Fix build failure when CONFIG_VIRT_CPU_ACCOUNTING is not defined

Valentine Barshak (1):
      [POWERPC] 4xx: Workaround for the 440EP(x)/GR(x) processors identical PVR issue.

will schmidt (2):
      [POWERPC] Include udbg.h when using udbg_printf
      [POWERPC] Fix switch_slb handling of 1T ESID values
