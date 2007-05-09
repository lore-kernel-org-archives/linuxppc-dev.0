Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17985.39428.196867.295302@cargo.ozlabs.ibm.com>
Date: Wed, 9 May 2007 19:53:08 +1000
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

to get another powerpc update for 2.6.22.  This includes the patch
from Hugh Dickins via Ben H to make the PowerPC world safe for SLUB,
plus a few other things.

Thanks,
Paul.

 arch/powerpc/Kconfig                            |   24 -
 arch/powerpc/kernel/asm-offsets.c               |   16 -
 arch/powerpc/kernel/lparmap.c                   |    3 
 arch/powerpc/mm/Makefile                        |    1 
 arch/powerpc/mm/hash_low_64.S                   |    5 
 arch/powerpc/mm/hash_utils_64.c                 |  142 +++--
 arch/powerpc/mm/hugetlbpage.c                   |  548 --------------------
 arch/powerpc/mm/init_64.c                       |   17 -
 arch/powerpc/mm/mem.c                           |   25 +
 arch/powerpc/mm/mmu_context_64.c                |   10 
 arch/powerpc/mm/ppc_mmu_32.c                    |    2 
 arch/powerpc/mm/slb.c                           |   11 
 arch/powerpc/mm/slb_low.S                       |   52 +-
 arch/powerpc/mm/slice.c                         |  633 +++++++++++++++++++++++
 arch/powerpc/mm/tlb_32.c                        |    4 
 arch/powerpc/mm/tlb_64.c                        |   12 
 arch/powerpc/platforms/86xx/mpc86xx_smp.c       |    2 
 arch/powerpc/platforms/cell/Kconfig             |   15 +
 arch/powerpc/platforms/cell/spu_base.c          |    9 
 arch/powerpc/platforms/cell/spufs/Makefile      |    2 
 arch/powerpc/platforms/cell/spufs/context.c     |    4 
 arch/powerpc/platforms/cell/spufs/file.c        |   80 ++-
 arch/powerpc/platforms/cell/spufs/lscsa_alloc.c |  181 +++++++
 arch/powerpc/platforms/cell/spufs/switch.c      |   28 -
 arch/powerpc/platforms/iseries/Kconfig          |    4 
 arch/powerpc/platforms/pseries/eeh.c            |   87 +++
 arch/powerpc/platforms/pseries/eeh_driver.c     |   14 -
 arch/powerpc/sysdev/fsl_soc.c                   |    2 
 drivers/char/Kconfig                            |    3 
 include/asm-powerpc/mmu-hash64.h                |   11 
 include/asm-powerpc/paca.h                      |    2 
 include/asm-powerpc/page_64.h                   |   86 ++-
 include/asm-powerpc/pgalloc-64.h                |   31 -
 include/asm-powerpc/pgtable-4k.h                |    6 
 include/asm-powerpc/pgtable-64k.h               |    7 
 include/asm-powerpc/spu_csa.h                   |   10 
 include/linux/suspend.h                         |   11 
 kernel/power/snapshot.c                         |   12 
 38 files changed, 1323 insertions(+), 789 deletions(-)
 create mode 100644 arch/powerpc/mm/slice.c
 create mode 100644 arch/powerpc/platforms/cell/spufs/lscsa_alloc.c

Benjamin Herrenschmidt (4):
      [POWERPC] Small fixes & cleanups in segment page size demotion
      [POWERPC] Introduce address space "slices"
      [POWERPC] Add ability to 4K kernel to hash in 64K pages
      [POWERPC] Spufs support for 64K LS mappings on 4K kernels

David Gibson (1):
      [POWERPC] Further fixes for the removal of 4level-fixup hack from ppc32

Hugh Dickins (1):
      [POWERPC] Don't use SLAB/SLUB for PTE pages

Johannes Berg (2):
      [POWERPC] swsusp: Introduce register_nosave_region_late
      [POWERPC] Mark pages that don't exist as nosave

Linas Vepstas (4):
      [POWERPC] EEH: log error only after driver notification.
      [POWERPC] EEH: Split up long error msg
      [POWERPC] EEH: capture and log pci state on error
      [POWERPC] EEH: log all PCI-X and PCI-E AER registers

Scott Wood (1):
      [POWERPC] fsl_soc: Make mac_addr const in fs_enet_of_init().

Stephen Rothwell (2):
      [POWERPC] iSeries: suppress build warning in lparmap.c
      [POWERPC] iSeries: Make HVC_ISERIES the default
