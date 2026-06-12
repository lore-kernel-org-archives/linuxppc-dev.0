Return-Path: <linuxppc-dev+bounces-22562-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855CBCD8CA8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 12 Jun 2026 14:49:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gcMpl1zdTz3bsM;
	Sat, 13 Jun 2026 00:49:03 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1336"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781270831;
	cv=none; b=oTCldclm3HRFEu2d73VQZHRGTKHOqJylgXsqrrHMFxUL1kFh+PMdEROGO8G/2EmsPsuh7FSfCSMahHOD8CvNGtK72fjkMFQSxXAgHRpD39WloqSv2fqQ8rfsc/eRWjMBYm7WLrd+ABRReVZ9XmwTSxn6Htbo4Cwdo4JrxmH3Y3cxIHP1Ub5NBxNPtvikOtKpWJVPz4d8Pwavg900OH8NAc52hN6XruXojbPHkaH2ES3658N4HwMTqozix/uY9w/Oe++ajLCZlEYhRtJWD8TbgIkk33Z+pTR2pM4XtsOAfAcfF/2aHohQh1t8j+maLlVDUWfDkuMTE5uufKnj5X4DSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781270831; c=relaxed/relaxed;
	bh=6XAdGAHmWyaxfC0CIkFTqcFEJz2zy9rtxVk5mFpwGBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qtj7C0y2OcVTzB/97CqLun8AWy5gdN8PB8lEnqiGdAI3CKGLZ6+JhetVAAQeT2h4UABxMCFkFO9MLY/40GYjsh16XYIiNq4siy4B9sqWfqzD8vvInWaT+YEqwibkGgLUHj9Pvzq5Q076h2QdFyWC4ny7nT8ZQrvtuwdVeAiPijsc8mI7gDyJ+D0swWkNPJQ2kq/OAsiSfWn++q4JSqCKaz3NVmL1IgTIu+GmHn4os3xTGRD59n7NyUcLSO90WWmAn1kPqdPinlY9y9dQ8bP1WjfdINVD7YbdQLeN6s0E3Q1uXswDi596i8PmcZXWH56P1jB+MMgjrsDYnbFBgTnWxg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oJE/OkC1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oJE/OkC1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1336; helo=mail-dy1-x1336.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dy1-x1336.google.com (mail-dy1-x1336.google.com [IPv6:2607:f8b0:4864:20::1336])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gcL0H1bHLz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 23:27:11 +1000 (AEST)
Received: by mail-dy1-x1336.google.com with SMTP id 5a478bee46e88-304d0ac5e3cso2071411eec.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2026 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781270829; x=1781875629; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6XAdGAHmWyaxfC0CIkFTqcFEJz2zy9rtxVk5mFpwGBY=;
        b=oJE/OkC1EXWOGusoiUOuwuXliKylUkGQEFDqaJ6C2SuCv6df85kmce+eboRMSdQpHi
         Iqg4L+OPrvGGu3aIbBIGuO/2+p8tZLtFnH+ZfxLRyvrD1vsFKGr0C8fnDdPEDmDgidys
         SZ5ay2KowEXyAel3fu0qwxItsSeyVJk466xfiAruaAeDJRxUOfTZi5PLa4sOXO5+Tntz
         VCEaRipSpRCcEquolxGhXjLz0v2zx/qD3/MeXs7/CGzV5tHPDHOX5wkdjB2cwshDLIhc
         xydyzWWbARtKO1vZq2ait49u6n1niqKz+Uz9HLOv76vD8ex1QPHFDP7IUq41Vt+3aNPn
         HDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781270829; x=1781875629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6XAdGAHmWyaxfC0CIkFTqcFEJz2zy9rtxVk5mFpwGBY=;
        b=IZSkZ/AZX0YYS21cdAtQFavOAG2kr6muslWTyLP5EPpFQU6ORza2CaNwmTdBrtbqlA
         eWjLFNe+JqbQ75wDW8KvDy96glv477EI75+NBqDa3s5UgeoUKYuDB0c3w3Oq3UulVOAm
         plJJ3GojR1z0b4ue3I1HQjYV6kEVxGKbzLVvMIfcOrjkYWT1FRfRfO54Un4pBTFc8h8D
         plw9HakKA0JXDgbq0/bUvpJAZwKgIjgbKj8t5b003U2VYXx1fd70MhfvKb8bEWf4nEM1
         POsHCm65maCB+zEwiM6cKz5Xsm6MPu7zNDjvCE6WUSU6HoaPtfU60+/J2fXPJcz+ItQ3
         Hycw==
X-Forwarded-Encrypted: i=1; AFNElJ8iMZo8aEeJT1YPizZKgcYdQsNnnECutv2SkVf6TqbBnS7iFYuu43aF7CJ/FDu2yPGoRUB2ZVdfpnHh9aM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YysjfuFGdID5hTdPSGb/N5csHQR2wnD/PwtVbhdmI1e9n7huJNV
	w9cXapkSLeikw49V5b5DyLLsP/Q84Jvrz/Bzde/aZCpaqHs9bxWZ5zFt
X-Gm-Gg: Acq92OFkSREt7LgWfqLfRCdRII4ge9qCAkAJBJ6/j51bjAK9hzhGv0eXKEAbdxdLLlA
	eyQPfQ7IAFeyCeuuzkHBmFYq9uLyiTXJRRiDlxQRbThJROpmzFkxyNnQHmtU/GqzO3egGqbP4wt
	qprDbCBkTq1C1/wbxxGl24WifX9OpN9qSPjyeWF5cbkUWACBrgJEcpG9k7Ec2udRvp9wI5nmM62
	BYkExYWsJN3Eu18OSLRn0dXSzVF/K0b5luXeslZ//0iAycoBzyjUjFm6WbZJ9vSmDJZ7qiDFm3/
	k45XZepe6zgnz+b9AKnpT0GQJaprVKWHmoz7qzCOiGikZzw3XsTfjnGy4V2e1LS5Mn/Kbtv9iRY
	TirbEaDqooez0o2yTUCF9FITCJNQoW+xOw3prMruXD+z9Ufld175MHmoj2KCCJQY4q7preHw1fC
	x8uwFdastla1mUdPufuI7S59xfUgnBrKi6RyNTyxpHW9MykrxMvyufD3CNaQ==
X-Received: by 2002:a05:7301:fa0b:b0:304:2176:a871 with SMTP id 5a478bee46e88-3081fcdd9f9mr1776040eec.0.1781270829171;
        Fri, 12 Jun 2026 06:27:09 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081e91f8b5sm3302343eec.19.2026.06.12.06.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:27:08 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 02/11] ASoC: fsl_audmix: Use guard() for spin locks
Date: Fri, 12 Jun 2026 20:26:30 +0700
Message-ID: <20260612132639.78086-3-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612132639.78086-1-phucduc.bui@gmail.com>
References: <20260612132639.78086-1-phucduc.bui@gmail.com>
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

From: bui duc phuc <phucduc.bui@gmail.com>

Clean up the code using guard() for spin locks.
Merely code refactoring, and no behavior change.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_audmix.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_audmix.c b/sound/soc/fsl/fsl_audmix.c
index 40a3b7432174..066239c64037 100644
--- a/sound/soc/fsl/fsl_audmix.c
+++ b/sound/soc/fsl/fsl_audmix.c
@@ -280,7 +280,6 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 				  struct snd_soc_dai *dai)
 {
 	struct fsl_audmix *priv = snd_soc_dai_get_drvdata(dai);
-	unsigned long lock_flags;
 
 	/* Capture stream shall not be handled */
 	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
@@ -290,16 +289,14 @@ static int fsl_audmix_dai_trigger(struct snd_pcm_substream *substream, int cmd,
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		spin_lock_irqsave(&priv->lock, lock_flags);
-		priv->tdms |= BIT(dai->driver->id);
-		spin_unlock_irqrestore(&priv->lock, lock_flags);
+		scoped_guard(spinlock_irqsave, &priv->lock)
+			priv->tdms |= BIT(dai->driver->id);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		spin_lock_irqsave(&priv->lock, lock_flags);
-		priv->tdms &= ~BIT(dai->driver->id);
-		spin_unlock_irqrestore(&priv->lock, lock_flags);
+		scoped_guard(spinlock_irqsave, &priv->lock)
+			priv->tdms &= ~BIT(dai->driver->id);
 		break;
 	default:
 		return -EINVAL;
-- 
2.43.0


