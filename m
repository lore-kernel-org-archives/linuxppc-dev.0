Return-Path: <SRS0=yMLg=3F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2E5C32771
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 01:58:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DA62084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 01:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="AJ6WIRIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DA62084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47ynQk3RW1zDqBy
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 12:58:06 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47ynCC6fWVzDqGM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2020 12:48:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=AJ6WIRIr; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 47ynCC4RVtz9sR0; Thu, 16 Jan 2020 12:48:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47ynCC2jRBz9sPW; Thu, 16 Jan 2020 12:48:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1579139287;
 bh=4P71+1AmChjmbDWdLc8e4bmEySVaKx76IqbtF519OgE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AJ6WIRIrF5IbFooewM45sk3wdHag+WHZP4HJR6VvsmCQsp+8CS6YfcjyLHxBsb0fp
 Y4wWJ3p0fr1wNiJTiqmdAJiZcZJJ7mRB6/jaAHS9aEEQGIHYZhVy4GbZuBT6Q8mjO1
 PRTHEqhimE63T2vt72BEZR+oK9gCp9GYyynt3IRK0SJq8qULSGnf1H0ludkSG6btG2
 xHrcHHxwHe5H3SWoRx3g94Z2PPWXWuEYjasSgJ7ZmRVBS6S7P/dPcUHd5HGv7EXI/F
 1hA1bsKBYWD+cQgBRCcv/AEjIIljV0O92/3rvx1TJjnXlCDR3LXpuNHgbbCflWzcT4
 ZFYhmyCCgxXEw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/9] powerpc/configs/skiroot: Drop default n
 CONFIG_CRYPTO_ECHAINIV
Date: Thu, 16 Jan 2020 11:48:04 +1000
Message-Id: <20200116014808.15756-5-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200116014808.15756-1-mpe@ellerman.id.au>
References: <20200116014808.15756-1-mpe@ellerman.id.au>
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
Cc: joel@jms.id.au, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

It's default n so we don't need to disable it.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/skiroot_defconfig | 1 -
 1 file changed, 1 deletion(-)

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

