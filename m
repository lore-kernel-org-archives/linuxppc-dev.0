Return-Path: <clg@fr.ibm.com>
Received: from e06smtp17.uk.ibm.com (e06smtp17.uk.ibm.com [195.75.94.113])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B93C1A0274
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Oct 2014 01:31:25 +1100 (AEDT)
Received: from /spool/local
 by e06smtp17.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Mon, 27 Oct 2014 14:31:20 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id 162961B08051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 14:31:18 +0000 (GMT)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9REVFTP2818428
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 14:31:15 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9REVEmi014945
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 08:31:15 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: mpe@ellerman.id.au
Subject: [PATCH] powerc: fix build failure when CONFIG_HUGETLB_PAGE is not set
Date: Mon, 27 Oct 2014 15:30:06 +0100
Message-Id: <1414420206-7869-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  CC      arch/powerpc/mm/slice.o
In file included from ../arch/powerpc/mm/slice.c:33:0:
../include/linux/hugetlb.h:141:47: error: expected identifier or ‘(’ before numeric constant
 #define is_hugepage_only_range(mm, addr, len) 0
                                               ^
../arch/powerpc/mm/slice.c:704:5: note: in expansion of macro ‘is_hugepage_only_range’
 int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
     ^

Signed-off-by: Cédric Le Goater <clg@fr.ibm.com>
---
 arch/powerpc/mm/slice.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
index 8d7bda94d196..89bc01222649 100644
--- a/arch/powerpc/mm/slice.c
+++ b/arch/powerpc/mm/slice.c
@@ -682,6 +682,7 @@ void slice_set_range_psize(struct mm_struct *mm, unsigned long start,
 	slice_convert(mm, mask, psize);
 }
 
+#ifdef CONFIG_HUGETLB_PAGE
 /*
  * is_hugepage_only_range() is used by generic code to verify whether
  * a normal mmap mapping (non hugetlbfs) is valid on a given area.
@@ -727,3 +728,4 @@ int is_hugepage_only_range(struct mm_struct *mm, unsigned long addr,
 	return !slice_check_fit(mask, available);
 }
 
+#endif
-- 
1.7.10.4
