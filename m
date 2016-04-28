Return-Path: <chandan.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwWmW45nZzDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 19:31:23 +1000 (AEST)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan.kumar@linux.vnet.ibm.com>;
 Thu, 28 Apr 2016 03:31:21 -0600
From: Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: acme@redhat.com, mpe@ellerman.id.au, jolsa@redhat.com,
 anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>
Subject: [PATCH 2/3] powerpc/perf: Add support for unwinding perf-stackdump
Date: Thu, 28 Apr 2016 15:01:09 +0530
Message-Id: <1461835870-67778-3-git-send-email-chandan.kumar@linux.vnet.ibm.com>
In-Reply-To: <1461835870-67778-1-git-send-email-chandan.kumar@linux.vnet.ibm.com>
References: <1461835870-67778-1-git-send-email-chandan.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds support for unwinding user stack dump by linking with libunwind.

Signed-off-by: Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/Build              |  1 +
 tools/perf/arch/powerpc/util/unwind-libunwind.c | 96 +++++++++++++++++++++++++
 tools/perf/config/Makefile                      |  1 +
 3 files changed, 98 insertions(+)
 create mode 100644 tools/perf/arch/powerpc/util/unwind-libunwind.c

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 9ee3350..90ad64b 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -5,3 +5,4 @@ libperf-y += perf_regs.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
+libperf-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/powerpc/util/unwind-libunwind.c b/tools/perf/arch/powerpc/util/unwind-libunwind.c
new file mode 100644
index 0000000..9e15f92
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/unwind-libunwind.c
@@ -0,0 +1,96 @@
+/*
+ * Copyright 2016 Chandan Kumar, IBM Corporation.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <errno.h>
+#include <libunwind.h>
+#include <asm/perf_regs.h>
+#include "../../util/unwind.h"
+#include "../../util/debug.h"
+
+int libunwind__arch_reg_id(int regnum)
+{
+	switch (regnum) {
+	case UNW_PPC64_R0:
+		return PERF_REG_POWERPC_R0;
+	case UNW_PPC64_R1:
+		return PERF_REG_POWERPC_R1;
+	case UNW_PPC64_R2:
+		return PERF_REG_POWERPC_R2;
+	case UNW_PPC64_R3:
+		return PERF_REG_POWERPC_R3;
+	case UNW_PPC64_R4:
+		return PERF_REG_POWERPC_R4;
+	case UNW_PPC64_R5:
+		return PERF_REG_POWERPC_R5;
+	case UNW_PPC64_R6:
+		return PERF_REG_POWERPC_R6;
+	case UNW_PPC64_R7:
+		return PERF_REG_POWERPC_R7;
+	case UNW_PPC64_R8:
+		return PERF_REG_POWERPC_R8;
+	case UNW_PPC64_R9:
+		return PERF_REG_POWERPC_R9;
+	case UNW_PPC64_R10:
+		return PERF_REG_POWERPC_R10;
+	case UNW_PPC64_R11:
+		return PERF_REG_POWERPC_R11;
+	case UNW_PPC64_R12:
+		return PERF_REG_POWERPC_R12;
+	case UNW_PPC64_R13:
+		return PERF_REG_POWERPC_R13;
+	case UNW_PPC64_R14:
+		return PERF_REG_POWERPC_R14;
+	case UNW_PPC64_R15:
+		return PERF_REG_POWERPC_R15;
+	case UNW_PPC64_R16:
+		return PERF_REG_POWERPC_R16;
+	case UNW_PPC64_R17:
+		return PERF_REG_POWERPC_R17;
+	case UNW_PPC64_R18:
+		return PERF_REG_POWERPC_R18;
+	case UNW_PPC64_R19:
+		return PERF_REG_POWERPC_R19;
+	case UNW_PPC64_R20:
+		return PERF_REG_POWERPC_R20;
+	case UNW_PPC64_R21:
+		return PERF_REG_POWERPC_R21;
+	case UNW_PPC64_R22:
+		return PERF_REG_POWERPC_R22;
+	case UNW_PPC64_R23:
+		return PERF_REG_POWERPC_R23;
+	case UNW_PPC64_R24:
+		return PERF_REG_POWERPC_R24;
+	case UNW_PPC64_R25:
+		return PERF_REG_POWERPC_R25;
+	case UNW_PPC64_R26:
+		return PERF_REG_POWERPC_R26;
+	case UNW_PPC64_R27:
+		return PERF_REG_POWERPC_R27;
+	case UNW_PPC64_R28:
+		return PERF_REG_POWERPC_R28;
+	case UNW_PPC64_R29:
+		return PERF_REG_POWERPC_R29;
+	case UNW_PPC64_R30:
+		return PERF_REG_POWERPC_R30;
+	case UNW_PPC64_R31:
+		return PERF_REG_POWERPC_R31;
+	case UNW_PPC64_LR:
+		return PERF_REG_POWERPC_LINK;
+	case UNW_PPC64_CTR:
+		return PERF_REG_POWERPC_CTR;
+	case UNW_PPC64_XER:
+		return PERF_REG_POWERPC_XER;
+	case UNW_PPC64_NIP:
+		return PERF_REG_POWERPC_NIP;
+	default:
+		pr_err("unwind: invalid reg id %d\n", regnum);
+		return -EINVAL;
+	}
+	return -EINVAL;
+}
diff --git a/tools/perf/config/Makefile b/tools/perf/config/Makefile
index eda1cfb..220536c 100644
--- a/tools/perf/config/Makefile
+++ b/tools/perf/config/Makefile
@@ -26,6 +26,7 @@ NO_PERF_REGS := 1
 # Additional ARCH settings for ppc
 ifeq ($(ARCH),powerpc)
   NO_PERF_REGS := 0
+  LIBUNWIND_LIBS := -lunwind -lunwind-ppc64
 endif
 
 # Additional ARCH settings for x86
-- 
1.9.3
