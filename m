Return-Path: <SRS0=5tyt=IO=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55914C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 07:34:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B13264FB5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 07:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B13264FB5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F04mP6tSBz30Bl
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Mar 2021 18:34:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=SdXcCZp5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::643;
 helo=mail-pl1-x643.google.com; envelope-from=menglong8.dong@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=SdXcCZp5; dkim-atps=neutral
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F04lw61y8z2yjK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 18:33:46 +1100 (AEDT)
Received: by mail-pl1-x643.google.com with SMTP id a13so1431613pln.8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Mar 2021 00:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4uwGLw4oyBg2siguHNzqzxEJ2zioYts2IjBxF9nVxAg=;
 b=SdXcCZp5eAj0eG7le1UodFJ9kJpKFCcQXFQp8y9qS8SdgjuQUyQtykgdEoNmnyyzKW
 IQ1GtYSUBCwWSC3WBh0bAoZ1T7a7sfvhhxTRkgQjODrJjpZBbfucYpPO1DICYL7y46U5
 kVnaM9dnC+obTvaD/Pyd4n4TjkZkW4PzW+0l8hSS3H3HbX+yTGRz1cuTTefF98kwU7/9
 9jyskWUQbxOckPjq60RBOooNAgPyiBqm2eqoD6AYFhZoYW7UqkZI+ejXh2XmO80BklJ8
 C/uD2l2ry6DUrtnjfwjnWoB4JMxx2v6vYiNyXeiSwuyG9FbMSR2nPHCgnDmBRLpNRsXe
 6uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4uwGLw4oyBg2siguHNzqzxEJ2zioYts2IjBxF9nVxAg=;
 b=DegMhk5KY2xAeJHw1Sz5oQEyvXry2Hu6ZLeqQaRw5+lfFidUi+OaD360+i4k3ueyoN
 I68bAJLyMydjy2uJhnDqne4a3Whfyx8hfgCnynYv7Kxo9vXz5ORW4FSovSXv0w6mI8TR
 VW1DmPogX4eKGO4gb9K8LZ+RU/au0mLF5KD+RpYONytWFnLEu1IHQO/PDcUvT6UEJ3tF
 xaFJnjIQ2GO/TkN0Hd3QXc1DC/ORAZWGkUtfur7fnFfkWcgyqzZ9brG22alwOnUt1bGy
 XK8lgatl3azylTCX6N7i6zmZw1u/YwaV+3AI+umhp30zTKH6ysNTGoV569t0+4063TQh
 mHaA==
X-Gm-Message-State: AOAM530ppR8AazYxzrECFi/H4YSPKZegUStJ8h+vYpj4MdwlFJYYaLc6
 HpOBhTSul6ADeLHxFQEvnfw=
X-Google-Smtp-Source: ABdhPJz2vO1LkuhskFr46Ba09gSjtiCwL5zhzdrTzGXkiqsvd3q1KCoj2T2CQeDKwYaintJT/FE2Ew==
X-Received: by 2002:a17:90a:cb12:: with SMTP id
 z18mr3298352pjt.132.1615880023387; 
 Tue, 16 Mar 2021 00:33:43 -0700 (PDT)
Received: from localhost.localdomain ([178.236.46.205])
 by smtp.gmail.com with ESMTPSA id d20sm1850131pjv.47.2021.03.16.00.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Mar 2021 00:33:42 -0700 (PDT)
From: menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To: pbonzini@redhat.com
Subject: [PATCH] selftests: remove duplicate include
Date: Tue, 16 Mar 2021 00:33:36 -0700
Message-Id: <20210316073336.426255-1-zhang.yunkai@zte.com.cn>
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
Cc: kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, zhang.yunkai@zte.com.cn, paulus@samba.org,
 linux-kselftest@vger.kernel.org, akpm@linux-foundation.org,
 ricardo.canuelo@collabora.com, shuah@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'assert.h' included in 'sparsebit.c' is duplicated.
It is also included in the 161th line.
'string.h' included in 'mincore_selftest.c' is duplicated.
It is also included in the 15th line.
'sched.h' included in 'tlbie_test.c' is duplicated.
It is also included in the 33th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 tools/testing/selftests/kvm/lib/sparsebit.c        | 1 -
 tools/testing/selftests/mincore/mincore_selftest.c | 1 -
 tools/testing/selftests/powerpc/mm/tlbie_test.c    | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/sparsebit.c b/tools/testing/selftests/kvm/lib/sparsebit.c
index 031ba3c932ed..a0d0c83d83de 100644
--- a/tools/testing/selftests/kvm/lib/sparsebit.c
+++ b/tools/testing/selftests/kvm/lib/sparsebit.c
@@ -1890,7 +1890,6 @@ void sparsebit_validate_internal(struct sparsebit *s)
  */
 
 #include <stdlib.h>
-#include <assert.h>
 
 struct range {
 	sparsebit_idx_t first, last;
diff --git a/tools/testing/selftests/mincore/mincore_selftest.c b/tools/testing/selftests/mincore/mincore_selftest.c
index 5a1e85ff5d32..e54106643337 100644
--- a/tools/testing/selftests/mincore/mincore_selftest.c
+++ b/tools/testing/selftests/mincore/mincore_selftest.c
@@ -14,7 +14,6 @@
 #include <sys/mman.h>
 #include <string.h>
 #include <fcntl.h>
-#include <string.h>
 
 #include "../kselftest.h"
 #include "../kselftest_harness.h"
diff --git a/tools/testing/selftests/powerpc/mm/tlbie_test.c b/tools/testing/selftests/powerpc/mm/tlbie_test.c
index f85a0938ab25..48344a74b212 100644
--- a/tools/testing/selftests/powerpc/mm/tlbie_test.c
+++ b/tools/testing/selftests/powerpc/mm/tlbie_test.c
@@ -33,7 +33,6 @@
 #include <sched.h>
 #include <time.h>
 #include <stdarg.h>
-#include <sched.h>
 #include <pthread.h>
 #include <signal.h>
 #include <sys/prctl.h>
-- 
2.25.1

