Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5780C1A026E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 13:05:53 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Michael Neuling <mikey@neuling.org>
Subject: [PATCH 4/4] selftests/powerpc: Skip TM tests if we don't have TM
Date: Tue, 24 Nov 2015 13:05:41 +1100
Message-Id: <1448330741-4804-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1448330741-4804-1-git-send-email-mpe@ellerman.id.au>
References: <1448330741-4804-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Make the newly added TM tests skip if we don't have TM available, either
because we're running on old hardware, or the kernel doesn't have TM
support enabled.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/tm/Makefile             | 8 +++++---
 tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c | 3 +++
 tools/testing/selftests/powerpc/tm/tm-signal-stack.c    | 3 +++
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 3e6e7aaa5312..578572a3700a 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -2,10 +2,12 @@ TEST_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack
 
 all: $(TEST_PROGS)
 
-$(TEST_PROGS): ../harness.c
+$(TEST_PROGS): ../harness.c ../utils.c
 
-tm-syscall: tm-syscall-asm.S ../utils.c
-tm-syscall: CFLAGS += -mhtm -I../../../../../usr/include
+CFLAGS += -I../../../../../usr/include
+
+tm-syscall: tm-syscall-asm.S
+tm-syscall: CFLAGS += -mhtm
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
index bdad34803c06..a6589582b780 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-msr-resv.c
@@ -18,6 +18,7 @@
 #include <signal.h>
 #include <unistd.h>
 
+#include "tm.h"
 #include "utils.h"
 
 int segv_expected = 0;
@@ -49,6 +50,8 @@ int tm_signal_msr_resv()
 {
 	struct sigaction act;
 
+	SKIP_IF(!have_htm());
+
 	act.sa_sigaction = signal_usr1;
 	sigemptyset(&act.sa_mask);
 	act.sa_flags = SA_SIGINFO;
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
index 62f2a5f108c6..82c29cb222dc 100644
--- a/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-stack.c
@@ -21,6 +21,7 @@
 #include <stdio.h>
 #include <signal.h>
 
+#include "tm.h"
 #include "utils.h"
 
 void signal_segv(int signum)
@@ -33,6 +34,8 @@ int tm_signal_stack()
 {
 	int pid;
 
+	SKIP_IF(!have_htm());
+
 	pid = fork();
 	if (pid < 0)
 		exit(1);
-- 
2.5.0
