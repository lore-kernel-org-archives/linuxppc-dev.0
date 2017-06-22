Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com
 [IPv6:2607:f8b0:400d:c0d::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtPQt75G1zDqjv
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 11:40:06 +1000 (AEST)
Received: by mail-qt0-x241.google.com with SMTP id o21so354101qtb.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 18:40:06 -0700 (PDT)
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
Subject: [RFC v3 06/23] powerpc: use helper functions in __hash_page_4K() for
 64K PTE
Date: Wed, 21 Jun 2017 18:39:22 -0700
Message-Id: <1498095579-6790-7-git-send-email-linuxram@us.ibm.com>
In-Reply-To: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
References: <1498095579-6790-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

replace redundant code in __hash_page_4K() with helper
functions get_hidx_gslot() and set_hidx_slot()

Signed-off-by: Ram Pai <linuxram@us.ibm.com>
---
 arch/powerpc/mm/hash64_64k.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index 5cbdaa9..cb48a60 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -103,18 +103,12 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	if (__rpte_sub_valid(rpte, subpg_index)) {
 		int ret;
 
-		hash = hpt_hash(vpn, shift, ssize);
-		hidx = __rpte_to_hidx(rpte, subpg_index);
-		if (hidx & _PTEIDX_SECONDARY)
-			hash = ~hash;
-		slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-		slot += hidx & _PTEIDX_GROUP_IX;
-
-		ret = mmu_hash_ops.hpte_updatepp(slot, rflags, vpn,
+		gslot = get_hidx_gslot(vpn, shift, ssize, rpte, subpg_index);
+		ret = mmu_hash_ops.hpte_updatepp(gslot, rflags, vpn,
 						 MMU_PAGE_4K, MMU_PAGE_4K,
 						 ssize, flags);
 		/*
-		 *if we failed because typically the HPTE wasn't really here
+		 * if we failed because typically the HPTE wasn't really here
 		 * we try an insertion.
 		 */
 		if (ret == -1)
@@ -214,15 +208,9 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * Since we have H_PAGE_BUSY set on ptep, we can be sure
 	 * nobody is undating hidx.
 	 */
-	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
-	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
-	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
-	new_pte = mark_subptegroup_valid(new_pte, subpg_index);
-	new_pte |=  H_PAGE_HASHPTE;
-	/*
-	 * check __real_pte for details on matching smp_rmb()
-	 */
-	smp_wmb();
+	new_pte |= H_PAGE_HASHPTE;
+	new_pte |= set_hidx_slot(ptep, rpte, subpg_index, slot);
+
 	*ptep = __pte(new_pte & ~H_PAGE_BUSY);
 	return 0;
 }
-- 
1.8.3.1
