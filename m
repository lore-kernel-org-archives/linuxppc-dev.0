Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qW3Tv63cczDq72
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Mar 2016 22:04:19 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: bsingharora@gmail.com, duwe@lst.de, <linux-kernel@vger.kernel.org>,
 rostedt@goodmis.org, kamalesh@linux.vnet.ibm.com, pmladek@suse.com,
 jeyu@redhat.com, jkosina@suse.cz, live-patching@vger.kernel.org,
 mbenes@suse.cz
Subject: [PATCH 2/6] ftrace: Make ftrace_location_range() global
Date: Thu, 24 Mar 2016 22:04:01 +1100
Message-Id: <1458817445-5855-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
References: <1458817445-5855-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In order to support live patching on powerpc we would like to call
ftrace_location_range(), so make it global.

Signed-off-by: Torsten Duwe <duwe@suse.de>
Signed-off-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 include/linux/ftrace.h |  1 +
 kernel/trace/ftrace.c  | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 6d9df3f7e334..93230e97e897 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -455,6 +455,7 @@ int ftrace_update_record(struct dyn_ftrace *rec, int enable);
 int ftrace_test_record(struct dyn_ftrace *rec, int enable);
 void ftrace_run_stop_machine(int command);
 unsigned long ftrace_location(unsigned long ip);
+unsigned long ftrace_location_range(unsigned long start, unsigned long end);
 unsigned long ftrace_get_addr_new(struct dyn_ftrace *rec);
 unsigned long ftrace_get_addr_curr(struct dyn_ftrace *rec);
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 57a6eea84694..f4e6aae6ebe7 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1533,7 +1533,19 @@ static int ftrace_cmp_recs(const void *a, const void *b)
 	return 0;
 }
 
-static unsigned long ftrace_location_range(unsigned long start, unsigned long end)
+/**
+ * ftrace_location_range - return the first address of a traced location
+ *	if it touches the given ip range
+ * @start: start of range to search.
+ * @end: end of range to search (inclusive). @end points to the last byte
+ *	to check.
+ *
+ * Returns rec->ip if the related ftrace location is a least partly within
+ * the given address range. That is, the first address of the instruction
+ * that is either a NOP or call to the function tracer. It checks the ftrace
+ * internal tables to determine if the address belongs or not.
+ */
+unsigned long ftrace_location_range(unsigned long start, unsigned long end)
 {
 	struct ftrace_page *pg;
 	struct dyn_ftrace *rec;
-- 
2.5.0
