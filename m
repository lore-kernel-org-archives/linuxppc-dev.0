Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxth0WNgzDrLd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 14/21] powerpc: Call jump_label_init() in
 apply_feature_fixups()
Date: Thu, 28 Jul 2016 00:18:10 +1000
Message-Id: <1469629097-30859-14-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

Call jump_label_init() early so that we can use static keys for CPU and
MMU feature checks.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/feature-fixups.c | 8 ++++++++
 1 file changed, 8 insertions(+)

v3: Updated comment.

diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 854b8ba40f8e..2a1904739843 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -13,6 +13,7 @@
  */
 
 #include <linux/types.h>
+#include <linux/jump_label.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/init.h>
@@ -187,6 +188,13 @@ void __init apply_feature_fixups(void)
 			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
 #endif
 	do_final_fixups();
+
+	/*
+	 * Initialise jump label. This causes all the cpu/mmu_has_feature()
+	 * checks to take on their correct polarity based on the current set of
+	 * CPU/MMU features.
+	 */
+	jump_label_init();
 }
 
 static int __init check_features(void)
-- 
2.7.4
