Return-Path: <SRS0=nnl5=M5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DBF8ECDE32
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 19:29:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60FBD213A2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Oct 2018 19:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVpKLd9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60FBD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42b2Kr6Q9hzF3YJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Oct 2018 06:29:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WVpKLd9o";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::441; helo=mail-wr1-x441.google.com;
 envelope-from=mathieu.malaterre@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WVpKLd9o"; 
 dkim-atps=neutral
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42b2GS3FxnzF3Yx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Oct 2018 06:26:07 +1100 (AEDT)
Received: by mail-wr1-x441.google.com with SMTP id g15-v6so30960747wru.9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Oct 2018 12:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jqjlq7mZDerPRopuOpz2ST/dUsC5C43Ae0k8tEaHxas=;
 b=WVpKLd9opJWWrBExvYR/Ah4pvuPR29lQ3A4oaXnUdHlGtAKS2qTWHy6O7MCIhvSU1z
 fLdbqYa+BTpJvI5qYHUAXFinmqoBNwz5jERurXWsyqIMbFQebLU7XRvVCwywksVU1N8U
 NTftiJf6utYTcHqE6I9ae8lrVGMwIoNT5NDBUk9XXkjGaEMzOmpo3RbeMYuQukVbCLsY
 NcbwWI3iRTqDSCqpqyey/4PT3Nm1HWlzMqP9XXNVZm0k3BNngQS/pTtyjm+Srcl9Ai85
 GbZRCsU0R1IaDTozkRBwksfBMpSNu6BjvdgG9k7xlErerAzgafu9LwVUGELesDHYE045
 JOtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=jqjlq7mZDerPRopuOpz2ST/dUsC5C43Ae0k8tEaHxas=;
 b=g91HeBKPeZkSSZI1ouFFXhHPzFIzYiWYm/eK//pOGoc+n2EhuZ8PyeTyAzZ2ybd09Q
 pDgyDGY3ggmkFIWzXzXxuUj4rwo7wt7m/JHfZ0vJ1AD494HGAtS4pu7jPE4BjIFY5Kq3
 qpgLDskrlbsLeCKGiJ3WnN+rEV1aogY8bfN2/JlZt5/94FMdSUdhNXouXweLHdZ+QPV7
 EEHwIqUuoD4+SfEZK8j/4f8R+5s9skp8D/xE68S6CuMeQQ94Ml9YugO+PjtpozJzZT1M
 XZMzZ18oeHzHTsnq2BIrFcpGzshrjjgYytTlxHg+AwBOHuFD5AdFGfN4bkTIpEbpc+Hj
 Sgww==
X-Gm-Message-State: ABuFfoi4A0ZN9ZpiPlCEzXDhOXwMeGn31miZk9TxVUSalAfGPy5diJNy
 gYbKj1kPIVPTH5xLHimoZKs=
X-Google-Smtp-Source: ACcGV612E9OUbPufP0Ft4lULmNOCb4sLe2L7KWXwfQVwTNdX0kwbYmVfmMyaUuhOQvlTQZxzWHc9rQ==
X-Received: by 2002:a5d:620b:: with SMTP id
 y11-v6mr24939393wru.105.1539804364985; 
 Wed, 17 Oct 2018 12:26:04 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-224-134.fbx.proxad.net.
 [78.225.224.134])
 by smtp.gmail.com with ESMTPSA id t66-v6sm1678872wmt.5.2018.10.17.12.26.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 17 Oct 2018 12:26:04 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
 id A140111439C3; Wed, 17 Oct 2018 21:26:02 +0200 (CEST)
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH] powerpc: Add missing include <asm/stacktrace.h>
Date: Wed, 17 Oct 2018 21:25:58 +0200
Message-Id: <20181017192558.8039-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
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
Cc: Mathieu Malaterre <malat@debian.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit 88b0fe175735 ("powerpc: Add show_user_instructions()") the
function show_user_instructions was added.

This commit adds an include of header file <asm/stacktrace.h> to provide
the missing function prototype. Silence the following gcc warning
(treated as error with W=1):

  arch/powerpc/kernel/process.c:1302:6: error: no previous prototype for ‘show_user_instructions’ [-Werror=missing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/kernel/process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index bb6ac471a784..1c64491e9702 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -65,6 +65,7 @@
 #include <asm/livepatch.h>
 #include <asm/cpu_has_feature.h>
 #include <asm/asm-prototypes.h>
+#include <asm/stacktrace.h>
 
 #include <linux/kprobes.h>
 #include <linux/kdebug.h>
-- 
2.11.0

