Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7392E606A31C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Nov 2026 10:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LYe1n5vh
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jc6Y04M0sz2xLm;
	Sat, 28 Nov 2026 21:51:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::132d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795853473;
	cv=none; b=EPxRBeZzGSF+fYvTyKzeO2jtw1DZA1/V3T4v6TLUCjABq30r4UrmIVVjqhNk5Qa5SzaQ675G6XZB3yXCoG/LtYhPO5pv1UTdpdnkugWxiuHvj99c/T00VTE5ckN6bhqi1/Yb3wayxOg/tJ7Z6EUcNJUfzYNcNfpXKcq/x0X65SZ0HOrXyxuEuCIy/tzKHnFubfwVRMfRn3Uyfsz2BySrPxWIDQK/6nJ5Ck2zgi9noM+hDpzx46ptvYUhmqDisobc2ULNtcrUcnTMWN9svBk6hHMRWiWJeapC+dHaOHL8WO0ziNoLxe1nFWnt5C8aEQ7oBQ2tliUWJy4rOh6zLAyZig==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795853473; c=relaxed/relaxed;
	bh=/NKgGI4baMEt3ekgY9p12tXsFBBeGRj9nnWHy6cARGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJBBgCc3sNv87hFeNYg+P7WPnb3ES8J1tPFZom1luNey1cYCJacKQE9pHFh9bvPC26euaKlctfWjZw8qWsnYATpxWbnislI1KX9CLmx7kZhzdugQomy8dYV0MKS+qP/ZSytDoEyJivbBK4XT/3B5KjSmF3taGt1ST6kIF9xWbqbng0O+UANIkq8VJF9RUJ4VpoEJ/yFzjAY167GkZKmB4tcWCNBKhcVyzPGTX7be5atqiKfScNNpQzDWNjsMAjzN++PID3OI7VzViNyB7eOXAHcX2IHzg6oCeI+19rSYwFMsWVvs8LEyBCrG72Y0Ea3betNhkDdNIyNmhPQ0K1nUHg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LYe1n5vh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=sreekuttan2156239@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LYe1n5vh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::132d; helo=mail-dy1-x132d.google.com; envelope-from=sreekuttan2156239@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x132d.google.com (mail-dy1-x132d.google.com [IPv6:2607:f8b0:4864:20::132d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jc2zg5MTbz2xqv
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 19:11:10 +1100 (AEDT)
Received: by mail-dy1-x132d.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso7163214eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Nov 2026 00:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795853468; x=1796458268; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/NKgGI4baMEt3ekgY9p12tXsFBBeGRj9nnWHy6cARGA=;
        b=LYe1n5vhKyCNcgNSXlLiqsEp8kAcQa7sGorfgawDOIFf7aO4rintmYPtPgA68XVoDF
         2g/parW1jimNBKeHKEBtBydxjXJU2YsfB1fI+koODIaeaQdLbvNAvctLSWz2LLdsBv4H
         b3ka3UM9lprhTt08oqhy305VgemHiQhXeLjgghREMdpnSZSFDnRSmQgwxPepNyAKw+IJ
         m8xeHi+iExnFuHRoRVLlc4kxaK/pTa6O2504AC704FXBd9t+CNyfwXULhFjCDLQ4Mbdh
         hY7mTmccFCnTd3C1ZLFW5ekVqOZVUJZSrkhghcgi3wjyzVmRLP+dXvZATERkH6huk5R6
         M+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795853468; x=1796458268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/NKgGI4baMEt3ekgY9p12tXsFBBeGRj9nnWHy6cARGA=;
        b=lWf7nl7ww50Do34rd6MTbfp0UhDxkLy9BzXZCbHvgbo9NshDK5LmqiwMgYYxWn1DYM
         Ou4jc99YzMbax43sDzIBi5xzUyWgsd4EUm1l0hHANyGvokzYiXTB+zRCWUh8LlWiIQwx
         fIGszjTUrLEzldXuc8Mg2+wUIO1DJDqMQbrhRauaGhTBzSr+J4elhoQctX+UHLghAvn9
         E/eAlQeUzv83eex9GpPng/MMPMD8CizbTRdsq3Pvtt1I9vhjhU+siR5PVjO4DU5I7O2i
         08vgzw854tBR8Ot2vzBX5Jyp2Fch0vd4ieyA5LPFuhTf/xwDaA5K6m9i0tv4AmMZW90g
         Cjiw==
X-Gm-Message-State: APuU4Z/RAXamEr2zp+8G4ETCAFS97740qGZpOcqyGQVQEb3t44bxBwUK
	dlAGFCEI6BvK7G57gaHPvMno+LOQtr3BtBrwShhX4FUTmFB4Ljae/NTq
X-Gm-Gg: AZFdTZddO9T0nhMEr1gTnbnvhu5GyXpFAzoOThGq3q5O/UD9dRsdDdDAiQblM61Q8AI
	5UnVkBnoFYzoQIB818llBNkguqbAPZaWmkttisASgs6GrVRNWJMApn556cT8lOiXfpmVzgbGWRN
	xEqlGKeYNz4hn4UmJpA/b4ZiNw87oVcd45IhVc8sBO3gwfjPqyCW1o1xHLNe5J8uXP8TObh/JZq
	sNMHxV/ToUrkrBS9YLiYJrH0j780GOleDie8NuFgAzYBi8WBAojZVsGfMychesCpNRPbOVYkkbl
	C7YeYdvWpgfOMGRf8q7R2srPsysSpMSPmO8MZOzPMIPIedobUx0tR1OFj+xzX/O7rVoAf6BqUoQ
	eKfE+5ebLz2uKAcwmo2oouFquQUigvwwylnguglXlaEoQWGvsQuXnKuO3XMV/FLVD4K5mnEPVOn
	1zQ7qa3qXQdde4W2lug8GTMnUR1a0nSt2kEk/VASBj7xWNOXEpyMGH9bmbtMAn40jPg08CsJSJS
	2CdAmJtFv4A03olyKqIgTQUQP78M2gl1N/Wbfn2ADbiOFaoCK5ciRmaYPB18FS9MG8r+ZvEiw0t
	r0mqiZ1A00LUYwFz2usyXx28S8DA1x2twlU2m6731H3hDFX3O4dm
X-Received: by 2002:a05:7300:601e:b0:386:1e2e:ce0a with SMTP id 5a478bee46e88-3861e2ed1bcmr26545761eec.27.1795853467909;
        Sat, 28 Nov 2026 00:11:07 -0800 (PST)
Received: from localhost.localdomain ([103.179.230.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386b9bdafb5sm47038711eec.9.2026.11.28.00.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 00:11:07 -0800 (PST)
From: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
To: johannes@sipsolutions.net,
	perex@perex.cz,
	tiwai@suse.de
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sreeraj S Kurup <sreekuttan2156239@gmail.com>
Subject: [PATCH] aoa: Fix codec unregister handling
Date: Sat, 28 Nov 2026 08:10:25 +0000
Message-ID: <20261128081025.2878-1-sreekuttan2156239@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Fix aoa_codec_unregister() to use the codec's own fabric pointer
when removing a codec.

Previously, the function checked the global fabric pointer instead
of codec->fabric. This could call the fabric's remove_codec()
callback for a codec that was never attached to the fabric.

The function also called module_put() unconditionally, even when
no module reference had been acquired by attach_codec_to_fabric().
This could cause an incorrect module reference count.

Save codec->fabric before unregistering the codec, and call
exit(), remove_codec(), and module_put() only when the codec is
actually attached to a fabric.

This also prevents releasing the module reference a second time
when codec initialization has already failed and the attach path
has cleaned up.

Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>
---
 sound/aoa/core/core.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/sound/aoa/core/core.c b/sound/aoa/core/core.c
index 99b032a4081f..41a3b79ca93a 100644
--- a/sound/aoa/core/core.c
+++ b/sound/aoa/core/core.c
@@ -71,13 +71,18 @@ EXPORT_SYMBOL_GPL(aoa_codec_register);
 
 void aoa_codec_unregister(struct aoa_codec *codec)
 {
+	struct aoa_fabric *codec_fabric = codec->fabric;
+
 	list_del(&codec->list);
-	if (codec->fabric && codec->exit)
-		codec->exit(codec);
-	if (fabric && fabric->remove_codec)
-		fabric->remove_codec(codec);
-	codec->fabric = NULL;
-	module_put(codec->owner);
+	if (codec_fabric) {
+		if (codec->exit)
+			codec->exit(codec);
+		if (codec_fabric->remove_codec)
+			codec_fabric->remove_codec(codec);
+
+		codec->fabric = NULL;
+		module_put(codec->owner);
+	}
 }
 EXPORT_SYMBOL_GPL(aoa_codec_unregister);
 
-- 
2.55.0


