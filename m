Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E98F606EE90
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aX2Km8DG
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKzSQ6NKlz2yGT;
	Thu, 05 Nov 2026 21:43:50 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793875430;
	cv=none; b=NOqAyBwikcNCE/v00KBpWfW6YuK+Ywh6qxyOfiY1DrOjck2gh0yWHXrrBUiRz0t1kA5bIA/OZs2fsFkIAehvMcDkIlY3NFXR7KxgkJIsXFZxfozonjEdpoeIBNapwovAN051Nch5EcVXniIciAeZzMRtJmfCzttA/tOrSuqzv/na3qynv3sBn+tLvGmmPE2SmRLl5wh+jOFG0ue5GX1nUJhqsI5oRwTlN54dPLjJ418l5Er1PgUl1J85jf1WovSl3XJmxcu0k/zH+6egqqgUcCkVwWrWgFka/bgKtzXGwd2yCNRshYnF5lpEYJ7xYFvCoxJZkPkfB8fEKTu9PCfXDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793875430; c=relaxed/relaxed;
	bh=XIRj/VHtFRarv0lZNWmzV0C1FzshlGUywm6oQSCzwkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o2azvPzrSoFmLmHuF2na4MzVrl+N2HyZVI+U/7VSOA7NlFu9Kqi5uMwza5250YBB/aVXQnW7sJAvVWUX4YOUhw+mvDdndOFp1Knhn3v0PG/LqEWiEoU1V1TwUABuCKwPrTYir9EHF/eKLG87BzApYRNAOn2jUYEsH6U/T1xTRBmk8wtv8Gi0oKl4DQWzU9gJllkv16BMEJ2tCzwOijXZVPB2rw3Z7gsHSjDLyhxHjrwmVBDt8kyv1xswOGxHvdOWd5VgRY2EifOrwbDhMj2bGR7LDIMjSlQ+qjMUp8IZ69RnLJRIIKTnrGXUG79GoWznWTguagiCQ0P7AXsXzD6eqw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aX2Km8DG; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aX2Km8DG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzSQ1NNxz2xSV
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:43:50 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so1990059c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875428; x=1794480228; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIRj/VHtFRarv0lZNWmzV0C1FzshlGUywm6oQSCzwkE=;
        b=aX2Km8DGACHeF0EqsI9sj4u7wxkrZqzd5ASEDZDuWx8bhKtu4iHUaHzVjTKL7vIX9M
         eyICRxBdX+/FKchlKl1Pww40zyOuIIvgFuNXYx9zmtQudtVeJ1E9JdZ/ZBSQnuvfi3mQ
         FnimlUYGe8N2S3IJwrHXTkg7Zr8Krei7W5azFd7N2k5PgM/Elz6xbbPTWjEWbfo/r3m4
         tZG3IQW9POaDCUrX+tUEsL5vWwnmkrSSUVgcIgmmmK5I2Ck1T5oKoRv2/BXZE2OyZiYH
         uvQY2LK832JdA/IwLjJuRJ/cgZY4w3TvhacIeQhfFlo+0ffsVlVbAJSu5B2WzkR4gQFL
         umCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875428; x=1794480228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XIRj/VHtFRarv0lZNWmzV0C1FzshlGUywm6oQSCzwkE=;
        b=ai5H1enpZ+tHaYwA7SyttP5+V8s70o9FF33LmoOBZP+Rqj7YZjvFwcZrs/KsrLroA+
         v0SgKlGtSwaeOaDzmH8wMCqHk0V/rv/PmBUKFAL9DG4+Qvm9Mn3LmGtdOZjFYQ/RwQuG
         370y+TusY4LL3V6Q/P1hDiLeJqZ1t2Fq5wUhK5NijFJfNJ60mMLf+jbrH4nHIeQ8pHJe
         jsSdG4zK03yYYqnWKq0le710hcE9+NWNd3WZItHpH7dj5v4nGV3GMnWuQ9jYMu6MariG
         r3EZQAB7Kju6unS4WBUPQY1WxDytnhLBpbmcPgOn9zZ9KqzZkbEpBeHcDGjHTnBhuoKE
         BTzg==
X-Forwarded-Encrypted: i=1; AKwUvBw0gXptxH8iQN+h5ajbh3xbr0AjyK1/5u5JIXTPQMiim28Y3Ry+oJArjG2mTQwJ/A+jVkK8F4bxJIYqnUg=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z987tE+E68WAQqoez8j7+BbmQCPQSsiNL2rPbevRGTH533wqLqo
	2jR1cjaq9i/pJueQBpU2MK5t/7PjSd1o0cx92JqCdCUPKlWrFkWmqf8H
X-Gm-Gg: AYBFou1Tq8rfaixCeBBUypgQmKXBE++JDxk01E3kzIL+I+ua/hrmjyGqaD7XZh6zZZ6
	2bZNteLo/QtWhvqVSdVBfJOGayghbBvfHrX4dO87zLBhctEebU5O3MwN8vxZJ6esoVTDckdU4yC
	wW5KnfCam9FSkuo//nmRxj1xiUoJOWNRJsKmeTXDPRFUJ/uo1aso2D4TrdQrmazRWaaU9uqkzKj
	mfEn3sX5qPOjWu6RQIdiHLH+mRzTUH4ZOdMF/w8VV7cKj3pAzEzxbsOdn/kUOqM+BxdOjiJQMBe
	x9X55w+6CnPmi7rEpZvmAEHqsCP5dJNt5qRpyleHNdqERPluU0OiDoQJuKwfx4OvN+ZNGvS+cL6
	nx+OjtcHJNJINOHGqd2sL4bnDhqUe7laveuiiObUoyJu7dSDHjZMxJqYtyJF5jJUdisxXw7CvPl
	6ptOBZCmEr5rWZy+EfLeGbe8g7Qr2otKROwmQhEIdq4LlmIJkrQoKmI/2jLY3ymOtCkJv3btGgp
	bufza7tOqIpSpFlm6sNVR4BEehU45STfVHsFgYPUWorzXNWy7j0Tqdn5brcZtZvR2dEKQ3FkFJ2
	SbcgH/KHgReGRYtOYIOymENarpB2qvp+fERBEkSDVVrzhe9dZ9X4zXdI4+/O0WZkEQw68sM1ib3
	e+PASY3dh178OOaVbMALhtcJpj0RBzsrBYpjp3fUaGAswN5zUip2ATWueHEkg8KcUGw==
X-Received: by 2002:a05:701b:42c7:20b0:1b0:f0f5:e38f with SMTP id a92af1059eb24-1b0f0f5e3b5mr20779490c88.34.1793875428330;
        Thu, 05 Nov 2026 02:43:48 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm15595215c88.8.2026.11.05.02.43.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:43:47 -0800 (PST)
From: phucduc.bui@gmail.com
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Shengjiu Wang <shengjiu.wang@nxp.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH v2 07/10] ASoC: fsl_sai: Clarify fsl_sai_dir_is_synced() documentation
Date: Thu,  5 Nov 2026 17:42:34 +0700
Message-ID: <20261105104237.38542-8-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105104237.38542-1-phucduc.bui@gmail.com>
References: <20261105104237.38542-1-phucduc.bui@gmail.com>
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

From: bui duc phuc <phucduc.bui@gmail.com>

The summary line of fsl_sai_dir_is_synced() reads as if @dir follows
the clocks of the opposite stream, while the function returns true
when @dir provides the clocks and the opposite stream is synchronous.

Reword the description to match the behavior and document the return
value. No functional change.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index f75a1d61d7b7..25243b6859d6 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -88,14 +88,16 @@ static const struct snd_kcontrol_new fsl_sai_timestamp_ctrls[] = {
 };
 
 /**
- * fsl_sai_dir_is_synced - Check if stream is synced by the opposite stream
- *
- * SAI supports synchronous mode using bit/frame clocks of either Transmitter's
- * or Receiver's for both streams. This function is used to check if clocks of
- * the stream's are synced by the opposite stream.
- *
+ * fsl_sai_dir_is_synced - Check if the opposite stream is synced to @dir
  * @sai: SAI context
- * @dir: stream direction
+ * @dir: stream direction, TX or RX
+ *
+ * SAI supports synchronous mode, where one direction uses the bit clock and
+ * frame sync of the other. This function checks whether @dir provides the
+ * clocks, i.e. @dir runs in asynchronous mode while the opposite direction
+ * runs in synchronous mode.
+ *
+ * Return: true if the opposite direction uses the clocks of @dir.
  */
 static inline bool fsl_sai_dir_is_synced(struct fsl_sai *sai, int dir)
 {
-- 
2.43.0


