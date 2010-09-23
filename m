Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 00823B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 06:10:23 +1000 (EST)
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix invalid page flags in create TLB CAM path for
	PTE_64BIT
Date: Thu, 23 Sep 2010 16:10:15 -0400
Message-Id: <1285272615-22758-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tiejun Chen <tiejun.chen@windriver.com>

There exists a four line chunk of code, which when configured for
64 bit address space, can incorrectly set certain page flags during
the TLB creation.  It turns out that this is legacy code that is no
longer required, but since it isn't obvious why this is legacy code
or why it causes problems, the below description covers both in detail.

For powerpc bootstrap, the physical memory (at most 768M), is mapped
into the kernel space via the following path:

MMU_init()
    |
    + adjust_total_lowmem()
            |
            + map_mem_in_cams()
                    |
                    + settlbcam(i, virt, phys, cam_sz, PAGE_KERNEL_X, 0);

On settlbcam(), the kernel will create TLB entries according to the flag,
PAGE_KERNEL_X.

settlbcam()
{
        ...
        TLBCAM[index].MAS1 = MAS1_VALID
                        | MAS1_IPROT | MAS1_TSIZE(tsize) | MAS1_TID(pid);
                                ^
			These entries cannot be invalidated by the
			kernel since MAS1_IPROT is set on TLB property.
        ...
        if (flags & _PAGE_USER) {
           TLBCAM[index].MAS3 |= MAS3_UX | MAS3_UR;
           TLBCAM[index].MAS3 |= ((flags & _PAGE_RW) ? MAS3_UW : 0);
        }

For classic BookE (flags & _PAGE_USER) is 'zero' so it's fine.
But on boards like the the Freescale P4080, we want to support 36-bit
physical address on it. So the following options may be set:

CONFIG_FSL_BOOKE=y
CONFIG_PTE_64BIT=y
CONFIG_PHYS_64BIT=y

As a result, boards like the P4080 will introduce PTE format as Book3E.
As per the file: arch/powerpc/include/asm/pgtable-ppc32.h

  * #elif defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
  * #include <asm/pte-book3e.h>

So PAGE_KERNEL_X is __pgprot(_PAGE_BASE | _PAGE_KERNEL_RWX) and the
book3E version of _PAGE_KERNEL_RWX is defined with:

  (_PAGE_BAP_SW | _PAGE_BAP_SR | _PAGE_DIRTY | _PAGE_BAP_SX)

Note the _PAGE_BAP_SR, which is also defined in the book3E _PAGE_USER:

  #define _PAGE_USER        (_PAGE_BAP_UR | _PAGE_BAP_SR) /* Can be read */

So the possibility exists to wrongly assign the user MAS3_U<RWX> bits
to kernel (PAGE_KERNEL_X) address space via the following code fragment:

        if (flags & _PAGE_USER) {
           TLBCAM[index].MAS3 |= MAS3_UX | MAS3_UR;
           TLBCAM[index].MAS3 |= ((flags & _PAGE_RW) ? MAS3_UW : 0);
        }

Here is a dump of the TLB info from Simics with the above code present:
------
L2 TLB1
                                            GT                   SSS UUU V I
 Row  Logical           Physical            SS TLPID  TID  WIMGE XWR XWR F P   V
----- ----------------- ------------------- -- ----- ----- ----- --- --- - -   -
  0   c0000000-cfffffff 000000000-00fffffff 00     0     0   M   XWR XWR 0 1   1
  1   d0000000-dfffffff 010000000-01fffffff 00     0     0   M   XWR XWR 0 1   1
  2   e0000000-efffffff 020000000-02fffffff 00     0     0   M   XWR XWR 0 1   1

Actually this conditional code was only used for two legacy functions:

  1: support KGDB to set break point.
     KGDB already dropped this; now uses its core write to set break point.

  2: io_block_mapping() to create TLB in segmentation size (not PAGE_SIZE)
     for device IO space.
     This use case is also removed from the latest PowerPC kernel.

So it looks like the deletion of these 4 lines of code was simply
overlooked when the above two cases went away.

With the code deleted, the TLB appears without U having XWR as below:

-------
L2 TLB1
                                            GT                   SSS UUU V I
 Row  Logical           Physical            SS TLPID  TID  WIMGE XWR XWR F P   V
----- ----------------- ------------------- -- ----- ----- ----- --- --- - -   -
  0   c0000000-cfffffff 000000000-00fffffff 00     0     0   M   XWR     0 1   1
  1   d0000000-dfffffff 010000000-01fffffff 00     0     0   M   XWR     0 1   1
  2   e0000000-efffffff 020000000-02fffffff 00     0     0   M   XWR     0 1   1

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/powerpc/mm/fsl_booke_mmu.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index d5fa5f2..9de7e1b 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -136,11 +136,6 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	if (mmu_has_feature(MMU_FTR_BIG_PHYS))
 		TLBCAM[index].MAS7 = (u64)phys >> 32;
 
-	if (flags & _PAGE_USER) {
-	   TLBCAM[index].MAS3 |= MAS3_UX | MAS3_UR;
-	   TLBCAM[index].MAS3 |= ((flags & _PAGE_RW) ? MAS3_UW : 0);
-	}
-
 	tlbcam_addrs[index].start = virt;
 	tlbcam_addrs[index].limit = virt + size - 1;
 	tlbcam_addrs[index].phys = phys;
-- 
1.7.2.1
