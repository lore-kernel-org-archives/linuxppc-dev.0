Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com
 [IPv6:2607:f8b0:400d:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xvDxx0FwDzDrbw
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Sep 2017 11:21:40 +1000 (AEST)
Received: by mail-qk0-x242.google.com with SMTP id o77so2436557qke.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 18:21:40 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org
Cc: arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 3/6] mm: display pkey in smaps if arch_pkeys_enabled() is true
Date: Fri, 15 Sep 2017 18:21:07 -0700
Message-Id: <1505524870-4783-4-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
References: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the  architecture  specific code is expected to
display  the  protection  keys  in  smap  for a given vma.
This can lead to redundant code and possibly to divergent
formats in which the key gets displayed.

This  patch  changes  the implementation. It displays the
pkey only if the architecture support pkeys.

x86 arch_show_smap() function is not needed anymore.
Delete it.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/x86/kernel/setup.c |    8 --------
 fs/proc/task_mmu.c      |   11 ++++++-----
 2 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3486d04..1953bce 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1340,11 +1340,3 @@ static int __init register_kernel_offset_dumper(void)
 	return 0;
 }
 __initcall(register_kernel_offset_dumper);
-
-void arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
-{
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
-		return;
-
-	seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
-}
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cf25306..667d44a 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -16,6 +16,7 @@
 #include <linux/mmu_notifier.h>
 #include <linux/page_idle.h>
 #include <linux/shmem_fs.h>
+#include <linux/pkeys.h>
 
 #include <asm/elf.h>
 #include <linux/uaccess.h>
@@ -714,10 +715,6 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 }
 #endif /* HUGETLB_PAGE */
 
-void __weak arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
-{
-}
-
 static int show_smap(struct seq_file *m, void *v, int is_pid)
 {
 	struct vm_area_struct *vma = v;
@@ -803,7 +800,11 @@ static int show_smap(struct seq_file *m, void *v, int is_pid)
 		   (vma->vm_flags & VM_LOCKED) ?
 			(unsigned long)(mss.pss >> (10 + PSS_SHIFT)) : 0);
 
-	arch_show_smap(m, vma);
+#ifdef CONFIG_ARCH_HAS_PKEYS
+	if (arch_pkeys_enabled())
+		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
+#endif
+
 	show_smap_vma_flags(m, vma);
 	m_cache_vma(m, vma);
 	return 0;
-- 
1.7.1
