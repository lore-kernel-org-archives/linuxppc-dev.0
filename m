Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18114.58992.882783.405412@cargo.ozlabs.ibm.com>
Date: Wed, 15 Aug 2007 21:41:36 +1000
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

to get a few more bug-fixes for powerpc.

Thanks,
Paul.

 arch/powerpc/boot/flatdevtree.c            |   18 ------------------
 arch/powerpc/kernel/Makefile               |    1 +
 arch/powerpc/kernel/misc_32.S              |   12 +++++++++++-
 arch/powerpc/platforms/cell/spu_syscalls.c |    1 +
 arch/powerpc/platforms/ps3/device-init.c   |    2 +-
 arch/ppc/kernel/misc.S                     |   12 +++++++++++-
 6 files changed, 25 insertions(+), 21 deletions(-)

commit 2de69124e86682c3427adb4136e097854841e467
Author: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date:   Wed Aug 15 02:30:13 2007 +1000

    [POWERPC] ps3: Fix no storage devices found
    
    Fix probing of PS3 storage devices: in the success case, we should set
    `error' to zero, not `result'.
    
    Without this patch no storage devices are found.
    
    Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 55a910a81d0c3014abc20b9efa73c595b3e68339
Author: Roland McGrath <roland@redhat.com>
Date:   Sat Aug 11 09:03:11 2007 +1000

    [POWERPC] Fix for assembler -g
    
    ppc64 does the unusual thing of using #include on a compiler-generated
    assembly file (lparmap.s) from an assembly source file (head_64.S).
    This runs afoul of my recent patch to pass -gdwarf2 to the assembler
    under CONFIG_DEBUG_INFO.  This patch avoids the problem by disabling
    DWARF generation (-g0) when producing lparmap.s.
    
    Signed-off-by: Roland McGrath <roland@redhat.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit aa1cf632bd6f998cb4567ccf1a9d2e5daaa9fb44
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Tue Aug 7 14:20:50 2007 +1000

    [POWERPC] Fix small race in 44x tlbie function
    
    The 440 family of processors don't have a tlbie instruction.  So, we
    implement TLB invalidates by explicitly searching the TLB with tlbsx.,
    then clobbering the relevant entry, if any.  Unfortunately the PID for
    the search needs to be stored in the MMUCR register, which is also
    used by the TLB miss handler.  Interrupts were enabled in _tlbie(), so
    an interrupt between loading the MMUCR and the tlbsx could cause
    incorrect search results, and thus a failure to invalide TLB entries
    which needed to be invalidated.
    
    This fixes the problem in both arch/ppc and arch/powerpc by inhibiting
    interrupts (even critical and debug interrupts) across the relevant
    instructions.
    
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
    Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit fa6b769a8e981afea869285982640168f76774df
Author: Becky Bruce <becky.bruce@freescale.com>
Date:   Sat May 12 03:49:39 2007 +1000

    [POWERPC] Remove unused code causing a compile warning
    
    AFAICT, nobody is using ft_ordered(), and it causes a build warning
    to be generated.  This patch cleans that up by removing the function
    and the commented-out code that calls it.
    
    Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
    Acked-by: David Gibson <david@gibson.dropbear.id.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ad941fe4b6b83999863f49dfba7b3d2cebc4ced5
Author: Jeremy Kerr <jk@ozlabs.org>
Date:   Mon Aug 13 13:22:44 2007 +1000

    [POWERPC] cell: Fix errno for modular spufs_create with invalid neighbour
    
    At present, spu_create with an invalid neighbo(u)r will return -ENOSYS,
    not -EBADF, but only when spufs.o is built as a module.
    
    This change adds the appropriate errno, making the behaviour the same
    as the built-in case.
    
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Acked-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
