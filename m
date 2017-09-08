Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xpss45JJdzDrcv
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Sep 2017 08:47:20 +1000 (AEST)
Received: by mail-qt0-x243.google.com with SMTP id h21so2358529qth.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Sep 2017 15:47:20 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: [PATCH 21/25] powerpc: introduce get_pte_pkey() helper
Date: Fri,  8 Sep 2017 15:45:09 -0700
Message-Id: <1504910713-7094-30-git-send-email-linuxram@us.ibm.com>
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

get_pte_pkey() helper returns the pkey associated with
a address corresponding to a given mm_struct.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu-hash.h |    5 +++++
 arch/powerpc/mm/hash_utils_64.c               |   24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
index 2e22357..8716031 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
@@ -451,6 +451,11 @@ extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap,
 int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
 		     pte_t *ptep, unsigned long trap, unsigned long flags,
 		     int ssize, unsigned int shift, unsigned int mmu_psize);
+
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+u16 get_pte_pkey(struct mm_struct *mm, unsigned long address);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern int __hash_page_thp(unsigned long ea, unsigned long access,
 			   unsigned long vsid, pmd_t *pmdp, unsigned long trap,
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index a739a2d..5917d45 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1572,6 +1572,30 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
 	local_irq_restore(flags);
 }
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+/*
+ * return the protection key associated with the given address
+ * and the mm_struct.
+ */
+u16 get_pte_pkey(struct mm_struct *mm, unsigned long address)
+{
+	pte_t *ptep;
+	u16 pkey = 0;
+	unsigned long flags;
+
+	if (!mm || !mm->pgd)
+		return 0;
+
+	local_irq_save(flags);
+	ptep = find_linux_pte(mm->pgd, address, NULL, NULL);
+	if (ptep)
+		pkey = pte_to_pkey_bits(pte_val(READ_ONCE(*ptep)));
+	local_irq_restore(flags);
+
+	return pkey;
+}
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
 static inline void tm_flush_hash_page(int local)
 {
-- 
1.7.1
