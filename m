Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0245.hostedemail.com
 [216.40.44.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yd67F6cQ9zDqtM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Nov 2017 03:26:01 +1100 (AEDT)
From: Joe Perches <joe@perches.com>
To: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: fsl_asrc: constify some arrays
Date: Thu, 16 Nov 2017 08:25:47 -0800
Message-Id: <b8a2684d6615ab36fa28f67606e5560c8097c8ef.1510849466.git.joe@perches.com>
In-Reply-To: <cover.1510849466.git.joe@perches.com>
References: <cover.1510849466.git.joe@perches.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Using const reduces data.

$ size sound/soc/fsl/fsl_asrc.o*
   text	   data	    bss	    dec	    hex	filename
  21691	   5872	    192	  27755	   6c6b	sound/soc/fsl/fsl_asrc.o.new
  21435	   6128	    192	  27755	   6c6b	sound/soc/fsl/fsl_asrc.o.old

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/soc/fsl/fsl_asrc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index ed683fe8b94a..641724c9b3f8 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -49,12 +49,12 @@ static const u8 process_option[][12][2] = {
 };
 
 /* Corresponding to process_option */
-static int supported_input_rate[] = {
+static const int supported_input_rate[] = {
 	5512, 8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200,
 	96000, 176400, 192000,
 };
 
-static int supported_asrc_rate[] = {
+static const int supported_asrc_rate[] = {
 	8000, 11025, 16000, 22050, 32000, 44100, 48000, 64000, 88200, 96000, 176400, 192000,
 };
 
@@ -62,26 +62,26 @@ static int supported_asrc_rate[] = {
  * The following tables map the relationship between asrc_inclk/asrc_outclk in
  * fsl_asrc.h and the registers of ASRCSR
  */
-static unsigned char input_clk_map_imx35[] = {
+static const unsigned char input_clk_map_imx35[] = {
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf,
 };
 
-static unsigned char output_clk_map_imx35[] = {
+static const unsigned char output_clk_map_imx35[] = {
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 0xa, 0xb, 0xc, 0xd, 0xe, 0xf,
 };
 
 /* i.MX53 uses the same map for input and output */
-static unsigned char input_clk_map_imx53[] = {
+static const unsigned char input_clk_map_imx53[] = {
 /*	0x0  0x1  0x2  0x3  0x4  0x5  0x6  0x7  0x8  0x9  0xa  0xb  0xc  0xd  0xe  0xf */
 	0x0, 0x1, 0x2, 0x7, 0x4, 0x5, 0x6, 0x3, 0x8, 0x9, 0xa, 0xb, 0xc, 0xf, 0xe, 0xd,
 };
 
-static unsigned char output_clk_map_imx53[] = {
+static const unsigned char output_clk_map_imx53[] = {
 /*	0x0  0x1  0x2  0x3  0x4  0x5  0x6  0x7  0x8  0x9  0xa  0xb  0xc  0xd  0xe  0xf */
 	0x8, 0x9, 0xa, 0x7, 0xc, 0x5, 0x6, 0xb, 0x0, 0x1, 0x2, 0x3, 0x4, 0xf, 0xe, 0xd,
 };
 
-static unsigned char *clk_map[2];
+static const unsigned char *clk_map[2];
 
 /**
  * Request ASRC pair
-- 
2.15.0
