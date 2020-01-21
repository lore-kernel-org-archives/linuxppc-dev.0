Return-Path: <SRS0=KLET=3K=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05CBC33CAA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 04:38:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61778217F4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 04:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Bhjm1me2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61778217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 481wl54kVRzDqJh
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Jan 2020 15:38:09 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 481wYr6hDrzDqWw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2020 15:30:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Bhjm1me2; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 481wYr45t5z9sP6; Tue, 21 Jan 2020 15:30:08 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 481wYr1jpHz9sRk; Tue, 21 Jan 2020 15:30:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1579581008;
 bh=haN7MBkI5CQF1PWVymxQBG/JRY2NLVsYH2dm+0uumPY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Bhjm1me2cIHeTfGd8lsY7mk79X9hEpDnfb369u936XjsEJJ/K/oktlvwOns/6/pN9
 0G6EOS/jZfsFWQ8G+O9ledQ8of1vERhSLCZdGu6kbhqBHQAOAgsXoeik0of1FGfUTN
 5gCHfkgko9M6+cpDUpkwpYkgzKJ82/06/zNvKrLk5OYfqyTusIuHY+1Ux1K1tEIEXl
 0c8bPnf2fs3Z9MjbN9SGzE47s6k4GuVmN+0/w0MveTlSS3TXkE8gkN5tLZzzQWZmFh
 XqOq/m8cn/mBAP4rIEWgakQy0x4vF+ZHVlw90e7Vix8t/NO/PHgi+N07TqEikLBh3F
 9GWecH6Vb2J7g==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2 05/10] powerpc/configs/skiroot: Drop default n
 CONFIG_CRYPTO_ECHAINIV
Date: Tue, 21 Jan 2020 15:29:55 +1100
Message-Id: <20200121043000.16212-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200121043000.16212-1-mpe@ellerman.id.au>
References: <20200121043000.16212-1-mpe@ellerman.id.au>
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
Cc: oohall@gmail.com, joel@jms.id.au, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It's default n so we don't need to disable it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/skiroot_defconfig | 1 -
 1 file changed, 1 deletion(-)

v2: No change.

diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 74cffb854c0f..0aa060eef06c 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -293,5 +293,4 @@ CONFIG_WQ_WATCHDOG=y
 CONFIG_XMON=y
 CONFIG_XMON_DEFAULT=y
 CONFIG_ENCRYPTED_KEYS=y
-# CONFIG_CRYPTO_ECHAINIV is not set
 # CONFIG_CRYPTO_HW is not set
-- 
2.21.1

