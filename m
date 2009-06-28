Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id BA172B7066
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Jun 2009 17:41:59 +1000 (EST)
Received: from mail-px0-f182.google.com (mail-px0-f182.google.com
	[209.85.216.182]) by ozlabs.org (Postfix) with ESMTP id 274A9DDD0C
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jun 2009 17:41:58 +1000 (EST)
Received: by pxi12 with SMTP id 12so2974207pxi.17
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jun 2009 00:41:56 -0700 (PDT)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 1/2] alsa/soc: Fix typo in MPC5200 PSC AC97 driver Kconfig
To: jonsmirl@gmail.com, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	broonie@sirena.org.uk, timur@freescale.com
Date: Sun, 28 Jun 2009 01:41:52 -0600
Message-ID: <20090628074109.26905.9927.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

ALSA SoC drivers should be specify SND_SOC_AC97_BUS instead, not AC97_BUS.
Without SND_SOC_AC97_BUS defined, an AC97 device will not get correctly
registered on the AC97 bus, which prevents thinks like the WM9712
touchscreen driver from getting probed.

Tested against 2.6.31-rc1.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 sound/soc/fsl/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)


diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 5dbebf8..5661876 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -33,7 +33,7 @@ config SND_SOC_MPC5200_I2S
 config SND_SOC_MPC5200_AC97
 	tristate "Freescale MPC5200 PSC in AC97 mode driver"
 	depends on PPC_MPC52xx && PPC_BESTCOMM
-	select AC97_BUS
+	select SND_SOC_AC97_BUS
 	select SND_MPC52xx_DMA
 	select PPC_BESTCOMM_GEN_BD
 	help
