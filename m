Return-Path: <rppt@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40608x3xfgzF1p4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:24:01 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LJIYGr077469
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 15:23:59 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2guw9k0p0p-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 15:23:59 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 19:23:56 -0000
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Richard Henderson <rth@twiddle.net>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
 Matt Turner <mattst88@gmail.com>, Tony Luck <tony.luck@intel.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Ralf Baechle <ralf@linux-mips.org>,
 James Hogan <jhogan@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kasan-dev@googlegroups.com,
 linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 12/32] docs/vm: mmu_notifier.txt: convert to ReST format
Date: Wed, 21 Mar 2018 21:22:28 +0200
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-Id: <1521660168-14372-13-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
---
 Documentation/vm/mmu_notifier.txt | 108 ++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 51 deletions(-)

diff --git a/Documentation/vm/mmu_notifier.txt b/Documentation/vm/mmu_notifier.txt
index 23b4625..47baa1c 100644
--- a/Documentation/vm/mmu_notifier.txt
+++ b/Documentation/vm/mmu_notifier.txt
@@ -1,7 +1,10 @@
+.. _mmu_notifier:
+
 When do you need to notify inside page table lock ?
+===================================================
 
 When clearing a pte/pmd we are given a choice to notify the event through
-(notify version of *_clear_flush call mmu_notifier_invalidate_range) under
+(notify version of \*_clear_flush call mmu_notifier_invalidate_range) under
 the page table lock. But that notification is not necessary in all cases.
 
 For secondary TLB (non CPU TLB) like IOMMU TLB or device TLB (when device use
@@ -18,6 +21,7 @@ a page that might now be used by some completely different task.
 
 Case B is more subtle. For correctness it requires the following sequence to
 happen:
+
   - take page table lock
   - clear page table entry and notify ([pmd/pte]p_huge_clear_flush_notify())
   - set page table entry to point to new page
@@ -28,58 +32,60 @@ the device.
 
 Consider the following scenario (device use a feature similar to ATS/PASID):
 
-Two address addrA and addrB such that |addrA - addrB| >= PAGE_SIZE we assume
+Two address addrA and addrB such that \|addrA - addrB\| >= PAGE_SIZE we assume
 they are write protected for COW (other case of B apply too).
 
-[Time N] --------------------------------------------------------------------
-CPU-thread-0  {try to write to addrA}
-CPU-thread-1  {try to write to addrB}
-CPU-thread-2  {}
-CPU-thread-3  {}
-DEV-thread-0  {read addrA and populate device TLB}
-DEV-thread-2  {read addrB and populate device TLB}
-[Time N+1] ------------------------------------------------------------------
-CPU-thread-0  {COW_step0: {mmu_notifier_invalidate_range_start(addrA)}}
-CPU-thread-1  {COW_step0: {mmu_notifier_invalidate_range_start(addrB)}}
-CPU-thread-2  {}
-CPU-thread-3  {}
-DEV-thread-0  {}
-DEV-thread-2  {}
-[Time N+2] ------------------------------------------------------------------
-CPU-thread-0  {COW_step1: {update page table to point to new page for addrA}}
-CPU-thread-1  {COW_step1: {update page table to point to new page for addrB}}
-CPU-thread-2  {}
-CPU-thread-3  {}
-DEV-thread-0  {}
-DEV-thread-2  {}
-[Time N+3] ------------------------------------------------------------------
-CPU-thread-0  {preempted}
-CPU-thread-1  {preempted}
-CPU-thread-2  {write to addrA which is a write to new page}
-CPU-thread-3  {}
-DEV-thread-0  {}
-DEV-thread-2  {}
-[Time N+3] ------------------------------------------------------------------
-CPU-thread-0  {preempted}
-CPU-thread-1  {preempted}
-CPU-thread-2  {}
-CPU-thread-3  {write to addrB which is a write to new page}
-DEV-thread-0  {}
-DEV-thread-2  {}
-[Time N+4] ------------------------------------------------------------------
-CPU-thread-0  {preempted}
-CPU-thread-1  {COW_step3: {mmu_notifier_invalidate_range_end(addrB)}}
-CPU-thread-2  {}
-CPU-thread-3  {}
-DEV-thread-0  {}
-DEV-thread-2  {}
-[Time N+5] ------------------------------------------------------------------
-CPU-thread-0  {preempted}
-CPU-thread-1  {}
-CPU-thread-2  {}
-CPU-thread-3  {}
-DEV-thread-0  {read addrA from old page}
-DEV-thread-2  {read addrB from new page}
+::
+
+ [Time N] --------------------------------------------------------------------
+ CPU-thread-0  {try to write to addrA}
+ CPU-thread-1  {try to write to addrB}
+ CPU-thread-2  {}
+ CPU-thread-3  {}
+ DEV-thread-0  {read addrA and populate device TLB}
+ DEV-thread-2  {read addrB and populate device TLB}
+ [Time N+1] ------------------------------------------------------------------
+ CPU-thread-0  {COW_step0: {mmu_notifier_invalidate_range_start(addrA)}}
+ CPU-thread-1  {COW_step0: {mmu_notifier_invalidate_range_start(addrB)}}
+ CPU-thread-2  {}
+ CPU-thread-3  {}
+ DEV-thread-0  {}
+ DEV-thread-2  {}
+ [Time N+2] ------------------------------------------------------------------
+ CPU-thread-0  {COW_step1: {update page table to point to new page for addrA}}
+ CPU-thread-1  {COW_step1: {update page table to point to new page for addrB}}
+ CPU-thread-2  {}
+ CPU-thread-3  {}
+ DEV-thread-0  {}
+ DEV-thread-2  {}
+ [Time N+3] ------------------------------------------------------------------
+ CPU-thread-0  {preempted}
+ CPU-thread-1  {preempted}
+ CPU-thread-2  {write to addrA which is a write to new page}
+ CPU-thread-3  {}
+ DEV-thread-0  {}
+ DEV-thread-2  {}
+ [Time N+3] ------------------------------------------------------------------
+ CPU-thread-0  {preempted}
+ CPU-thread-1  {preempted}
+ CPU-thread-2  {}
+ CPU-thread-3  {write to addrB which is a write to new page}
+ DEV-thread-0  {}
+ DEV-thread-2  {}
+ [Time N+4] ------------------------------------------------------------------
+ CPU-thread-0  {preempted}
+ CPU-thread-1  {COW_step3: {mmu_notifier_invalidate_range_end(addrB)}}
+ CPU-thread-2  {}
+ CPU-thread-3  {}
+ DEV-thread-0  {}
+ DEV-thread-2  {}
+ [Time N+5] ------------------------------------------------------------------
+ CPU-thread-0  {preempted}
+ CPU-thread-1  {}
+ CPU-thread-2  {}
+ CPU-thread-3  {}
+ DEV-thread-0  {read addrA from old page}
+ DEV-thread-2  {read addrB from new page}
 
 So here because at time N+2 the clear page table entry was not pair with a
 notification to invalidate the secondary TLB, the device see the new value for
-- 
2.7.4
