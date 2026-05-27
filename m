Return-Path: <linuxppc-dev+bounces-21595-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8947ACD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 15:16:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQY9V55jDz3cdZ;
	Thu, 28 May 2026 01:16:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779894974;
	cv=none; b=WU4oUk3tvXn94CqnRmGLsVxIsQjtSCFnTM7kIerFJ/XTInBEsoOMUMi0+2dq7jCjdYeXcXhECKm6QINRq1/8LJvVfboMi0xRqOa7vfJ43qcauB80RhrGGLTTeM5e9Qdp6d4SFOky/w04v2GrU7z4WhOU4nUENlU3eJ/2r0my2rloqfTaTO4qszqxZVKy5qbbjw/OPiwuee/Y+a5+WuEtWLt8edmbepYSAj+ZiTZxU6vb5lFP7+LHYMgjHniXwxzstcEFt20YJu32i/QLfKdgRggU6pcyiBXwPk3y97JvLU6DwWOsHwBflmGtAATNOSBYPnQGfRPfHN6FyZTlAPRfjw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779894974; c=relaxed/relaxed;
	bh=Y6S6cB8ObGQfuJNgjDJMW2rq8gvqvaymXV0iZZjEyf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEgZcdJIXy9anrPvkI07L3zHHNQ+6aJloyJL0ylYqa15zv1sRaurVk7RA6LEOjylKX0d9jb/GoqrErNSslJygzxWOOO1EJnOZ9aob/QkSFqIrIVI54NcjgmA1HtI1sIjNfDOaq7lpipb4yg2bKOtGu6EfD58DwPY3bxpuy7aJtIGjCy1to7UAObHzLmVo7P9n+kWLzLeVU2cuQvYDV7Eif/Fjmwk3r5s8zz3Af1ghfHQfxKLj2R6Eldx1QVdgIPGdlKdZhbK+wIgK/qaE1L9hBc8bAKucz9rBmxCGbZy/8qjLO2huQ27qv+5GBlOhJloOkI4kkFdckv+VfxJoyS7/w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=INON9EyJ; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tUgvpzHS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=INON9EyJ; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tUgvpzHS; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=INON9EyJ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tUgvpzHS;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=INON9EyJ;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=tUgvpzHS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQY9T61dzz30Wn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 01:16:13 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 625206AA59;
	Wed, 27 May 2026 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779894956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6S6cB8ObGQfuJNgjDJMW2rq8gvqvaymXV0iZZjEyf4=;
	b=INON9EyJSuB4kEF8tdsnv6R6M9gPeEeoAI/y9MGdG4m/UulsYFUpyi1ow291JOCQ1cGDUY
	JKApHL2Z5nm89K0cT5tJpfeZsBbUZVnSjJQEH1Hwm9Mu97bZM7Gp3rcrmmoCrT8h56ods3
	+9tnPEV0TpiqLVKr7SwFESG2jEuEOQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779894956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6S6cB8ObGQfuJNgjDJMW2rq8gvqvaymXV0iZZjEyf4=;
	b=tUgvpzHSgmFK8y/MfhPE5nbE5O32GhHCZ/DWdv4QqjUEHK9PnU17uzXqUyM8LpiceE39gg
	zo/L8bVEuGp80mBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779894956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6S6cB8ObGQfuJNgjDJMW2rq8gvqvaymXV0iZZjEyf4=;
	b=INON9EyJSuB4kEF8tdsnv6R6M9gPeEeoAI/y9MGdG4m/UulsYFUpyi1ow291JOCQ1cGDUY
	JKApHL2Z5nm89K0cT5tJpfeZsBbUZVnSjJQEH1Hwm9Mu97bZM7Gp3rcrmmoCrT8h56ods3
	+9tnPEV0TpiqLVKr7SwFESG2jEuEOQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779894956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y6S6cB8ObGQfuJNgjDJMW2rq8gvqvaymXV0iZZjEyf4=;
	b=tUgvpzHSgmFK8y/MfhPE5nbE5O32GhHCZ/DWdv4QqjUEHK9PnU17uzXqUyM8LpiceE39gg
	zo/L8bVEuGp80mBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 124965A8C3;
	Wed, 27 May 2026 15:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aA5KA6wKF2p6FQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 15:15:56 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de,
	geert@linux-m68k.org,
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
Subject: [PATCH v3 3/4] fbdev: Wrap fbcon updates from vga-switcheroo in helper
Date: Wed, 27 May 2026 17:14:04 +0200
Message-ID: <20260527151551.258659-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527151551.258659-1-tzimmermann@suse.de>
References: <20260527151551.258659-1-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,linux-m68k.org,ffwll.ch,gmail.com,wunner.de,linux.ibm.com,ellerman.id.au,kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL3i8gi83d8iemn6cxmyh4cqsd)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Handle console remapping in fbcon in fb_switch_output(). Vga-switcheroo
invokes this functionality before switching physical outputs to a new
graphics device. Open-coding fbcon state in vga-switcheroo exposed fbdev
implementation details.

Vga-switcheroo is used for switching physical outputs among graphics
hardware. This functionality is only supported by DRM drivers. A later
update will further move fb_switch_output() into DRM's fbdev emulation;
thus fully decoupling vga-switcheroo from fbdev.

v3:
- remove Kconfig dependency related to fbcon (Geert)
v2:
- use '#if defined' (Helge)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/vga/Kconfig          |  2 +-
 drivers/gpu/vga/vga_switcheroo.c |  6 +++---
 drivers/video/fbdev/core/fbmem.c | 10 ++++++++++
 include/linux/fb.h               |  1 +
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/vga/Kconfig b/drivers/gpu/vga/Kconfig
index eb8b14ab22c3..bad4bcee313f 100644
--- a/drivers/gpu/vga/Kconfig
+++ b/drivers/gpu/vga/Kconfig
@@ -4,7 +4,7 @@ config VGA_SWITCHEROO
 	depends on X86
 	depends on ACPI
 	depends on PCI
-	depends on (FRAMEBUFFER_CONSOLE=n || FB=y)
+	depends on FB=y
 	select VGA_ARB
 	help
 	  Many laptops released in 2008/9/10 have two GPUs with a multiplexer
diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 8fe1ae3c71bb..22cf52b78b75 100644
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
 
+#if defined(CONFIG_FB)
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


