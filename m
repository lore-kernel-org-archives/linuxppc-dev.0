Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8916F1A0222
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:16 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 19:38:05 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id D34922BB0040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6T9boxI15400966
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:37:50 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6T9cCE7008346
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:12 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 7/8] powerpc: mm: Use read barrier when creating real_pte
Date: Tue, 29 Jul 2014 15:07:48 +0530
Message-Id: <1406626669-31154-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1406626669-31154-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1406626669-31154-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On ppc64 we support 4K hash pte with 64K page size. That requires
us to track the hash pte slot information on a per 4k basis. We do that
by storing the slot details in the second half of pte page. The pte bit
_PAGE_COMBO is used to indicate whether the second half need to be
looked while building real_pte. We need to use read memory barrier while
doing that so that load of hidx is not reordered w.r.t _PAGE_COMBO
check. On the store side we already do a lwsync in __hash_page_4K

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pte-hash64-64k.h | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pte-hash64-64k.h b/arch/powerpc/include/asm/pte-hash64-64k.h
index d836d945068d..44a02ccb0c1a 100644
--- a/arch/powerpc/include/asm/pte-hash64-64k.h
+++ b/arch/powerpc/include/asm/pte-hash64-64k.h
@@ -46,11 +46,32 @@
  * in order to deal with 64K made of 4K HW pages. Thus we override the
  * generic accessors and iterators here
  */
-#define __real_pte(e,p) 	((real_pte_t) { \
-			(e), (pte_val(e) & _PAGE_COMBO) ? \
-				(pte_val(*((p) + PTRS_PER_PTE))) : 0 })
-#define __rpte_to_hidx(r,index)	((pte_val((r).pte) & _PAGE_COMBO) ? \
-        (((r).hidx >> ((index)<<2)) & 0xf) : ((pte_val((r).pte) >> 12) & 0xf))
+#define __real_pte __real_pte
+static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
+{
+	real_pte_t rpte;
+
+	rpte.pte = pte;
+	rpte.hidx = 0;
+	if (pte_val(pte) & _PAGE_COMBO) {
+		/*
+		 * Make sure we order the hidx load against the _PAGE_COMBO
+		 * check. The store side ordering is done in __hash_page_4K
+		 */
+		smp_rmb();
+		rpte.hidx = pte_val(*((ptep) + PTRS_PER_PTE));
+	}
+	return rpte;
+}
+
+static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
+{
+	if ((pte_val(rpte.pte) & _PAGE_COMBO))
+		return (rpte.hidx >> (index<<2)) & 0xf;
+	else
+		return (pte_val(rpte.pte) >> 12) & 0xf;
+}
+
 #define __rpte_to_pte(r)	((r).pte)
 #define __rpte_sub_valid(rpte, index) \
 	(pte_val(rpte.pte) & (_PAGE_HPTE_SUB0 >> (index)))
-- 
1.9.1
