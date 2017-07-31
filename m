Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x242.google.com (mail-qt0-x242.google.com
 [IPv6:2607:f8b0:400d:c0d::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKfR0tV2zDr5s
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:13:03 +1000 (AEST)
Received: by mail-qt0-x242.google.com with SMTP id c15so11605082qta.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:13:03 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [RFC v7 13/25] powerpc: map vma key-protection bits to pte key bits.
Date: Sun, 30 Jul 2017 17:12:14 -0700
Message-Id: <1501459946-11619-14-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
References: <1501459946-11619-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

map  the  key  protection  bits of the vma to the pkey bits in
the PTE.

The Pte  bits used  for pkey  are  3,4,5,6  and 57. The  first
four bits are the same four bits that were freed up  initially
in this patch series. remember? :-) Without those four bits
this patch would'nt be possible.

BUT, On 4k kernel, bit 3, and 4 could not be freed up. remember?
Hence we have to be satisfied with 5,6 and 7.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |   25 ++++++++++++++++++++++++-
 arch/powerpc/include/asm/mman.h              |    8 ++++++++
 arch/powerpc/include/asm/pkeys.h             |   12 ++++++++++++
 3 files changed, 44 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index d4da0e9..060a1b2 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -37,6 +37,7 @@
 #define _RPAGE_RSV2		0x0800000000000000UL
 #define _RPAGE_RSV3		0x0400000000000000UL
 #define _RPAGE_RSV4		0x0200000000000000UL
+#define _RPAGE_RSV5		0x00040UL
 
 #define _PAGE_PTE		0x4000000000000000UL	/* distinguishes PTEs from pointers */
 #define _PAGE_PRESENT		0x8000000000000000UL	/* pte contains a translation */
@@ -56,6 +57,25 @@
 /* Max physical address bit as per radix table */
 #define _RPAGE_PA_MAX		57
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+#ifdef CONFIG_PPC_64K_PAGES
+#define H_PAGE_PKEY_BIT0	_RPAGE_RSV1
+#define H_PAGE_PKEY_BIT1	_RPAGE_RSV2
+#else /* CONFIG_PPC_64K_PAGES */
+#define H_PAGE_PKEY_BIT0	0 /* _RPAGE_RSV1 is not available */
+#define H_PAGE_PKEY_BIT1	0 /* _RPAGE_RSV2 is not available */
+#endif /* CONFIG_PPC_64K_PAGES */
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
@@ -116,13 +136,16 @@
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
 			 _PAGE_ACCESSED | _PAGE_SPECIAL | _PAGE_PTE |	\
 			 _PAGE_SOFT_DIRTY)
+
+#define H_PAGE_PKEY  (H_PAGE_PKEY_BIT0 | H_PAGE_PKEY_BIT1 | H_PAGE_PKEY_BIT2 | \
+			H_PAGE_PKEY_BIT3 | H_PAGE_PKEY_BIT4)
 /*
  * Mask of bits returned by pte_pgprot()
  */
 #define PAGE_PROT_BITS  (_PAGE_SAO | _PAGE_NON_IDEMPOTENT | _PAGE_TOLERANT | \
 			 H_PAGE_4K_PFN | _PAGE_PRIVILEGED | _PAGE_ACCESSED | \
 			 _PAGE_READ | _PAGE_WRITE |  _PAGE_DIRTY | _PAGE_EXEC | \
-			 _PAGE_SOFT_DIRTY)
+			 _PAGE_SOFT_DIRTY | H_PAGE_PKEY)
 /*
  * We define 2 sets of base prot bits, one for basic pages (ie,
  * cacheable kernel and user pages) and one for non cacheable
diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 067eec2..3f7220f 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -32,12 +32,20 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
+
 static inline pgprot_t arch_vm_get_page_prot(unsigned long vm_flags)
 {
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	return (vm_flags & VM_SAO) ?
+		__pgprot(_PAGE_SAO | vmflag_to_page_pkey_bits(vm_flags)) :
+		__pgprot(0 | vmflag_to_page_pkey_bits(vm_flags));
+#else
 	return (vm_flags & VM_SAO) ? __pgprot(_PAGE_SAO) : __pgprot(0);
+#endif
 }
 #define arch_vm_get_page_prot(vm_flags) arch_vm_get_page_prot(vm_flags)
 
+
 static inline bool arch_validate_prot(unsigned long prot)
 {
 	if (prot & ~(PROT_READ | PROT_WRITE | PROT_EXEC | PROT_SEM | PROT_SAO))
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 03f7ea2..1ded6df 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -46,6 +46,18 @@ static inline u64 pkey_to_vmflag_bits(u16 pkey)
 		((pkey & 0x10UL) ? VM_PKEY_BIT4 : 0x0UL));
 }
 
+static inline u64 vmflag_to_page_pkey_bits(u64 vm_flags)
+{
+	if (!pkey_inited)
+		return 0x0UL;
+
+	return (((vm_flags & VM_PKEY_BIT0) ? H_PAGE_PKEY_BIT4 : 0x0UL) |
+		((vm_flags & VM_PKEY_BIT1) ? H_PAGE_PKEY_BIT3 : 0x0UL) |
+		((vm_flags & VM_PKEY_BIT2) ? H_PAGE_PKEY_BIT2 : 0x0UL) |
+		((vm_flags & VM_PKEY_BIT3) ? H_PAGE_PKEY_BIT1 : 0x0UL) |
+		((vm_flags & VM_PKEY_BIT4) ? H_PAGE_PKEY_BIT0 : 0x0UL));
+}
+
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
 				VM_PKEY_BIT3 | VM_PKEY_BIT4)
 
-- 
1.7.1
