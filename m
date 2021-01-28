Return-Path: <SRS0=s+PL=G7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F920C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 18:21:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7211264DD6
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Jan 2021 18:21:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7211264DD6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DRTLp1GBnzDrgx
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jan 2021 05:21:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+81cfe4b7420194b52767+6367+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=JrXlXz27; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DRTCn6ggxzDrZ1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2021 05:15:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=fOGP2fwzT2JhZvsiTzA+wVkqRw7CvPV2PR044xdNRuY=; b=JrXlXz27/mzG2g1VdPZUxTrM1W
 Oona3eMQfcz7R7M+O+Lo4QIA7oJJf710/28xl/+/09Lgcoi5qDaXiJiKGKALoCc7OnrHpc8uacY7W
 BOm73nKO5zs/tLQHoPldiFiCSxVFstOJUSvDj5GIOBKfrEWTuHTkdkwwJrP6v2Brp8JFKHGaUug5G
 LKk9emCqi8DCShtS3rQhC1nt1wfQXdA8bfRLCjyxZBGGW9zPkCqwtywiggwei98SbJws8xQic47A0
 JOusy0/bIcl8DzKg+ZFBTQhGbkoNpj7LNfq+5N2kQOrD8J8Kchsh+NpW/7u0MgJRBid3Fe35rrtqy
 ceNg/hCw==;
Received: from [2001:4bb8:198:6bf4:e052:196b:7e32:37d9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l5BoS-008nr8-5T; Thu, 28 Jan 2021 18:14:38 +0000
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
Subject: [PATCH 02/13] drm: remove drm_fb_helper_modinit
Date: Thu, 28 Jan 2021 19:14:10 +0100
Message-Id: <20210128181421.2279-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128181421.2279-1-hch@lst.de>
References: <20210128181421.2279-1-hch@lst.de>
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
IS_ENABLED and IS_MODULE, and skip the find_module check as a
request_module is harmless if the module is already loaded (and not
other caller has this find_module check either).

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/drm_crtc_helper_internal.h | 10 ---------
 drivers/gpu/drm/drm_fb_helper.c            | 21 ------------------
 drivers/gpu/drm/drm_kms_helper_common.c    | 25 +++++++++++-----------
 3 files changed, 12 insertions(+), 44 deletions(-)

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
index 4b81195106875d..0b9f1ae1b7864c 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -2499,24 +2499,3 @@ void drm_fbdev_generic_setup(struct drm_device *dev,
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
-	struct module *fbcon;
-
-	mutex_lock(&module_mutex);
-	fbcon = find_module(name);
-	mutex_unlock(&module_mutex);
-
-	if (!fbcon)
-		request_module_nowait(name);
-#endif
-	return 0;
-}
-EXPORT_SYMBOL(drm_fb_helper_modinit);
diff --git a/drivers/gpu/drm/drm_kms_helper_common.c b/drivers/gpu/drm/drm_kms_helper_common.c
index 221a8528c9937a..f933da1656eb52 100644
--- a/drivers/gpu/drm/drm_kms_helper_common.c
+++ b/drivers/gpu/drm/drm_kms_helper_common.c
@@ -64,19 +64,18 @@ MODULE_PARM_DESC(edid_firmware,
 
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
+	    !IS_ENABLED(CONFIG_EXPERT))
+		request_module_nowait("fbcon");
+
+	return drm_dp_aux_dev_init();
 }
 
 static void __exit drm_kms_helper_exit(void)
-- 
2.29.2

