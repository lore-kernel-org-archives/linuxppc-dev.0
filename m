Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xLKcp2FCnzDqqV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Jul 2017 10:11:38 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id c15so11603342qta.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Jul 2017 17:11:38 -0700 (PDT)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, linuxram@us.ibm.com,
 bauerman@linux.vnet.ibm.com, mhocko@kernel.org
Subject: [PATCH 6/7] powerpc: introduce pte_get_hash_gslot() helper
Date: Sun, 30 Jul 2017 17:11:15 -0700
Message-Id: <1501459876-11357-7-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1501459876-11357-1-git-send-email-linuxram@us.ibm.com>
References: <1501459876-11357-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce pte_get_hash_gslot()() which returns the slot number of the
HPTE in the global hash table.

This function will come in handy as we work towards re-arranging the
PTE bits in the later patches.

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash.h |    3 +++
 arch/powerpc/mm/hash_utils_64.c           |   18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 509ace1..1b2ac7e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -155,6 +155,9 @@ static inline int hash__pte_none(pte_t pte)
 	return (pte_val(pte) & ~H_PTE_NONE_MASK) == 0;
 }
 
+unsigned long pte_get_hash_gslot(unsigned long vpn, unsigned long shift,
+		int ssize, real_pte_t rpte, unsigned int subpg_index);
+
 /* This low level function performs the actual PTE insertion
  * Setting the PTE depends on the MMU type and other factors. It's
  * an horrible mess that I'm not going to try to clean up now but
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 1b494d0..d3604da 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -1591,6 +1591,24 @@ static inline void tm_flush_hash_page(int local)
 }
 #endif
 
+/*
+ * return the global hash slot, corresponding to the given
+ * pte, which contains the hpte.
+ */
+unsigned long pte_get_hash_gslot(unsigned long vpn, unsigned long shift,
+		int ssize, real_pte_t rpte, unsigned int subpg_index)
+{
+	unsigned long hash, slot, hidx;
+
+	hash = hpt_hash(vpn, shift, ssize);
+	hidx = __rpte_to_hidx(rpte, subpg_index);
+	if (hidx & _PTEIDX_SECONDARY)
+		hash = ~hash;
+	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+	slot += hidx & _PTEIDX_GROUP_IX;
+	return slot;
+}
+
 /* WARNING: This is called from hash_low_64.S, if you change this prototype,
  *          do not forget to update the assembly call site !
  */
-- 
1.7.1
