Return-Path: <linuxppc-dev+bounces-21391-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CC5FCD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 May 2026 12:30:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gMPkd1dNRz2yHT;
	Fri, 22 May 2026 22:30:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779453033;
	cv=none; b=gNFIr4Q9PrR0AP5fHr5B8ln113KwFpDpYUrBj2ScIKZr/4qIp3uzf09Swet6kYOiZ3oB46sCYNXigGC1+uq3PM7nSZa6u01tImWkNlp7UC4TFKc4L5MvCf+1XHFlHRQqr++JSYAzYe4c9NXckRkMEM3HE+gYiwyyZEldCjvVisRhzqWg4SPNqwkNPkKUq28btBK8CvJrHDsiSthg6h2RR53POU9VIH4DUcC2pOFDu33EjVftu33FXU/PwOJAFKhjyapq/Z2yjg9tCTER7N9hG+himdrKgOPHqog1EvdZihNCl1CPtG77WQ0YjddFx5KLDLy+JCBS0kvXisgruCJAcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779453033; c=relaxed/relaxed;
	bh=UALBSGuAGg/xyDl1SGNmBoW3BaheeXzgPMspM9tuiGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=onxcYSfBoKsddmdPIzFSqIoqdSiR2Of8r4OqX3nsTm2M5QIBqSYngGDkdgmPZF+y91YAi6OhpN2oL+zSv5blP+7UoQHNcpKVus1N509DpVBwxrf2r6qKbxMDCOJ6jz15QA9H1065GbiUoMFsAQfND9on316H/Ik/b8sIjyElwIMATr0KaHVr/AzwPthdMc+RiarJ4dkVIcR4UBIfGLM1q9hY8qvCr0s7G2reEV1eRiIiF5LwbXfcmmqHXLzHkV1NuW0KFLcx/mFo2BMIOH9cWm58BON3YmovqK7MfGT0/w3cyOl3rVYkzJPs8axuSVfgathMYNjYPi8qulXdlgjwjw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L5J2qNFY; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=18C+Yd/x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L5J2qNFY; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=18C+Yd/x; dkim-atps=neutral; spf=pass (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L5J2qNFY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=18C+Yd/x;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=L5J2qNFY;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=18C+Yd/x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.130; helo=smtp-out1.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gMPkc1dkfz2xpn
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2026 22:30:31 +1000 (AEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C7F4E6BD1B;
	Fri, 22 May 2026 12:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779453027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UALBSGuAGg/xyDl1SGNmBoW3BaheeXzgPMspM9tuiGs=;
	b=L5J2qNFYCqJvKXgaeaj8vYv1b68CwETD3OTqwg8VNPWgRWPwOzlJak7pIAlw0n8RPYrONL
	s9eJRDzU/C+YNtJRhNp7oX/uUvu9poGPFZn2lv1A4yuNlcz2NxwKoUylx3adJEl6idr9Z2
	sRDbj2ztCB2RNX1c4MFfwrmPm+wtt9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779453027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UALBSGuAGg/xyDl1SGNmBoW3BaheeXzgPMspM9tuiGs=;
	b=18C+Yd/x4nZDxdMX2LWZ6zKwhsStD7LRuH6UQVy5S8d++pOFA+nXpWArZzK1PBxDM25YS5
	jc32A1JE4eFynVDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L5J2qNFY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="18C+Yd/x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779453027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UALBSGuAGg/xyDl1SGNmBoW3BaheeXzgPMspM9tuiGs=;
	b=L5J2qNFYCqJvKXgaeaj8vYv1b68CwETD3OTqwg8VNPWgRWPwOzlJak7pIAlw0n8RPYrONL
	s9eJRDzU/C+YNtJRhNp7oX/uUvu9poGPFZn2lv1A4yuNlcz2NxwKoUylx3adJEl6idr9Z2
	sRDbj2ztCB2RNX1c4MFfwrmPm+wtt9M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779453027;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=UALBSGuAGg/xyDl1SGNmBoW3BaheeXzgPMspM9tuiGs=;
	b=18C+Yd/x4nZDxdMX2LWZ6zKwhsStD7LRuH6UQVy5S8d++pOFA+nXpWArZzK1PBxDM25YS5
	jc32A1JE4eFynVDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77788593A8;
	Fri, 22 May 2026 12:30:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0rzyG2NMEGqqeQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 22 May 2026 12:30:27 +0000
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
Subject: [PATCH v2 0/4] fbdev: Internalize fbcon
Date: Fri, 22 May 2026 14:28:12 +0200
Message-ID: <20260522123019.211059-1-tzimmermann@suse.de>
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
X-Rspamd-Queue-Id: C7F4E6BD1B
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch,gmail.com,wunner.de,linux.ibm.com,ellerman.id.au,kernel.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action

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

v2:
- use '#if defined' (Helge)

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


base-commit: f103db97c610a41177720b08aa4a2a05f9b42d49
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
-- 
2.54.0


