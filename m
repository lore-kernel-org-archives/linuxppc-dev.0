Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 812611A1AB5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:37:24 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 1 Dec 2015 09:07:22 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id EBB95E0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 09:08:00 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB13bI8055509052
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:18 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB13bHhr022586
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 09:07:18 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Scott Wood <scottwood@freescale.com>,
 Denis Kirjanov <kda@linux-powerpc.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V6 35/35] powerpc/mm: Don't open code pgtable_t size
Date: Tue,  1 Dec 2015 09:07:00 +0530
Message-Id: <1448941020-15168-36-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

The slot information of base page size hash pte is stored in the
pgtable_t w.r.t transparent hugepage. We need to make sure we don't
index beyond pgtable_t size.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugepage-hash64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 1f666de0110a..baf1301ded0c 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -71,7 +71,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	 */
 	shift = mmu_psize_defs[psize].shift;
 	index = (ea & ~HPAGE_PMD_MASK) >> shift;
-	BUG_ON(index >= 4096);
+	BUG_ON(index >= PTE_FRAG_SIZE);
 
 	vpn = hpt_vpn(ea, vsid, ssize);
 	hpte_slot_array = get_hpte_slot_array(pmdp);
-- 
2.5.0
