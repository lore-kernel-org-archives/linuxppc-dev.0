Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BC8FC4332F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Nov 2023 01:19:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4STBR52gcxz3clB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Nov 2023 12:19:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nfschina.com (client-ip=42.101.60.195; helo=mail.nfschina.com; envelope-from=zeming@nfschina.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 137 seconds by postgrey-1.37 at boromir; Mon, 13 Nov 2023 12:18:44 AEDT
Received: from mail.nfschina.com (unknown [42.101.60.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4STBQX0YH0z2xrD
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2023 12:18:43 +1100 (AEDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 5CB506031E5A3;
	Mon, 13 Nov 2023 09:15:45 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: fbarrat@linux.ibm.com,
	ajd@linux.ibm.com,
	arnd@arndb.de,
	gregkh@linuxfoundation.org
Subject: [PATCH] misc: ocxl: context: Remove unnecessary (void*) conversions
Date: Mon, 13 Nov 2023 09:15:43 +0800
Message-Id: <20231113011543.6940-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Li zeming <zeming@nfschina.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The ctx pointer does not need to cast the type.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 drivers/misc/ocxl/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/context.c b/drivers/misc/ocxl/context.c
index 7f83116ae11a6..cded7d1caf328 100644
--- a/drivers/misc/ocxl/context.c
+++ b/drivers/misc/ocxl/context.c
@@ -55,7 +55,7 @@ EXPORT_SYMBOL_GPL(ocxl_context_alloc);
  */
 static void xsl_fault_error(void *data, u64 addr, u64 dsisr)
 {
-	struct ocxl_context *ctx = (struct ocxl_context *) data;
+	struct ocxl_context *ctx = data;
 
 	mutex_lock(&ctx->xsl_error_lock);
 	ctx->xsl_error.addr = addr;
-- 
2.18.2

