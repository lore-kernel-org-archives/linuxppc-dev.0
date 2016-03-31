Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qbMgQ116YzDq71
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:27:30 +1100 (AEDT)
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 31 Mar 2016 21:27:29 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 3275E3578052
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:27:20 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2VBR7dw60752014
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:27:20 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2VBQgZG024586
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Mar 2016 22:26:42 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Alexei Starovoitov <ast@fb.com>, "David S . Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 1/4] samples/bpf: Fix build breakage with map_perf_test_user.c
Date: Thu, 31 Mar 2016 16:55:41 +0530
Message-Id: <922f95fb5d16686367a66d2d4bd176149a87e9ad.1459423412.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Building BPF samples is failing with the below error:

samples/bpf/map_perf_test_user.c: In function ‘main’:
samples/bpf/map_perf_test_user.c:134:9: error: variable ‘r’ has
initializer but incomplete type
  struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
         ^
samples/bpf/map_perf_test_user.c:134:21: error: ‘RLIM_INFINITY’
undeclared (first use in this function)
  struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
                     ^
samples/bpf/map_perf_test_user.c:134:21: note: each undeclared
identifier is reported only once for each function it appears in
samples/bpf/map_perf_test_user.c:134:9: warning: excess elements in
struct initializer [enabled by default]
  struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
         ^
samples/bpf/map_perf_test_user.c:134:9: warning: (near initialization
for ‘r’) [enabled by default]
samples/bpf/map_perf_test_user.c:134:9: warning: excess elements in
struct initializer [enabled by default]
samples/bpf/map_perf_test_user.c:134:9: warning: (near initialization
for ‘r’) [enabled by default]
samples/bpf/map_perf_test_user.c:134:16: error: storage size of ‘r’
isn’t known
  struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
                ^
samples/bpf/map_perf_test_user.c:139:2: warning: implicit declaration of
function ‘setrlimit’ [-Wimplicit-function-declaration]
  setrlimit(RLIMIT_MEMLOCK, &r);
  ^
samples/bpf/map_perf_test_user.c:139:12: error: ‘RLIMIT_MEMLOCK’
undeclared (first use in this function)
  setrlimit(RLIMIT_MEMLOCK, &r);
            ^
samples/bpf/map_perf_test_user.c:134:16: warning: unused variable ‘r’
[-Wunused-variable]
  struct rlimit r = {RLIM_INFINITY, RLIM_INFINITY};
                ^
make[2]: *** [samples/bpf/map_perf_test_user.o] Error 1

Fix this by including the necessary header file.

Cc: Alexei Starovoitov <ast@fb.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 samples/bpf/map_perf_test_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/samples/bpf/map_perf_test_user.c b/samples/bpf/map_perf_test_user.c
index 95af56e..3147377 100644
--- a/samples/bpf/map_perf_test_user.c
+++ b/samples/bpf/map_perf_test_user.c
@@ -17,6 +17,7 @@
 #include <linux/bpf.h>
 #include <string.h>
 #include <time.h>
+#include <sys/resource.h>
 #include "libbpf.h"
 #include "bpf_load.h"
 
-- 
2.7.4
