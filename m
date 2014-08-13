Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C7A41A15D1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:32 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Aug 2014 17:02:31 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 0B5D63578047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:29 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s7D73CpJ11337844
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:03:12 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7D72R4a006256
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Aug 2014 17:02:28 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH V2 6/8] powerpc: thp: use ACCESS_ONCE when loading pmdp
Date: Wed, 13 Aug 2014 12:32:02 +0530
Message-Id: <1407913324-8062-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We would get wrong results in compiler recomputed old_pmd. Avoid
that by using ACCESS_ONCE

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hugepage-hash64.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 1fb609dcc49b..5f5e6328c21c 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -84,7 +84,9 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 	 * atomically mark the linux large page PMD busy and dirty
 	 */
 	do {
-		old_pmd = pmd_val(*pmdp);
+		pmd_t pmd = ACCESS_ONCE(*pmdp);
+
+		old_pmd = pmd_val(pmd);
 		/* If PMD busy, retry the access */
 		if (unlikely(old_pmd & _PAGE_BUSY))
 			return 0;
-- 
1.9.1
