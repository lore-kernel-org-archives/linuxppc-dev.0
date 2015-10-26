Return-Path: <anju@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 30B191A0AA4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:45:12 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Mon, 26 Oct 2015 22:45:11 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 9BAB72BB0052
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:45:08 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9QCitET26083410
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:45:03 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9QCiZDh004699
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 23:44:36 +1100
From: Anju T <anju@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: sukadev@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, jolsa@redhat.com,
 dsahern@gmail.com, acme@redhat.com, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com
Subject: [PATCH V2 2/3] tools/perf:Map the ID values with register names
Date: Mon, 26 Oct 2015 18:14:07 +0530
Message-Id: <1445863448-5746-3-git-send-email-anju@linux.vnet.ibm.com>
In-Reply-To: <1445863448-5746-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1445863448-5746-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The id values are mapped with the corresponding register names.
This names are displayed while using a perf report/perf script command.

Signed-off-by: Anju T <anju@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/include/perf_regs.h | 118 ++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)
 create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h

diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
new file mode 100644
index 0000000..621aa94
--- /dev/null
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -0,0 +1,118 @@
+#ifndef ARCH_PERF_REGS_H
+#define ARCH_PERF_REGS_H
+
+#include <stdlib.h>
+#include <linux/types.h>
+#include <asm/perf_regs.h>
+
+void perf_regs_load(u64 *regs);
+
+#define PERF_REGS_MASK  ((1ULL << PERF_REG_POWERPC_MAX) - 1)
+#define PERF_REGS_MAX   PERF_REG_POWERPC_MAX
+#define PERF_SAMPLE_REGS_ABI   PERF_SAMPLE_REGS_ABI_64
+
+#define PERF_REG_IP     PERF_REG_POWERPC_NIP
+#define PERF_REG_SP     PERF_REG_POWERPC_R1
+
+static inline const char *perf_reg_name(int id)
+{
+	switch (id) {
+	case PERF_REG_POWERPC_GPR0:
+		return "gpr0";
+	case PERF_REG_POWERPC_GPR1:
+		return "gpr1";
+	case PERF_REG_POWERPC_GPR2:
+		return "gpr2";
+	case PERF_REG_POWERPC_GPR3:
+		return "gpr3";
+	case PERF_REG_POWERPC_GPR4:
+		return "gpr4";
+	case PERF_REG_POWERPC_GPR5:
+		return "gpr5";
+	case PERF_REG_POWERPC_GPR6:
+		return "gpr6";
+	case PERF_REG_POWERPC_GPR7:
+		return "gpr7";
+	case PERF_REG_POWERPC_GPR8:
+		return "gpr8";
+	case PERF_REG_POWERPC_GPR9:
+		return "gpr9";
+	case PERF_REG_POWERPC_GPR10:
+		return "gpr10";
+	case PERF_REG_POWERPC_GPR11:
+		return "gpr11";
+	case PERF_REG_POWERPC_GPR12:
+		return "gpr12";
+	case PERF_REG_POWERPC_GPR13:
+		return "gpr13";
+	case PERF_REG_POWERPC_GPR14:
+		return "gpr14";
+	case PERF_REG_POWERPC_GPR15:
+		return "gpr15";
+	case PERF_REG_POWERPC_GPR16:
+		return "gpr16";
+	case PERF_REG_POWERPC_GPR17:
+		return "gpr17";
+	case PERF_REG_POWERPC_GPR18:
+		return "gpr18";
+	case PERF_REG_POWERPC_GPR19:
+		return "gpr19";
+	case PERF_REG_POWERPC_GPR20:
+		return "gpr20";
+	case PERF_REG_POWERPC_GPR21:
+		return "gpr21";
+	case PERF_REG_POWERPC_GPR22:
+		return "gpr22";
+	case PERF_REG_POWERPC_GPR23:
+		return "gpr23";
+	case PERF_REG_POWERPC_GPR24:
+		return "gpr24";
+	case PERF_REG_POWERPC_GPR25:
+		return "gpr25";
+	case PERF_REG_POWERPC_GPR26:
+		return "gpr26";
+	case PERF_REG_POWERPC_GPR27:
+		return "gpr27";
+	case PERF_REG_POWERPC_GPR28:
+		return "gpr28";
+	case PERF_REG_POWERPC_GPR29:
+		return "gpr29";
+	case PERF_REG_POWERPC_GPR30:
+		return "gpr30";
+	case PERF_REG_POWERPC_GPR31:
+		return "gpr31";
+	case PERF_REG_POWERPC_NIP:
+		return "nip";
+	case PERF_REG_POWERPC_MSR:
+		return "msr";
+	case PERF_REG_POWERPC_ORIG_R3:
+		return "orig_r3";
+	case PERF_REG_POWERPC_CTR:
+		return "ctr";
+	case PERF_REG_POWERPC_LNK:
+		return "link";
+	case PERF_REG_POWERPC_XER:
+		return "xer";
+	case PERF_REG_POWERPC_CCR:
+		return "ccr";
+#ifdef __powerpc64__
+	case PERF_REG_POWERPC_SOFTE:
+		return "softe";
+#else
+	case PERF_REG_POWERPC_MQ:
+		return "mq";
+#endif
+	case PERF_REG_POWERPC_TRAP:
+		return "trap";
+	case PERF_REG_POWERPC_DAR:
+		return "dar";
+	case PERF_REG_POWERPC_DSISR:
+		return "dsisr";
+	case PERF_REG_POWERPC_RESULT:
+		return "result";
+	default:
+		return NULL;
+	}
+	return NULL;
+}
+#endif /*ARCH_PERF_REGS_H */
-- 
2.1.0
