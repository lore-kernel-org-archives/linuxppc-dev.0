Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB98C001B0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Aug 2023 14:22:55 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cqgKhGl2;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RM8KB2vHCz3cGw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Aug 2023 00:22:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=cqgKhGl2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RM8J83B43z30XV
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Aug 2023 00:22:00 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 59F7C65D8B;
	Thu, 10 Aug 2023 14:21:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD33C433C7;
	Thu, 10 Aug 2023 14:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691677315;
	bh=NTZhJvX8Fa33MdPPJUJFrTri4+p2YZpKQVbTmgUMKFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cqgKhGl2DoUwkrH27k0CfFHk4cjsMWCn+krIYRRadLbq/26dDO7M63XU2OA6RddWv
	 dgIEDaGkr6CDt72ElTPqXoJmXpAzgguxwGmQcd5u+eXPiPrL0cRnTikIRskZp2XvBc
	 qTC7ATNWHQdPUOVM8mxtsTB9A0G5Fan2dsnq1Ka109cwdlI1qNdKtZupKFKxnIX2Jb
	 /ig+h6oo/9A1LKlxYouXUcTmsuAYmoLl/W1cxZBwBiWDSBWEqEYazRTK3Pp+zOHoi+
	 UPC4NKD8NVlpxXQu/Ksklwbi1HCt/mESFyGS970fgg4jU7F3MYgbxidp3qiaT43kji
	 WgekgZXFjYdeA==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/17] macintosh/ams: mark ams_init() static
Date: Thu, 10 Aug 2023 16:19:24 +0200
Message-Id: <20230810141947.1236730-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810141947.1236730-1-arnd@kernel.org>
References: <20230810141947.1236730-1-arnd@kernel.org>
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
Cc: linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Arnd Bergmann <arnd@arndb.de>

This is the module init function, which by definition is used only
locally, so mark it static to avoid a warning:

drivers/macintosh/ams/ams-core.c:179:12: error: no previous prototype for 'ams_init' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/macintosh/ams/ams-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/macintosh/ams/ams-core.c b/drivers/macintosh/ams/ams-core.c
index 877e8cb231283..c978b4272daa5 100644
--- a/drivers/macintosh/ams/ams-core.c
+++ b/drivers/macintosh/ams/ams-core.c
@@ -176,7 +176,7 @@ int ams_sensor_attach(void)
 	return result;
 }
 
-int __init ams_init(void)
+static int __init ams_init(void)
 {
 	struct device_node *np;
 
-- 
2.39.2

