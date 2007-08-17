Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18117.1110.955352.469650@cargo.ozlabs.ibm.com>
Date: Fri, 17 Aug 2007 12:13:42 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: for-2.6.24 branch in powerpc.git created
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have made a for-2.6.24 branch in powerpc.git and pushed the
following patches to it.

Paul.

Becky Bruce (1):
      [POWERPC] Update lmb.h include protection to ASM_POWERPC

David Gibson (4):
      [POWERPC] Fixes to allow use of Ebony's flash chips through physmap_of
      [POWERPC] Fix setting of irq trigger type in UIC driver
      [POWERPC] Fix irq flow handler for 4xx UIC
      [POWERPC] Improve robustness of the UIC cascade handler

Gabriel C (1):
      [POWERPC] Typo fixes interrrupt -> interrupt

Grant Likely (1):
      [POWERPC] Only ignore arch/ppc/include, not arch/ppc/boot/include

Guennadi Liakhovetski (1):
      [POWERPC] Fix i2c device string format

Ishizaki Kou (4):
      [POWERPC] Fix celleb pci section warnings
      [POWERPC] Fix celleb sio section warning
      [POWERPC] Init markings for celleb
      [POWERPC] Init markings for hvc_beat

Jesper Juhl (1):
      [POWERPC] Clean out a bunch of duplicate includes

Jon Loeliger (3):
      [POWERPC] 52xx: Remove unnecessary loops_per_jiffy initialization code
      [POWERPC] 8xx: Remove unnecessary loops_per_jiffy initialization code
      [POWERPC] embedded6xx: Remove unnecessary loops_per_jiffy initialization code

Linas Vepstas (10):
      [POWERPC] EEH: Tweak printk message
      [POWERPC] EEH: Fix PCI bridge handling bug
      [POWERPC] EEH: Dump PCI bridge status on event
      [POWERPC] pseries: Avoid excess rtas_token calls
      [POWERPC] pseries: Use rtas_token instead of hand-rolled code
      [POWERPC] pseries: Simplify rtasd initialization
      [POWERPC] Remove nvram forward declarations
      [POWERPC] pseries: Fix jumbled no_logging flag
      [POWERPC] pseries: Eliminate global error_log_cnt variable
      [POWERPC] pseries: Remove dead EEH video code

Mariusz Kozlowski (1):
      [POWERPC] drivers/macintosh/therm_adt746x.c: kmalloc + memset conversion to kzalloc

Michael Buesch (1):
      [POWERPC] via-pmu: Fix typo in printk

Murali Iyer (1):
      [POWERPC] Export DCR symbols for modules

Nathan Lynch (14):
      [POWERPC] Remove gratuitous reads from maple PCI config space methods
      [POWERPC] rtas_pci_ops: Use named structure member initializers
      [POWERPC] celleb_fake_pci_ops: Use named structure member initializers
      [POWERPC] celleb_epci_ops: Use named structure member initializers
      [POWERPC] maple pci_ops: Use named structure member initializers
      [POWERPC] pa_pxp_ops: Use named structure member initializers
      [POWERPC] powermac pci_ops: Use named structure member initializers
      [POWERPC] null_pci_ops: Use named structure member initializers
      [POWERPC] efika rtas_pci_ops: Use named structure member initializers
      [POWERPC] chrp pci_ops: Use named structure member initializers
      [POWERPC] indirect_pci_ops: Use named structure member initializers
      [POWERPC] tsi108_direct_pci_ops: Use named structure member initializers
      [POWERPC] Remove gratuitous reads from pasemi pci config space methods
      [POWERPC] Remove gratuitous reads from powermac pci config space methods

Paul Mackerras (1):
      [POWERPC] Handle alignment faults on new FP load/store instructions

Segher Boessenkool (2):
      [POWERPC] Replace a few #defines with empty inline functions
      [POWERPC] Implement atomic{, 64}_{read, write}() without volatile

Stephen Rothwell (10):
      [POWERPC] Fix non HUGETLB_PAGE build warning
      [POWERPC] Use of_get_property in ipmi code
      [POWERPC] Remove get_property and device_is_compatible
      [POWERPC] Tidy up CONFIG_PPC_MM_SLICES code
      [POWERPC] Comment out a currently unused function
      [POWERPC] Fix section mismatch in crash_dump.c
      [POWERPC] Fix section mismatch in dart_iommu.c
      [POWERPC] Fix section mismatches in udbg_adb.c
      [POWERPC] Fix section mismatch in pasemi/iommu.c
      [POWERPC] Remove some duplicate declarations from pmac.h

 arch/powerpc/boot/dts/ebony.dts                   |    1 
 arch/powerpc/boot/ebony.c                         |   39 +++
 arch/powerpc/configs/ebony_defconfig              |  246 ++++++++++-----------
 arch/powerpc/kernel/align.c                       |   57 ++++-
 arch/powerpc/kernel/btext.c                       |    1 
 arch/powerpc/kernel/crash.c                       |    1 
 arch/powerpc/kernel/crash_dump.c                  |    2 
 arch/powerpc/kernel/iommu.c                       |    1 
 arch/powerpc/kernel/nvram_64.c                    |   23 --
 arch/powerpc/kernel/pci_32.c                      |    4 
 arch/powerpc/kernel/prom.c                        |    1 
 arch/powerpc/kernel/rtas_pci.c                    |    4 
 arch/powerpc/kernel/time.c                        |    1 
 arch/powerpc/mm/hash_utils_64.c                   |    7 -
 arch/powerpc/mm/hugetlbpage.c                     |    3 
 arch/powerpc/mm/init_32.c                         |    1 
 arch/powerpc/mm/mem.c                             |    1 
 arch/powerpc/mm/mmu_context_64.c                  |   11 -
 arch/powerpc/mm/slice.c                           |    1 
 arch/powerpc/platforms/52xx/efika.c               |    4 
 arch/powerpc/platforms/52xx/lite5200.c            |   13 -
 arch/powerpc/platforms/52xx/mpc52xx_pic.c         |    1 
 arch/powerpc/platforms/8xx/mpc86xads_setup.c      |   14 -
 arch/powerpc/platforms/8xx/mpc885ads_setup.c      |   14 -
 arch/powerpc/platforms/celleb/pci.c               |   16 +
 arch/powerpc/platforms/celleb/scc_epci.c          |    8 -
 arch/powerpc/platforms/celleb/scc_sio.c           |    8 -
 arch/powerpc/platforms/celleb/setup.c             |    4 
 arch/powerpc/platforms/chrp/pci.c                 |    8 -
 arch/powerpc/platforms/chrp/setup.c               |    1 
 arch/powerpc/platforms/chrp/smp.c                 |    1 
 arch/powerpc/platforms/embedded6xx/holly.c        |   14 -
 arch/powerpc/platforms/embedded6xx/linkstation.c  |    2 
 arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |    2 
 arch/powerpc/platforms/embedded6xx/prpmc2800.c    |    7 -
 arch/powerpc/platforms/iseries/it_lp_naca.h       |    2 
 arch/powerpc/platforms/iseries/setup.c            |    1 
 arch/powerpc/platforms/maple/pci.c                |   21 +-
 arch/powerpc/platforms/pasemi/iommu.c             |    4 
 arch/powerpc/platforms/pasemi/pci.c               |    7 -
 arch/powerpc/platforms/powermac/low_i2c.c         |    1 
 arch/powerpc/platforms/powermac/pci.c             |   25 +-
 arch/powerpc/platforms/powermac/pmac.h            |    4 
 arch/powerpc/platforms/powermac/udbg_adb.c        |    5 
 arch/powerpc/platforms/pseries/eeh.c              |   52 +++-
 arch/powerpc/platforms/pseries/eeh_cache.c        |    9 -
 arch/powerpc/platforms/pseries/lpar.c             |    1 
 arch/powerpc/platforms/pseries/rtasd.c            |   96 +++-----
 arch/powerpc/sysdev/dart_iommu.c                  |    4 
 arch/powerpc/sysdev/dcr.c                         |    4 
 arch/powerpc/sysdev/fsl_soc.c                     |   13 +
 arch/powerpc/sysdev/indirect_pci.c                |    4 
 arch/powerpc/sysdev/tsi108_pci.c                  |    4 
 arch/powerpc/sysdev/uic.c                         |   66 +++++-
 arch/ppc/.gitignore                               |    2 
 drivers/char/hvc_beat.c                           |    4 
 drivers/char/ipmi/ipmi_si_intf.c                  |    6 -
 drivers/macintosh/therm_adt746x.c                 |    5 
 drivers/macintosh/via-pmu.c                       |    2 
 drivers/macintosh/windfarm_smu_sat.c              |    2 
 drivers/mtd/maps/Kconfig                          |    2 
 include/asm-powerpc/atomic.h                      |   34 ++-
 include/asm-powerpc/dma-mapping.h                 |   24 ++
 include/asm-powerpc/lmb.h                         |    6 -
 include/asm-powerpc/nvram.h                       |    6 -
 include/asm-powerpc/page_64.h                     |    7 +
 include/asm-powerpc/prom.h                        |    1 
 include/asm-ppc/prom.h                            |    1 
 include/linux/of.h                                |    1 
 69 files changed, 499 insertions(+), 449 deletions(-)
