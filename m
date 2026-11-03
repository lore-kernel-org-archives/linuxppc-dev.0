Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1396B606A32D
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2026 23:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UKtgzhia
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jK4Pf3KZ5z2xyj;
	Wed, 04 Nov 2026 10:23:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793748198;
	cv=none; b=Ze/KXZNQHESJPXQ72pFl9SFysnTSg8gX2YuD0JHZrRAreGyCejp7Snj0zy+z2kx7dsLYAuEnXWdfA0hvpC4euPrdwbQ0uCa/t/L4WGUvihD1KwUyzrTmGsHLSFepMp1wTK3u6J+sLuqDWe3ftY+zV5300bGrEZoqRGtCk37Rk5B4p1ORG037M2cUHYPjqElD2kX6TzXpiReqfwN99UhM+Tw1bNhvBth2wAQJxzt6sDQ/mlqOUEWTSnHCl3HLQfZac3H25VM75RtQWp1jD65QxW2dvHEJB7pD9awPm6qkB66Cgeo1+xIOsRvhfLHeeFkf4N/XzWOG6ibI4LXl6WlYFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793748198; c=relaxed/relaxed;
	bh=cSmLYuREQ2//vWlinxm+BhFVoxU9Wq39k8PHH/kS3cw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n2HbGx1/hbA16m+1GFsAOEOHb42QCCS0nEn8yMIFA697ZHW4bfLdInGAwrY38quu+FjeMwcEgSjwE774r6L68EWZ8cuMGWx/RGV3a1J4peDRMWKgivebM/PmUR+Ux36wPa5lPreLGwO5jisYDPhMYf1ll7imu2wfS13r58ong4kkIjJSmhEfERXHxXDGZ2i/8Zu1MD3RdwbV3qWTKVknyLMVhbxEb+3GM0xyXwJ96YNga1sV/VSEhd4Y+PRgVoG9xOEbVTvB2HeaDeRNsCKNLDf59c112W7D6+Hcs7SC+jCbLGKhrnTjYMo3AAomtSGdr68HWBbIz1J/V8eAETma1w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UKtgzhia; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UKtgzhia;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jK4Pc1Rdzz2xKQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 10:23:16 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D865D60D81;
	Tue,  3 Nov 2026 23:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D5F91F00919;
	Tue,  3 Nov 2026 23:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793748191;
	bh=cSmLYuREQ2//vWlinxm+BhFVoxU9Wq39k8PHH/kS3cw=;
	h=From:To:Cc:Subject:Date;
	b=UKtgzhiaChyk+WCzVo7VWNI7+SvtQu/xL0H8olst8nZ9RA61pwuRq3ThM/Oo6fjc0
	 Ml19Clwv+vTxaEPMjYIq4q60sNmVyjp24QFF02AY4AwZPH0RV1rYuTeptU2PqS3P9U
	 Uhzt/fNvW4uEGKxyflyasiIt3ni1wJOgZtxxLy8xAqC1jTwMUUBREqpSe4Yl5s70Dk
	 IDvfRkVKUh4vD8s53V6AVv1mDyRDpxtXQJPfev3YnLqFt4Qorl/lq9iT9ggeUi4ffU
	 zoJjqvICfNdcqNp4/LEcC7nEw6ooz13mz6Z33uHGnXA+CJX2VXF8tLwQp62276EIA5
	 BlIo2ByVqju0g==
From: Sasha Levin <sashal@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Shuah Khan <shuah@kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/powerpc: override EMIT_TESTS instead of the emit_tests rule
Date: Tue,  3 Nov 2026 18:23:07 -0500
Message-ID: <20261103232307.1924618-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The powerpc Makefiles include lib.mk and then define their own
emit_tests rule, so every selftests build that includes powerpc warns,
on any architecture:

  Makefile:60: warning: overriding recipe for target 'emit_tests'
  ../lib.mk:183: warning: ignoring old recipe for target 'emit_tests'

lib.mk used to keep the recipe in an EMIT_TESTS variable that Makefiles
could override, as they still do with RUN_TESTS, INSTALL_RULE and
CLEAN. Commit d4e59a536f50 ("selftests: Use runner.sh for emit
targets") dropped the variable, and commit 58b33e78a317
("selftests/powerpc: Fix emit_tests to work with run_kselftest.sh")
then replaced the powerpc EMIT_TESTS definitions with rules.

Bring EMIT_TESTS back in lib.mk and override it in the powerpc Makefiles
again. Mark the lib.mk recipe with '+', so that the powerpc sub-makes
still get the jobserver, as they did when $(MAKE) was in the rule
itself. The emitted test lists don't change.

Fixes: 58b33e78a317 ("selftests/powerpc: Fix emit_tests to work with run_kselftest.sh")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
Checked with "make ARCH=powerpc emit_tests" in
tools/testing/selftests/powerpc, which lists the same 186 tests as
before, and with an x86_64 selftests install, whose kselftest-list.txt
doesn't change. make -j2 --jobserver-style=pipe doesn't warn about the
jobserver.

 tools/testing/selftests/lib.mk               | 6 +++++-
 tools/testing/selftests/powerpc/Makefile     | 3 ++-
 tools/testing/selftests/powerpc/pmu/Makefile | 3 ++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
index 881f13ee2c8ac..506cb26510e4d 100644
--- a/tools/testing/selftests/lib.mk
+++ b/tools/testing/selftests/lib.mk
@@ -179,11 +179,15 @@ else
 	$(error Error: set INSTALL_PATH to use install)
 endif
 
-emit_tests:
+define EMIT_TESTS
 	for TEST in $(TEST_GEN_PROGS) $(TEST_CUSTOM_PROGS) $(TEST_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
 		echo "$(COLLECTION):$$BASENAME_TEST";	\
 	done
+endef
+
+emit_tests:
+	+$(EMIT_TESTS)
 
 # define if isn't already. It is undefined in make O= case.
 ifeq ($(RM),)
diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index b175e94e1901d..aeab9366d09bf 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -56,11 +56,12 @@ override define INSTALL_RULE
 	done;
 endef
 
-emit_tests:
+override define EMIT_TESTS
 	+@for TARGET in $(SUB_DIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET COLLECTION=$(COLLECTION)/$$TARGET -s -C $$TARGET $@;\
 	done;
+endef
 
 override define CLEAN
 	+@for TARGET in $(SUB_DIRS); do \
diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index 7e9dbf3d0d092..3aca10223f0ff 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -37,7 +37,7 @@ override define RUN_TESTS
 	done;
 endef
 
-emit_tests:
+override define EMIT_TESTS
 	for TEST in $(TEST_GEN_PROGS); do \
 		BASENAME_TEST=`basename $$TEST`;	\
 		echo "$(COLLECTION):$$BASENAME_TEST";	\
@@ -46,6 +46,7 @@ emit_tests:
 		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
 		$(MAKE) OUTPUT=$$BUILD_TARGET COLLECTION=$(COLLECTION)/$$TARGET -s -C $$TARGET emit_tests; \
 	done;
+endef
 
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
-- 
2.53.0


