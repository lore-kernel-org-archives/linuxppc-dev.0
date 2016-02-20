Return-Path: <anju@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 176851A0920
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:04:44 +1100 (AEDT)
Received: from localhost
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Sat, 20 Feb 2016 15:04:43 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0C3B42CE8054
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:04:41 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1K54Xpl65601558
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:04:41 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1K548Vv002040
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 16:04:08 +1100
From: Anju T <anju@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: mpe@ellerman.id.au, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, sukadev@linux.vnet.ibm.com,
 hemant@linux.vnet.ibm.com, naveen.n.rao@linux.vnet.ibm.com,
 anju@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V2 4/4] tool/perf: Add sample_reg_mask to include all perf_regs
Date: Sat, 20 Feb 2016 10:32:48 +0530
Message-Id: <1455944568-7231-5-git-send-email-anju@linux.vnet.ibm.com>
In-Reply-To: <1455944568-7231-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1455944568-7231-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>

Add sample_reg_mask array with pt_regs registers.
This is needed for printing supported regs ( -I? option).

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/Build       |  1 +
 tools/perf/arch/powerpc/util/perf_regs.c | 49 ++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
 create mode 100644 tools/perf/arch/powerpc/util/perf_regs.c

diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 7b8b0d1..3deb1bc 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -1,5 +1,6 @@
 libperf-y += header.o
 libperf-y += sym-handling.o
+libperf-y += perf_regs.o
 
 libperf-$(CONFIG_DWARF) += dwarf-regs.o
 libperf-$(CONFIG_DWARF) += skip-callchain-idx.o
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
new file mode 100644
index 0000000..df9db75
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -0,0 +1,49 @@
+#include "../../perf.h"
+#include "../../util/perf_regs.h"
+
+const struct sample_reg sample_reg_masks[] = {
+	SMPL_REG(r0, PERF_REG_POWERPC_R0),
+	SMPL_REG(r1, PERF_REG_POWERPC_R1),
+	SMPL_REG(r2, PERF_REG_POWERPC_R2),
+	SMPL_REG(r3, PERF_REG_POWERPC_R3),
+	SMPL_REG(r4, PERF_REG_POWERPC_R4),
+	SMPL_REG(r5, PERF_REG_POWERPC_R5),
+	SMPL_REG(r6, PERF_REG_POWERPC_R6),
+	SMPL_REG(r7, PERF_REG_POWERPC_R7),
+	SMPL_REG(r8, PERF_REG_POWERPC_R8),
+	SMPL_REG(r9, PERF_REG_POWERPC_R9),
+	SMPL_REG(r10, PERF_REG_POWERPC_R10),
+	SMPL_REG(r11, PERF_REG_POWERPC_R11),
+	SMPL_REG(r12, PERF_REG_POWERPC_R12),
+	SMPL_REG(r13, PERF_REG_POWERPC_R13),
+	SMPL_REG(r14, PERF_REG_POWERPC_R14),
+	SMPL_REG(r15, PERF_REG_POWERPC_R15),
+	SMPL_REG(r16, PERF_REG_POWERPC_R16),
+	SMPL_REG(r17, PERF_REG_POWERPC_R17),
+	SMPL_REG(r18, PERF_REG_POWERPC_R18),
+	SMPL_REG(r19, PERF_REG_POWERPC_R19),
+	SMPL_REG(r20, PERF_REG_POWERPC_R20),
+	SMPL_REG(r21, PERF_REG_POWERPC_R21),
+	SMPL_REG(r22, PERF_REG_POWERPC_R22),
+	SMPL_REG(r23, PERF_REG_POWERPC_R23),
+	SMPL_REG(r24, PERF_REG_POWERPC_R24),
+	SMPL_REG(r25, PERF_REG_POWERPC_R25),
+	SMPL_REG(r26, PERF_REG_POWERPC_R26),
+	SMPL_REG(r27, PERF_REG_POWERPC_R27),
+	SMPL_REG(r28, PERF_REG_POWERPC_R28),
+	SMPL_REG(r29, PERF_REG_POWERPC_R29),
+	SMPL_REG(r30, PERF_REG_POWERPC_R30),
+	SMPL_REG(r31, PERF_REG_POWERPC_R31),
+	SMPL_REG(nip, PERF_REG_POWERPC_NIP),
+	SMPL_REG(msr, PERF_REG_POWERPC_MSR),
+	SMPL_REG(orig_r3, PERF_REG_POWERPC_ORIG_R3),
+	SMPL_REG(ctr, PERF_REG_POWERPC_CTR),
+	SMPL_REG(link, PERF_REG_POWERPC_LNK),
+	SMPL_REG(xer, PERF_REG_POWERPC_XER),
+	SMPL_REG(ccr, PERF_REG_POWERPC_CCR),
+	SMPL_REG(softe, PERF_REG_POWERPC_SOFTE),
+	SMPL_REG(trap, PERF_REG_POWERPC_TRAP),
+	SMPL_REG(dar, PERF_REG_POWERPC_DAR),
+	SMPL_REG(dsisr, PERF_REG_POWERPC_DSISR),
+	SMPL_REG_END
+};
-- 
2.1.0
