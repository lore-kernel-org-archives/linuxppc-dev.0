Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 333391A0CC6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:19 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:18 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C7DDDE004C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:07:56 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13bEH252822064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:15 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13bDtE022208
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:14 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 21/35] powerpc/mm: Remove pte_val usage for the second half
 of pgtable_t
Date: Tue,  1 Dec 2015 09:06:46 +0530
Message-Id: <1448941020-15168-22-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 4 +++-
 arch/powerpc/mm/hash64_64k.c                  | 1 -
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index a268416ca4a4..9fca7fae434b 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -61,6 +61,7 @@
 static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
 {
 	real_pte_t rpte;
+	unsigned long *hidxp;
 
 	rpte.pte = pte;
 	rpte.hidx = 0;
@@ -70,7 +71,8 @@ static inline real_pte_t __real_pte(pte_t pte, pte_t *ptep)
 		 * check. The store side ordering is done in __hash_page_4K
 		 */
 		smp_rmb();
-		rpte.hidx = pte_val(*((ptep) + PTRS_PER_PTE));
+		hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
+		rpte.hidx = *hidxp;
 	}
 	return rpte;
 }
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index f1b86ba63430..8f7328075f04 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -218,7 +218,6 @@ repeat:
 	 * nobody is undating hidx.
 	 */
 	hidxp = (unsigned long *)(ptep + PTRS_PER_PTE);
-	/* __real_pte use pte_val() any idea why ? FIXME!! */
 	rpte.hidx &= ~(0xfUL << (subpg_index << 2));
 	*hidxp = rpte.hidx  | (slot << (subpg_index << 2));
 	new_pte = mark_subptegroup_valid(new_pte, subpg_index);
-- 
2.5.0
