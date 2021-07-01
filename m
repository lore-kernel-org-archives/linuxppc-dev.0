Return-Path: <SRS0=ZiU1=LZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EFFC11F64
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 12:50:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5038A6140D
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 12:50:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5038A6140D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GFykR5Xsqz3bjW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Jul 2021 22:50:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=VoKnAQoc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=VoKnAQoc; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GFyk06zS9z2ypn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Jul 2021 22:50:32 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GFyjz6Ljjz9sX5; Thu,  1 Jul 2021 22:50:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1625143831;
 bh=tbYJ2am5iPPSCxKGbyTzZbv5ZR6aV1TXfixQcYpWFIg=;
 h=From:To:Cc:Subject:Date:From;
 b=VoKnAQockLt4SLhwY8+5+WJ1mFsh1vGh0ZWWuB4CXEnFMY0tTMRNlJEtyMaQaSDxm
 kDeHB6l1CHV3WUgmhTYjgHLwP78BtqqKWltej+rqOGJM3o4pKAuZYyrrCbydQklcZT
 TPUiJmly4/1I9TgQpu43fHzQnHxyFnoYZKfJbtxFrcdgKawRpQR66680/3lLI57BXH
 CZR1x/0uv1uGfsW6x+jYCpJt7TP6tp+aT2KemskpnMvvR5XMx5Rs93PX2CgRNr9zG9
 pUkQxdDPPMmti5pSm9f5UpnVaRjusqSzO9Bd0NTqRVqBcfj6f5WEPu3aji8u9sHZm7
 BiXGO4D6AiqcA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Only build restart_table.c for 64s
Date: Thu,  1 Jul 2021 22:50:26 +1000
Message-Id: <20210701125026.292224-1-mpe@ellerman.id.au>
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 9b69d48c7516 ("powerpc/64e: remove implicit soft-masking and
interrupt exit restart logic") limited the implicit soft masking and
restart logic to 64-bit Book3S only. However we are still building
restart_table.c for all 64-bit, ie. Book3E also.

There's no need to build it for 64e, and it also causes missing
prototype warnings for 64e builds, because the prototype is already
behind an #ifdef PPC_BOOK3S_64.

Fixes: 9b69d48c7516 ("powerpc/64e: remove implicit soft-masking and interrupt exit restart logic")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 4c92c80454f3..99a7c9132422 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -39,10 +39,10 @@ extra-$(CONFIG_PPC64)	+= crtsavres.o
 endif
 
 obj-$(CONFIG_PPC_BOOK3S_64) += copyuser_power7.o copypage_power7.o \
-			       memcpy_power7.o
+			       memcpy_power7.o restart_table.o
 
 obj64-y	+= copypage_64.o copyuser_64.o mem_64.o hweight_64.o \
-	   memcpy_64.o copy_mc_64.o restart_table.o
+	   memcpy_64.o copy_mc_64.o
 
 ifndef CONFIG_PPC_QUEUED_SPINLOCKS
 obj64-$(CONFIG_SMP)	+= locks.o
-- 
2.25.1

