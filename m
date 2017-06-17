Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wqNcm1CHhzDqP2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Jun 2017 13:53:12 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id u8so899671qka.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 20:53:12 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com
Subject: [RFC v2 05/12] powerpc: Implementation for sys_mprotect_pkey() system
 call.
Date: Fri, 16 Jun 2017 20:52:37 -0700
Message-Id: <1497671564-20030-6-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This system call, associates the pkey with PTE of all
pages corresponding to the given address range.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h | 22 ++++++-
 arch/powerpc/include/asm/mman.h              | 29 +++++----
 arch/powerpc/include/asm/pkeys.h             | 21 ++++++-
 arch/powerpc/include/asm/systbl.h            |  1 +
 arch/powerpc/include/asm/unistd.h            |  4 +-
 arch/powerpc/include/uapi/asm/unistd.h       |  1 +
 arch/powerpc/mm/pkeys.c                      | 93 +++++++++++++++++++++++++++-
 include/linux/mm.h                           |  1 +
 8 files changed, 154 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 87e9a89..bc845cd 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -37,6 +37,7 @@
 #define _RPAGE_RSV2		0x0800000000000000UL
 #define _RPAGE_RSV3		0x0400000000000000UL
 #define _RPAGE_RSV4		0x0200000000000000UL
+#define _RPAGE_RSV5		0x00040UL
 
 #define _PAGE_PTE		0x4000000000000000UL	/* distinguishes PTEs from pointers */
 #define _PAGE_PRESENT		0x8000000000000000UL	/* pte contains a translation */
@@ -56,6 +57,20 @@
 /* Max physical address bit as per radix table */
 #define _RPAGE_PA_MAX		57
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+#define H_PAGE_PKEY_BIT0	_RPAGE_RSV1
+#define H_PAGE_PKEY_BIT1	_RPAGE_RSV2
+#define H_PAGE_PKEY_BIT2	_RPAGE_RSV3
+#define H_PAGE_PKEY_BIT3	_RPAGE_RSV4
+#define H_PAGE_PKEY_BIT4	_RPAGE_RSV5
+#else /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+#define H_PAGE_PKEY_BIT0	0
+#define H_PAGE_PKEY_BIT1	0
+#define H_PAGE_PKEY_BIT2	0
+#define H_PAGE_PKEY_BIT3	0
+#define H_PAGE_PKEY_BIT4	0
+#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 /*
  * Max physical address bit we will use for now.
  *
@@ -122,7 +137,12 @@
 #define PAGE_PROT_BITS  (_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT | \
 			 H_PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
 			 _PAGE_READ | _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
-			 _PAGE_SOFT_DIRTY)
+			 _PAGE_SOFT_DIRTY | \
+			 H_PAGE_PKEY_BIT0 | \
+			 H_PAGE_PKEY_BIT1 | \
+			 H_PAGE_PKEY_BIT2 | \
+			 H_PAGE_PKEY_BIT3 | \
+			 H_PAGE_PKEY_BIT4)
 /*
  * We define 2 sets of base prot bits, one for basic pages (ie,
  * cacheable kernel and user pages) and one for non cacheable
diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 30922f6..14cc1aa 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -13,24 +13,31 @@
 
 #include <asm/cputable.h>
 #include <linux/mm.h>
+#include <linux/pkeys.h>
 #include <asm/cpu_has_feature.h>
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+
 /*
  * This file is included by linux/mman.h, so we can't use cacl_vm_prot_bits()
  * here.  How important is the optimization?
  */
-static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
-		unsigned long pkey)
-{
-	return (prot & PROT_SAO) ? VM_SAO : 0;
-}
-#define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
+#define arch_calc_vm_prot_bits(prot, key) (             \
+		((prot) & PROT_SAO ? VM_SAO : 0) |	\
+			pkey_to_vmflag_bits(key))
+#define arch_vm_get_page_prot(vm_flags) __pgprot(       \
+		((vm_flags) & VM_SAO ? _PAGE_SAO : 0) |	\
+		vmflag_to_page_pkey_bits(vm_flags))
+
+#else /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
+#define arch_calc_vm_prot_bits(prot, key) (	\
+		((prot) & PROT_SAO ? VM_SAO : 0))
+#define arch_vm_get_page_prot(vm_flags) __pgprot(	\
+		((vm_flags) & VM_SAO ? _PAGE_SAO : 0))
+
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 
-static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
-{
-	return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : __pgprot(0);
-}
-#define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
 
 static inline bool arch_validate_prot(unsigned long prot)
 {
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 7bc8746..0f3dca8 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -14,6 +14,19 @@
 			VM_PKEY_BIT3 | \
 			VM_PKEY_BIT4)
 
+#define pkey_to_vmflag_bits(key) (((key & 0x1UL) ? VM_PKEY_BIT0 : 0x0UL) | \
+			((key & 0x2UL) ? VM_PKEY_BIT1 : 0x0UL) |	\
+			((key & 0x4UL) ? VM_PKEY_BIT2 : 0x0UL) |	\
+			((key & 0x8UL) ? VM_PKEY_BIT3 : 0x0UL) |	\
+			((key & 0x10UL) ? VM_PKEY_BIT4 : 0x0UL))
+
+#define vmflag_to_page_pkey_bits(vm_flags)  \
+		(((vm_flags & VM_PKEY_BIT0) ? H_PAGE_PKEY_BIT4 : 0x0UL)|     \
+		((vm_flags & VM_PKEY_BIT1) ? H_PAGE_PKEY_BIT3 : 0x0UL) |     \
+		((vm_flags & VM_PKEY_BIT2) ? H_PAGE_PKEY_BIT2 : 0x0UL) |     \
+		((vm_flags & VM_PKEY_BIT3) ? H_PAGE_PKEY_BIT1 : 0x0UL) |     \
+		((vm_flags & VM_PKEY_BIT4) ? H_PAGE_PKEY_BIT0 : 0x0UL))
+
 /*
  * Bits are in BE format.
  * NOTE: key 31, 1, 0 are not used.
@@ -42,6 +55,12 @@
 #define mm_set_pkey_is_reserved(mm, pkey) (PKEY_INITIAL_ALLOCAION & \
 					pkeybit_mask(pkey))
 
+
+static inline int vma_pkey(struct vm_area_struct *vma)
+{
+	return (vma->vm_flags & ARCH_VM_PKEY_FLAGS) >> VM_PKEY_SHIFT;
+}
+
 static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 {
 	/* a reserved key is never considered as 'explicitly allocated' */
@@ -114,7 +133,7 @@ static inline int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	return __arch_set_user_pkey_access(tsk, pkey, init_val);
 }
 
-static inline pkey_mm_init(struct mm_struct *mm)
+static inline void pkey_mm_init(struct mm_struct *mm)
 {
 	mm_pkey_allocation_map(mm) = PKEY_INITIAL_ALLOCAION;
 	/* -1 means unallocated or invalid */
diff --git a/arch/powerpc/include/asm/systbl.h b/arch/powerpc/include/asm/systbl.h
index 22dd776..b33b551 100644
--- a/arch/powerpc/include/asm/systbl.h
+++ b/arch/powerpc/include/asm/systbl.h
@@ -390,3 +390,4 @@
 SYSCALL(statx)
 SYSCALL(pkey_alloc)
 SYSCALL(pkey_free)
+SYSCALL(pkey_mprotect)
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index e0273bc..daf1ba9 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -12,12 +12,10 @@
 #include <uapi/asm/unistd.h>
 
 
-#define NR_syscalls		386
+#define NR_syscalls		387
 
 #define __NR__exit __NR_exit
 
-#define __IGNORE_pkey_mprotect
-
 #ifndef __ASSEMBLY__
 
 #include <linux/types.h>
diff --git a/arch/powerpc/include/uapi/asm/unistd.h b/arch/powerpc/include/uapi/asm/unistd.h
index 7993a07..71ae45e 100644
--- a/arch/powerpc/include/uapi/asm/unistd.h
+++ b/arch/powerpc/include/uapi/asm/unistd.h
@@ -396,5 +396,6 @@
 #define __NR_statx		383
 #define __NR_pkey_alloc		384
 #define __NR_pkey_free		385
+#define __NR_pkey_mprotect	386
 
 #endif /* _UAPI_ASM_POWERPC_UNISTD_H_ */
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index b97366e..11a32b3 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -15,6 +15,17 @@
 #include <linux/pkeys.h>                /* PKEY_*                       */
 #include <uapi/asm-generic/mman-common.h>
 
+#define pkeyshift(pkey) ((arch_max_pkey()-pkey-1) * AMR_BITS_PER_PKEY)
+
+static inline bool pkey_allows_readwrite(int pkey)
+{
+	int pkey_shift = pkeyshift(pkey);
+
+	if (!(read_uamor() & (0x3UL << pkey_shift)))
+		return true;
+
+	return !(read_amr() & ((AMR_AD_BIT|AMR_WD_BIT) << pkey_shift));
+}
 
 /*
  * set the access right in AMR IAMR and UAMOR register
@@ -68,7 +79,60 @@ int __arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
-	return -1;
+	bool need_to_set_mm_pkey = false;
+	int execute_only_pkey = mm->context.execute_only_pkey;
+	int ret;
+
+	/* Do we need to assign a pkey for mm's execute-only maps? */
+	if (execute_only_pkey == -1) {
+		/* Go allocate one to use, which might fail */
+		execute_only_pkey = mm_pkey_alloc(mm);
+		if (execute_only_pkey < 0)
+			return -1;
+		need_to_set_mm_pkey = true;
+	}
+
+	/*
+	 * We do not want to go through the relatively costly
+	 * dance to set AMR if we do not need to.  Check it
+	 * first and assume that if the execute-only pkey is
+	 * readwrite-disabled than we do not have to set it
+	 * ourselves.
+	 */
+	if (!need_to_set_mm_pkey &&
+	    !pkey_allows_readwrite(execute_only_pkey))
+		return execute_only_pkey;
+
+	/*
+	 * Set up AMR so that it denies access for everything
+	 * other than execution.
+	 */
+	ret = __arch_set_user_pkey_access(current, execute_only_pkey,
+			(PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE));
+	/*
+	 * If the AMR-set operation failed somehow, just return
+	 * 0 and effectively disable execute-only support.
+	 */
+	if (ret) {
+		mm_set_pkey_free(mm, execute_only_pkey);
+		return -1;
+	}
+
+	/* We got one, store it and use it from here on out */
+	if (need_to_set_mm_pkey)
+		mm->context.execute_only_pkey = execute_only_pkey;
+	return execute_only_pkey;
+}
+
+static inline bool vma_is_pkey_exec_only(struct vm_area_struct *vma)
+{
+	/* Do this check first since the vm_flags should be hot */
+	if ((vma->vm_flags & (VM_READ | VM_WRITE | VM_EXEC)) != VM_EXEC)
+		return false;
+	if (vma_pkey(vma) != vma->vm_mm->context.execute_only_pkey)
+		return false;
+
+	return true;
 }
 
 /*
@@ -84,5 +148,30 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
 	if (pkey != -1)
 		return pkey;
 
-	return 0;
+	/*
+	 * Look for a protection-key-drive execute-only mapping
+	 * which is now being given permissions that are not
+	 * execute-only.  Move it back to the default pkey.
+	 */
+	if (vma_is_pkey_exec_only(vma) &&
+	    (prot & (PROT_READ|PROT_WRITE))) {
+		return 0;
+	}
+	/*
+	 * The mapping is execute-only.  Go try to get the
+	 * execute-only protection key.  If we fail to do that,
+	 * fall through as if we do not have execute-only
+	 * support.
+	 */
+	if (prot == PROT_EXEC) {
+		pkey = execute_only_pkey(vma->vm_mm);
+		if (pkey > 0)
+			return pkey;
+	}
+	/*
+	 * This is a vanilla, non-pkey mprotect (or we failed to
+	 * setup execute-only), inherit the pkey from the VMA we
+	 * are working on.
+	 */
+	return vma_pkey(vma);
 }
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 34ddac7..5399031 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -227,6 +227,7 @@ extern int overcommit_kbytes_handler(struct ctl_table *, int, void __user *,
 #define VM_PKEY_BIT3	VM_HIGH_ARCH_3
 #endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
 #elif defined(CONFIG_PPC)
+#define VM_PKEY_SHIFT	VM_HIGH_ARCH_BIT_0
 #define VM_PKEY_BIT0	VM_HIGH_ARCH_0	/* A protection key is a 5-bit value */
 #define VM_PKEY_BIT1	VM_HIGH_ARCH_1
 #define VM_PKEY_BIT2	VM_HIGH_ARCH_2
-- 
1.8.3.1
