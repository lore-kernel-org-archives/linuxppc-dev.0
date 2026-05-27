Return-Path: <linuxppc-dev+bounces-21592-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046A8CD5BD5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 15:16:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQY9G2jxHz3cX6;
	Thu, 28 May 2026 01:16:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779894962;
	cv=none; b=ZiuXZCmsSDezc9uakB2fjyWhVv9+pbzd5GxLZ7fLYQP0Y+5CJUPGhJ/1A7PslNlz900qCOIMgB5YOr9p8aKfQVjoP2HfCY3IoFD1dRKa0M5s4/zUfbHXnPZrbA44X1c0GCHrkQZLmtrxBxmjfrIAaqjXEMNfmmnEyz2Y0OXAPOnt5Pu+Q27e1HQ2aqMicXH2CMPkS+GLqXaWZEHtQub2IdQo5dr7jtOUg6lSqlZFpxvq7tIWnMy9fzfj6Wj81jQc8R06YZ2xVL2W2NXbgfAXJ1aG5Pg8TNOWAFgpKKT4OfdbGZigcx8WEqphQENU1YxfclpKqLAOwVoM1dqsYEm2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779894962; c=relaxed/relaxed;
	bh=BwKD8u/oFzgxbvk0UW8C8FJ0orKlewT3AkmJOJgnQXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a7s2pVPlZTGGoRBOTT5gwwzWKquFLcsJ06/sXFNSaV/xl5de1Z8uFHldPOxzKLDSrfEVPl+Zoe4iikxHzMpcn/w0bBaRi560z2mT6AfysukSMiYW3vuh6xzqHgMQ3SfuXkeopehKObOTXie6iV0d9hDmGRtghhd8QypeCR2Z/23m+eg0wcLlinUkjcNmYou/IB1RH0EbhzV29ML/Jqxb3zkS09rqASgr6nx8kXWz1PrvcogAFQnbBRw9BnVltC5yt6XB31QMbu2iL77ysz9HgpEeIsJsn4F9htSFqz3AQKS6WZbD+P6HI5KOvipoQpLCai22uTWAqlvartMKAnUYPg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EgDs66DT; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mfwVqURc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EgDs66DT; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mfwVqURc; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EgDs66DT;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mfwVqURc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=EgDs66DT;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mfwVqURc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQY9C6HnGz30Wn
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 May 2026 01:15:59 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BB596A9B1;
	Wed, 27 May 2026 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779894955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BwKD8u/oFzgxbvk0UW8C8FJ0orKlewT3AkmJOJgnQXw=;
	b=EgDs66DTREZMPkqpwlSW7x3i5hxMbdCzFi9MujxugNSU+OA9XEklbUXmWtCF1y+H+ikJ6Y
	uXQa47jzn+Cwbnyp7yquxz3a29yXy6CW9EqE9Jf6pmU0Z5Y+kSxasL2D503QiOZNd+sNNv
	/TgxXUQRA535R9+Fb4JcqeYuNoHHYDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779894955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BwKD8u/oFzgxbvk0UW8C8FJ0orKlewT3AkmJOJgnQXw=;
	b=mfwVqURcXjstDdXst6R+1tJatuARK/bqZoM3AR2T9cvK/Ub6zljgI/GlruyxHphJju8Zvy
	CunfSqDNRrfWptDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779894955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BwKD8u/oFzgxbvk0UW8C8FJ0orKlewT3AkmJOJgnQXw=;
	b=EgDs66DTREZMPkqpwlSW7x3i5hxMbdCzFi9MujxugNSU+OA9XEklbUXmWtCF1y+H+ikJ6Y
	uXQa47jzn+Cwbnyp7yquxz3a29yXy6CW9EqE9Jf6pmU0Z5Y+kSxasL2D503QiOZNd+sNNv
	/TgxXUQRA535R9+Fb4JcqeYuNoHHYDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779894955;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=BwKD8u/oFzgxbvk0UW8C8FJ0orKlewT3AkmJOJgnQXw=;
	b=mfwVqURcXjstDdXst6R+1tJatuARK/bqZoM3AR2T9cvK/Ub6zljgI/GlruyxHphJju8Zvy
	CunfSqDNRrfWptDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA48E5A8C1;
	Wed, 27 May 2026 15:15:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QMq3N6oKF2p6FQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 15:15:54 +0000
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
Subject: [PATCH v3 0/4] fbdev: Internalize fbcon
Date: Wed, 27 May 2026 17:14:01 +0200
Message-ID: <20260527151551.258659-1-tzimmermann@suse.de>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,linux-m68k.org,ffwll.ch,gmail.com,wunner.de,linux.ibm.com,ellerman.id.au,kernel.org];
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

With all refactoring in place, fbdev manages fbcon interactions by
itself. Remove the public interfaces.

v3:
- resolve vga-switcheroo dependencies wrt fbcon (Geert)
v2:
- use '#if defined' (Helge)

Thomas Zimmermann (4):
  fbdev: Wrap user-invoked calls to fb_set_var() in helper
  fbdev: Wrap user-invoked calls to fb_blank() in helper
  fbdev: Wrap fbcon updates from vga-switcheroo in helper
  fbdev: Do not export fbcon from fbdev

 MAINTAINERS                            |  1 -
 drivers/gpu/vga/Kconfig                |  2 +-
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
 13 files changed, 99 insertions(+), 88 deletions(-)
 delete mode 100644 include/linux/fbcon.h


base-commit: 5fb5a9a63cf5ece68e0eeb6fa397da27712bccf0
-- 
2.54.0


