Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18316.35013.246973.689872@cargo.ozlabs.ibm.com>
Date: Tue, 15 Jan 2008 21:19:49 +1100
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

to get two more bug fixes for powerpc.  One is a fix for a recently
introduced regression which means that the kernel doesn't boot on
POWER6 machines.  The other is a fix for something that got broken
back in the 2.6.19 timeframe.

Thanks,
Paul.

 arch/powerpc/kernel/iommu.c           |   17 ++++++++++++++---
 arch/powerpc/mm/slb.c                 |   10 ++--------
 arch/powerpc/platforms/pseries/lpar.c |    1 -
 include/asm-powerpc/mmu-hash64.h      |    1 -
 4 files changed, 16 insertions(+), 13 deletions(-)

commit dfbe0d3b6be52596b5694b1bb75b19562e769021
Author: Paul Mackerras <paulus@samba.org>
Date:   Tue Jan 15 17:29:33 2008 +1100

    [POWERPC] Fix boot failure on POWER6
    
    Commit 473980a99316c0e788bca50996375a2815124ce1 added a call to clear
    the SLB shadow buffer before registering it.  Unfortunately this means
    that we clear out the entries that slb_initialize has previously set in
    there.  On POWER6, the hypervisor uses the SLB shadow buffer when doing
    partition switches, and that means that after the next partition switch,
    each non-boot CPU has no SLB entries to map the kernel text and data,
    which causes it to crash.
    
    This fixes it by reverting most of 473980a9 and instead clearing the
    3rd entry explicitly in slb_initialize.  This fixes the problem that
    473980a9 was trying to solve, but without breaking POWER6.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit d262c32a4bcc3e5fda0325a64e53c25fe1e999d7
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Tue Jan 8 10:34:22 2008 +1100

    [POWERPC] Workaround for iommu page alignment
    
    Commit 5d2efba64b231a1733c4048d1708d77e07f26426 changed our iommu code
    so that it always uses an iommu page size of 4kB.  That means with our
    current code, drivers may do a dma_map_sg() of a 64kB page and obtain
    a dma_addr_t that is only 4k aligned.
    
    This works fine in most cases except for some infiniband HW it seems,
    where they tell the HW about the page size and it ignores the low bits
    of the DMA address.
    
    This works around it by making our IOMMU code enforce a PAGE_SIZE alignment
    for mappings of objects that are page aligned in the first place and whose
    size is larger or equal to a page.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
