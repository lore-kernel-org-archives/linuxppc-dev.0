Return-Path: <kda@linux-powerpc.org>
Received: from mail-lb0-f170.google.com (mail-lb0-f170.google.com
 [209.85.217.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1835E2C00EA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 19:18:47 +1000 (EST)
Received: by mail-lb0-f170.google.com with SMTP id u10so3617254lbi.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2013 02:18:43 -0700 (PDT)
From: Denis Kirjanov <kda@linux-powerpc.org>
To: aneesh.kumar@linux.vnet.ibm.com
Subject: [PATCH] Fix a typo in pSeries_lpar_hpte_insert()
Date: Mon, 22 Jul 2013 09:23:50 +0400
Message-Id: <1374470630-2106-1-git-send-email-kda@linux-powerpc.org>
Cc: Denis Kirjanov <kda@linux-powerpc.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix a typo in pSeries_lpar_hpte_insert()

Signed-off-by: Denis Kirjanov <kda@linux-powerpc.org>
---
 arch/powerpc/platforms/pseries/lpar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 0da39fe..c4112ed 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -136,7 +136,7 @@ static long pSeries_lpar_hpte_insert(unsigned long hpte_group,
 	flags = 0;
 
 	/* Make pHyp happy */
-	if ((rflags & _PAGE_NO_CACHE) & !(rflags & _PAGE_WRITETHRU))
+	if ((rflags & _PAGE_NO_CACHE) && !(rflags & _PAGE_WRITETHRU))
 		hpte_r &= ~_PAGE_COHERENT;
 	if (firmware_has_feature(FW_FEATURE_XCMO) && !(hpte_r & HPTE_R_N))
 		flags |= H_COALESCE_CAND;
-- 
1.8.0.2
