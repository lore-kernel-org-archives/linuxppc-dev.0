Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s45pN0m4bzDqRb
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:29:31 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u738THgN101404
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 04:29:29 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24k0brsrxh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Aug 2016 04:29:29 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 3 Aug 2016 18:29:26 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E24ED2CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Aug 2016 18:29:13 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u738TDWh29425890
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 18:29:13 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u738TCYJ013638
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Aug 2016 18:29:13 +1000
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
Subject: [RESENT PATCH v5 1/2] tools/perf: Fix the mask in regs_dump__printf
 and print_sample_iregs
Date: Wed,  3 Aug 2016 13:59:06 +0530
Message-Id: <1470212947-10473-1-git-send-email-maddy@linux.vnet.ibm.com>
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
 tools/include/linux/bitmap.h |  2 ++
 tools/lib/bitmap.c           | 18 ++++++++++++++++++
 tools/perf/builtin-script.c  |  4 +++-
 tools/perf/util/session.c    |  4 +++-
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index 28f5493da491..5e98525387dc 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -2,6 +2,7 @@
 #define _PERF_BITOPS_H
 
 #include <string.h>
+#include <limits.h>
 #include <linux/bitops.h>
 
 #define DECLARE_BITMAP(name,bits) \
@@ -10,6 +11,7 @@
 int __bitmap_weight(const unsigned long *bitmap, int bits);
 void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 		 const unsigned long *bitmap2, int bits);
+void bitmap_from_u64(unsigned long *dst, u64 mask);
 
 #define BITMAP_FIRST_WORD_MASK(start) (~0UL << ((start) & (BITS_PER_LONG - 1)))
 
diff --git a/tools/lib/bitmap.c b/tools/lib/bitmap.c
index 0a1adc1111fd..464a0cc63e6a 100644
--- a/tools/lib/bitmap.c
+++ b/tools/lib/bitmap.c
@@ -29,3 +29,21 @@ void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
 	for (k = 0; k < nr; k++)
 		dst[k] = bitmap1[k] | bitmap2[k];
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
index 971ff91b16cb..20d7988a1636 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -418,11 +418,13 @@ static void print_sample_iregs(struct perf_sample *sample,
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
