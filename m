Return-Path: <linuxppc-dev+bounces-18281-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4AFFB5E90
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Mar 2026 00:09:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZXPR0lLKz2ygl;
	Tue, 17 Mar 2026 11:08:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773684350;
	cv=none; b=kWjoFTJTeoXmkuSTGyZcMf64tA5PAdZuguJNxI2GsulnCQEcg/ev+2bk+3kN+50MVq17byaqIg8JGdHPorWDJ8AbkutZOndHJDKGtss1WhEI8cx4YoLwieZ2v4ZpjXzyrrDjURvYsBY9oR9EmfvREb2kiH2eo4XwVHrIlIQddLvqfIXL4+sQkUCRAX/Q8GeZhfFOgxsdCH3Fvxrmzpwgqk9yg4n3lDs+dVLkKCsXrU+Lvg2A7JFaYet6v5PbmNASR6m9U6S8zCSAy2L6BOXaM9/7oPxy0I2fGOx+X+Gmjp2VcT6TO4uev5Atx+hnRgKhJ5Yr9Pxm8DbyOcWyuwmeQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773684350; c=relaxed/relaxed;
	bh=tp/BF1K5uh5JTZA4//d2Z+RL7wdZQyPsqQ/JPGUIUyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyCoKql2OKOoMPI7q2R9/RJ0FOa6+LNc2vdM7l1+4MX0ZiH6GzBz78at9VHX0R0qEh62kbYg7XD0P9hhnstlurw5+Y70sTezgeygTOB+lBKN8wIwl8MJSYlUzJxznQmez1xxu6NfGTama3EEwircuMp2ENkrg5VTnv58XWsbFIIsfMHpp8CgI94Xd937Iy6xORc2PV+KRBDcJwXBx2ZQWhQ1qOba1F7/+2Ti1Nf9hiSG67WL6HrrhfnbXWavCndjWBUpUF0MoTwLAtehEU13dCfgl0pp0UtN8VrhtLKJM5CQw5SFIRNxlObDkgdTqQAHAd8rU3aW9lX9fb3zszBlCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=reject dis=none) header.from=oracle.com; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=rfr8=bq=oracle.com=joseph.salisbury@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=reject dis=none) header.from=oracle.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=srs0=rfr8=bq=oracle.com=joseph.salisbury@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZNLQ0jkGz2yZc
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2026 05:05:50 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F0B9660123;
	Mon, 16 Mar 2026 18:05:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8577DC19421;
	Mon, 16 Mar 2026 18:05:46 +0000 (UTC)
From: Joseph Salisbury <joseph.salisbury@oracle.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: fsl_easrc: fix comment typo
Date: Mon, 16 Mar 2026 14:05:45 -0400
Message-ID: <20260316180545.144032-1-joseph.salisbury@oracle.com>
X-Mailer: git-send-email 2.47.3
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

The file contains a spelling error in a source comment (funciton).

Typos in comments reduce readability and make text searches less reliable
for developers and maintainers.

Replace 'funciton' with 'function' in the affected comment. This is a
comment-only cleanup and does not change behavior.

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Joseph Salisbury <joseph.salisbury@oracle.com>
---
 sound/soc/fsl/fsl_easrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 6c56134c60cc..599e439b359a 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1286,7 +1286,7 @@ static int fsl_easrc_request_context(int channels, struct fsl_asrc_pair *ctx)
 /*
  * Release the context
  *
- * This funciton is mainly doing the revert thing in request context
+ * This function is mainly doing the revert thing in request context
  */
 static void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
 {
-- 
2.47.3


