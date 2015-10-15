Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6C7ED1A0681
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 11:40:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: sam.bobroff@au1.ibm.com
Subject: [PATCH] selftests/powerpc: Allow the tm-syscall test to build with
 old headers
Date: Thu, 15 Oct 2015 11:40:50 +1100
Message-Id: <1444869650-15843-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When building against older kernel headers, currently the tm-syscall
test fails to build because PPC_FEATURE2_HTM_NOSC is not defined.

Tweak the test so that if PPC_FEATURE2_HTM_NOSC is not defined it still
builds, but prints a warning at run time and marks the test as skipped.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/tm/tm-syscall.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-syscall.c b/tools/testing/selftests/powerpc/tm/tm-syscall.c
index 1276e23da63b..e835bf7ec7ae 100644
--- a/tools/testing/selftests/powerpc/tm/tm-syscall.c
+++ b/tools/testing/selftests/powerpc/tm/tm-syscall.c
@@ -77,13 +77,23 @@ pid_t getppid_tm(bool suspend)
 	exit(-1);
 }
 
+static inline bool have_htm_nosc(void)
+{
+#ifdef PPC_FEATURE2_HTM_NOSC
+	return ((long)get_auxv_entry(AT_HWCAP2) & PPC_FEATURE2_HTM_NOSC);
+#else
+	printf("PPC_FEATURE2_HTM_NOSC not defined, can't check AT_HWCAP2\n");
+	return false;
+#endif
+}
+
 int tm_syscall(void)
 {
 	unsigned count = 0;
 	struct timeval end, now;
 
-	SKIP_IF(!((long)get_auxv_entry(AT_HWCAP2)
-		  & PPC_FEATURE2_HTM_NOSC));
+	SKIP_IF(!have_htm_nosc());
+
 	setbuf(stdout, NULL);
 
 	printf("Testing transactional syscalls for %d seconds...\n", TEST_DURATION);
-- 
2.1.4
