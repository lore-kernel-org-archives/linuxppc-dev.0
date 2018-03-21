Return-Path: <rppt@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40609s6Dp0zF1s0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 06:24:49 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2LJIajq094373
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 15:24:47 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2guvmsagvg-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 15:24:46 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <rppt@linux.vnet.ibm.com>;
 Wed, 21 Mar 2018 19:24:44 -0000
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
Subject: [PATCH 23/32] docs/vm: split_page_table_lock: convert to ReST format
Date: Wed, 21 Mar 2018 21:22:39 +0200
In-Reply-To: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1521660168-14372-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-Id: <1521660168-14372-24-git-send-email-rppt@linux.vnet.ibm.com>
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
 Documentation/vm/split_page_table_lock | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/vm/split_page_table_lock b/Documentation/vm/split_page_table_lock
index 62842a8..889b00b 100644
--- a/Documentation/vm/split_page_table_lock
+++ b/Documentation/vm/split_page_table_lock
@@ -1,3 +1,6 @@
+.. _split_page_table_lock:
+
+=====================
 Split page table lock
 =====================
 
@@ -11,6 +14,7 @@ access to the table. At the moment we use split lock for PTE and PMD
 tables. Access to higher level tables protected by mm->page_table_lock.
 
 There are helpers to lock/unlock a table and other accessor functions:
+
  - pte_offset_map_lock()
 	maps pte and takes PTE table lock, returns pointer to the taken
 	lock;
@@ -34,12 +38,13 @@ Split page table lock for PMD tables is enabled, if it's enabled for PTE
 tables and the architecture supports it (see below).
 
 Hugetlb and split page table lock
----------------------------------
+=================================
 
 Hugetlb can support several page sizes. We use split lock only for PMD
 level, but not for PUD.
 
 Hugetlb-specific helpers:
+
  - huge_pte_lock()
 	takes pmd split lock for PMD_SIZE page, mm->page_table_lock
 	otherwise;
@@ -47,7 +52,7 @@ Hugetlb-specific helpers:
 	returns pointer to table lock;
 
 Support of split page table lock by an architecture
----------------------------------------------------
+===================================================
 
 There's no need in special enabling of PTE split page table lock:
 everything required is done by pgtable_page_ctor() and pgtable_page_dtor(),
@@ -73,7 +78,7 @@ NOTE: pgtable_page_ctor() and pgtable_pmd_page_ctor() can fail -- it must
 be handled properly.
 
 page->ptl
----------
+=========
 
 page->ptl is used to access split page table lock, where 'page' is struct
 page of page containing the table. It shares storage with page->private
@@ -81,6 +86,7 @@ page of page containing the table. It shares storage with page->private
 
 To avoid increasing size of struct page and have best performance, we use a
 trick:
+
  - if spinlock_t fits into long, we use page->ptr as spinlock, so we
    can avoid indirect access and save a cache line.
  - if size of spinlock_t is bigger then size of long, we use page->ptl as
-- 
2.7.4
