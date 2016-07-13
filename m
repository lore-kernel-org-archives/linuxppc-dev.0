Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rq7Cq5vXzzDqFP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:07 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D5i1UF045269
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 01:48:05 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452yp6bx5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 01:48:05 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 13 Jul 2016 15:48:02 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 955D12BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:00 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6D5m08f18284608
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:00 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6D5lxDT004289
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 15:48:00 +1000
From: alastair@au1.ibm.com
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, paulus@samba.org, herbert@gondor.apana.org.au,
 davem@davemloft.net, linuxppc-dev@lists.ozlabs.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH 1/2] Allow drivers to be autoloaded.
Date: Wed, 13 Jul 2016 15:47:17 +1000
In-Reply-To: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
References: <1468388840-12068-1-git-send-email-alastair@au1.ibm.com>
Message-Id: <1468388840-12068-2-git-send-email-alastair@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

This patch provides the necessary infrastructure to allow drivers
to be automatically loaded via UDEV. It implements the minimum
required to be able to use module_cpu_feature_match to trigger
the GENERIC_CPU_AUTOPROBE mechanisms.

The features exposed are a mirror of the cpu_user_features
(converted to an offset from a mask). This decision was made to
ensure that the behavior between features for module loading and
userspace are consistent.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 arch/powerpc/Kconfig                  |  1 +
 arch/powerpc/include/asm/cpufeature.h | 68 +++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 arch/powerpc/include/asm/cpufeature.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 0a9d439..a6e49db 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -164,6 +164,7 @@ config PPC
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT
 	select HAVE_LIVEPATCH if HAVE_DYNAMIC_FTRACE_WITH_REGS
+	select GENERIC_CPU_AUTOPROBE
 
 config GENERIC_CSUM
 	def_bool CPU_LITTLE_ENDIAN
diff --git a/arch/powerpc/include/asm/cpufeature.h b/arch/powerpc/include/asm/cpufeature.h
new file mode 100644
index 0000000..6d52527
--- /dev/null
+++ b/arch/powerpc/include/asm/cpufeature.h
@@ -0,0 +1,68 @@
+/*
+ * Copyright 2016 Alastair D'Silva, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef __ASM_CPUFEATURE_H
+#define __ASM_CPUFEATURE_H
+
+#include <asm/cputable.h>
+
+/* Keep these in step with powerpc/include/asm/cputable.h */
+#define MAX_CPU_FEATURES (2 * 32)
+
+#define PPC_MODULE_FEATURE_32				(ilog2(PPC_FEATURE_32))
+#define PPC_MODULE_FEATURE_64				(ilog2(PPC_FEATURE_64))
+#define PPC_MODULE_FEATURE_601_INSTR			(ilog2(PPC_FEATURE_601_INSTR))
+#define PPC_MODULE_FEATURE_HAS_ALTIVEC			(ilog2(PPC_FEATURE_HAS_ALTIVEC))
+#define PPC_MODULE_FEATURE_HAS_FPU			(ilog2(PPC_FEATURE_HAS_FPU))
+#define PPC_MODULE_FEATURE_HAS_MMU			(ilog2(PPC_FEATURE_HAS_MMU))
+#define PPC_MODULE_FEATURE_HAS_4xxMAC			(ilog2(PPC_FEATURE_HAS_4xxMAC))
+#define PPC_MODULE_FEATURE_UNIFIED_CACHE		ilog2(PPC_FEATURE_UNIFIED_CACHE))
+#define PPC_MODULE_FEATURE_HAS_SPE			(ilog2(PPC_FEATURE_HAS_SPE))
+#define PPC_MODULE_FEATURE_HAS_EFP_SINGLE		(ilog2(PPC_FEATURE_HAS_EFP_SINGLE))
+#define PPC_MODULE_FEATURE_HAS_EFP_DOUBLE		(ilog2(PPC_FEATURE_HAS_EFP_DOUBLE))
+#define PPC_MODULE_FEATURE_NO_TB			(ilog2(PPC_FEATURE_NO_TB))
+#define PPC_MODULE_FEATURE_POWER4			(ilog2(PPC_FEATURE_POWER4))
+#define PPC_MODULE_FEATURE_POWER5			(ilog2(PPC_FEATURE_POWER5))
+#define PPC_MODULE_FEATURE_POWER5_PLUS			(ilog2(PPC_FEATURE_POWER5_PLUS))
+#define PPC_MODULE_FEATURE_CELL				(ilog2(PPC_FEATURE_CELL))
+#define PPC_MODULE_FEATURE_BOOKE			(ilog2(PPC_FEATURE_BOOKE))
+#define PPC_MODULE_FEATURE_SMT				(ilog2(PPC_FEATURE_SMT))
+#define PPC_MODULE_FEATURE_ICACHE_SNOOP			(ilog2(PPC_FEATURE_ICACHE_SNOOP))
+#define PPC_MODULE_FEATURE_ARCH_2_05			(ilog2(PPC_FEATURE_ARCH_2_05))
+#define PPC_MODULE_FEATURE_PA6T				(ilog2(PPC_FEATURE_PA6T))
+#define PPC_MODULE_FEATURE_HAS_DFP			(ilog2(PPC_FEATURE_HAS_DFP))
+#define PPC_MODULE_FEATURE_POWER6_EXT			(ilog2(PPC_FEATURE_POWER6_EXT))
+#define PPC_MODULE_FEATURE_ARCH_2_06			(ilog2(PPC_FEATURE_ARCH_2_06))
+#define PPC_MODULE_FEATURE_HAS_VSX			(ilog2(PPC_FEATURE_HAS_VSX))
+#define PPC_MODULE_FEATURE_PSERIES_PERFMON_COMPAT	(ilog2(PPC_FEATURE_PSERIES_PERFMON_COMPAT))
+#define PPC_MODULE_FEATURE_TRUE_LE			(ilog2(PPC_FEATURE_TRUE_LE))
+#define PPC_MODULE_FEATURE_PPC_LE			(ilog2(PPC_FEATURE_PPC_LE))
+
+#define PPC_MODULE_FEATURE_ARCH_2_07			(32 + ilog2(PPC_FEATURE2_ARCH_2_07))
+#define PPC_MODULE_FEATURE_HTM				(32 + ilog2(PPC_FEATURE2_HTM))
+#define PPC_MODULE_FEATURE_DSCR				(32 + ilog2(PPC_FEATURE2_DSCR))
+#define PPC_MODULE_FEATURE_EBB				(32 + ilog2(PPC_FEATURE2_EBB))
+#define PPC_MODULE_FEATURE_ISEL				(32 + ilog2(PPC_FEATURE2_ISEL))
+#define PPC_MODULE_FEATURE_TAR				(32 + ilog2(PPC_FEATURE2_TAR))
+#define PPC_MODULE_FEATURE_VEC_CRYPTO			(32 + ilog2(PPC_FEATURE2_VEC_CRYPTO))
+#define PPC_MODULE_FEATURE_HTM_NOSC			(32 + ilog2(PPC_FEATURE2_HTM_NOSC))
+#define PPC_MODULE_FEATURE_ARCH_3_00			(32 + ilog2(PPC_FEATURE2_ARCH_3_00))
+#define PPC_MODULE_FEATURE_HAS_IEEE128			(32 + ilog2(PPC_FEATURE2_HAS_IEEE128))
+
+#define cpu_feature(x)		(x)
+
+static inline bool cpu_have_feature(unsigned int num)
+{
+	if (num < 32)
+		return !!(cur_cpu_spec->cpu_user_features & 1UL << num);
+	else
+		return !!(cur_cpu_spec->cpu_user_features2 & 1UL << (num - 32));
+}
+
+#endif
-- 
2.7.4
