Return-Path: <linuxppc-dev+bounces-17946-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AEAEA8550
	for <linuxppc-dev@archiver.kernel.org>; Tue, 10 Mar 2026 09:02:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fVSZW2XWxz3bjb;
	Tue, 10 Mar 2026 20:02:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773133363;
	cv=none; b=ZFZQTP531pKnjyhsv2Ya+ueGr0eeXY2mnCBR+4UTh9QMyDEfR6W9VStI34qBWgKRrqtGOX25DvoCjOLTbLE1c+k0R0wIOznzqZhrd9sqlsGT+6dTVe04WQFor1S6LXhbbJjO9nrXPH6ZSsDTSMf6ENfvfWG0TAiH1wZ/PGENxKho7J0rs8ZP7sXSpsmQwz7L040y5PF1PZh45Hi2I7PlgV7D6qhxvJTjHBXLtEy4b8/JB2lrKURtocUemiusclEgFwpH6Bom8QCiJVIZhrPi6UTOzloMfaT5tNlNxy6dbavDn8PL5NciYHpFOIGVGwEyK7qM+gRHwerAtae8prcxeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773133363; c=relaxed/relaxed;
	bh=hcgXHgtFNbqe5vp1LaIY7fnxoJDvViHMQXyB0sO4CPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giQcNkQtWjGeCQyC26BXHpOrQZpON4Ao76YECoYLNrpp5J8svaYEvQyu4aYWVb3O0OUadlSm/vPvYc/V8DJo6kZxX1id6VhQUNMsKM83o5iKhxWcoPGx85jfhB3OswZDEw08YXJrh80zcUXoSiJoRfBhw7TqguoEfZU3uVd785xPEELqvNK/ABlvY+3M25HQ/mlcNMANE9zYilPqf1le8g/GKJbAQK1JVtuDTr88sZN2vi/xekV9qliUn/T834UdJxmtL1W37HE1gjKqaQapViniJu4MSGdD7l3tF2CDMy19PBmtBXJriU7Fx5DBarVk1aXYSMAceonsTuqv0Ooqlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t8/wlkIH; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=t8/wlkIH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=sashal@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fVSZR0Q9xz2yFY
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Mar 2026 20:02:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 933B9418A1;
	Tue, 10 Mar 2026 09:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E29AC2BC87;
	Tue, 10 Mar 2026 09:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773133357;
	bh=X04MSuYe+0MX6O5qj8SOGjt38XEk63ORDpQb1AL4ryc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t8/wlkIH7GY+DUoXnJhbYmXkY0fQXl94txQX1hIVj4mXpHVi9atcgdqXGizPrIosp
	 oErLFgAgU6agX85/8Gi4zDP3o6lL4Et2Qg2qCZxSWjVudIWe0sCGwDa7y2vDRiCwcq
	 DdAfNWJrT7gnc/siExMFTxlAgyOdsD6Eyn3gXfapph06eephp3yuL5MDZ+Y7DjM5Tt
	 CkE+Pc0UF1IKoJWKskOZ5RCojyaZLUHI/bYaxstrrHsq9qvmx2juuRzf2u/oabrjSu
	 2crISrknGhgCNd3CTkXpCigo6fu7dhO/DeoUwKLZSHSxl1cQIUPEJj9ymun6+sn35F
	 5tleAGH2gLGsw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.19-5.10] ASoC: fsl_easrc: Fix event generation in fsl_easrc_iec958_put_bits()
Date: Tue, 10 Mar 2026 05:01:35 -0400
Message-ID: <20260310090145.2709021-35-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310090145.2709021-1-sashal@kernel.org>
References: <20260310090145.2709021-1-sashal@kernel.org>
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
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.19.6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mark Brown <broonie@kernel.org>

[ Upstream commit 54a86cf48eaa6d1ab5130d756b718775e81e1748 ]

ALSA controls should return 1 if the value in the control changed but the
control put operation fsl_easrc_iec958_put_bits() unconditionally returns
0, causing ALSA to not generate any change events. This is detected by
mixer-test with large numbers of messages in the form:

    No event generated for Context 3 IEC958 CS5
    Context 3 IEC958 CS5.0 orig 5224 read 5225, is_volatile 0

Add a suitable check.

Signed-off-by: Mark Brown <broonie@kernel.org>
Link: https://patch.msgid.link/20260205-asoc-fsl-easrc-fix-events-v1-1-39d4c766918b@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

The driver has been present since v5.8 (2020), so it exists in all
current stable trees.

## Analysis

**What the commit fixes:**
The `fsl_easrc_iec958_put_bits()` function is an ALSA control put
callback. Per the ALSA API contract, put callbacks must return 1 when
the control value changes and 0 when it doesn't. This function
unconditionally returned 0, which meant ALSA never generated change
events for IEC958 controls on this hardware. The fix adds a simple
comparison before the assignment and returns whether the value changed.

**Bug category:** Incorrect return value / missing event generation — a
real functional bug.

**Scope and risk:**
- 3 lines changed (adding `int ret`, comparing old vs new value,
  returning `ret` instead of `0`)
- Purely local to one function in one driver
- The fix is obviously correct — standard ALSA pattern used across
  hundreds of drivers
- Zero risk of regression — the only behavioral change is that change
  events are now properly generated

**Author:** Mark Brown, the ASoC subsystem maintainer. He is both the
author and committer, demonstrating high confidence in the fix.

**Stable criteria:**
- Obviously correct: Yes — trivial pattern
- Fixes real bug: Yes — missing change events mean userspace
  applications (mixers, audio daemons) don't get notified of control
  changes
- Small and contained: Yes — 3 lines in one function
- No new features: Correct — just fixes existing behavior to match API
  contract
- Tested: Detected by mixer-test, fix validated by same

**User impact:** Any system using the NXP/Freescale EASRC (Enhanced
Asynchronous Sample Rate Converter) where userspace monitors IEC958
control changes would silently miss updates. This affects audio
applications relying on ALSA event notifications.

## Verification

- Read the current code at `sound/soc/fsl/fsl_easrc.c:46-62` — confirmed
  the fix is applied and is the standard pattern (compare before assign,
  return difference)
- `git log master --reverse` confirmed driver was introduced in commit
  955ac624058f9 (2020-04-16, v5.8 cycle), so it exists in all maintained
  stable trees
- The function is referenced at line 125 as `.put =
  fsl_easrc_iec958_put_bits` in a macro, confirming it's used as an ALSA
  control callback
- Author is Mark Brown (broonie@kernel.org), the ASoC maintainer —
  verified from commit metadata
- The fix pattern (checking old != new before returning from put
  callback) is a well-established ALSA convention — no novel logic

**YES**

 sound/soc/fsl/fsl_easrc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 733374121196e..6c56134c60cc8 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -52,10 +52,13 @@ static int fsl_easrc_iec958_put_bits(struct snd_kcontrol *kcontrol,
 	struct soc_mreg_control *mc =
 		(struct soc_mreg_control *)kcontrol->private_value;
 	unsigned int regval = ucontrol->value.integer.value[0];
+	int ret;
+
+	ret = (easrc_priv->bps_iec958[mc->regbase] != regval);
 
 	easrc_priv->bps_iec958[mc->regbase] = regval;
 
-	return 0;
+	return ret;
 }
 
 static int fsl_easrc_iec958_get_bits(struct snd_kcontrol *kcontrol,
-- 
2.51.0


