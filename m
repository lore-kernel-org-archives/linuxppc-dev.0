Return-Path: <ravi.bangoria@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xjcCh6G1szDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 19:15:12 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7V9ELRr085459
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 05:15:10 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cpca8k0ad-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 05:15:09 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ravi.bangoria@linux.vnet.ibm.com>;
 Thu, 31 Aug 2017 19:15:06 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v7V9F4xY34275574
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 19:15:04 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v7V9F3AZ004113
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Aug 2017 19:15:04 +1000
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
To: acme@kernel.org
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com,
 namhyung@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: [PATCH v2] perf test powerpc: Fix 'Object code reading' test
Date: Thu, 31 Aug 2017 14:44:56 +0530
Message-Id: <1504170896-7876-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

'Object code reading' test always fails on powerpc guest. Two reasons
for the failure are:

1. When elf section is too big (size beyond 'unsigned int' max value).
objdump fails to disassemble from such section. This was fixed with
commit 0f6329bd7fc ("binutils/objdump: Fix disassemble for huge elf
sections") in binutils.

2. When the sample is from hypervisor. Hypervisor symbols can not
be resolved within guest and thus thread__find_addr_map() fails for
such symbols. Fix this by ignoring hypervisor symbols in the test.

Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
---
Changes in v2:
 - Add pr_debug()

 tools/perf/tests/code-reading.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/tests/code-reading.c b/tools/perf/tests/code-reading.c
index 761c5a4..466a462 100644
--- a/tools/perf/tests/code-reading.c
+++ b/tools/perf/tests/code-reading.c
@@ -237,6 +237,11 @@ static int read_object_code(u64 addr, size_t len, u8 cpumode,
 
 	thread__find_addr_map(thread, cpumode, MAP__FUNCTION, addr, &al);
 	if (!al.map || !al.map->dso) {
+		if (cpumode == PERF_RECORD_MISC_HYPERVISOR) {
+			pr_debug("Hypervisor address can not be resolved - skipping\n");
+			return 0;
+		}
+
 		pr_debug("thread__find_addr_map failed\n");
 		return -1;
 	}
-- 
1.8.3.1
