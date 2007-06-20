Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18041.8605.878236.247595@cargo.ozlabs.ibm.com>
Date: Wed, 20 Jun 2007 22:46:21 +1000
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get two more bug fixes for powerpc.  Both bugs cause an oops in
some circumstances.

(Please also do the pull that Kumar requested; I haven't pulled in his
commits in this instance.)

Thanks,
Paul.

 arch/powerpc/mm/fault.c                 |    5 ++---
 arch/powerpc/platforms/powermac/setup.c |    3 +++
 2 files changed, 5 insertions(+), 3 deletions(-)

commit c5f226c7e95bf318879fb6ae02fc0dfb0f6d408c
Author: Tony Breeds <tony@bakeyournoodle.com>
Date:   Wed Jun 20 15:17:29 2007 +1000

    [POWERPC] Fix powermac late initcall to only run on powermac
    
    Current ppc64_defconfig kernel fails to boot on iSeries, dying with:
    
    Unable to handle kernel paging request for data at address 0x00000000
    Faulting instruction address: 0xc00000000071b258
    Oops: Kernel access of bad area, sig: 11 [#1]
    SMP NR_CPUS=32 iSeries
    <snip>
    NIP [c00000000071b258] .iSeries_src_init+0x34/0x64
    LR [c000000000701bb4] .kernel_init+0x1fc/0x3bc
    Call Trace:
    [c000000007d0be30] [0000000000008000] 0x8000 (unreliable)
    [c000000007d0bea0] [c000000000701bb4] .kernel_init+0x1fc/0x3bc
    [c000000007d0bf90] [c0000000000262d4] .kernel_thread+0x4c/0x68
    Instruction dump:
    e922cba8 3880ffff 78840420 f8010010 f821ff91 60000000 e8090000 78095fe3
    4182002c e922cb58 e862cbb0 e9290140 <e8090000> f8410028 7c0903a6 e9690010
    Kernel panic - not syncing: Attempted to kill init!
    
    This happens because some powermac code unconditionally sets
    ppc_md.progress to NULL.  This patch makes sure the powermac late
    initcall is only run on powermac machines.
    
    Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 9ba4ace39fdfe22268daca9f28c5df384ae462cf
Author: Segher Boessenkool <segher@kernel.crashing.org>
Date:   Wed Jun 20 01:07:04 2007 +1000

    [POWERPC] PowerPC: Prevent data exception in kernel space (32-bit)
    
    The "is_exec" branch of the protection check in do_page_fault()
    didn't do anything on 32-bit PowerPC.  So if a userland program
    jumps to a page with Linux protection flags "---p", all the tests
    happily fall through, and handle_mm_fault() is called, which in
    turn calls handle_pte_fault(), which calls update_mmu_cache(),
    which goes flush the dcache to a page with no access rights.
    
    Boom.
    
    This fixes it.
    
    Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
    Cc: Johannes Berg <johannes@sipsolutions.net>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
