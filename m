Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E8391A1B39
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:35:01 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 23 Nov 2015 20:35:01 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 5F76A3578047
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:59 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tANAYr9p32178354
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:35:01 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tANAYQOx028181
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2015 21:34:27 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 05/10] powerpc/mm: Use H_READ with H_READ_4
Date: Mon, 23 Nov 2015 16:03:40 +0530
Message-Id: <1448274825-30289-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

This will bulk read 4 hash pte slot entries and should reduce the loop

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/plpar_wrappers.h | 17 ++++++++++
 arch/powerpc/platforms/pseries/lpar.c     | 54 +++++++++++++++----------------
 2 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 67859edbf8fd..1b394247afc2 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -202,6 +202,23 @@ static inline long plpar_pte_read_raw(unsigned long flags, unsigned long ptex,
 }
 
 /*
+ * ptes must be 8*sizeof(unsigned long)
+ */
+static inline long plpar_pte_read_4(unsigned long flags, unsigned long ptex,
+				    unsigned long *ptes)
+
+{
+	long rc;
+	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+
+	rc = plpar_hcall9(H_READ, retbuf, flags | H_READ_4, ptex);
+
+	memcpy(ptes, retbuf, 8*sizeof(unsigned long));
+
+	return rc;
+}
+
+/*
  * plpar_pte_read_4_raw can be called in real mode.
  * ptes must be 8*sizeof(unsigned long)
  */
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 6d46547871aa..477290ad855e 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -315,48 +315,48 @@ static long pSeries_lpar_hpte_updatepp(unsigned long slot,
 	return 0;
 }
 
-static unsigned long pSeries_lpar_hpte_getword0(unsigned long slot)
+static long __pSeries_lpar_hpte_find(unsigned long want_v, unsigned long hpte_group)
 {
-	unsigned long dword0;
-	unsigned long lpar_rc;
-	unsigned long dummy_word1;
-	unsigned long flags;
+	long lpar_rc;
+	unsigned long i, j;
+	struct {
+		unsigned long pteh;
+		unsigned long ptel;
+	} ptes[4];
 
-	/* Read 1 pte at a time                        */
-	/* Do not need RPN to logical page translation */
-	/* No cross CEC PFT access                     */
-	flags = 0;
+	for (i = 0; i < HPTES_PER_GROUP; i += 4, hpte_group += 4) {
 
-	lpar_rc = plpar_pte_read(flags, slot, &dword0, &dummy_word1);
+		lpar_rc = plpar_pte_read_4(0, hpte_group, (void *)ptes);
+		if (lpar_rc != H_SUCCESS)
+			continue;
 
-	BUG_ON(lpar_rc != H_SUCCESS);
+		for (j = 0; j < 4; j++) {
+			if (HPTE_V_COMPARE(ptes[j].pteh, want_v) &&
+			    (ptes[j].pteh & HPTE_V_VALID))
+				return i + j;
+		}
+	}
 
-	return dword0;
+	return -1;
 }
 
 static long pSeries_lpar_hpte_find(unsigned long vpn, int psize, int ssize)
 {
-	unsigned long hash;
-	unsigned long i;
 	long slot;
-	unsigned long want_v, hpte_v;
+	unsigned long hash;
+	unsigned long want_v;
+	unsigned long hpte_group;
 
 	hash = hpt_hash(vpn, mmu_psize_defs[psize].shift, ssize);
 	want_v = hpte_encode_avpn(vpn, psize, ssize);
 
 	/* Bolted entries are always in the primary group */
-	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-	for (i = 0; i < HPTES_PER_GROUP; i++) {
-		hpte_v = pSeries_lpar_hpte_getword0(slot);
-
-		if (HPTE_V_COMPARE(hpte_v, want_v) && (hpte_v & HPTE_V_VALID))
-			/* HPTE matches */
-			return slot;
-		++slot;
-	}
-
-	return -1;
-} 
+	hpte_group = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+	slot = __pSeries_lpar_hpte_find(want_v, hpte_group);
+	if (slot < 0)
+		return -1;
+	return hpte_group + slot;
+}
 
 static void pSeries_lpar_hpte_updateboltedpp(unsigned long newpp,
 					     unsigned long ea,
-- 
2.5.0
