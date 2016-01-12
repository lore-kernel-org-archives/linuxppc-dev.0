Return-Path: <LW@KARO-electronics.de>
Received: from mail.karo-electronics.de (mail.karo-electronics.de
 [81.173.242.67]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E1D51A17E0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 05:13:53 +1100 (AEDT)
From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: Arnd Bergmann <arnd@arndb.de>, Fabio Estevam <fabio.estevam@freescale.com>,
 Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>,
 =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>,
 Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] ASoC: fsl: imx-sgtl5000: make audmux optional for imx
 sound driver
Date: Tue, 12 Jan 2016 19:13:30 +0100
Message-Id: <1452622411-16674-2-git-send-email-LW@KARO-electronics.de>
In-Reply-To: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
References: <1452622411-16674-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

i.MX6UL does not have the audio multiplexer (AUDMUX) like e.g. i.MX6Q,
but apart from that can use the same audio driver. Make audmux
optional for the imx-sgtl5000 driver, so it can be used on i.MX6UL
too. Also i.MX6UL requires use of the SAI interface rather than SSI.

Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
---
 sound/soc/fsl/imx-sgtl5000.c | 70 +++++++++++++++++++++++---------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index b99e0b5..7cefb40 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -65,40 +65,42 @@ static int imx_sgtl5000_probe(struct platform_device *pdev)
 	int int_port, ext_port;
 	int ret;
 
-	ret = of_property_read_u32(np, "mux-int-port", &int_port);
-	if (ret) {
-		dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
-		return ret;
-	}
-	ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
-	if (ret) {
-		dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
-		return ret;
-	}
-
-	/*
-	 * The port numbering in the hardware manual starts at 1, while
-	 * the audmux API expects it starts at 0.
-	 */
-	int_port--;
-	ext_port--;
-	ret = imx_audmux_v2_configure_port(int_port,
-			IMX_AUDMUX_V2_PTCR_SYN |
-			IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
-			IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
-			IMX_AUDMUX_V2_PTCR_TFSDIR |
-			IMX_AUDMUX_V2_PTCR_TCLKDIR,
-			IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
-	if (ret) {
-		dev_err(&pdev->dev, "audmux internal port setup failed\n");
-		return ret;
-	}
-	ret = imx_audmux_v2_configure_port(ext_port,
-			IMX_AUDMUX_V2_PTCR_SYN,
-			IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
-	if (ret) {
-		dev_err(&pdev->dev, "audmux external port setup failed\n");
-		return ret;
+	if (!of_property_read_bool(np, "fsl,no-audmux")) {
+		ret = of_property_read_u32(np, "mux-int-port", &int_port);
+		if (ret) {
+			dev_err(&pdev->dev, "mux-int-port missing or invalid\n");
+			return ret;
+		}
+		ret = of_property_read_u32(np, "mux-ext-port", &ext_port);
+		if (ret) {
+			dev_err(&pdev->dev, "mux-ext-port missing or invalid\n");
+			return ret;
+		}
+
+		/*
+		 * The port numbering in the hardware manual starts at 1, while
+		 * the audmux API expects it starts at 0.
+		 */
+		int_port--;
+		ext_port--;
+		ret = imx_audmux_v2_configure_port(int_port,
+				IMX_AUDMUX_V2_PTCR_SYN |
+				IMX_AUDMUX_V2_PTCR_TFSEL(ext_port) |
+				IMX_AUDMUX_V2_PTCR_TCSEL(ext_port) |
+				IMX_AUDMUX_V2_PTCR_TFSDIR |
+				IMX_AUDMUX_V2_PTCR_TCLKDIR,
+				IMX_AUDMUX_V2_PDCR_RXDSEL(ext_port));
+		if (ret) {
+			dev_err(&pdev->dev, "audmux internal port setup failed\n");
+			return ret;
+		}
+		ret = imx_audmux_v2_configure_port(ext_port,
+				IMX_AUDMUX_V2_PTCR_SYN,
+				IMX_AUDMUX_V2_PDCR_RXDSEL(int_port));
+		if (ret) {
+			dev_err(&pdev->dev, "audmux external port setup failed\n");
+			return ret;
+		}
 	}
 
 	ssi_np = of_parse_phandle(pdev->dev.of_node, "ssi-controller", 0);
-- 
2.1.4
