Return-Path: <anju@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5D22D1A11B5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 16:18:31 +1100 (AEDT)
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 14 Dec 2015 15:18:29 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 07CE12CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 16:18:22 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBE5IFip26148868
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 16:18:23 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBE5Hm0C030475
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 16:17:49 +1100
From: Anju T <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: khandual@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com,
 acme@redhat.com, maddy@linux.vnet.ibm.com, dsahern@gmail.com,
 jolsa@redhat.com, anju@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH V1 4/4] tool/perf: Add sample_reg_mask to include all
 perf_regs regs
Date: Mon, 14 Dec 2015 10:47:16 +0530
Message-Id: <1450070236-3461-5-git-send-email-anju@linux.vnet.ibm.com>
In-Reply-To: <1450070236-3461-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1450070236-3461-1-git-send-email-anju@linux.vnet.ibm.com>
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
 tools/perf/arch/powerpc/util/perf_regs.c | 48 ++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)
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
index 0000000..0b0ec65
--- /dev/null
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -0,0 +1,48 @@
+#include "../../perf.h"
+#include "../../util/perf_regs.h"
+
+const struct sample_reg sample_reg_masks[] = {
+	SMPL_REG(gpr0, PERF_REG_POWERPC_GPR0),
+	SMPL_REG(gpr1, PERF_REG_POWERPC_GPR1),
+	SMPL_REG(gpr2, PERF_REG_POWERPC_GPR2),
+	SMPL_REG(gpr3, PERF_REG_POWERPC_GPR3),
+	SMPL_REG(gpr4, PERF_REG_POWERPC_GPR4),
+	SMPL_REG(gpr5, PERF_REG_POWERPC_GPR5),
+	SMPL_REG(gpr6, PERF_REG_POWERPC_GPR6),
+	SMPL_REG(gpr7, PERF_REG_POWERPC_GPR7),
+	SMPL_REG(gpr8, PERF_REG_POWERPC_GPR8),
+	SMPL_REG(gpr9, PERF_REG_POWERPC_GPR9),
+	SMPL_REG(gpr10, PERF_REG_POWERPC_GPR10),
+	SMPL_REG(gpr11, PERF_REG_POWERPC_GPR11),
+	SMPL_REG(gpr12, PERF_REG_POWERPC_GPR12),
+	SMPL_REG(gpr13, PERF_REG_POWERPC_GPR13),
+	SMPL_REG(gpr14, PERF_REG_POWERPC_GPR14),
+	SMPL_REG(gpr15, PERF_REG_POWERPC_GPR15),
+	SMPL_REG(gpr16, PERF_REG_POWERPC_GPR16),
+	SMPL_REG(gpr17, PERF_REG_POWERPC_GPR17),
+	SMPL_REG(gpr18, PERF_REG_POWERPC_GPR18),
+	SMPL_REG(gpr19, PERF_REG_POWERPC_GPR19),
+	SMPL_REG(gpr20, PERF_REG_POWERPC_GPR20),
+	SMPL_REG(gpr21, PERF_REG_POWERPC_GPR21),
+	SMPL_REG(gpr22, PERF_REG_POWERPC_GPR22),
+	SMPL_REG(gpr23, PERF_REG_POWERPC_GPR23),
+	SMPL_REG(gpr24, PERF_REG_POWERPC_GPR24),
+	SMPL_REG(gpr25, PERF_REG_POWERPC_GPR25),
+	SMPL_REG(gpr26, PERF_REG_POWERPC_GPR26),
+	SMPL_REG(gpr27, PERF_REG_POWERPC_GPR27),
+	SMPL_REG(gpr28, PERF_REG_POWERPC_GPR28),
+	SMPL_REG(gpr29, PERF_REG_POWERPC_GPR29),
+	SMPL_REG(gpr30, PERF_REG_POWERPC_GPR30),
+	SMPL_REG(gpr31, PERF_REG_POWERPC_GPR31),
+	SMPL_REG(nip, PERF_REG_POWERPC_NIP),
+	SMPL_REG(msr, PERF_REG_POWERPC_MSR),
+	SMPL_REG(orig_r3, PERF_REG_POWERPC_ORIG_R3),
+	SMPL_REG(ctr, PERF_REG_POWERPC_CTR),
+	SMPL_REG(link, PERF_REG_POWERPC_LNK),
+	SMPL_REG(xer, PERF_REG_POWERPC_XER),
+	SMPL_REG(ccr, PERF_REG_POWERPC_CCR),
+	SMPL_REG(trap, PERF_REG_POWERPC_TRAP),
+	SMPL_REG(dar, PERF_REG_POWERPC_DAR),
+	SMPL_REG(dsisr, PERF_REG_POWERPC_DSISR),
+	SMPL_REG_END
+};
-- 
2.1.0
