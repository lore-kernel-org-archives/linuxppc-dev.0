Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2CF8B1A1AB2
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:21 +1100 (AEDT)
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:19 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 645101258019
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:07:36 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13bIYL48889914
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:18 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13bG51022514
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:17 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 31/35] powerpc/mm: Don't hardcode the hash pte slot shift
Date: Tue,  1 Dec 2015 09:06:56 +0530
Message-Id: <1448941020-15168-32-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448941020-15168-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use the #define instead of open-coding the same

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 2 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h  | 2 +-
 arch/powerpc/include/asm/nohash/64/pgtable.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index cca050aa1aa8..9f9942998587 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -94,7 +94,7 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
 {
 	if ((pte_val(rpte.pte) & _PAGE_COMBO))
 		return (rpte.hidx >> (index<<2)) & 0xf;
-	return (pte_val(rpte.pte) >> 12) & 0xf;
+	return (pte_val(rpte.pte) >> _PAGE_F_GIX_SHIFT) & 0xf;
 }
 
 #define __rpte_to_pte(r)	((r).pte)
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index bb97b6a52b84..a2d4e0e37067 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -50,7 +50,7 @@
 #define __real_pte(e,p)		(e)
 #define __rpte_to_pte(r)	(__pte(r))
 #endif
-#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> 12)
+#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >>_PAGE_F_GIX_SHIFT)
 
 #define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
 	do {							         \
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index d635a924d652..03c226965b46 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -121,7 +121,7 @@
 #define __real_pte(e,p)		(e)
 #define __rpte_to_pte(r)	(__pte(r))
 #endif
-#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> 12)
+#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> _PAGE_F_GIX_SHIFT)
 
 #define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
 	do {							         \
-- 
2.5.0
