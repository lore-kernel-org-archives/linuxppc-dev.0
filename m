Return-Path: <linuxppc-dev+bounces-23086-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A7FC43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 10:08:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphn05Gsqz2yT0;
	Mon, 29 Jun 2026 20:08:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782721724;
	cv=none; b=ag1kM2Ce4yviB9a+80JwAZwJJ3IKvKWcOwiFPh+u5e+FOe79vKVzSh7kUDjG/owH1jsVAk6qC585j7ksVJwuU4Xugv6er3b06Kg3ZzycaZBqvAaEWHlJs8KCMA+tJWvrTr4buNPL8jnx3NC+2c/jSD0pNQAAERwz2V7rrbiZa7d1I0mJpLx40ZiYODvRthiGslWdEW4JaLnlAVXcoTi6SEZYH1zHQPN16GHPADGT9FawrEZVMfSQo+xSlX0GdjkVRkrU2Hol57BQQJaTdix/KykWZQmcvNzx8A5l46es2u9t0izFPgr1LdRhb4/lVHLb2w522Wgwj4v/nLPlgKoiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782721724; c=relaxed/relaxed;
	bh=1R5ufUL1JYVLa5BSDpNGTaM8Nbmty7gpJMGe0EiBf8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SuqjAl/9vnP9GupECYfHunzenexfvv/2HEENGvBvOt5P+aQ94cQ730NmVn61jUfyjqTS5l7ryoF8m6cDoP7DUFT29jVyLdk2/vzqlBhbAl2xt1YGuCaU/EO8YJ8TvjhyFSlwgiCVKyfFRwEgcGMCCFP3sY/R0Xiy1MLdGgIma7eVLt99cbUmMjllJHYUhp/52em6oFqGMVUVPPi9NWvt41jcTrlhUzfIpoqSLsof8bTJG8ZkNDF5NVxsxBPCcgFePdD4HM0EFHqqFjVUinVVhVvTBnA3aHtIoSwB/ImPDjjv2GWN2qreh8As5SxI1ImijKvP6hGYyuzU+qAjSblt4Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KH3MYcEO; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=martin.githubacc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KH3MYcEO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=martin.githubacc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpfZ250Ykz2yT0
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 18:28:41 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-37fa06b39b4so1527252a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 01:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782721720; x=1783326520; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R5ufUL1JYVLa5BSDpNGTaM8Nbmty7gpJMGe0EiBf8U=;
        b=KH3MYcEOp/r86SWthwGdrVPjN6KNQuiNQk63tDzlpRO7QjSyqsOaUe9fYTitOGJTfQ
         Oj+Rkn1kPBL0yVSHODO/3EhjEnRyxP/YLsqcF3bCyEF+xuPsVHGRS6Hrljaw/HOJuros
         HvAuq8MxcCRUtMWV5m3rbIvD6KQwmv1p36yKSV0wOBLGk/WTlOrvdqsgiAgkuF0Gk9vp
         FBauOM0qiCCPcspP6OQWKHmzlZQ8XxfifVs61D9Z3SF+eh7sMn6UZbZxtvBgrI5H63D0
         9pzeHKipZFkLYFlZfMf/Nkhjlr2lLVIgDB/IkUt0S111agi+/6Myo3CHWnkwLKSNBXH9
         xGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782721720; x=1783326520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1R5ufUL1JYVLa5BSDpNGTaM8Nbmty7gpJMGe0EiBf8U=;
        b=CX7GjVGcOPvUSYC9oChb4kNkDEGKv1cUi1L6TethUzYVe+nN/+Rx2QGi3wZm1NTh0W
         N/jyrrAves9Czjy0WeWxtiggvc9fqjEpD5Oz66SmHKGYVZRyDb5AFPT9PN68CwC5XCJc
         OfH7wgaj9h11ODtXqVFPcVHVsuW9fwdZKbnBwrzkfczwh/ZfJo33lOwTpEyBB7xQoiXl
         FqsRSFgmEoQThGmRsEmZkrb3qDFq3bp0VNtG6f7K1nXiRZDF3cIdcVydQKkXisG6trSQ
         viwgQJNQfi6E0iatlNtVclJfycpeeq5WMJTbnucNA6Q3N9UhQPBdlMxDM4ROE5I9Z3Kg
         +JCw==
X-Forwarded-Encrypted: i=1; AHgh+RrBSQ/xSi8nm3KLckHPILYceaDzc8MnJSWhmR2uea+peiy3PZete9+2cgs0RPra5dmkAz0Kc/K/18dAQM0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YytTJ78I0HJOsRUvBeKX44ZurMLnezZmbTN8JfJD6iAAg7Nl82g
	qZHzhSPhuF6qGCn1y8rtlab+j5gnfqwuLP+yPeThAxeBtBPcb1awAzSU
X-Gm-Gg: AfdE7cnWS/XH7XqK2QgUmEzsO/k++Eyqvg3wRERuu/tQIFPB7+HBdjB9jnBx3+HHnJw
	3OepIDoZ9dsdeZimeyV6cWAG2TQMd0+gvDIHpOo47RyyjbK7gxJrtG6HESzvCqjaOxWAuKbPv0G
	omoeaBwcAPtnV2gLdDE2CaooUsA3Soast6viT5tKBToWZMXn8q5P6NKNGUfSZtOGvZcy+C9vUAP
	AcCMFMXq1RrbcaNYQlN2OlOn+8deficRhmh8mIvAqaTguu7e7FKQDC6rcoGVfzmwgGSpRcCjFTk
	n8tPFLdeGjQs/X6VkCIXCMEQbiDk2isqnvzoJ0Lbn1R+XWcRp3ancdivtSYt3IsR5ziCjo4/wMH
	qHujZUZGGyxqa2d8ggF9mkmshIthLjP7YI+Y7+nPKgPdOutpdjxlLdrgfd7iFlM3n7y5JSP96BH
	zfZ835
X-Received: by 2002:a17:90b:2ec4:b0:37f:d265:18c5 with SMTP id 98e67ed59e1d1-37fd2651c13mr5031747a91.18.1782721719646;
        Mon, 29 Jun 2026 01:28:39 -0700 (PDT)
Received: from martin ([2405:9800:b862:14dc:12ff:e0ff:fecd:7ddc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37fd2bd0e49sm3259343a91.0.2026.06.29.01.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 01:28:39 -0700 (PDT)
From: Martin Weiss <martin.githubacc@gmail.com>
X-Google-Original-From: Martin Weiss <Martin.weiss2410@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Martin Weiss <Martin.weiss2410@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 3/4] selftests: powerpc: fix spelling mistake
Date: Mon, 29 Jun 2026 15:28:08 +0700
Message-ID: <20260629082812.551273-3-Martin.weiss2410@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629082812.551273-1-Martin.weiss2410@gmail.com>
References: <20260629082812.551273-1-Martin.weiss2410@gmail.com>
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

Signed-off-by: Martin Weiss <Martin.weiss2410@gmail.com>
---
 tools/testing/selftests/powerpc/tm/tm-tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-tar.c b/tools/testing/selftests/powerpc/tm/tm-tar.c
index f2a9137f3c1e..ea420caa3961 100644
--- a/tools/testing/selftests/powerpc/tm/tm-tar.c
+++ b/tools/testing/selftests/powerpc/tm/tm-tar.c
@@ -50,7 +50,7 @@ int test_tar(void)
 			"bne	2b;"
 			"tend.;"
 
-			/* Transaction sucess! TAR should be 3 */
+			/* Transaction success! TAR should be 3 */
 			"mfspr  7, %[tar];"
 			"ori	%[res], 7, 4;"  // res = 3|4 = 7
 			"b	4f;"
-- 
2.54.0


