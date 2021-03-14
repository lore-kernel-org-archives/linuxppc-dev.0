Return-Path: <SRS0=qxeE=IM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E16C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 09:34:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2807D64EBA
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 09:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2807D64EBA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DyvWj5x5Vz3dM0
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Mar 2021 20:34:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=c+deRtUe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=c+deRtUe; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DyvW36Zq0z3dCx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Mar 2021 20:33:35 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4DyvW33838z9sR4; Sun, 14 Mar 2021 20:33:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1615714415;
 bh=A3FEZPyBU8ypKpQ8pO2BjXIWHcM3y5KyOsdpY57DTjg=;
 h=From:To:Subject:Date:From;
 b=c+deRtUeRqAzl4eRr7v5+BrcJvn7WUNRnZClvhQrMgEVNuYHVIU6JOoUyKiu93n0I
 O7msYW7I8F3h2cE2KAZVgEASZWZfd/iBK3JdQ7kbQxJmx98lJoDoPHMpJq3UZ0xXSD
 yTWhK77M4o8VeJqj1ygMq4JLGAorlO85y4Z0Mktk27t+HrFdBteIoOjRNhQjjXgBjt
 eICxZtxVG+mltxWuchZIL80ICSYiBt27gutYqUjplbSJ3nO+Myr6EI3zUdhqXRCXfR
 s3BBXG1avS8soKkSe1qA22W9iveFbL/gMThcE3oJt7lE0dtq3DY21IGhSLMW4PFhRJ
 v/N8zaJZUTvNA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix section mismatch warning in smp_setup_pacas()
Date: Sun, 14 Mar 2021 20:33:33 +1100
Message-Id: <20210314093333.132657-1-mpe@ellerman.id.au>
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

Section mismatch in reference from the function .smp_setup_pacas() to
the function .init.text:.allocate_paca()

The only caller of smp_setup_pacas() is setup_arch() which is __init,
so mark smp_setup_pacas() __init.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/setup-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index bee984b1887b..55caaa211b9f 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -829,7 +829,7 @@ static __init void print_system_info(void)
 }
 
 #ifdef CONFIG_SMP
-static void smp_setup_pacas(void)
+static void __init smp_setup_pacas(void)
 {
 	int cpu;
 
-- 
2.25.1

