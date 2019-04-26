Return-Path: <SRS0=ImKy=S4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A416C43219
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 03:23:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D380B206DD
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 03:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udHN4jJB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D380B206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44qzs74GgJzDqfr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Apr 2019 13:23:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::644; helo=mail-pl1-x644.google.com;
 envelope-from=nicoleotsuka@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="udHN4jJB"; 
 dkim-atps=neutral
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com
 [IPv6:2607:f8b0:4864:20::644])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44qzqY0xV6zDqdS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Apr 2019 13:21:44 +1000 (AEST)
Received: by mail-pl1-x644.google.com with SMTP id x15so803700pln.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2019 20:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=2J1TjtOstEzmWtLspAyMVLNIkrOKT0VPlYnQGIz+uw4=;
 b=udHN4jJBs3pXVk16n237GoSyhZGfP8O8KDAYlJyn4iJED7j9WSbV+1zmUqg+jJlnPi
 PRaIOEU5kug5BbH13YwAGbsS2eW5bb/UWaLkxMfFSh/PJiqL/zfzfr0gP5lHldBZM9kW
 p0IWOJd0KbKCXZ3MZiPvhhzXuruHmlyD+Y/lRGzNHPsFYn9qCtzdsnDDpDBB7DqIPxY+
 xWOskoDNaoJk+9eAvzZlKFT+HJzemNiwDrvnNLA3vgywC2bhI+TwS7tCSjYOQJa1iqIG
 13gNkOgz40bdUJwCXQ2vNR9VbrwpaQRK4ELcUgWfjqUmPuiSI4l9lVLzw6i83KmAqR3H
 8edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2J1TjtOstEzmWtLspAyMVLNIkrOKT0VPlYnQGIz+uw4=;
 b=msbyChaohOGLA7mYt4vZGgIs+ut3aThwqOpJyTq308IIZ8BstY/QCeDBNMH+ZAdxQ5
 aoIJlYOWVBPy48Jg3Dx+kj4baraIbxLtwOVR7ZKuAr/I9DtMYARB2je55DRoP6Kxjn54
 IYFppDuSfTm6EnNKk1WtnPgiYcSTtIo+H+RyemXM0QBI8JPp61aXkjKRWyeKYCwgnNHl
 4IWuPFBqq0l1izYg7VabvTEdHvZU+YnhwxFHNoBnzwkkQAoivfVLvTDEJ3RHI5uAP9Pe
 ZoNK2QSWgVDJIPPSn+P8r5jSsyzZuoBuKWClsRTEau/5WptZxHKAeWEQpy6tvdgaC38m
 Rt2g==
X-Gm-Message-State: APjAAAUNqxYuNU6S4acTeRjnwszDqZvNlRTebCIkrgz4unIrgmc2Oddf
 h/1aAvtjguDndjQQWlgVJCk=
X-Google-Smtp-Source: APXvYqzmideczOWmwDVE6IZEwTpFCEMCSkYkYC177nGVkAFFTgTtQJGsO4LuFeTWfsNBVvH589AZsg==
X-Received: by 2002:a17:902:b605:: with SMTP id
 b5mr5024608pls.206.1556248900457; 
 Thu, 25 Apr 2019 20:21:40 -0700 (PDT)
Received: from Asurada-CZ80.localdomain (c-98-248-47-108.hsd1.ca.comcast.net.
 [98.248.47.108])
 by smtp.gmail.com with ESMTPSA id 10sm64985956pft.100.2019.04.25.20.21.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 25 Apr 2019 20:21:39 -0700 (PDT)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org
Subject: [PATCH] ASoC: fsl_sai: Add missing return 0 in remove()
Date: Thu, 25 Apr 2019 20:20:50 -0700
Message-Id: <1556248850-3748-1-git-send-email-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.7.4
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
Cc: daniel.baluta@nxp.com, sfr@canb.auug.org.au, alsa-devel@alsa-project.org,
 timur@kernel.org, lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Xiubo.Lee@gmail.com, tiwai@suse.com, perex@perex.cz, festevam@gmail.com,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Build warning being reported:
    sound/soc/fsl/fsl_sai.c: In function 'fsl_sai_remove':
    sound/soc/fsl/fsl_sai.c:921:1: warning: no return statement in
    function returning non-void [-Wreturn-type]

So this patch just adds a "return 0" to fix it.

Fixes: 812ad463e089 ("ASoC: fsl_sai: Add support for runtime pm")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 26c27dc..8593269 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -918,6 +918,8 @@ static int fsl_sai_probe(struct platform_device *pdev)
 static int fsl_sai_remove(struct platform_device *pdev)
 {
 	pm_runtime_disable(&pdev->dev);
+
+	return 0;
 }
 
 static const struct of_device_id fsl_sai_ids[] = {
-- 
2.7.4

