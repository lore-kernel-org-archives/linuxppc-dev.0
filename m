Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com
 [IPv6:2607:f8b0:400d:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxhYv54gvzDr28
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 20:12:35 +1000 (AEST)
Received: by mail-qk0-x244.google.com with SMTP id 16so3246897qkg.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 03:12:35 -0700 (PDT)
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
Subject: [RFC v4 09/17] powerpc: call the hash functions with the correct pkey
 value
Date: Tue, 27 Jun 2017 03:11:51 -0700
Message-Id: <1498558319-32466-10-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
References: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pass the correct protection key value to the hash functions on
page fault.

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/pkeys.h | 11 +++++++++++
 arch/powerpc/mm/hash_utils_64.c  |  4 ++++
 arch/powerpc/mm/mem.c            |  6 ++++++
 3 files changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index ef1c601..1370b3f 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -74,6 +74,17 @@ static inline bool mm_pkey_is_allocated(struct mm_struct *mm, int pkey)
 }
 
 /*
+ * return the protection key of the vma corresponding to the
+ * given effective address @ea.
+ */
+static inline int mm_pkey(struct mm_struct *mm, unsigned long ea)
+{
+	struct vm_area_struct *vma = find_vma(mm, ea);
+	int pkey = vma ? vma_pkey(vma) : 0;
+	return pkey;
+}
+
+/*
  * Returns a positive, 5-bit key on success, or -1 on failure.
  */
 static inline int mm_pkey_alloc(struct mm_struct *mm)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 7e67dea..403f75d 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1319,6 +1319,10 @@ int hash_page_mm(struct mm_struct *mm, unsigned long ea,
 		goto bail;
 	}
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	pkey = mm_pkey(mm, ea);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 	if (hugeshift) {
 		if (is_thp)
 			rc = __hash_page_thp(ea, access, vsid, (pmd_t *)ptep,
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index ec890d3..0fcaa48 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -541,8 +541,14 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
 		return;
 	}
 
+#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
+	hash_preload_pkey(vma->vm_mm, address, access, trap, vma_pkey(vma));
+#else
 	hash_preload(vma->vm_mm, address, access, trap);
+#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
+
 #endif /* CONFIG_PPC_STD_MMU */
+
 #if (defined(CONFIG_PPC_BOOK3E_64) || defined(CONFIG_PPC_FSL_BOOK3E)) \
 	&& defined(CONFIG_HUGETLB_PAGE)
 	if (is_vm_hugetlb_page(vma))
-- 
1.8.3.1
