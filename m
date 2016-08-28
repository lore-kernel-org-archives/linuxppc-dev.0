Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMnKg2WYLzDrgq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 07:02:31 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7SKwuPm078005
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:29 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 253rc1pqbf-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Aug 2016 17:02:29 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 29 Aug 2016 02:32:26 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id F3BAEE0040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:31:24 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7SL2OuN14483542
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:24 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7SL2LXb006791
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 02:32:24 +0530
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
Subject: [PATCH 11/13] tools/perf: Fix the mask in regs_dump__printf and
 print_sample_iregs
Date: Mon, 29 Aug 2016 02:30:56 +0530
In-Reply-To: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1472418058-28659-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1472418058-28659-12-git-send-email-maddy@linux.vnet.ibm.com>
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
lib functions along with sizeof().

While the exisitng code works fine in most of the case,
the logic is broken when using a 32bit perf on a 64bit kernel (Big Endian).
When reading u64 using (u32 *)(&val)[0], perf (lib/find_*_bit()) assumes it gets
lower 32bits of u64 which is wrong. Proposed fix is to swap the words
of the u64 to handle this case. This is _not_ endianess swap.

Suggested-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: Yury Norov <ynorov@caviumnetworks.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
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
Fix already posted, but yet to be pulled in. This is needed
for the subsequent patches.

https://patchwork.kernel.org/patch/9285421/

 tools/include/linux/bitmap.h |  2 ++
 tools/lib/bitmap.c           | 18 ++++++++++++++++++
 tools/perf/builtin-script.c  |  4 +++-
 tools/perf/util/session.c    |  4 +++-
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 43c1c5021e4b..998ac95a8ddd 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -4,10 +4,12 @@
 #include <string.h>
 #include <linux/bitops.h>
 #include <stdlib.h>
+#include <limits.h>
 
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
 
+void bitmap_from_u64(unsigned long *dst, u64 mask);
 int __bitmap_weight(const unsigned long *bitmap, int bits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, int bits);
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 38748b0e342f..21e17730c35f 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -73,3 +73,21 @@ int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
 			   BITMAP_LAST_WORD_MASK(bits));
 	return result != 0;
 }
+
+/*
+ * bitmap_from_u64 - Check and swap words within u64.
+ *  @mask: source bitmap
+ *  @dst:  destination bitmap
+ *
+ * In 32 bit big endian userspace on a 64bit kernel, 'unsigned long' is 32 bits.
+ * When reading u64 using (u32 *)(&val)[0] and (u32 *)(&val)[1],
+ * we will get wrong value for the mask. That is "(u32 *)(&val)[0]"
+ * gets upper 32 bits of u64, but perf may expect lower 32bits of u64.
+ */
+void bitmap_from_u64(unsigned long *dst, u64 mask)
+{
+	dst[0] = mask & ULONG_MAX;
+
+	if (sizeof(mask) > sizeof(unsigned long))
+		dst[1] = mask >> 32;
+}
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 6b3c8b0d3276..db270b4f892a 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -421,11 +421,13 @@ static void print_sample_iregs(struct perf_sample *sample,
 	struct regs_dump *regs = &sample->intr_regs;
 	uint64_t mask = attr->sample_regs_intr;
 	unsigned i = 0, r;
+	DECLARE_BITMAP(_mask, 64);
 
 	if (!regs)
 		return;
 
-	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
+	bitmap_from_u64(_mask, mask);
+	for_each_set_bit(r, _mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
 		printf("%5s:0x%"PRIx64" ", perf_reg_name(r), val);
 	}
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5d61242a6e64..440a9fb2a6fb 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -944,8 +944,10 @@ static void branch_stack__printf(struct perf_sample *sample)
 static void regs_dump__printf(u64 mask, u64 *regs)
 {
 	unsigned rid, i = 0;
+	DECLARE_BITMAP(_mask, 64);
 
-	for_each_set_bit(rid, (unsigned long *) &mask, sizeof(mask) * 8) {
+	bitmap_from_u64(_mask, mask);
+	for_each_set_bit(rid, _mask, sizeof(mask) * 8) {
 		u64 val = regs[i++];
 
 		printf(".... %-5s 0x%" PRIx64 "\n",
-- 
2.7.4
