Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qdyxK0H3xzDq6C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 03:03:33 +1000 (AEST)
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 5 Apr 2016 03:03:31 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 38F112CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 03:03:18 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u34H3A6i31719494
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 03:03:18 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u34H2i4F021267
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Apr 2016 03:02:45 +1000
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
 "David S . Miller" <davem@davemloft.net>,
 Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCHv2 net 1/3] samples/bpf: Fix build breakage with
 map_perf_test_user.c
Date: Mon,  4 Apr 2016 22:31:32 +0530
Message-Id: <5ab5eec91d2d0bc7f221d714ef84afac83b2604b.1459789086.git.naveen.n.rao@linux.vnet.ibm.com>
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
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: David S. Miller <davem@davemloft.net>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
v2: no changes

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
