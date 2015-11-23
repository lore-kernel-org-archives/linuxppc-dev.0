Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEBB31A1B1C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:55 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:34:55 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 947FA2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:52 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANAYSun20578390
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:36 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANAYJrM028056
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:20 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 02/10] powerpc/mm: Don't hardcode the hash pte slot shift
Date: Mon, 23 Nov 2015 16:03:37 +0530
Message-Id: <1448274825-30289-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1448274825-30289-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index 565f9418c25f..681657cabbe4 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -71,7 +71,7 @@ static inline unsigned long __rpte_to_hidx(real_pte_t rpte, unsigned long index)
 {
 	if ((pte_val(rpte.pte) & _PAGE_COMBO))
 		return (unsigned long) rpte.hidx[index] >> 4;
-	return (pte_val(rpte.pte) >> 12) & 0xf;
+	return (pte_val(rpte.pte) >> _PAGE_F_GIX_SHIFT) & 0xf;
 }
 
 static inline pte_t __rpte_to_pte(real_pte_t rpte)
diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
index 0b43ca60dcb9..64ef7316ff88 100644
--- a/arch/powerpc/include/asm/book3s/64/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
@@ -50,7 +50,7 @@
 #define __real_pte(a,e,p)	(e)
 #define __rpte_to_pte(r)	(__pte(r))
 #endif
-#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> 12)
+#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >>_PAGE_F_GIX_SHIFT)
 
 #define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
 	do {							         \
diff --git a/arch/powerpc/include/asm/nohash/64/pgtable.h b/arch/powerpc/include/asm/nohash/64/pgtable.h
index c4dff4d41c26..8969b4c93c4f 100644
--- a/arch/powerpc/include/asm/nohash/64/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/64/pgtable.h
@@ -121,7 +121,7 @@
 #define __real_pte(a,e,p)	(e)
 #define __rpte_to_pte(r)	(__pte(r))
 #endif
-#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> 12)
+#define __rpte_to_hidx(r,index)	(pte_val(__rpte_to_pte(r)) >> _PAGE_F_GIX_SHIFT)
 
 #define pte_iterate_hashed_subpages(rpte, psize, va, index, shift)       \
 	do {							         \
-- 
2.5.0
