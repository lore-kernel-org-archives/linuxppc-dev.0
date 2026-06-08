Return-Path: <linuxppc-dev+bounces-22198-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F48CD8C9F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 13:39:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYtSk6vL2z3bqh;
	Mon, 08 Jun 2026 23:39:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780925990;
	cv=none; b=Sp4IQCOuL1b/xUe657pqd/TZNck5kdJazn7SFUjtLVWtGqPEIev+HNmkx9iUHpcwQiSoSNZEiqZBriVb+M9d14Ht3qEusz+r5xnCynDe1To2G1nuSdHgeZ5qroM7NQtv9JeCdMhWP6uEb+entQhJ9XtTJPoiA4WgWY0X75qlbrU8P+pb0dWO6idGWLz/6CavcyqSvqUZx0qES05ylmAW4fvmZXdEyXzcWTA8/YYenuj0EcgF3NkASbGS2UOc2AxjQukmuYnTZGB1oaOrRyOaayWAr4iLIdvfr2s4hOry7d+0kgYQH6w6HralWa4Wy6aFw0LjEXp3gLvcfLMbb5hpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780925990; c=relaxed/relaxed;
	bh=YBhrbnQZkkDV1+28VAJe073K28r+xjYcWQgKCYCLNoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dC1xROLAHEWJ8wrqeq/l+WYcVAnlY7RGEv8fHu+21loNN6a0DcuWfJzsVCraeq2B9eCU+t3yqiAzShUtQ0neiVKb08UuD8oIS1l1+fL/97azvn/5bdIU4AKumQyDIF6twZcVtR6CzKUwLYvkYMgxAAT6HGugxzjb94BjiSNd3R87qXQNM72PabpkoXlTJQuaFqyEDKTFadvbLTf6lYJe+fv684r/lbqGfJ7i819jOxa9B2+IQl290KBM7hWUWUXUyUK5urAV3JhOKaSKg2WFP/lDxPT/i4wDodCiyylgGe1UFNxHh02H2qsH/o+Z8lhaWUJBazYvAPSrs/PW52SzFQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B/VbGz+O; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B/VbGz+O;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122c; helo=mail-dl1-x122c.google.com; envelope-from=cassiogabrielcontato@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122c.google.com (mail-dl1-x122c.google.com [IPv6:2607:f8b0:4864:20::122c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gYtSk1q3pz2yQH
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 23:39:50 +1000 (AEST)
Received: by mail-dl1-x122c.google.com with SMTP id a92af1059eb24-137dd523634so6721133c88.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 08 Jun 2026 06:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780925988; x=1781530788; darn=lists.ozlabs.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YBhrbnQZkkDV1+28VAJe073K28r+xjYcWQgKCYCLNoY=;
        b=B/VbGz+O23Xy1kvh2XnTY3EBdzymRByP+hEQjdL/T4Hkd6goaQOtOKdeMz+5MLgxE+
         dKIMMH7/ZTxSTxUsw374JEz+mc/+Io+RA3WP1Lm7Ypiyp7wt0ytCzZ+dfX1qb4QeJkp8
         u6Uhyk1FxKtkE/T0RFl4AA0VkUxjiEElhmbeP4lyT1/95b8MsnTws9BEEweNd2IM5rdu
         sQw0RuT5/qJurquaTj7rAytpfcpb6aIsTO3Yx2a8y86Peu+EcaXPGhgUuGwt+Uu14Aej
         UXZ4l8AgcUTa797KfUwwFCzWPFi6bS6DLxmzWSHG8PHiXXc6C1a5fcjlbaH0xZAT7R7f
         k1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780925988; x=1781530788;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YBhrbnQZkkDV1+28VAJe073K28r+xjYcWQgKCYCLNoY=;
        b=ryvDQ6cQvYu79O3D5sEbEAwZqm09h/XU3C3tLejkA0mC7s7Pp6FI0rdvuEzfjwhYJo
         piXqQ2jVmtbb+piOV+CrsKkkuQKwBhYtSB1wE+/39gwZ855GFABy9KYONgIQtrJUTgzO
         0KQYUIspejsNQa1SJONE9KcaUrwRznbsDPWXujQOJIKy0g8KSTVBpIx2cGZNBi7MeOJl
         9T8yfoZVX90oTWvlZvlmKTp3IZez4NLn7QMxi4hpigWX5zYaxCnauS6QzNMqvIou6LAm
         dMRvqFfyfSNvxfV43zYlLJj6r/7QnP4HjsX7xYyUS04QEN70Gn3A4O3mi72JmiEV9egH
         6NRQ==
X-Forwarded-Encrypted: i=1; AFNElJ/lMoOVBBSU2xCTr9bVRva7phuGom4rvNrFDKqfdBcwy5ustNh7+YLX/wt31qfXP1yk5ytsKD7yyIRRhjQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxJm3weDShN2rD9gT9NEOfjFD/YFSkX4aZRk9oudVR71+IkwmDL
	ejPhBrnoavitluIBiO3BEZsg1jGzHxnZJd3E6b8sXgrAOidalG08/4Oc
X-Gm-Gg: Acq92OG/eQP1N/ImEX4Z197reUPSay7P9soPiSxMBonZP1iCYq/rR4QeTVp5MomfgZu
	WBSDtrhRSFHsrpQQ1/SUqnJrrvKE3zV8Vq9GN0vpYdRpC+nKdTt6C45ymnBMgq8Tkr7JrDzUiJ2
	ZEqSUCkXMeqhXLxC20yC/ipZ8CxQFQZ3h8jb6Yzn+m2AS6Y9E+d4STLkqyywZUcBby/YWuGZ2KA
	RdF/094wfv0gPY6FfVhxVeAqcSVMqbgXdwaEhIlg+2zTk+/ywlcojJ7817Wd074o1Y90ch7liz4
	K9nOhBK6pjavz/jJxVIwO2m36wFoaNMXe4Ms+ayKw6pOZTV9DqjgNvaRvDKXVdTOJAVvoRRhjcC
	2cpnQnWm+TNLRWFSEN4Evs4jWzPtQSOaA7pAkQZMawxQyFuic5b3MU+GFdHHZJu7FucH9WKskOd
	gs0fapK+tjrbA/cDWI9iR1SEw34DpCsEtm6wZdV4fiz4aK+JWTtL7KgRf1Oq44erV8VsXMVaz1x
	7s8oJxLcixkNTcAqQNw0bM=
X-Received: by 2002:a05:7300:230b:b0:304:2eb0:2726 with SMTP id 5a478bee46e88-3077b22df0fmr7429361eec.25.1780925987987;
        Mon, 08 Jun 2026 06:39:47 -0700 (PDT)
Received: from [192.168.1.18] (177-4-161-23.user3p.v-tal.net.br. [177.4.161.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm23893449eec.5.2026.06.08.06.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:39:47 -0700 (PDT)
From: =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
Date: Mon, 08 Jun 2026 10:39:11 -0300
Subject: [PATCH 1/3] ASoC: qcom: common: use scoped OF node handling
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260608-asoc-of-node-scoped-cleanup-v1-1-9e3ac518dc2e@gmail.com>
References: <20260608-asoc-of-node-scoped-cleanup-v1-0-9e3ac518dc2e@gmail.com>
In-Reply-To: <20260608-asoc-of-node-scoped-cleanup-v1-0-9e3ac518dc2e@gmail.com>
To: Srinivas Kandagatla <srini@kernel.org>, Mark Brown <broonie@kernel.org>, 
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Herve Codina <herve.codina@bootlin.com>, 
 Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, 
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@lists.infradead.org, notify@kernel.org, 
 =?utf-8?q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4019;
 i=cassiogabrielcontato@gmail.com; h=from:subject:message-id;
 bh=Fku3y1CGF4nhcunbUPtMiClanJb89VvqUuwkh2+knqc=;
 b=owGbwMvMwCV2IdZeKur/u2bG02pJDFlqxySsmP6Uc+po3Tn/8kP/s2fH8w/HHkoXC4xxXeCRb
 /CAZ39pRykLgxgXg6yYIsvqpEWWe7oeXK2PW+EBM4eVCWQIAxenAEzk1y+GPxwrOKKqzBacSJxt
 9/tcgR5Dgp68lparbeMO/TVCrQstljMynC35KmN89b1HxdbVHh9ufDaRTzlueZRld/yU+ZP/P/X
 ewwAA
X-Developer-Key: i=cassiogabrielcontato@gmail.com; a=openpgp;
 fpr=AB62A239BC8AE0D57F5EA848D05D3F1A5AFFEE83

qcom_snd_parse_of() manually drops the link child node and the
cpu/platform/codec child nodes on error paths and at the end of each
iteration.

Use for_each_available_child_of_node_scoped() for the link node and
__free(device_node) for the named child nodes. This keeps the existing
ownership rules for DAI component phandle references, while removing the
manual cleanup labels from a path that has previously needed OF refcount
fixes.

Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
---
 sound/soc/qcom/common.c | 47 +++++++++++++++--------------------------------
 1 file changed, 15 insertions(+), 32 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index cf1f3a767cee..edc4611691f7 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -25,10 +25,6 @@ static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
 
 int qcom_snd_parse_of(struct snd_soc_card *card)
 {
-	struct device_node *np;
-	struct device_node *codec = NULL;
-	struct device_node *platform = NULL;
-	struct device_node *cpu = NULL;
 	struct device *dev = card->dev;
 	struct snd_soc_dai_link *link;
 	struct of_phandle_args args;
@@ -82,12 +78,10 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	card->num_links = num_links;
 	link = card->dai_link;
 
-	for_each_available_child_of_node(dev->of_node, np) {
+	for_each_available_child_of_node_scoped(dev->of_node, np) {
 		dlc = devm_kcalloc(dev, 2, sizeof(*dlc), GFP_KERNEL);
-		if (!dlc) {
-			ret = -ENOMEM;
-			goto err_put_np;
-		}
+		if (!dlc)
+			return -ENOMEM;
 
 		link->cpus	= &dlc[0];
 		link->platforms	= &dlc[1];
@@ -98,32 +92,33 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 		ret = of_property_read_string(np, "link-name", &link->name);
 		if (ret) {
 			dev_err(card->dev, "error getting codec dai_link name\n");
-			goto err_put_np;
+			return ret;
 		}
 
-		cpu = of_get_child_by_name(np, "cpu");
-		platform = of_get_child_by_name(np, "platform");
-		codec = of_get_child_by_name(np, "codec");
+		struct device_node *cpu __free(device_node) =
+			of_get_child_by_name(np, "cpu");
+		struct device_node *platform __free(device_node) =
+			of_get_child_by_name(np, "platform");
+		struct device_node *codec __free(device_node) =
+			of_get_child_by_name(np, "codec");
 
 		if (!cpu) {
 			dev_err(dev, "%s: Can't find cpu DT node\n", link->name);
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 
 		ret = snd_soc_of_get_dlc(cpu, &args, link->cpus, 0);
 		if (ret) {
 			dev_err_probe(card->dev, ret,
 				      "%s: error getting cpu dai name\n", link->name);
-			goto err;
+			return ret;
 		}
 
 		link->id = args.args[0];
 
 		if (link->id >= LPASS_MAX_PORT) {
 			dev_err(dev, "%s: Invalid cpu dai id %d\n", link->name, link->id);
-			ret = -EINVAL;
-			goto err;
+			return -EINVAL;
 		}
 
 		if (platform) {
@@ -132,8 +127,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 					0);
 			if (!link->platforms->of_node) {
 				dev_err(card->dev, "%s: platform dai not found\n", link->name);
-				ret = -EINVAL;
-				goto err;
+				return -EINVAL;
 			}
 		} else {
 			link->platforms->of_node = link->cpus->of_node;
@@ -144,7 +138,7 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			if (ret < 0) {
 				dev_err_probe(card->dev, ret,
 					      "%s: codec dai not found\n", link->name);
-				goto err;
+				return ret;
 			}
 
 			if (platform) {
@@ -167,10 +161,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 
 		link->stream_name = link->name;
 		link++;
-
-		of_node_put(cpu);
-		of_node_put(codec);
-		of_node_put(platform);
 	}
 
 	if (!card->dapm_widgets) {
@@ -179,13 +169,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 	}
 
 	return 0;
-err:
-	of_node_put(cpu);
-	of_node_put(codec);
-	of_node_put(platform);
-err_put_np:
-	of_node_put(np);
-	return ret;
 }
 EXPORT_SYMBOL_GPL(qcom_snd_parse_of);
 

-- 
2.54.0


