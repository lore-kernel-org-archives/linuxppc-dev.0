Return-Path: <SRS0=KHR7=NP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53310C4338F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 03:06:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AE53613D5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 03:06:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5AE53613D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GtvCd5Jjzz2yPn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Aug 2021 13:06:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=eP6pqLBN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::836;
 helo=mail-qt1-x836.google.com; envelope-from=cgel.zte@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=eP6pqLBN; dkim-atps=neutral
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com
 [IPv6:2607:f8b0:4864:20::836])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GtvBq480nz2xrx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Aug 2021 13:06:10 +1000 (AEST)
Received: by mail-qt1-x836.google.com with SMTP id x5so15620880qtq.13
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Aug 2021 20:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2kVvHTOkclueciWHjlwAZSqO9FMOmpPlMvewZXfOAmg=;
 b=eP6pqLBNeyCeJM8uVp8bzcC1h6sq8OKzLgRi6al1jCpA7Xle45/8q3gm8f5aEppJgp
 SBEQIJTYVyriOAVaInb/H6yvKkBl5N8QE8d81/EO9AO5ScvgM2jpeRQbV7ELUpYX4kOe
 hvC2P/rYksi8aLHx2kUslkBFBeggLXqCTkVqiTYPLJGK1CZv/GZEAoiKdbla5nHvWjN/
 r3GU0mdF941yFeXorLcXlgTpDEEnDpURPxNwNNF5+7USIGSnKZ6qt91I5fDvq+Fn5piF
 2H2TeFOuX9UZsY1lzyltV1LkTnDzxGx3CuYwMGT0MqEQkmBtrm2RcSabLk++mHVqfLFH
 whAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2kVvHTOkclueciWHjlwAZSqO9FMOmpPlMvewZXfOAmg=;
 b=csaNYncjEzlFVx5373RRf595YWEOhANokC18udWYuijVYh7RRYjNfnal9inGHkR0P4
 tsY/Smu4DbCG6xWbF+46p/AGeVVrNvPENopQdaV37cd49h0QlQj1OGQh3zko0q7ga2M4
 fbN3Culd/zPnozmb4rWeS1vnVpU99tU24UjqwXMDKMWAqXMg/he3E+w0OOhzbINpCdh3
 ujXoIy5dIdow5rxL6Nj4TqsjoLmm0wOhz5xSmntAtR5Dqm1ShJC3fMnb9VTurrMczZX5
 kM2UOS+1SgfBdWRceMICB3rNyWK1p2R1cEb+OVoIqdI4XohzxjJr1ULMDldkpp6bZyR1
 Tagg==
X-Gm-Message-State: AOAM531hPJzTjjy0ofylAklQHEh7hyqvNgPT35OZB22B4gbq0FJloLTb
 0+mZRTDExGDDZ0dEMN90bzM=
X-Google-Smtp-Source: ABdhPJxqWLQTotq77Iz8SEIcYkl6+dtS1OVo4xMkKsL04oeOP/MdyK/wLiaWMivGOU8VktLhIW11WA==
X-Received: by 2002:ac8:4e2b:: with SMTP id d11mr33127629qtw.384.1629774363103; 
 Mon, 23 Aug 2021 20:06:03 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id m8sm9677653qkk.130.2021.08.23.20.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Aug 2021 20:06:02 -0700 (PDT)
From: CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <deng.changcheng@zte.com.cn>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH linux-next] selftests/powerpc: remove duplicate include
Date: Mon, 23 Aug 2021 20:05:50 -0700
Message-Id: <20210824030550.57467-1-deng.changcheng@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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
Cc: Zeal Robot <zealci@zte.com.cn>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-kselftest@vger.kernel.org, Changcheng Deng <deng.changcheng@zte.com.cn>,
 Shuah Khan <shuah@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Changcheng Deng <deng.changcheng@zte.com.cn>

Clean up the following includecheck warning:

./tools/testing/selftests/powerpc/tm/tm-poison.c: inttypes.h is included
more than once.

No functional change.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
---
 tools/testing/selftests/powerpc/tm/tm-poison.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/tm-poison.c b/tools/testing/selftests/powerpc/tm/tm-poison.c
index 29e5f26..27c083a 100644
--- a/tools/testing/selftests/powerpc/tm/tm-poison.c
+++ b/tools/testing/selftests/powerpc/tm/tm-poison.c
@@ -20,7 +20,6 @@
 #include <sched.h>
 #include <sys/types.h>
 #include <signal.h>
-#include <inttypes.h>
 
 #include "tm.h"
 
-- 
1.8.3.1


