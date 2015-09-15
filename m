Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 330881A2C21
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 17:01:16 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 15 Sep 2015 17:01:14 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 853162CE805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 17:01:09 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8F7119S45023336
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 17:01:09 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8F70aQZ030502
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 17:00:37 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Recompute hash value after a failed update
Date: Tue, 15 Sep 2015 12:30:08 +0530
Message-Id: <1442300408-26490-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we had secondary hash flag set, we ended up modifying hash value in
the updatepp code path. Hence with a failed updatepp we will be using
a wrong hash value for the following hash insert. Fix this by
recomputing hash before insert.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugepage-hash64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 43dafb9d6a46..4d87122cf6a7 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -85,7 +85,6 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	BUG_ON(index >= 4096);
 
 	vpn = hpt_vpn(ea, vsid, ssize);
-	hash = hpt_hash(vpn, shift, ssize);
 	hpte_slot_array = get_hpte_slot_array(pmdp);
 	if (psize == MMU_PAGE_4K) {
 		/*
@@ -101,6 +100,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	valid = hpte_valid(hpte_slot_array, index);
 	if (valid) {
 		/* update the hpte bits */
+		hash = hpt_hash(vpn, shift, ssize);
 		hidx =  hpte_hash_index(hpte_slot_array, index);
 		if (hidx & _PTEIDX_SECONDARY)
 			hash = ~hash;
@@ -126,6 +126,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	if (!valid) {
 		unsigned long hpte_group;
 
+		hash = hpt_hash(vpn, shift, ssize);
 		/* insert new entry */
 		pa = pmd_pfn(__pmd(old_pmd)) << PAGE_SHIFT;
 		new_pmd |= _PAGE_HASHPTE;
-- 
2.5.0
