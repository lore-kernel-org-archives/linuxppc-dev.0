Return-Path: <SRS0=L8Yn=U2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C85DC4321A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 23:52:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E73520815
	for <linuxppc-dev@archiver.kernel.org>; Thu, 27 Jun 2019 23:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlQMzQja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E73520815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ZcBm20NjzDqjY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 28 Jun 2019 09:52:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::542; helo=mail-pg1-x542.google.com;
 envelope-from=huangfq.daxian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="WlQMzQja"; 
 dkim-atps=neutral
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45ZRxq5XqwzDqdZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Jun 2019 03:40:28 +1000 (AEST)
Received: by mail-pg1-x542.google.com with SMTP id z19so1328907pgl.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2019 10:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=FR72I8Co0+MJGxYGED+5/dqb9dBV7h2vnmoy22KZs5Q=;
 b=WlQMzQjaD6Aa5Vpx6UqUNwQtzaS+/ZnzexxXnYOYG0W1PYAgkbHfE2fYWoFKiBP7Zh
 LEPR/SVzaF7l+Q0m/o+UQebDcRzFIfpgkyImNv/KS4nJvxOsSaAT7aN30UUxwZLvkXsZ
 S9TZz5Czs4+GdrWidNougIDcp9M3vrswqrYypZU7hhTfV/t60PFVpiIsb9HBmx5S6jHd
 XYri7Ee2gAkIhLJZTONReWvn31bZfWiomRHF24DigS8uElaw1RZfJHUfP4/QS8fFGm3R
 OfXHhpgZfeWICB17eszaHC1hpsNgliz4hxuW3YOWDqR0CZKbTCr1WzSwm8Hs3BR1Oq1K
 EqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=FR72I8Co0+MJGxYGED+5/dqb9dBV7h2vnmoy22KZs5Q=;
 b=hDQpdJH0nNm7cS33HgVIRyYSLkdtD7/xEgKBJLVfzDuOiDurSN+qirkOLx/bUA8ZzF
 9VO3adUI+/aApDx8hDwzAd+7GpjgG4blKK0L09kzFPoPvvmXPtCO42zolVkPeosMeprt
 cFR10TzPJyRW1ebFHhv68DKRDss8/pv+AsHZJ0HfhxA2KfotGzJJxb5WDLccmRhMMpYB
 whz6iiklM5+peRw2qpErkPBPklH+oVAkmH+Z/5v1pcnA+RimGp7umzNC1VMViIIOuFIL
 Vbtq6O4KTwrPP+UnFLOVbNwkCYCTpOtmeE5qcczuhH9BQ7bOVte8lALYvGZzIiZNNzJV
 /62A==
X-Gm-Message-State: APjAAAX3pzhlWKKOw2fcZ235uTcyo2uPJNMhFt0nFxI3Hx6BJxL7dkeG
 01/ZRCpF4JnufMLKNHwQi84=
X-Google-Smtp-Source: APXvYqyafuSdTGPVAkCNuqSoaQIqQdl9g85tFTYZqmB4WSXYWLjMlnD3sWyW3Lsdj+lZO711wPLnpQ==
X-Received: by 2002:a17:90a:9f08:: with SMTP id
 n8mr7522337pjp.102.1561657226195; 
 Thu, 27 Jun 2019 10:40:26 -0700 (PDT)
Received: from hfq-skylake.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
 by smtp.googlemail.com with ESMTPSA id o95sm1727758pjb.4.2019.06.27.10.40.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 10:40:25 -0700 (PDT)
From: Fuqian Huang <huangfq.daxian@gmail.com>
To: 
Subject: [PATCH 41/87] sound: ppc: remove memset after dma_alloc_coherent
Date: Fri, 28 Jun 2019 01:40:17 +0800
Message-Id: <20190627174018.4015-1-huangfq.daxian@gmail.com>
X-Mailer: git-send-email 2.11.0
X-Mailman-Approved-At: Fri, 28 Jun 2019 09:50:46 +1000
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Paul Mackerras <paulus@samba.org>,
 Fuqian Huang <huangfq.daxian@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

In commit af7ddd8a627c
("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
dma_alloc_coherent has already zeroed the memory.
So memset is not needed.

Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
---
 sound/ppc/pmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/ppc/pmac.c b/sound/ppc/pmac.c
index 1b11e53f6a62..1ab12f4f8631 100644
--- a/sound/ppc/pmac.c
+++ b/sound/ppc/pmac.c
@@ -56,7 +56,6 @@ static int snd_pmac_dbdma_alloc(struct snd_pmac *chip, struct pmac_dbdma *rec, i
 	if (rec->space == NULL)
 		return -ENOMEM;
 	rec->size = size;
-	memset(rec->space, 0, rsize);
 	rec->cmds = (void __iomem *)DBDMA_ALIGN(rec->space);
 	rec->addr = rec->dma_base + (unsigned long)((char *)rec->cmds - (char *)rec->space);
 
-- 
2.11.0

