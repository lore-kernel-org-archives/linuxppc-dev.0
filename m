Return-Path: <linuxppc-dev+bounces-21247-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A4ECD4F3D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 16:08:22 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLGfb1hRRz2y7Y;
	Thu, 21 May 2026 02:08:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779293287;
	cv=none; b=EV0eGvxqjPWPdRrFi3Gi156wJXDgbx2xdnSfmq4jumkmhdVnvKDJSNaE8X7kncvm/zNZyAu1aAaTQrFbV2/bxPIrJPHy+1QZh5Fv6WY5PONBAkTDnB9fWuMvZiFUIVt2Ynf1a1dBHDflcoOeju5Xt/zgOaIPCva1iKxvb4jlNzhFXQxVjVW6kb21EGoHhaADwg9k7IPpOlnraGrSgB8ZRAXH6OHenkckNAUcMAxDrofHE92qsa1N3MwIoEqa8IGNw5VL4ePW02SUN53lZ2NOk0upZSUI5CBfEJIHbyP/QI6p+FC1Y48LkQ6YfjrVxAxd5RdpJF/y1gwPa7mNkHYWqw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779293287; c=relaxed/relaxed;
	bh=70TGVk8Zu+qjOoChAUzJU+mory/7WmBYjIAFEIyiDB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MW48Z8HQzQP0ARWkQuRbKe3Xaa5KimK38e6ecpo+6EEieDLDBuI+nwD7VWvXcwjVpHis8FAvzkue+KNwkAN1AUiiWPPWWT8bzlBUOGD7AG1mfB3EgrRwow9CqZuEvW8KpoTR5Ye9etBBcXDjw1RTAT2jcs6pfHP5Gf9ioxaMrqgOJ1ysiOmjiCSFA+VUMJDA6BRzNhMAnjgIK05/Ba+eN+3Yh7wjUwldQLc7SarTFCdQQrA9wNUsoYVmropnilJnXQp5Go+zpIifrUSEFk+4/cqFB5z5V4Vu3cAhQ+ru8ILwmH0aYl6OpdCR1UXHWbZJf7iJHmi8t71v7kY7OKX47w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLGfZ4B2Gz2xqJ
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 02:08:06 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9913E6BC13;
	Wed, 20 May 2026 16:07:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E63F593AB;
	Wed, 20 May 2026 16:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aDZgGlrcDWqwWgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 20 May 2026 16:07:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	simona@ffwll.ch,
	airlied@gmail.com,
	lukas@wunner.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/4] fbdev: Wrap fbcon updates from vga-switcheroo in helper
Date: Wed, 20 May 2026 18:00:38 +0200
Message-ID: <20260520160744.130841-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520160744.130841-1-tzimmermann@suse.de>
References: <20260520160744.130841-1-tzimmermann@suse.de>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 9913E6BC13
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action

Handle console remapping in fbcon in fb_switch_output(). Vga-switcheroo
invokes this functionality before switching physical outputs to a new
graphics device. Open-coding fbcon state in vga-switcheroo exposed fbdev
implementation details.

Vga-switcheroo is used for switching physical outputs among graphics
hardware. This functionality is only supported by DRM drivers. A later
update will further move fb_switch_output() into DRM's fbdev emulation;
thus fully decoupling vga-switcheroo from fbdev.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/vga/vga_switcheroo.c |  6 +++---
 drivers/video/fbdev/core/fbmem.c | 10 ++++++++++
 include/linux/fb.h               |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 8fe1ae3c71bb..805953d0b941 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -31,11 +31,9 @@
 #define pr_fmt(fmt) "vga_switcheroo: " fmt
 
 #include <linux/apple-gmux.h>
-#include <linux/console.h>
 #include <linux/debugfs.h>
 #include <linux/fb.h>
 #include <linux/fs.h>
-#include <linux/fbcon.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pm_domain.h>
@@ -735,8 +733,10 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
 	if (!active->driver_power_control)
 		set_audio_state(active->id, VGA_SWITCHEROO_OFF);
 
+#if CONFIG_FB
 	if (new_client->fb_info)
-		fbcon_remap_all(new_client->fb_info);
+		fb_switch_outputs(new_client->fb_info);
+#endif
 
 	mutex_lock(&vgasr_priv.mux_hw_lock);
 	ret = vgasr_priv.handler->switchto(new_client->id);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 1a6758653b64..ecadbc58abff 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -684,6 +684,16 @@ void fb_set_suspend(struct fb_info *info, int state)
 }
 EXPORT_SYMBOL(fb_set_suspend);
 
+/**
+ * fb_switch_outputs - framebuffer got the outputs from vga-switcheroo
+ * @info: framebuffer
+ */
+void fb_switch_outputs(struct fb_info *info)
+{
+	fbcon_remap_all(info);
+}
+EXPORT_SYMBOL(fb_switch_outputs);
+
 static int __init fbmem_init(void)
 {
 	int ret;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 88680a7cabd5..e9a26e82322a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -608,6 +608,7 @@ void fb_pad_unaligned_buffer(u8 *dst, u32 d_pitch, const u8 *src, u32 idx, u32 h
 			     u32 shift_high, u32 shift_low, u32 mod);
 void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, const u8 *src, u32 s_pitch, u32 height);
 extern void fb_set_suspend(struct fb_info *info, int state);
+extern void fb_switch_outputs(struct fb_info *info);
 extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 			      struct fb_fix_screeninfo *fix);
 extern int fb_get_options(const char *name, char **option);
-- 
2.54.0


