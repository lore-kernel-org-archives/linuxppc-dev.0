Return-Path: <linuxppc-dev+bounces-21395-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3334ACD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 12:42:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMQ0r6WsQz3bpx;
	Fri, 22 May 2026 22:42:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779453772;
	cv=none; b=bObGRb0m099YYpmpx34LJ+AKN90RyBd2FQiTaAGCFwe/MIGU2A9MzPS2MGJ7dD+Pf2aqPiXWyS2/2s41dVJFbu5WxIdArPKWZXrTijEItRadRZUAR1yhTIR8QCKuP8T8aMhtljN/8zuWfp91mKv4YBvvrRXBEht3MlU1gVIPhajd0lto3rF85jqy6qDoysG07M319oKLUmVlyyCq9CVCqaffUmM1ru1htuAiMzmBdZZRAAPLx4US2svsZesEdSZJo1/D3pq7r2oOVpx0EtRwkPUpHDMCLXXcSXIov57QUZUwNpo7KvbXrY+upzZW2yMLy1Gx8b/AWIjWNRA/JZFbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779453772; c=relaxed/relaxed;
	bh=vBtaE/SLft/7bYaH+tW5iBuZ4PwLUahf4IAUa7S3OcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcLJ+OKJI+uDGELiX0+FrNPWZnHCWebyc55lO+8GekLJlHOtM6m4joTAVlzPKIPPyvcmI5/1kdl00LRf996iEoBYiVOmqNd2L8OkYGoNY7pJ91T0PtO3qIMWQ0Au5JtzXclphQfQdObr+4o4b/rr9EUtJAK0dbqxxs2BTAzkUCl2H77xVRA3dof0GHWZchYwfUpxSvDMlSvE3O44O6ON7AXAbAJXcCPJ+w7RLCcQwAiQyiFshPQD8YHBPzsVwvIt+BzBOwcQAdT+UALeEj/PdudGsn6OvTv0kevw2xPoszxj96D+R5BM+y06tVPHlI7asqPP6314qAen6j6vxhMPpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KWNrr3SG; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jYJ5Gux7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KWNrr3SG; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jYJ5Gux7; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KWNrr3SG;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jYJ5Gux7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=KWNrr3SG;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=jYJ5Gux7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMQ0l6g3hz2xRw
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 22:42:47 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4078367CD6;
	Fri, 22 May 2026 12:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779453029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBtaE/SLft/7bYaH+tW5iBuZ4PwLUahf4IAUa7S3OcI=;
	b=KWNrr3SGun+JUo91FFxQ2B6VAOg9V5cX+9Eb2YNZlg4szMTeqItdPJibs9f6e4Vf0RQNS6
	J2/zP73rWBaC4/Eu39i9dyZf2VRg9AQxykRkRW2t8RUjWhY4ttaUQj9sDVfxDtfCfKCVnk
	De3/szNjsnAbdpgyB4Isi2oOCoGK4Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779453029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBtaE/SLft/7bYaH+tW5iBuZ4PwLUahf4IAUa7S3OcI=;
	b=jYJ5Gux7lgD0D7y9dRKgYJeTxOYiuIRF5DzIk68cCqwlv7B1++xn4NB1MKNxeQ+FIfwfPl
	V1kwNYO7HOfXTLDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779453029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBtaE/SLft/7bYaH+tW5iBuZ4PwLUahf4IAUa7S3OcI=;
	b=KWNrr3SGun+JUo91FFxQ2B6VAOg9V5cX+9Eb2YNZlg4szMTeqItdPJibs9f6e4Vf0RQNS6
	J2/zP73rWBaC4/Eu39i9dyZf2VRg9AQxykRkRW2t8RUjWhY4ttaUQj9sDVfxDtfCfKCVnk
	De3/szNjsnAbdpgyB4Isi2oOCoGK4Hg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779453029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vBtaE/SLft/7bYaH+tW5iBuZ4PwLUahf4IAUa7S3OcI=;
	b=jYJ5Gux7lgD0D7y9dRKgYJeTxOYiuIRF5DzIk68cCqwlv7B1++xn4NB1MKNxeQ+FIfwfPl
	V1kwNYO7HOfXTLDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2B31593A8;
	Fri, 22 May 2026 12:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oF0mNmRMEGqqeQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 22 May 2026 12:30:28 +0000
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
Subject: [PATCH v2 4/4] fbdev: Do not export fbcon from fbdev
Date: Fri, 22 May 2026 14:28:16 +0200
Message-ID: <20260522123019.211059-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522123019.211059-1-tzimmermann@suse.de>
References: <20260522123019.211059-1-tzimmermann@suse.de>
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
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch,gmail.com,wunner.de,linux.ibm.com,ellerman.id.au,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL3i8gi83d8iemn6cxmyh4cqsd)];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

There are no callers of fbcon outside fbdev. Move the declarations
into the internal header.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 MAINTAINERS                          |  1 -
 drivers/video/fbdev/core/fb_chrdev.c |  2 +-
 drivers/video/fbdev/core/fbcon.c     |  1 -
 drivers/video/fbdev/core/fbcon.h     | 50 +++++++++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c     |  2 +-
 include/linux/fbcon.h                | 55 ----------------------------
 6 files changed, 52 insertions(+), 59 deletions(-)
 delete mode 100644 include/linux/fbcon.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6810710e7a57..0ed3ef0b466a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10147,7 +10147,6 @@ F:	drivers/video/fbdev/core/fbcon_rotate.h
 F:	drivers/video/fbdev/core/fbcon_ud.c
 F:	drivers/video/fbdev/core/softcursor.c
 F:	drivers/video/fbdev/core/tileblit.c
-F:	include/linux/fbcon.h
 F:	include/linux/font.h
 F:	lib/fonts/
 
diff --git a/drivers/video/fbdev/core/fb_chrdev.c b/drivers/video/fbdev/core/fb_chrdev.c
index 035e67d2c28f..ba1d0bc214c5 100644
--- a/drivers/video/fbdev/core/fb_chrdev.c
+++ b/drivers/video/fbdev/core/fb_chrdev.c
@@ -3,10 +3,10 @@
 #include <linux/compat.h>
 #include <linux/console.h>
 #include <linux/fb.h>
-#include <linux/fbcon.h>
 #include <linux/major.h>
 
 #include "fb_internal.h"
+#include "fbcon.h"
 
 /*
  * We hold a reference to the fb_info in file->private_data,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 50b84cd32938..853b52b40d01 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -70,7 +70,6 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
-#include <linux/fbcon.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
 #include <linux/font.h>
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 321cc7f44baa..407d207b14f1 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -11,6 +11,7 @@
 #ifndef _VIDEO_FBCON_H
 #define _VIDEO_FBCON_H
 
+#include <linux/compiler_types.h>
 #include <linux/font.h>
 #include <linux/types.h>
 #include <linux/vt_buffer.h>
@@ -19,6 +20,11 @@
 
 #include <asm/io.h>
 
+struct fb_blit_caps;
+struct fb_info;
+struct fb_var_screeninfo;
+struct fb_videomode;
+
    /*
     *    This is the interface between the low-level console driver and the
     *    low-level frame buffer device
@@ -233,4 +239,48 @@ static inline int get_attribute(struct fb_info *info, u16 c)
         (void) (&_r == &_v); \
         (i == FB_ROTATE_UR || i == FB_ROTATE_UD) ? _r : _v; })
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE
+void __init fb_console_init(void);
+void __exit fb_console_exit(void);
+int fbcon_fb_registered(struct fb_info *info);
+void fbcon_fb_unregistered(struct fb_info *info);
+void fbcon_fb_unbind(struct fb_info *info);
+void fbcon_suspended(struct fb_info *info);
+void fbcon_resumed(struct fb_info *info);
+int fbcon_mode_deleted(struct fb_info *info,
+		       struct fb_videomode *mode);
+void fbcon_delete_modelist(struct list_head *head);
+void fbcon_new_modelist(struct fb_info *info);
+void fbcon_get_requirement(struct fb_info *info,
+			   struct fb_blit_caps *caps);
+void fbcon_fb_blanked(struct fb_info *info, int blank);
+int  fbcon_modechange_possible(struct fb_info *info,
+			       struct fb_var_screeninfo *var);
+void fbcon_update_vcs(struct fb_info *info, bool all);
+void fbcon_remap_all(struct fb_info *info);
+int fbcon_set_con2fb_map_ioctl(void __user *argp);
+int fbcon_get_con2fb_map_ioctl(void __user *argp);
+#else
+static inline void fb_console_init(void) {}
+static inline void fb_console_exit(void) {}
+static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
+static inline void fbcon_fb_unregistered(struct fb_info *info) {}
+static inline void fbcon_fb_unbind(struct fb_info *info) {}
+static inline void fbcon_suspended(struct fb_info *info) {}
+static inline void fbcon_resumed(struct fb_info *info) {}
+static inline int fbcon_mode_deleted(struct fb_info *info,
+				     struct fb_videomode *mode) { return 0; }
+static inline void fbcon_delete_modelist(struct list_head *head) {}
+static inline void fbcon_new_modelist(struct fb_info *info) {}
+static inline void fbcon_get_requirement(struct fb_info *info,
+					 struct fb_blit_caps *caps) {}
+static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
+static inline int  fbcon_modechange_possible(struct fb_info *info,
+				struct fb_var_screeninfo *var) { return 0; }
+static inline void fbcon_update_vcs(struct fb_info *info, bool all) {}
+static inline void fbcon_remap_all(struct fb_info *info) {}
+static inline int fbcon_set_con2fb_map_ioctl(void __user *argp) { return 0; }
+static inline int fbcon_get_con2fb_map_ioctl(void __user *argp) { return 0; }
+#endif
+
 #endif /* _VIDEO_FBCON_H */
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index ecadbc58abff..e5221653ec2b 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -14,13 +14,13 @@
 #include <linux/console.h>
 #include <linux/export.h>
 #include <linux/fb.h>
-#include <linux/fbcon.h>
 #include <linux/lcd.h>
 #include <linux/leds.h>
 
 #include <video/nomodeset.h>
 
 #include "fb_internal.h"
+#include "fbcon.h"
 
     /*
      *  Frame buffer device initialization and setup routines
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
deleted file mode 100644
index f206370060e1..000000000000
--- a/include/linux/fbcon.h
+++ /dev/null
@@ -1,55 +0,0 @@
-#ifndef _LINUX_FBCON_H
-#define _LINUX_FBCON_H
-
-#include <linux/compiler_types.h>
-
-struct fb_blit_caps;
-struct fb_info;
-struct fb_var_screeninfo;
-struct fb_videomode;
-
-#ifdef CONFIG_FRAMEBUFFER_CONSOLE
-void __init fb_console_init(void);
-void __exit fb_console_exit(void);
-int fbcon_fb_registered(struct fb_info *info);
-void fbcon_fb_unregistered(struct fb_info *info);
-void fbcon_fb_unbind(struct fb_info *info);
-void fbcon_suspended(struct fb_info *info);
-void fbcon_resumed(struct fb_info *info);
-int fbcon_mode_deleted(struct fb_info *info,
-		       struct fb_videomode *mode);
-void fbcon_delete_modelist(struct list_head *head);
-void fbcon_new_modelist(struct fb_info *info);
-void fbcon_get_requirement(struct fb_info *info,
-			   struct fb_blit_caps *caps);
-void fbcon_fb_blanked(struct fb_info *info, int blank);
-int  fbcon_modechange_possible(struct fb_info *info,
-			       struct fb_var_screeninfo *var);
-void fbcon_update_vcs(struct fb_info *info, bool all);
-void fbcon_remap_all(struct fb_info *info);
-int fbcon_set_con2fb_map_ioctl(void __user *argp);
-int fbcon_get_con2fb_map_ioctl(void __user *argp);
-#else
-static inline void fb_console_init(void) {}
-static inline void fb_console_exit(void) {}
-static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
-static inline void fbcon_fb_unregistered(struct fb_info *info) {}
-static inline void fbcon_fb_unbind(struct fb_info *info) {}
-static inline void fbcon_suspended(struct fb_info *info) {}
-static inline void fbcon_resumed(struct fb_info *info) {}
-static inline int fbcon_mode_deleted(struct fb_info *info,
-				     struct fb_videomode *mode) { return 0; }
-static inline void fbcon_delete_modelist(struct list_head *head) {}
-static inline void fbcon_new_modelist(struct fb_info *info) {}
-static inline void fbcon_get_requirement(struct fb_info *info,
-					 struct fb_blit_caps *caps) {}
-static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
-static inline int  fbcon_modechange_possible(struct fb_info *info,
-				struct fb_var_screeninfo *var) { return 0; }
-static inline void fbcon_update_vcs(struct fb_info *info, bool all) {}
-static inline void fbcon_remap_all(struct fb_info *info) {}
-static inline int fbcon_set_con2fb_map_ioctl(void __user *argp) { return 0; }
-static inline int fbcon_get_con2fb_map_ioctl(void __user *argp) { return 0; }
-#endif
-
-#endif /* _LINUX_FBCON_H */
-- 
2.54.0


