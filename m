Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x244.google.com (mail-pa0-x244.google.com
 [IPv6:2607:f8b0:400e:c03::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3swK6c2SSxzDt2k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 18:31:52 +1100 (AEDT)
Received: by mail-pa0-x244.google.com with SMTP id hh10so5775538pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2016 00:31:52 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH v2] powerpc/64: option to force run-at-load to test relocation
Date: Fri, 14 Oct 2016 18:31:33 +1100
Message-Id: <20161014073133.24548-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This adds a config option that can help exercise the case when
the kernel is not running at PAGE_OFFSET.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
Changes since v1:
- Improved style as suggested by Balbir and Michael

 arch/powerpc/Kconfig          | 9 +++++++++
 arch/powerpc/kernel/head_64.S | 8 +++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 65fba4c..5d43cb8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -478,6 +478,15 @@ config RELOCATABLE
 	  setting can still be useful to bootwrappers that need to know the
 	  load address of the kernel (eg. u-boot/mkimage).
 
+config RELOCATABLE_TEST
+	bool "Test relocatable kernel"
+	depends on (PPC64 && RELOCATABLE)
+	default n
+	help
+	  This runs the relocatable kernel at the address it was initially
+	  loaded at, which tends to be non-zero and therefore test the
+	  relocation code.
+
 config CRASH_DUMP
 	bool "Build a kdump crash kernel"
 	depends on PPC64 || 6xx || FSL_BOOKE || (44x && !SMP)
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 79da0641..a0aaced 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -107,11 +107,17 @@ __secondary_hold_acknowledge:
 	 * observing the alignment requirement.
 	 */
 	/* Do not move this variable as kexec-tools knows about it. */
+#ifdef CONFIG_RELOCATABLE_TEST
+#define RUN_AT_LOAD_DEFAULT 1		/* Test relocation, do not copy to 0 */
+#else
+#define RUN_AT_LOAD_DEFAULT 0x72756e30  /* "run0" -- relocate to 0 by default */
+#endif
+
 	. = 0x5c
 	.globl	__run_at_load
 __run_at_load:
 DEFINE_FIXED_SYMBOL(__run_at_load)
-	.long	0x72756e30	/* "run0" -- relocate to 0 by default */
+	.long	RUN_AT_LOAD_DEFAULT
 #endif
 
 	. = 0x60
-- 
2.9.3
