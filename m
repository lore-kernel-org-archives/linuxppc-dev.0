Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rW7tk334PzDqvL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 15:22:54 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5H5IngU132220
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 01:22:51 -0400
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [125.16.236.6])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23ktcahpkr-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 01:22:50 -0400
Received: from localhost
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 17 Jun 2016 10:52:47 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 61E07125805B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 10:55:18 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u5H5Mjne62062616
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 10:52:45 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u5H5Mfje023026
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jun 2016 10:52:45 +0530
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
Subject: [PATCH] tools/perf: Fix the mask in regs_dump__printf
Date: Fri, 17 Jun 2016 10:52:38 +0530
Message-Id: <1466140958-1928-1-git-send-email-maddy@linux.vnet.ibm.com>
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
And mask is of type "u64". But "u64" is send as a "unsigned long *" to
lib functions along with sizeof().

While the exisitng code works fine in most of the case, when using a
32bit perf on a 64bit kernel (Big Endian), we end up reading the wrong word
in the u64 mask. Patch to fix the mask in regs_dump__printf().

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
 tools/perf/util/session.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

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
