Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnJN0wzDzDrhd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:01:23 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKwuKq037102
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:01:22 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 253712g61w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:01:21 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:31:18 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 4BA58E0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:30:16 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL1FsK21037250
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:15 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL1CI5004666
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:15 +0530
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
Subject: [PATCH 01/13] perf/core: Add perf_arch_regs and mask to perf_regs
 structure
Date: Mon, 29 Aug 2016 02:30:46 +0530
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472418058-28659-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It's a perennial request from hardware folks to be able to
see the raw values of the pmu registers. Partly it's so that
they can verify perf is doing what they want, and some
of it is that they're interested in some of the more obscure
info that isn't plumbed out through other perf interfaces.

Over the years internally have used various hack to get
the requested data out but this is an attempt to use a
somewhat standard mechanism (using PERF_SAMPLE_REGS_INTR).

This would also be helpful for those of us working on the perf
hardware backends, to be able to verify that we're programming
things correctly, without resorting to debug printks etc.

Mechanism proposed:

1)perf_regs structure is extended with a perf_arch_regs structure
which each arch/ can populate with their specific platform
registers to sample on each perf interrupt and an arch_regs_mask
variable, which is for perf tool to know about the perf_arch_regs
that are supported.

2)perf/core func perf_sample_regs_intr() extended to update
the perf_arch_regs structure and the perf_arch_reg_mask. Set of new
support functions added perf_get_arch_regs_mask() and
perf_get_arch_reg() to aid the updates from arch/ side.

3) perf/core funcs perf_prepare_sample() and perf_output_sample()
are extended to support the update for the perf_arch_regs_mask and
perf_arch_regs in the sample

4)perf/core func perf_output_sample_regs() extended to dump
the arch_regs to the output sample.

5)Finally, perf tool side is updated a) to include a new element
"arch_regs_mask" in the "struct regs_dump", b) event sample funcs
to updated to include "arch_regs_mask" and c) print functions
are updated.

This foundation patch just extends the perf_regs structure, defines
support function and subsequent patches completes the implimentation
for powerpc arch.

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
 include/linux/perf_regs.h | 26 ++++++++++++++++++++++++++
 kernel/events/core.c      | 16 ++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index a5f98d53d732..bd19b15703e2 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -4,8 +4,14 @@
 struct perf_regs {
 	__u64		abi;
 	struct pt_regs	*regs;
+	struct perf_arch_regs	*arch_regs;
+	u64		arch_regs_mask;
 };
 
+#ifndef perf_arch_regs
+struct perf_arch_regs { };
+#endif
+
 #ifdef CONFIG_HAVE_PERF_REGS
 #include <asm/perf_regs.h>
 u64 perf_reg_value(struct pt_regs *regs, int idx);
@@ -14,6 +20,11 @@ u64 perf_reg_abi(struct task_struct *task);
 void perf_get_regs_user(struct perf_regs *regs_user,
 			struct pt_regs *regs,
 			struct pt_regs *regs_user_copy);
+
+u64 perf_get_arch_regs_mask(void);
+struct perf_arch_regs *perf_get_arch_reg(void);
+u64 perf_arch_reg_value(struct perf_arch_regs *regs, int idx);
+
 #else
 static inline u64 perf_reg_value(struct pt_regs *regs, int idx)
 {
@@ -37,5 +48,20 @@ static inline void perf_get_regs_user(struct perf_regs *regs_user,
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
 }
+
+u64 perf_get_arch_regs_mask(void)
+{
+	return 0;
+}
+
+struct perf_arch_regs *perf_get_arch_reg(void)
+{
+	return 0;
+}
+
+u64 perf_arch_reg_value(struct perf_arch_regs *regs, int idx)
+{
+	return 0;
+}
 #endif /* CONFIG_HAVE_PERF_REGS */
 #endif /* _LINUX_PERF_REGS_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 3f07e6cfc1b6..2f6e6a16b117 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5353,6 +5353,22 @@ int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
 }
 EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
 
+u64 __attribute__((weak)) perf_get_arch_regs_mask()
+{
+	return 0;
+}
+
+struct perf_arch_regs *__attribute__((weak)) perf_get_arch_reg()
+{
+	return 0;
+}
+
+u64 __attribute__((weak)) perf_arch_reg_value(struct perf_arch_regs *regs,
+								int idx)
+{
+	return 0;
+}
+
 static void
 perf_output_sample_regs(struct perf_output_handle *handle,
 			struct pt_regs *regs, u64 mask)
-- 
2.7.4
