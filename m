Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2TcS1TLPzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 00:16:08 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3BEE0Km015786
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:15:56 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29rf064u9u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 10:15:55 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 08:15:54 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 Rick Lindsley <ricklind@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Update mm context addr limit correctly.
Date: Tue, 11 Apr 2017 19:45:35 +0530
Message-Id: <1491920135-13612-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We added the addr < TASK_SIZE check to avoid updating addr_limit unnecessarily and
also to avoid calling slice_flush_segments on all the cpus. This had the side
effect of having different behaviour when using an addr value above TASK_SIZE
before updating addr_limit and after updating addr_limit as show by below
output:

requesting with hint 0x0
Addr returned 0x7fff893a0000
requesting with hint 0xffffffffffffffff
Addr returned 0x7fff891b0000                  <===== 1st return
requesting with hint 0x1000000000000
Addr returned 0x1000000000000
requesting with hint 0xffffffffffffffff
Addr returned 0x1ffff89410000                <==== second return

After fix:
requesting with hint 0x0
Addr returned 0x7fff8bc00000
requesting with hint 0xffffffffffffffff
Addr returned 0x1ffff8bc80000                <==== 1st return
requesting with hint 0x1000000000000
Addr returned 0x1000000000000
requesting with hint 0xffffffffffffffff
Addr returned 0x1ffff8bc60000                <==== second return

Fixes: 1b49451ebd3e9 (powerpc/mm: Enable mappings above 128TB)
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/mmap.c  | 6 ++++--
 arch/powerpc/mm/slice.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/mmap.c b/arch/powerpc/mm/mmap.c
index b2111baa0da6..355b6fe8a1e6 100644
--- a/arch/powerpc/mm/mmap.c
+++ b/arch/powerpc/mm/mmap.c
@@ -97,7 +97,8 @@ radix__arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct vm_area_struct *vma;
 	struct vm_unmapped_area_info info;
 
-	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE))
+	if (unlikely(addr > mm->context.addr_limit &&
+		     mm->context.addr_limit != TASK_SIZE))
 		mm->context.addr_limit = TASK_SIZE;
 
 	if (len > mm->context.addr_limit - mmap_min_addr)
@@ -139,7 +140,8 @@ radix__arch_get_unmapped_area_topdown(struct file *filp,
 	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info;
 
-	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE))
+	if (unlikely(addr > mm->context.addr_limit &&
+		     mm->context.addr_limit != TASK_SIZE))
 		mm->context.addr_limit = TASK_SIZE;
 
 	/* requested length too big for entire address space */
diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 251b6bae7023..2d2d9760d057 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -419,7 +419,8 @@ unsigned long slice_get_unmapped_area(unsigned long addr, unsigned long len,
 	/*
 	 * Check if we need to expland slice area.
 	 */
-	if (unlikely(addr > mm->context.addr_limit && addr < TASK_SIZE)) {
+	if (unlikely(addr > mm->context.addr_limit &&
+		     mm->context.addr_limit != TASK_SIZE)) {
 		mm->context.addr_limit = TASK_SIZE;
 		on_each_cpu(slice_flush_segments, mm, 1);
 	}
-- 
2.7.4
