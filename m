Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnJq0NqMzDrhM
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:01:46 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKwte4070903
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:01:45 -0400
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [125.16.236.7])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2533rk5q4v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:01:44 -0400
Received: from localhost
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:31:41 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id C9953E0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:30:38 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL1cMW44761170
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:38 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL1X0j005514
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:37 +0530
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
Subject: [PATCH 04/13] perf/core: Extend perf_output_sample_regs() to include
 perf_arch_regs
Date: Mon, 29 Aug 2016 02:30:49 +0530
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472418058-28659-5-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Extend perf_output_sample_regs() to take in perf_regs structure as
a parameter instead of pt_regs. Add code to check for arch_regs_mask
and dump the arch registers to the output sample.

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
 kernel/events/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 274288819829..e16bf4d057d1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5371,16 +5371,24 @@ u64 __attribute__((weak)) perf_arch_reg_value(struct perf_arch_regs *regs,
 
 static void
 perf_output_sample_regs(struct perf_output_handle *handle,
-			struct pt_regs *regs, u64 mask)
+				struct perf_regs *regs, u64 mask)
 {
 	int bit;
 	DECLARE_BITMAP(_mask, 64);
+	u64 arch_regs_mask = regs->arch_regs_mask;
 
 	bitmap_from_u64(_mask, mask);
 	for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
 		u64 val;
 
-		val = perf_reg_value(regs, bit);
+		val = perf_reg_value(regs->regs, bit);
+		perf_output_put(handle, val);
+	}
+
+	bitmap_from_u64(_mask, arch_regs_mask);
+	for_each_set_bit(bit, _mask, sizeof(mask) * BITS_PER_BYTE) {
+		u64 val;
+		val = perf_arch_reg_value(regs->arch_regs, bit);
 		perf_output_put(handle, val);
 	}
 }
@@ -5792,7 +5800,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 		if (abi) {
 			u64 mask = event->attr.sample_regs_user;
 			perf_output_sample_regs(handle,
-						data->regs_user.regs,
+						&data->regs_user,
 						mask);
 		}
 	}
@@ -5827,7 +5835,7 @@ void perf_output_sample(struct perf_output_handle *handle,
 			u64 mask = event->attr.sample_regs_intr;
 
 			perf_output_sample_regs(handle,
-						data->regs_intr.regs,
+						&data->regs_intr,
 						mask);
 		}
 	}
-- 
2.7.4
