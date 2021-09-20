Return-Path: <SRS0=EPkL=OK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF44C433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Sep 2021 08:44:54 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABEDE60F12
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Sep 2021 08:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABEDE60F12
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HCdR819sHz2ywc
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Sep 2021 18:44:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=molgen.mpg.de (client-ip=141.14.17.11; helo=mx1.molgen.mpg.de;
 envelope-from=pmenzel@molgen.mpg.de; receiver=<UNKNOWN>)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HCdQh4Kthz2yKF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Sep 2021 18:44:28 +1000 (AEST)
Received: from localhost.localdomain (ip5f5aef72.dynamic.kabel-deutschland.de
 [95.90.239.114])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3FBA161E5FE33;
 Mon, 20 Sep 2021 10:44:25 +0200 (CEST)
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3] lib/zlib_inflate/inffast: Check config in C to avoid
 unused function warning
Date: Mon, 20 Sep 2021 10:43:33 +0200
Message-Id: <20210920084332.5752-1-pmenzel@molgen.mpg.de>
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
v2: Use IS_ENABLED
v3: Use if statement over ternary operator as requested by Christophe

 lib/zlib_inflate/inffast.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/lib/zlib_inflate/inffast.c b/lib/zlib_inflate/inffast.c
index f19c4fbe1be7..2843f9bb42ac 100644
--- a/lib/zlib_inflate/inffast.c
+++ b/lib/zlib_inflate/inffast.c
@@ -253,13 +253,12 @@ void inflate_fast(z_streamp strm, unsigned start)
 
 			sfrom = (unsigned short *)(from);
 			loops = len >> 1;
-			do
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-			    *sout++ = *sfrom++;
-#else
-			    *sout++ = get_unaligned16(sfrom++);
-#endif
-			while (--loops);
+			do {
+			    if (IS_ENABLED(CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS))
+				*sout++ = *sfrom++;
+			    else
+				*sout++ = get_unaligned16(sfrom++);
+			} while (--loops);
 			out = (unsigned char *)sout;
 			from = (unsigned char *)sfrom;
 		    } else { /* dist == 1 or dist == 2 */
-- 
2.33.0

