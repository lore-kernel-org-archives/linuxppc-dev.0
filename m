Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnL02zb6zDrh6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:02:48 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKx744131843
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:46 -0400
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2537c9funt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:46 -0400
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:32:42 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 0B851394004E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:40 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL2dK420840674
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:39 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL2aaa007117
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:39 +0530
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
Subject: [PATCH 13/13] powerpc/perf: Add support to dump only arch_regs
Date: Mon, 29 Aug 2016 02:30:58 +0530
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472418058-28659-14-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf tool provides us an option to selective dump intr_regs.
Add arch_regs option to it.

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
 arch/powerpc/include/uapi/asm/perf_regs.h       | 1 +
 arch/powerpc/perf/perf_regs.c                   | 3 +++
 tools/arch/powerpc/include/uapi/asm/perf_regs.h | 1 +
 tools/perf/arch/powerpc/include/perf_regs.h     | 3 ++-
 tools/perf/arch/powerpc/util/perf_regs.c        | 1 +
 5 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h b/arch/powerpc/include/uapi/asm/perf_regs.h
index e8f5553a61d1..cbf1c7521ea5 100644
--- a/arch/powerpc/include/uapi/asm/perf_regs.h
+++ b/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -45,6 +45,7 @@ enum perf_event_powerpc_regs {
 	PERF_REG_POWERPC_TRAP,
 	PERF_REG_POWERPC_DAR,
 	PERF_REG_POWERPC_DSISR,
+	PERF_REG_POWERPC_ARCH_REGS,
 	PERF_REG_POWERPC_MAX,
 };
 
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index d24a8a3668fa..eb51f47276ac 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -75,6 +75,9 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 	if (WARN_ON_ONCE(idx >= PERF_REG_POWERPC_MAX))
 		return 0;
 
+	if (idx == PERF_REG_POWERPC_ARCH_REGS)
+		return perf_get_arch_regs_mask();
+
 	return regs_get_register(regs, pt_regs_offset[idx]);
 }
 
diff --git a/tools/arch/powerpc/include/uapi/asm/perf_regs.h b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
index bf249a27aa36..d4ae8458af3d 100644
--- a/tools/arch/powerpc/include/uapi/asm/perf_regs.h
+++ b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -45,6 +45,7 @@ enum perf_event_powerpc_regs {
 	PERF_REG_POWERPC_TRAP,
 	PERF_REG_POWERPC_DAR,
 	PERF_REG_POWERPC_DSISR,
+	PERF_REG_POWERPC_ARCH_REGS,
 	PERF_REG_POWERPC_MAX,
 };
 
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index 801de6def8da..699376afa77f 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -60,7 +60,8 @@ static const char *reg_names[] = {
 	[PERF_REG_POWERPC_SOFTE] = "softe",
 	[PERF_REG_POWERPC_TRAP] = "trap",
 	[PERF_REG_POWERPC_DAR] = "dar",
-	[PERF_REG_POWERPC_DSISR] = "dsisr"
+	[PERF_REG_POWERPC_DSISR] = "dsisr",
+	[PERF_REG_POWERPC_ARCH_REGS] = "arch_regs"
 };
 
 static inline const char *perf_reg_name(int id)
diff --git a/tools/perf/arch/powerpc/util/perf_regs.c b/tools/perf/arch/powerpc/util/perf_regs.c
index a3c3e1ce6807..bd5afa8506e5 100644
--- a/tools/perf/arch/powerpc/util/perf_regs.c
+++ b/tools/perf/arch/powerpc/util/perf_regs.c
@@ -45,5 +45,6 @@ const struct sample_reg sample_reg_masks[] = {
 	SMPL_REG(trap, PERF_REG_POWERPC_TRAP),
 	SMPL_REG(dar, PERF_REG_POWERPC_DAR),
 	SMPL_REG(dsisr, PERF_REG_POWERPC_DSISR),
+	SMPL_REG(arch_regs, PERF_REG_POWERPC_ARCH_REGS),
 	SMPL_REG_END
 };
-- 
2.7.4
