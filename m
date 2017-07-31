Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com
 [IPv6:2607:f8b0:400d:c09::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKfX3hD8zDrBX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:13:08 +1000 (AEST)
Received: by mail-qk0-x243.google.com with SMTP id d145so22783228qkc.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:13:08 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [RFC v7 16/25] powerpc: helper to validate key-access permissions of
 a pte
Date: Sun, 30 Jul 2017 17:12:17 -0700
Message-Id: <1501459946-11619-17-git-send-email-linuxram@us.ibm.com>
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

helper function that checks if the read/write/execute is allowed
on the pte.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/pgtable.h |    4 +++
 arch/powerpc/include/asm/pkeys.h             |   12 +++++++++++
 arch/powerpc/mm/pkeys.c                      |   28 ++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 060a1b2..2bec0f6 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -477,6 +477,10 @@ static inline void write_uamor(u64 value)
 	mtspr(SPRN_UAMOR, value);
 }
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+extern bool arch_pte_access_permitted(u64 pte, bool write, bool execute);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long addr, pte_t *ptep)
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 4b7e3f4..ba7bff6 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -85,6 +85,18 @@ static inline u64 pte_to_hpte_pkey_bits(u64 pteflags)
 		((pteflags & H_PAGE_PKEY_BIT4) ? HPTE_R_KEY_BIT4 : 0x0UL));
 }
 
+static inline u16 pte_to_pkey_bits(u64 pteflags)
+{
+	if (!pkey_inited)
+		return 0x0UL;
+
+	return (((pteflags & H_PAGE_PKEY_BIT0) ? 0x10 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT1) ? 0x8 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT2) ? 0x4 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT3) ? 0x2 : 0x0UL) |
+		((pteflags & H_PAGE_PKEY_BIT4) ? 0x1 : 0x0UL));
+}
+
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
 				VM_PKEY_BIT3 | VM_PKEY_BIT4)
 #define AMR_BITS_PER_PKEY 2
diff --git a/arch/powerpc/mm/pkeys.c b/arch/powerpc/mm/pkeys.c
index edcbf48..8d756ef 100644
--- a/arch/powerpc/mm/pkeys.c
+++ b/arch/powerpc/mm/pkeys.c
@@ -201,3 +201,31 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot,
 	 */
 	return vma_pkey(vma);
 }
+
+static bool pkey_access_permitted(int pkey, bool write, bool execute)
+{
+	int pkey_shift;
+	u64 amr;
+
+	if (!pkey)
+		return true;
+
+	pkey_shift = pkeyshift(pkey);
+	if (!(read_uamor() & (0x3UL << pkey_shift)))
+		return true;
+
+	if (execute && !(read_iamr() & (IAMR_EX_BIT << pkey_shift)))
+		return true;
+
+	amr = read_amr(); /* delay reading amr uptil absolutely needed*/
+	return ((!write && !(amr & (AMR_RD_BIT << pkey_shift))) ||
+		(write &&  !(amr & (AMR_WR_BIT << pkey_shift))));
+}
+
+bool arch_pte_access_permitted(u64 pte, bool write, bool execute)
+{
+	if (!pkey_inited)
+		return true;
+	return pkey_access_permitted(pte_to_pkey_bits(pte),
+			write, execute);
+}
-- 
1.7.1
