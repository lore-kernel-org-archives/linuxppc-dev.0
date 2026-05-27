Return-Path: <linuxppc-dev+bounces-21593-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E12CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 15:16:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQY9N0tDvz3cZ5;
	Thu, 28 May 2026 01:16:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779894968;
	cv=none; b=k9fMH/WGbPO+AxKXwkryljJ9qsg9BOtTtR8RrIKlbTECEzdVwoLyYG8sRSXRPErws0OoBkajuN2cY9Wden3eSOE1pgvQlw50wmCsc5uctyUxtdHwJP/PxzULGdM1a2ljloe2vuhFS7JmZ1iQEEDCKqpwyaDc2oYz5L4sO+0wOaHLpQ0/c+DL7BURcRpBY7qER/vRfwBiRT5QTgRScRhMH+YhBbGqDks7MLEq1x6HowWzat/h92wyB/hDZXSPh2FToXGztFRh3hiAEeRcO2i9hFkMlmeD0zC12qUQnTHyKQc1iObSCzQOwKg6KxVy88/iG+I8bQHHfrW2VfsnNkz8kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779894968; c=relaxed/relaxed;
	bh=AC9L7qlZbtz9ZlnMfxZoo95vX+3Yiqd0s5v2/8LwRIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjKz1KVHVNDQTGcRPzh+hsAFhnxk2qCAfvNqGB7zWO01VTPyANApvYIzKKBlqVbgT4PpftMoT3Uj/T/Lmlq0W4WoEXGvDZO8ba9WwbG+ko2UQ5g59hsmcT8qbkOgpd7Q302aaWPsG/u4P56ggtoGcqn/DvWntsXBTg1/ilqVt5zkewI6sckip7lzw4x1YIyhO0gIgskPVVC/AQmbm6AhrlFgjh8UDQ4PspOZ22N9Q6kjdI5add0P5BnxlrpRiQ/cHiOOMl68munGixJjlftDVMrMwELC7JTauXlAYmNDiM7he1b744s4hRtIWjVQhG08nJf7cNuon4MD46t/RxtU+Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xdndTBFU; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v2n5aavs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xdndTBFU; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v2n5aavs; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xdndTBFU;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v2n5aavs;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=xdndTBFU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=v2n5aavs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQY9M3FXKz30Wn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 01:16:07 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A65256AA37;
	Wed, 27 May 2026 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779894955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AC9L7qlZbtz9ZlnMfxZoo95vX+3Yiqd0s5v2/8LwRIM=;
	b=xdndTBFUh9zOeBPXuq2uboWM+KX2sjCVlSqE9xEfsyVSJi7HinN7TiOkzwFd3uu0CkuNO5
	fjGvJdWUs7Cz1sT45qdXm6IH0z3JX0DcaEY5ea6hFYmOvfw28rx5+q55Ci+rWQxiVncsdC
	AesL/I5Lv4csVDsSIrd02vzXijZGkeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779894955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AC9L7qlZbtz9ZlnMfxZoo95vX+3Yiqd0s5v2/8LwRIM=;
	b=v2n5aavs6TljC0G23wkYlN//EI/+IfzmESw4y+vl8cg+PStxBYBn7pKzF477SrIj1jhNLT
	quw+IrniNLbaDiBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779894955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AC9L7qlZbtz9ZlnMfxZoo95vX+3Yiqd0s5v2/8LwRIM=;
	b=xdndTBFUh9zOeBPXuq2uboWM+KX2sjCVlSqE9xEfsyVSJi7HinN7TiOkzwFd3uu0CkuNO5
	fjGvJdWUs7Cz1sT45qdXm6IH0z3JX0DcaEY5ea6hFYmOvfw28rx5+q55Ci+rWQxiVncsdC
	AesL/I5Lv4csVDsSIrd02vzXijZGkeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779894955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AC9L7qlZbtz9ZlnMfxZoo95vX+3Yiqd0s5v2/8LwRIM=;
	b=v2n5aavs6TljC0G23wkYlN//EI/+IfzmESw4y+vl8cg+PStxBYBn7pKzF477SrIj1jhNLT
	quw+IrniNLbaDiBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5196B5A8C3;
	Wed, 27 May 2026 15:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cAO7EqsKF2p6FQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 15:15:55 +0000
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
Subject: [PATCH v3 1/4] fbdev: Wrap user-invoked calls to fb_set_var() in helper
Date: Wed, 27 May 2026 17:14:02 +0200
Message-ID: <20260527151551.258659-2-tzimmermann@suse.de>
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

Handle fbcon during display updates in fb_set_var_from_user(). Check
with fbcon if the mode change is possible, update hardware state and
finally update fbcon. Update all callers.

Only the FBIOPUT_VSCREENINFO ioctl currently does all steps. Other
mode-changes callers in sysfs and driver code are missing fbcon-related
steps.

With the new helper, ps3fb and sh_mobile_lcdcfb no longer maintain
fbcon state themselves.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fb_chrdev.c   |  6 +-----
 drivers/video/fbdev/core/fbcon.c       |  2 --
 drivers/video/fbdev/core/fbmem.c       | 13 +++++++++++++
 drivers/video/fbdev/core/fbsysfs.c     |  4 +---
 drivers/video/fbdev/ps3fb.c            |  5 +----
 drivers/video/fbdev/sh_mobile_lcdcfb.c |  5 +----
 include/linux/fb.h                     |  2 ++
 7 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_chrdev.c b/drivers/video/fbdev/core/fb_chrdev.c
index 4ebd16b7e3b8..54f926fb411b 100644
--- a/drivers/video/fbdev/core/fb_chrdev.c
+++ b/drivers/video/fbdev/core/fb_chrdev.c
@@ -85,11 +85,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		var.activate &= ~FB_ACTIVATE_KD_TEXT;
 		console_lock();
 		lock_fb_info(info);
-		ret = fbcon_modechange_possible(info, &var);
-		if (!ret)
-			ret = fb_set_var(info, &var);
-		if (!ret)
-			fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
+		ret = fb_set_var_from_user(info, &var);
 		unlock_fb_info(info);
 		console_unlock();
 		if (!ret && copy_to_user(argp, &var, sizeof(var)))
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b0e3e765360d..50b84cd32938 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2699,7 +2699,6 @@ void fbcon_update_vcs(struct fb_info *info, bool all)
 	else
 		fbcon_modechanged(info);
 }
-EXPORT_SYMBOL(fbcon_update_vcs);
 
 /* let fbcon check if it supports a new screen resolution */
 int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *var)
@@ -2727,7 +2726,6 @@ int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *va
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fbcon_modechange_possible);
 
 int fbcon_mode_deleted(struct fb_info *info,
 		       struct fb_videomode *mode)
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 30f2b59c47bf..d37a1039e221 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -346,6 +346,19 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 }
 EXPORT_SYMBOL(fb_set_var);
 
+int fb_set_var_from_user(struct fb_info *info, struct fb_var_screeninfo *var)
+{
+	int ret = fbcon_modechange_possible(info, var);
+
+	if (!ret)
+		ret = fb_set_var(info, var);
+	if (!ret)
+		fbcon_update_vcs(info, var->activate & FB_ACTIVATE_ALL);
+
+	return ret;
+}
+EXPORT_SYMBOL(fb_set_var_from_user);
+
 static void fb_lcd_notify_blank(struct fb_info *info)
 {
 	int power;
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index baa2bae0fb5b..5ece236e6252 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -19,9 +19,7 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 	var->activate |= FB_ACTIVATE_FORCE;
 	console_lock();
 	lock_fb_info(fb_info);
-	err = fb_set_var(fb_info, var);
-	if (!err)
-		fbcon_update_vcs(fb_info, var->activate & FB_ACTIVATE_ALL);
+	err = fb_set_var_from_user(fb_info, var);
 	unlock_fb_info(fb_info);
 	console_unlock();
 	if (err)
diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
index dbcda307f6a6..1376d19b19ae 100644
--- a/drivers/video/fbdev/ps3fb.c
+++ b/drivers/video/fbdev/ps3fb.c
@@ -29,7 +29,6 @@
 #include <linux/freezer.h>
 #include <linux/uaccess.h>
 #include <linux/fb.h>
-#include <linux/fbcon.h>
 #include <linux/init.h>
 
 #include <asm/cell-regs.h>
@@ -830,9 +829,7 @@ static int ps3fb_ioctl(struct fb_info *info, unsigned int cmd,
 				/* Force, in case only special bits changed */
 				var.activate |= FB_ACTIVATE_FORCE;
 				par->new_mode_id = val;
-				retval = fb_set_var(info, &var);
-				if (!retval)
-					fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
+				retval = fb_set_var_from_user(info, &var);
 				console_unlock();
 			}
 			break;
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 72969fe8e513..e8324b01700f 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -15,7 +15,6 @@
 #include <linux/ctype.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
-#include <linux/fbcon.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ioctl.h>
@@ -1768,11 +1767,9 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 	var.height = ch->display.height;
 	var.activate = FB_ACTIVATE_NOW;
 
-	if (fb_set_var(info, &var) < 0)
+	if (fb_set_var_from_user(info, &var) < 0)
 		/* Couldn't reconfigure, hopefully, can continue as before */
 		return;
-
-	fbcon_update_vcs(info, true);
 }
 
 /*
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 5178a33c752c..88680a7cabd5 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -533,6 +533,8 @@ extern int fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var);
 extern int fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var);
 extern int fb_blank(struct fb_info *info, int blank);
 
+int fb_set_var_from_user(struct fb_info *info, struct fb_var_screeninfo *var);
+
 /*
  * Helpers for framebuffers in I/O memory
  */
-- 
2.54.0


