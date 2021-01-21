Return-Path: <SRS0=iciS=GY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0B4C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 08:12:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0E642395B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 08:12:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0E642395B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DLw9R30ZGzDr7h
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Jan 2021 19:12:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+5b2bf2cc950c4867fd89+6360+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=ESsvgyjn; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DLvp23mkPzDqpC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2021 18:55:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=pDVrAQODm5MVEOopuQVfAeRLjXskf/bF8mZuyUX3ZZA=; b=ESsvgyjnfo/9h/O2QrIVrOVh84
 ID9uydF9M6oVObzA4HwZIF2bshL9psjwIVVdtPWQ/mdl0u8LY3qvS7nICXTvlcW7QeM59CgSH59+p
 YESRp7AANijbNBaGAmHcLzVAMjg3lDja22MN+wJoMI8zbcyGLzidqoq3DKxSInB1fqf74hlcw21f/
 x5aJ3fvDnaCs3vxzpvN5EN+olckdQCRPXhYgCHNeMY0LQXN1vuuWGzgWQjP+0Ngp7q8gEsOjrWjRC
 95zxt51w7ULeLNJEMQWrF7PaiEDebcNM4yw3K064lypfQASrIv/oD1Z5d106G2azwZTRPyMrHvh7m
 EwmMp5gQ==;
Received: from [2001:4bb8:188:1954:d5b3:2657:287:e45f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l2Unz-00Gm9t-Ky; Thu, 21 Jan 2021 07:55:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Frederic Barrat <fbarrat@linux.ibm.com>,
 Andrew Donnellan <ajd@linux.ibm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Jessica Yu <jeyu@kernel.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>,
 Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>
Subject: [PATCH 08/13] drm: remove drm_fb_helper_modinit
Date: Thu, 21 Jan 2021 08:49:54 +0100
Message-Id: <20210121074959.313333-9-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210121074959.313333-1-hch@lst.de>
References: <20210121074959.313333-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Michal Marek <michal.lkml@markovi.net>, linux-kbuild@vger.kernel.org,
 Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, live-patching@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

drm_fb_helper_modinit has a lot of boilerplate for what is not very
simple functionality.  Just open code it in the only caller using
IS_ENABLED and IS_MODULE.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/drm_crtc_helper_internal.h | 10 ---------
 drivers/gpu/drm/drm_fb_helper.c            | 16 -------------
 drivers/gpu/drm/drm_kms_helper_common.c    | 26 +++++++++++-----------
 3 files changed, 13 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/drm_crtc_helper_internal.h b/drivers/gpu/drm/drm_crtc_helper_internal.h
index 25ce42e799952c..61e09f8a8d0ff0 100644
--- a/drivers/gpu/drm/drm_crtc_helper_internal.h
+++ b/drivers/gpu/drm/drm_crtc_helper_internal.h
@@ -32,16 +32,6 @@
 #include <drm/drm_encoder.h>
 #include <drm/drm_modes.h>
 
-/* drm_fb_helper.c */
-#ifdef CONFIG_DRM_FBDEV_EMULATION
-int drm_fb_helper_modinit(void);
-#else
-static inline int drm_fb_helper_modinit(void)
-{
-	return 0;
-}
-#endif
-
 /* drm_dp_aux_dev.c */
 #ifdef CONFIG_DRM_DP_AUX_CHARDEV
 int drm_dp_aux_dev_init(void);
diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index ce6d63ca75c32a..0b9f1ae1b7864c 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2499,19 +2499,3 @@ void drm_fbdev_generic_setup(struct drm_device *dev,
 	drm_client_register(&fb_helper->client);
 }
 EXPORT_SYMBOL(drm_fbdev_generic_setup);
-
-/* The Kconfig DRM_KMS_HELPER selects FRAMEBUFFER_CONSOLE (if !EXPERT)
- * but the module doesn't depend on any fb console symbols.  At least
- * attempt to load fbcon to avoid leaving the system without a usable console.
- */
-int __init drm_fb_helper_modinit(void)
-{
-#if defined(CONFIG_FRAMEBUFFER_CONSOLE_MODULE) && !defined(CONFIG_EXPERT)
-	const char name[] = "fbcon";
-
-	if (!module_loaded(name))
-		request_module_nowait(name);
-#endif
-	return 0;
-}
-EXPORT_SYMBOL(drm_fb_helper_modinit);
diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
index 221a8528c9937a..b694a7da632eae 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -64,19 +64,19 @@ MODULE_PARM_DESC(edid_firmware,
 
 static int __init drm_kms_helper_init(void)
 {
-	int ret;
-
-	/* Call init functions from specific kms helpers here */
-	ret = drm_fb_helper_modinit();
-	if (ret < 0)
-		goto out;
-
-	ret = drm_dp_aux_dev_init();
-	if (ret < 0)
-		goto out;
-
-out:
-	return ret;
+	/*
+	 * The Kconfig DRM_KMS_HELPER selects FRAMEBUFFER_CONSOLE (if !EXPERT)
+	 * but the module doesn't depend on any fb console symbols.  At least
+	 * attempt to load fbcon to avoid leaving the system without a usable
+	 * console.
+	 */
+	if (IS_ENABLED(CONFIG_DRM_FBDEV_EMULATION) &&
+	    IS_MODULE(CONFIG_FRAMEBUFFER_CONSOLE) &&
+	    !IS_ENABLED(CONFIG_EXPERT) &&
+	    !module_loaded("fbcon"))
+		request_module_nowait("fbcon");
+
+	return drm_dp_aux_dev_init();
 }
 
 static void __exit drm_kms_helper_exit(void)
-- 
2.29.2

