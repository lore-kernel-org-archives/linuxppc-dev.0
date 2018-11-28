Return-Path: <SRS0=VBhC=OH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D3DC43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 13:26:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6CC720660
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Nov 2018 13:26:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6CC720660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 434hHx2kptzDqyk
	for <linuxppc-dev@archiver.kernel.org>; Thu, 29 Nov 2018 00:26:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=debian.org
 (client-ip=148.163.158.5; helo=mx0a-001b2d01.pphosted.com;
 envelope-from=leitao@debian.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 434hF02d2vzDqvn
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Nov 2018 00:23:48 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 wASDFTJg075272
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 08:23:45 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2p1u9as9v2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Nov 2018 08:23:45 -0500
Received: from localhost
 by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <leitao@debian.org>;
 Wed, 28 Nov 2018 13:23:44 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
 by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized
 Use Only! Violators will be prosecuted; 
 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
 Wed, 28 Nov 2018 13:23:26 -0000
Received: from b01ledav006.gho.pok.ibm.com (b01ledav006.gho.pok.ibm.com
 [9.57.199.111])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 wASDNPUa18088076
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 28 Nov 2018 13:23:26 GMT
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D8DE4AC05B;
 Wed, 28 Nov 2018 13:23:25 +0000 (GMT)
Received: from b01ledav006.gho.pok.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 06784AC059;
 Wed, 28 Nov 2018 13:23:24 +0000 (GMT)
Received: from debra.ibm.com (unknown [9.18.239.97])
 by b01ledav006.gho.pok.ibm.com (Postfix) with ESMTP;
 Wed, 28 Nov 2018 13:23:24 +0000 (GMT)
From: Breno Leitao <leitao@debian.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] selftests/powerpc: New TM signal self test
Date: Wed, 28 Nov 2018 11:23:33 -0200
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1542828069-29100-1-git-send-email-leitao@debian.org>
References: <1542828069-29100-1-git-send-email-leitao@debian.org>
X-TM-AS-GCONF: 00
x-cbid: 18112813-2213-0000-0000-00000320CF0D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010137; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000270; SDB=6.01123984; UDB=6.00583531; IPR=6.00904113; 
 MB=3.00024365; MTD=3.00000008; XFM=3.00000015; UTC=2018-11-28 13:23:44
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18112813-2214-0000-0000-00005C69F355
Message-Id: <1543411413-23863-1-git-send-email-leitao@debian.org>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:, ,
 definitions=2018-11-28_07:, , signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1811280118
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Breno Leitao <leitao@debian.org>, mikey@neuling.org,
 gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A new self test that forces MSR[TS] to be set without calling any TM
instruction. This test also tries to cause a page fault at a signal
handler, exactly between MSR[TS] set and tm_recheckpoint(), forcing
thread->texasr to be rewritten with TEXASR[FS] = 0, which will cause a BUG
when tm_recheckpoint() is called.

This test is not deterministic since it is hard to guarantee that the page
access will cause a page fault. Tests have shown that the bug could be
exposed with few interactions in a buggy kernel. This test is configured to
loop 5000x, having a good chance to hit the kernel issue in just one run.
This self test takes less than two seconds to run.

This test uses set/getcontext because the kernel will recheckpoint
zeroed structures, causing the test to segfault, which is undesired because
the test needs to rerun, so, there is a signal handler for SIGSEGV which
will restart the test.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/testing/selftests/powerpc/tm/.gitignore |   1 +
 tools/testing/selftests/powerpc/tm/Makefile   |   3 +-
 .../powerpc/tm/tm-signal-force-msr.c          | 115 ++++++++++++++++++
 3 files changed, 118 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/tm/tm-signal-force-msr.c

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index c3ee8393dae8..89679822ebc9 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -11,6 +11,7 @@ tm-signal-context-chk-fpu
 tm-signal-context-chk-gpr
 tm-signal-context-chk-vmx
 tm-signal-context-chk-vsx
+tm-signal-force-msr
 tm-vmx-unavail
 tm-unavailable
 tm-trap
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 9fc2cf6fbc92..58a2ebd13958 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -4,7 +4,7 @@ SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu
 
 TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
 	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail tm-unavailable tm-trap \
-	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn
+	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn tm-signal-force-msr
 
 top_srcdir = ../../../../..
 include ../../lib.mk
@@ -20,6 +20,7 @@ $(OUTPUT)/tm-vmx-unavail: CFLAGS += -pthread -m64
 $(OUTPUT)/tm-resched-dscr: ../pmu/lib.c
 $(OUTPUT)/tm-unavailable: CFLAGS += -O0 -pthread -m64 -Wno-error=uninitialized -mvsx
 $(OUTPUT)/tm-trap: CFLAGS += -O0 -pthread -m64
+$(OUTPUT)/tm-signal-force-msr: CFLAGS += -pthread
 
 SIGNAL_CONTEXT_CHK_TESTS := $(patsubst %,$(OUTPUT)/%,$(SIGNAL_CONTEXT_CHK_TESTS))
 $(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-force-msr.c b/tools/testing/selftests/powerpc/tm/tm-signal-force-msr.c
new file mode 100644
index 000000000000..4441d61c2328
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-force-msr.c
@@ -0,0 +1,115 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018, Breno Leitao, Gustavo Romero, IBM Corp.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <string.h>
+#include <ucontext.h>
+#include <unistd.h>
+
+#include "tm.h"
+#include "utils.h"
+
+#define __MASK(X)       (1UL<<(X))
+#define MSR_TS_S_LG     33                  /* Trans Mem state: Suspended */
+#define MSR_TM          __MASK(MSR_TM_LG)   /* Transactional Mem Available */
+#define MSR_TS_S        __MASK(MSR_TS_S_LG) /* Transaction Suspended */
+
+#define COUNT_MAX       5000                /* Number of interactions */
+
+/* Setting contexts because the test will crash and we want to recover */
+ucontext_t init_context, main_context;
+
+static int count, first_time;
+
+void trap_signal_handler(int signo, siginfo_t *si, void *uc)
+{
+	ucontext_t *ucp = uc;
+
+	/*
+	 * Allocating memory in a signal handler, and never freeing it on
+	 * purpose, forcing the heap increase, so, the memory leak is what
+	 * we want here.
+	 */
+	ucp->uc_link = malloc(sizeof(ucontext_t));
+	memcpy(&ucp->uc_link, &ucp->uc_mcontext, sizeof(ucp->uc_mcontext));
+
+	/* Forcing to enable MSR[TM] */
+	ucp->uc_mcontext.gp_regs[PT_MSR] |= MSR_TS_S;
+
+	/*
+	 * A fork inside a signal handler seems to be more efficient than a
+	 * fork() prior to the signal being raised.
+	 */
+	if (fork() == 0) {
+		/*
+		 * Both child and parent will return, but, child returns
+		 * with count set so it will exit in the next segfault.
+		 * Parent will continue to loop.
+		 */
+		count = COUNT_MAX;
+	}
+
+	/*
+	 * If the change above does not hit the bug, it will cause a
+	 * segmentation fault, since the ck structures are NULL.
+	 */
+}
+
+void seg_signal_handler(int signo, siginfo_t *si, void *uc)
+{
+	if (count == COUNT_MAX) {
+		/* Return to tm_signal_force_msr() and exit */
+		setcontext(&main_context);
+	}
+
+	count++;
+	/* Reexecute the test */
+	setcontext(&init_context);
+}
+
+void tm_trap_test(void)
+{
+	struct sigaction trap_sa, seg_sa;
+
+	trap_sa.sa_flags = SA_SIGINFO;
+	trap_sa.sa_sigaction = trap_signal_handler;
+
+	seg_sa.sa_flags = SA_SIGINFO;
+	seg_sa.sa_sigaction = seg_signal_handler;
+
+	/*
+	 * Set initial context. Will get back here from
+	 * seg_signal_handler()
+	 */
+	getcontext(&init_context);
+
+	/* The signal handler will enable MSR_TS */
+	sigaction(SIGUSR1, &trap_sa, NULL);
+	/* If it does not crash, it will segfault, avoid it to retest */
+	sigaction(SIGSEGV, &seg_sa, NULL);
+
+	raise(SIGUSR1);
+}
+
+int tm_signal_force_msr(void)
+{
+	SKIP_IF(!have_htm());
+
+	/* Will get back here after COUNT_MAX interactions */
+	getcontext(&main_context);
+
+	if (!first_time++)
+		tm_trap_test();
+
+	return EXIT_SUCCESS;
+}
+
+int main(int argc, char **argv)
+{
+	test_harness(tm_signal_force_msr, "tm_signal_force_msr");
+}
-- 
2.19.0

