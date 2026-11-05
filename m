Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC8606EE9F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2026 10:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xuehxoma
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jKzSX2M9Pz2xSV;
	Thu, 05 Nov 2026 21:43:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::122f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1793875436;
	cv=none; b=g4KWM178jH1tqGCtchAVcH9qXopWvoLsqhwZXGoREq5HW+OaSoIlN/mcv0beqY2+H3lfPzZvr4KOX5mCeEpv3S0nC5BryZeae95+bNFB2QzyBqiues2N2VO/UpFW6S0A/Ptt/tJHJ5UB1y1f/JcRfUkLpo9+JJM21MWfd4qM8XdyFG3EGU2giZUdKq05EjE0YUiqP07uXsPc0vQynLmIvY0DvQjIc4LPlHFcyt4acZE9njqVllDXRFSrJEA/ZuZ3TIccgCBr1zu2zf0MMh10/FFG6cC1oClF84RILScGonrEfGXuO16JvJOV8ESTkXFbqEgaJjZCND7StYRZBLFpuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1793875436; c=relaxed/relaxed;
	bh=vKAKMQ4BVho2fFcjnz3XT6CSg1r7fe1rHI3g3JTlXJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1fR2fNeYCCxAOzlZyeGlbgX+uOladFG3sV9lIJjs74u6aW8mxKedK5E2FEiHfnPSLvemoWWl4MLuKgcRuV52/eMMB4ug1dlX2jepN82vh26OUZAsGgoHt9dqT2w4/lyatgQc/04T2YU21PNxN15/5/5TGcuEQPH2rNH1zlBGWsvshbPAHhwQ3zUbZUoPFurrslXVbM0s8hO8CXC09R7eZRToKCWWj/i+wNQPJgFh1zlcwkQNZYe2lq3oIVPhAQNlROhpEvGQKEN/CaJuFSl757TwBCQGSCyB16OcmNuJMDr2/xkmBYzYsg1S59Pj8LxKusKGNJ/xEBUBFEqORsN6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xuehxoma; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xuehxoma;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::122f; helo=mail-dl1-x122f.google.com; envelope-from=phucduc.bui@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x122f.google.com (mail-dl1-x122f.google.com [IPv6:2607:f8b0:4864:20::122f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jKzSW5Kzjz2yMK
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 21:43:55 +1100 (AEDT)
Received: by mail-dl1-x122f.google.com with SMTP id a92af1059eb24-1a3c08d6928so2497816c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Nov 2026 02:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793875434; x=1794480234; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vKAKMQ4BVho2fFcjnz3XT6CSg1r7fe1rHI3g3JTlXJ4=;
        b=Xuehxomao4g/uFey0ncLWbyubSQRpIwtK/0ui5tuNjRJ6R+yJK9XO36cdqCWALFYXh
         CswY9+Y4ZbBhCcutUVEIihL1W6sS2xwhg8x9UuTkN57NKCYuo38C5gv0lFUztaQwa0xW
         1MUeqLEbUPrB/uzh6dgyK+7T15P4HSiYSj5JfREQap9Y0D2WgxmTJpgUO/DITSVsfwnG
         yK0rGOerOmN4XxqtAmQpDgGgLyk6w9bD6rjKBJbYhQaA9JnqPy934VFf3wRdBhFEHDlY
         pZHfWtu7n6+6wrMGfO0NTePRyt8zzuI4/eOeWcl1Ge4NlzGIaMQ5GZyF8auVL4wtNA1V
         fHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793875434; x=1794480234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vKAKMQ4BVho2fFcjnz3XT6CSg1r7fe1rHI3g3JTlXJ4=;
        b=ta4NYdkWr00gXB5CS0cFH1uNIG0/Y8MkX+rryc1waSBH47otD0zDeMM7T6HGvQpExR
         5a7D/FKHzXLbugDGkD4vCbtPvIgpBdGfU/wsd6jV5wJF0cxvkLTjKNTOsdcClVZruTO6
         bc+LInmn/9ZYuS7ru2sdRs9TGb9Q4kCMXL2q7ro4JGLuJPQFRBCxgs48zUBCtudSTKqn
         8PtDixpNrj3l+VUl0LflqVTqSho4fKGTW3muCNyC2xUu3mb4cpl4cEWsZBixsPvs9J9N
         IzMVgT6CG0fT1wMh6ItddvKx6ylNrYfY+jLMI7k7HerGIsJWSpe2WtoUbS2Fq9wFT0GG
         6T7Q==
X-Forwarded-Encrypted: i=1; AKwUvBxX5vN3WAKuO+cYys8Suq26Md6BnjGVdggJRgHNgMGClNfYfA2tDhh3nQp9VtSWuyhZ9VvcgSxvpmtpPdo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z/0bRe5/NIm9AnykAczXWi4gKONse9lR0Y2j6ltN6F0IySLlq2C
	NeZmoUM4E9ox6+0zKiobs9PsIyyzLKHqcZrUeeEXcXdFMBjP0jEU1tEc
X-Gm-Gg: AYBFou1pZd+byYADPv2b28Z8tyRcDAD8rjh+YavUrn5SEysVbGFGWIMTG9z2Yo0kj7J
	Fv5fE+Ku/LquVUuE1ngEzPTjrJCj30G6E/421zMmTPJKVHQ9EGN7CPxBkYS0YmxTk/vI0uZ5GTI
	PhWaHIcL1tapHwzkSa0Fgb2xg8Kf9FNS3VyiThe70hD7z9HZUkPpisHhlCHA3iwg+fzqeLFZXnU
	14yY9tmH9GFf991SqXNWye0h/m2DtGfOqJnUXCDamwjANYxww7EMsxyGpCx5W4XqaRSK1G+FrMT
	Tl+zmrlF5VAgTRKfK5tQChi6VEsVZHabCWI1EmlmM50RK/e8pt07V5q3a0sbwTGCTL3ON5cck8b
	yuvgIbgPhLk9zlrBq9n+iRUDnT9KgXjCZVM/8Cy2uLIBginPz7ijD+/5gChaQ39qF8JOMaTLrPs
	dAhmiwPWy7BZTMpzB3Di+VqJ0CVfo3QHfn2X/gUv3xhpZXxsZZfSUZfpW1kYEln3+U7QNIblMlk
	K82dK5KzusWlOvLPpRyXYUdb09gp5UPGV/akQ2AF/5UL+aA8uOKYOlfKHyjEq1d27iT1MSRLGpL
	t+X8fGJfmOWJdU1f9V/vG1wz6k7TJNzIxnTVIQaiORCMWUTQ3HQxSxR8ky2oNECL//Im+gtuE81
	V5o4Nemy+a6Z2l67dLTzQvUCUQeHzkvmgVzFNK8w5wN3q0meA9IVTcSODbvWBzwG6TA==
X-Received: by 2002:a05:7022:b0c4:b0:144:fb87:5b91 with SMTP id a92af1059eb24-1ac5e32099dmr27470535c88.44.1793875433623;
        Thu, 05 Nov 2026 02:43:53 -0800 (PST)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c1c272sm15595215c88.8.2026.11.05.02.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 02:43:53 -0800 (PST)
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
Subject: [PATCH v2 08/10] ASoC: fsl_sai: Check regmap_read() return value in ISR
Date: Thu,  5 Nov 2026 17:42:35 +0700
Message-ID: <20261105104237.38542-9-phucduc.bui@gmail.com>
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

The IRQ is shared, so fsl_sai_isr() may run while the SAI is runtime
suspended. The regmap is then in cache-only mode, so regmap_read()
fails and xcsr is used uninitialized.

Check the return value of regmap_read() for both TCSR and RCSR, and
skip the handling of the corresponding direction on failure.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 sound/soc/fsl/fsl_sai.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 25243b6859d6..5c50ed7c2258 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -148,7 +148,8 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 	mask = (FSL_SAI_FLAGS >> FSL_SAI_CSR_xIE_SHIFT) << FSL_SAI_CSR_xF_SHIFT;
 
 	/* Tx IRQ */
-	regmap_read(sai->regmap, FSL_SAI_TCSR(ofs), &xcsr);
+	if (regmap_read(sai->regmap, FSL_SAI_TCSR(ofs), &xcsr))
+		return IRQ_NONE;
 	flags = xcsr & mask;
 
 	if (flags)
@@ -179,7 +180,8 @@ static irqreturn_t fsl_sai_isr(int irq, void *devid)
 
 irq_rx:
 	/* Rx IRQ */
-	regmap_read(sai->regmap, FSL_SAI_RCSR(ofs), &xcsr);
+	if (regmap_read(sai->regmap, FSL_SAI_RCSR(ofs), &xcsr))
+		goto out;
 	flags = xcsr & mask;
 
 	if (flags)
-- 
2.43.0


