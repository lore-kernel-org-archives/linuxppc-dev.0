Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sqYWb0yK9zDrPb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Oct 2016 00:33:30 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u96DUJCQ088465
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Oct 2016 09:33:28 -0400
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 by mx0b-001b2d01.pphosted.com with ESMTP id 25wjgd8c0m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 06 Oct 2016 09:33:27 -0400
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Thu, 6 Oct 2016 14:33:26 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com
 (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 41F1B1B08023
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Oct 2016 14:35:21 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u96DXNdf11862400
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Oct 2016 13:33:23 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u96DXM2S014405
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Oct 2016 07:33:22 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/pseries: Fix stack corruption in htpe code
Date: Thu,  6 Oct 2016 15:33:21 +0200
Message-Id: <1475760801-10592-1-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This commit fixes a stack corruption in the pseries specific code dealing
with the huge pages.

In __pSeries_lpar_hugepage_invalidate() the buffer used to pass arguments
to the hypervisor is not large enough. This leads to a stack corruption
where a previously saved register could be corrupted leading to unexpected
result in the caller, like the following panic:

Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2048 NUMA pSeries
Modules linked in: virtio_balloon ip_tables x_tables autofs4
virtio_blk 8139too virtio_pci virtio_ring 8139cp virtio
CPU: 11 PID: 1916 Comm: mmstress Not tainted 4.8.0 #76
task: c000000005394880 task.stack: c000000005570000
NIP: c00000000027bf6c LR: c00000000027bf64 CTR: 0000000000000000
REGS: c000000005573820 TRAP: 0300   Not tainted  (4.8.0)
MSR: 8000000000009033 <SF,EE,ME,IR,DR,RI,LE>  CR: 84822884  XER:
20000000
CFAR: c00000000010a924 DAR: 420000000014e5e0 DSISR: 40000000 SOFTE: 1
GPR00: c00000000027bf64 c000000005573aa0 c000000000e02800 c000000004447964
GPR04: c00000000404de18 c000000004d38810 00000000042100f5 00000000f5002104
GPR08: e0000000f5002104 0000000000000001 042100f5000000e0 00000000042100f5
GPR12: 0000000000002200 c00000000fe02c00 c00000000404de18 0000000000000000
GPR16: c1ffffffffffe7ff 00003fff62000000 420000000014e5e0 00003fff63000000
GPR20: 0008000000000000 c0000000f7014800 0405e600000000e0 0000000000010000
GPR24: c000000004d38810 c000000004447c10 c00000000404de18 c000000004447964
GPR28: c000000005573b10 c000000004d38810 00003fff62000000 420000000014e5e0
NIP [c00000000027bf6c] zap_huge_pmd+0x4c/0x470
LR [c00000000027bf64] zap_huge_pmd+0x44/0x470
Call Trace:
[c000000005573aa0] [c00000000027bf64] zap_huge_pmd+0x44/0x470 (unreliable)
[c000000005573af0] [c00000000022bbd8] unmap_page_range+0xcf8/0xed0
[c000000005573c30] [c00000000022c2d4] unmap_vmas+0x84/0x120
[c000000005573c80] [c000000000235448] unmap_region+0xd8/0x1b0
[c000000005573d80] [c0000000002378f0] do_munmap+0x2d0/0x4c0
[c000000005573df0] [c000000000237be4] SyS_munmap+0x64/0xb0
[c000000005573e30] [c000000000009560] system_call+0x38/0x108
Instruction dump:
fbe1fff8 fb81ffe0 7c7f1b78 7ca32b78 7cbd2b78 f8010010 7c9a2378 f821ffb1
7cde3378 4bfffea9 7c7b1b79 41820298 <e87f0000> 48000130 7fa5eb78 7fc4f378

Most of the time, the bug is surfacing in a caller up in the stack from
__pSeries_lpar_hugepage_invalidate() which is quite confusing.

This bug is pending since v3.11 but was hidden if a caller of the
caller of __pSeries_lpar_hugepage_invalidate() has pushed the corruped
register (r18 in this case) in the stack and is not using it until
restoring it. GCC 6.2.0 seems to raise it more frequently.

This commit also change the definition of the parameter buffer in
pSeries_lpar_flush_hash_range() to rely on the global define
PLPAR_HCALL9_BUFSIZE (no functional change here).

Fixes: 1a5272866f87 ("powerpc: Optimize hugepage invalidate")
Cc: <stable@vger.kernel.org>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 86707e67843f..aa35245d8d6d 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -393,7 +393,7 @@ static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 					     unsigned long *vpn, int count,
 					     int psize, int ssize)
 {
-	unsigned long param[8];
+	unsigned long param[PLPAR_HCALL9_BUFSIZE];
 	int i = 0, pix = 0, rc;
 	unsigned long flags = 0;
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
@@ -522,7 +522,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	unsigned long flags = 0;
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
-	unsigned long param[9];
+	unsigned long param[PLPAR_HCALL9_BUFSIZE];
 	unsigned long hash, index, shift, hidx, slot;
 	real_pte_t pte;
 	int psize, ssize;
-- 
2.7.4
