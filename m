Return-Path: <wangnan0@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 898011A0248
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 14:36:27 +1100 (AEDT)
From: Wang Nan <wangnan0@huawei.com>
To: <naveen.n.rao@linux.vnet.ibm.com>, <acme@kernel.org>, <jolsa@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Wang Nan
 <wangnan0@huawei.com>, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v3 1/3] perf tools: Fix PowerPC native building
Date: Tue, 15 Dec 2015 03:35:55 +0000
Message-ID: <1450150557-127942-2-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1450150557-127942-1-git-send-email-wangnan0@huawei.com>
References: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
 <1450150557-127942-1-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Checks BPF syscall number, turn off libbpf building on platform doesn't
correctly support sys_bpf instead of blocking compiling.

Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/build/feature/test-bpf.c | 20 +++++++++++++++++++-
 tools/lib/bpf/bpf.c            |  4 ++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-bpf.c
index 062bac8..b389026 100644
--- a/tools/build/feature/test-bpf.c
+++ b/tools/build/feature/test-bpf.c
@@ -1,9 +1,23 @@
+#include <asm/unistd.h>
 #include <linux/bpf.h>
+#include <unistd.h>
+
+#ifndef __NR_bpf
+# if defined(__i386__)
+#  define __NR_bpf 357
+# elif defined(__x86_64__)
+#  define __NR_bpf 321
+# elif defined(__aarch64__)
+#  define __NR_bpf 280
+#  error __NR_bpf not defined. libbpf does not support your arch.
+# endif
+#endif
 
 int main(void)
 {
 	union bpf_attr attr;
 
+	/* Check fields in attr */
 	attr.prog_type = BPF_PROG_TYPE_KPROBE;
 	attr.insn_cnt = 0;
 	attr.insns = 0;
@@ -14,5 +28,9 @@ int main(void)
 	attr.kern_version = 0;
 
 	attr = attr;
-	return 0;
+	/*
+	 * Test existence of __NR_bpf and BPF_PROG_LOAD.
+	 * This call should fail if we run the testcase.
+	 */
+	return syscall(__NR_bpf, BPF_PROG_LOAD, attr, sizeof(attr));
 }
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5bdc6ea..1f91cc9 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -14,8 +14,8 @@
 #include "bpf.h"
 
 /*
- * When building perf, unistd.h is override. Define __NR_bpf is
- * required to be defined.
+ * When building perf, unistd.h is overrided. __NR_bpf is
+ * required to be defined explicitly.
  */
 #ifndef __NR_bpf
 # if defined(__i386__)
-- 
1.8.3.4
