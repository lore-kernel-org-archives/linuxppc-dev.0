Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E31AE1A065A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2015 20:12:02 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/6] powerpc: Make STRICT_MM_TYPECHECKS a config option
Date: Wed, 25 Mar 2015 20:11:56 +1100
Message-Id: <1427274719-25890-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
References: <1427274719-25890-1-git-send-email-mpe@ellerman.id.au>
Cc: aneesh.kumar@in.ibm.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The STRICT_MM_TYPECHECKS code has bit-rotted over the years. To make it
possible to easily build test it, make it a CONFIG option.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug               | 8 ++++++++
 arch/powerpc/include/asm/page.h          | 4 +---
 arch/powerpc/include/asm/pgtable-ppc64.h | 2 +-
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index ec2e40f2cc11..777108f4acab 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -19,6 +19,14 @@ config PPC_WERROR
 	depends on !PPC_DISABLE_WERROR
 	default y
 
+config STRICT_MM_TYPECHECKS
+	bool "Do extra type checking on mm types"
+	default n
+	help
+	  This option turns on extra type checking for some mm related types.
+
+	  If you don't know what this means, say N.
+
 config PRINT_STACK_DEPTH
 	int "Stack depth to print" if DEBUG_KERNEL
 	default 64
diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index 69c059887a2c..71294a6e976e 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -278,9 +278,7 @@ extern long long virt_phys_offset;
 
 #ifndef __ASSEMBLY__
 
-#undef STRICT_MM_TYPECHECKS
-
-#ifdef STRICT_MM_TYPECHECKS
+#ifdef CONFIG_STRICT_MM_TYPECHECKS
 /* These are used to make use of C type-checking. */
 
 /* PTE level */
diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 43e6ad424c7f..f951d9cf358a 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -118,7 +118,7 @@
  */
 #ifndef __real_pte
 
-#ifdef STRICT_MM_TYPECHECKS
+#ifdef CONFIG_STRICT_MM_TYPECHECKS
 #define __real_pte(e,p)		((real_pte_t){(e)})
 #define __rpte_to_pte(r)	((r).pte)
 #else
-- 
2.1.0
