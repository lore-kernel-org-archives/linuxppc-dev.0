Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17736.19763.908128.176065@cargo.ozlabs.ibm.com>
Date: Wed, 1 Nov 2006 18:30:59 +1100
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

to get some more PowerPC bugfixes, as listed below.  I have included
the full commit messages this time.

Thanks,
Paul.

 arch/powerpc/kernel/Makefile               |    1 
 arch/powerpc/kernel/btext.c                |    2 
 arch/powerpc/kernel/iommu.c                |   77 ++++++----
 arch/powerpc/kernel/perfmon_fsl_booke.c    |  221 ----------------------------
 arch/powerpc/kernel/pmc.c                  |    2 
 arch/powerpc/kernel/traps.c                |   18 +-
 arch/powerpc/kernel/vio.c                  |    4 -
 arch/powerpc/lib/sstep.c                   |    5 -
 arch/powerpc/mm/hugetlbpage.c              |    3 
 arch/powerpc/oprofile/Makefile             |    2 
 arch/powerpc/oprofile/common.c             |   10 +
 arch/powerpc/oprofile/op_model_7450.c      |    2 
 arch/powerpc/oprofile/op_model_fsl_booke.c |  170 +++++++++++++++++-----
 arch/powerpc/oprofile/op_model_power4.c    |    2 
 arch/powerpc/oprofile/op_model_rs64.c      |    2 
 arch/powerpc/platforms/iseries/iommu.c     |   11 -
 arch/powerpc/platforms/pseries/iommu.c     |   35 +---
 arch/powerpc/sysdev/dart.h                 |    1 
 arch/powerpc/sysdev/dart_iommu.c           |    8 -
 arch/powerpc/sysdev/qe_lib/qe.c            |    3 
 arch/ppc/kernel/traps.c                    |   18 +-
 drivers/video/offb.c                       |   36 +++--
 include/asm-powerpc/current.h              |   12 +-
 include/asm-powerpc/io.h                   |    7 +
 include/asm-powerpc/iommu.h                |   22 +++
 include/asm-powerpc/oprofile_impl.h        |   87 +++++++++++
 include/asm-powerpc/pmc.h                  |   13 --
 include/asm-powerpc/system.h               |    6 -
 include/asm-powerpc/tce.h                  |    3 
 29 files changed, 381 insertions(+), 402 deletions(-)
 delete mode 100644 arch/powerpc/kernel/perfmon_fsl_booke.c

commit 4393c4f6788cee65095dd838cfeca6edefbfeb52
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed Nov 1 15:11:39 2006 +1100

    [POWERPC] Make alignment exception always check exception table
    
    The alignment exception used to only check the exception table for
    -EFAULT, not for other errors. That opens an oops window if we can
    coerce the kernel into getting an alignment exception for other reasons
    in what would normally be a user-protected accessor, which can be done
    via some of the futex ops. This fixes it by always checking the
    exception tables.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 0d69a052d4d7c4085706b9ac0d1bd28ff90c9fca
Author: Gui,Jian <guij@cn.ibm.com>
Date:   Wed Nov 1 10:50:15 2006 +0800

    [POWERPC] Disallow kprobes on emulate_step and branch_taken
    
    On powerpc, probing on emulate_step function will crash 2.6.18.1 when
    it is triggered.
    
    When kprobe is triggered, emulate_step() is on its kernel path and
    will cause recursive kprobe fault.  And branch_taken() is called
    in emulate_step().  This disallows kprobes on both of them.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 292f86f005e3867277b2126c2399eea3e773a4fc
Author: Hugh Dickins <hugh@veritas.com>
Date:   Tue Oct 31 18:41:51 2006 +0000

    [POWERPC] Make mmiowb's io_sync preempt safe
    
    If mmiowb() is always used prior to releasing spinlock as Doc suggests,
    then it's safe against preemption; but I'm not convinced that's always
    the case.  If preemption occurs between sync and get_paca()->io_sync = 0,
    I believe there's no problem.  But in the unlikely event that gcc does
    the store relative to another register than r13 (as it did with current),
    then there's a small danger of setting another cpu's io_sync to 0, after
    it had just set it to 1.  Rewrite ppc64 mmiowb to prevent that.
    
    The remaining io_sync assignments in io.h all get_paca()->io_sync = 1,
    which is harmless even if preempted to the wrong cpu (the context switch
    itself syncs); and those in spinlock.h are while preemption is disabled.
    
    Signed-off-by: Hugh Dickins <hugh@veritas.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 96268889ee369b36203b7a06e8aabb197270216e
Author: Hugh Dickins <hugh@veritas.com>
Date:   Tue Oct 31 18:40:39 2006 +0000

    [POWERPC] Make high hugepage areas preempt safe
    
    Checking source for other get_paca()->field preemption dangers found that
    open_high_hpage_areas does a structure copy into its paca while preemption
    is enabled: unsafe however gcc accomplishes it.  Just remove that copy:
    it's done safely afterwards by on_each_cpu, as in open_low_hpage_areas.
    
    Signed-off-by: Hugh Dickins <hugh@veritas.com>
    Acked-by: David Gibson <dwg@au1.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 5fe8e8b88e68e517637e3f8287f1fee89e2d9252
Author: Hugh Dickins <hugh@veritas.com>
Date:   Tue Oct 31 18:39:31 2006 +0000

    [POWERPC] Make current preempt-safe
    
    Repeated -j20 kernel builds on a G5 Quad running an SMP PREEMPT kernel
    would often collapse within a day, some exec failing with "Bad address".
    In each case examined, load_elf_binary was doing a kernel_read, but
    generic_file_aio_read's access_ok saw current->thread.fs.seg as USER_DS
    instead of KERNEL_DS.
    
    objdump of filemap.o shows gcc 4.1.0 emitting "mr r5,r13 ... ld r9,416(r5)"
    here for get_paca()->__current, instead of the expected and much more usual
    "ld r9,416(r13)"; I've seen other gcc4s do the same, but perhaps not gcc3s.
    
    So, if the task is preempted and rescheduled on a different cpu in between
    the mr and the ld, r5 will be looking at a different paca_struct from the
    one it's now on, pick up the wrong __current, and perhaps the wrong seg.
    Presumably much worse could happen elsewhere, though that split is rare.
    
    Other architectures appear to be safe (x86_64's read_pda is more limiting
    than get_paca), but ppc64 needs to force "current" into one instruction.
    
    Signed-off-by: Hugh Dickins <hugh@veritas.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 302439d2167e0f1e01a6480ac40c06063f4e16a1
Author: Timur Tabi <timur@freescale.com>
Date:   Tue Oct 31 17:53:42 2006 +0800

    [POWERPC] qe_lib: qe_issue_cmd writes wrong value to CECDR
    
    Changed qe_issue_cmd() to write cmd_input to the CECDR unmodified.  It
    was treating cmd_input as a virtual address and tried to convert it to
    a physical address.
    
    Signed-off-by: Timur Tabi <timur@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 5d2efba64b231a1733c4048d1708d77e07f26426
Author: Linas Vepstas <linas@austin.ibm.com>
Date:   Mon Oct 30 16:15:59 2006 +1100

    [POWERPC] Use 4kB iommu pages even on 64kB-page systems
    
    The 10Gigabit ethernet device drivers appear to be able to chew
    up all 256MB of TCE mappings on pSeries systems, as evidenced by
    numerous error messages:
    
     iommu_alloc failed, tbl c0000000010d5c48 vaddr c0000000d875eff0 npages 1
    
    Some experimentation indicates that this is essentially because
    one 1500 byte ethernet MTU gets mapped as a 64K DMA region when
    the large 64K pages are enabled. Thus, it doesn't take much to
    exhaust all of the available DMA mappings for a high-speed card.
    
    This patch changes the iommu allocator to work with its own
    unique, distinct page size. Although the patch is long, its
    actually quite simple: it just #defines a distinct IOMMU_PAGE_SIZE
    and then uses this in all the places that matter.
    
    As a side effect, it also dramatically improves network performance
    on platforms with H-calls on iommu translation inserts/removes (since
    we no longer call it 16 times for a 1500 bytes packet when the iommu HW
    is still 4k).
    
    In the future, we might want to make the IOMMU_PAGE_SIZE a variable
    in the iommu_table instance, thus allowing support for different HW
    page sizes in the iommu itself.
    
    Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Acked-by: Olof Johansson <olof@lixom.net>
    Acked-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit dd6c89f686bdb2a5de72fab636fc839e5a0add6d
Author: Andy Fleming <afleming@freescale.com>
Date:   Fri Oct 27 15:06:32 2006 -0500

    [POWERPC] Fix oprofile support for e500 in arch/powerpc
    
    Fixed a compile error in building the 85xx support with oprofile, and in
    the process cleaned up some issues with the fsl_booke performance monitor
    code.
    
    * Reorganized FSL Book-E performance monitoring code so that the 7450
      wouldn't be built if the e500 was, and cleaned it up so it was more
      self-contained.
    
    * Added a cpu_setup function for FSL Book-E.  The original
      cpu_setup function prototype had no arguments, assuming that
      the reg_setup function would copy the required information into
      variables which represented the registers.  This was silly for
      e500, since it has 1 register per counter (rather than 3 for
      all counters), so the code has been restructured to have
      cpu_setup take the current counter config array as an argument,
      with op_powerpc_setup() invoking op_powerpc_cpu_setup() through
      on_each_cpu(), and op_powerpc_cpu_setup() invoking the
      model-specific cpu_setup function with an argument.  The
      argument is ignored on all other platforms at present.
    
    * Fixed a confusing line where a trinary operator only had two
      arguments
    
    Signed-off-by: Andrew Fleming <afleming@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e0da0daee14862e0a5c49f2059641a8deb27eca2
Author: Andy Fleming <afleming@freescale.com>
Date:   Fri Oct 27 14:31:07 2006 -0500

    [POWERPC] Fix rmb() for e500-based machines it
    
    The e500 core generates an illegal instruction exception when it tries
    to execute the lwsync instruction, which we currently use for rmb().
    This fixes it by using the LWSYNC macro, which turns into a plain sync
    on 32-bit machines.
    
    Signed-off-by: Andrew Fleming <afleming@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 441cbd8dace80545db2ac43175ac1c097d96f75c
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Thu Oct 26 15:38:10 2006 +1000

    [POWERPC] Fix various offb issues
    
    This patch fixes a few issues in offb:
    
     - A test was inverted causing the palette hack to never work
    (no device node was passed down to the init function)
    
     - Some cards seem to have their assigned-addresses property in a random
    order, thus we need to try using of_get_pci_address() first, which will
    fail if it's not a PCI device, and fallback to of_get_address() in that
    case. of_get_pci_address() properly parsees assigned-addresses to test
    the BAR number and thus will get it right whatever the order is.
    
     - Some cards (like GXT4500) provide a linebytes of 0xffffffff in the
    device-tree which does no good. This patch handles that by using the
    screen width when that happens. (Also fixes btext.c while at it).
    
     - Add detection of the GXT4500 in addition to the GXT2000 for the
    palette hacks (we use the same hack, palette is linear in register space
    at offset 0x6000).
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
