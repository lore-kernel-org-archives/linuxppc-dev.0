Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9CNq4wCKzDqm3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jul 2017 13:59:39 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id v31so14709536qtb.3
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Jul 2017 20:59:39 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com, mhocko@kernel.org
Subject: [RFC v6 39/62] mm: display pkey in smaps if arch_pkeys_enabled() is
 true
Date: Sat, 15 Jul 2017 20:56:41 -0700
Message-Id: <1500177424-13695-40-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
References: <1500177424-13695-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the architecture specific code is expected to
display the protection keys in smap for a given vma.
This can lead to redundant code and possibly to divergent
formats in which the key gets displayed.

This patch changes the implementation. It displays the
pkey only if the architecture support pkeys.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 fs/proc/task_mmu.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e5710bc..d2b3e75 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -16,6 +16,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/shmem_fs.h>
+#include <linux/pkeys.h>
 
 #include <asm/elf.h>
 #include <linux/uaccess.h>
@@ -715,10 +716,6 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 }
 #endif /* HUGETLB_PAGE */
 
-void __weak arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
-{
-}
-
 static int show_smap(struct seq_file *m, void *v, int is_pid)
 {
 	struct vm_area_struct *vma = v;
@@ -804,7 +801,9 @@ static int show_smap(struct seq_file *m, void *v, int is_pid)
 		   (vma->vm_flags & VM_LOCKED) ?
 			(unsigned long)(mss.pss >> (10 + PSS_SHIFT)) : 0);
 
-	arch_show_smap(m, vma);
+	if (arch_pkeys_enabled())
+		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
+
 	show_smap_vma_flags(m, vma);
 	m_cache_vma(m, vma);
 	return 0;
-- 
1.7.1
