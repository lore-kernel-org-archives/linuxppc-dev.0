Return-Path: <SRS0=yMLg=3F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025EFC32771
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 01:52:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A974D2084D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 01:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="Yt5unIuT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A974D2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47ynJ62n24zDqTY
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 12:52:22 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47ynC92kWgzDqNG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jan 2020 12:48:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=Yt5unIuT; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix)
 id 47ynC906ytz9sR4; Thu, 16 Jan 2020 12:48:05 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47ynC86S1hz9sRQ; Thu, 16 Jan 2020 12:48:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1579139284;
 bh=BtmfzVFDau46OXa54kU9h6IMBSO9EAgh219JXQ6Eh8g=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Yt5unIuTj2FA/Vqkokxc4P4QeOvTU2R36e/GLnIHwddkjqiX02scI8zXQmQ1OExL7
 LYqcOOJigQ45iI9KQCpvHu1R22OUu0H6oet7JLX9Ad1TfCAFwK4OnvIPHL1xd1tt11
 oZdFxIFlcSq5TXEfcTZiiNg70ASXWiySXJ2pxpaqSmQtNacorgA7AjU94ce7SZro9e
 M6HATseRoImHeFtmYcOtiTshDljlf9VrFuXwNHpIkIAO/SUFg9TksioC231l7mZOX2
 E8ThkY9Vi2LSBcR4qbbQKPQnTi6QDqP+BUibCZQIKqH/olDirdGM/tWwJXfWP9/Tfs
 rLhyGt5th6sZg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/9] powerpc/configs: NET_CADENCE became NET_VENDOR_CADENCE
Date: Thu, 16 Jan 2020 11:48:01 +1000
Message-Id: <20200116014808.15756-2-mpe@ellerman.id.au>
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

The NET_CADENCE symbol was renamed to NET_VENDOR_CADENCE, so we don't
need to disable the former, see commit 0df5f81c481e ("net: ethernet:
Add missing VENDOR to Cadence and Packet Engines symbols").

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/configs/skiroot_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 7ff1ff1ddc28..eaaffe9ae8b9 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -138,7 +138,6 @@ CONFIG_TIGON3=m
 CONFIG_BNX2X=m
 # CONFIG_NET_VENDOR_BROCADE is not set
 # CONFIG_NET_VENDOR_CADENCE is not set
-# CONFIG_NET_CADENCE is not set
 # CONFIG_NET_VENDOR_CAVIUM is not set
 CONFIG_CHELSIO_T1=m
 # CONFIG_NET_VENDOR_CISCO is not set
-- 
2.21.1

