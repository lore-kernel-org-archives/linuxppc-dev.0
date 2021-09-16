Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8963C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Sep 2021 14:23:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3954E61212
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Sep 2021 14:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3954E61212
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H9K7S3fs4z2yPQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Sep 2021 00:23:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H9K6z2zwdz2xv8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Sep 2021 00:22:48 +1000 (AEST)
Received: from ersatz.molgen.mpg.de (g45.guest.molgen.mpg.de [141.14.220.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id C00FB61E64761;
 Thu, 16 Sep 2021 16:22:39 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] lib/zlib_inflate/inffast: Check config in C to avoid unused
 function warning
Date: Thu, 16 Sep 2021 16:22:10 +0200
Message-Id: <20210916142210.26722-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.33.0
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
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, llvm@lists.linux.dev,
 Zhen Lei <thunder.leizhen@huawei.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Building Linux for ppc64le with Ubuntu clang version 12.0.0-3ubuntu1~21.04.1
shows the warning below.

    arch/powerpc/boot/inffast.c:20:1: warning: unused function 'get_unaligned16' [-Wunused-function]
    get_unaligned16(const unsigned short *p)
    ^
    1 warning generated.

Fix it, by moving the check from the preprocessor to C, so the compiler
sees the use.

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 lib/zlib_inflate/inffast.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
index f19c4fbe1be7..444ad3c3ccd3 100644
--- a/lib/zlib_inflate/inffast.c
+++ b/lib/zlib_inflate/inffast.c
@@ -254,11 +254,7 @@ void inflate_fast(z_streamp strm, unsigned start)
 			sfrom = (unsigned short *)(from);
 			loops = len >> 1;
 			do
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-			    *sout++ = *sfrom++;
-#else
-			    *sout++ = get_unaligned16(sfrom++);
-#endif
+			    *sout++ = CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS ? *sfrom++ : get_unaligned16(sfrom++);
 			while (--loops);
 			out = (unsigned char *)sout;
 			from = (unsigned char *)sfrom;
-- 
2.33.0

