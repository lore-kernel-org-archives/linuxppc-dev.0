Return-Path: <linuxppc-dev+bounces-21244-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14FCCD5BAC
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 16:08:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLGfQ6QZZz2xrC;
	Thu, 21 May 2026 02:07:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779293278;
	cv=none; b=bJfHKXVLxl8UqwxeC0JzFnIniLVwPZa/UEKUUs1R9KeZPU0p3Jy415CXU7x+ADloR0l5tf/p0v9VdNaCBUiNLk/kQgieYWbqOQCmWOV3E2mlIdls3Vbbkf/XB9MPSmbtmmcFVyT06HrtVq/6a+uvKZmOKXSxhyYKUUpZKmhd4h1kyLuMijLlTgw6A2+cDf4WSruVcQMNIjDpQvsw0LBXvMkYT6FgW/P14sc3fmlDV8fo5o5ZfInfveE7U9szE1UZL8co9rFC8UYmCE8U7ArjsQ8bHzaOu68x6M/VU+gbyIucfomeoXUZ6oK6N+HRj3dNCn4TX2YnVTAPi7rlSo1e/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779293278; c=relaxed/relaxed;
	bh=BsIHtmKMljMz7z5PREYhvn3TDXWyUdpRgr9wgteuRFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SMGlWCRIXSyrNS+6ke3lYQPlTLlHlNQzIx6s0WqoUhM/B5u/JaavI00Vw+6JIhEAU7ag5KIpIsuAm33gGDoIvXpMl3EF42SNwmqdUr3z4116SqyV8Ki65vUm3C3uL6w2aichiEQtMUeD8GwKpYDzhJWE0UAbmtf4NybEsPYKHCee/8fnpE2jn+PHzJ/mXw1uPS36X5Gd6qMqvOjO5qDnqRsQj9TFYWJFxlUnMI6+5MCxDjgKelJqAiBOkUCuepQ3LHm8py8XzKUTCmqTLxYCYcpDA3AOUgvCpXNRgmF8K1yVmL1S3BhfZPuv96PT2T7Xrk7BWOac3lyMkWZbMBxfTw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dwTKUIdn; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Lt3vjNt0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dwTKUIdn; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Lt3vjNt0; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dwTKUIdn;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Lt3vjNt0;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dwTKUIdn;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Lt3vjNt0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLGfP38k8z2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 02:07:57 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A62A6BAB5;
	Wed, 20 May 2026 16:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779293274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsIHtmKMljMz7z5PREYhvn3TDXWyUdpRgr9wgteuRFs=;
	b=dwTKUIdnMGhcIj5IYEaBkI0IBx6iyWGBppuPdWRhme62X8ZZ1twGD9ITsuMdBjdJtkj1ez
	ujFrXsGEnytMDtwRb6GTvGRSS5YPU+1DntFP3ccAt19CzxLAHEExY1jSm2DAn/3mcXdz0Z
	hGKK7J7OTuIu7mtoSvg6gXxxOgz69yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779293274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsIHtmKMljMz7z5PREYhvn3TDXWyUdpRgr9wgteuRFs=;
	b=Lt3vjNt0H0Ob8JlzBUOJ//Yhp+FroFF77zOFWU/yGTs5/tBXpSYbJ3if7Z7/uIqoNU84l0
	mBhgpfUsfTo5iKAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779293274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsIHtmKMljMz7z5PREYhvn3TDXWyUdpRgr9wgteuRFs=;
	b=dwTKUIdnMGhcIj5IYEaBkI0IBx6iyWGBppuPdWRhme62X8ZZ1twGD9ITsuMdBjdJtkj1ez
	ujFrXsGEnytMDtwRb6GTvGRSS5YPU+1DntFP3ccAt19CzxLAHEExY1jSm2DAn/3mcXdz0Z
	hGKK7J7OTuIu7mtoSvg6gXxxOgz69yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779293274;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BsIHtmKMljMz7z5PREYhvn3TDXWyUdpRgr9wgteuRFs=;
	b=Lt3vjNt0H0Ob8JlzBUOJ//Yhp+FroFF77zOFWU/yGTs5/tBXpSYbJ3if7Z7/uIqoNU84l0
	mBhgpfUsfTo5iKAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E748F593AA;
	Wed, 20 May 2026 16:07:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DGLON1ncDWqwWgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 20 May 2026 16:07:53 +0000
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
Subject: [PATCH 0/4] fbdev: Internalize fbcon
Date: Wed, 20 May 2026 18:00:35 +0200
Message-ID: <20260520160744.130841-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch,gmail.com,wunner.de,linux.ibm.com,ellerman.id.au,kernel.org];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]

Turn fbcon into an internal client of fbdev. Manage all interactions
with graphics drivers within fbdev. Add helpers for these tasks and
convert drivers.

Fbdev's PS3 and SH-Mobile drivers update fbcon as part of user-invoked
mode changes. Call the new helpers, which also fix inconsistencies
among the various code paths.

Vga-switcheroo remaps the fbcon terminals when switching physical
outputs. For now, hide this in another helper. The call will later
move into DRM's fbdev emulation.

When all refactoring in place, fbdev manages fbcon interactions by
itself. Remove the public interfaces.

Thomas Zimmermann (4):
  fbdev: Wrap user-invoked calls to fb_set_var() in helper
  fbdev: Wrap user-invoked calls to fb_blank() in helper
  fbdev: Wrap fbcon updates from vga-switcheroo in helper
  fbdev: Do not export fbcon from fbdev

 MAINTAINERS                            |  1 -
 drivers/gpu/vga/vga_switcheroo.c       |  6 +--
 drivers/video/fbdev/core/fb_chrdev.c   | 12 ++----
 drivers/video/fbdev/core/fb_internal.h |  1 +
 drivers/video/fbdev/core/fbcon.c       |  3 --
 drivers/video/fbdev/core/fbcon.h       | 50 +++++++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c       | 35 +++++++++++++++-
 drivers/video/fbdev/core/fbsysfs.c     |  9 +----
 drivers/video/fbdev/ps3fb.c            |  5 +--
 drivers/video/fbdev/sh_mobile_lcdcfb.c |  5 +--
 include/linux/fb.h                     |  3 ++
 include/linux/fbcon.h                  | 55 --------------------------
 12 files changed, 98 insertions(+), 87 deletions(-)
 delete mode 100644 include/linux/fbcon.h


base-commit: 121c16f9d8c56ea07263df84ab971cc10870fe88
-- 
2.54.0


