Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CA601A0207
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:14 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 29 Jul 2014 19:38:03 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1CC853578023
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:12 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6T9L7nP196910
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:21:08 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6T9cAUr008314
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Jul 2014 19:38:11 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH 6/8] powerpc: thp: use ACCESS_ONCE when loading pmdp
Date: Tue, 29 Jul 2014 15:07:47 +0530
Message-Id: <1406626669-31154-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
