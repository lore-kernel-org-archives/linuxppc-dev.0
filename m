Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18018.5690.655733.126061@cargo.ozlabs.ibm.com>
Date: Sun, 3 Jun 2007 11:15:38 +1000
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

to get some more powerpc bug fixes, compile fixes, and a comment-only
change, for 2.6.22.

Thanks,
Paul.

 arch/powerpc/Makefile                  |    1 -
 arch/powerpc/boot/Makefile             |   22 ++++++++++++----------
 arch/powerpc/boot/wrapper              |    4 ++--
 arch/powerpc/kernel/irq.c              |    6 +++---
 arch/powerpc/kernel/prom.c             |   11 ++++++-----
 arch/powerpc/kernel/ptrace.c           |    2 ++
 arch/powerpc/platforms/pasemi/idle.c   |    1 +
 arch/powerpc/platforms/ps3/interrupt.c |    1 +
 arch/powerpc/platforms/pseries/xics.c  |   10 ++++++----
 arch/ppc/syslib/ibm_ocp.c              |    1 +
 drivers/macintosh/Kconfig              |    2 +-
 include/asm-powerpc/pgalloc-64.h       |    3 ++-
 include/asm-powerpc/tlb.h              |    9 +++++++++
 13 files changed, 46 insertions(+), 27 deletions(-)

commit 627aa944a17ba82ca3ba87dc1d6ee85bd314ec79
Author: Milton Miller <miltonm@bga.com>
Date:   Thu May 31 01:29:01 2007 +1000

    [POWERPC] Fix zImage.coff generation for 32-bit pmac
    
    Commit 9da82a6dee9db4cd5ae7a74ab4f51afb52b6efb9 inadvertently
    removed the platform override for zImage.coff to be generated
    with pmaccoff.   Rather than add a special makefile rule,
    change the platform for which the wrapper platform uses
    the special rules.
    
    Signed-off-by: Milton Miller <miltonm@bga.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit f48419666e645208c0156aecab1ee6157303da3c
Author: Stefan Roese <sr@denx.de>
Date:   Sat Jun 2 19:30:20 2007 +1000

    [POWERPC] Fix compile breakage for IBM/AMCC 4xx arch/ppc platforms
    
    The IBM/AMCC 405 platforms don't compile anymore in the current
    kernel version.  This fixes the compile breakage.
    
    Signed-off-by: Stefan Roese <sr@denx.de>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit e358ae4dd4ca823abc5ee06c61e3915636e60191
Author: Johannes Berg <johannes@sipsolutions.net>
Date:   Sat Jun 2 19:13:44 2007 +1000

    [POWERPC] Don't allow PMAC_APM_EMU for 64-bit
    
    In b302887854d6f0c6f9fc3f1080535e7c1bd53134 I switched the apm emulation
    code to use the generic code but accidentally dropped the PPC32
    dependency from the configuration symbol. This adds it back.
    
    Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit f5921697cf5cae68dcbfa881d9e08f3cebef47eb
Author: Michael Ellerman <michael@ellerman.id.au>
Date:   Fri Jun 1 17:23:26 2007 +1000

    [POWERPC] Compare irq numbers with NO_IRQ not IRQ_NONE
    
    There is a thinko in the irq code, it uses IRQ_NONE to indicate no irq,
    whereas it should be using NO_IRQ.  IRQ_NONE is returned from irq
    handlers to say "not handled".
    
    As it happens they currently have the same value (0), so this is just for
    future proof-ness.
    
    Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
    Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit a4c28ab7445f5ca60e56ffd90edb3e9fc1330b71
Author: Akinobu Mita <mita@fixstars.com>
Date:   Tue May 29 20:46:51 2007 +1000

    [POWERPC] Fix return from pte_alloc_one() in out-of-memory case
    
    pte_alloc_one() is expected to return NULL if out of memory.
    But it returns virt_to_page(NULL), which is not NULL.
    This fixes it.
    
    Cc: Paul Mackerras <paulus@samba.org>
    Signed-off-by: Akinobu Mita <mita@fixstars.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 66b30922c8a2c880fe61080c5bf87ae6615b9f64
Author: Michael Neuling <mikey@neuling.org>
Date:   Tue May 29 17:01:52 2007 +1000

    [POWERPC] Fix compile warning in pseries xics code
    
    In 616883df78bd4b3fcdb6ddc39bd3d4cb902bfa32 request_irq was marked as
    __must_check so we must... er... check it.
    
    Signed-off-by: Michael Neuling <mikey@neuling.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit b610b9780bdb2750849f32c2eefef46af58c67f8
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Tue May 29 15:37:12 2007 +1000

    [POWERPC] Don't use HOSTCFLAGS in BOOTCFLAGS
    
    In the bootwrapper code for powerpc, we include HOSTCFLAGS into the
    BOOTCFLAGS used for building the zImage wrapper code.  Since the
    wrapper code is not host code, this makes no sense.  This patch
    removes the use of HOSTCFLAGS here, instead including directly into
    BOOTCFLAGS those flags from the normal kernel CFLAGS which also make
    sense in the bootwrapper code.
    
    In particular, this makes the bootwrapper use -msoft-float, preventing
    the compiler from generating floating point instructions.  Previously,
    under some circumstances the compiler could generate floating point
    instructions in the bootwrapper which would cause exceptions on
    embedded CPUS which don't have floating point support.
    
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
    Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 0570d4ed4325c0fb2ceb75f45a21d878b1741b61
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon May 28 16:12:59 2007 +1000

    [POWERPC] Create a zImage for legacy iSeries
    
    This zImage is really just the stripped vmlinux, but it means that there
    is one less special case for iSeries and also that the zImages will be
    built for a combined kernel build that happens to include iSeries.
    
    This zImage boots fine on legacy iSeries.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 18456d015c50bc903fc66c65621170170190a1fd
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon May 28 10:20:45 2007 +1000

    [POWERPC] pasemi idle uses hard_smp_processor_id
    
    and so needs to include asm/smp.h so a UP build works.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Acked-by: Olof Johansson <olof@lixom.net>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 42d284bc45a9d6625b30c3175563829847406e03
Author: Stephen Rothwell <sfr@canb.auug.org.au>
Date:   Mon May 28 10:19:08 2007 +1000

    [POWERPC] ps3/interrupt.c uses get_hard_smp_processor_id
    
    and so needs to include asm/smp.h for a UP build to work.
    
    Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
    Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 6ad8d010b2f364b739020e514e61b6a73444464b
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Sun May 27 15:18:22 2007 +1000

    [POWERPC] Fix possible access to free pages
    
    I think we have a subtle race on ppc64 with the tlb batching.  The
    common code expects tlb_flush() to actually flush any pending TLB
    batch.  It does that because it delays all page freeing until after
    tlb_flush() is called, in order to ensure no stale reference to
    those pages exist in any TLB, thus causing potential access to
    the freed pages.
    
    However, our tlb_flush only triggers the RCU for freeing page
    table pages, it does not currently trigger a flush of a pending
    TLB/hash batch, which is, I think, an error.  This fixes it.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 988519acb3dbe7168276a36cbb8fd91fddbffaee
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Fri May 25 13:19:17 2007 +1000

    [POWERPC] Fix compiler/assembler flags for Ebony platform boot files
    
    The recent addition of assembler flags for 44x.c and ebony.c in the
    bootwrapper to make them compile on certain toolchains was not correct
    and could break other platforms.  This patch switches to using a
    compiler flag instead, which implies the appropriate assembler flag,
    and also stops the compiler itself generating instructions which are
    invalid for the platform in question.
    
    Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
    Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 7d43e57764fe6922703c36d8d0d56a7ead21f03d
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Thu May 24 15:41:04 2007 +1000

    [POWERPC] Fix ppc32 single-stepping out of syscalls
    
    The ppc32 kernel didn't properly set/clear the TIF_SINGLESTEP
    flag, causing return from syscalls to not SIGTRAP, thus executing
    one more instruction before stopping again.
    
    This fixes it.  The ptrace code is a bit of a mess, and is overdue
    for at least a -proper- 32/64 bits split and possibly more cleanups
    but this minimum fix should be ok for 2.6.22
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 5169b8a1659fef9cc093ed3d889a854945a18177
Author: Michael Ellerman <michael@ellerman.id.au>
Date:   Wed May 23 18:08:13 2007 +1000

    [POWERPC] Update documentation for of_find_node_by_type()
    
    The documentation for of_find_node_by_type() incorrectly refers to the
    "name" parameter - it should be "type".
    
    Also the behaviour when from == NULL is not really documented, fix that.
    
    Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
