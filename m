Return-Path: <linuxppc-dev+bounces-21394-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80DC6CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 12:37:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMPtk1n6Kz3brx;
	Fri, 22 May 2026 22:37:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a07:de40:b251:101:10:150:64:2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779453454;
	cv=none; b=E44PIpnwNaUprKy/OEB11AMStd6qfSEcccMmA+1T8G+OEWu0zftfm1bIqvcG53Hyv+BQrw+FSDkTKm0V9H2Z6anl5UQymow+IyHTCAAqTxpXhk+7vZr/7ax6NekGNmWSHPLQdZTezybXWCcOxcWNatKfzPRL7r4rL+B87i51m1kryMZcUk5mVv0OO2JXxGCDWNIOR2bEzDX/w8ExdjS4MW4AJId3q4IUz40lH4JxodtLVs6Hh9YJYVdPU5MzpXNDTGBwpwadmlC/2nCJvq3Bhryq3VFw3LCHnsxZBlr4kUHPvjzUkMXif49ffeTAgSLGXFZC31sexpLQRk3sd5R3WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779453454; c=relaxed/relaxed;
	bh=vRL7lJ+FKh53s9XMUk0foKTPN+6R7sPbKwtDyw5wi7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK93PllhCETB/CwxC6LxK3Iim/1ouo1e8AHSIPLTVBYOD5v4rXmrIUzMzgVyrCGIH1SxALcnc4/BXWO1j3H4z/TmuRx0TaVRrWX9ooCqKThc42cUcyS2kf8GDPuX1LFbEOFdceoN3G+w173FzQ8MlZRUuCp8kudb7j5xGGbgkZaCxT+E6K0QRlsfEXGOdTyJLgO8tfqROfUlxZew7vIJh6EvOI5hpo1tpXM7InP5UwAkA+PdG91IWIEV3K7iEe+jcHJ9hXWyV+zU5XzmeYEVyjThYH5NLceTlgZBm5uu9yI6w951o0BPm5awa4WndL1rpCFr2vjB47mkQR1KyhHYEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VmWO0Gdq; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c2R/9hIg; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VmWO0Gdq; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c2R/9hIg; dkim-atps=neutral; spf=pass (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VmWO0Gdq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c2R/9hIg;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=VmWO0Gdq;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c2R/9hIg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMPtd0SS3z3brL
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 22:37:29 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DBDE767CCD;
	Fri, 22 May 2026 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779453028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRL7lJ+FKh53s9XMUk0foKTPN+6R7sPbKwtDyw5wi7Q=;
	b=VmWO0GdqkKWDC9s3oGyLUpbz64ZfCpRvn18L64NthYsBSCzutL8EcPgee7rMgMSwHvrFtR
	DUHYWs64K2x1zXrEJpOFblnZ0v2o+/03KHQOjcz4i1veY8L1sdKTnFxZO4g6nQWnyRaqFd
	8zyjYv0PFKx7krzV8vPwAeKgMcpY+Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779453028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRL7lJ+FKh53s9XMUk0foKTPN+6R7sPbKwtDyw5wi7Q=;
	b=c2R/9hIgV88MwmT/XqIu6lFPmde4BmTXUQZ2k0o+dGYFZ3NyD7ZoqnTDTauJ+xYTLFlXqj
	lspc0pcG8FqFjnBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779453028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRL7lJ+FKh53s9XMUk0foKTPN+6R7sPbKwtDyw5wi7Q=;
	b=VmWO0GdqkKWDC9s3oGyLUpbz64ZfCpRvn18L64NthYsBSCzutL8EcPgee7rMgMSwHvrFtR
	DUHYWs64K2x1zXrEJpOFblnZ0v2o+/03KHQOjcz4i1veY8L1sdKTnFxZO4g6nQWnyRaqFd
	8zyjYv0PFKx7krzV8vPwAeKgMcpY+Zg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779453028;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vRL7lJ+FKh53s9XMUk0foKTPN+6R7sPbKwtDyw5wi7Q=;
	b=c2R/9hIgV88MwmT/XqIu6lFPmde4BmTXUQZ2k0o+dGYFZ3NyD7ZoqnTDTauJ+xYTLFlXqj
	lspc0pcG8FqFjnBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88D87593AD;
	Fri, 22 May 2026 12:30:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SJU0IGRMEGqqeQAAD6G6ig
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
Subject: [PATCH v2 3/4] fbdev: Wrap fbcon updates from vga-switcheroo in helper
Date: Fri, 22 May 2026 14:28:15 +0200
Message-ID: <20260522123019.211059-4-tzimmermann@suse.de>
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

Handle console remapping in fbcon in fb_switch_output(). Vga-switcheroo
invokes this functionality before switching physical outputs to a new
graphics device. Open-coding fbcon state in vga-switcheroo exposed fbdev
implementation details.

Vga-switcheroo is used for switching physical outputs among graphics
hardware. This functionality is only supported by DRM drivers. A later
update will further move fb_switch_output() into DRM's fbdev emulation;
thus fully decoupling vga-switcheroo from fbdev.

v2:
- use '#if defined' (Helge)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/vga/vga_switcheroo.c |  6 +++---
 drivers/video/fbdev/core/fbmem.c | 10 ++++++++++
 include/linux/fb.h               |  1 +
 3 files changed, 14 insertions(+), 3 deletions(-)

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


