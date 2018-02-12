Return-Path: <nicoleotsuka@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgKRB2ntBzF0pS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 09:02:46 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id m19so3415475pgn.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Feb 2018 14:02:46 -0800 (PST)
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: broonie@kernel.org,
	timur@tabi.org
Cc: caleb@crome.org, mail@maciej.szmigiero.name, fabio.estevam@nxp.com,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 arnaud.mouiche@invoxia.com, lukma@denx.de, kernel@pengutronix.de
Subject: [PATCH v6 05/17] ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
Date: Mon, 12 Feb 2018 14:03:13 -0800
Message-Id: <1518473005-14090-6-git-send-email-nicoleotsuka@gmail.com>
In-Reply-To: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
References: <1518473005-14090-1-git-send-email-nicoleotsuka@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

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
---
 sound/soc/fsl/fsl_ssi.c | 55 +++++++++++++++++++++----------------------------
 1 file changed, 23 insertions(+), 32 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index b277a56..0d8c800 100644
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
2.1.4
