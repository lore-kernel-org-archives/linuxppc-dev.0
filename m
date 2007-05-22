Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18003.31275.181182.633689@cargo.ozlabs.ibm.com>
Date: Wed, 23 May 2007 09:18:03 +1000
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

to get some powerpc bug fixes, including one from Ben H that fixes an
error in our vmlinux.lds.S which is currently making our kernels
unbootable.

Thanks,
Paul.

 arch/powerpc/kernel/cputable.c    |    4 ++++
 arch/powerpc/kernel/pmc.c         |    6 +++---
 arch/powerpc/kernel/smp.c         |   34 ++++++++++++++++++----------------
 arch/powerpc/kernel/vmlinux.lds.S |    1 -
 arch/powerpc/mm/mem.c             |    9 +++++----
 5 files changed, 30 insertions(+), 24 deletions(-)

commit 5453e7723b95958f4591b2e0063573d8d53e7699
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue May 22 16:25:51 2007 +1000

    [POWERPC] Fix warning in 32-bit builds with CONFIG_HIGHMEM
    
    Some missing fixup for the removal of 4 level fixup header.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 832a791c580a86cbeea5bb12a984d95b1f458539
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue May 22 14:33:05 2007 +1000

    [POWERPC] Fix powerpc vmlinux.lds.S
    
    Sam's recent change in 7664709b44a13e2e0b545e2dd8e7b8797a1748dc
    broke things for us because we ended up with *(.text.*) before
    *(.text), whereas previously *(.text) was first.  This was
    important because the start of the text section contains the
    kernel entry point.
    
    In fact, we don't need that *(.text.*) thing anymore and it
    incorrectly matched .text.init.refok, thus putting it before
    .text. .. ouch !
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 177e9ea49deea238f59bb0b1708cfc60b75828fb
Author: Anton Blanchard <anton@samba.org>
Date:   Sun May 20 03:13:43 2007 +1000

    [POWERPC] Fix typo: MMCR0_PMA0 != MMCR0_PMAO
    
    pmc.c has:
    
    #ifndef MMCR0_PMA0
    #define MMCR0_PMA0     0
    
    This one took a while to find.  Unfortunately its the wrong define
    (number 0 vs letter O). Its probably worth removing this override, since
    if our includes get screwed up we will have the same (hard to debug)
    failure.
    
    Fix it simply for now, so that we can backport to stable.
    
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 2fae4985a135ca5d7d9bba17d45d674c099621b4
Author: Anton Blanchard <anton@samba.org>
Date:   Sat May 19 15:22:41 2007 +1000

    [POWERPC] Add missing pmc_type fields in cpu_table
    
    A number of cpu_table entries were missing the pmc_type field,
    which means that the sysfs entries for the performance monitor
    counters don't get created.  This adds them.
    
    Signed-off-by: Anton Blanchard <anton@samba.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit d3fdaed9e973687f088c9c156a6e20870386e0b7
Author: Hugh Dickins <hugh@veritas.com>
Date:   Sat May 19 02:47:01 2007 +1000

    [POWERPC] Fix smp_call_function to be preempt-safe
    
    smp_call_function_map() was not safe against preemption to another
    cpu: its test for removing self from map was outside the spinlock.
    Rearrange it a little to fix that.
    
    smp_call_function_single() was also wrong: now get_cpu() before
    excluding self, as other architectures do.
    
    Signed-off-by: Hugh Dickins <hugh@veritas.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
