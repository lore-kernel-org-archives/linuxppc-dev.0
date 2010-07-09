Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 87BFD10085C
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 16:17:03 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.31.245])
	by e23smtp08.au.ibm.com (8.14.4/8.13.1) with ESMTP id o696H1pk027102
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:01 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o696H32J1556640
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:03 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o696H2p0013236
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 16:17:02 +1000
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 10/13] powerpc/book3e: Fix single step when using HW page
	tables
Date: Fri,  9 Jul 2010 16:16:52 +1000
Message-Id: <1278656215-24705-10-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1278656215-24705-9-git-send-email-benh@kernel.crashing.org>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-3-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-4-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-5-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-6-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-7-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-8-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-9-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We patch the TLB miss exception vectors to point to alternate
functions when using HW page table on BookE.

However, we were patching in a new branch in the first instruction
of the exception handler instead of the second one, thus overriding
the nop that is in the first instruction.

This cause problems when single stepping as we rely on that nop for
the single step to stop properly within the exception vector range
rather than on the target of the branch.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/exceptions-64e.S |    6 ++++++
 arch/powerpc/mm/tlb_nohash.c         |   13 +++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 316465a..5c43063 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -191,6 +191,12 @@ exc_##n##_bad_stack:							    \
 	sth	r1,PACA_TRAP_SAVE(r13);	/* store trap */		    \
 	b	bad_stack_book3e;	/* bad stack error */
 
+/* WARNING: If you change the layout of this stub, make sure you chcek
+	*   the debug exception handler which handles single stepping
+	*   into exceptions from userspace, and the MM code in
+	*   arch/powerpc/mm/tlb_nohash.c which patches the branch here
+	*   and would need to be updated if that branch is moved
+	*/
 #define	EXCEPTION_STUB(loc, label)					\
 	. = interrupt_base_book3e + loc;				\
 	nop;	/* To make debug interrupts happy */			\
diff --git a/arch/powerpc/mm/tlb_nohash.c b/arch/powerpc/mm/tlb_nohash.c
index e81d5d6..2ce42bf 100644
--- a/arch/powerpc/mm/tlb_nohash.c
+++ b/arch/powerpc/mm/tlb_nohash.c
@@ -391,10 +391,15 @@ static void __early_init_mmu(int boot_cpu)
 		/* Check if HW loader is supported */
 		if ((tlb0cfg & TLBnCFG_IND) &&
 		    (tlb0cfg & TLBnCFG_PT)) {
-			patch_branch(ibase + (0x1c0 / 4),
-			     (unsigned long)&exc_data_tlb_miss_htw_book3e, 0);
-			patch_branch(ibase + (0x1e0 / 4),
-			     (unsigned long)&exc_instruction_tlb_miss_htw_book3e, 0);
+			/* Our exceptions vectors start with a NOP and -then- a branch
+			 * to deal with single stepping from userspace which stops on
+			 * the second instruction. Thus we need to patch the second
+			 * instruction of the exception, not the first one
+			 */
+			patch_branch(ibase + (0x1c0 / 4) + 1,
+				(unsigned long)&exc_data_tlb_miss_htw_book3e, 0);
+			patch_branch(ibase + (0x1e0 / 4) + 1,
+				(unsigned long)&exc_instruction_tlb_miss_htw_book3e, 0);
 			book3e_htw_enabled = 1;
 		}
 		pr_info("MMU: Book3E Page Tables %s\n",
-- 
1.6.3.3
