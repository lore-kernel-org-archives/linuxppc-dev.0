Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A8361A0CC0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 07:46:44 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 5 Nov 2015 02:16:42 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id DFE971258019
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 02:16:39 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4KkdO725755712
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 02:16:39 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4KkbPs028085
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Nov 2015 02:16:39 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [RFC PATCH 2/3]perf/powerpc: update macros and add regs to
 arch_misc_reg struct
Date: Thu,  5 Nov 2015 02:16:17 +0530
Message-Id: <1446669978-6366-3-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1446669978-6366-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch updates the arch_misc_regs struct (arch/powerpc/ptrace.h)
with arch/powerpc specific regs (PMU regs). Updates asm/perf_regs.h and
perf_regs.c with corresponding macros to export the arch_misc_reg values.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
CC: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 Will really appreciate comments and feedback for the patch.

 arch/powerpc/include/uapi/asm/perf_regs.h   | 10 ++++++++++
 arch/powerpc/include/uapi/asm/ptrace.h      | 11 ++++++++++-
 arch/powerpc/perf/perf_regs.c               | 28 +++++++++++++++++++++++++---
 tools/perf/arch/powerpc/include/perf_regs.h | 16 ++++++++++++++++
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h b/arch/powerpc/include/uapi/asm/perf_regs.h
index 30fb601bdbb2..2d170734f47d 100644
--- a/arch/powerpc/include/uapi/asm/perf_regs.h
+++ b/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -49,6 +49,16 @@ enum perf_event_powerpc_regs {
 	PERF_REG_POWERPC_TRAP,
 	PERF_REG_POWERPC_DAR,
 	PERF_REG_POWERPC_DSISR,
+	PERF_REG_POWERPC_PMC1,
+	PERF_REG_POWERPC_PMC2,
+	PERF_REG_POWERPC_PMC3,
+	PERF_REG_POWERPC_PMC4,
+	PERF_REG_POWERPC_PMC5,
+	PERF_REG_POWERPC_PMC6,
+	PERF_REG_POWERPC_MMCR0,
+	PERF_REG_POWERPC_MMCR1,
+
 	PERF_REG_POWERPC_MAX,
+	PERF_REG_PT_REGS_END = PERF_REG_POWERPC_DSISR + 1,
 };
 #endif /* _ASM_POWERPC_PERF_REGS_H */
diff --git a/arch/powerpc/include/uapi/asm/ptrace.h b/arch/powerpc/include/uapi/asm/ptrace.h
index 0025651ab8bc..5e9b3259ef78 100644
--- a/arch/powerpc/include/uapi/asm/ptrace.h
+++ b/arch/powerpc/include/uapi/asm/ptrace.h
@@ -51,7 +51,16 @@ struct pt_regs {
 	unsigned long result;		/* Result of a system call */
 };

-struct arch_misc_regs {};
+struct arch_misc_regs {
+	unsigned long pmc1;
+	unsigned long pmc2;
+	unsigned long pmc3;
+	unsigned long pmc4;
+	unsigned long pmc5;
+	unsigned long pmc6;
+	unsigned long mmcr0;
+	unsigned long mmcr1;
+};

 #endif /* __ASSEMBLY__ */

diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index f7995b46078a..48e479c91fb2 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -8,8 +8,11 @@
 #include <asm/perf_regs.h>

 #define PT_REGS_OFFSET(id, r) [id] = offsetof(struct pt_regs, r)
+#define ARCH_REGS_OFFSET(id, r) [id] = offsetof(struct arch_misc_regs, r)

 #define REG_RESERVED (~((1ULL << PERF_REG_POWERPC_MAX) - 1))
+#define MAX_ARCH_REG_OFFSET	(offsetof(struct arch_misc_regs, mmcr1))
+

 static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
 	PT_REGS_OFFSET(PERF_REG_POWERPC_GPR0, gpr[0]),
@@ -59,15 +62,34 @@ static unsigned int pt_regs_offset[PERF_REG_POWERPC_MAX] = {
 	PT_REGS_OFFSET(PERF_REG_POWERPC_TRAP, trap),
 	PT_REGS_OFFSET(PERF_REG_POWERPC_DAR, dar),
 	PT_REGS_OFFSET(PERF_REG_POWERPC_DSISR, dsisr),
+	ARCH_REGS_OFFSET(PERF_REG_POWERPC_PMC1, pmc1),
+	ARCH_REGS_OFFSET(PERF_REG_POWERPC_PMC2, pmc2),
+	ARCH_REGS_OFFSET(PERF_REG_POWERPC_PMC3, pmc3),
+	ARCH_REGS_OFFSET(PERF_REG_POWERPC_PMC4, pmc4),
+	ARCH_REGS_OFFSET(PERF_REG_POWERPC_PMC5, pmc5),
+	ARCH_REGS_OFFSET(PERF_REG_POWERPC_PMC6, pmc6),
+	ARCH_REGS_OFFSET(PERF_REG_POWERPC_MMCR0, mmcr0),
+	ARCH_REGS_OFFSET(PERF_REG_POWERPC_MMCR1, mmcr1),
 };

-u64 perf_reg_value(struct perf_regs *p_regs, int idx)
+static inline unsigned long
+arch_regs_get_register(struct arch_misc_regs *regs, unsigned int offset)
 {
-	struct pt_regs *regs = p_regs->regs;
+	if (unlikely(offset > MAX_ARCH_REG_OFFSET))
+		return 0;
+	return *(unsigned long *)((unsigned long)regs + offset);
+}

+u64 perf_reg_value(struct perf_regs *p_regs, int idx)
+{
 	if (WARN_ON_ONCE(idx >= PERF_REG_POWERPC_MAX))
 		return 0;
-	return regs_get_register(regs, pt_regs_offset[idx]);
+
+	if (idx >= PERF_REG_PT_REGS_END)
+		return arch_regs_get_register(p_regs->arch_regs,
+							pt_regs_offset[idx]);
+	else
+		return regs_get_register(p_regs->regs, pt_regs_offset[idx]);
 }

 int perf_reg_validate(u64 mask)
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index 47307ca19c28..e0d23b274644 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -106,6 +106,22 @@ static inline const char *perf_reg_name(int id)
 		return "dar";
 	case PERF_REG_POWERPC_DSISR:
 		return "dsisr";
+	case PERF_REG_POWERPC_PMC1:
+		return "pmc1";
+	case PERF_REG_POWERPC_PMC2:
+		return "pmc2";
+	case PERF_REG_POWERPC_PMC3:
+		return "pmc3";
+	case PERF_REG_POWERPC_PMC4:
+		return "pmc4";
+	case PERF_REG_POWERPC_PMC5:
+		return "pmc5";
+	case PERF_REG_POWERPC_PMC6:
+		return "pmc6";
+	case PERF_REG_POWERPC_MMCR0:
+		return "mmcr0";
+	case PERF_REG_POWERPC_MMCR1:
+		return "mmcr1";
 	default:
 		return NULL;
 	}
--
1.9.1
