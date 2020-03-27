Return-Path: <SRS0=yRDn=5M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDDDC43331
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2020 20:40:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEBB2206F1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2020 20:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vlVSkiGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEBB2206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48ptyS6XcNzDqkp
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Mar 2020 07:40:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=geoff@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=merlin.20170209 header.b=vlVSkiGz; 
 dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48ptg93tW5zDrJq
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Mar 2020 07:26:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Date:Cc:To:Subject:From:References:
 In-Reply-To:Message-Id:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=ccvRX8ZSStwztohfWoZirODP+RV3GhLZD0SpDIIFj1g=; b=vlVSkiGz9Y8MX9YjTKb/4/TykD
 y7fXD93pYA9n01Rg4Nlh6jY53y5x08Gk+WZWGrGuThXKBDGquB9DIh4PNnjE2SWPEm4lY6J0sIcHr
 P8YBlZ8XqDcDSy4rEWP/pkPipdyQNQ11CGMjOZqCAd0DzkD40thTmtOBCHWvu54CJSVkthH/khSOZ
 P38AP38UPPBlqKkWVIayakA38LDxFZVAbm3bqcpmg0qWE9IikFBuxgJyZEsSQXDdsZTCOlSI7rWzT
 DewwUGbvC3uXPbFxq6rOODBLs+n7GlshuzzWW2jpmHa7O0GKkZNWWvS0rKXdPma55nzYKaOU74zLe
 EhBRF6EQ==;
Received: from geoff by merlin.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jHvYd-0003J3-T9; Fri, 27 Mar 2020 20:26:23 +0000
Message-Id: <1333a8985c4190763c9c0312bcefad8b1ea863c7.1585340156.git.geoff@infradead.org>
In-Reply-To: <cover.1585340156.git.geoff@infradead.org>
References: <cover.1585340156.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Fri, 27 Mar 2020 13:07:31 -0700
Subject: [PATCH 9/9] powerpc/ps3: Add udbg_panic
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 27 Mar 2020 20:26:23 +0000
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
Cc: linuxppc-dev@lists.ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 Markus Elfring <elfring@users.sourceforge.net>,
 Dan Carpenter <dan.carpenter@oracle.com>,
 Emmanuel Nicolet <emmanuel.nicolet@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

BUG_ON() won't work in the early init code, so replace it with
a new routine udbg_panic() that uses udbg_printf() and lv1_panic().

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/powerpc/platforms/ps3/mm.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/ps3/mm.c b/arch/powerpc/platforms/ps3/mm.c
index 423be34f0f5f..7c7c2f53eacb 100644
--- a/arch/powerpc/platforms/ps3/mm.c
+++ b/arch/powerpc/platforms/ps3/mm.c
@@ -26,6 +26,13 @@
 #define DBG pr_devel
 #endif
 
+#define udbg_panic(_val, _msg) \
+if (_val) { \
+	udbg_printf("%s:%d: " _msg ": %d\n", \
+		__func__, __LINE__, (int)(_val)); \
+	lv1_panic(0); \
+}
+
 enum {
 #if defined(CONFIG_PS3_DYNAMIC_DMA)
 	USE_DYNAMIC_DMA = 1,
@@ -313,7 +320,7 @@ static void ps3_mm_region_destroy(struct mem_region *r)
 
 	if (r->base) {
 		result = lv1_release_memory(r->base);
-		BUG_ON(result);
+		udbg_panic(result, "lv1_release_memory failed");
 		r->size = r->base = r->offset = 0;
 		map.total = map.rm.size;
 	}
-- 
2.20.1

