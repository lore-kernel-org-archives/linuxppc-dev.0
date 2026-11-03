Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24946606A31B
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Nov 2026 05:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rDUUlGB6
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKDml5J0Nz2xDD;
	Wed, 04 Nov 2026 16:40:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793727825;
	cv=none; b=QeYOppB5iRbXpjG3y8x1W8OvJOI0noAWTopZbieGkpTiFp4gSbTkdD6vhGfrgf4XWlOzdY4khTv1WGEfSzUhs6NN/fwMDrPNcITHzD1gP3Wqb2+8RAed1BagW8mbART/f/19+xoh0CkSnaTEltEv7lCdRY9WxFZbD84rkEgE0pP4E6lZEIYfBmEbFwavAfXNyR/8hJX98bzewRicWPBddragu4jiqgNKLqMhNKDynYID+lIUcYXQ+zSrIsTZG28t2iDbFJBhLQWdoNQaEYT151TKBNXBdLpoPoupEubMTMiP8ruwN2V/BBca11EH7YICrAT9QvShr7D1kaJcKzxnyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793727825; c=relaxed/relaxed;
	bh=uJ2wtG0TbwKE5OUp6DvJO2lAnPSHDHBXyR6Yjzaf8Mo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaMED640DA8yAnH+VlXM4Gw5EBJD/U4XxY/QMyjhB88+k/ZAbOBxN25ar3KKlavRN2oAa6saPULPONioZ0hAjVdlu+A4ie59v7zANLaqfTLH0fxENv7GKKe3OA1FBJdwicAZ2K//WBgv2BJF9W/CeYxhR9SHQ5YPQDF1yJ4TVZV50NJKUUWsii1FA82J47j9JBVFvHcJaxLSUY+bJo/mXWCdEjb8J+sDoL5MvkdTdJkVq6uk22iNcKsW0zzDrcOWLl6vkoqfNT5AT5PVK3qMpcHP4LXCSI+wVt2dI51zgpwkPfCh9tpOptmTvrysax3Zr9bKF+41oof4WoFX2neiWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rDUUlGB6; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=yigejiang86@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rDUUlGB6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132c; helo=mail-dy1-x132c.google.com; envelope-from=yigejiang86@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132c.google.com (mail-dy1-x132c.google.com [IPv6:2607:f8b0:4864:20::132c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jJwsr61M1z2xSS
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Nov 2026 04:43:44 +1100 (AEDT)
Received: by mail-dy1-x132c.google.com with SMTP id 5a478bee46e88-36a2551d7b5so1033526eec.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Nov 2026 09:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793727822; x=1794332622; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJ2wtG0TbwKE5OUp6DvJO2lAnPSHDHBXyR6Yjzaf8Mo=;
        b=rDUUlGB6rH9r94J1tTnuJijgpyDPEdcHTJ5e7EOoOoMObYGkywtsIZeJyc2FmLVSJV
         vR1YKwly5rhfGUfwhZ3pO1Ubtwu98rFr6wE6SKRNuQv5I/AVZH1bD6GVl7g2JVh5ZgQj
         fOq45YkmpVQQK9cMO4Mc8yip7mCnglG1+lCBgdm9DYYkXI6NXf8l+qTK241lIotWJiTt
         z+re1Nt95JkMGeAwyn2dB4p8iYbmdNDaxvvrH9c+rvf/I5seCCC/nDNmAdoC0uO/xA18
         rZm2vnzslvP6prujKmoYBKM8/Qsb03nkWp0WhSNvJYEtJPX3ozGKHM/2To2hZ0j4Epc3
         OtUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793727822; x=1794332622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJ2wtG0TbwKE5OUp6DvJO2lAnPSHDHBXyR6Yjzaf8Mo=;
        b=vvj9D1JUk5ofmEoPoEvowdNO8e14Pb793sxrZdvW0iUO6G/lu+LlBGcWyS7lPgwZUy
         IqX25boHIcu5dNIuuUZ6+2vyICsRfjLchPe+NkmZxEOuDiltGgxNaZgX+etNNrvOo9tP
         OLL8l18bu1G60Z6s+qZcS2ehEESIJ03o7dPrfoDvmovyfUC8cefrpoQJmAC8cDB2VOG0
         aYwNsOUwbU7OVRXivNgCVMOFFzpF6BEaK7RQb1quYGa3ANnjeUmOp/yqQZBUuUfSD72b
         JHfv+p9rQWpeF0CqyLVJPYDVIDok1i971Tn+IbQ+s90hDTNnQmxA9zb35lJgBA/ErpbU
         Cl5Q==
X-Forwarded-Encrypted: i=1; AKwUvBxi66EPaMl5GFkOfWSRuYfQBwjEpN4P87fni/N0rAdYNJfIKZToaK3xryTm0xbJNFH+V1tBndGyvxMtiQ4=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+6wRad915XVDGwOkTiKEZVK4N0FEwNov/OO228fAg2XpT+s2QE
	deMlF7no7iqE+g9of0HdqXO/0oodV69W+YI0MBYetZltueWwgbA4RXU=
X-Gm-Gg: AYBFou0yN+ks79loSMYQ+4EyHmIlRCb1YOgjl5cG9SHn0fs4+V1cbLzG5IE+uMAKiVl
	GcGHdzzZJw+o6HdgCl4JYJTCxaHdx6qgt7NwpJxQ3JOkTZlg3b9Y20cBtmrvgSVaco5So6HlnRH
	4FArKcA3Az8s44wNlOdaN1DfSBSUXLOn7nCrCKDSlzFKsvSqfYMmceQj491fgOPhdYeLgMBLD73
	BMr8lrmMzHakIF9diFtgDKpvv4dQHDAHtRFMJa6TO6p6ATXUm9wMfu1ueQgxPRRfinnsqAQqkms
	+7v28TB2dR5VeyjxwlVfeONgfZRvFWlhvRnEfs7JSGKVljcIBss1asj985wBXbT3/WIDi/1Slq7
	fKktyesqXSkwS4XGbnJTWBDJiCh7/RNIHdmkzoK6bZx7mC81+xUTlHvyGM4CQnwgug0Qigxzz0a
	2ySBWZiQ8Ylnpy8Fe+DRzCe+OKXSL3gnb3QbDyAa3fehMV9nDeJawNgdoMgDyNPlAU+g2sXXY96
	f4p6duGWjdY9pvqOFx41cSUChL8fF/oyC6jB5bPP9pgIraV0ZxH/1KX2Ux5mQSXJH9aOQfKe7LR
	eoUZJSn27V4AoNmhmfXlxU9cG3Y8DsnTyUfatYIYilH3B5sZijnFg0PBNv/EAIa/F67a
X-Received: by 2002:a05:701b:230f:b0:1ab:9742:e860 with SMTP id a92af1059eb24-1ab9742e8e8mr19731281c88.20.1793727821880;
        Tue, 03 Nov 2026 09:43:41 -0800 (PST)
Received: from localhost.localdomain ([2406:3003:2002:639c:a995:4c32:db66:d000])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1bcedsm420380c88.7.2026.11.03.09.43.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 09:43:40 -0800 (PST)
From: Yige Jiang <yigejiang86@gmail.com>
To: linux-sound@vger.kernel.org
Cc: Yige Jiang <yigejiang86@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ASoC: fsl: pcm030: release the platform node reference
Date: Wed,  4 Nov 2026 01:43:33 +0800
Message-ID: <rc-review-20261103-07-1337c123a4ea@gmail.com>
X-Mailer: git-send-email 2.50.1
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pcm030_fabric_probe() gets a platform node reference and shares it
between two DAI links. Neither probe failures nor card removal
release this reference. The links borrow the node; assigning the
pointer twice does not acquire another reference.

Register a managed put action after acquiring the node. This covers
later probe failures and releases the reference after the card and
codec are unregistered on unbind. If registering the action fails,
the reset variant releases the reference immediately.

Fixes: 084011615c1c ("ASoC: fsl: pcm030-audio-fabric use snd_soc_register_card")
Assisted-by: LLM
Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
---
Based on linux-next next-20261102 (2637bdec0535).
Compile-tested: powerpc, GCC 14.2.0, W=1, CONFIG_OF_DYNAMIC=y.
CONFIG_SND_MPC52xx_SOC_PCM030=m.
Baseline and patched target objects built from this exact base.
No full kernel/module-link, hardware or runtime test was performed.
AI assistance: Codex (LLM) for ownership analysis, code and changelog.

 sound/soc/fsl/pcm030-audio-fabric.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index a7a5dba83a2f..64d9f7e34611 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -50,6 +50,11 @@ static struct snd_soc_card pcm030_card = {
 	.num_links = ARRAY_SIZE(pcm030_fabric_dai),
 };
 
+static void pcm030_put_platform_node(void *data)
+{
+	of_node_put(data);
+}
+
 static int pcm030_fabric_probe(struct platform_device *op)
 {
 	struct device_node *np = op->dev.of_node;
@@ -78,6 +83,11 @@ static int pcm030_fabric_probe(struct platform_device *op)
 		return -ENODEV;
 	}
 
+	ret = devm_add_action_or_reset(&op->dev, pcm030_put_platform_node,
+				       platform_np);
+	if (ret)
+		return ret;
+
 	for_each_card_prelinks(card, i, dai_link)
 		dai_link->platforms->of_node = platform_np;
 

base-commit: 2637bdec0535a2044cd830eba9a79363651d9043

