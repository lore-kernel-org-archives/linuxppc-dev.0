Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409QFV4cNPzF29r
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 20:09:50 +1100 (AEDT)
Received: by mail-qt0-x242.google.com with SMTP id s2so22956254qti.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 02:09:50 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	mingo@redhat.com,
	akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com,
 corbet@lwn.net, arnd@arndb.de
Subject: [PATCH v13 1/3] mm, powerpc,
 x86: define VM_PKEY_BITx bits if CONFIG_ARCH_HAS_PKEYS is enabled
Date: Tue, 27 Mar 2018 02:09:26 -0700
Message-Id: <1522141768-25485-2-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1522141768-25485-1-git-send-email-linuxram@us.ibm.com>
References: <1522141768-25485-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

VM_PKEY_BITx are defined only if CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
is enabled. Powerpc also needs these bits. Hence lets define the
VM_PKEY_BITx bits for any architecture that enables
CONFIG_ARCH_HAS_PKEYS.

cc: Michael Ellermen <mpe@ellerman.id.au>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h |    2 ++
 fs/proc/task_mmu.c               |    4 ++--
 include/linux/mm.h               |    9 +++++----
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 0d3c630..99344d7 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -26,6 +26,8 @@
 # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
 # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
 # define VM_PKEY_BIT4	VM_HIGH_ARCH_4
+#elif !defined(VM_PKEY_BIT4)
+# define VM_PKEY_BIT4	VM_HIGH_ARCH_4
 #endif
 
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index ec6d298..6b996d0 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -679,13 +679,13 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
 		[ilog2(VM_MERGEABLE)]	= "mg",
 		[ilog2(VM_UFFD_MISSING)]= "um",
 		[ilog2(VM_UFFD_WP)]	= "uw",
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+#ifdef CONFIG_ARCH_HAS_PKEYS
 		/* These come out via ProtectionKey: */
 		[ilog2(VM_PKEY_BIT0)]	= "",
 		[ilog2(VM_PKEY_BIT1)]	= "",
 		[ilog2(VM_PKEY_BIT2)]	= "",
 		[ilog2(VM_PKEY_BIT3)]	= "",
-#endif
+#endif /* CONFIG_ARCH_HAS_PKEYS */
 	};
 	size_t i;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42..ad207ad 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -228,15 +228,16 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
-#if defined(CONFIG_X86)
-# define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
-#if defined (CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS)
+#ifdef CONFIG_ARCH_HAS_PKEYS
 # define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
 # define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 4-bit value */
 # define VM_PKEY_BIT1	VM_HIGH_ARCH_1
 # define VM_PKEY_BIT2	VM_HIGH_ARCH_2
 # define VM_PKEY_BIT3	VM_HIGH_ARCH_3
-#endif
+#endif /* CONFIG_ARCH_HAS_PKEYS */
+
+#if defined(CONFIG_X86)
+# define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
 #elif defined(CONFIG_PPC)
 # define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
 #elif defined(CONFIG_PARISC)
-- 
1.7.1
