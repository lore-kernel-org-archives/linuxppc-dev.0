Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whYQr4r7HzDqLb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 11:05:56 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id s33so12920352qtg.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jun 2017 18:05:56 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, dave.hansen@intel.com, hbabu@us.ibm.com,
 linuxram@us.ibm.com
Subject: [RFC PATCH 6/7 v1]powerpc: Handle exceptions caused by violation of
 key protection.
Date: Mon,  5 Jun 2017 18:05:08 -0700
Message-Id: <1496711109-4968-7-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
References: <1496711109-4968-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Handle Data and Instruction exceptions caused by memory
protection-key.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/mmu_context.h | 12 +++++
 arch/powerpc/include/asm/pkeys.h       |  9 ++++
 arch/powerpc/include/asm/reg.h         | 10 +++-
 arch/powerpc/kernel/exceptions-64s.S   |  2 +-
 arch/powerpc/mm/fault.c                | 21 +++++++-
 arch/powerpc/mm/pkeys.c                | 90 ++++++++++++++++++++++++++++++++++
 6 files changed, 140 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu_context.h b/arch/powerpc/include/asm/mmu_context.h
index da7e943..71fffe0 100644
--- a/arch/powerpc/include/asm/mmu_context.h
+++ b/arch/powerpc/include/asm/mmu_context.h
@@ -175,11 +175,23 @@ static inline void arch_bprm_mm_init(struct mm_struct *mm,
 {
 }
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+bool arch_pte_access_permitted(pte_t pte, bool write);
+bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool execute, bool foreign);
+#else /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+static inline bool arch_pte_access_permitted(pte_t pte, bool write)
+{
+	/* by default, allow everything */
+	return true;
+}
 static inline bool arch_vma_access_permitted(struct vm_area_struct *vma,
 		bool write, bool execute, bool foreign)
 {
 	/* by default, allow everything */
 	return true;
 }
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 #endif /* __KERNEL__ */
 #endif /* __ASM_POWERPC_MMU_CONTEXT_H */
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 9b6820d..405e7db 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -14,6 +14,15 @@
 			VM_PKEY_BIT3 | \
 			VM_PKEY_BIT4)
 
+static inline u16 pte_flags_to_pkey(unsigned long pte_flags)
+{
+	return ((pte_flags & H_PAGE_PKEY_BIT4) ? 0x1 : 0x0) |
+		((pte_flags & H_PAGE_PKEY_BIT3) ? 0x2 : 0x0) |
+		((pte_flags & H_PAGE_PKEY_BIT2) ? 0x4 : 0x0) |
+		((pte_flags & H_PAGE_PKEY_BIT1) ? 0x8 : 0x0) |
+		((pte_flags & H_PAGE_PKEY_BIT0) ? 0x10 : 0x0);
+}
+
 #define pkey_to_vmflag_bits(key) (((key & 0x1UL) ? VM_PKEY_BIT0 : 0x0UL) | \
 			((key & 0x2UL) ? VM_PKEY_BIT1 : 0x0UL) |	\
 			((key & 0x4UL) ? VM_PKEY_BIT2 : 0x0UL) |	\
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7e50e47..c1ec880 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -272,16 +272,24 @@
 #define SPRN_DAR	0x013	/* Data Address Register */
 #define SPRN_DBCR	0x136	/* e300 Data Breakpoint Control Reg */
 #define SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
+#define   DSISR_BIT32		0x80000000	/* not defined */
 #define   DSISR_NOHPTE		0x40000000	/* no translation found */
+#define   DSISR_PAGEATTR_CONFLT	0x20000000	/* page attribute conflict */
+#define   DSISR_BIT35		0x10000000	/* not defined */
 #define   DSISR_PROTFAULT	0x08000000	/* protection fault */
 #define   DSISR_BADACCESS	0x04000000	/* bad access to CI or G */
 #define   DSISR_ISSTORE		0x02000000	/* access was a store */
 #define   DSISR_DABRMATCH	0x00400000	/* hit data breakpoint */
-#define   DSISR_NOSEGMENT	0x00200000	/* SLB miss */
 #define   DSISR_KEYFAULT	0x00200000	/* Key fault */
+#define   DSISR_BIT43		0x00100000	/* Not defined */
 #define   DSISR_UNSUPP_MMU	0x00080000	/* Unsupported MMU config */
 #define   DSISR_SET_RC		0x00040000	/* Failed setting of R/C bits */
 #define   DSISR_PGDIRFAULT      0x00020000      /* Fault on page directory */
+#define   DSISR_PAGE_FAULT_MASK (DSISR_BIT32 |	\
+				DSISR_PAGEATTR_CONFLT |	\
+				DSISR_BADACCESS |	\
+				DSISR_KEYFAULT |	\
+				DSISR_BIT43)
 #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
 #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
 #define SPRN_CIR	0x11B	/* Chip Information Register (hyper, R/0) */
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ae418b8..5226a9d 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1411,7 +1411,7 @@ USE_TEXT_SECTION()
 	.balign	IFETCH_ALIGN_BYTES
 do_hash_page:
 #ifdef CONFIG_PPC_STD_MMU_64
-	andis.	r0,r4,0xa410		/* weird error? */
+	andis.	r0,r4,DSISR_PAGE_FAULT_MASK@h	/* weird error? */
 	bne-	handle_page_fault	/* if not, try to insert a HPTE */
 	andis.  r0,r4,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index 3a7d580..c31624f 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -216,9 +216,10 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	 * bits we are interested in.  But there are some bits which
 	 * indicate errors in DSISR but can validly be set in SRR1.
 	 */
-	if (trap == 0x400)
+	if (trap == 0x400) {
 		error_code &= 0x48200000;
-	else
+		flags |= FAULT_FLAG_INSTRUCTION;
+	} else
 		is_write = error_code & DSISR_ISSTORE;
 #else
 	is_write = error_code & ESR_DST;
@@ -261,6 +262,13 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 	}
 #endif
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (error_code & DSISR_KEYFAULT) {
+		code = SEGV_PKUERR;
+		goto bad_area_nosemaphore;
+	}
+#endif /*  CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
 		local_irq_enable();
@@ -441,6 +449,15 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
 		WARN_ON_ONCE(error_code & DSISR_PROTFAULT);
 #endif /* CONFIG_PPC_STD_MMU */
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
+					flags & FAULT_FLAG_INSTRUCTION,
+					0)) {
+		code = SEGV_PKUERR;
+		goto bad_area;
+	}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	/*
 	 * If for any reason at all we couldn't handle the fault,
 	 * make sure we exit gracefully rather than endlessly redo
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index 11a32b3..a9545f1 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -27,6 +27,37 @@ static inline bool pkey_allows_readwrite(int pkey)
 	return !(read_amr() & ((AMR_AD_BIT|AMR_WD_BIT) << pkey_shift));
 }
 
+static inline bool pkey_allows_read(int pkey)
+{
+	int pkey_shift = (arch_max_pkey()-pkey-1) * AMR_BITS_PER_PKEY;
+
+	if (!(read_uamor() & (0x3ul << pkey_shift)))
+		return true;
+
+	return !(read_amr() & (AMR_AD_BIT << pkey_shift));
+}
+
+static inline bool pkey_allows_write(int pkey)
+{
+	int pkey_shift = (arch_max_pkey()-pkey-1) * AMR_BITS_PER_PKEY;
+
+	if (!(read_uamor() & (0x3ul << pkey_shift)))
+		return true;
+
+	return !(read_amr() & (AMR_WD_BIT << pkey_shift));
+}
+
+static inline bool pkey_allows_execute(int pkey)
+{
+	int pkey_shift = (arch_max_pkey()-pkey-1) * AMR_BITS_PER_PKEY;
+
+	if (!(read_uamor() & (0x3ul << pkey_shift)))
+		return true;
+
+	return !(read_iamr() & (IAMR_EX_BIT << pkey_shift));
+}
+
+
 /*
  * set the access right in AMR IAMR and UAMOR register
  * for @pkey to that specified in @init_val.
@@ -175,3 +206,62 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
 	 */
 	return vma_pkey(vma);
 }
+
+bool arch_pte_access_permitted(pte_t pte, bool write)
+{
+	int pkey = pte_flags_to_pkey(pte_val(pte));
+
+	if (!pkey_allows_read(pkey))
+		return false;
+	if (write && !pkey_allows_write(pkey))
+		return false;
+	return true;
+}
+
+/*
+ * We only want to enforce protection keys on the current process
+ * because we effectively have no access to PKRU for other
+ * processes or any way to tell *which * PKRU in a threaded
+ * process we could use.
+ *
+ * So do not enforce things if the VMA is not from the current
+ * mm, or if we are in a kernel thread.
+ */
+static inline bool vma_is_foreign(struct vm_area_struct *vma)
+{
+	if (!current->mm)
+		return true;
+	/*
+	 * if the VMA is from another process, then PKRU has no
+	 * relevance and should not be enforced.
+	 */
+	if (current->mm != vma->vm_mm)
+		return true;
+
+	return false;
+}
+
+bool arch_vma_access_permitted(struct vm_area_struct *vma,
+		bool write, bool execute, bool foreign)
+{
+	int pkey;
+	/* allow access if the VMA is not one from this process */
+	if (foreign || vma_is_foreign(vma))
+		return true;
+
+	pkey = vma_pkey(vma);
+
+	if (!pkey)
+		return true;
+
+	if (execute)
+		return pkey_allows_execute(pkey);
+
+	if (!pkey_allows_read(pkey))
+		return false;
+
+	if (write)
+		return pkey_allows_write(pkey);
+
+	return true;
+}
-- 
1.8.3.1
