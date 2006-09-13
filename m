Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17671.64971.450232.870486@cargo.ozlabs.ibm.com>
Date: Wed, 13 Sep 2006 22:47:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'merge' branch
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
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get the last set of PowerPC updates for 2.6.18.

There are:

* A fix for the DART code from Ben H, which fixes the tg3 data
  corruption issue that we have been chasing (it turned out that
  adding barriers in tg3.c or to readl/writel didn't fix the problem).

* Changes to the readX/writeX and related functions to make them have
  the expected semantics, i.e. ordered w.r.t. previous accesses to
  RAM, etc.

* An implementation of futex_atomic_cmpxchg_inatomic.

* A compile fix for the 86xx platforms.

* A couple of kdump fixes.
 
* A couple of defconfig updates.

Thanks,
Paul.

 arch/powerpc/configs/cell_defconfig         |   58 ++-
 arch/powerpc/configs/chrp32_defconfig       |   31 +
 arch/powerpc/configs/g5_defconfig           |    9 
 arch/powerpc/configs/iseries_defconfig      |    7 
 arch/powerpc/configs/maple_defconfig        |  129 ++++--
 arch/powerpc/configs/mpc7448_hpc2_defconfig |   64 ++-
 arch/powerpc/configs/mpc834x_itx_defconfig  |   20 +
 arch/powerpc/configs/mpc834x_mds_defconfig  |  104 ++++-
 arch/powerpc/configs/mpc8540_ads_defconfig  |   84 +++-
 arch/powerpc/configs/mpc85xx_cds_defconfig  |   75 +++
 arch/powerpc/configs/mpc8641_hpcn_defconfig |   62 ++-
 arch/powerpc/configs/pmac32_defconfig       |   18 +
 arch/powerpc/configs/ppc64_defconfig        |  198 ++++++---
 arch/powerpc/configs/pseries_defconfig      |    8 
 arch/powerpc/kernel/crash.c                 |    2 
 arch/powerpc/kernel/misc.S                  |   49 +-
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c  |    2 
 arch/powerpc/sysdev/dart_iommu.c            |    7 
 arch/ppc/configs/prep_defconfig             |  585 +++++++++++++++------------
 include/asm-powerpc/eeh.h                   |    3 
 include/asm-powerpc/futex.h                 |   28 +
 include/asm-powerpc/io.h                    |   43 +-
 include/asm-powerpc/kdump.h                 |    2 
 include/asm-powerpc/paca.h                  |    1 
 include/asm-powerpc/spinlock.h              |   17 +
 include/asm-ppc/io.h                        |   20 +
 26 files changed, 1102 insertions(+), 524 deletions(-)

commit eeac5c142b8687e35780b11b54b4c2f95b1a2436
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed Sep 13 22:12:52 2006 +1000

    [POWERPC] Fix G5 DART (IOMMU) race causing occasional data corruption
    
    It seems that the occasional data corruption observed with the tg3
    driver wasn't due to missing barriers after all, but rather seems to
    be due to the DART (= IOMMU) in the U4 northbridge reading stale
    IOMMU table entries from memory due to a race.  This fixes it by
    making the CPU read the entry back from memory before using it.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit f007cacffc8870702a1473d83ba5e4922d54e17c
Author: Paul Mackerras <paulus@samba.org>
Date:   Wed Sep 13 22:08:26 2006 +1000

    [POWERPC] Fix MMIO ops to provide expected barrier behaviour
    
    This changes the writeX family of functions to have a sync instruction
    before the MMIO store rather than after, because the generally expected
    behaviour is that the device receiving the MMIO store can be guaranteed
    to see the effects of any preceding writes to normal memory.
    
    To preserve ordering between writeX and readX, and to preserve ordering
    between preceding stores and the readX, the readX family of functions
    have had an sync added before the load.
    
    Although writeX followed by spin_unlock is not officially guaranteed
    to keep the writeX inside the spin-locked region unless an mmiowb()
    is used, there are currently drivers that depend on the previous
    behaviour on powerpc, which was that the mmiowb wasn't actually required.
    Therefore we have a per-cpu flag that is set by writeX, cleared by
    __raw_spin_lock and mmiowb, and tested by __raw_spin_unlock.  If it is
    set, __raw_spin_unlock does a sync and clears it.
    
    This changes both 32-bit and 64-bit readX/writeX.  32-bit already has a
    sync in __raw_spin_unlock (since lwsync doesn't exist on 32-bit), and thus
    doesn't need the per-cpu flag.
    
    Tested on G5 (PPC970) and POWER5.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 2e8e8dacc566cc91cd8707cb092e76c7bbfab178
Author: Mohan Kumar M <mohan@in.ibm.com>
Date:   Tue Sep 12 17:48:21 2006 +0530

    [POWERPC] Fix interrupt clearing in kdump shutdown sequence
    
    Call chip->eoi(irq) to clear any pending interrupt in case of kdump
    shutdown sequence.  chip->end(irq) does not serve this purpose.
    
    Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ebf2ed283897b752daa743952aff43d78b725183
Author: Olaf Hering <olaf@aepfle.de>
Date:   Thu Sep 7 14:44:45 2006 +0200

    [POWERPC] update prep_defconfig
    
    Update PReP defconfig, disable some drivers for hardware that is not
    used on those systems; enable SL82C105 IDE driver for Powerstack.
    
    Signed-off-by: Olaf Hering <olaf@aepfle.de>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e269d269e0b53a7a6cb1d04290f8174bf0488cb4
Author: Sachin P. Sant <sachinp@in.ibm.com>
Date:   Fri Sep 8 07:59:52 2006 +0530

    [POWERPC] kdump: Support kernels having 64k page size.
    
    This is required to generate proper core files using kdump on ppc64.
    
    Create a backup region of 64K size irrespective of the PAGE SIZE.
    At present 32K was used as backup size. In the case of 64K page size,
    second PT_LOAD segments starts at 32K and the first one is not page
    aligned.  __ioremap() (crash_dump.c) fails if pfn = 0 which is the
    case for the second PT_LOAD segment. This is not an issue for 4K page
    size because the the first page (32K backup) is copied to second
    kernel memory and thus referencing with the second kernel pfn.
    
    Signed-off-by: Sachin Sant <sachinp@in.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 69588298188b40ed7f75c98a6fd328d82f23ca21
Author: David Woodhouse <dwmw2@infradead.org>
Date:   Mon Sep 4 21:53:14 2006 -0700

    [POWERPC] Implement PowerPC futex_atomic_cmpxchg_inatomic().
    
    The sys_[gs]et_robust_list() syscalls were wired up on PowerPC but
    didn't work correctly because futex_atomic_cmpxchg_inatomic() wasn't
    implemented.  Implement it, based on __cmpxchg_u32().
    
    Signed-off-by: David Woodhouse <dwmw2@infradead.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 20fb96e2aa009ae9892fde9ef7ffa82f56eebd11
Author: Jon Loeliger <jdl@freescale.com>
Date:   Fri Sep 1 10:17:20 2006 -0500

    [POWERPC] Add new, missing argument to of_irq_map_raw() for 86xx.
    
    Ben speaks; we follow.
    
    Signed-off-by: Jon Loeliger <jdl@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit fb7d527c1aec5e224fb3a0772337f8b5e59eecd0
Author: Paul Mackerras <paulus@samba.org>
Date:   Sun Sep 10 11:04:36 2006 +1000

    [POWERPC] Update defconfigs
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>
