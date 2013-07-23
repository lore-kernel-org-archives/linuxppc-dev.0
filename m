Return-Path: <kda@linux-powerpc.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CA3A2C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jul 2013 01:23:00 +1000 (EST)
Received: by mail-la0-f53.google.com with SMTP id fj20so4615746lab.12
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 08:22:56 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] Fix a typo in pSeries_lpar_hpte_insert()
Date: Tue, 23 Jul 2013 15:28:03 +0400
Message-Id: <1374578883-2242-1-git-send-email-kda@linux-powerpc.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, aneesh.kumar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 801eb73f45371accc78ca9d6d22d647eeb722c11 introduced
a bug while checking PTE flags. We have to drop the _PAGE_COHERENT flag
when __PAGE_NO_CACHE is set and the cache update policy is not write-through
(i.e. _PAGE_WRITETHRU is not set)

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
CC:  Michael Ellerman <michael@ellerman.id.au>
---
v1->v2:
- Updated commit log
---
 arch/powerpc/platforms/pseries/lpar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 02d6e21..8bad880 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -146,7 +146,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	flags = 0;
 
 	/* Make pHyp happy */
-	if ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU))
+	if ((rflags & _PAGE_NO_CACHE) && !(rflags & _PAGE_WRITETHRU))
 		hpte_r &= ~_PAGE_COHERENT;
 	if (firmware_has_feature(FW_FEATURE_XCMO) && !(hpte_r & HPTE_R_N))
 		flags |= H_COALESCE_CAND;
-- 
1.8.0.2
