Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2v3s1sWtzDr3x
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 07:23:05 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id p21so204293qke.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 14:23:05 -0700 (PDT)
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
Subject: [RFC v5 14/38] powerpc: initial plumbing for key management
Date: Wed,  5 Jul 2017 14:21:51 -0700
Message-Id: <1499289735-14220-15-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Initial plumbing to manage all the keys supported by the
hardware.

Total 32 keys are supported on powerpc. However pkey 0,1
and 31 are reserved. So effectively we have 29 pkeys.

This patch keeps track of reserved keys, allocated  keys
and keys that are currently free.

Also it  adds  skeletal  functions  and macros, that the
architecture-independent code expects to be available.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/Kconfig                     |   16 +++++
 arch/powerpc/include/asm/book3s/64/mmu.h |    9 +++
 arch/powerpc/include/asm/pkeys.h         |  106 ++++++++++++++++++++++++++++++
 arch/powerpc/mm/mmu_context_book3s64.c   |    5 ++
 4 files changed, 136 insertions(+), 0 deletions(-)
 create mode 100644 arch/powerpc/include/asm/pkeys.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f7c8f99..a2480b6 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -871,6 +871,22 @@ config SECCOMP
 
 	  If unsure, say Y. Only embedded should say N here.
 
+config PPC64_MEMORY_PROTECTION_KEYS
+	prompt "PowerPC Memory Protection Keys"
+	def_bool y
+	# Note: only available in 64-bit mode
+	depends on PPC64 && PPC_64K_PAGES
+	select ARCH_USES_HIGH_VMA_FLAGS
+	select ARCH_HAS_PKEYS
+	---help---
+	  Memory Protection Keys provides a mechanism for enforcing
+	  page-based protections, but without requiring modification of the
+	  page tables when an application changes protection domains.
+
+	  For details, see Documentation/powerpc/protection-keys.txt
+
+	  If unsure, say y.
+
 endmenu
 
 config ISA_DMA_API
diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 77529a3..104ad72 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -108,6 +108,15 @@ struct patb_entry {
 #ifdef CONFIG_SPAPR_TCE_IOMMU
 	struct list_head iommu_group_mem_list;
 #endif
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	/*
+	 * Each bit represents one protection key.
+	 * bit set   -> key allocated
+	 * bit unset -> key available for allocation
+	 */
+	u32 pkey_allocation_map;
+#endif
 } mm_context_t;
 
 /*
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
new file mode 100644
index 0000000..9345767
--- /dev/null
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -0,0 +1,106 @@
+#ifndef _ASM_PPC64_PKEYS_H
+#define _ASM_PPC64_PKEYS_H
+
+#define arch_max_pkey()  32
+#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
+				VM_PKEY_BIT3 | VM_PKEY_BIT4)
+/*
+ * Bits are in BE format.
+ * NOTE: key 31, 1, 0 are not used.
+ * key 0 is used by default. It give read/write/execute permission.
+ * key 31 is reserved by the hypervisor.
+ * key 1 is recommended to be not used.
+ * PowerISA(3.0) page 1015, programming note.
+ */
+#define PKEY_INITIAL_ALLOCAION  0xc0000001
+
+#define pkeybit_mask(pkey) (0x1 << (arch_max_pkey() - pkey - 1))
+
+#define mm_pkey_allocation_map(mm)	(mm->context.pkey_allocation_map)
+
+#define mm_set_pkey_allocated(mm, pkey) {	\
+	mm_pkey_allocation_map(mm) |= pkeybit_mask(pkey); \
+}
+
+#define mm_set_pkey_free(mm, pkey) {	\
+	mm_pkey_allocation_map(mm) &= ~pkeybit_mask(pkey);	\
+}
+
+#define mm_set_pkey_is_allocated(mm, pkey)	\
+	(mm_pkey_allocation_map(mm) & pkeybit_mask(pkey))
+
+#define mm_set_pkey_is_reserved(mm, pkey) (PKEY_INITIAL_ALLOCAION & \
+					pkeybit_mask(pkey))
+
+static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
+{
+	/* a reserved key is never considered as 'explicitly allocated' */
+	return (!mm_set_pkey_is_reserved(mm, pkey) &&
+		mm_set_pkey_is_allocated(mm, pkey));
+}
+
+/*
+ * Returns a positive, 5-bit key on success, or -1 on failure.
+ */
+static inline int mm_pkey_alloc(struct mm_struct *mm)
+{
+	/*
+	 * Note: this is the one and only place we make sure
+	 * that the pkey is valid as far as the hardware is
+	 * concerned.  The rest of the kernel trusts that
+	 * only good, valid pkeys come out of here.
+	 */
+	u32 all_pkeys_mask = (u32)(~(0x0));
+	int ret;
+
+	/*
+	 * Are we out of pkeys?  We must handle this specially
+	 * because ffz() behavior is undefined if there are no
+	 * zeros.
+	 */
+	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
+		return -1;
+
+	ret = arch_max_pkey() -
+		ffz((u32)mm_pkey_allocation_map(mm))
+		- 1;
+	mm_set_pkey_allocated(mm, ret);
+	return ret;
+}
+
+static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
+{
+	if (!mm_pkey_is_allocated(mm, pkey))
+		return -EINVAL;
+
+	mm_set_pkey_free(mm, pkey);
+
+	return 0;
+}
+
+/*
+ * Try to dedicate one of the protection keys to be used as an
+ * execute-only protection key.
+ */
+static inline int execute_only_pkey(struct mm_struct *mm)
+{
+	return 0;
+}
+
+static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
+		int prot, int pkey)
+{
+	return 0;
+}
+
+static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
+		unsigned long init_val)
+{
+	return 0;
+}
+
+static inline void pkey_mm_init(struct mm_struct *mm)
+{
+	mm_pkey_allocation_map(mm) = PKEY_INITIAL_ALLOCAION;
+}
+#endif /*_ASM_PPC64_PKEYS_H */
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index c6dca2a..2da9931 100644
--- a/arch/powerpc/mm/mmu_context_book3s64.c
+++ b/arch/powerpc/mm/mmu_context_book3s64.c
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/pkeys.h>
 #include <linux/spinlock.h>
 #include <linux/idr.h>
 #include <linux/export.h>
@@ -120,6 +121,10 @@ static int hash__init_new_context(struct mm_struct *mm)
 
 	subpage_prot_init_new_context(mm);
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	pkey_mm_init(mm);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	return index;
 }
 
-- 
1.7.1
