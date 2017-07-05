Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2v4K00y7zDr2t
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 07:23:28 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id c20so201507qte.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 14:23:28 -0700 (PDT)
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
Subject: [RFC v5 24/38] powerpc: Program HPTE key protection bits
Date: Wed,  5 Jul 2017 14:22:01 -0700
Message-Id: <1499289735-14220-25-git-send-email-linuxram@us.ibm.com>
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

Map the PTE protection key bits to the HPTE key protection bits,
while creating HPTE  entries.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    5 +++++
 arch/powerpc/include/asm/pkeys.h              |    9 +++++++++
 arch/powerpc/mm/hash_utils_64.c               |    5 +++++
 3 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 6981a52..f7a6ed3 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -90,6 +90,8 @@
 #define HPTE_R_PP0		ASM_CONST(0x8000000000000000)
 #define HPTE_R_TS		ASM_CONST(0x4000000000000000)
 #define HPTE_R_KEY_HI		ASM_CONST(0x3000000000000000)
+#define HPTE_R_KEY_BIT0		ASM_CONST(0x2000000000000000)
+#define HPTE_R_KEY_BIT1		ASM_CONST(0x1000000000000000)
 #define HPTE_R_RPN_SHIFT	12
 #define HPTE_R_RPN		ASM_CONST(0x0ffffffffffff000)
 #define HPTE_R_RPN_3_0		ASM_CONST(0x01fffffffffff000)
@@ -104,6 +106,9 @@
 #define HPTE_R_C		ASM_CONST(0x0000000000000080)
 #define HPTE_R_R		ASM_CONST(0x0000000000000100)
 #define HPTE_R_KEY_LO		ASM_CONST(0x0000000000000e00)
+#define HPTE_R_KEY_BIT2		ASM_CONST(0x0000000000000800)
+#define HPTE_R_KEY_BIT3		ASM_CONST(0x0000000000000400)
+#define HPTE_R_KEY_BIT4		ASM_CONST(0x0000000000000200)
 
 #define HPTE_V_1TB_SEG		ASM_CONST(0x4000000000000000)
 #define HPTE_V_VRMA_MASK	ASM_CONST(0x4001ffffff000000)
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index c681de9..6477b87 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -22,6 +22,15 @@ static inline u64 vmflag_to_page_pkey_bits(u64 vm_flags)
 		((vm_flags & VM_PKEY_BIT4) ? H_PAGE_PKEY_BIT0 : 0x0UL));
 }
 
+static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
+{
+	return (((pteflags & H_PAGE_PKEY_BIT0) ? HPTE_R_KEY_BIT0 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT1) ? HPTE_R_KEY_BIT1 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT2) ? HPTE_R_KEY_BIT2 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT3) ? HPTE_R_KEY_BIT3 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
+}
+
 static inline int vma_pkey(struct vm_area_struct *vma)
 {
 	return (vma->vm_flags & ARCH_VM_PKEY_FLAGS) >> VM_PKEY_SHIFT;
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index d863696..1e74529 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -35,6 +35,7 @@
 #include <linux/memblock.h>
 #include <linux/context_tracking.h>
 #include <linux/libfdt.h>
+#include <linux/pkeys.h>
 
 #include <asm/debugfs.h>
 #include <asm/processor.h>
@@ -230,6 +231,10 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 		 */
 		rflags |= HPTE_R_M;
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	rflags |= pte_to_hpte_pkey_bits(pteflags);
+#endif
+
 	return rflags;
 }
 
-- 
1.7.1
