Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C812E1A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:13 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 19:38:13 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id EA8712BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:09 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6T9bl3417957118
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:37:47 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6T9c9HM008256
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:09 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 5/8] powerpc: thp: inalidate with vpn in loop
Date: Tue, 29 Jul 2014 15:07:46 +0530
Message-Id: <1406626669-31154-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

As per ISA, for 4k base page size we compare 14..65 bits of VA specified
with the entry_VA in tlb. That implies we need to make sure we do a
tlbie with all the possible 4k va we used to access the 16MB hugepage.
With 64k base page size we compare 14..57 bits of VA. Hence we cannot
ignore the lower 24 bits of va while tlbie .We also cannot tlb
invalidate a 16MB entry with just one tlbie instruction because
we don't track which va was used to instantiate the tlb entry.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_native_64.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index fb89d7695a9a..afc0a8295f84 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -417,7 +417,7 @@ static void native_hugepage_invalidate(unsigned long vsid,
 				       unsigned char *hpte_slot_array,
 				       int psize, int ssize)
 {
-	int i, lock_tlbie;
+	int i;
 	struct hash_pte *hptep;
 	int actual_psize = MMU_PAGE_16M;
 	unsigned int max_hpte_count, valid;
@@ -456,22 +456,13 @@ static void native_hugepage_invalidate(unsigned long vsid,
 		else
 			/* Invalidate the hpte. NOTE: this also unlocks it */
 			hptep->v = 0;
+		/*
+		 * We need to do tlb invalidate for all the address, tlbie
+		 * instruction compares entry_VA in tlb with the VA specified
+		 * here
+		 */
+		tlbie(vpn, psize, actual_psize, ssize, 0);
 	}
-	/*
-	 * Since this is a hugepage, we just need a single tlbie.
-	 * use the last vpn.
-	 */
-	lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
-	if (lock_tlbie)
-		raw_spin_lock(&native_tlbie_lock);
-
-	asm volatile("ptesync":::"memory");
-	__tlbie(vpn, psize, actual_psize, ssize);
-	asm volatile("eieio; tlbsync; ptesync":::"memory");
-
-	if (lock_tlbie)
-		raw_spin_unlock(&native_tlbie_lock);
-
 	local_irq_restore(flags);
 }
 
-- 
1.9.1
