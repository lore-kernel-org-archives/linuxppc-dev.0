Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 750581A00D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 22:23:17 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 2/4] selftests/powerpc: Put the test in a separate process
 group
Date: Tue, 10 Jun 2014 22:23:08 +1000
Message-Id: <1402402990-31925-2-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1402402990-31925-1-git-send-email-mpe@ellerman.id.au>
References: <1402402990-31925-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Allows us to kill the test and any children it has spawned.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/harness.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/harness.c b/tools/testing/selftests/powerpc/harness.c
index e80c42a..532ddff 100644
--- a/tools/testing/selftests/powerpc/harness.c
+++ b/tools/testing/selftests/powerpc/harness.c
@@ -30,12 +30,15 @@ int run_test(int (test_function)(void), char *name)
 
 	pid = fork();
 	if (pid == 0) {
+		setpgid(0, 0);
 		exit(test_function());
 	} else if (pid == -1) {
 		perror("fork");
 		return 1;
 	}
 
+	setpgid(pid, pid);
+
 	/* Wake us up in timeout seconds */
 	alarm(TIMEOUT);
 	terminated = false;
@@ -50,17 +53,20 @@ wait:
 
 		if (terminated) {
 			printf("!! force killing %s\n", name);
-			kill(pid, SIGKILL);
+			kill(-pid, SIGKILL);
 			return 1;
 		} else {
 			printf("!! killing %s\n", name);
-			kill(pid, SIGTERM);
+			kill(-pid, SIGTERM);
 			terminated = true;
 			alarm(KILL_TIMEOUT);
 			goto wait;
 		}
 	}
 
+	/* Kill anything else in the process group that is still running */
+	kill(-pid, SIGTERM);
+
 	if (WIFEXITED(status))
 		status = WEXITSTATUS(status);
 	else {
-- 
1.9.1
