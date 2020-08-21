Return-Path: <SRS0=lwUg=B7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26019C433E1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:51:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE7362072D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 10:51:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Ic7CLE8C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE7362072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BXyx433kszDr7j
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Aug 2020 20:51:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BXytz0qR7zDr7h
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Aug 2020 20:49:15 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Ic7CLE8C; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 4BXyty5nYhz9sPB; Fri, 21 Aug 2020 20:49:14 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BXyty4jRtz9sTF; Fri, 21 Aug 2020 20:49:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1598006954;
 bh=JjpyRpHNHrdiIzB9HKYK2tJlfybxA7SBXGzOln4SAMw=;
 h=From:To:Cc:Subject:Date:From;
 b=Ic7CLE8CPil48dGMD59EwPqX1s8aafqB7yJvTRAPHkKoPZ7HLlxoyS0nMl7zdulkj
 ExYnaonEXl3hzV0BTmnOb2Ry5nlfoPtDrmfSFE9RbKjyJBIYcVColR+aOk0UNk9sKG
 b084LseD3EL+ywDMxlZrwJagpafnb3wEguhoBrUcQO4BfdiZXlrQIXCgHlTcV/FSE7
 MjbzyYJgdHhUMwTGK0fuTIKxThwXnKxzPURLTeDp+f0Qdvb7UBF8y+Y8jzlCBc/SNP
 wm4Bsqs7ksBNF7fXmUV3a2bBq6RUUFIbB+s39oMVvjMa2Uu90436E5VCa6JNwOtecE
 BheYKTYIX0DhQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] video: fbdev: controlfb: Fix build for COMPILE_TEST=y &&
 PPC_PMAC=n
Date: Fri, 21 Aug 2020 20:49:10 +1000
Message-Id: <20200821104910.3363818-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-fbdev@vger.kernel.org, b.zolnierkie@samsung.com,
 daniel.vetter@ffwll.ch, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, sam@ravnborg.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The build is currently broken, if COMPILE_TEST=y and PPC_PMAC=n:

  linux/drivers/video/fbdev/controlfb.c: In function ‘control_set_hardware’:
  linux/drivers/video/fbdev/controlfb.c:276:2: error: implicit declaration of function ‘btext_update_display’
    276 |  btext_update_display(p->frame_buffer_phys + CTRLFB_OFF,
        |  ^~~~~~~~~~~~~~~~~~~~

Fix it by including btext.h whenever CONFIG_BOOTX_TEXT is enabled.

Fixes: a07a63b0e24d ("video: fbdev: controlfb: add COMPILE_TEST support")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/video/fbdev/controlfb.c | 2 ++
 1 file changed, 2 insertions(+)

Does anyone mind if I apply this via the powerpc tree for v5.9?

It would be nice to get the build clean.

cheers

diff --git a/drivers/video/fbdev/controlfb.c b/drivers/video/fbdev/controlfb.c
index 9c4f1be856ec..547abeb39f87 100644
--- a/drivers/video/fbdev/controlfb.c
+++ b/drivers/video/fbdev/controlfb.c
@@ -49,6 +49,8 @@
 #include <linux/cuda.h>
 #ifdef CONFIG_PPC_PMAC
 #include <asm/prom.h>
+#endif
+#ifdef CONFIG_BOOTX_TEXT
 #include <asm/btext.h>
 #endif
 
-- 
2.25.1

