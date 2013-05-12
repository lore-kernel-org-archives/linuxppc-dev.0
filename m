Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 452CD2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 02:14:44 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 12 May 2013 21:37:49 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 149463940023
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 21:44:37 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4CGESmK10617254
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 21:44:28 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4CGEZm8023321
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 02:14:36 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com
Subject: [PATCH -V8 01/18] powerpc/mm: Use the correct mask value when looking
 at pgtable address
Date: Sun, 12 May 2013 21:44:08 +0530
Message-Id: <1368375265-19593-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1368375265-19593-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1368375265-19593-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Our pgtable are 2*sizeof(pte_t)*PTRS_PER_PTE which is PTE_FRAG_SIZE.
Instead of depending on frag size, mask with PMD_MASKED_BITS.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgalloc-64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/pgalloc-64.h b/arch/powerpc/include/asm/pgalloc-64.h
index 91acb12..b66ae72 100644
--- a/arch/powerpc/include/asm/pgalloc-64.h
+++ b/arch/powerpc/include/asm/pgalloc-64.h
@@ -186,7 +186,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 static inline pgtable_t pmd_pgtable(pmd_t pmd)
 {
-	return (pgtable_t)(pmd_val(pmd) & -sizeof(pte_t)*PTRS_PER_PTE);
+	return (pgtable_t)(pmd_val(pmd) & ~PMD_MASKED_BITS);
 }
 
 static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm,
-- 
1.8.1.2
