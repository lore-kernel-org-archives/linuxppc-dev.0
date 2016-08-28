Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnKY5lS3zDrh0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:02:25 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKxiuO127064
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:24 -0400
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [125.16.236.8])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25356etwbf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:23 -0400
Received: from localhost
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:32:20 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 527CCE0060
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:19 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL2Ixc16122080
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:18 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL2FLg006654
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:18 +0530
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
Subject: [PATCH 10/13] tool/perf: Add support for perf_arch_regs
Date: Mon, 29 Aug 2016 02:30:55 +0530
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472418058-28659-11-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Update the structure regs_dump with the arch_regs_mask
variable. Update perf_evsel__parse_sample() and
perf_event__sample_event_size() to include arch_regs_mask variable.

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
 tools/perf/util/event.h |  1 +
 tools/perf/util/evsel.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index 8d363d5e65a2..aee0ff536e29 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -94,6 +94,7 @@ struct sample_event {
 struct regs_dump {
 	u64 abi;
 	u64 mask;
+	u64 arch_regs_mask;
 	u64 *regs;
 
 	/* Cached values/mask filled by first register access. */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 21fd573106ed..aac8820b3bd5 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1902,6 +1902,8 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		OVERFLOW_CHECK_u64(array);
 		data->user_regs.abi = *array;
 		array++;
+		data->user_regs.arch_regs_mask = *array;
+		array++;
 
 		if (data->user_regs.abi) {
 			u64 mask = evsel->attr.sample_regs_user;
@@ -1961,11 +1963,14 @@ int perf_evsel__parse_sample(struct perf_evsel *evsel, union perf_event *event,
 		OVERFLOW_CHECK_u64(array);
 		data->intr_regs.abi = *array;
 		array++;
+		data->intr_regs.arch_regs_mask = *array;
+		array++;
 
 		if (data->intr_regs.abi != PERF_SAMPLE_REGS_ABI_NONE) {
 			u64 mask = evsel->attr.sample_regs_intr;
 
 			sz = hweight_long(mask) * sizeof(u64);
+			sz += hweight_long(data->intr_regs.arch_regs_mask) * sizeof(u64);
 			OVERFLOW_CHECK(array, sz, max_size);
 			data->intr_regs.mask = mask;
 			data->intr_regs.regs = (u64 *)array;
@@ -2044,6 +2049,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		if (sample->user_regs.abi) {
 			result += sizeof(u64);
 			sz = hweight_long(sample->user_regs.mask) * sizeof(u64);
+			sz += hweight_long(sample->user_regs.arch_regs_mask) * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -2072,6 +2078,7 @@ size_t perf_event__sample_event_size(const struct perf_sample *sample, u64 type,
 		if (sample->intr_regs.abi) {
 			result += sizeof(u64);
 			sz = hweight_long(sample->intr_regs.mask) * sizeof(u64);
+			sz += hweight_long(sample->intr_regs.arch_regs_mask) * sizeof(u64);
 			result += sz;
 		} else {
 			result += sizeof(u64);
@@ -2223,7 +2230,9 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_REGS_USER) {
 		if (sample->user_regs.abi) {
 			*array++ = sample->user_regs.abi;
+			*array++ = sample->user_regs.arch_regs_mask;
 			sz = hweight_long(sample->user_regs.mask) * sizeof(u64);
+			sz += hweight_long(sample->user_regs.arch_regs_mask) * sizeof(u64);
 			memcpy(array, sample->user_regs.regs, sz);
 			array = (void *)array + sz;
 		} else {
@@ -2259,7 +2268,9 @@ int perf_event__synthesize_sample(union perf_event *event, u64 type,
 	if (type & PERF_SAMPLE_REGS_INTR) {
 		if (sample->intr_regs.abi) {
 			*array++ = sample->intr_regs.abi;
+			*array++ = sample->intr_regs.arch_regs_mask;
 			sz = hweight_long(sample->intr_regs.mask) * sizeof(u64);
+			sz += hweight_long(sample->intr_regs.arch_regs_mask) * sizeof(u64);
 			memcpy(array, sample->intr_regs.regs, sz);
 			array = (void *)array + sz;
 		} else {
-- 
2.7.4
