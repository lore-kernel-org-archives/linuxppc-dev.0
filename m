Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4012hM3wRfzDrTB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2018 05:00:35 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w2DHsJ3a055934
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 14:00:32 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2gpk9t0mwj-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2018 14:00:31 -0400
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 13 Mar 2018 18:00:29 -0000
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 hpa@zytor.com, Will Deacon <will.deacon@arm.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 Andrea Arcangeli <aarcange@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>, kemi.wang@intel.com,
 sergey.senozhatsky.work@gmail.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com, bsingharora@gmail.com,
 Tim Chen <tim.c.chen@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org
Subject: [PATCH v9 12/24] mm/migrate: Pass vm_fault pointer to
 migrate_misplaced_page()
Date: Tue, 13 Mar 2018 18:59:42 +0100
In-Reply-To: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1520963994-28477-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-Id: <1520963994-28477-13-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

migrate_misplaced_page() is only called during the page fault handling so
it's better to pass the pointer to the struct vm_fault instead of the vma.

This way during the speculative page fault path the saved vma->vm_flags
could be used.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 include/linux/migrate.h | 4 ++--
 mm/memory.c             | 2 +-
 mm/migrate.c            | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index f2b4abbca55e..fd4c3ab7bd9c 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -126,14 +126,14 @@ static inline void __ClearPageMovable(struct page *page)
 #ifdef CONFIG_NUMA_BALANCING
 extern bool pmd_trans_migrating(pmd_t pmd);
 extern int migrate_misplaced_page(struct page *page,
-				  struct vm_area_struct *vma, int node);
+				  struct vm_fault *vmf, int node);
 #else
 static inline bool pmd_trans_migrating(pmd_t pmd)
 {
 	return false;
 }
 static inline int migrate_misplaced_page(struct page *page,
-					 struct vm_area_struct *vma, int node)
+					 struct vm_fault *vmf, int node)
 {
 	return -EAGAIN; /* can't migrate now */
 }
diff --git a/mm/memory.c b/mm/memory.c
index 46fe92b93682..412014d5785b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3880,7 +3880,7 @@ static int do_numa_page(struct vm_fault *vmf)
 	}
 
 	/* Migrate to the requested node */
-	migrated = migrate_misplaced_page(page, vma, target_nid);
+	migrated = migrate_misplaced_page(page, vmf, target_nid);
 	if (migrated) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
diff --git a/mm/migrate.c b/mm/migrate.c
index 5d0dc7b85f90..ad8692ca6a4f 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1900,7 +1900,7 @@ bool pmd_trans_migrating(pmd_t pmd)
  * node. Caller is expected to have an elevated reference count on
  * the page that will be dropped by this function before returning.
  */
-int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
+int migrate_misplaced_page(struct page *page, struct vm_fault *vmf,
 			   int node)
 {
 	pg_data_t *pgdat = NODE_DATA(node);
@@ -1913,7 +1913,7 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
 	 * with execute permissions as they are probably shared libraries.
 	 */
 	if (page_mapcount(page) != 1 && page_is_file_cache(page) &&
-	    (vma->vm_flags & VM_EXEC))
+	    (vmf->vma_flags & VM_EXEC))
 		goto out;
 
 	/*
-- 
2.7.4
