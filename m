Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jXfh6Ps2zF377
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 13:35:40 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id p12-v6so3545521pff.13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 20:35:40 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] selftests/powerpc: fix exec benchmark
Date: Sat, 12 May 2018 13:35:24 +1000
Message-Id: <20180512033525.18762-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The exec_target binary could segfault calling _exit(2) because r13
is not set up properly (and libc looks at that when performing a
syscall). Call SYS_exit using syscall(2) which doesn't seem to
have this problem.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tools/testing/selftests/powerpc/benchmarks/exec_target.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/exec_target.c b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
index 3c9c144192be..c14b0fc1edde 100644
--- a/tools/testing/selftests/powerpc/benchmarks/exec_target.c
+++ b/tools/testing/selftests/powerpc/benchmarks/exec_target.c
@@ -6,8 +6,11 @@
  * Copyright 2018, Anton Blanchard, IBM Corp.
  */
 
-void _exit(int);
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <sys/syscall.h>
+
 void _start(void)
 {
-	_exit(0);
+	syscall(SYS_exit, 0);
 }
-- 
2.17.0
