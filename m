Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17909.62596.852504.141626@cargo.ozlabs.ibm.com>
Date: Tue, 13 Mar 2007 11:47:00 +1100
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

A few more powerpc bug fixes have come in, so please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

I pulled in the Cell fixes that Arnd collected together, and added
three commits from Stephen Rothwell relating to new system calls.  The
full commit messages are below.

Thanks,
Paul.

 arch/powerpc/configs/cell_defconfig        |  151 ++++++++++++++++++++++++----
 arch/powerpc/mm/hash_utils_64.c            |    6 +
 arch/powerpc/mm/hugetlbpage.c              |    4 +
 arch/powerpc/platforms/cell/spu_base.c     |   81 +++++++++++++--
 arch/powerpc/platforms/cell/spufs/file.c   |   24 +++-
 arch/powerpc/platforms/cell/spufs/run.c    |    4 -
 arch/powerpc/platforms/cell/spufs/sched.c  |   20 +---
 arch/powerpc/platforms/cell/spufs/spufs.h  |    6 -
 arch/powerpc/platforms/cell/spufs/switch.c |   62 +----------
 arch/powerpc/platforms/ps3/mm.c            |    2 
 arch/powerpc/platforms/ps3/system-bus.c    |    2 
 drivers/ps3/ps3av.c                        |    9 +-
 drivers/ps3/sys-manager.c                  |    6 +
 drivers/ps3/vuart.c                        |    2 
 include/asm-powerpc/spu.h                  |    7 +
 include/asm-powerpc/spu_csa.h              |    4 -
 include/asm-powerpc/systbl.h               |    3 -
 include/asm-powerpc/unistd.h               |    4 +
 18 files changed, 263 insertions(+), 134 deletions(-)

commit 7b3c384db1ff0f336b59d5062617915e216eaec1
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Fri Mar 9 11:58:11 2007 +1100

    [POWERPC] sys_move_pages should be callable from an SPU
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 4b0092c215fc678e325193cf97ddcb4be6a550c3
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Fri Mar 9 11:57:10 2007 +1100

    [POWERPC] Wire up sys_epoll_pwait
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 4cd723b4a0cc3e061e0a3fd86a1ec9a227f17c0b
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Fri Mar 9 11:54:57 2007 +1100

    [POWERPC] Allocate syscall number for sys_getcpu
    
    I forgot to do this when wiring up the syscall.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit c886c2bf804c029499694adcc0decfdd32a0cd8b
Author: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Date:   Sat Mar 10 00:05:39 2007 +0100

    [POWERPC] update cell_defconfig
    
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit ef596c697a4d80048eccf50530153d7e3330c127
Author: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date:   Sat Mar 10 00:05:38 2007 +0100

    [POWERPC] ps3: always make sure were running on a PS3
    
    Add missing checks to PS3 specific drivers ps3av and sys-manager to verify that
    we are actually running on a PS3 (pointed out by Arnd).
    
    Correct existing checks in other subsystems/drivers to return -ENODEV instead
    of zero.
    
    Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 94b2a4393c500a620de90c3266d595926302e26b
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sat Mar 10 00:05:37 2007 +0100

    [POWERPC] Fix spu SLB invalidations
    
    The SPU code doesn't properly invalidate SPUs SLBs when necessary,
    for example when changing a segment size from the hugetlbfs code. In
    addition, it saves and restores the SLB content on context switches
    which makes it harder to properly handle those invalidations.
    
    This patch removes the saving & restoring for now, something more
    efficient might be found later on. It also adds a spu_flush_all_slbs(mm)
    that can be used by the core mm code to flush the SLBs of all SPEs that
    are running a given mm at the time of the flush.
    
    In order to do that, it adds a spinlock to the list of all SPEs and move
    some bits & pieces from spufs to spu_base.c
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

commit 50b520d4efbce45281f58112789470ec7965fd33
Author: Christoph Hellwig <hch@lst.de>
Date:   Sat Mar 10 00:05:36 2007 +0100

    [POWERPC] avoid SPU_ACTIVATE_NOWAKE optimization
    
    This optimization was added recently but is still buggy,
    so back it out for now.
    
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit aa0ed2bdb663608d5e409faecff3e1e81a3d413a
Author: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Date:   Sat Mar 10 00:05:35 2007 +0100

    [POWERPC] spufs: fix possible memory corruption is spufs_mem_write
    
    Due to a buggy unsigned comparison, it was possible to write
    beyond the end of the local store file in spufs under some
    circumstances.
    
    This rewrites the buggy function to look more like
    simple_copy_from_buffer.
    
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>
