Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y26J44bLDzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Sep 2017 15:46:12 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id g65so5973487pfe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 22:46:12 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Jeremy Kerr <jk@ozlabs.org>,
 Meng YK Li <shlimeng@cn.ibm.com>
Subject: [PATCH] powerpc/powernv: Use early_radix_enabled in POWER9 tlb flush
Date: Wed, 27 Sep 2017 15:45:58 +1000
Message-Id: <20170927054558.26007-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This code is used at boot and machine checks, so it should be using
early_radix_enabled() (which is usable any time).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/mce_power.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
index b76ca198e09c..d37e612050b5 100644
--- a/arch/powerpc/kernel/mce_power.c
+++ b/arch/powerpc/kernel/mce_power.c
@@ -128,7 +128,7 @@ void __flush_tlb_power9(unsigned int action)
 {
 	unsigned int num_sets;
 
-	if (radix_enabled())
+	if (early_radix_enabled())
 		num_sets = POWER9_TLB_SETS_RADIX;
 	else
 		num_sets = POWER9_TLB_SETS_HASH;
-- 
2.13.3
