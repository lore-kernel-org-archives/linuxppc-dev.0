Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnJg0xG7zDrhP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:01:38 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKwtko077933
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:01:36 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 253rc1ppkd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:01:36 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:31:33 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id EF2C7125805C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:31 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL1UYQ19267674
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:30 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL1QD2005346
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:30 +0530
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
Subject: [PATCH 03/13] perf/core: Update perf_*_sample() to include
 perf_arch_regs
Date: Mon, 29 Aug 2016 02:30:48 +0530
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472418058-28659-4-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf_prepare_sample is extended to include the perf_arch_regs_mask
in the sample header size calculation. Update perf_output_sample() to dump
the perf_arch_regs_mask to sample output.

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
index 8cf540275c34..274288819829 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5780,12 +5780,14 @@ void perf_output_sample(struct perf_output_handle *handle,
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		u64 abi = data->regs_user.abi;
+		u64 arch_regs_mask = data->regs_user.arch_regs_mask;
 
 		/*
 		 * If there are no regs to dump, notice it through
 		 * first u64 being zero (PERF_SAMPLE_REGS_ABI_NONE).
 		 */
 		perf_output_put(handle, abi);
+		perf_output_put(handle, arch_regs_mask);
 
 		if (abi) {
 			u64 mask = event->attr.sample_regs_user;
@@ -5812,11 +5814,14 @@ void perf_output_sample(struct perf_output_handle *handle,
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
 		u64 abi = data->regs_intr.abi;
+		u64 arch_regs_mask = data->regs_intr.arch_regs_mask;
+
 		/*
 		 * If there are no regs to dump, notice it through
 		 * first u64 being zero (PERF_SAMPLE_REGS_ABI_NONE).
 		 */
 		perf_output_put(handle, abi);
+		perf_output_put(handle, arch_regs_mask);
 
 		if (abi) {
 			u64 mask = event->attr.sample_regs_intr;
@@ -5910,8 +5915,8 @@ void perf_prepare_sample(struct perf_event_header *header,
 				      &data->regs_user_copy);
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
-		/* regs dump ABI info */
-		int size = sizeof(u64);
+		/* regs dump ABI info and arch_regs_mask */
+		int size = sizeof(u64) * 2;
 
 		if (data->regs_user.regs) {
 			u64 mask = event->attr.sample_regs_user;
@@ -5947,8 +5952,8 @@ void perf_prepare_sample(struct perf_event_header *header,
 	}
 
 	if (sample_type & PERF_SAMPLE_REGS_INTR) {
-		/* regs dump ABI info */
-		int size = sizeof(u64);
+		/* regs dump ABI info and arch_regs_mask */
+		int size = sizeof(u64) * 2;
 
 		perf_sample_regs_intr(&data->regs_intr, regs);
 
@@ -5956,6 +5961,9 @@ void perf_prepare_sample(struct perf_event_header *header,
 			u64 mask = event->attr.sample_regs_intr;
 
 			size += hweight64(mask) * sizeof(u64);
+
+			mask = data->regs_intr.arch_regs_mask;
+			size += hweight64(mask) * sizeof(u64);
 		}
 
 		header->size += size;
-- 
2.7.4
