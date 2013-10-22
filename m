Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A16E2C0420
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 22:41:37 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 22 Oct 2013 17:11:32 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id B93348E925F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 17:00:07 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9MBSXO327852886
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:58:33 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9MBSZGp023269
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:58:35 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, linux-mm@kvack.org
Subject: [RFC PATCH 9/9] powerpc: mm: Enable numa faulting for hugepages
Date: Tue, 22 Oct 2013 16:58:20 +0530
Message-Id: <1382441300-1513-10-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Provide numa related functions for updating pmd entries.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 67ea8fb..aa3add7 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -95,19 +95,19 @@ static inline void change_pmd_protnuma(struct mm_struct *mm, unsigned long addr,
 #define pmd_numa pmd_numa
 static inline int pmd_numa(pmd_t pmd)
 {
-	return 0;
+	return pte_numa(pmd_pte(pmd));
 }
 
 #define pmd_mknonnuma pmd_mknonnuma
 static inline pmd_t pmd_mknonnuma(pmd_t pmd)
 {
-	return pmd;
+	return pte_pmd(pte_mknonnuma(pmd_pte(pmd)));
 }
 
 #define pmd_mknuma pmd_mknuma
 static inline pmd_t pmd_mknuma(pmd_t pmd)
 {
-	return pmd;
+	return pte_pmd(pte_mknuma(pmd_pte(pmd)));
 }
 
 # else
-- 
1.8.3.2
