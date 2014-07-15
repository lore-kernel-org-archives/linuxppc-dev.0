Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0CA181A0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:52:03 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 16 Jul 2014 00:52:02 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 932E93578048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:51:59 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6FETGfY2818328
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:29:17 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6FEpwiS009583
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 00:51:58 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: thp: Add write barrier after updating the valid bit
Date: Tue, 15 Jul 2014 20:21:31 +0530
Message-Id: <1405435891-23870-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
write barrier to make sure that clearing pmd busy bit and updating
hpte valid info are ordered properly.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index eb9261024f51..558beb760062 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -394,6 +394,12 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
 					unsigned int index, unsigned int hidx)
 {
 	hpte_slot_array[index] = hidx << 4 | 0x1 << 3;
+	/*
+	 * The hpte valid is stored in the pgtable whose address is in the
+	 * second half of the PMD. Order this against clearing of the busy bit in
+	 * huge pmd.
+	 */
+	smp_wmb();
 }
 
 struct page *realmode_pfn_to_page(unsigned long pfn);
-- 
1.9.1
