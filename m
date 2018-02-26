Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqQWV5qlhzF1FY
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 13:19:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: gromero@linux.vnet.ibm.com
Subject: [PATCH] selftests/powerpc: Skip tm-trap if transactional memory is
 not enabled
Date: Mon, 26 Feb 2018 13:19:26 +1100
Message-Id: <20180226021926.32513-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some processor revisions do not support transactional memory, and
additionally kernel support can be disabled. In either case the
tm-trap test should be skipped, otherwise it will fail with a SIGILL.

Fixes: a08082f8e4e1 ("powerpc/selftests: Check endianness on trap in TM")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/tm/tm-trap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/powerpc/tm/tm-trap.c b/tools/testing/selftests/powerpc/tm/tm-trap.c
index 5d92c23ee6cb..179d592f0073 100644
--- a/tools/testing/selftests/powerpc/tm/tm-trap.c
+++ b/tools/testing/selftests/powerpc/tm/tm-trap.c
@@ -255,6 +255,8 @@ int tm_trap_test(void)
 
 	struct sigaction trap_sa;
 
+	SKIP_IF(!have_htm());
+
 	trap_sa.sa_flags = SA_SIGINFO;
 	trap_sa.sa_sigaction = trap_signal_handler;
 	sigaction(SIGTRAP, &trap_sa, NULL);
-- 
2.14.1
