Return-Path: <SRS0=Q9Ec=BX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD00C433DF
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2020 01:42:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034F420771
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2020 01:42:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="rqM/nTad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034F420771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BRq7R5cNhzDqYJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Aug 2020 11:42:11 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BRpyy1g5FzDqWh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Aug 2020 11:34:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=rqM/nTad; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BRpyy0lG9z9sRK; Thu, 13 Aug 2020 11:34:50 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BRpyy04Nwz9sTT; Thu, 13 Aug 2020 11:34:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1597282490;
 bh=oFS+mVwByErZd5inMdhUb7SDf2DIfRsrQcO5gwLyvY8=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=rqM/nTadR+Gz5MulUcc/iBM/NRRXxgtsD8GhGSPwSsdn7+yXgB/kndo3dn7fJl+je
 B7F4JICAhSwP7vR/zuHJeEDhoI9urz+eaNpVTgKLV+xN/TaAUJSFiaXWKboukqKbBo
 jIFC5VPMJveEYMSXp49iVgKusduK1EMdEPekXWOZhDywhJqx/5nnZuRJtFPshpCgT5
 Q/r0Xl/kCBhSWG2IMjryCbAzqJ5lEKoyq/H/JSK1kdqkSC15TE0Hm5za0MUWfe0gHL
 sFEcUKFM00kDEBPdkdoclfOwiR38rFEXua8oNhZF+NiBTbbekkFbLk+aA3wL4PzxUW
 dD1o1HG8r8Zdg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 3/3] selftests/powerpc: Run tm-tmspr test for longer
Date: Thu, 13 Aug 2020 11:34:45 +1000
Message-Id: <20200813013445.686464-3-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813013445.686464-1-mpe@ellerman.id.au>
References: <20200813013445.686464-1-mpe@ellerman.id.au>
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

This test creates some threads, which write to TM SPRs, and then makes
sure the registers maintain the correct values across context switches
and contention with other threads.

But currently the test finishes almost instantaneously, which reduces
the chance of it hitting an interesting condition.

So increase the number of loops, so it runs a bit longer, though still
less than 2s on a Power8.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/tm/tm-tmspr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-tmspr.c b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
index 2ff329e2fca9..794d574db784 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tmspr.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tmspr.c
@@ -33,7 +33,7 @@
 #include "utils.h"
 #include "tm.h"
 
-int	num_loops	= 10000;
+int	num_loops	= 1000000;
 int	passed = 1;
 
 void tfiar_tfhar(void *in)
-- 
2.25.1

