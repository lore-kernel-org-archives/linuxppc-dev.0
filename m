Return-Path: <linuxppc-dev+bounces-4319-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CF5E77188
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Dec 2024 11:44:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YCsK06yrYz30T2;
	Wed, 18 Dec 2024 22:44:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=150.107.74.76
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734522244;
	cv=none; b=HUGgP+/78TpJ+2yzprbCzYjtNmXCB9qWyiYxHzXAbH8viOyKyBHLu5lRSba5AISTiSEUKjN8EdPoL+qYVcRNqzZjVWy3P2eafTu5nYV1Y2i0jc9F0yY+3FO2/sCN10prkhd8ESinWSP6OSUD7GQsYsdvTsayLOvQl7b11cZilkYQTyfQ5gVU5WG6wkpzSWiwTQbjb9FjpK6t1H31iE630g6gvrO2jrFQbg57eHDuZ3jezAYNsx78cyR++Rz+skAGGDljON9PSa/iTu10I4xz/ZmL9B7zxBuXz4Cynaq6noymTh10EHna623sCQFRr3Vp8LQgcT4sErNV6EnWI7HWEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734522244; c=relaxed/relaxed;
	bh=eY+zDsxS5lF1GImYLjUzzEHj5yP0cYuDF2gnL4QXJCM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YN1AYXwUHep8SZfjAM6dfRsDzLIA+ZimtjVXyABYLXWneZLeXs1OXgTlFmsZNdIC6BTif+NGHmTpmwwf7dKsi77QjwzlB1zjp9TnzVRHaJUpggU/rPImKGCTUworhMG3FvJUtxPhDWL120pmFPyC7G0e6LT7uKBjvc6NcCKTfHvaZGYwOKssgSbMHcSY/u/gTprk5sRRd58SUJP5odGHt/wnnBuGB0jZskIwST5sALi/lF0zX5ol4NOl2XtYh7eKM7nIajAddA04S9HRVvEAHm185GQVuV7JZ4gVhA4rdowwXNOU5ST2yfWLhYixtyEuJlADuPCWyvTYynShme0kUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=jn2IDKIU; dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=jn2IDKIU;
	dkim-atps=neutral
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YCsJz6Rtjz2yD4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2024 22:44:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1734522238;
	bh=eY+zDsxS5lF1GImYLjUzzEHj5yP0cYuDF2gnL4QXJCM=;
	h=From:To:Cc:Subject:Date:From;
	b=jn2IDKIUJ8+zcxWXhGffDB0bZvwiPQGvfASH4DcVoAJv7nyGrcwCq+BaPgPYoA/8a
	 YEf0ay3dHaQOmFqr7I+Vn74Bd9+m4VX6ATMMVsqZiMZ7h2WJdJRm4SJabWXHzXksTM
	 1dvdyHH7/CDh+wdBin4363SoxKMkIa8pQtODl4pUl3YY54fArW1L4bCH1rqU4aPKMw
	 tfsyvOo0AsMcb6Pr0f9AQLKJF7Tpp29YtUjwgTTHurXAKTYliXVaz8pjQ/qSYkuOMF
	 sh/psrrHxGZasSDQn2iNg/bKfVZVRZb3Hv+0QPzcJ5lpSbH1w4bevVNn9upbaAh4bf
	 wiJmQeDrGdb0Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4YCsJt0vR1z4xcv;
	Wed, 18 Dec 2024 22:43:58 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: ye.xingchen@zte.com.cn
Subject: [PATCH] selftests/powerpc: Fix argument order to timer_sub()
Date: Wed, 18 Dec 2024 22:43:47 +1100
Message-ID: <20241218114347.428108-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.47.1
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

Commit c814bf958926 ("powerpc/selftests: Use timersub() for
gettimeofday()"), got the order of arguments to timersub() wrong,
leading to a negative time delta being reported, eg:

  test: gettimeofday
  tags: git_version:v6.12-rc5-409-gdddf291c3030
  time = -3.297781
  success: gettimeofday

The correct order is minuend, subtrahend, which in this case is end,
start. Which gives:

  test: gettimeofday
  tags: git_version:v6.12-rc5-409-gdddf291c3030-dirty
  time = 3.300650
  success: gettimeofday

Fixes: c814bf958926 ("powerpc/selftests: Use timersub() for gettimeofday()")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/benchmarks/gettimeofday.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c b/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
index 580fcac0a09f..b71ef8a493ed 100644
--- a/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
+++ b/tools/testing/selftests/powerpc/benchmarks/gettimeofday.c
@@ -20,7 +20,7 @@ static int test_gettimeofday(void)
 		gettimeofday(&tv_end, NULL);
 	}
 
-	timersub(&tv_start, &tv_end, &tv_diff);
+	timersub(&tv_end, &tv_start, &tv_diff);
 
 	printf("time = %.6f\n", tv_diff.tv_sec + (tv_diff.tv_usec) * 1e-6);
 
-- 
2.47.1


