Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVmhq5wR4zDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:59:39 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id j58so10030244qtj.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 00:59:39 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
 corbet@lwn.net, arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v9 28/51] mm: display pkey in smaps if arch_pkeys_enabled() is
 true
Date: Mon,  6 Nov 2017 00:57:20 -0800
Message-Id: <1509958663-18737-29-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
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
index 0957dd7..b8b8d0e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1357,11 +1357,3 @@ static int __init register_kernel_offset_dumper(void)
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
index fad19a0..5ce3ec0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -18,6 +18,7 @@
 #include <linux/page_idle.h>
 #include <linux/shmem_fs.h>
 #include <linux/uaccess.h>
+#include <linux/pkeys.h>
 
 #include <asm/elf.h>
 #include <asm/tlb.h>
@@ -731,10 +732,6 @@ static int smaps_hugetlb_range(pte_t *pte, unsigned long hmask,
 }
 #endif /* HUGETLB_PAGE */
 
-void __weak arch_show_smap(struct seq_file *m, struct vm_area_struct *vma)
-{
-}
-
 static int show_smap(struct seq_file *m, void *v, int is_pid)
 {
 	struct proc_maps_private *priv = m->private;
@@ -854,9 +851,13 @@ static int show_smap(struct seq_file *m, void *v, int is_pid)
 			   (unsigned long)(mss->pss >> (10 + PSS_SHIFT)));
 
 	if (!rollup_mode) {
-		arch_show_smap(m, vma);
+#ifdef CONFIG_ARCH_HAS_PKEYS
+		if (arch_pkeys_enabled())
+			seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
+#endif
 		show_smap_vma_flags(m, vma);
 	}
+
 	m_cache_vma(m, vma);
 	return ret;
 }
-- 
1.7.1
