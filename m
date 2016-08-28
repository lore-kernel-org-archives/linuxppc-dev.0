Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnLX0z32zDrhs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:03:15 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKwtxM125596
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:03:14 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25356etx37-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:03:14 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:33:11 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 209451258062
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:33:10 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL383p23462000
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:33:08 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL1d26005804
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:42 +0530
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
Subject: [PATCH 05/13] powerpc/perf: Define enums for perf_arch_regs registers
Date: Mon, 29 Aug 2016 02:30:50 +0530
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472418058-28659-6-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch creates a perf_event_powerpc_arch_regs enum and macros
to include some of the powerpc pmu registers.

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
 arch/powerpc/include/uapi/asm/perf_regs.h       | 38 ++++++++++++++++++++++++
 tools/arch/powerpc/include/uapi/asm/perf_regs.h | 39 +++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/arch/powerpc/include/uapi/asm/perf_regs.h b/arch/powerpc/include/uapi/asm/perf_regs.h
index 6a93209748a1..e8f5553a61d1 100644
--- a/arch/powerpc/include/uapi/asm/perf_regs.h
+++ b/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -47,4 +47,42 @@ enum perf_event_powerpc_regs {
 	PERF_REG_POWERPC_DSISR,
 	PERF_REG_POWERPC_MAX,
 };
+
+enum perf_event_powerpc_arch_regs {
+	PERF_ARCH_REG_POWERPC_PVR,
+	PERF_ARCH_REG_POWERPC_PMC1,
+	PERF_ARCH_REG_POWERPC_PMC2,
+	PERF_ARCH_REG_POWERPC_PMC3,
+	PERF_ARCH_REG_POWERPC_PMC4,
+	PERF_ARCH_REG_POWERPC_PMC5,
+	PERF_ARCH_REG_POWERPC_PMC6,
+	PERF_ARCH_REG_POWERPC_PMC7,
+	PERF_ARCH_REG_POWERPC_PMC8,
+	PERF_ARCH_REG_POWERPC_MMCR0,
+	PERF_ARCH_REG_POWERPC_MMCR1,
+	PERF_ARCH_REG_POWERPC_SIER,
+	PERF_ARCH_REG_POWERPC_SIAR,
+	PERF_ARCH_REG_POWERPC_SDAR,
+	PERF_ARCH_REG_POWERPC_MMCRA,
+	PERF_ARCH_REG_POWERPC_MMCR2,
+	PERF_ARCH_REG_POWERPC_MAX,
+};
+
+#define PERF_ARCH_REG_PVR	(1ULL<<PERF_ARCH_REG_POWERPC_PVR)
+#define PERF_ARCH_REG_PMC1	(1ULL<<PERF_ARCH_REG_POWERPC_PMC1)
+#define PERF_ARCH_REG_PMC2	(1ULL<<PERF_ARCH_REG_POWERPC_PMC2)
+#define PERF_ARCH_REG_PMC3	(1ULL<<PERF_ARCH_REG_POWERPC_PMC3)
+#define PERF_ARCH_REG_PMC4	(1ULL<<PERF_ARCH_REG_POWERPC_PMC4)
+#define PERF_ARCH_REG_PMC5	(1ULL<<PERF_ARCH_REG_POWERPC_PMC5)
+#define PERF_ARCH_REG_PMC6	(1ULL<<PERF_ARCH_REG_POWERPC_PMC6)
+#define PERF_ARCH_REG_PMC7	(1ULL<<PERF_ARCH_REG_POWERPC_PMC7)
+#define PERF_ARCH_REG_PMC8	(1ULL<<PERF_ARCH_REG_POWERPC_PMC8)
+#define PERF_ARCH_REG_MMCR0	(1ULL<<PERF_ARCH_REG_POWERPC_MMCR0)
+#define PERF_ARCH_REG_MMCR1	(1ULL<<PERF_ARCH_REG_POWERPC_MMCR1)
+#define PERF_ARCH_REG_SIER	(1ULL<<PERF_ARCH_REG_POWERPC_SIER)
+#define PERF_ARCH_REG_SIAR	(1ULL<<PERF_ARCH_REG_POWERPC_SIAR)
+#define PERF_ARCH_REG_SDAR	(1ULL<<PERF_ARCH_REG_POWERPC_SDAR)
+#define PERF_ARCH_REG_MMCRA	(1ULL<<PERF_ARCH_REG_POWERPC_MMCRA)
+#define PERF_ARCH_REG_MMCR2	(1ULL<<PERF_ARCH_REG_POWERPC_MMCR2)
+
 #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
diff --git a/tools/arch/powerpc/include/uapi/asm/perf_regs.h b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
index 6a93209748a1..bf249a27aa36 100644
--- a/tools/arch/powerpc/include/uapi/asm/perf_regs.h
+++ b/tools/arch/powerpc/include/uapi/asm/perf_regs.h
@@ -47,4 +47,43 @@ enum perf_event_powerpc_regs {
 	PERF_REG_POWERPC_DSISR,
 	PERF_REG_POWERPC_MAX,
 };
+
+enum perf_event_powerpc_arch_regs {
+	PERF_ARCH_REG_POWERPC_PVR,
+	PERF_ARCH_REG_POWERPC_PMC1,
+	PERF_ARCH_REG_POWERPC_PMC2,
+	PERF_ARCH_REG_POWERPC_PMC3,
+	PERF_ARCH_REG_POWERPC_PMC4,
+	PERF_ARCH_REG_POWERPC_PMC5,
+	PERF_ARCH_REG_POWERPC_PMC6,
+	PERF_ARCH_REG_POWERPC_PMC7,
+	PERF_ARCH_REG_POWERPC_PMC8,
+	PERF_ARCH_REG_POWERPC_MMCR0,
+	PERF_ARCH_REG_POWERPC_MMCR1,
+	PERF_ARCH_REG_POWERPC_SIER,
+	PERF_ARCH_REG_POWERPC_SIAR,
+	PERF_ARCH_REG_POWERPC_SDAR,
+	PERF_ARCH_REG_POWERPC_MMCRA,
+	PERF_ARCH_REG_POWERPC_MMCR2,
+	PERF_ARCH_REG_POWERPC_MAX,
+};
+
+#define PERF_ARCH_REG_PVR	1ULL<<PERF_ARCH_REG_POWERPC_PVR
+#define PERF_ARCH_REG_PMC1	1ULL<<PERF_ARCH_REG_POWERPC_PMC1
+#define PERF_ARCH_REG_PMC2	1ULL<<PERF_ARCH_REG_POWERPC_PMC2
+#define PERF_ARCH_REG_PMC3	1ULL<<PERF_ARCH_REG_POWERPC_PMC3
+#define PERF_ARCH_REG_PMC4	1ULL<<PERF_ARCH_REG_POWERPC_PMC4
+#define PERF_ARCH_REG_PMC5	1ULL<<PERF_ARCH_REG_POWERPC_PMC5
+#define PERF_ARCH_REG_PMC6	1ULL<<PERF_ARCH_REG_POWERPC_PMC6
+#define PERF_ARCH_REG_PMC7	1ULL<<PERF_ARCH_REG_POWERPC_PMC7
+#define PERF_ARCH_REG_PMC8	1ULL<<PERF_ARCH_REG_POWERPC_PMC8
+#define PERF_ARCH_REG_MMCR0	1ULL<<PERF_ARCH_REG_POWERPC_MMCR0
+#define PERF_ARCH_REG_MMCR1	1ULL<<PERF_ARCH_REG_POWERPC_MMCR1
+#define PERF_ARCH_REG_SIER	1ULL<<PERF_ARCH_REG_POWERPC_SIER
+#define PERF_ARCH_REG_SIAR	1ULL<<PERF_ARCH_REG_POWERPC_SIAR
+#define PERF_ARCH_REG_SDAR	1ULL<<PERF_ARCH_REG_POWERPC_SDAR
+#define PERF_ARCH_REG_MMCRA	1ULL<<PERF_ARCH_REG_POWERPC_MMCRA
+#define PERF_ARCH_REG_MMCR2	1ULL<<PERF_ARCH_REG_POWERPC_MMCR2
+
+
 #endif /* _UAPI_ASM_POWERPC_PERF_REGS_H */
-- 
2.7.4
