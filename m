Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::147:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C5C281A1047
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Dec 2015 20:12:41 +1100 (AEDT)
Date: Wed, 9 Dec 2015 20:11:47 +1100
From: Anton Blanchard <anton@samba.org>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 cyrilbur@gmail.com, scottwood@freescale.com, mikey@neuling.org,
 khandual@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix DSCR inheritance over fork()
Message-ID: <20151209201147.032e28c3@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Two DSCR tests have a hack in them:

	/*
	 * XXX: Force a context switch out so that DSCR
	 * current value is copied into the thread struct
	 * which is required for the child to inherit the
	 * changed value.
	 */
	sleep(1);

We should not be working around this in the testcase, it is a kernel bug.
Fix it by copying the current DSCR to the child, instead of what we
had in the thread struct at last context switch.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 arch/powerpc/kernel/process.c                                 | 2 +-
 tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c | 8 --------
 tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c      | 8 --------
 3 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index ec10250..fffc2d2 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1282,7 +1282,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 #ifdef CONFIG_PPC64 
 	if (cpu_has_feature(CPU_FTR_DSCR)) {
 		p->thread.dscr_inherit = current->thread.dscr_inherit;
-		p->thread.dscr = current->thread.dscr;
+		p->thread.dscr = mfspr(SPRN_DSCR);
 	}
 	if (cpu_has_feature(CPU_FTR_HAS_PPR))
 		p->thread.ppr = INIT_PPR;
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
index 8265504..08a8b95 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
@@ -60,14 +60,6 @@ int dscr_inherit_exec(void)
 		else
 			set_dscr(dscr);
 
-		/*
-		 * XXX: Force a context switch out so that DSCR
-		 * current value is copied into the thread struct
-		 * which is required for the child to inherit the
-		 * changed value.
-		 */
-		sleep(1);
-
 		pid = fork();
 		if (pid == -1) {
 			perror("fork() failed");
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c b/tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c
index 4e414ca..3e5a6d1 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c
@@ -40,14 +40,6 @@ int dscr_inherit(void)
 		else
 			set_dscr(dscr);
 
-		/*
-		 * XXX: Force a context switch out so that DSCR
-		 * current value is copied into the thread struct
-		 * which is required for the child to inherit the
-		 * changed value.
-		 */
-		sleep(1);
-
 		pid = fork();
 		if (pid == -1) {
 			perror("fork() failed");
-- 
2.5.0
