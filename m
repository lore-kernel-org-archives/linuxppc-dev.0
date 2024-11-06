Return-Path: <linuxppc-dev+bounces-2912-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05168D44D54
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Nov 2024 13:05:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Xk55q3T36z3bZr;
	Thu,  7 Nov 2024 00:05:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1730898303;
	cv=none; b=k8rsKsh+RfH4501a7n4waZegrcP+ldxB8boHclVzyzEEbNw9zEpDqJUI00vRV/Er+aeP4XCnV4pSgkUcDt7mczt92NUE3EH2/Pk5quVG0sUsv684+SqY+J/DRKc9ndXVk8DKdZjq6+O9773cDjQ2BcPZ3rwsflrgADHpKtPI4dwOy63L4jxjEO193jNaypGx62eJRKcxSkNIYEoJMJWOrp09qT/QR8Hq/+VAbiIAzqPBFBluo6TbtmL1BHDgJ/lLch0BsI/sMVp8t9MkNKC2SqrIdt2vhc2+iFVc0USodpho337KEwn0BlX8E7LE158EZhl2AZFPvR0OXmtMO8EiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1730898303; c=relaxed/relaxed;
	bh=B+DpJzUt5pgtyxVRT5MgXeyFDGbQoigs3Py0OrcwOvE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chkXeTuanXTtx5fVznEcXnpRDHGGw/FD/lptAjZZwfVNBPnFh7xX05JnxNszLiu2K6oMWwJ3MUB9FcnBOO83e7vc0TPfd09tjRth+9V9Z144VMzFENd+B1mqxghTH/GDlD4dx/YzQ8P3mLWAXjROuo/SxviUDDP9VRbPKCysbgSLn5z4fFRQKlweDwf21P8pCcz+WPG5rOettGyyyNUgiZAUtVtG8qU+uSJYUsWVG35BxXkdVPWvWrYaGf4F/N1NJLYAF48z8kE+QD5vXnWiAyfm0jNL0o1riew9q88X4VEWFpuicE+4aC2iicxvvfAlE/6j6vo3j0txYOlFltV+Lw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=VPNk5xvj; dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=VPNk5xvj;
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Xk55n5PX7z30CD
	for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Nov 2024 00:05:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730898299;
	bh=B+DpJzUt5pgtyxVRT5MgXeyFDGbQoigs3Py0OrcwOvE=;
	h=From:To:Cc:Subject:Date:From;
	b=VPNk5xvjtYFlyRUdofY/HhRHBp4lQkzaONXCDrFDWh77HhouPj8EcPKpw5dJdp6zL
	 0/kKopZRW5A7LF6sNIgI+WHBfHys8KlGVP08FksOsy2v7/vYVBCb5eyUQ9ptgnBj4V
	 5P1Y5nxfArEPiqWTjyJVrrDuDtwFmnxoRpu2SkziZ5fQR6dKpZQxgbfRwOxwul2mok
	 A/9e2DVkqhWGoD/zWfTWWT6f1+czly3LWjAWeAmA4kh9LrDUU2ittQqACZ+uej+n7C
	 2OaQscQDBpVzaF4GCJpe+eZ/kHTey7pvU9+qJurWuzjaeHMJTSzbwpaaacBLxLyWE1
	 y+ytXvFKYvh9A==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Xk55l23S6z4x04;
	Thu,  7 Nov 2024 00:04:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kselftest@vger.kernel.org>
Subject: [PATCH 1/5] selftests/powerpc: Lower run time of count_stcx_fail test
Date: Thu,  7 Nov 2024 00:04:49 +1100
Message-ID: <20241106130453.1741013-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.0
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
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The count_stcx_fail test runs for close to or just over 2 minutes, which
means it sometimes times out.

That's overkill for a test that just demonstrates some PMU counters
are working. Drop the 64 billion instruction case, to lower the runtime
to ~30s.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/count_stcx_fail.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c b/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
index 2070a1e2b3a5..d8dd9a9c6c1b 100644
--- a/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
+++ b/tools/testing/selftests/powerpc/pmu/count_stcx_fail.c
@@ -144,9 +144,6 @@ static int test_body(void)
 	/* Run for 16Bi instructions */
 	FAIL_IF(do_count_loop(events, 16000000000, overhead, true));
 
-	/* Run for 64Bi instructions */
-	FAIL_IF(do_count_loop(events, 64000000000, overhead, true));
-
 	event_close(&events[0]);
 	event_close(&events[1]);
 
-- 
2.47.0


