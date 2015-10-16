Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70A1F1A0992
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 23:07:28 +1100 (AEDT)
Received: from localhost
 by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Fri, 16 Oct 2015 13:07:24 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp03.portsmouth.uk.ibm.com (Postfix) with ESMTP id EE6881B0806E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 13:07:27 +0100 (BST)
Received: from d06av04.portsmouth.uk.ibm.com (d06av04.portsmouth.uk.ibm.com
 [9.149.37.216])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9GC7MgL42270746
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 12:07:22 GMT
Received: from d06av04.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av04.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9GC7DHU009913
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 06:07:20 -0600
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 akpm@linux-foundation.org, xemul@parallels.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 benh@kernel.crashing.org, aneesh.kumar@linux.vnet.ibm.com, paulus@samba.org
Cc: criu@openvz.org
Subject: [PATCH 2/3] mm: clear_soft_dirty_pmd requires THP
Date: Fri, 16 Oct 2015 14:07:07 +0200
Message-Id: <c56e0cee475c34bda846ffbf1cc0e541ccb6b9b4.1444995096.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1444995096.git.ldufour@linux.vnet.ibm.com>
References: <cover.1444995096.git.ldufour@linux.vnet.ibm.com>
In-Reply-To: <cover.1444995096.git.ldufour@linux.vnet.ibm.com>
References: <cover.1444995096.git.ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Don't build clear_soft_dirty_pmd() if the transparent huge pages are
not enabled.

Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
CC: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 fs/proc/task_mmu.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c9454ee39b28..fa847a982a9f 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -762,7 +762,14 @@ static inline void clear_soft_dirty(struct vm_area_struct *vma,
 		set_pte_at(vma->vm_mm, addr, pte, ptent);
 	}
 }
+#else
+static inline void clear_soft_dirty(struct vm_area_struct *vma,
+		unsigned long addr, pte_t *pte)
+{
+}
+#endif
 
+#if defined(CONFIG_MEM_SOFT_DIRTY) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
 static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmdp)
 {
@@ -776,14 +783,7 @@ static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 
 	set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
 }
-
 #else
-
-static inline void clear_soft_dirty(struct vm_area_struct *vma,
-		unsigned long addr, pte_t *pte)
-{
-}
-
 static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
 		unsigned long addr, pmd_t *pmdp)
 {
-- 
1.9.1
