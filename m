Return-Path: <linuxppc-dev+bounces-21591-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1ABCD6E44
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 15:16:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQY9F3VFzz3cLV;
	Thu, 28 May 2026 01:16:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779894961;
	cv=none; b=KM7w3zqaPr70K6B+Z5U9pSze6vREvsf633GT0t8AvoKeS0fT0svcKfxniN3cNsPBo811ge120YmUfuozbnDUhHkWYQ2/UQCi7EM4uxRaERlx7O4IKKSbXXnkC81FCPIna3xvWFxvctBxl+TEgk5t0o+eBKSb9pdtN0rYOt8fVbv5/8T8H491IH27MkEG24RInbUjevrjxe8cjMgN0rqZeYeiXVxToQiALsJMG6ZDlXPAd+9tgtP1SzIRUHFGuG+9Se0YHfx9cvklGzx1fVj+efxv/h6b+Jf18dIGVhmx/3LLm5joLG7ee5pEBWupSYKkXVj4cYpWdAdlQcl45sGHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779894961; c=relaxed/relaxed;
	bh=Q23F0LaqDkNSpvyAUae8noyxKMFf2FHoVKc+13avh4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzpzX2UfOJZEDadvz5AD4aJ39Z+R9dqjDSyX+YGTRVtOB2rGhGDNLdJ3hgKyCMliQLuK8Tk9HCg74+LhxSnkQRD4xJkhd4NyEYAC96HTLp/CvF6cS02sfH/s5dsoXedNyNn1UQQnJFdn8Di/Hj2w6TvBLK9w8QwSwTzlH/EVz505SkyUjGOW0gZYVSTuVtdYL/uoZ5/Ny/R2nQdIxCZ9AFY485kKQLucnYHCXSJ+owZGBQifz/6pqNYt1BnWz4w9By+B/6TfOHzL/wGMTvq6M5ZArKRmmHSRatUs2DcRWgVcgCHOGnLLhS5xz7irKsSLvXP/7B/7cDlipWnx0++7UQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LajgLtXw; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8WRonL1j; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LajgLtXw; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8WRonL1j; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LajgLtXw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8WRonL1j;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=LajgLtXw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8WRonL1j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQY9C6LkZz3bqV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 01:15:59 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B4C166D97;
	Wed, 27 May 2026 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779894956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q23F0LaqDkNSpvyAUae8noyxKMFf2FHoVKc+13avh4U=;
	b=LajgLtXwc923TvdxxNZrKlZf3QIW/eHDeXt5jFPUyECZ6/cP/5+tnmI9mriqhAFGWFlClQ
	miw/FwWP6cxZpyqneOk2K3jFz1+Y/kL4OkWr1RZEM8fot25KU/8iJACg99lEBEPtDV74xP
	ADHiTuEmS8cPjikF4MaOu1F4Aicr0/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779894956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q23F0LaqDkNSpvyAUae8noyxKMFf2FHoVKc+13avh4U=;
	b=8WRonL1j1F2umnLd7LVE/NLDmo+aMn6Vk0IuYKXG3Wfkytm8YMSTGq3WWrxMyzQHFOVX1L
	eAkrXXn8jPM4tEAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779894956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q23F0LaqDkNSpvyAUae8noyxKMFf2FHoVKc+13avh4U=;
	b=LajgLtXwc923TvdxxNZrKlZf3QIW/eHDeXt5jFPUyECZ6/cP/5+tnmI9mriqhAFGWFlClQ
	miw/FwWP6cxZpyqneOk2K3jFz1+Y/kL4OkWr1RZEM8fot25KU/8iJACg99lEBEPtDV74xP
	ADHiTuEmS8cPjikF4MaOu1F4Aicr0/I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779894956;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q23F0LaqDkNSpvyAUae8noyxKMFf2FHoVKc+13avh4U=;
	b=8WRonL1j1F2umnLd7LVE/NLDmo+aMn6Vk0IuYKXG3Wfkytm8YMSTGq3WWrxMyzQHFOVX1L
	eAkrXXn8jPM4tEAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABA825A8C1;
	Wed, 27 May 2026 15:15:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EMyqKKsKF2p6FQAAD6G6ig
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
Subject: [PATCH v3 2/4] fbdev: Wrap user-invoked calls to fb_blank() in helper
Date: Wed, 27 May 2026 17:14:03 +0200
Message-ID: <20260527151551.258659-3-tzimmermann@suse.de>
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

Handle fbcon during blanking in fb_blank_from_user(). First blank the
hardware, then blank fbcon. Same for unblanking. Update all callers and
resolve the duplicated logic.

With the new helper, fbdev's sysfb code no longer maintains fbcon state
by itself.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fb_chrdev.c   |  4 +---
 drivers/video/fbdev/core/fb_internal.h |  1 +
 drivers/video/fbdev/core/fbmem.c       | 10 ++++++++++
 drivers/video/fbdev/core/fbsysfs.c     |  5 +----
 4 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_chrdev.c b/drivers/video/fbdev/core/fb_chrdev.c
index 54f926fb411b..035e67d2c28f 100644
--- a/drivers/video/fbdev/core/fb_chrdev.c
+++ b/drivers/video/fbdev/core/fb_chrdev.c
@@ -138,9 +138,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 			return -EINVAL;
 		console_lock();
 		lock_fb_info(info);
-		ret = fb_blank(info, arg);
-		/* might again call into fb_blank */
-		fbcon_fb_blanked(info, arg);
+		ret = fb_blank_from_user(info, arg);
 		unlock_fb_info(info);
 		console_unlock();
 		break;
diff --git a/drivers/video/fbdev/core/fb_internal.h b/drivers/video/fbdev/core/fb_internal.h
index 613832d335fe..62e75bf15b9b 100644
--- a/drivers/video/fbdev/core/fb_internal.h
+++ b/drivers/video/fbdev/core/fb_internal.h
@@ -44,6 +44,7 @@ extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
 struct fb_info *get_fb_info(unsigned int idx);
 void put_fb_info(struct fb_info *fb_info);
+int fb_blank_from_user(struct fb_info *info, int blank);
 
 /* fb_procfs.c */
 #if defined(CONFIG_FB_DEVICE)
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index d37a1039e221..1a6758653b64 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -422,6 +422,16 @@ int fb_blank(struct fb_info *info, int blank)
 }
 EXPORT_SYMBOL(fb_blank);
 
+int fb_blank_from_user(struct fb_info *info, int blank)
+{
+	int ret = fb_blank(info, blank);
+
+	/* might again call into fb_blank */
+	fbcon_fb_blanked(info, blank);
+
+	return ret;
+}
+
 static int fb_check_foreignness(struct fb_info *fi)
 {
 	const bool foreign_endian = fi->flags & FBINFO_FOREIGN_ENDIAN;
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 5ece236e6252..d9743ef35355 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -7,7 +7,6 @@
 
 #include <linux/console.h>
 #include <linux/fb.h>
-#include <linux/fbcon.h>
 #include <linux/major.h>
 
 #include "fb_internal.h"
@@ -229,9 +228,7 @@ static ssize_t store_blank(struct device *device,
 
 	arg = simple_strtoul(buf, &last, 0);
 	console_lock();
-	err = fb_blank(fb_info, arg);
-	/* might again call into fb_blank */
-	fbcon_fb_blanked(fb_info, arg);
+	err = fb_blank_from_user(fb_info, arg);
 	console_unlock();
 	if (err < 0)
 		return err;
-- 
2.54.0


