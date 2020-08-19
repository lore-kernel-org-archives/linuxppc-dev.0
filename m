Return-Path: <SRS0=nuQA=B5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6EBC433E1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 02:14:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADA7F20738
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 02:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="eTC845fS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA7F20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BWWYd6vLDzDqtp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Aug 2020 12:14:13 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BWWBT4jlGzDqnl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Aug 2020 11:57:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=eTC845fS; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BWWBT1QMTz9sPC; Wed, 19 Aug 2020 11:57:37 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BWWBR32MBz9sTb; Wed, 19 Aug 2020 11:57:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1597802255;
 bh=m6AVXPTYGpFBfEpI0E6/D5q3Gdk+xLf45IVukjO+e80=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=eTC845fSwDWQ9EZj5kyN3s2wFm6gtU6qX6iDrWtxxJRQ/l4Wv/m1p5Ib3lPQeqTl7
 NogsZh7EPTokL3lYIoiPxA91pZEP+L6sXodnKQbDQz1k8SlS+tvMernJA3YFz781qp
 YMpnhweJeCKpuvvcjZkWq/2RlL/iVu2odve12QF62lI0w3OAU1LsR3R6/pzfFSsPZN
 3yJHEHoLdqKwH/+e56T1q0TkgHHIDK1bf8f66Bf6hD4XvdTwEYegpmlJP3ndl7nBPW
 Ni77f8sY272bD/XbgQ1CcedBps13CNKebGLkybICB1ck5DLKbI7wlsNJ+b3YmD9Jdc
 ZOW7kimEWQwWA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/9] selftests/powerpc: Don't run DSCR tests on old systems
Date: Wed, 19 Aug 2020 11:57:23 +1000
Message-Id: <20200819015727.1977134-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819015727.1977134-1-mpe@ellerman.id.au>
References: <20200819015727.1977134-1-mpe@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The DSCR tests fail on systems that don't have DSCR, so check for the
DSCR in hwcap and skip if it's not present.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/dscr/Makefile                 | 2 +-
 tools/testing/selftests/powerpc/dscr/dscr_default_test.c      | 2 ++
 tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c     | 2 ++
 tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c | 2 ++
 tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c      | 2 ++
 tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c        | 2 ++
 tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c | 2 ++
 tools/testing/selftests/powerpc/dscr/dscr_user_test.c         | 2 ++
 8 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/dscr/Makefile b/tools/testing/selftests/powerpc/dscr/Makefile
index cfa6eedcb66c..845db6273a1b 100644
--- a/tools/testing/selftests/powerpc/dscr/Makefile
+++ b/tools/testing/selftests/powerpc/dscr/Makefile
@@ -10,4 +10,4 @@ include ../../lib.mk
 
 $(OUTPUT)/dscr_default_test: LDLIBS += -lpthread
 
-$(TEST_GEN_PROGS): ../harness.c
+$(TEST_GEN_PROGS): ../harness.c ../utils.c
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_default_test.c b/tools/testing/selftests/powerpc/dscr/dscr_default_test.c
index 288a4e2ad156..e76611e608af 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_default_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_default_test.c
@@ -63,6 +63,8 @@ int dscr_default(void)
 	unsigned long i, *status[THREADS];
 	unsigned long orig_dscr_default;
 
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_DSCR));
+
 	orig_dscr_default = get_default_dscr();
 
 	/* Initial DSCR default */
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c b/tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c
index aefcd8d8759b..32fcf2b324b1 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_explicit_test.c
@@ -21,6 +21,8 @@ int dscr_explicit(void)
 {
 	unsigned long i, dscr = 0;
 
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_DSCR));
+
 	srand(getpid());
 	set_dscr(dscr);
 
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
index 7c1cb46397c6..c6a81b2d6b91 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_inherit_exec_test.c
@@ -44,6 +44,8 @@ int dscr_inherit_exec(void)
 	unsigned long i, dscr = 0;
 	pid_t pid;
 
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_DSCR));
+
 	for (i = 0; i < COUNT; i++) {
 		dscr++;
 		if (dscr > DSCR_MAX)
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c b/tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c
index 04297a69ab59..f9dfd3d3c2d5 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_inherit_test.c
@@ -22,6 +22,8 @@ int dscr_inherit(void)
 	unsigned long i, dscr = 0;
 	pid_t pid;
 
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_DSCR));
+
 	srand(getpid());
 	set_dscr(dscr);
 
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
index 02f6b4efde14..fbbdffdb2e5d 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_test.c
@@ -77,6 +77,8 @@ int dscr_sysfs(void)
 	unsigned long orig_dscr_default;
 	int i, j;
 
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_DSCR));
+
 	orig_dscr_default = get_default_dscr();
 	for (i = 0; i < COUNT; i++) {
 		for (j = 0; j < DSCR_MAX; j++) {
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
index 37be2c25f277..191ed126f118 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_sysfs_thread_test.c
@@ -56,6 +56,8 @@ int dscr_sysfs_thread(void)
 	unsigned long orig_dscr_default;
 	int i, j;
 
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_DSCR));
+
 	orig_dscr_default = get_default_dscr();
 	for (i = 0; i < COUNT; i++) {
 		for (j = 0; j < DSCR_MAX; j++) {
diff --git a/tools/testing/selftests/powerpc/dscr/dscr_user_test.c b/tools/testing/selftests/powerpc/dscr/dscr_user_test.c
index eaf785d11eed..e09072446dd3 100644
--- a/tools/testing/selftests/powerpc/dscr/dscr_user_test.c
+++ b/tools/testing/selftests/powerpc/dscr/dscr_user_test.c
@@ -36,6 +36,8 @@ int dscr_user(void)
 {
 	int i;
 
+	SKIP_IF(!have_hwcap2(PPC_FEATURE2_DSCR));
+
 	check_dscr("");
 
 	for (i = 0; i < COUNT; i++) {
-- 
2.25.1

