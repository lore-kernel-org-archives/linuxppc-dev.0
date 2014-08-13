Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C39431A15F0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:25 +1000 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Aug 2014 17:02:23 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 8B5502CE8056
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7D72tni17039596
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:56 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7D72F5V005841
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:16 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V2 1/8] powerpc: thp: Add write barrier after updating the
 valid bit
Date: Wed, 13 Aug 2014 12:31:57 +0530
Message-Id: <1407913324-8062-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1407913324-8062-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1407913324-8062-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

With hugepages, we store the hpte valid information in the pte page
whose address is stored in the second half of the PMD. Use a
write barrier to make sure clearing pmd busy bit and updating
hpte valid info are ordered properly.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugepage-hash64.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 826893fcb3a7..11f9a37ca2c6 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -172,8 +172,11 @@ repeat:
 		mark_hpte_slot_valid(hpte_slot_array, index, slot);
 	}
 	/*
-	 * No need to use ldarx/stdcx here
+	 * The hpte valid is stored in the pgtable whose address is in the
+	 * second half of the PMD. Order this against clearing of the busy bit in
+	 * huge pmd.
 	 */
+	smp_wmb();
 	*pmdp = __pmd(new_pmd & ~_PAGE_BUSY);
 	return 0;
 }
-- 
1.9.1
