Return-Path: <broonie@sirena.org.uk>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znFJ22VYWzF13W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 00:17:06 +1100 (AEDT)
From: Mark Brown <broonie@kernel.org>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Caleb Crome <caleb@crome.org>,
 Maciej S. Szmigiero <mail@maciej.szmigiero.name>,
 Mark Brown <broonie@kernel.org>, timur@tabi.org, broonie@kernel.org,
 mail@maciej.szmigiero.name, alsa-devel@alsa-project.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com,
 linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro" to the asoc
 tree
In-Reply-To: <1515990087-11598-6-git-send-email-nicoleotsuka@gmail.com>
Message-Id: <E1eoqk4-0006Pe-PP@debutante>
Date: Thu, 22 Feb 2018 13:16:56 +0000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch

   ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro

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

>From 06a994540505a9ce7028d9e801c52f967654b836 Mon Sep 17 00:00:00 2001
From: Nicolin Chen <nicoleotsuka@gmail.com>
Date: Mon, 12 Feb 2018 14:03:13 -0800
Subject: [PATCH] ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro

The define of fsl_ssi_disable_val is not so clear as it mixes two
steps of calculations together. And those parameter names are also
a bit long to read.

Since it just tries to exclude the shared bits from the regvals of
current stream while the opposite stream is active, it's better to
use something like ssi_excl_shared_bits.

This patch also bisects fsl_ssi_disable_val into two macros of two
corresponding steps and then shortens its parameter names. It also
updates callers in the fsl_ssi_config() accordingly.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
Tested-by: Caleb Crome <caleb@crome.org>
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Reviewed-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/fsl/fsl_ssi.c | 55 +++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b277a563ff48..0d8c800db0b3 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -421,24 +421,24 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 }
 
 /**
- * Calculate the bits that have to be disabled for the current stream that is
- * getting disabled. This keeps the bits enabled that are necessary for the
- * second stream to work if 'stream_active' is true.
+ * Exclude bits that are used by the opposite stream
  *
- * Detailed calculation:
- * These are the values that need to be active after disabling. For non-active
- * second stream, this is 0:
- *	vals_stream * !!stream_active
+ * When both streams are active, disabling some bits for the current stream
+ * might break the other stream if these bits are used by it.
  *
- * The following computes the overall differences between the setup for the
- * to-disable stream and the active stream, a simple XOR:
- *	vals_disable ^ (vals_stream * !!(stream_active))
+ * @vals : regvals of the current stream
+ * @avals: regvals of the opposite stream
+ * @aactive: active state of the opposite stream
  *
- * The full expression adds a mask on all values we care about
+ *  1) XOR vals and avals to get the differences if the other stream is active;
+ *     Otherwise, return current vals if the other stream is not active
+ *  2) AND the result of 1) with the current vals
  */
-#define fsl_ssi_disable_val(vals_disable, vals_stream, stream_active) \
-	((vals_disable) & \
-	 ((vals_disable) ^ ((vals_stream) * (u32)!!(stream_active))))
+#define _ssi_xor_shared_bits(vals, avals, aactive) \
+	((vals) ^ ((avals) * (aactive)))
+
+#define ssi_excl_shared_bits(vals, avals, aactive) \
+	((vals) & _ssi_xor_shared_bits(vals, avals, aactive))
 
 /**
  * Enable or disable SSI configuration.
@@ -446,19 +446,14 @@ static void fsl_ssi_fifo_clear(struct fsl_ssi *ssi, bool is_rx)
 static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 			   struct fsl_ssi_regvals *vals)
 {
+	int adir = (&ssi->regvals[TX] == vals) ? RX : TX;
 	int dir = (&ssi->regvals[TX] == vals) ? TX : RX;
 	struct regmap *regs = ssi->regs;
 	struct fsl_ssi_regvals *avals;
-	int nr_active_streams;
-	int keep_active;
-
-	nr_active_streams = !!(ssi->streams & BIT(TX)) +
-			    !!(ssi->streams & BIT(RX));
+	bool aactive;
 
-	if (nr_active_streams - 1 > 0)
-		keep_active = 1;
-	else
-		keep_active = 0;
+	/* Check if the opposite stream is active */
+	aactive = ssi->streams & BIT(adir);
 
 	/* Get the opposite direction to keep its values untouched */
 	if (&ssi->regvals[RX] == vals)
@@ -471,8 +466,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		 * To keep the other stream safe, exclude shared bits between
 		 * both streams, and get safe bits to disable current stream
 		 */
-		u32 scr = fsl_ssi_disable_val(vals->scr, avals->scr,
-					      keep_active);
+		u32 scr = ssi_excl_shared_bits(vals->scr, avals->scr, aactive);
 		/* Safely disable SCR register for the stream */
 		regmap_update_bits(regs, REG_SSI_SCR, scr, 0);
 
@@ -487,7 +481,7 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 	 * 2) Disable all remaining bits of both streams when last stream ends
 	 */
 	if (ssi->soc->offline_config) {
-		if ((enable && !nr_active_streams) || (!enable && !keep_active))
+		if ((enable && !ssi->streams) || (!enable && !aactive))
 			fsl_ssi_rxtx_config(ssi, enable);
 
 		goto config_done;
@@ -509,12 +503,9 @@ static void fsl_ssi_config(struct fsl_ssi *ssi, bool enable,
 		 * To keep the other stream safe, exclude shared bits between
 		 * both streams, and get safe bits to disable current stream
 		 */
-		sier = fsl_ssi_disable_val(vals->sier, avals->sier,
-					   keep_active);
-		srcr = fsl_ssi_disable_val(vals->srcr, avals->srcr,
-					   keep_active);
-		stcr = fsl_ssi_disable_val(vals->stcr, avals->stcr,
-					   keep_active);
+		sier = ssi_excl_shared_bits(vals->sier, avals->sier, aactive);
+		srcr = ssi_excl_shared_bits(vals->srcr, avals->srcr, aactive);
+		stcr = ssi_excl_shared_bits(vals->stcr, avals->stcr, aactive);
 
 		/* Safely disable other control registers for the stream */
 		regmap_update_bits(regs, REG_SSI_SRCR, srcr, 0);
-- 
2.16.1
