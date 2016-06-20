Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rY4Cz3LhBzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 18:44:31 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5K8iSFv060425
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 04:44:28 -0400
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23n2fxfq8m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 04:44:28 -0400
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 14:14:24 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 57D01125805E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 14:16:57 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5K8iM068454300
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 14:14:22 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5K8iDhX003157
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jun 2016 14:14:21 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Yury Norov <ynorov@caviumnetworks.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@intel.com>, Wang Nan <wangnan0@huawei.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2] tools/perf: Fix the mask in regs_dump__printf and
Date: Mon, 20 Jun 2016 14:14:01 +0530
Message-Id: <1466412241-27502-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When decoding the perf_regs mask in regs_dump__printf(),
we loop through the mask using find_first_bit and find_next_bit functions.
"mask" is of type "u64", but sent as a "unsigned long *" to
lib functions along with sizeof(). While the exisitng code works fine in
most of the case, the logic is broken when using a 32bit perf on a
64bit kernel (Big Endian). We end up reading the wrong word of the u64
first in the lib functions. Proposed fix is to swap the words of the
u64 to handle this case. This is not endianess swap.

Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Changelog v1:
1)updated commit message and patch subject
2)Add the fix to print_sample_iregs() in builtin-script.c

 tools/perf/builtin-script.c | 7 ++++++-
 tools/perf/util/session.c   | 7 ++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e3ce2f34d3ad..76d5006ebcc3 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -412,11 +412,16 @@ static void print_sample_iregs(struct perf_sample *sample,
 	struct regs_dump *regs = &sample->intr_regs;
 	uint64_t mask = attr->sample_regs_intr;
 	unsigned i = 0, r;
+	unsigned long _mask[sizeof(mask)/sizeof(unsigned long)];
 
 	if (!regs)
 		return;
 
-	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
+	_mask[0] = mask & ULONG_MAX;
+	if (sizeof(mask) > sizeof(unsigned long))
+		_mask[1] = mask >> 32;
+
+	for_each_set_bit(r, _mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
 		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5214974e841a..2eaa42a4832a 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -940,8 +940,13 @@ static void branch_stack__printf(struct perf_sample *sample)
 static void regs_dump__printf(u64 mask, u64 *regs)
 {
 	unsigned rid, i = 0;
+	unsigned long _mask[sizeof(mask)/sizeof(unsigned long)];
 
-	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
+	_mask[0] = mask & ULONG_MAX;
+	if (sizeof(mask) > sizeof(unsigned long))
+		_mask[1] = mask >> 32;
+
+	for_each_set_bit(rid, _mask, sizeof(mask) * 8) {
 		u64 val = regs[i++];
 
 		printf(".... %-5s 0x%" PRIx64 "\n",
-- 
1.9.1
