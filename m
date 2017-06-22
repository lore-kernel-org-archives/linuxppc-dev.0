Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtPRj1sBCzDr2H
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 11:40:49 +1000 (AEST)
Received: by mail-qk0-x241.google.com with SMTP id p21so370708qke.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 18:40:49 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com, arnd@arndb.de, akpm@linux-foundation.org,
 corbet@lwn.net, mingo@redhat.com
Subject: [RFC v3 23/23] procfs: display the protection-key number associated
 with a vma
Date: Wed, 21 Jun 2017 18:39:39 -0700
Message-Id: <1498095579-6790-24-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
References: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Display the pkey number associated with the vma in smaps of a task.
The key will be seen as below:

VmFlags: rd wr mr mw me dw ac key=0

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 Documentation/filesystems/proc.txt |  3 ++-
 fs/proc/task_mmu.c                 | 22 +++++++++++-----------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
index 4cddbce..a8c74aa 100644
--- a/Documentation/filesystems/proc.txt
+++ b/Documentation/filesystems/proc.txt
@@ -423,7 +423,7 @@ SwapPss:               0 kB
 KernelPageSize:        4 kB
 MMUPageSize:           4 kB
 Locked:                0 kB
-VmFlags: rd ex mr mw me dw
+VmFlags: rd ex mr mw me dw key=<num>
 
 the first of these lines shows the same information as is displayed for the
 mapping in /proc/PID/maps.  The remaining lines show the size of the mapping
@@ -491,6 +491,7 @@ manner. The codes are the following:
     hg  - huge page advise flag
     nh  - no-huge page advise flag
     mg  - mergable advise flag
+    key=<num> - the memory protection key number
 
 Note that there is no guarantee that every flag and associated mnemonic will
 be present in all further kernel releases. Things get changed, the flags may
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2ddc298..d2eb096 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1,4 +1,6 @@
 #include <linux/mm.h>
+#include <linux/pkeys.h>
+#include <linux/huge_mm.h>
 #include <linux/vmacache.h>
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
@@ -666,22 +668,20 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MERGEABLE)]	= "mg",
 		[ilog2(VM_UFFD_MISSING)]= "um",
 		[ilog2(VM_UFFD_WP)]	= "uw",
-#ifdef CONFIG_ARCH_HAS_PKEYS
-		/* These come out via ProtectionKey: */
-		[ilog2(VM_PKEY_BIT0)]	= "",
-		[ilog2(VM_PKEY_BIT1)]	= "",
-		[ilog2(VM_PKEY_BIT2)]	= "",
-		[ilog2(VM_PKEY_BIT3)]	= "",
-#endif /* CONFIG_ARCH_HAS_PKEYS */
-#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
-		/* Additional bit in ProtectionKey: */
-		[ilog2(VM_PKEY_BIT4)]	= "",
-#endif
 	};
 	size_t i;
 
 	seq_puts(m, "VmFlags: ");
 	for (i = 0; i < BITS_PER_LONG; i++) {
+#ifdef CONFIG_ARCH_HAS_PKEYS
+		if (i == ilog2(VM_PKEY_BIT0)) {
+			int keyvalue = vma_pkey(vma);
+
+			i += ilog2(arch_max_pkey())-1;
+			seq_printf(m, "key=%d ", keyvalue);
+			continue;
+		}
+#endif /* CONFIG_ARCH_HAS_PKEYS */
 		if (!mnemonics[i][0])
 			continue;
 		if (vma->vm_flags & (1UL << i)) {
-- 
1.8.3.1
