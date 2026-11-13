Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F69606A882
	for <linuxppc-dev@archiver.kernel.org>; Fri, 13 Nov 2026 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OrfI5aw+
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jRDFP0Rxqz3bZR;
	Sat, 14 Nov 2026 10:37:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794566012;
	cv=none; b=QvnIO8F4eC/UH9qGY3rcSk/jdLuxf0N0NciLz7WBfDvOpFKCktyEgm0ekQ0nUGAVzHeDk3aIpxZi8wouxT7raUqM5E41mkVlqRKJXtEyYN9F/NqglctKOTtjvAt4naqqnhjX2dBu7LERrLBnM3nn+LW5I3YbAkR6rsFH5l02rPniSVnvkdnlmwopdeOmKdWDHdJiVGp2seS+vaA2AcNZuk/igumdPwENsHi4yIKUON3XMahzotIbabZIxDzuzAKWLwRNI3CSDZvi0a7sCjttYJwMxaSF730I0DKgureEBDuDM1ytO69TQ0A2gnt0OQVb+T82VxHt/38yF9qD2vrkPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794566012; c=relaxed/relaxed;
	bh=5IvnIMxNH4DFuBLSRMUrL4BN8mPeajYkYb4pg7wnNmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JeHhJMBc7UhQlygcAG436k4D8b80u4yvXRnWnR4PJVoxeltJU3FylLJN4hx7oF2+htEpiugZQZc2dzvBPuQiMAKjwkPxC1lHSAkIuvyCCrbhlFNguMZub8i0Jl1oQTqXmRzq03UJL0sk8gSRCMS8cU1vccLnmm6HDmTd6RZkve1h6zxVlADCB/4mXzSIoeqBJ7WzphBIZywaVQ9kieGM//0VuFjrCa0/ETfNFFjT9yoPg9DujQvs14GOzg1wXL0TeLy8fobl8Wl9RB0xmg7uFGBGAqPSImwtFMugz+yLKj3ptSyRNCh/SS10n5/W24XM9Y4KC/UIz3RE3kH6C224HQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; dkim=pass (1024-bit key; unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OrfI5aw+; dkim-atps=neutral; spf=pass (client-ip=111.22.67.139; helo=cmccmta6.chinamobile.com; envelope-from=chenaibing@cmss.chinamobile.com; receiver=lists.ozlabs.org) smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=OrfI5aw+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmss.chinamobile.com (client-ip=111.22.67.139; helo=cmccmta6.chinamobile.com; envelope-from=chenaibing@cmss.chinamobile.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 184 seconds by postgrey-1.37 at boromir; Fri, 13 Nov 2026 21:33:27 AEDT
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jQtrl53pbz2yFb
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2026 21:33:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=OrfI5aw+MkoZPyfArg0eobtJkTHI5gxU0Gz6eIGGAMZ9J9YWK98YRhhRy5HUw4KpG6Ki5uALS0TKp
	 B9/dfh8eXeDPkOeWN4wVKhNgMc8QDjKQuNqh+ZRL9sBdJJsBNLEzXw1k1mz1/lGp5ngbD2sCEv6TSj
	 sEeFRXvr0RBqrvq4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app01-12001 (RichMail) with SMTP id 2ee16af6e6b0322-c791e;
	Fri, 13 Nov 2026 18:30:09 +0800 (CST)
X-RM-TRANSID:2ee16af6e6b0322-c791e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHD-W7400297 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26af6e6afd4d-22761;
	Fri, 13 Nov 2026 18:30:09 +0800 (CST)
X-RM-TRANSID:2ee26af6e6afd4d-22761
From: Aibing Chen <chenaibing@cmss.chinamobile.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: aoa: size the codec reference property name buffer
Date: Fri, 13 Nov 2026 18:30:06 +0800
Message-ID: <20261113103006.705-1-chenaibing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

check_codec() builds the device tree property name
"platform-<codec>-codec-ref" in a 32 byte buffer with snprintf().
A codec name may be up to MAX_CODEC_NAME_LEN - 1 (31) characters and
the surrounding text adds 19 characters, so the full name can be 50
characters plus the terminator.  Codec names longer than 12 characters
are silently truncated, of_get_property() then looks up a property name
that does not exist, and check_codec() fails the codec with "required
property ... not present".

All codecs in the tree use shorter names today, but the buffer should
match the documented maximum.  Size it from MAX_CODEC_NAME_LEN, which
is already available through "../aoa.h".

Compiling with W=1 before this change reports:

  sound/aoa/fabrics/layout.c:780:36: warning: '%s' directive output may be truncated writing up to 31 bytes into a region of size 23 [-Wformat-truncation=]

Signed-off-by: Aibing Chen <chenaibing@cmss.chinamobile.com>
---
 sound/aoa/fabrics/layout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index 7bb541577..8ee66dabd 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -771,7 +771,7 @@ static int check_codec(struct aoa_codec *codec,
 		       struct codec_connect_info *cci)
 {
 	const u32 *ref;
-	char propname[32];
+	char propname[MAX_CODEC_NAME_LEN + 20];
 	const struct codec_connection *cc;
 
 	/* if the codec has a 'codec' node, we require a reference */



