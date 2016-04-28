Return-Path: <chandan.kumar@linux.vnet.ibm.com>
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qwWmQ5HG1zDq62
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 19:31:18 +1000 (AEST)
Received: from localhost
 by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <chandan.kumar@linux.vnet.ibm.com>;
 Thu, 28 Apr 2016 05:31:16 -0400
From: Chandan Kumar <chandan.kumar@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: acme@redhat.com, mpe@ellerman.id.au, jolsa@redhat.com,
 anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 naveen.n.rao@linux.vnet.ibm.com, hemant@linux.vnet.ibm.com
Subject: [PATCH 3/3] perf tools: Fix perf regs mask generation
Date: Thu, 28 Apr 2016 15:01:10 +0530
Message-Id: <1461835870-67778-4-git-send-email-chandan.kumar@linux.vnet.ibm.com>
In-Reply-To: <1461835870-67778-1-git-send-email-chandan.kumar@linux.vnet.ibm.com>
References: <1461835870-67778-1-git-send-email-chandan.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

On some architectures (powerpc in particular), the number of registers
exceeds what can be represented in an integer bitmask. Ensure we
generate the proper bitmask on such platforms.

Fixes: 71ad0f5e4 ("perf tools: Support for DWARF CFI unwinding on post
processing")

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/util/perf_regs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 6b8eb13..c4023f2 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -12,18 +12,18 @@ int perf_reg_value(u64 *valp, struct regs_dump *regs, int id)
 	int i, idx = 0;
 	u64 mask = regs->mask;
 
-	if (regs->cache_mask & (1 << id))
+	if (regs->cache_mask & (1ULL << id))
 		goto out;
 
-	if (!(mask & (1 << id)))
+	if (!(mask & (1ULL << id)))
 		return -EINVAL;
 
 	for (i = 0; i < id; i++) {
-		if (mask & (1 << i))
+		if (mask & (1ULL << i))
 			idx++;
 	}
 
-	regs->cache_mask |= (1 << id);
+	regs->cache_mask |= (1ULL << id);
 	regs->cache_regs[id] = regs->regs[idx];
 
 out:
-- 
1.9.3
