Return-Path: <linuxppc-dev+bounces-19259-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5816D73087
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 02:31:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fn2lt20dtz2yVP;
	Fri, 03 Apr 2026 13:31:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775181294;
	cv=none; b=CnzDk8t5/oDqhiApGUjLNUe2LJS7X+nVhi/bW/2k8OrIBjOE44adCtTUfNACqCLl0LM//xudg2RUd7mBNjU4w8ViRzR4ioCkRp6YrYcomHtHpa8briRgUsq3kbbpHt1y60nFeheLtcKiVfLckubwgafclbzC5JltqA3RUA8TEZyG+A2ePLgLhgroE/vdbPB7GZV8mAN/IEwi1Bprx4ZLYCVOtCCDbJZpHWGk08S3mXJQSsRakkuQ8CjrgGb1KVzdM7ti9FCerVwpwRFgOJ/Fur31h7nK9mfdTZaBWgw0J2j3kk4wYjMSQIcbXuSjnUgF+GWMHL4QloKv9gH8tq5utQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775181294; c=relaxed/relaxed;
	bh=BjV3zxihmqtsHZ19nXPiN3UVuXXarr2GiOFicubZu5E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D9TRUoLgQFIMjeFJvD1phjc0HpNKXTYNO/+T9VQwzHyNsZy1bei7iKsnM6y4Bas/EfdDIWVJfGbxdGjR0vp0ZDMO+SAPUSKGkCmVojeJMJPn6yceR0/d2l28UmJWCKNown+tsmseb7g8nEFhmjUTgqbjW26ukKNF2l0Gnyh6R3uxutc9ijQ6bKbSAKXwsuoY1KMCi9ThZ7h2TMI1sl5t/dddD6Dijj4zJvULycBaUDDDoCgxhd08w0CAmRoEkVpdityJA+N2Tr9uNSX03YenIMqa47VdLkjSMLqmv14inep2RoZyarJpBsi5T73Jc2b2swMCjVD5tscOd0o+CFRamQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com; dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JmWex4Mu; dkim-atps=neutral; spf=pass (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=wangdich9700@163.com; receiver=lists.ozlabs.org) smtp.mailfrom=163.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JmWex4Mu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=163.com (client-ip=117.135.210.3; helo=m16.mail.163.com; envelope-from=wangdich9700@163.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 248 seconds by postgrey-1.37 at boromir; Fri, 03 Apr 2026 12:54:51 AEDT
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fn1xl0Dh5z2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 12:54:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Bj
	V3zxihmqtsHZ19nXPiN3UVuXXarr2GiOFicubZu5E=; b=JmWex4Mua9Xg4/86TY
	zcwXRxtax+2rLvsfBAqbisZHilh2k1Q9wXQW09AYr2ilb18n937Mw2enT7rM/z/Y
	KOC8+ll+res7BrGkNY1g/GgswlA9piJ4lnare4P9yKZkGMQlrBYM9Tt+VkmtC+i/
	Hwl81/BkN+SCV6K8ki3CruJ8E=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wBnZAE6HM9pTfLWCw--.54645S2;
	Fri, 03 Apr 2026 09:47:39 +0800 (CST)
From: wangdich9700@163.com
To: johannes@sipsolutions.net,
	perex@perex.cz,
	tiwai@suse.com,
	wangdich9700@163.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH v2 1/2] ALSA: aoa/onyx: Fix OF node leak on probe failure
Date: Fri,  3 Apr 2026 09:47:36 +0800
Message-Id: <20260403014736.33014-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wBnZAE6HM9pTfLWCw--.54645S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Gr47JryxtFW3uF18Cw4Durg_yoWfZrX_JF
	409rZYg34rKr4xCw4DXFWSvw1v9r18Ca1S9FnYyF17C34rtrs8CFnIyFn3Cr9rWryIkFy3
	JFn0qr1UGrWakjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRqPS4PUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/xtbC5xtjsmnPHDsfiQAA36

From: wangdicheng <wangdicheng@kylinos.cn>

Add missing of_node_put() in the error path.

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---

v1->v2:
onyx_read_register()--->goto fail--->kfree
aoa_codec_register()--->goto fail_put--->of_node_put + kfree

 sound/aoa/codecs/onyx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 04961c456d2c..da0eebf5dfbc 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -980,10 +980,12 @@ static int onyx_i2c_probe(struct i2c_client *client)
 	onyx->codec.node = of_node_get(node);
 
 	if (aoa_codec_register(&onyx->codec)) {
-		goto fail;
+		goto fail_put;
 	}
 	printk(KERN_DEBUG PFX "created and attached onyx instance\n");
 	return 0;
+ fail_put:
+	of_node_put(onyx->codec.node);
  fail:
 	kfree(onyx);
 	return -ENODEV;
-- 
2.25.1


