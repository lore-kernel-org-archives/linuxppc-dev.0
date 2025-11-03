Return-Path: <linuxppc-dev+bounces-13689-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BC7CCF9F8
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Nov 2025 07:06:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4d0N1Y40rDz306d;
	Mon,  3 Nov 2025 18:06:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.12.242.22
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1762153617;
	cv=none; b=I7O8SKM0AtdM4WfRNECeqQsD0HuCgGnFqpgqqj7qTlL0vRDzkhIabvcl3+YYprmhM48HX/r6SdL4DGw6Yb7y4VtMf43GtFwLmyILos9/5mdjCQ12+cUxTD1yWcniOE0xR7jLS7ekMQlHGo7VbMB29qu8uXGLoX8CckGoZ8yWA326NtU1W+LIbRAjRn4njnIGGhhajExDE5OlLRsJkrwH83dQd8tq3/sk2PpIF3USl9GQ7KeIgcxPQX5ZDqbVdoxS1G/3HUc0VORtUZ3hj/NjbZElbO2qRnSywL6+psixbMo5pyGMco8q+9od9VgXTTxZV/FdCsYHhc+/J5w3jvdAsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1762153617; c=relaxed/relaxed;
	bh=AXuQEY3AagyS51O+lVG4zaIuniqmVZG13dgoQRqEHxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhQpsHXEVQ21h4Hq33eHVQJhx90xDygVLeQzGwWVI3wyRTYze2KrUzFnjrpDzDwKvsH++93KtrwXl0b1/MSHoPa1IiB8Jq5tzCOknxFVvMITnZqIzb8qIiTUv7sH3GKRIhhxUV48p1txvabbkt9qhDtxig4QOYsdf2AJmQslQ4txF8svZCQSXNxgn8dV4sNvx9XXDpOnG1u6FwIcg8kmAhxx9E835nRkhNXFEoEVlvaIrNAf2EKDfhotMPGDO0V1jljI64HPjoYB+ZCIKj5egHo+xYlz2R6kgrxZ2GYMn5rdEUJCADXlrmNUhbhZoWJtOmJvB3WpcU3DLHxfvO9VSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=lLTFZU36; dkim-atps=neutral; spf=pass (client-ip=80.12.242.22; helo=smtp.smtpout.orange.fr; envelope-from=christophe.jaillet@wanadoo.fr; receiver=lists.ozlabs.org) smtp.mailfrom=wanadoo.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=lLTFZU36;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wanadoo.fr (client-ip=80.12.242.22; helo=smtp.smtpout.orange.fr; envelope-from=christophe.jaillet@wanadoo.fr; receiver=lists.ozlabs.org)
X-Greylist: delayed 2015 seconds by postgrey-1.37 at boromir; Mon, 03 Nov 2025 18:06:53 AEDT
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4d0N1T4ZgKz2xR4
	for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Nov 2025 18:06:52 +1100 (AEDT)
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id Fo6ovtBvMsL0VFo6pvhfqx; Mon, 03 Nov 2025 07:32:08 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1762151528;
	bh=AXuQEY3AagyS51O+lVG4zaIuniqmVZG13dgoQRqEHxA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=lLTFZU36FYB0sKQyFImDYg0x8kfglP8EUdMvpX22mTojxO3tFK3caMU/oiUty2jgO
	 kIU+K9GQdAjC1Y42Lreqn7cTd3hDfmtZR8lvFMGrrfFtorC6cyjZwUbEswloGoinjf
	 gOtnnQQkH8KXBiPlrQAvLPybrYotWwgRVBSP3vNvDGnoBO4/em1NEwvEqk0jx7KJ1G
	 EPugLS+Qlley1Ylz/XLOnCCAnl+VpBo1ho38+kLM9R2hRX9xxd0135mYwqbJIk2TU9
	 cex59Yo2hDoQw+2TvTzDrqCfYHHaqIotJ/7PcqX7umepfUHMFyznUupg9QpcbTHNON
	 fsnF4qh0nMHyQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 Nov 2025 07:32:08 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Shengjiu Wang <shengjiu.wang@gmail.com>,
	Xiubo Li <Xiubo.Lee@gmail.com>,
	Fabio Estevam <festevam@gmail.com>,
	Nicolin Chen <nicoleotsuka@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-sound@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] ASoC: fsl_spdif: Constify some structures
Date: Mon,  3 Nov 2025 07:32:03 +0100
Message-ID: <5fe08f028395a6c6f50d11eee8fdb4a90b1f68ab.1762151503.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.1
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

'struct fsl_spdif_soc_data' and 'struct snd_kcontrol_new' are not modified
in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  53548	  25576	    128	  79252	  13594	sound/soc/fsl/fsl_spdif.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  54828	  24296	    128	  79252	  13594	sound/soc/fsl/fsl_spdif.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 sound/soc/fsl/fsl_spdif.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index ee946e0d3f49..1b9be85b34c2 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -148,7 +148,7 @@ struct fsl_spdif_priv {
 	struct clk *pll11k_clk;
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_vf610 = {
+static const struct fsl_spdif_soc_data fsl_spdif_vf610 = {
 	.imx = false,
 	.shared_root_clock = false,
 	.raw_capture_mode = false,
@@ -158,7 +158,7 @@ static struct fsl_spdif_soc_data fsl_spdif_vf610 = {
 	.tx_formats = FSL_SPDIF_FORMATS_PLAYBACK,
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_imx35 = {
+static const struct fsl_spdif_soc_data fsl_spdif_imx35 = {
 	.imx = true,
 	.shared_root_clock = false,
 	.raw_capture_mode = false,
@@ -168,7 +168,7 @@ static struct fsl_spdif_soc_data fsl_spdif_imx35 = {
 	.tx_formats = FSL_SPDIF_FORMATS_PLAYBACK,
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_imx6sx = {
+static const struct fsl_spdif_soc_data fsl_spdif_imx6sx = {
 	.imx = true,
 	.shared_root_clock = true,
 	.raw_capture_mode = false,
@@ -179,7 +179,7 @@ static struct fsl_spdif_soc_data fsl_spdif_imx6sx = {
 
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_imx8qm = {
+static const struct fsl_spdif_soc_data fsl_spdif_imx8qm = {
 	.imx = true,
 	.shared_root_clock = true,
 	.raw_capture_mode = false,
@@ -189,7 +189,7 @@ static struct fsl_spdif_soc_data fsl_spdif_imx8qm = {
 	.tx_formats = SNDRV_PCM_FMTBIT_S24_LE,  /* Applied for EDMA */
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_imx8mm = {
+static const struct fsl_spdif_soc_data fsl_spdif_imx8mm = {
 	.imx = true,
 	.shared_root_clock = false,
 	.raw_capture_mode = true,
@@ -199,7 +199,7 @@ static struct fsl_spdif_soc_data fsl_spdif_imx8mm = {
 	.tx_formats = FSL_SPDIF_FORMATS_PLAYBACK,
 };
 
-static struct fsl_spdif_soc_data fsl_spdif_imx8ulp = {
+static const struct fsl_spdif_soc_data fsl_spdif_imx8ulp = {
 	.imx = true,
 	.shared_root_clock = true,
 	.raw_capture_mode = false,
@@ -1146,7 +1146,7 @@ static int fsl_spdif_usync_put(struct snd_kcontrol *kcontrol,
 }
 
 /* FSL SPDIF IEC958 controller defines */
-static struct snd_kcontrol_new fsl_spdif_ctrls[] = {
+static const struct snd_kcontrol_new fsl_spdif_ctrls[] = {
 	/* Status cchanel controller */
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -1233,7 +1233,7 @@ static struct snd_kcontrol_new fsl_spdif_ctrls[] = {
 	},
 };
 
-static struct snd_kcontrol_new fsl_spdif_ctrls_rcm[] = {
+static const struct snd_kcontrol_new fsl_spdif_ctrls_rcm[] = {
 	{
 		.iface = SNDRV_CTL_ELEM_IFACE_PCM,
 		.name = "IEC958 Raw Capture Mode",
-- 
2.51.1


