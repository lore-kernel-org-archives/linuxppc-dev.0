Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtl0gNGzDrLm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:55 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 17/21] powerpc: Add kconfig option to use jump labels for
 cpu/mmu_has_feature()
Date: Thu, 28 Jul 2016 00:18:13 +1000
Message-Id: <1469629097-30859-17-git-send-email-mpe@ellerman.id.au>
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

Add a kconfig option to control whether we use jump label for the
cpu/mmu_has_feature() checks. Currently this does nothing, but we will
enabled it in the subsequent patches.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug | 9 +++++++++
 1 file changed, 9 insertions(+)

v3: New.

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index cfe08eab90c6..2512dac77adb 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -60,6 +60,15 @@ config CODE_PATCHING_SELFTEST
 	depends on DEBUG_KERNEL
 	default n
 
+config JUMP_LABEL_FEATURE_CHECKS
+	bool "Enable use of jump label for cpu/mmu_has_feature()"
+	depends on JUMP_LABEL
+	default y
+	help
+	  Selecting this options enables use of jump labels for some internal
+	  feature checks. This should generate more optimal code for those
+	  checks.
+
 config FTR_FIXUP_SELFTEST
 	bool "Run self-tests of the feature-fixup code"
 	depends on DEBUG_KERNEL
-- 
2.7.4
