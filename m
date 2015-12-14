Return-Path: <wangnan0@huawei.com>
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [119.145.14.65])
 (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F5051A11AC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Dec 2015 23:04:33 +1100 (AEDT)
From: Wang Nan <wangnan0@huawei.com>
To: <naveen.n.rao@linux.vnet.ibm.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>, Wang Nan
 <wangnan0@huawei.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, "Alexei
 Starovoitov" <alexei.starovoitov@gmail.com>, Jiri Olsa <jolsa@redhat.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v2] tools lib bpf: Support libbpf on PowerPC
Date: Mon, 14 Dec 2015 11:57:39 +0000
Message-ID: <1450094259-123844-1-git-send-email-wangnan0@huawei.com>
In-Reply-To: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
References: <1450090232-11437-1-git-send-email-naveen.n.rao@linux.vnet.ibm.com>
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

Support basic PowerPC compiling.

Checks BPF syscall number, turn off libbpf building on platform doesn't
support sys_bpf instead of blocking compiling.

Reported-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Signed-off-by: Wang Nan <wangnan0@huawei.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---

v1 -> v2: __powerpc64__ -> __powerpc__. Code is from
          ./tools/perf/perf-sys.h, but not tested yet.

Naveen, please help me try this patch on PPC.
	  
Thank you.

---
 tools/build/feature/test-bpf.c | 23 ++++++++++++++++++++++-
 tools/lib/bpf/bpf.c            |  6 ++++--
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/build/feature/test-bpf.c b/tools/build/feature/test-bpf.c
index 062bac8..19497f7 100644
--- a/tools/build/feature/test-bpf.c
+++ b/tools/build/feature/test-bpf.c
@@ -1,9 +1,26 @@
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
+# elif defined(__powerpc__)
+#  define __NR_bpf 361
+# else
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
@@ -14,5 +31,9 @@ int main(void)
 	attr.kern_version = 0;
 
 	attr = attr;
-	return 0;
+	/*
+	 * Test existance of __NR_bpf and BPF_PROG_LOAD.
+	 * This call should fail if we run the testcase.
+	 */
+	return syscall(__NR_bpf, BPF_PROG_LOAD, attr, sizeof(attr));
 }
diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 5bdc6ea..fd25c58 100644
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
@@ -24,6 +24,8 @@
 #  define __NR_bpf 321
 # elif defined(__aarch64__)
 #  define __NR_bpf 280
+# elif defined(__powerpc__)
+#  define __NR_bpf 361
 # else
 #  error __NR_bpf not defined. libbpf does not support your arch.
 # endif
-- 
1.8.3.4
