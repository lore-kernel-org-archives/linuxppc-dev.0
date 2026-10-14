Return-Path: <linuxppc-dev+bounces-29512-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBBEEC3DA7A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Oct 2026 20:01:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j4ht216Dlz2xwN;
	Thu, 15 Oct 2026 07:01:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792008090;
	cv=none; b=HjWEzZV7w6qXPRycjgKRowjTUqgoYCO/NYRqx6qAndmR2PaNTRWlVzYlWjuJHKJLqdQ2ZajaIRPEz7Gpq4fdt7tNdrpATb1IuZLW7Y6acCVN8KkkrjCEz/HjNrxCehqhv6E6QGyO3AO3vT7W/NGnDGbIpriOHtzjnoSU05vYhB8K29HYoDX3fFMC9bHs7eWYqgNMyIpHoAyb1AA4VjfYvvX0EZw4Qoi/KqK59AY4Yhb29oaUWxSm4q/Juz8n6hSbimWLdWtpk9L/qvhRS8jo4vqi2LbVECM/yweVa9ejas40QYSlr18+Y1ZwKtw+/yBYL5FTEm14U4GeXvWbXINmNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792008090; c=relaxed/relaxed;
	bh=OJJRzw35bezfBVy0Bke8Qe4M2f3C2NI3f1X/6Jbh83U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqu2hwf+T2jEr9wmyqPNHiMOQYrUSyVY2ZIN8ceFdWEX5+vxXe4OpSQZr6qltz4UUDR857+CyTkJsWgiElTFq7eeN2tP0XBXg3eRJ8TbN64uZnJ1pboXayiCwP7irEnBtwR879+f9SiFjlHp1ZuSMO93Cf8MXgJ6AT8cTm4Lho1dIlEo6NL15P9NQADz0FYvYcQqwmJCOy5NGeJaV3DHLXTTwVO76IBE/XdEyL0sZifvcTaTouGd4V8Mhl8QWTiwUJmTfEQSrfrlXpvSr5lvXtD6sZyuLnlep2j7yWnEBfjROIEhj/DgX6KWxdMN0Op/Zuycbi0pwnRjwJMPY8vwQw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NncGK1Cq; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NncGK1Cq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j4ht02Dvzz2xlw
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2026 07:01:28 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6FF9144520;
	Wed, 14 Oct 2026 20:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404A91F000C7;
	Wed, 14 Oct 2026 20:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792008086;
	bh=OJJRzw35bezfBVy0Bke8Qe4M2f3C2NI3f1X/6Jbh83U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NncGK1CqR0+mAIK9AVAUBCGrocJSygrgvpKE25CvKZxnWSjZC/+GYxV5d06a3Rt6I
	 VkgOTkq6fvaiHKIuLluO1YjYatNJd19PXvV4m2GSsUvQlOql44eUiOri45wVhwwKS5
	 zDkPFq6/3hKto5o7WOyUFro1pNCX6viZUB+ntyB7CFg7QiWQXmzEVjCtdDncbt3tAR
	 FCBXvuLvjs25+TYMj/OedLfctCx583E/3uaz6pSGlS4MPMshOv/RnmGOKM63NTNk1m
	 eYHOEa9HyS+ng18WP2J5MrQhSARGRUc7LkqFNyvOvoFqn6I3iRzvJZtpwKD1CrsUSw
	 VkSislgVtq3XQ==
From: Sasha Levin <sashal@kernel.org>
To: Shuah Khan <shuah@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	Mark Brown <broonie@kernel.org>,
	=?UTF-8?q?Ricardo=20B=2E=20Marli=C3=A8re?= <rbm@suse.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] selftests/powerpc: report the outcome of each subdirectory
Date: Wed, 14 Oct 2026 16:01:14 -0400
Message-ID: <20261014200115.1363363-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014200115.1363363-1-sashal@kernel.org>
References: <20261014200115.1363363-1-sashal@kernel.org>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The powerpc suite and its pmu subdirectory install and list their tests
in shell loops whose status is that of the last subdirectory, so a
failure in any other subdirectory is lost and FORCE_TARGETS has no
effect on them.

Make the installation and runlist loops fail only when no subdirectory
succeeds, which matches how the top-level selftests Makefile treats its
targets, and stop at the first failure when FORCE_TARGETS is set. When a
build report is requested, record each subdirectory as powerpc/<subdir>
or powerpc/pmu/<subdir>, including the builds of the subdirectories, so
that a failure is visible even when make itself succeeds.

The subdirectories are still built as prerequisites of "all", so a
subdirectory that fails to build still fails the build of the suite as
before; only the reporting of that failure is added.

Fixes: 6faeeea44b84 ("selftests: Add install support for the powerpc tests")
Fixes: 822a04957cc5 ("selftests/powerpc: Convert pmu Makefile to for loop style")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/powerpc/Makefile     | 20 +++++++++++++++-----
 tools/testing/selftests/powerpc/pmu/Makefile | 20 +++++++++++++++-----
 2 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/powerpc/Makefile b/tools/testing/selftests/powerpc/Makefile
index b175e94e1901d..8349196c934d5 100644
--- a/tools/testing/selftests/powerpc/Makefile
+++ b/tools/testing/selftests/powerpc/Makefile
@@ -37,9 +37,11 @@ endif
 all: $(SUB_DIRS)
 
 $(SUB_DIRS):
-	BUILD_TARGET=$(OUTPUT)/$@; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $@ all
+	BUILD_TARGET=$(OUTPUT)/$@; mkdir -p $$BUILD_TARGET && $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $@ all; \
+	status=$$?; $(call ksft_record_build_status,all,powerpc/$@); exit $$status
 
 include ../lib.mk
+include $(selfdir)/build_report.mk
 include ./flags.mk
 
 override define RUN_TESTS
@@ -50,17 +52,25 @@ override define RUN_TESTS
 endef
 
 override define INSTALL_RULE
-	+@for TARGET in $(SUB_DIRS); do \
+	+@ret=$(if $(SUB_DIRS),1,0); for TARGET in $(SUB_DIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET INSTALL_PATH=$$INSTALL_PATH/$$TARGET -C $$TARGET install;\
-	done;
+		status=$$?;				\
+		$(call ksft_record_build_status,install,powerpc/$$TARGET); \
+		$(if $(FORCE_TARGETS),[ $$status -eq 0 ] || exit $$status;) \
+		[ $$status -eq 0 ] && ret=0;		\
+	done; exit $$ret
 endef
 
 emit_tests:
-	+@for TARGET in $(SUB_DIRS); do \
+	+@ret=$(if $(SUB_DIRS),1,0); for TARGET in $(SUB_DIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$TARGET;	\
 		$(MAKE) OUTPUT=$$BUILD_TARGET COLLECTION=$(COLLECTION)/$$TARGET -s -C $$TARGET $@;\
-	done;
+		status=$$?;				\
+		$(call ksft_record_build_status,install,powerpc/$$TARGET); \
+		$(if $(FORCE_TARGETS),[ $$status -eq 0 ] || exit $$status;) \
+		[ $$status -eq 0 ] && ret=0;		\
+	done; exit $$ret
 
 override define CLEAN
 	+@for TARGET in $(SUB_DIRS); do \
diff --git a/tools/testing/selftests/powerpc/pmu/Makefile b/tools/testing/selftests/powerpc/pmu/Makefile
index 7e9dbf3d0d092..7b3ef1decbfbb 100644
--- a/tools/testing/selftests/powerpc/pmu/Makefile
+++ b/tools/testing/selftests/powerpc/pmu/Makefile
@@ -7,6 +7,7 @@ EXTRA_SOURCES := ../harness.c event.c lib.c ../utils.c
 
 top_srcdir = ../../../../..
 include ../../lib.mk
+include $(selfdir)/build_report.mk
 include ../flags.mk
 
 SUB_DIRS := ebb sampling_tests event_code_tests
@@ -26,7 +27,8 @@ $(OUTPUT)/count_stcx_fail: loop.S $(EXTRA_SOURCES)
 $(OUTPUT)/per_event_excludes: ../utils.c
 
 $(SUB_DIRS):
-	BUILD_TARGET=$(OUTPUT)/$@; mkdir -p $$BUILD_TARGET; $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $@ all
+	BUILD_TARGET=$(OUTPUT)/$@; mkdir -p $$BUILD_TARGET && $(MAKE) OUTPUT=$$BUILD_TARGET -k -C $@ all; \
+	status=$$?; $(call ksft_record_build_status,all,powerpc/pmu/$@); exit $$status
 
 DEFAULT_RUN_TESTS := $(RUN_TESTS)
 override define RUN_TESTS
@@ -42,18 +44,26 @@ emit_tests:
 		BASENAME_TEST=`basename $$TEST`;	\
 		echo "$(COLLECTION):$$BASENAME_TEST";	\
 	done
-	+@for TARGET in $(SUB_DIRS); do \
+	+@ret=$(if $(SUB_DIRS),1,0); for TARGET in $(SUB_DIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
 		$(MAKE) OUTPUT=$$BUILD_TARGET COLLECTION=$(COLLECTION)/$$TARGET -s -C $$TARGET emit_tests; \
-	done;
+		status=$$?; \
+		$(call ksft_record_build_status,install,powerpc/pmu/$$TARGET); \
+		$(if $(FORCE_TARGETS),[ $$status -eq 0 ] || exit $$status;) \
+		[ $$status -eq 0 ] && ret=0; \
+	done; exit $$ret
 
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)
-	+@for TARGET in $(SUB_DIRS); do \
+	+@ret=$(if $(SUB_DIRS),1,0); for TARGET in $(SUB_DIRS); do \
 		BUILD_TARGET=$(OUTPUT)/$$TARGET; \
 		$(MAKE) OUTPUT=$$BUILD_TARGET INSTALL_PATH=$$INSTALL_PATH/$$TARGET -C $$TARGET install; \
-	done;
+		status=$$?; \
+		$(call ksft_record_build_status,install,powerpc/pmu/$$TARGET); \
+		$(if $(FORCE_TARGETS),[ $$status -eq 0 ] || exit $$status;) \
+		[ $$status -eq 0 ] && ret=0; \
+	done; exit $$ret
 endef
 
 DEFAULT_CLEAN := $(CLEAN)
-- 
2.53.0


