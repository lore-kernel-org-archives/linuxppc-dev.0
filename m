Return-Path: <SRS0=tcMx=SQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068ADC10F13
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Apr 2019 19:16:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEA220850
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Apr 2019 19:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLg/VDGJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEA220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44j1b92wSnzDqKb
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Apr 2019 05:16:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=andradanciu1997@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="VLg/VDGJ"; 
 dkim-atps=neutral
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44j1YC6dRdzDqJm
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Apr 2019 05:15:11 +1000 (AEST)
Received: by mail-wm1-x329.google.com with SMTP id h18so17407909wml.1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Apr 2019 12:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=/WshFKwVEOSIDmK/jXaqIellNMbewgiCDoskQDtQ9tk=;
 b=VLg/VDGJIgUw2fofdR/TgK4EhPCTTiduiQf83iqMWlGRtI0nuE00H33BTZvFiRNgcT
 ska17eYtWMxAeZ2BXWOeMlnDJBLiJKXIsPeD+DqDG1Qsfkr49FwQDdk8A6ySLg6paemW
 Haxl/Zzmp0jWeZiwjY74kDghz5wwwOKxKFqJLOuRWnvne1CSwdC6xQIp4f5f6vVvDJSm
 5yk+mo2iriyuzMvRVhXieC11h3mzVFVrEo9MnY9pWV6sc4gM0x484joyKhqnyJSIms/e
 +9dV8snSshP/Jr428V5sKrfx85oyFsxV2DK8Q0h09aUkWiu1vvQHf6yddNuatw287qhg
 H+6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=/WshFKwVEOSIDmK/jXaqIellNMbewgiCDoskQDtQ9tk=;
 b=GRZoutUDjniPiLarB8Tiss4E/LPLPSsmWNgvesvbvLIe6OeSeKeKmNJMX4AQNd4iLH
 NCDC4yKtOYt/835Nm/4bHzUOVXEnISRRRzlCWMHafHT8Xxrh0QfWGLuxdilXNe872l4a
 Rlcmw75AhWIlfn/XZ/V9Vnw6TWhhrJb/T4Dt6iCFtMKAngNBooOvaCFWfSWLaQODYLKn
 ZmKmSXzP5XVoqqY4GVgTZhU2S1PWJVTMVd3juGlv1QtdMS7v6tpJvhhXlurr915GXiy0
 8NZnIiw1mWx87HOxJuiMYQQmfcykPHxO1gbSSQdZHCZRAx04k3/WAcEs3uLS7VfmTdDH
 +wiQ==
X-Gm-Message-State: APjAAAWK7FhLgVFgRDShbUzxzpJ/+wez7Zod+C5rjtt/DgUXPmEUJcQb
 8CDep5gxAtG0aA3NYQ2Rz2A=
X-Google-Smtp-Source: APXvYqx+jDH6MmAkrZ+Timy7nHQDcQmWzrUIcxA/WT7cYjMlvS6JDBW9obXqMgmwG5+CKAqcncDVsw==
X-Received: by 2002:a1c:acc8:: with SMTP id v191mr20193317wme.72.1555269307205; 
 Sun, 14 Apr 2019 12:15:07 -0700 (PDT)
Received: from localhost.localdomain (p12.eregie.pub.ro. [141.85.0.112])
 by smtp.gmail.com with ESMTPSA id v16sm96654246wro.48.2019.04.14.12.15.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 14 Apr 2019 12:15:06 -0700 (PDT)
From: Andra Danciu <andradanciu1997@gmail.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, linux-imx@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Fix invalid license IDS
Date: Sun, 14 Apr 2019 22:14:48 +0300
Message-Id: <20190414191450.18377-1-andradanciu1997@gmail.com>
X-Mailer: git-send-email 2.11.0
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
Cc: tglx@linutronix.de, daniel.baluta@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

This series of patches solves two issues reported by Thomas Gleixner

Andra Danciu (2):
  ASoC: mpc5200_dma: Fix invalid license ID
  ASoC: mpc5200_psc_i2s: Fix invalid license ID

 sound/soc/fsl/mpc5200_dma.c     | 2 +-
 sound/soc/fsl/mpc5200_psc_i2s.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.11.0

