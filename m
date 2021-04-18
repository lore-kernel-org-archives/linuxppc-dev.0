Return-Path: <SRS0=Xpyi=JP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE0E3C433B4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Apr 2021 13:17:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CA026109F
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Apr 2021 13:17:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA026109F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNVq26zjBz3c2d
	for <linuxppc-dev@archiver.kernel.org>; Sun, 18 Apr 2021 23:17:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=rTttSofe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=rTttSofe; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNVpZ6tM4z2yyj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Apr 2021 23:16:54 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FNVpS0MJRz9vFw; Sun, 18 Apr 2021 23:16:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1618751808;
 bh=D/YG+dioCETaFGj5wbGEbbu4JVN0q/1ty1G4Keh16/I=;
 h=From:To:Subject:Date:From;
 b=rTttSofennFoFmQ9vaLjc2wvIdybImuMQjdozhFgnsFNSkipMjES5xkIpbmxPftXz
 o0PJlqhx8Dms/bXGUUGJOOitRrU9AzogZhk7hCG2ZEl/zW8IVLm/khxwvYyUfc98Jm
 DNShAKoGYJvyjk1mgF0ZnUMSDTmbdNGSBmrvVuC0JJGWqVMVkWyc27LSSycd4qKGpC
 rrdQlWdQTtattaP30r6To0nRRFOoIdP/R2HYBh5Q/l+eIHXNOhjU24yxsd3e9x83rf
 3/C4/gWcjoUN1APcVg27Vq+pPitThDfPzdAp9dRXy1Dxq2BPfAPmreVH9fY8Yfmc2T
 Trq9HsffXd7zQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Only define _TASK_CPU for 32-bit
Date: Sun, 18 Apr 2021 23:16:41 +1000
Message-Id: <20210418131641.1186227-1-mpe@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We have some interesting code in our Makefile to define _TASK_CPU, based
on awk'ing the value out of asm-offsets.h. It exists to circumvent some
circular header dependencies that prevent us from referring to
task_struct in the relevant code. See the comment around _TASK_CPU in
smp.h for more detail.

Maybe one day we can come up with a better solution, but for now we can
at least limit that logic to 32-bit, because it's not needed for 64-bit.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 32dd693b4e42..3212d076ac6a 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -438,12 +438,15 @@ endif
 endif
 
 ifdef CONFIG_SMP
+ifdef CONFIG_PPC32
 prepare: task_cpu_prepare
 
 PHONY += task_cpu_prepare
 task_cpu_prepare: prepare0
 	$(eval KBUILD_CFLAGS += -D_TASK_CPU=$(shell awk '{if ($$2 == "TASK_CPU") print $$3;}' include/generated/asm-offsets.h))
-endif
+
+endif # CONFIG_PPC32
+endif # CONFIG_SMP
 
 PHONY += checkbin
 # Check toolchain versions:
-- 
2.25.1

