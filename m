Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVmbz4dRlzDr5J
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 19:55:27 +1100 (AEDT)
Received: by mail-qt0-x241.google.com with SMTP id z19so9959238qtg.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Nov 2017 00:55:27 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, linuxram@us.ibm.com
Subject: [PATCH v9 1/8] powerpc: introduce pte_set_hidx() helper
Date: Mon,  6 Nov 2017 00:50:45 -0800
Message-Id: <1509958252-18302-2-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1509958252-18302-1-git-send-email-linuxram@us.ibm.com>
References: <1509958252-18302-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce pte_set_hidx().It sets the (H_PAGE_F_SECOND|H_PAGE_F_GIX) bits
at the appropriate location in the PTE of 4K PTE. For 64K PTE, it sets
the bits in the second part of the PTE. Though the implementation for
the former just needs the slot parameter, it does take some additional
parameters to keep the prototype consistent.

This function will be handy as we work towards re-arranging the bits in
the subsequent patches.

Acked-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |   14 ++++++++++++++
 arch/powerpc/include/asm/book3s/64/hash-64k.h |   25 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 197ced1..2975fc1 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -49,6 +49,20 @@ static inline int hash__hugepd_ok(hugepd_t hpd)
 }
 #endif
 
+/*
+ * 4K PTE format is different from 64K PTE format. Saving the hash_slot is just
+ * a matter of returning the PTE bits that need to be modified. On 64K PTE,
+ * things are a little more involved and hence needs many more parameters to
+ * accomplish the same. However we want to abstract this out from the caller by
+ * keeping the prototype consistent across the two formats.
+ */
+static inline unsigned long pte_set_hidx(pte_t *ptep, real_pte_t rpte,
+			unsigned int subpg_index, unsigned long hidx)
+{
+	return (hidx << H_PAGE_F_GIX_SHIFT) &
+		(H_PAGE_F_SECOND | H_PAGE_F_GIX);
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 static inline char *get_hpte_slot_array(pmd_t *pmdp)
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index 8d40cf0..c1bd258 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -68,6 +68,8 @@ static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
 	return rpte;
 }
 
+#define HIDX_BITS(x, index)  (x << (index << 2))
+
 static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
 {
 	if ((pte_val(rpte.pte) & H_PAGE_COMBO))
@@ -75,6 +77,29 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
 	return (pte_val(rpte.pte) >> H_PAGE_F_GIX_SHIFT) & 0xf;
 }
 
+/*
+ * Commit the hidx and return PTE bits that needs to be modified. The caller is
+ * expected to modify the PTE bits accordingly and commit the PTE to memory.
+ */
+static inline unsigned long pte_set_hidx(pte_t *ptep, real_pte_t rpte,
+		unsigned int subpg_index, unsigned long hidx)
+{
+	unsigned long *hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
+
+	rpte.hidx &= ~HIDX_BITS(0xfUL, subpg_index);
+	*hidxp = rpte.hidx  | HIDX_BITS(hidx, subpg_index);
+
+	/*
+	 * Anyone reading PTE must ensure hidx bits are read after reading the
+	 * PTE by using the read-side barrier smp_rmb(). __real_pte() can be
+	 * used for that.
+	 */
+	smp_wmb();
+
+	/* No PTE bits to be modified, return 0x0UL */
+	return 0x0UL;
+}
+
 #define __rpte_to_pte(r)	((r).pte)
 extern bool __rpte_sub_valid(real_pte_t rpte, unsigned long index);
 /*
-- 
1.7.1
