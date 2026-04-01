Return-Path: <linuxppc-dev+bounces-19125-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BB9D35157
	for <linuxppc-dev@archiver.kernel.org>; Wed,  1 Apr 2026 08:30:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flyqH0j9Fz2ySY;
	Wed, 01 Apr 2026 19:30:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775032235;
	cv=none; b=FWgzkCq4ZKUQ8rJ/1HsX+cf6AUy9ugYhbteRpgkaTPljLz341JM+FORbSmkDt4CMcVVHEaJWWHUTREntls8wLvoR7ntpPQHxw/GGWc73VkiRlpmwYa+O0QPRfT/LipPAbEwdhzrLhFO9H1hvYcfsv8e7Vd4DesWkQWKdD9Q3awcIlfqxFvbAXi3whWLKvTPTvzGkDUKLFwgmwopDiP12A5zOkJhPfRqWNSwqE5gXIGYfYeY7C/T2GLwzJt8xyXLL0V/MF3dGdUIJIDdOrwCkRlaa9QHDDei87WJkgk5UJGb+w67/DIE0Gt11mV6Y/GF2qNVvusdD6qruvFa3i26E0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775032235; c=relaxed/relaxed;
	bh=8CnmapT0V8m+IRQyLVEPql2MsIMw0+8dAbXhsqMlKGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i5ENzioAFUYo/8B6EIuuSwV8hti2a+RJHZii4ezQzaBomuS9I/s/kjCMqYIXpfWE9LNcINhzD3YA/+JLhhmMGSDJ4eXVG5PBWjJ2AmP7pQ6C1G/d6K4MnBeoy8zypYUp5vknRp6DjlKOgC3fW/irl1b0lpyYzaWP/Qi1UU2VHQQSWnHnJ10EwzU8iepBfZrH3A9wF1h+X3BJyGFTok1gSarWDXjimDA05pNKYC6Iv5flpTHYTAqBk0MrxgDwXmyTfNzYuMO3rhdVxfqHetG1KXn5ZL6rScU4nkibPlHdEprKKHeVGsteKjZjBEKk1bPGSaylPv3LFGGUbP8QkRioMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de; dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FCFXTxnw; dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ni27gQBz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dPJYVOJR; dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=y9vtFWX1; dkim-atps=neutral; spf=pass (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org) smtp.mailfrom=suse.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FCFXTxnw;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ni27gQBz;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dPJYVOJR;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=y9vtFWX1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=suse.de (client-ip=195.135.223.131; helo=smtp-out2.suse.de; envelope-from=tzimmermann@suse.de; receiver=lists.ozlabs.org)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flyqG0dgtz2xpk
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 19:30:34 +1100 (AEDT)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EAC045BD5E;
	Wed,  1 Apr 2026 08:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775032227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8CnmapT0V8m+IRQyLVEPql2MsIMw0+8dAbXhsqMlKGg=;
	b=FCFXTxnwcs7KVAer+Im7ZNmgaWlMlwSbSqhZ2nbIaTiOSfZH4xQDB3pQnyXWHKR1SLHqee
	h7CNSz5zPU6fLac1lIrU51T3LJbg7+XzjHMhDrG5gH70DGZhkvRDkTMBb8EedTqDlkf0SB
	eMVHOVD7mvBzIMT1zh8Sa1napm09fdc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775032227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8CnmapT0V8m+IRQyLVEPql2MsIMw0+8dAbXhsqMlKGg=;
	b=ni27gQBzjHebaov+w2Yzua09qHaqHDFtJssJLvORnmojZh6xFfS8YMvOEuhki0dv3QjQPO
	yTLLr44PjFP+BNAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775032226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8CnmapT0V8m+IRQyLVEPql2MsIMw0+8dAbXhsqMlKGg=;
	b=dPJYVOJRH5nOmy/fJMmSRAJvFU/RjB9p1fWHuwG0n884SpQftpfcFkoRJdi98d17chIuHg
	VLXlFB3DHPIts3N+qtYfFuFpAXlPkTKaRAnMRabF2+ZlphdETAoDGmEpgUZjYeEOKA3QQi
	GnJPGomyDVL+tMHUokEDiqzjffA+JbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775032226;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=8CnmapT0V8m+IRQyLVEPql2MsIMw0+8dAbXhsqMlKGg=;
	b=y9vtFWX1pf1T5ArrkXwSwNTKUuAEYX8T+gEsE15QqQVq2hF7TCRQ10iaAE2+OEihwd7fUP
	HXJOfUvHCeFoO0Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABE764A0B0;
	Wed,  1 Apr 2026 08:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DAh/KKLXzGkkCQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 01 Apr 2026 08:30:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	arnd@arndb.de
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] arch/powerpc: Drop CONFIG_FIRMWARE_EDID from defconfig files
Date: Wed,  1 Apr 2026 10:30:03 +0200
Message-ID: <20260401083023.214426-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,arndb.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
true here, so drop the lines from the defconfig files.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/powerpc/configs/amigaone_defconfig | 1 -
 arch/powerpc/configs/chrp32_defconfig   | 1 -
 arch/powerpc/configs/g5_defconfig       | 1 -
 arch/powerpc/configs/pasemi_defconfig   | 1 -
 arch/powerpc/configs/powernv_defconfig  | 1 -
 arch/powerpc/configs/ppc64_defconfig    | 1 -
 arch/powerpc/configs/ppc64e_defconfig   | 1 -
 arch/powerpc/configs/skiroot_defconfig  | 1 -
 8 files changed, 8 deletions(-)

diff --git a/arch/powerpc/configs/amigaone_defconfig b/arch/powerpc/configs/amigaone_defconfig
index 69ef3dc31c4b..7a515390646b 100644
--- a/arch/powerpc/configs/amigaone_defconfig
+++ b/arch/powerpc/configs/amigaone_defconfig
@@ -76,7 +76,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_TILEBLITTING=y
 CONFIG_FB_RADEON=y
 CONFIG_FB_3DFX=y
diff --git a/arch/powerpc/configs/chrp32_defconfig b/arch/powerpc/configs/chrp32_defconfig
index b799c95480ae..66eae5b7e16c 100644
--- a/arch/powerpc/configs/chrp32_defconfig
+++ b/arch/powerpc/configs/chrp32_defconfig
@@ -76,7 +76,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_NVRAM=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_OF=y
 CONFIG_FB_MATROX=y
 CONFIG_FB_MATROX_MILLENIUM=y
diff --git a/arch/powerpc/configs/g5_defconfig b/arch/powerpc/configs/g5_defconfig
index 428f17b45513..ed051fbc7b69 100644
--- a/arch/powerpc/configs/g5_defconfig
+++ b/arch/powerpc/configs/g5_defconfig
@@ -123,7 +123,6 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_AGP=m
 CONFIG_AGP_UNINORTH=m
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_TILEBLITTING=y
 CONFIG_FB_OF=y
 CONFIG_FB_NVIDIA=y
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 8bbf51b38480..89bcbeb05067 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -98,7 +98,6 @@ CONFIG_SENSORS_LM85=y
 CONFIG_SENSORS_LM90=y
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_TILEBLITTING=y
 CONFIG_FB_VGA16=y
 CONFIG_FB_NVIDIA=y
diff --git a/arch/powerpc/configs/powernv_defconfig b/arch/powerpc/configs/powernv_defconfig
index 9ac746cfb4be..fea71d647375 100644
--- a/arch/powerpc/configs/powernv_defconfig
+++ b/arch/powerpc/configs/powernv_defconfig
@@ -198,7 +198,6 @@ CONFIG_I2C_CHARDEV=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_DRM=y
 CONFIG_DRM_AST=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_OF=y
 CONFIG_FB_MATROX=m
 CONFIG_FB_MATROX_MILLENIUM=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 2b0720f2753b..2b358c242123 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -251,7 +251,6 @@ CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_AMD8111=y
 CONFIG_I2C_PASEMI=y
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_OF=y
 CONFIG_FB_MATROX=y
 CONFIG_FB_MATROX_MILLENIUM=y
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 90247b2a0ab0..80606a5e6475 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -120,7 +120,6 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_AMD8111=y
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_OF=y
 CONFIG_FB_MATROX=y
 CONFIG_FB_MATROX_MILLENIUM=y
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index 86c74146824a..879e57629af7 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -216,7 +216,6 @@ CONFIG_SENSORS_IBMPOWERNV=m
 CONFIG_DRM=m
 CONFIG_DRM_AST=m
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
-- 
2.53.0


