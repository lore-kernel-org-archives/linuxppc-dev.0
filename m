Return-Path: <linuxppc-dev+bounces-23936-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13D6C43458
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Jul 2026 11:40:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwtLz32wwz3bxl;
	Thu, 09 Jul 2026 21:40:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783597243;
	cv=none; b=NTkmHKGvvvIsYR0UrxvGJ12NDnmu+Qp5t0E7nyZn+vDTn/XYJMCWh7wi8rw442FeFs/VFF2OjNs+q5KV7zWxUcKjqIrK0GmymBGN/tRCJOdNMrCI2/m0ueeShcFZdu6sNUMcMXtVNtVoqTKsCS6/kJPZ6NsVBkVxfWE6jokr5bI1i6EaxR5dDrjCilP5Hfgjt5pAKCK/aNsOuR1yKBgrzL/Kk7KtYBi8mAcErRHomSvUXMBippDBt8CwAcVVYwhfOt5LADhc2qKzC/rcGj0vSXza6FAGsWIuiDf0NV3Q1imd2eto2rRIoj18fd6EDGccuNJDMHCpNIoXQ8KnzZADjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783597243; c=relaxed/relaxed;
	bh=gl9PI4iaZLQoEkKjFkWlnA85Asut1OedrWfrXANKJdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CEiYJYJ6kCHwNVxvc7XS2sKiy/BmBY17SXZEBqjFOnYGH/2qm19usjQCrK02ST+/I2RS4hVGCnWxkqxPOtCzKs4H+lhZ00U7PE0I1NJUWNdv6/k82KJcmRH4/WMgrA1B1vpM/ESJPbw3vQoXi2pEdD0VK5gPi1Y93aWrvhy8I0lYQ1Z8ZID2FYzK4rFG/U5tLQwuqgT5vJ1j3XcSJE5EygOXI+joGjZGMOcnUSf62PDDXslOGBbZnSAm/FUqLgcGywajlMOFiIO+iIxv+/1vwjDus9bHGyVsDnnR2ZoRP4JPQevWURejFWJ43B1NAvfmUrWp3B/EtCITjtXT8ifNtQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXuwm1BR; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXuwm1BR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwtLy2XQDz3bxf
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Jul 2026 21:40:42 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 75A58600C3;
	Thu,  9 Jul 2026 11:40:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2596B1F000E9;
	Thu,  9 Jul 2026 11:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783597239;
	bh=gl9PI4iaZLQoEkKjFkWlnA85Asut1OedrWfrXANKJdo=;
	h=From:To:Cc:Subject:Date;
	b=WXuwm1BRBGwqelTxF3Ntzn6TMIdfiSchXU7teeBGIBT61HpE7nXovD9hy9TFyPZWY
	 RfaHu9SEJb0ZOlAVPA/Pp1FXgRFOKEDdTsCT3siHNqblcTcVtyiiTuvfwlX++c3QRI
	 JlUcOcDhIr7Q9WRJITSwG/8vPXkM4fQIL49gX0Kn+7XM+bNdRL6P/66GEoVuYsp9jo
	 Gy7Ny4H45DqC1MlB6FemsOh3gQ/TfF9AV508dHEaml+bv1UgyyGjIddP+7BRSZAsD7
	 kM1AazThd40PhpZM8i+cuelPHGVxbFG0JzObAZVxR7AQ2Ue2fy12Ut0Kw7BtE1L9km
	 XBAWEVpXidcpw==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Erhard Furtner <erhard_f@mailbox.org>
Subject: [PATCH] bitmap: Properly initialise destination bitmap for scatter & gather test
Date: Thu,  9 Jul 2026 13:40:06 +0200
Message-ID: <67d1838732b85b1f715cc3ada5bb38dcfcf9db55.1783593992.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.54.0
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; i=chleroy@kernel.org; h=from:subject:message-id; bh=Y4hIf41FHJO1+YG76PY8saBfZL5rpOcw+LiVnoz5KoQ=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWT5d8yd8jlzYoDWvp3+CovPvOFXFHRsPhF4Yd3i34dbO D/LGsSZdZSyMIhxMciKKbIc/8+9a0bXl9T8qbv0YeawMoEMYeDiFICJfLNm+J8kKRAx7SJf0cd4 raf38t8tc4l/Ecmmx/+e9X3W3vdPbJsZGbZq6revvP8q3dVidWqgz8Enb9dvWcUpW2g2n8FH/Pd hEyYA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit

Erhard reports failure of bitmap tests on powerpc:

  test_bitmap: loaded.
  test_bitmap: [lib/test_bitmap.c:397] bitmaps contents differ: expected "1,3-4,9", got "1,3-4,9,65-71,73-79,81-87,89-95,97-99"
  test_bitmap: parselist('0-2047:128/256'):    912
  test_bitmap: scnprintf("%*pbl", '0-32767'):    5977
  test_bitmap: test_bitmap_read_perf:        1191082
  test_bitmap: test_bitmap_write_perf:        1270153
  test_bitmap: failed 1 out of 208655 tests

The happens mainly when CONFIG_INIT_STACK_ALL_PATTERN is set.

Commit 6b5a4b687367 ("bitmap: Add test for out-of-boundary
modifications for scatter & gather") extended the test to
out-of-boundary bits, but those bits where left uninitialised.

Properly initialise the entire result bitmap before the test.

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Closes: https://lore.kernel.org/all/ca3547ae-8b79-43a2-a758-23ec980bfd9a@mailbox.org
Fixes: 6b5a4b687367 ("bitmap: Add test for out-of-boundary modifications for scatter & gather")
Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 lib/test_bitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 69813c10e6c0..448c3eb48a4a 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -392,6 +392,7 @@ static void __init test_bitmap_sg(void)
 
 	/* Scatter/gather relationship */
 	bitmap_zero(bmap_tmp, 100);
+	bitmap_zero(bmap_res, 100);
 	bitmap_gather(bmap_tmp, bmap_scatter, sg_mask, nbits);
 	bitmap_scatter(bmap_res, bmap_tmp, sg_mask, nbits);
 	expect_eq_bitmap(bmap_scatter, bmap_res, 100);
-- 
2.54.0


