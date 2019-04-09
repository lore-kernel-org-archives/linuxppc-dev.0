Return-Path: <SRS0=YLyy=SL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10167C10F13
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 03:18:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C0720880
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 03:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXe08+ZY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C0720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dXYb0mrkzDqKb
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 13:18:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="eXe08+ZY"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44dXWr3xXmzDqGL
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 13:16:56 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id 9so8803407pfj.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Apr 2019 20:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9czcuJTzb1cs81udvniLfVb22jjd1dYS4/+gZe7hE5I=;
 b=eXe08+ZYU7N+Fd0ML/xQF+ywoAkHNWPme4SBH6dgqyjX0aWBt5Ijj6HPsLtMvW0MN/
 2kAuoFttZQnaPsbCACHInicqXqnkKdYzNbOpVp2AKT+cXhrb3tXbEWQILyl+cmAcYY0d
 OZgYIRpBKkNJNjfhU2TlsvSluIV/wNx2e2tMExpxLeOUevY+nQskQGTftzFWvC9swgDm
 S/Qg/kWKEiZcJxnPp5ly/p0vOQ69fScF8+8DqrKG6ZxFzZlgNsW3r9MVNSCQUVVXQCvO
 npyR0F7IRHJZRZqK8JpuNgsz0693+PgnBtfOEAw4m9MGwhFdw8Aq7hHdHXMIFhf2BTPC
 uAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9czcuJTzb1cs81udvniLfVb22jjd1dYS4/+gZe7hE5I=;
 b=IsTOUHsQ241hQXnN1tyO76prKfEIu3KwTPa7U/Qv1UaaaGb+25kvL8AZf8OwfSS45c
 S+PKtebOz0UlMqeBbkoZgH6fNjKqE3XXQ/iLEtwj620u/Ef9GKrNH2OIb8SXU2DgBwNS
 Nx4mrLBrb/WLYvQeuq697GxUldOytUrvm1RVJK1ieIiLgmLmoj0amz7J0/4idL+rFvGi
 Z22LMjGRZRfraGWiJyWH2M7C8VlIaHBGLyxA05P9LIk8w9gc+nOxSgRd1VtoluCtugSj
 APrWwZ+utSCAoD83IPA8yU6EFJ0wWPNs1Iv01Bi+9aQZ4s9r7VlQaFuXkJZDb3z87DMQ
 RjFQ==
X-Gm-Message-State: APjAAAVleTVfIIscU5TSS91CmA9E/6a6tiPIxqgbdsPZcjiMsPveupVW
 z4lCgFhKkBk3fNPoOzpNK26uSgDR
X-Google-Smtp-Source: APXvYqywn12ZI6MJ3h/tRi3zDP2EUDh33mktwhIy+xnxpUthb1RCHPROv8mpweX0uTTAPXjTjDWDTA==
X-Received: by 2002:a63:494f:: with SMTP id y15mr32462977pgk.56.1554779813696; 
 Mon, 08 Apr 2019 20:16:53 -0700 (PDT)
Received: from bobo.local0.net ([58.84.107.218])
 by smtp.gmail.com with ESMTPSA id p20sm41522858pgh.83.2019.04.08.20.16.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 08 Apr 2019 20:16:53 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/64s/radix: Fix radix segment exception handling
Date: Tue,  9 Apr 2019 13:16:43 +1000
Message-Id: <20190409031643.20405-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Anton Blanchard <anton@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
broke the radix-mode segment exception handler. In radix mode, this is
exception is not an SLB miss, rather it signals that the EA is outside
the range translated by any page table.

The commit lost the radix feature alternate code patch, which can
cause faults to some EAs to kernel BUG at arch/powerpc/mm/slb.c:639!

The original radix code would send faults to slb_miss_large_addr,
which would end up faulting due to slb_addr_limit being 0. This patch
sends radix directly to do_bad_slb_fault, which is a bit clearer.

Fixes: 48e7b76957 ("powerpc/64s/hash: Convert SLB miss handlers to C")
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
- Add a selftests that triggers the crash

 arch/powerpc/kernel/exceptions-64s.S          | 12 +++
 tools/testing/selftests/powerpc/mm/Makefile   |  3 +-
 .../selftests/powerpc/mm/access_tests.c       | 94 +++++++++++++++++++
 3 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/mm/access_tests.c

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index a5b8fbae56a0..9481a117e242 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -656,11 +656,17 @@ EXC_COMMON_BEGIN(data_access_slb_common)
 	ld	r4,PACA_EXSLB+EX_DAR(r13)
 	std	r4,_DAR(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+BEGIN_MMU_FTR_SECTION
+	/* HPT case, do SLB fault */
 	bl	do_slb_fault
 	cmpdi	r3,0
 	bne-	1f
 	b	fast_exception_return
 1:	/* Error case */
+MMU_FTR_SECTION_ELSE
+	/* Radix case, access is outside page table range */
+	li	r3,-EFAULT
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 	std	r3,RESULT(r1)
 	bl	save_nvgprs
 	RECONCILE_IRQ_STATE(r10, r11)
@@ -705,11 +711,17 @@ EXC_COMMON_BEGIN(instruction_access_slb_common)
 	EXCEPTION_PROLOG_COMMON(0x480, PACA_EXSLB)
 	ld	r4,_NIP(r1)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+BEGIN_MMU_FTR_SECTION
+	/* HPT case, do SLB fault */
 	bl	do_slb_fault
 	cmpdi	r3,0
 	bne-	1f
 	b	fast_exception_return
 1:	/* Error case */
+MMU_FTR_SECTION_ELSE
+	/* Radix case, access is outside page table range */
+	li	r3,-EFAULT
+ALT_MMU_FTR_SECTION_END_IFCLR(MMU_FTR_TYPE_RADIX)
 	std	r3,RESULT(r1)
 	bl	save_nvgprs
 	RECONCILE_IRQ_STATE(r10, r11)
diff --git a/tools/testing/selftests/powerpc/mm/Makefile b/tools/testing/selftests/powerpc/mm/Makefile
index 43d68420e363..68b7add5086d 100644
--- a/tools/testing/selftests/powerpc/mm/Makefile
+++ b/tools/testing/selftests/powerpc/mm/Makefile
@@ -2,7 +2,7 @@
 noarg:
 	$(MAKE) -C ../
 
-TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors wild_bctr
+TEST_GEN_PROGS := hugetlb_vs_thp_test subpage_prot prot_sao segv_errors wild_bctr access_tests
 TEST_GEN_FILES := tempfile
 
 top_srcdir = ../../../../..
@@ -13,6 +13,7 @@ $(TEST_GEN_PROGS): ../harness.c
 $(OUTPUT)/prot_sao: ../utils.c
 
 $(OUTPUT)/wild_bctr: CFLAGS += -m64
+$(OUTPUT)/access_tests: CFLAGS += -m64
 
 $(OUTPUT)/tempfile:
 	dd if=/dev/zero of=$@ bs=64k count=1
diff --git a/tools/testing/selftests/powerpc/mm/access_tests.c b/tools/testing/selftests/powerpc/mm/access_tests.c
new file mode 100644
index 000000000000..ad300d7d9d43
--- /dev/null
+++ b/tools/testing/selftests/powerpc/mm/access_tests.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright 2017 John Sperbeck
+ *
+ * Test faults to "interesting" locations.
+ */
+
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <assert.h>
+#include <ucontext.h>
+
+#include "utils.h"
+
+#define PAGE_SIZE	(64*1024)
+#define TB		(1024ULL*1024*1024*1024)
+static volatile bool faulted;
+static volatile int si_code;
+
+static void segv_handler(int n, siginfo_t *info, void *ctxt_v)
+{
+	ucontext_t *ctxt = (ucontext_t *)ctxt_v;
+	struct pt_regs *regs = ctxt->uc_mcontext.regs;
+
+	faulted = true;
+	si_code = info->si_code;
+	regs->nip += 4;
+}
+
+int test_segv_errors(void)
+{
+	struct sigaction act = {
+		.sa_sigaction = segv_handler,
+		.sa_flags = SA_SIGINFO,
+	};
+	static unsigned long ptrs[] = {
+		0x0f00000000000000ULL, /* Radix Q0 out of pgtable range */
+		0x4000000000000000ULL, /* Radix Q1 */
+		0x4f00000000000000ULL, /* Radix Q1 out of pgtable range */
+		0x8000000000000000ULL, /* Radix Q2 */
+		0x8f00000000000000ULL, /* Radix Q2 out of pgtable range */
+		0xc000000000000000ULL, /* Radix Q3 */
+		0xcf00000000000000ULL, /* Radix Q3 out of pgtable range */
+		0xc000000000000000ULL, /* Hash kernel region */
+		0xc000000000000000ULL + TB, /* Hash kernel region + 1 segment */
+		0xc000000000000000ULL + TB - 1,
+		0xd000000000000000ULL, /* Hash vmalloc region */
+		0xd000000000000000ULL + TB,
+		0xd000000000000000ULL + TB - 1,
+		0xe000000000000000ULL,
+		0xe000000000000000ULL + TB,
+		0xe000000000000000ULL + TB - 1,
+		0xf000000000000000ULL, /* Hash vmemmap region */
+		0xf000000000000000ULL + TB,
+		0xf000000000000000ULL + TB - 1,
+	};
+	size_t i;
+
+	FAIL_IF(sigaction(SIGSEGV, &act, NULL) != 0);
+
+	for (i = 0; i < sizeof(ptrs)/sizeof(ptrs[0]); i++) {
+		volatile char *p = (void *)ptrs[i];
+
+		/*
+		 * We just need a compiler barrier, but mb() works and has the
+		 * nice property of being easy to spot in the disassembly.
+		 */
+		printf("testing %p...\n", p);
+		faulted = false;
+		si_code = 0;
+		mb();
+		(void)*p;
+		mb();
+		FAIL_IF(!faulted);
+		FAIL_IF(si_code != SEGV_MAPERR && si_code != SEGV_BNDERR);
+		/*
+		 * Some accesses throw MAPERR, others BNDERR. Possibly all
+		 * Q>0 accesses should cause BNDERR.
+		 */
+	}
+
+	return 0;
+}
+
+int main(void)
+{
+	return test_harness(test_segv_errors, "segv_errors");
+}
-- 
2.20.1

