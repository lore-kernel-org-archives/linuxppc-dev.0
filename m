Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17997.41560.178348.542393@cargo.ozlabs.ibm.com>
Date: Fri, 18 May 2007 22:55:52 +1000
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

to get some powerpc bug and warning fixes, documentation, comment and
defconfig updates, some very minor cleanups, plus a couple more
syscalls wired up.

Thanks,
Paul.

 arch/powerpc/Makefile                    |    3 
 arch/powerpc/boot/Makefile               |   15 +
 arch/powerpc/boot/dts/ebony.dts          |   37 +--
 arch/powerpc/boot/dts/kuroboxHD.dts      |   44 +--
 arch/powerpc/boot/dts/kuroboxHG.dts      |   45 +---
 arch/powerpc/boot/dts/lite5200.dts       |   69 +++--
 arch/powerpc/boot/dts/lite5200b.dts      |   77 +++---
 arch/powerpc/boot/dts/mpc7448hpc2.dts    |   72 +++---
 arch/powerpc/boot/dts/mpc8540ads.dts     |   16 +
 arch/powerpc/boot/dts/mpc8541cds.dts     |   16 +
 arch/powerpc/boot/dts/mpc8544ds.dts      |   16 +
 arch/powerpc/boot/dts/mpc8548cds.dts     |   16 +
 arch/powerpc/boot/dts/mpc8555cds.dts     |   16 +
 arch/powerpc/boot/dts/mpc8560ads.dts     |   18 +
 arch/powerpc/boot/dts/mpc8568mds.dts     |   16 +
 arch/powerpc/boot/flatdevtree.c          |   17 +
 arch/powerpc/configs/cell_defconfig      |   15 -
 arch/powerpc/configs/iseries_defconfig   |  209 +++++++++-------
 arch/powerpc/configs/pasemi_defconfig    |  383 +++++++++++++++++-------------
 arch/powerpc/kernel/cputable.c           |    2 
 arch/powerpc/kernel/entry_32.S           |   18 +
 arch/powerpc/kernel/of_platform.c        |   10 -
 arch/powerpc/kernel/pci_64.c             |   23 ++
 arch/powerpc/kernel/prom.c               |    5 
 arch/powerpc/kernel/rtas-proc.c          |    2 
 arch/powerpc/lib/rheap.c                 |   22 +-
 arch/powerpc/mm/hash_low_32.S            |   18 +
 arch/powerpc/mm/hash_utils_64.c          |    4 
 arch/powerpc/mm/pgtable_64.c             |    4 
 arch/powerpc/platforms/44x/Kconfig       |    3 
 arch/powerpc/platforms/44x/ebony.c       |    6 
 arch/powerpc/platforms/iseries/viopath.c |   21 +-
 arch/powerpc/platforms/pasemi/Kconfig    |    1 
 arch/powerpc/platforms/pseries/pseries.h |    4 
 arch/powerpc/sysdev/mpic.c               |   12 +
 arch/ppc/syslib/pq2_sys.c                |   36 ++-
 drivers/char/watchdog/booke_wdt.c        |    2 
 drivers/macintosh/windfarm_core.c        |   10 +
 include/asm-powerpc/cputable.h           |    6 
 include/asm-powerpc/mmu-44x.h            |    2 
 include/asm-powerpc/mpc8260.h            |    6 
 include/asm-powerpc/pgtable-ppc32.h      |   15 -
 include/asm-powerpc/pmac_feature.h       |    6 
 include/asm-powerpc/systbl.h             |    3 
 include/asm-powerpc/tsi108_irq.h         |    6 
 include/asm-powerpc/tsi108_pci.h         |    6 
 include/asm-powerpc/unistd.h             |   11 +
 47 files changed, 782 insertions(+), 582 deletions(-)

Becky Bruce (1):
      [POWERPC] Change include protections to ASM_POWERPC

Benjamin Herrenschmidt (3):
      [POWERPC] Add spinlock to request_phb_iospace()
      [POWERPC] Fix IO space on PCI buses created from of_platform
      [POWERPC] Make sure device node type/name is not NULL on hot-added nodes

Christian Krafft (1):
      [POWERPC] cell_defconfig: Disable cpufreq and pmi

Christoph Hellwig (2):
      [POWERPC] viopath: Use completion
      [POWERPC] viopath: Use a completion in some more places

Dave Jiang (2):
      [POWERPC] Fix comment in booke_wdt
      [POWERPC] 85xx: Add device nodes for error reporting devices used by EDAC

David Gibson (4):
      [POWERPC] Remove fixup_bigphys_addr() for arch/powerpc to avoid link error
      [POWERPC] Fix bug adding properties with flatdevtree.c's ft_set_prop()
      [POWERPC] Fix make rules for treeImage.initrd
      [POWERPC] Small fixes for the Ebony device tree

James.Yang (1):
      [POWERPC] Remove CPU_FTR_NEED_COHERENT for 7448.

Jon Tollefson (1):
      [POWERPC] Correct #endif comment

Josh Boyer (1):
      [POWERPC] Pass per-file CFLAGs for platform specific op codes

Kumar Gala (3):
      [POWERPC] Fix COMMON symbol warnings
      [POWERPC] 85xx: Add device nodes for error reporting devices used by EDAC
      [POWERPC] Removed hardcoded phandles from dts

Morten Banzon (1):
      [PPC] MCC2 missing in MPC826x device_list

Olof Johansson (3):
      [POWERPC] pasemi: CONFIG_GENERIC_TBSYNC no longer needed
      [POWERPC] Update pasemi_defconfig
      [POWERPC] Remove warning in mpic.c

Segher Boessenkool (3):
      [POWERPC] Specify GNUTARGET on $(AR) invocations
      [POWERPC] Fix sed command lines for zlib source construction
      [POWERPC] Fix ppc_rtas_progress_show()

Stephen Rothwell (4):
      [POWERPC] Wire up some more syscalls
      [POWERPC] Update iseries_defconfig
      [POWERPC] Fix warning on UP
      [POWERPC] Remove build warnings in windfarm_core

Timur Tabi (1):
      [POWERPC] Fix alignment problem in rh_alloc_align() with exact-sized blocks

Tony Breeds (1):
      [POWERPC] Fix Kconfig undefined symbol 'IBM_NEW_EMAC_ZMII'
