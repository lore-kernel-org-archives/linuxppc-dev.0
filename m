Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 40F1EB710F
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 25 Sep 2010 02:45:06 +1000 (EST)
Date: Fri, 24 Sep 2010 12:44:52 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix invalid page flags in create TLB CAM path
	for PTE_64BIT
Message-ID: <20100924164451.GA14042@windriver.com>
References: <1285272615-22758-1-git-send-email-paul.gortmaker@windriver.com>
	<20100923153347.4b517105@udp111988uds.am.freescale.net>
	<1285279157.5158.17.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285279157.5158.17.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Re: [PATCH] powerpc: Fix invalid page flags in create TLB CAM path for PTE_64BIT] On 24/09/2010 (Fri 07:59) Benjamin Herrenschmidt wrote:

> On Thu, 2010-09-23 at 15:33 -0500, Scott Wood wrote:
> > I don't see a generic accessor that can test PTE flags for user
> > access -- in the absence of one, I guess we need an ifdef here.  Or at
> > least put in a comment so anyone who adds a userspace use knows they
> > need to fix it. 
> 
> We could make up one in powerpc arch at least
> 
> #define pte_user(val) ((val & _PAGE_USER) == _PAGE_USER)
> 
> would do

I've put the above into pte-common.h, restored the deleted code block
which now uses pte_user() and I've updated the commit header to match.
Passes sanity boot test on an sbc8548 both with and without PTE_64BIT.

Thanks for the feedback.
Paul.


>From d48ebb58b8214f9faec775a5e06902f638f165cf Mon Sep 17 00:00:00 2001
From: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 21 Sep 2010 19:31:31 +0800
Subject: [PATCH] powerpc: Fix invalid page flags in create TLB CAM path for PTE_64BIT

There exists a four line chunk of code, which when configured for
64 bit address space, can incorrectly set certain page flags during
the TLB creation.  It turns out that this is code which isn't used,
but might still serve a purpose.  Since it isn't obvious why it exists
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

Actually this conditional code was used for two legacy functions:

  1: support KGDB to set break point.
     KGDB already dropped this; now uses its core write to set break point.

  2: io_block_mapping() to create TLB in segmentation size (not PAGE_SIZE)
     for device IO space.
     This use case is also removed from the latest PowerPC kernel.

However, there may still be a use case for it in the future, like
large user pages, so we can't remove it entirely.  As an alternative,
we match on all bits of _PAGE_USER instead of just any bits, so the
case where just _PAGE_BAP_SR is set can't sneak through.

With this done, the TLB appears without U having XWR as below:

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
 arch/powerpc/include/asm/pte-common.h |    7 +++++++
 arch/powerpc/mm/fsl_booke_mmu.c       |    3 ++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-common.h b/arch/powerpc/include/asm/pte-common.h
index f2b3701..76bb195 100644
--- a/arch/powerpc/include/asm/pte-common.h
+++ b/arch/powerpc/include/asm/pte-common.h
@@ -171,6 +171,13 @@ extern unsigned long bad_call_to_PMD_PAGE_SIZE(void);
 /* Make modules code happy. We don't set RO yet */
 #define PAGE_KERNEL_EXEC	PAGE_KERNEL_X
 
+/*
+ * Don't just check for any non zero bits in __PAGE_USER, since for book3e
+ * and PTE_64BIT, PAGE_KERNEL_X contains _PAGE_BAP_SR which is also in
+ * _PAGE_USER.  Need to explictly match _PAGE_BAP_UR bit in that case too.
+ */
+#define pte_user(val)		((val & _PAGE_USER) == _PAGE_USER)
+
 /* Advertise special mapping type for AGP */
 #define PAGE_AGP		(PAGE_KERNEL_NC)
 #define HAVE_PAGE_AGP
diff --git a/arch/powerpc/mm/fsl_booke_mmu.c b/arch/powerpc/mm/fsl_booke_mmu.c
index 4b66a1e..1b4354d 100644
--- a/arch/powerpc/mm/fsl_booke_mmu.c
+++ b/arch/powerpc/mm/fsl_booke_mmu.c
@@ -137,7 +137,8 @@ static void settlbcam(int index, unsigned long virt, phys_addr_t phys,
 	if (mmu_has_feature(MMU_FTR_BIG_PHYS))
 		TLBCAM[index].MAS7 = (u64)phys >> 32;
 
-	if (flags & _PAGE_USER) {
+	/* Below is unlikely -- only for large user pages or similar */
+	if (pte_user(flags)) {
 	   TLBCAM[index].MAS3 |= MAS3_UX | MAS3_UR;
 	   TLBCAM[index].MAS3 |= ((flags & _PAGE_RW) ? MAS3_UW : 0);
 	}
-- 
1.7.2.1
