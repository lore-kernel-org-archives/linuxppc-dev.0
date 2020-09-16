Return-Path: <SRS0=+K1p=CZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB18CC433E2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2020 11:58:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8193822208
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2020 11:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="b3nXZiRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8193822208
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BrzBj1Z9NzDqXf
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Sep 2020 21:58:21 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Brz8p5r9vzDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2020 21:56:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=b3nXZiRY; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4Brz8p1j8Sz9sTs; Wed, 16 Sep 2020 21:56:42 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Brz8p0RKZz9sTv; Wed, 16 Sep 2020 21:56:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1600257402;
 bh=wRKccZgE95TR/6oALIgXVVAyiET2fd7JWDO0U6AQFTk=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=b3nXZiRY3rHnag/cD8vUUtTDdQu3tulw8A5EN923RDCFzMCM9IOlfn0Uu9W1DTFRF
 NdaPGYoqxmDtDZaxW7fbYJaTOPPfpLfyLasIPZeJv3kMPEA3otaKuIyloRs/E12wAE
 0z859sMQqHl7eLXi13oH4g6Pd2lA1DefAkOcoEmxgNbzu6gc04tmkdwP0blWTSNFEH
 dCdaAV0jLnRpB9YuF1Ywq09tp0d1loRbhTScZkFiQiX4tKScMjRjHiOFquiURCJ0gr
 XAceiI7QtuyunTs6BV5ZMBhmSc6BW5APkCVZrw0us9oUMhGTR2/+60i2Tny9lis87q
 W3GH7Svk/oHcw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] powerpc/perf: Add declarations to fix sparse warnings
Date: Wed, 16 Sep 2020 21:56:37 +1000
Message-Id: <20200916115637.3100484-2-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200916115637.3100484-1-mpe@ellerman.id.au>
References: <20200916115637.3100484-1-mpe@ellerman.id.au>
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

Sparse warns about all the init functions:
  symbol init_ppc970_pmu was not declared. Should it be static?
  symbol init_power5p_pmu was not declared. Should it be static?
  symbol init_power5_pmu was not declared. Should it be static?
  symbol init_power6_pmu was not declared. Should it be static?
  symbol init_power7_pmu was not declared. Should it be static?
  symbol init_power9_pmu was not declared. Should it be static?
  symbol init_power8_pmu was not declared. Should it be static?
  symbol init_generic_compat_pmu was not declared. Should it be static?

They're already declared in internal.h, so just make sure all the C
files include that directly or indirectly.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/perf/isa207-common.h | 2 ++
 arch/powerpc/perf/power10-pmu.c   | 1 -
 arch/powerpc/perf/power5+-pmu.c   | 2 ++
 arch/powerpc/perf/power5-pmu.c    | 2 ++
 arch/powerpc/perf/power6-pmu.c    | 2 ++
 arch/powerpc/perf/power7-pmu.c    | 2 ++
 arch/powerpc/perf/ppc970-pmu.c    | 2 ++
 7 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 044de65e96b9..7025de5e60e7 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -13,6 +13,8 @@
 #include <asm/firmware.h>
 #include <asm/cputable.h>
 
+#include "internal.h"
+
 #define EVENT_EBB_MASK		1ull
 #define EVENT_EBB_SHIFT		PERF_EVENT_CONFIG_EBB_SHIFT
 #define EVENT_BHRB_MASK		1ull
diff --git a/arch/powerpc/perf/power10-pmu.c b/arch/powerpc/perf/power10-pmu.c
index 83148656b524..9dbe8f9b89b4 100644
--- a/arch/powerpc/perf/power10-pmu.c
+++ b/arch/powerpc/perf/power10-pmu.c
@@ -9,7 +9,6 @@
 #define pr_fmt(fmt)	"power10-pmu: " fmt
 
 #include "isa207-common.h"
-#include "internal.h"
 
 /*
  * Raw event encoding for Power10:
diff --git a/arch/powerpc/perf/power5+-pmu.c b/arch/powerpc/perf/power5+-pmu.c
index a62b2cd7914f..3e64b4a1511f 100644
--- a/arch/powerpc/perf/power5+-pmu.c
+++ b/arch/powerpc/perf/power5+-pmu.c
@@ -10,6 +10,8 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 
+#include "internal.h"
+
 /*
  * Bits in event code for POWER5+ (POWER5 GS) and POWER5++ (POWER5 GS DD3)
  */
diff --git a/arch/powerpc/perf/power5-pmu.c b/arch/powerpc/perf/power5-pmu.c
index 8732b587cf71..017bb19b73fb 100644
--- a/arch/powerpc/perf/power5-pmu.c
+++ b/arch/powerpc/perf/power5-pmu.c
@@ -10,6 +10,8 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 
+#include "internal.h"
+
 /*
  * Bits in event code for POWER5 (not POWER5++)
  */
diff --git a/arch/powerpc/perf/power6-pmu.c b/arch/powerpc/perf/power6-pmu.c
index 0e318cf87129..189974478e9f 100644
--- a/arch/powerpc/perf/power6-pmu.c
+++ b/arch/powerpc/perf/power6-pmu.c
@@ -10,6 +10,8 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 
+#include "internal.h"
+
 /*
  * Bits in event code for POWER6
  */
diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 5e0bf09cf077..bacfab104a1a 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -10,6 +10,8 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 
+#include "internal.h"
+
 /*
  * Bits in event code for POWER7
  */
diff --git a/arch/powerpc/perf/ppc970-pmu.c b/arch/powerpc/perf/ppc970-pmu.c
index d35223fb112c..7d78df97f272 100644
--- a/arch/powerpc/perf/ppc970-pmu.c
+++ b/arch/powerpc/perf/ppc970-pmu.c
@@ -9,6 +9,8 @@
 #include <asm/reg.h>
 #include <asm/cputable.h>
 
+#include "internal.h"
+
 /*
  * Bits in event code for PPC970
  */
-- 
2.25.1

