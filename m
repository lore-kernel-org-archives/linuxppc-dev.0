Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41vGRK2SWFzDrb6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Aug 2018 00:29:48 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w7KETVUY139079
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 10:29:47 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kyvpb73ss-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Aug 2018 10:29:47 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Mon, 20 Aug 2018 15:29:45 +0100
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: aneesh.kumar@linux.ibm.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
 paulus@samba.org, npiggin@gmail.com
Subject: [PATCH v2 2/3] powerpc/pseries/mm: factorize PTE slot computation
Date: Mon, 20 Aug 2018 16:29:35 +0200
In-Reply-To: <1534775376-22480-1-git-send-email-ldufour@linux.vnet.ibm.com>
References: <1534775376-22480-1-git-send-email-ldufour@linux.vnet.ibm.com>
Message-Id: <1534775376-22480-3-git-send-email-ldufour@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This part of code will be called also when dealing with H_BLOCK_REMOVE.

Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/lpar.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index d3992ced0782..ebc852e3607d 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -546,6 +546,24 @@ static int pSeries_lpar_hpte_removebolted(unsigned long ea,
 	return 0;
 }
 
+
+static inline unsigned long compute_slot(real_pte_t pte,
+					 unsigned long vpn,
+					 unsigned long index,
+					 unsigned long shift,
+					 int ssize)
+{
+	unsigned long slot, hash, hidx;
+
+	hash = hpt_hash(vpn, shift, ssize);
+	hidx = __rpte_to_hidx(pte, index);
+	if (hidx & _PTEIDX_SECONDARY)
+		hash = ~hash;
+	slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
+	slot += hidx & _PTEIDX_GROUP_IX;
+	return slot;
+}
+
 /*
  * Take a spinlock around flushes to avoid bouncing the hypervisor tlbie
  * lock.
@@ -558,7 +576,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
 	unsigned long param[PLPAR_HCALL9_BUFSIZE];
-	unsigned long hash, index, shift, hidx, slot;
+	unsigned long index, shift, slot;
 	real_pte_t pte;
 	int psize, ssize;
 
@@ -572,12 +590,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 		vpn = batch->vpn[i];
 		pte = batch->pte[i];
 		pte_iterate_hashed_subpages(pte, psize, vpn, index, shift) {
-			hash = hpt_hash(vpn, shift, ssize);
-			hidx = __rpte_to_hidx(pte, index);
-			if (hidx & _PTEIDX_SECONDARY)
-				hash = ~hash;
-			slot = (hash & htab_hash_mask) * HPTES_PER_GROUP;
-			slot += hidx & _PTEIDX_GROUP_IX;
+			slot = compute_slot(pte, vpn, index, shift, ssize);
 			if (!firmware_has_feature(FW_FEATURE_BULK_REMOVE)) {
 				/*
 				 * lpar doesn't use the passed actual page size
-- 
2.7.4
