Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpsrR63G1zDrd1
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:46:47 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id c69so2309113qke.5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:46:47 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 03/25] powerpc: track allocation status of all pkeys
Date: Fri,  8 Sep 2017 15:44:51 -0700
Message-Id: <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Total 32 keys are available on power7 and above. However
pkey 0,1 are reserved. So effectively we  have  30 pkeys.

On 4K kernels, we do not  have  5  bits  in  the  PTE to
represent  all the keys; we only have 3bits.Two of those
keys are reserved; pkey 0 and pkey 1. So effectively  we
have 6 pkeys.

This patch keeps track of reserved keys, allocated  keys
and keys that are currently free.

Also it  adds  skeletal  functions  and macros, that the
architecture-independent code expects to be available.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |    9 ++++
 arch/powerpc/include/asm/mmu_context.h   |    1 +
 arch/powerpc/include/asm/pkeys.h         |   72 ++++++++++++++++++++++++++++--
 arch/powerpc/mm/mmu_context_book3s64.c   |    2 +
 arch/powerpc/mm/pkeys.c                  |   28 ++++++++++++
 5 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index c3b00e8..55950f4 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -107,6 +107,15 @@ struct patb_entry {
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
diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index 7badf29..c705a5d 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -144,6 +144,7 @@ static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 
 #ifndef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
 #define pkey_initialize()
+#define pkey_mm_init(mm)
 #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 44e01a2..133f8c4 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -3,6 +3,8 @@
 
 extern bool pkey_inited;
 extern bool pkey_execute_disable_support;
+extern int pkeys_total; /* total pkeys as per device tree */
+extern u32 initial_allocation_mask;/* bits set for reserved keys */
 
 /*
  * powerpc needs an additional vma bit to support 32 keys.
@@ -21,21 +23,76 @@
 #define VM_PKEY_BIT4	VM_HIGH_ARCH_4
 #endif
 
-#define ARCH_VM_PKEY_FLAGS 0
+#define arch_max_pkey()  pkeys_total
+#define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
+				VM_PKEY_BIT3 | VM_PKEY_BIT4)
+
+#define pkey_alloc_mask(pkey) (0x1 << pkey)
+
+#define mm_pkey_allocation_map(mm)	(mm->context.pkey_allocation_map)
+
+#define mm_set_pkey_allocated(mm, pkey) {	\
+	mm_pkey_allocation_map(mm) |= pkey_alloc_mask(pkey); \
+}
+
+#define mm_set_pkey_free(mm, pkey) {	\
+	mm_pkey_allocation_map(mm) &= ~pkey_alloc_mask(pkey);	\
+}
+
+#define mm_set_pkey_is_allocated(mm, pkey)	\
+	(mm_pkey_allocation_map(mm) & pkey_alloc_mask(pkey))
+
+#define mm_set_pkey_is_reserved(mm, pkey) (initial_allocation_mask & \
+					pkey_alloc_mask(pkey))
 
 static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 {
-	return (pkey == 0);
+	/* a reserved key is never considered as 'explicitly allocated' */
+	return ((pkey < arch_max_pkey()) &&
+		!mm_set_pkey_is_reserved(mm, pkey) &&
+		mm_set_pkey_is_allocated(mm, pkey));
 }
 
+/*
+ * Returns a positive, 5-bit key on success, or -1 on failure.
+ */
 static inline int mm_pkey_alloc(struct mm_struct *mm)
 {
-	return -1;
+	/*
+	 * Note: this is the one and only place we make sure
+	 * that the pkey is valid as far as the hardware is
+	 * concerned.  The rest of the kernel trusts that
+	 * only good, valid pkeys come out of here.
+	 */
+	u32 all_pkeys_mask = (u32)(~(0x0));
+	int ret;
+
+	if (!pkey_inited)
+		return -1;
+	/*
+	 * Are we out of pkeys?  We must handle this specially
+	 * because ffz() behavior is undefined if there are no
+	 * zeros.
+	 */
+	if (mm_pkey_allocation_map(mm) == all_pkeys_mask)
+		return -1;
+
+	ret = ffz((u32)mm_pkey_allocation_map(mm));
+	mm_set_pkey_allocated(mm, ret);
+	return ret;
 }
 
 static inline int mm_pkey_free(struct mm_struct *mm, int pkey)
 {
-	return -EINVAL;
+	if (!pkey_inited)
+		return -1;
+
+	if (!mm_pkey_is_allocated(mm, pkey))
+		return -EINVAL;
+
+	mm_set_pkey_free(mm, pkey);
+
+	return 0;
 }
 
 /*
@@ -59,5 +116,12 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	return 0;
 }
 
+static inline void pkey_mm_init(struct mm_struct *mm)
+{
+	if (!pkey_inited)
+		return;
+	mm_pkey_allocation_map(mm) = initial_allocation_mask;
+}
+
 extern void pkey_initialize(void);
 #endif /*_ASM_PPC64_PKEYS_H */
diff --git a/arch/powerpc/mm/mmu_context_book3s64.c b/arch/powerpc/mm/mmu_context_book3s64.c
index 05e1538..5df223a 100644
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
@@ -118,6 +119,7 @@ static int hash__init_new_context(struct mm_struct *mm)
 
 	subpage_prot_init_new_context(mm);
 
+	pkey_mm_init(mm);
 	return index;
 }
 
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 418a05b..ebc9e84 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -16,9 +16,13 @@
 
 bool pkey_inited;
 bool pkey_execute_disable_support;
+int  pkeys_total;		/* total pkeys as per device tree */
+u32  initial_allocation_mask;	/* bits set for reserved keys */
 
 void __init pkey_initialize(void)
 {
+	int os_reserved, i;
+
 	/* disable the pkey system till everything
 	 * is in place. A patch further down the
 	 * line will enable it.
@@ -30,4 +34,28 @@ void __init pkey_initialize(void)
 	 * A patch further down will enable it.
 	 */
 	pkey_execute_disable_support = false;
+
+	/* Lets assume 32 keys */
+	pkeys_total = 32;
+
+#ifdef CONFIG_PPC_4K_PAGES
+	/*
+	 * the OS can manage only 8 pkeys
+	 * due to its inability to represent
+	 * them in the linux 4K-PTE.
+	 */
+	os_reserved = pkeys_total-8;
+#else
+	os_reserved = 0;
+#endif
+	/*
+	 * Bits are in LE format.
+	 * NOTE: 1, 0 are reserved.
+	 * key 0 is the default key, which allows read/write/execute.
+	 * key 1 is recommended not to be used.
+	 * PowerISA(3.0) page 1015, programming note.
+	 */
+	initial_allocation_mask = ~0x0;
+	for (i = 2; i < (pkeys_total - os_reserved); i++)
+		initial_allocation_mask &= ~(0x1<<i);
 }
-- 
1.7.1
