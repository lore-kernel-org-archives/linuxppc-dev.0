Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymyDY31bNzDr8h
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 21:57:48 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: only enable proper channel slots in AC'97
 mode" to the asoc tree
In-Reply-To: <5fafe9ba-ef40-66ef-80ca-b8333e10774e@maciej.szmigiero.name>
Message-Id: <E1eK03b-00060J-6Y@debutante>
Date: Wed, 29 Nov 2017 10:57:35 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: only enable proper channel slots in AC'97 mode

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 01ca485171e3253f3aee555437519c0d316d4b0c Mon Sep 17 00:00:00 2001
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Date: Wed, 22 Nov 2017 00:54:26 +0100
Subject: [PATCH] ASoC: fsl_ssi: only enable proper channel slots in AC'97 mode

We need to make sure that only proper channel slots (in SACCST register)
are enabled at playback start time since some AC'97 CODECs (like VT1613 on
UDOO board) were observed requesting via SLOTREQ spurious ones just after
an AC'97 link is started but before the CODEC is configured by its driver.
When a bit for some channel slot is set in a SLOTREQ request then SSI sets
the relevant bit in SACCST automatically, which then 'sticks' until it is
manually unset.
The SACCST register is not writable directly, we have to use SACCDIS and
SACCEN registers to configure it instead (these aren't normal registers:
writing a '1' bit at some position in SACCEN sets the relevant bit in
SACCST; SACCDIS operates in a similar way but allows unsetting bits in
SACCST).

Theoretically, this should be necessary only for the very first playback
but since some CODECs are so untrustworthy and extra channel slots enabled
mean ruined playback let's play safe here and make sure that no extra
slots are enabled in SACCST every time a playback is started.

Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 52 +++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 939d1b8894dc..20ef09e1a395 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -577,8 +577,54 @@ static void fsl_ssi_rx_config(struct fsl_ssi_private *ssi_private, bool enable)
 	fsl_ssi_config(ssi_private, enable, &ssi_private->rxtx_reg_val.rx);
 }
 
+static void fsl_ssi_tx_ac97_saccst_setup(struct fsl_ssi_private *ssi_private)
+{
+	struct regmap *regs = ssi_private->regs;
+
+	/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
+	if (!ssi_private->soc->imx21regs) {
+		/*
+		 * Note that these below aren't just normal registers.
+		 * They are a way to disable or enable bits in SACCST
+		 * register:
+		 * - writing a '1' bit at some position in SACCEN sets the
+		 * relevant bit in SACCST,
+		 * - writing a '1' bit at some position in SACCDIS unsets
+		 * the relevant bit in SACCST register.
+		 *
+		 * The two writes below first disable all channels slots,
+		 * then enable just slots 3 & 4 ("PCM Playback Left Channel"
+		 * and "PCM Playback Right Channel").
+		 */
+		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
+		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
+	}
+}
+
 static void fsl_ssi_tx_config(struct fsl_ssi_private *ssi_private, bool enable)
 {
+	/*
+	 * Why are we setting up SACCST everytime we are starting a
+	 * playback?
+	 * Some CODECs (like VT1613 CODEC on UDOO board) like to
+	 * (sometimes) set extra bits in their SLOTREQ requests.
+	 * When a bit is set in a SLOTREQ request then SSI sets the
+	 * relevant bit in SACCST automatically (it is enough if a bit was
+	 * set in a SLOTREQ just once, bits in SACCST are 'sticky').
+	 * If an extra slot gets enabled that's a disaster for playback
+	 * because some of normal left or right channel samples are
+	 * redirected instead to this extra slot.
+	 *
+	 * A workaround implemented in fsl-asoc-card of setting an
+	 * appropriate CODEC register so that slots 3 & 4 (the normal
+	 * stereo playback slots) are used for S/PDIF seems to mostly fix
+	 * this issue on the UDOO board but since this CODEC is so
+	 * untrustworthy let's play safe here and make sure that no extra
+	 * slots are enabled every time a playback is started.
+	 */
+	if (enable && fsl_ssi_is_ac97(ssi_private))
+		fsl_ssi_tx_ac97_saccst_setup(ssi_private);
+
 	fsl_ssi_config(ssi_private, enable, &ssi_private->rxtx_reg_val.tx);
 }
 
@@ -633,12 +679,6 @@ static void fsl_ssi_setup_ac97(struct fsl_ssi_private *ssi_private)
 	regmap_write(regs, CCSR_SSI_SACNT,
 			CCSR_SSI_SACNT_AC97EN | CCSR_SSI_SACNT_FV);
 
-	/* no SACC{ST,EN,DIS} regs on imx21-class SSI */
-	if (!ssi_private->soc->imx21regs) {
-		regmap_write(regs, CCSR_SSI_SACCDIS, 0xff);
-		regmap_write(regs, CCSR_SSI_SACCEN, 0x300);
-	}
-
 	/*
 	 * Enable SSI, Transmit and Receive. AC97 has to communicate with the
 	 * codec before a stream is started.
-- 
2.15.0
