Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnKs60h4zDrhh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:02:41 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKwuxh022928
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:40 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2536xrg2sa-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:39 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:32:36 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 47521125805B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:35 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL2XdW23593204
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:33 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL2Tkk006973
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:33 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Stephane Eranian <eranian@gmail.com>,
 Russell King <linux@arm.linux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will.deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH 12/13] tool/perf: Add perf_arch_reg mask and arch_reg_names
 structure
Date: Mon, 29 Aug 2016 02:30:57 +0530
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472418058-28659-13-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add arch_reg_names structure and define perf_arch_reg_name() function
to aid the printing of arch_regs values. Also, extend regs_dump__printf()
to include perf_arch_regs_mask to enable printing support.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Stephane Eranian <eranian@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 tools/perf/arch/arm/include/perf_regs.h     |  5 +++++
 tools/perf/arch/arm64/include/perf_regs.h   |  5 +++++
 tools/perf/arch/powerpc/include/perf_regs.h | 25 +++++++++++++++++++++++++
 tools/perf/arch/x86/include/perf_regs.h     |  5 +++++
 tools/perf/builtin-script.c                 |  7 +++++++
 tools/perf/util/perf_regs.h                 |  5 +++++
 tools/perf/util/session.c                   | 12 ++++++++++--
 7 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/tools/perf/arch/arm/include/perf_regs.h b/tools/perf/arch/arm/include/perf_regs.h
index f619c9c5a4bf..db5a5f0ad439 100644
--- a/tools/perf/arch/arm/include/perf_regs.h
+++ b/tools/perf/arch/arm/include/perf_regs.h
@@ -56,4 +56,9 @@ static inline const char *perf_reg_name(int id)
 	return NULL;
 }
 
+static inline const char *perf_arch_reg_name(int id __maybe_unused)
+{
+	return NULL;
+}
+
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
index 4e5af27e3fbf..20f8067b3e93 100644
--- a/tools/perf/arch/arm64/include/perf_regs.h
+++ b/tools/perf/arch/arm64/include/perf_regs.h
@@ -90,4 +90,9 @@ static inline const char *perf_reg_name(int id)
 	return NULL;
 }
 
+static inline const char *perf_arch_reg_name(int id __maybe_unused)
+{
+	return NULL;
+}
+
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index 75de0e92e71e..801de6def8da 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -4,6 +4,7 @@
 #include <stdlib.h>
 #include <linux/types.h>
 #include <asm/perf_regs.h>
+#include <uapi/asm/perf_regs.h>
 
 #define PERF_REGS_MASK  ((1ULL << PERF_REG_POWERPC_MAX) - 1)
 #define PERF_REGS_MAX   PERF_REG_POWERPC_MAX
@@ -66,4 +67,28 @@ static inline const char *perf_reg_name(int id)
 {
 	return reg_names[id];
 }
+
+static const char *arch_reg_names[] = {
+	[PERF_ARCH_REG_POWERPC_PVR] = "pvr",
+	[PERF_ARCH_REG_POWERPC_PMC1] = "pmc1",
+	[PERF_ARCH_REG_POWERPC_PMC2] = "pmc2",
+	[PERF_ARCH_REG_POWERPC_PMC3] = "pmc3",
+	[PERF_ARCH_REG_POWERPC_PMC4] = "pmc4",
+	[PERF_ARCH_REG_POWERPC_PMC5] = "pmc5",
+	[PERF_ARCH_REG_POWERPC_PMC6] = "pmc6",
+	[PERF_ARCH_REG_POWERPC_PMC7] = "pmc7",
+	[PERF_ARCH_REG_POWERPC_PMC8] = "pmc8",
+	[PERF_ARCH_REG_POWERPC_MMCR0] = "mmcr0",
+	[PERF_ARCH_REG_POWERPC_MMCR1] = "mmcr1",
+	[PERF_ARCH_REG_POWERPC_SIER] = "sier",
+	[PERF_ARCH_REG_POWERPC_SIAR] = "siar",
+	[PERF_ARCH_REG_POWERPC_SDAR] = "sdar",
+	[PERF_ARCH_REG_POWERPC_MMCRA] = "mmcra",
+	[PERF_ARCH_REG_POWERPC_MMCR2] = "mmcr2"
+};
+
+static inline const char *perf_arch_reg_name(int id)
+{
+	return arch_reg_names[id];
+}
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index 7df517acfef8..a555541697b3 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -83,4 +83,9 @@ static inline const char *perf_reg_name(int id)
 	return NULL;
 }
 
+static inline const char *perf_arch_reg_name(int id __maybe_unused)
+{
+	return NULL;
+}
+
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index db270b4f892a..c2a84484b95b 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -420,6 +420,7 @@ static void print_sample_iregs(struct perf_sample *sample,
 {
 	struct regs_dump *regs = &sample->intr_regs;
 	uint64_t mask = attr->sample_regs_intr;
+	uint64_t arch_regs_mask = regs->arch_regs_mask;
 	unsigned i = 0, r;
 	DECLARE_BITMAP(_mask, 64);
 
@@ -431,6 +432,12 @@ static void print_sample_iregs(struct perf_sample *sample,
 		u64 val = regs->regs[i++];
 		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
+
+	bitmap_from_u64(_mask, arch_regs_mask);
+	for_each_set_bit(r, _mask, sizeof(mask) * 8) {
+		u64 val = regs->regs[i++];
+		printf("%5s:0x%"PRIx64" ", perf_arch_reg_name(r), val);
+	}
 }
 
 static void print_sample_start(struct perf_sample *sample,
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 679d6e493962..1a044728bd45 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -29,6 +29,11 @@ static inline const char *perf_reg_name(int id __maybe_unused)
 	return NULL;
 }
 
+static inline const char *perf_arch_reg_name(int id __maybe_unused)
+{
+	return NULL;
+}
+
 static inline int perf_reg_value(u64 *valp __maybe_unused,
 				 struct regs_dump *regs __maybe_unused,
 				 int id __maybe_unused)
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 440a9fb2a6fb..ca5c057c88af 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -941,7 +941,7 @@ static void branch_stack__printf(struct perf_sample *sample)
 	}
 }
 
-static void regs_dump__printf(u64 mask, u64 *regs)
+static void regs_dump__printf(u64 mask, u64 arch_regs_mask, u64 *regs)
 {
 	unsigned rid, i = 0;
 	DECLARE_BITMAP(_mask, 64);
@@ -953,6 +953,14 @@ static void regs_dump__printf(u64 mask, u64 *regs)
 		printf(".... %-5s 0x%" PRIx64 "\n",
 		       perf_reg_name(rid), val);
 	}
+
+	bitmap_from_u64(_mask, arch_regs_mask);
+	for_each_set_bit(rid, _mask, sizeof(mask) * 8) {
+		u64 val = regs[i++];
+
+		printf(".... %-5s 0x%" PRIx64 "\n",
+			perf_arch_reg_name(rid), val);
+	}
 }
 
 static const char *regs_abi[] = {
@@ -978,7 +986,7 @@ static void regs__printf(const char *type, struct regs_dump *regs)
 	       mask,
 	       regs_dump_abi(regs));
 
-	regs_dump__printf(mask, regs->regs);
+	regs_dump__printf(mask, regs->arch_regs_mask, regs->regs);
 }
 
 static void regs_user__printf(struct perf_sample *sample)
-- 
2.7.4
