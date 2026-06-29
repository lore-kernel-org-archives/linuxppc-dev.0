Return-Path: <linuxppc-dev+bounces-23088-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06605C43458
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jun 2026 10:17:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gphzY348pz2yZc;
	Mon, 29 Jun 2026 20:17:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782725491;
	cv=none; b=gBt0Kmzq+WzKqcU9SO2G2qb1ys668IFD7ejCQl3QfCUHEJw309+Kp+I0FyQDhFF+B2PpN5IXeiVXX9UyCbZBB/H5Ekwxv0DhQOBp1GBplK83Ynq8gyTpTjvxC7+gzv74TuHbjEwCGO1I3StgHo44B6v9RNYR6kDPOMpMTngExUdLJqnUOqLI4pITuXNb80lmfPdRA0JDMntIEzIIsxg+If2dnWAFGC75/9k5xMkFAO8oREp76cdtPax5y2Z2CtHUAhkW74JG+Ymjw94RzuvCwJ7OCK33/Kp+YisUjAd6zEch1a9K3KF+l+/1BI/A5w6a7b/WhbjkiMPpAYsgQr+GMw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782725491; c=relaxed/relaxed;
	bh=1R5ufUL1JYVLa5BSDpNGTaM8Nbmty7gpJMGe0EiBf8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tdmn5+47KTQ39ODtIvDd1vDKpdjnHJhQCj7sBZiVWsI0qTKDxtPQHY89DK1nT/JOiZyOCarnJwv4eQx0JAbq8JpVnKlJV76UCvpQ5B5dJhHh1Z8wwtUVC4hXN5tt/3W36t+BfkBdwZ4FrMP3Olewu0ghw7VV2k0cEfNxIBtgDsNuymSY+1RIfKERuMgyXmmOmQoFuK+OcWLaWgvZJ10FhQU/cj3fJU6qJBM+xsfuZC+UAlFZeVh7DX4eulyW4BHIJtUZP2LYtCkmokE5hQcK9ZEotOKfxvONKL/ie520CIlu2VBMuIfXcj+XVzGRXYRriErA87oWatgpOkFoLe8xOQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRtQrICC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=martin.githubacc@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=BRtQrICC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=martin.githubacc@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gpgyT426pz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 19:31:29 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso361909b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jun 2026 02:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782725487; x=1783330287; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1R5ufUL1JYVLa5BSDpNGTaM8Nbmty7gpJMGe0EiBf8U=;
        b=BRtQrICCRKNnINE8kQLt4nLPRlkeitmxIrYBYOVYoAYLXFPEG3XDjet1pcz56PdJqz
         2Frmpth3rxu9ADw9PdXvgH4o4BE2+Z90iUkBTy3i+Fr13gqxhy9ZzryhktCoQrz1bNb7
         ntEfcXPa5aMoYWub+g0PBmigzoKPhBx52NDId3onubPrrXNnJhk7FHyHbyQDAccFAEo7
         jZypF68ZGXrWGAjlzmNiJQhZuJwWbvnZkVq6BXCNX8zY8Z8G5LWNw78TtcGJ6hXmkAqs
         76KTl6te2LM0VAuCFnX5uVcIEPz9A13L2GfIlTM17ZtzWtxZxOC3eiVn/oT5D+omW1/h
         844g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782725487; x=1783330287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1R5ufUL1JYVLa5BSDpNGTaM8Nbmty7gpJMGe0EiBf8U=;
        b=C6mTr2L5SdVuEQVuF2xpNhiwlFlY7SevOeVK2xzvtfHhHeE2n+Ec3xrifucozKaJ7g
         fNB/0r1GAiEV+qgb1axTAWNu5LdyXMjD4SKraY5RTW/G+v4o4IXASU/JOa3Zi5Z46nSX
         8eduWlL6lRRorDZY31i66ueofmGwQrZoYc1/Fah6Vs6ih00Gy/cUYVdqDQ68ufzoIFnk
         ZgXwxkWN+m5Un0WoBod8Ln8/MkgHWC2cxMunkJklM7JdruRny2/kFY670dIuqVKpvVCb
         J5Okb+VtxvdaMVXEDwgzYM5VXxzoeCAv+VHWYsMdyE+Y/aiRlY1IblExMgNd5YsV0SZ7
         bNSw==
X-Forwarded-Encrypted: i=1; AHgh+RqopMEdOhLUmJuAq+8y8wS/g3yZ6GWND9jZIqDLqsmGlx6oTe8aHKupKy/KAJTnS++n19hIssdlwn8hMQM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyGQCdTYQsIy9LOywjSPAfDtXmuyycsatzN1IefJSNFZdi2mNQE
	5dllMzhpozmyt2P4wT9mqzQNXSmY2EASQCnZ6AvpcHDgz4+MXwGk96Q5
X-Gm-Gg: AfdE7ckfN9rZLNqI1Vmqlpl3V0qkYDHo6pTfr6K7yL1f6t1BQesQ9UWQE6e7o94AsqN
	fPs1wmG8WRtZBmDcowuLCEFAhBe6sTH+rCp7sNQFJBjRRUxp7moTar/Xxltr4My4yUKzhuqqp9o
	Jljad7SigDpRtvXJXKHDCcd8tiyLwTOFDgNTFguYaB3biGYh5LT4Yw3vKqsXNjuGSZkgDR52mTx
	1iMzC/6H33Xwn6DtyT9ToCny8Qrzjqkt4Igcy9xSYogYbaezoGWIyxmmG+oePmQ4OE61TTMyd4b
	t2eqYMIl2NSagYtygP7L0CkNB79iQXUh3f5T6ZJkrN3qGqpyVQUUeaJYazzru8uvS4yzApx6P5g
	0+XyDDiulAAsSf9G4Zar1miySuchwYXuS/FCzZkIOpAR42egMm1jb2E2sgV+S5+6t4MlEDe9klV
	m3gISRWp4u8v4NCEs=
X-Received: by 2002:a05:6a00:90a8:b0:847:926c:5837 with SMTP id d2e1a72fcca58-847926c5c7emr899938b3a.11.1782725486620;
        Mon, 29 Jun 2026 02:31:26 -0700 (PDT)
Received: from martin ([2405:9800:b862:14dc:12ff:e0ff:fecd:7ddc])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3feb769sm11591198b3a.17.2026.06.29.02.31.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:31:26 -0700 (PDT)
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
Date: Mon, 29 Jun 2026 16:30:53 +0700
Message-ID: <20260629093056.591498-3-Martin.weiss2410@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629093056.591498-1-Martin.weiss2410@gmail.com>
References: <20260629093056.591498-1-Martin.weiss2410@gmail.com>
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


